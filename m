Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456DC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1822C886CE;
	Tue, 16 Jul 2024 04:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N7vx7LNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA99588755; Tue, 16 Jul 2024 04:40:33 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99CC885EE
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-093-080.um16.pools.vodafone-ip.de
 [62.143.93.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 41BCD3F1DD; 
 Tue, 16 Jul 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721097629;
 bh=x5yUo/kSFuxcLMQj88FeAmWvlykEYjbqDd7GRCPSxaQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=N7vx7LNKeZXelK5y2CT1Eab7Yo99XeVPf4ckfgSdAjE1YGmtNuIeWAf43GrMJ8ATX
 p83Ybkb7bI92NfScZQbTkPDBnjpnk+3p5RYvRx6lKaiIF3+hsfJE84evVQEPwZ2lkz
 2MkAVjY+rXkbfi46hW8oZrFUmukBHpaVBo2kCaTlLqjoWPZSkgA53Iot1lq1SALjed
 uqUUl3rQucwnmiawb5AOz2gGxpaOO9qfGUlVBuDfMZt7o7rqy6qY2+HugSH5bBnNXD
 DPXdZNuGtquj9pWxYYD2zt1ZPCuyAhuY/nlZ75r2pFYNysEP9ldldKBuACpnAIQzfA
 vH5R6qWhaKwiw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
Date: Tue, 16 Jul 2024 04:40:32 +0200
Message-ID: <20240716024032.22254-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
Here the QFW boot method is not needed.

At least for qemu-riscv64_smode_defconfig the kernel parameter is used
to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
no sense.

Provide Kconfig parameter CONFIG_BOOTMETH_QFW to decide if the QFW boot
method shall be provided.

Disable the QFW boot method for all architectures but the sandbox by
default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig  | 9 +++++++++
 boot/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 95300b008c5..d7e034c89e7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -568,6 +568,15 @@ config BOOTMETH_EFI_BOOTMGR
 	  the EFI binary to be launched is determined. To set the EFI variables
 	  use the eficonfig command.
 
+config BOOTMETH_QFW
+	bool "Boot method using QEMU parameters"
+	depends on QFW
+	default y if SANDBOX
+	help
+	 Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
+	 initial RAM disk, and kernel command line parameters to boot an
+	 operating system. U-Boot's control device-tree is passed to the kernel.
+
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
diff --git a/boot/Makefile b/boot/Makefile
index 84ccfeaecec..92e6adb887c 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
 
 obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
-obj-$(CONFIG_QFW) += bootmeth_qfw.o
 
 endif
 
@@ -31,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
-- 
2.45.2

