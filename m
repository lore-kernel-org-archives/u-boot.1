Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0911BC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58BB86963;
	Mon, 14 Aug 2023 19:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMWd10vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA878698E; Mon, 14 Aug 2023 19:40:06 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2BA86927
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe45481edfso46535135e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692034803; x=1692639603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd5BbdxJ+USR/I8hSid3mMIsXmqnl3rHSywPMUabapE=;
 b=dMWd10vREXBwm1nqrHtEja1bvPylcGqjFY5bLgEpoS3mQcXpgATRZFT624ribKShhr
 5J9kvFu4dA41yEu5bUjCSWC+0ml49JyhZWoBYW+s/PVd2P1rRuTcNEgxwuH9qUUX8vro
 EEXgO+2bu2q/PMKYjhecKa5ak+3iJNv+fvimFzIMRPdEvwiCfIrsu5dYXBmxgAMUg4WL
 rDxRIB8CzjnS31RYwTO+sd/0nPVIjLDC4x2H0rllzi3Njd/9cBDSVml6cZVLiPHINLwR
 y1IIV2kFCg/KC9JAUmpmlXs7b1yg5lzPoyP/wOKZ1H2aMzXTOcC3vhfOg/2eZOAh64c8
 HNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692034803; x=1692639603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hd5BbdxJ+USR/I8hSid3mMIsXmqnl3rHSywPMUabapE=;
 b=AkYewWDNDapWTC7Gmgf5ZjQk23G8DJduBZ2njoHzSecNxbgUu9x8hy4KlSup7iCtUP
 xL4+B5aS/jI3nBesjHfP2PEMD6yLMWtIbOM/jWUBaQH6SsY5ehKkP8Bnf9nQtQBy+fR1
 X00w5ZMsu4e9azMKsTZEHRnK9ettuhppUvU/AjuQvnn8g8thF9184abqJHmlAPgioLEG
 zSKPZCuyWaxrqzBO7lHmOLpuF6qvTURnPpmvZEB+xA6XWNFi56TAZEXT3KTpSGq1K4h6
 JZfzaJ4CKBs7+/e8EhvgVFR7OPfOvGJXmFgo/JwPX0sGJwsA1Rl9c3blTRkxi/dv8xls
 oQ6w==
X-Gm-Message-State: AOJu0YzgQVrEa7O5Ouk2/TCczMWyoYCyHH/wT3VjWLSMYJyN1uT8byrC
 ZnVdqOo58C8ZgnTHP1jWcIKGY3PBu/E=
X-Google-Smtp-Source: AGHT+IHPIXpzChZJIhmOfe+0g2Jjf6DZZseolBgOj+68iewrGJUdXyoHQ4gOdmBsqa+pb0MI5LbAbA==
X-Received: by 2002:a7b:c8d2:0:b0:3fe:ad4:27b4 with SMTP id
 f18-20020a7bc8d2000000b003fe0ad427b4mr8898020wml.27.1692034803622; 
 Mon, 14 Aug 2023 10:40:03 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm15002406wmi.16.2023.08.14.10.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:40:03 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 3/4] arm: qemu: Enable usb keyboard as an input device
Date: Mon, 14 Aug 2023 20:39:43 +0300
Message-Id: <20230814173944.288356-4-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814173944.288356-1-alpernebiyasak@gmail.com>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
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

Commit 02be57caf730 ("riscv: qemu: Enable usb keyboard as an input
device") adds PCI xHCI support to QEMU RISC-V virtual machines and
enables using a USB keyboard as one of the input devices. Similarly,
enable those for ARM virtual machines as well.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
---

Changes in v2:
- Add tag: "Reviewed-by: Simon Glass <sjg@chromium.org>"
- Add tag: "Reviewed-by: Bin Meng <bmeng@tinylab.org>"

 arch/arm/Kconfig                      | 5 +++++
 board/emulation/qemu-arm/qemu-arm.c   | 5 +++++
 board/emulation/qemu-arm/qemu-arm.env | 2 +-
 configs/qemu_arm64_defconfig          | 2 --
 configs/qemu_arm_defconfig            | 2 --
 doc/board/emulation/qemu-arm.rst      | 4 ++++
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89b978797720..1fd3ccd1607f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1041,6 +1041,11 @@ config ARCH_QEMU
 	imply SYS_WHITE_ON_BLACK
 	imply SYS_CONSOLE_IS_IN_ENV
 	imply PRE_CONSOLE_BUFFER
+	imply USB
+	imply USB_XHCI_HCD
+	imply USB_XHCI_PCI
+	imply USB_KEYBOARD
+	imply CMD_USB
 
 config ARCH_RMOBILE
 	bool "Renesas ARM SoCs"
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index dfea0d92a3c8..942f1fff5717 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -11,6 +11,7 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <log.h>
+#include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
 
@@ -114,6 +115,10 @@ int board_late_init(void)
 	 */
 	virtio_init();
 
+	/* start usb so that usb keyboard can be used as input device */
+	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
+		usb_init();
+
 	return 0;
 }
 
diff --git a/board/emulation/qemu-arm/qemu-arm.env b/board/emulation/qemu-arm/qemu-arm.env
index 86a99a2e8713..fb4adef281ed 100644
--- a/board/emulation/qemu-arm/qemu-arm.env
+++ b/board/emulation/qemu-arm/qemu-arm.env
@@ -2,7 +2,7 @@
 
 /* environment for qemu-arm and qemu-arm64 */
 
-stdin=serial
+stdin=serial,usbkbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
 fdt_high=0xffffffff
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 94bd96678443..f6b8ae530a4a 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_ENV_IS_IN_FLASH=y
@@ -68,7 +67,6 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TPM2_MMIO=y
-CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_TPM=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index 7cb1e9f037ff..1347b86f34b1 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -36,7 +36,6 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_ENV_IS_IN_FLASH=y
@@ -69,7 +68,6 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TPM2_MMIO=y
-CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_TPM=y
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1108fe5f8184..8ec5349fc9ea 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -84,6 +84,10 @@ can be enabled with the following command line parameters:
 
     -device usb-ehci,id=ehci
 
+- To add a USB keyboard attached to an emulated xHCI controller, pass e.g.::
+
+    -device qemu-xhci,id=xhci -device usb-kbd,bus=xhci.0
+
 - To add an NVMe disk, pass e.g.::
 
     -drive if=none,file=disk.img,id=mydisk -device nvme,drive=mydisk,serial=foo
-- 
2.40.1

