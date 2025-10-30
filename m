Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE7CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180F2839E2;
	Thu, 30 Oct 2025 17:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="f4r2UbyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE86839D7; Thu, 30 Oct 2025 17:45:50 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A35839DD
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 20BBC1A1782;
 Thu, 30 Oct 2025 16:45:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA6BA60331;
 Thu, 30 Oct 2025 16:45:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE14911808CA3; Thu, 30 Oct 2025 17:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761842747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FAp4XnlgGlM0i2xyGRIe3WsZLCXn1kHESvFofslsZUs=;
 b=f4r2UbyAGKzNFypI6UR83JcsXcriMemXvEe1z+ZiXz/oLlCVZYhntKD4ZcpGMNOVOF/obq
 1dZu0VG9V96yF3kS86L5luorzx+CCBxI9yF1yKObsCMeI0ty+nBwSS+aqiBtS8pnU4YJtx
 WTmlceILp7Pa9z6mgvYK9ZwzBdyfiFlx+YYHAKhJONxgFXfPrBy2zUl3s7HK+C/p5TMcY0
 RWaoY4oTDkBAW8GSUrISQu+5SZqBCk9jAsEH76414Nah8khEgiuOzhs/rjYdKU+drp9XGk
 JT5EJdK+w4kgCaELLiuDhYT1JVuOGx4NakVraatj+CFXAFmnJUL6a6TkrxcJug==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Thu, 30 Oct 2025 17:45:12 +0100
Subject: [PATCH v5 19/20] boot: bootmeth_efi: Refactor
 distro_efi_try_bootflow_files return logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-feature_sysboot_extension_board-v5-19-cfb77672fc68@bootlin.com>
References: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
In-Reply-To: <20251030-feature_sysboot_extension_board-v5-0-cfb77672fc68@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
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

Simplify the return path in distro_efi_try_bootflow_files() to prepare
for adding extension board support in a subsequent commit.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 boot/bootmeth_efi.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 0af23df3a4a..64de5c08b7b 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -148,25 +148,26 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 			return log_msg_ret("fil", -ENOMEM);
 	}
 
-	if (!ret) {
-		bflow->fdt_size = size;
-		bflow->fdt_addr = fdt_addr;
-
-		/*
-		 * TODO: Apply extension overlay
-		 *
-		 * Here we need to load and apply the extension overlay. This is
-		 * not implemented. See do_extension_apply(). The extension
-		 * stuff needs an implementation in boot/extension.c so it is
-		 * separate from the command code. Really the extension stuff
-		 * should use the device tree and a uclass / driver interface
-		 * rather than implementing its own list
-		 */
-	} else {
+	if (ret) {
 		log_debug("No device tree available\n");
 		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
+		return 0;
 	}
 
+	bflow->fdt_size = size;
+	bflow->fdt_addr = fdt_addr;
+
+	/*
+	 * TODO: Apply extension overlay
+	 *
+	 * Here we need to load and apply the extension overlay. This is
+	 * not implemented. See do_extension_apply(). The extension
+	 * stuff needs an implementation in boot/extension.c so it is
+	 * separate from the command code. Really the extension stuff
+	 * should use the device tree and a uclass / driver interface
+	 * rather than implementing its own list
+	 */
+
 	return 0;
 }
 

-- 
2.43.0

