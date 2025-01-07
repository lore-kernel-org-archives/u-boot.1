Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCDFE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 22:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606928036B;
	Tue,  7 Jan 2025 23:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736290595;
	bh=wT15LDh/BKG+W9EDz3QwxlkdoPZrF7KrsqASD5FKKKc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nYgClOcwxBZnXUmINOSNPg99u0uAupiQfDpY89y7uUwTB5yOx15X00HMj5rHdJXQ7
	 jxRAw++n4C0Zrf70XrDFsviD9+QMtDcI8tuUk4zX8M5mIVwpk3p7YECeuVke0LtkoI
	 0vDHTDdOuZfpVtMgBXtHYKGuM5kr6g9Z3vfF8/rWOpoTGc848nvUB5UkK3Q5zDR3hz
	 SEmh4rJ2niuNmw7aUhviWDPne8TPGjYlkhhSRpBWZ7GeGRiv0uJ3px2fAcMWyv5kj3
	 E1egBn/XmIUl6se2sXrokdr1/yCAq3xXTZW9J2OdBMkZHgQrHTJxIMIgE05V4oP5Sr
	 to64rKyoYHcQg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179DE805E9; Tue,  7 Jan 2025 23:56:34 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59E2801FD
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 23:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Zn9zOXWg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F84810485590; Tue,  7 Jan 2025 23:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736290590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wT15LDh/BKG+W9EDz3QwxlkdoPZrF7KrsqASD5FKKKc=;
 b=Zn9zOXWgLnXq8Wq69EPBkdpcmM91zPSt6+W4yUVCywMoJ/A4WYY9kSDDETttrcICtbU1vJ
 r2GearpFeZYUPMD6KFVUuIEBTzdoGCQ5ZCw3UjA4CwS+liPmsGWzSYLN6Bu9Vry8MaKOJh
 4oPMsFO4FVajV0sJvAN2gS/glGGpmIb+jUBammJAV9/w8ov0T+Y0webJbgfmj8ReceAfWg
 a98J/EstGW2T91NTOCbJspPByKu1tUB585oQ/C6XNRPXlg1oM+pD/Oze3X75ZHorm23tkQ
 ttWdSJ6dSfZFR2k7ppiJirZXc0P6xho6Ai8h52qUjCs2uGBg5bjPJldVZ+Tb3w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] usb: ehci-mx5: Use regulator_set_enable_if_allowed
Date: Tue,  7 Jan 2025 23:56:07 +0100
Message-ID: <20250107225616.195878-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

With the commit 4fcba5d556b4 ("regulator: implement basic reference
counter") the return value of regulator_set_enable may be EALREADY or
EBUSY for fixed/gpio regulators.

Change to use the more relaxed regulator_set_enable_if_allowed to
continue if regulator already was enabled or disabled.

Based on 335799b7252a ("usb: dwc2: Use regulator_set_enable_if_allowed")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/host/ehci-mx5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index d8f521befe1..1392d29bc13 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -287,9 +287,9 @@ static int ehci_usb_probe(struct udevice *dev)
 		debug("%s: No vbus supply\n", dev->name);
 
 	if (!ret && priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply,
-					   (type == USB_INIT_DEVICE) ?
-					   false : true);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+						      (type == USB_INIT_DEVICE) ?
+						      false : true);
 		if (ret) {
 			puts("Error enabling VBUS supply\n");
 			return ret;
-- 
2.45.2

