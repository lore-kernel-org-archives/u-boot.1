Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE076CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F09484843;
	Sun, 10 May 2026 19:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M9+sQ8i5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HSq9CO8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A562684843; Sun, 10 May 2026 19:17:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B00846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gD8gc4gp6z9tKq;
 Sun, 10 May 2026 19:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRX/upL7GN9fheA1bfRgdeXNQXL31Olcccp32V6LrQ=;
 b=M9+sQ8i50gjMB5Si3reRjWRP362JxReRNFdt5yNyrjQUGGyUsBTxSvVOnuo7RaPLfF3TJD
 pJUatLhhLrZo3NztWM1rlExntWl9y2koZrrZDe1v03k38WpzO/QD2cDuehp5dE92EQSDwo
 RWfd6Nyv6tvYyl3/LX4+LoJzbvE1eFnNAGb/sBLEFU2518ACj6kKLE2yRfrK3CBWa5DD42
 ybt9LkU1REBm1Vlssl2Yy++uF190zs99vQYDkSid1yJM1iTJo4pkVQdq9YA3KeB2JcEmAV
 UcDEhkY2qHoazR9g1AFIH0pxRY87yicGlmvvaCeyYKzVlKEqVrm/SpMzd8Pa7g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRX/upL7GN9fheA1bfRgdeXNQXL31Olcccp32V6LrQ=;
 b=HSq9CO8+982JJCmvbcelFVteIN13tm5lipmClVQYtEMO6Qa6wjmBXvhPrXaAQ/OFu/JPRY
 a0XFEZjbKxKqbZnNjTQWhVUgy0rDwlMzUTW/O6B95L1BEJixDkDmxzxKYApSZi2NewZ5KF
 EQaj6ey652Jfee00j7MzyKJcEl2/n5DMmTRPFM8fmbq3xGUDbqF3Rx4ZVrevdrggXctQ9N
 b5lDV4Je3ejh8wk2bSwIJXY6vPhtYdi7QX+BblsbzyFcxslicnn4w2mQK8SISyp28n9UU/
 Zx3Syyq+049fSW96ewbnO4KBxdsXRNAnirtiTczs5uiL//sUDvMBTm1Aw3nLtg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] video: tda19988: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:05 +0200
Message-ID: <20260510171723.56866-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5718a03dd378c4ca9b5
X-MBO-RS-META: i38jf6q4h39pmobmf5tho1brkp986aon
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/tda19988.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tda19988.c b/drivers/video/tda19988.c
index ebc8521c6ed..a4cc3a49232 100644
--- a/drivers/video/tda19988.c
+++ b/drivers/video/tda19988.c
@@ -522,7 +522,7 @@ static int tda19988_enable(struct udevice *dev, int panel_bpp,
 	return 0;
 }
 
-struct dm_display_ops tda19988_ops = {
+static const struct dm_display_ops tda19988_ops = {
 	.read_edid = tda19988_read_edid,
 	.enable = tda19988_enable,
 };
-- 
2.53.0

