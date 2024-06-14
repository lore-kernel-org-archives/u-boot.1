Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D8C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9018897F;
	Fri, 14 Jun 2024 02:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xsmL2VXG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FTcBavIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A86588958; Fri, 14 Jun 2024 02:53:50 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD7488987
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W0gkz6mP0z9sr8;
 Fri, 14 Jun 2024 02:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhhfFunN2B76L83ePiVgtQmYOx9GbllbwaFZKa9x8BM=;
 b=xsmL2VXGMV76YViYrVPKpUhkAPh6pJogNYoQ1SxeWxbhDBWpxN0+BjBWOK/yiYlUuLy5yU
 +bFftdZGJuoSCXPIuu5Vmv9tOf9+7AYCH6VmzV7Bii/FvFDfJmzbYWVTQWuKGTj0p3z2Nx
 mOxlaoP+WKNVjzMNtuceYT/6/csEqTs1gwBqJsopXxP0FOEdX1UhAM+yUfSbolnu2USeYi
 QnuK+sq4+dSW7qkhLpo0mbI8vmhhMbzxGB4avG+vD1ElObqbKw9wS6A4bl1XREOu1mbeeX
 jw38AL/VpnrmriuL9Rm5K2yXTK6oC/VG8Kh6yKbuXb2FfugQ6/DnvfjEgz1xqg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhhfFunN2B76L83ePiVgtQmYOx9GbllbwaFZKa9x8BM=;
 b=FTcBavIfuTDUrUNsRCw7wo6Y5LZHKXG29wEzjED3CMbgNQUQ8xEiap2OFpyeGayCXb/aBW
 5E3hYrp6BmXnpOO+wsWfCc/lcPeUw9fT26HREKfNdJ98ptN6smh0X5/OCgeWMrxKS7U9r2
 NwJxtYJEcnkqo/C/NrfE3RGopUXIJ5QYYIsWPuDcoqjX0EjgFch6KnsKkl7JsadRaGz+dn
 BS+r3Ysp8icGQ72Ii8DCw//n/brzrVq6s7u1wifBPWJt77/kZNmPaGASoiPmb695g4crwZ
 87NV8ydujVrP70ZGyct7u0bhPw0PruDBLBH+Z/jKXn2pPyL0dDBfGlUL5UvVQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] usb: gadget: ux500: Convert interrupt handling to
 usb_gadget_generic_ops
Date: Fri, 14 Jun 2024 02:51:24 +0200
Message-ID: <20240614005309.34433-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 18hdxchyss5ad3nk68cwae1rn5zkbdrq
X-MBO-RS-ID: e597c0793b7899e255f
X-Rspamd-Queue-Id: 4W0gkz6mP0z9sr8
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

Implement .handle_interrupts callback as a replacement for deprecated
dm_usb_gadget_handle_interrupts() function. The new callback allows
for each DM capable USB gadget controller driver to define its own
IRQ handling implementation without colliding with other controller
drivers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/musb-new/ux500.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index 6b4ef3c8578..89dd75b7d05 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -91,14 +91,6 @@ static const struct musb_platform_ops ux500_musb_ops = {
 	.disable	= ux500_musb_disable,
 };
 
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	struct ux500_glue *glue = dev_get_priv(dev);
-
-	glue->mdata.host->isr(0, glue->mdata.host);
-	return 0;
-}
-
 static int ux500_musb_probe(struct udevice *dev)
 {
 #ifdef CONFIG_USB_MUSB_HOST
@@ -155,6 +147,19 @@ static int ux500_musb_remove(struct udevice *dev)
 	return 0;
 }
 
+static int ux500_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct ux500_glue *glue = dev_get_priv(dev);
+
+	glue->mdata.host->isr(0, glue->mdata.host);
+
+	return 0;
+}
+
+static const struct usb_gadget_generic_ops ux500_gadget_ops = {
+	.handle_interrupts	= ux500_gadget_handle_interrupts,
+};
+
 static const struct udevice_id ux500_musb_ids[] = {
 	{ .compatible = "stericsson,db8500-musb" },
 	{ }
@@ -168,6 +173,7 @@ U_BOOT_DRIVER(ux500_musb) = {
 	.id		= UCLASS_USB_GADGET_GENERIC,
 #endif
 	.of_match	= ux500_musb_ids,
+	.ops		= &ux500_gadget_ops,
 	.probe		= ux500_musb_probe,
 	.remove		= ux500_musb_remove,
 #ifdef CONFIG_USB_MUSB_HOST
-- 
2.43.0

