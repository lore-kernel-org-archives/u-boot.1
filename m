Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC25ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8F488FEB;
	Tue, 10 Sep 2024 12:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ERFzwh+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99F588FFC; Tue, 10 Sep 2024 12:13:49 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD83888FF5
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12446240006;
 Tue, 10 Sep 2024 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbSsq+oYjWduI1kVBW6FKZHrLeCN3gr9EAnyFpGpqhI=;
 b=ERFzwh+TYGT6Yo++r8ao4foFk5TnJ5vJcozTRcvUoik3roLGqJbP1qFpsCUNX7Surhmqc/
 lIZbIK9EnlimQmcYqMXu51J1VZ1dja0l/Rf7XYwY1LAWkPT5BbgqAcONCz0eqGy6xtPAWf
 9owKU7eUnLKBGJMbWcVa5keNRXOtpwyy3stYYJEjY4jSVWf2CXEt3XHXhRHNPj4tBok/iZ
 f6Qy0PGorjVI4z7AEey6UgLCslxZ518CpthK2/xwzQVl9+HzigPuoDxldTin/hh9vlnFDK
 CQJyIuCe+ilCV9TJRZy9d27X31sHFP50SOwvgl5KKq1SScO125k122k7UWmPMA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/8] clk: Ensure the parent clocks are enabled while
 reparenting
Date: Tue, 10 Sep 2024 12:13:38 +0200
Message-ID: <20240910101344.110633-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Reparenting a clock C with a new parent P means that C will only
continue clocking if P is already clocking when the mux is updated. In
case the parent is currently disabled, failures (stalls) are likely to
happen.

This is exactly what happens on i.MX8 when enabling the video
pipeline. We tell LCDIF clocks to use the VIDEO PLL as input, while the
VIDEO PLL is currently off. This all happens as part of the
assigned-clocks handling procedure, where the reparenting happens before
the enable() calls. Enabling the parents as part of the reparenting
procedure seems sane and also matches the logic applied in other parts
of the CCM.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index ed6e60bc484..24f801e16f1 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -595,6 +595,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
+	ret = clk_enable(parent);
+	if (ret)
+		return ret;
+
 	ret = ops->set_parent(clk, parent);
 	if (ret)
 		return ret;
-- 
2.43.0

