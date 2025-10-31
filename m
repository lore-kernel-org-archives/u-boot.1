Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE0CCF9FF
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 08:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4764183642;
	Fri, 31 Oct 2025 09:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ZNQHMtgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B17836F0; Fri, 31 Oct 2025 09:39:14 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A91D800B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 09:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C2B2A1F8DE;
 Fri, 31 Oct 2025 09:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1761899952;
 bh=zYIpB5BXGvCv9zv4NunDnikGMQ4qb90bDLK8fe1PiIA=; h=From:To:Subject;
 b=ZNQHMtgQeSuC0snsxhMJhO6LG5HnsLjKYMhrz54JY/JTwAleyg2brt72ANfWRZ9he
 V/cVFc2kLqdlj4PKK+EBpREE3zB0NNoQOBu+c/e/+rip0W/dQm4atfiaiXW0hiFgbc
 AXCTI8KTphhc2QGPc5TR7ZMcDSK3iPQqk8Y8hH1wUGBGUsNeLag/IrjXUkn1viW1u8
 qNpy05JAxKyVe6UI+iEUc9/xg9myRsotQ44ppcDGoKJczFBkNqIyh+N/lN5JikZM64
 kj4B5wBY/aWS2yV7kopIfY0oAA75gPphKpYDR3344GeJMeQ2VUQ/K7XweVbhZcZ3O9
 tFkLZtKj8gRXA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] configs: toradex-smarc-imx95: enable USB Gadget OS
 Descriptors for fastboot
Date: Fri, 31 Oct 2025 09:39:04 +0100
Message-Id: <20251031083904.34273-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 configs/toradex-smarc-imx95_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 6f7b406e8175..c5cea6e4e5f5 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -164,6 +164,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
-- 
2.39.5

