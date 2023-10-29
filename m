Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F4C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA6338711D;
	Sun, 29 Oct 2023 08:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="q6ey1cT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DF687481; Sun, 29 Oct 2023 08:25:06 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5578F8711D
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 024E34265F;
 Sun, 29 Oct 2023 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698564303; bh=UYUL/wMA6Ti0u7fhPRwjFJPX4/q5JU6SDIoDqlMdU5s=;
 h=From:Date:Subject:To:Cc;
 b=q6ey1cT5QTGsgm7dllX6MnmULi0FHGHGVcLsZVeyZASg8b2LPpZIMDKMng9byVY8b
 GQ19lYeYHYmDWzcIrSs0rxtMlezAygm3Kj/vEsTyXRHbEI8yPYnSEB18g3TMcv2j/D
 KQNRjkERKAdtzB+58lNTvPNIuoRd3Qf6bn0Yj+IoME/SUpWQRL6OtA1wYKRa3S2XcI
 Eqz+mCSHKRelLAhpRoN8bysEfRfEqqPR13KWAZGT/DotEeiazjfw1pOB29MHoqFQ2c
 DrqEQQ9OTcZdXROmsfB7YZaEeRCL0oYnaly0edC+Njv0pQ5sq9wArQx2bT/aH60N8S
 bCZDkdehghYyw==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 16:24:55 +0900
Subject: [PATCH] usb: Ignore endpoints in non-zero altsettings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-4-v1-1-fe973dde7e59@marcan.st>
X-B4-Tracking: v=1; b=H4sIAMYIPmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNL3dLiJN20zIrUYl0T3aREM0tjw8TkNCNDcyWgjoKiVLAUUEN0bG0
 tAAeIFaVdAAAA
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=marcan@marcan.st;
 h=from:subject:message-id; bh=UYUL/wMA6Ti0u7fhPRwjFJPX4/q5JU6SDIoDqlMdU5s=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ7jrMTmWuDJ6Yz1hxKmjZvj3maYUT0BNYrlvW+Emuv3
 uE+OPFcRykLgxgHg6yYIkvjid5T3Z7Tz6mrpkyHmcPKBDKEgYtTACYyg4WR4WPKn9d+71POSJoY
 bDT5Gas1sWcyd+D7jfxbg8MSNzzrsmf4X5175MbKsmrn4ivM22fUxQtdCPyxQV9ut1/sDV+mAPc
 ERgA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

We currently do not really handle altsettings properly, and no driver
uses them. Ignore the respective endpoint descriptors for secondary
altsettings, to avoid creating duplicate endpoint records in the
interface.

This will have to be revisited if/when we have a driver that needs
altsettings to work properly.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 common/usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/usb.c b/common/usb.c
index aad13fd9c557..90f72fda00bc 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -463,6 +463,15 @@ static int usb_parse_config(struct usb_device *dev,
 				puts("Endpoint descriptor out of order!\n");
 				break;
 			}
+			if (if_desc->num_altsetting > 1) {
+				/*
+				 * Ignore altsettings, which can trigger duplicate
+				 * endpoint errors below. Revisit this when some
+				 * driver actually needs altsettings with differing
+				 * endpoint setups.
+				 */
+				break;
+			}
 			epno = dev->config.if_desc[ifno].no_of_ep;
 			if_desc = &dev->config.if_desc[ifno];
 			if (epno >= USB_MAXENDPOINTS) {

---
base-commit: 8ad1c9c26f7740806a162818b790d4a72f515b7e
change-id: 20231029-usb-fixes-4-ba6931acf217

Best regards,
-- 
Hector Martin <marcan@marcan.st>

