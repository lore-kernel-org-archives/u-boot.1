Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF34C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CCC340859;
	Thu, 20 Aug 2026 18:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2A8ZqbyBkub; Thu, 20 Aug 2026 18:09:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787249355;
	bh=fE8tzH2nKOpfdYZ5M+LKR/29xfzSBUUixUdWZXg85A8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peCmFRg6h4imk1O5DrzgZM6WxMUBfS8uN/DUmKCEngQQRvEreUx/DAZ2dO2nyVzTM
	 S4J5aHx3/3fIqXX8OtE/HThhbY4/YRZ0EtmZ4kTGoh5hbqd7oBvs6gAfqAb9pGHcK0
	 KQe+EAP1ZMwz+3/o06NZv7hIaJbU39JwlURznb6sRGx9NWxmnEZgB9hW++uDr7AWsQ
	 fdNqLhvRJnI/t7zLTjBa7FgunpjnavwLQ3jG63oeony5ZqsNoNB37grdUYyO9pTKCr
	 gpP/kcmFJwA9UmgSQmYoenQtBilu1ERxO7VIozXqs8NLfMKZCoCCMeB9DA5fw1IXTc
	 MpA34D9MfR4tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66D2A4083B;
	Thu, 20 Aug 2026 18:09:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92DF039E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E68A80F40
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J4Bcv-oAaLVl for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:09:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QsjunOkd
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4142D80EE6
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:04 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so140678f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787249343; x=1787854143;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fE8tzH2nKOpfdYZ5M+LKR/29xfzSBUUixUdWZXg85A8=;
 b=QsjunOkdN32KFbY/nKGAniKtP1gGZMfF6bo2WFZO4Jk9HHhCI2WSxVuC2nbk+OSvtd
 lmSEqJjTBALI+dZoFaUL0g0a+oNOdp25T34b1aGl7RT2/lzRpPHR4o0K9aU836abu06U
 sX4xDsOmm7v6aTVYMgcl7J//L2sm1obAsZXVBU4g899hG0taNCGhQMjvf/e6jGhlZUrm
 VN31JIOJ8c4nv3Ilk6h2RlGcKRpLNq4Y9G3rJuAwBP3gBpOuZMmXy1te1cGErKpAfcmG
 inTcoESNsGLVQv4B6kr+bRh0aA3JYjvofVd3Ugg1tHTY7FUyX2lkbPgAkdHZVRogjR+z
 A+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249343; x=1787854143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fE8tzH2nKOpfdYZ5M+LKR/29xfzSBUUixUdWZXg85A8=;
 b=TVzAgE9hbnWzYKoQ20GBTtmwoZ2nAjDtVHl6bKIp2DtNUr9PruoEMhms6SPckuzkWY
 zs7e9I/iQWnn+cd4rSrPsRjwxa21vC9HYLgqfq9joiV+DFEA2oG1ebpp3MLFMjwhErKU
 zAOh5XSJYB3Xwfaji3IwoOK0pMwHi9pzl8nZFvFv2fA2GKpuLUOLU6k9n+x7JsARVaFb
 +eil9AZymk5SzVHURIAcK5jOlLpPGUs1b3/QlofqAiBgAL4dwNWfEKbYNiSKoHQBSMuO
 lAonZuTxLTRHMPXg0tHG4lDVIUw3iLb8Nxuclw0a95Gc6IBbNo4XjEcj+xEfFIU9VZG5
 61Yw==
X-Gm-Message-State: AFuF++lPc5ml4CnxaY1OWkGRZWyTOBwzIo1zgXDg4Kx4svV5NrApNO1O
 qX4PserMP0OgS4Iq86PprhEkC0nz/9pnncRXMG753ZMjmi9bHLMMo39kWgtrm7U8y8Q=
X-Gm-Gg: AR+sD11rTnlkW1BAVnQhqTSrn54gciqsQCPphLUq7EJ++Llr2IlfOpHMuIpqSBrz6pE
 tGr/gY1laXsPnwzqfVe9QJotjq3zn/i5r84zx6Q7ISE8eCgyGUwO9tH0h64TqKj81ZLQb+SlG7H
 4NM6sMeWS9eN4Tpdd6AMgTNzv1ivL9PEV05vFwzCBCAE0/zqxStrkWZ2LWp8kYAyLX3WYiZJBr6
 ZgDgruYlNnio5ZJ2VguRo1Si3SnBEm1kFKCthwSdflp/msW29CKBY/V7RR9/L/WnFD2YXLxKH6Q
 Tm0BO/yGkz+k5zv6rlO5KbIxpIQUFMXV2tR05ahvguP0HjxcO6aCPBTB/N9nXc4I841XhD70uV1
 wn5sD+Si3t9oSjEqnYxgoPWuXno0AaPeLmkc49VFpq6cjyGEOg5pjMy7rPfp6KzPWnuHmZZcESj
 iTmv7GTzertxFDfB+tyc1xxEDrH/wgSEok8QtSJZdLzNWjiJROVgty8+wPj7OuMR6nSHb8QeP9t
 t0n+XkJmW2OBFVrM5fD0gY8S2MLbKlBa1qSKGiV4M+gXmMFdnn/UUmaWHD2i+j4F078GFvpzYID
 0PXoo48Nz8j4+ToT
X-Received: by 2002:a5d:6f13:0:b0:47f:e9fd:80d8 with SMTP id
 ffacd0b85a97d-482c0bb40bemr1025995f8f.21.1787249342657; 
 Thu, 20 Aug 2026 11:09:02 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13443810f8f.27.2026.08.20.11.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:09:02 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 20 Aug 2026 20:08:29 +0200
Subject: [PATCH v4 5/5] fastboot: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-ccaione-upstream-spl-fastboot-v4-5-57e5ef71c74d@baylibre.com>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some recovery and initial-provisioning flows run before usable firmware
is available in persistent storage. In these flows the SoC ROM loads a
small first stage, but that stage must still provide a standard protocol
with which the host can provision the device.

U-Boot already provides fastboot for this purpose, but its
implementation is currently restricted to U-Boot proper and coupled
to command-line support. This forces platforms that need provisioning
from SPL to maintain a separate downloader or an out-of-tree fastboot
implementation.

Allow boards to run USB fastboot as a service directly from SPL. Include
MMC partition flashing and Android sparse-image handling so that the SPL
service can provision the same storage images accepted by fastboot in
U-Boot proper.

Keep the SPL interface deliberately narrower. The fastboot boot command
is not supported because SPL is being used for provisioning rather than
OS boot orchestration. Filesystem probing is also omitted, so partition
types are reported as raw. Reboot support remains optional since reset
and persistent reboot-reason handling are platform-specific.

SPL size remains an important constraint. Make the support entirely
opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
fastboot code or supporting library is added to SPL and its binary size
is unchanged.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/android/fastboot.rst        | 31 ++++++++++++++
 drivers/fastboot/Kconfig        | 92 ++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_command.c   | 66 ++++++++++++++++++++++++++---
 drivers/fastboot/fb_common.c    | 19 +++++++++
 drivers/fastboot/fb_getvar.c    |  5 +++
 drivers/fastboot/fb_usb.c       |  3 ++
 drivers/usb/gadget/Makefile     |  2 +-
 drivers/usb/gadget/f_fastboot.c |  4 ++
 8 files changed, 213 insertions(+), 9 deletions(-)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 96c544ae11b..35dcaa8d5c3 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -72,6 +72,37 @@ platform. The location of the buffer and size are set with
 may be overridden on the fastboot command line using ``-l`` and
 ``-s``.
 
+Fastboot in SPL
+^^^^^^^^^^^^^^^
+
+Fastboot can be used from SPL without enabling the command line. Enable
+``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
+then start the session from board code::
+
+   ret = fastboot_usb_run(controller_index, NULL, 0);
+
+A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
+``CONFIG_FASTBOOT_BUF_SIZE``. Passing explicit values overrides these
+defaults. Unlike the command-line invocation, an SPL session cannot be aborted
+from the local console.
+
+SPL supports ``getvar``, ``download``, ``continue`` and the ``set_active``
+stub. The ``continue`` command ends the session and returns control to the
+caller. The ``flash`` and ``erase`` commands are available when their SPL
+backend is enabled.
+
+MMC flash and erase support is enabled with
+``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
+storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
+for GPT.
+
+Reboot commands require ``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform
+``reset_cpu()`` implementation. The ``reboot-bootloader``, ``reboot-fastboot``
+and ``reboot-recovery`` commands also require a platform
+``fastboot_set_reboot_flag()`` implementation.
+
+The ``boot``, ``ucmd``, ``acmd`` and OEM commands are not available in SPL.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..24e92968851 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
-	depends on CMDLINE
+
+if CMDLINE
 
 config FASTBOOT
 	bool
@@ -47,7 +48,30 @@ config TCP_FUNCTION_FASTBOOT
 	help
 	  This enables the fastboot protocol over TCP.
 
-if FASTBOOT
+endif # CMDLINE
+
+config SPL_FASTBOOT
+	bool "Support fastboot in SPL"
+	depends on USB_GADGET && SPL_USB_GADGET
+	depends on SPL_ENV_SUPPORT
+	depends on !SPL_USE_TINY_PRINTF
+	select SPL_LIBCOMMON_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select SPL_PRINTF
+	help
+	  Enable the USB fastboot protocol in SPL. The board is responsible
+	  for starting the fastboot session.
+
+config SPL_USB_FUNCTION_FASTBOOT
+	def_bool y if SPL_FASTBOOT
+
+config SPL_FASTBOOT_REBOOT
+	bool "Enable fastboot reboot commands in SPL"
+	depends on SPL_FASTBOOT
+	help
+	  Enable the fastboot reboot commands in SPL.
+
+if FASTBOOT || SPL_FASTBOOT
 
 config FASTBOOT_BUF_ADDR
 	hex "Define FASTBOOT buffer address"
@@ -79,6 +103,10 @@ config FASTBOOT_BUF_SIZE
 	  downloads. This buffer should be as large as possible for a
 	  platform. Define this to the size available RAM for fastboot.
 
+endif # FASTBOOT || SPL_FASTBOOT
+
+if FASTBOOT
+
 config FASTBOOT_USB_DEV
 	int "USB controller number"
 	depends on USB_FUNCTION_FASTBOOT
@@ -294,4 +322,64 @@ config FASTBOOT_OEM_BOARD
 
 endif # FASTBOOT
 
+config SPL_FASTBOOT_FLASH
+	bool
+	default y if SPL_FASTBOOT_FLASH_MMC
+	select SPL_IMAGE_SPARSE
+
+config SPL_FASTBOOT_FLASH_MMC
+	bool "Enable fastboot MMC flashing in SPL"
+	depends on SPL_FASTBOOT && SPL_MMC && SPL_DM_MMC && SPL_PARTITIONS
+	select SPL_MMC_WRITE
+	help
+	  Build the fastboot MMC flashing backend into SPL. This allows the
+	  fastboot flash and erase commands to operate on MMC partitions. A
+	  suitable SPL partition-table parser must also be enabled.
+
+config SPL_FASTBOOT_FLASH_MMC_DEV
+	int "Define fastboot MMC flash device in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	default 0
+	help
+	  Define the MMC device that the SPL fastboot flash backend uses.
+
+config SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	bool "Enable eMMC boot-partition flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SUPPORT_EMMC_BOOT
+	help
+	  Enable the special fastboot targets used to flash or erase the eMMC
+	  boot hardware partitions from SPL.
+
+config SPL_FASTBOOT_MMC_BOOT1_NAME
+	string "Target name for updating eMMC boot partition 1 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot0"
+
+config SPL_FASTBOOT_MMC_BOOT2_NAME
+	string "Target name for updating eMMC boot partition 2 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot1"
+
+config SPL_FASTBOOT_MMC_USER_SUPPORT
+	bool "Enable eMMC user-area flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	help
+	  Enable a special fastboot target for flashing or erasing the complete
+	  eMMC user area from SPL.
+
+config SPL_FASTBOOT_MMC_USER_NAME
+	string "Target name for updating the eMMC user area in SPL"
+	depends on SPL_FASTBOOT_MMC_USER_SUPPORT
+	default "mmc0"
+
+config SPL_FASTBOOT_GPT_NAME
+	string "Target name for updating GPT from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_EFI_PARTITION
+	default "gpt"
+
+config SPL_FASTBOOT_MBR_NAME
+	string "Target name for updating MBR from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_DOS_PARTITION
+	default "mbr"
+
 endmenu
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 111516fd1b3..a4f1c74aa7f 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -48,10 +48,59 @@ static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
-static const struct {
+struct fastboot_command {
 	const char *command;
 	void (*dispatch)(char *cmd_parameter, char *response);
-} commands[FASTBOOT_COMMAND_COUNT] = {
+};
+
+#ifdef CONFIG_XPL_BUILD
+static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
+	[FASTBOOT_COMMAND_GETVAR] = {
+		.command = "getvar",
+		.dispatch = getvar
+	},
+	[FASTBOOT_COMMAND_DOWNLOAD] = {
+		.command = "download",
+		.dispatch = download
+	},
+	[FASTBOOT_COMMAND_FLASH] =  {
+		.command = "flash",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
+	},
+	[FASTBOOT_COMMAND_ERASE] =  {
+		.command = "erase",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
+	},
+	[FASTBOOT_COMMAND_CONTINUE] =  {
+		.command = "continue",
+		.dispatch = okay
+	},
+	[FASTBOOT_COMMAND_REBOOT] =  {
+		.command = "reboot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
+		.command = "reboot-bootloader",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_bootloader), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
+		.command = "reboot-fastboot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_fastbootd), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
+		.command = "reboot-recovery",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_recovery), (NULL))
+	},
+	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
+		.command = "set_active",
+		.dispatch = okay
+	},
+};
+#else
+static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 	[FASTBOOT_COMMAND_GETVAR] = {
 		.command = "getvar",
 		.dispatch = getvar
@@ -129,6 +178,7 @@ static const struct {
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
 };
+#endif
 
 /**
  * fastboot_handle_command - Handle fastboot command
@@ -147,7 +197,8 @@ int fastboot_handle_command(char *cmd_string, char *response)
 	strsep(&cmd_parameter, ":");
 
 	for (i = 0; i < FASTBOOT_COMMAND_COUNT; i++) {
-		if (!strcmp(commands[i].command, cmd_string)) {
+		if (commands[i].command &&
+		    !strcmp(commands[i].command, cmd_string)) {
 			if (commands[i].dispatch) {
 				commands[i].dispatch(cmd_parameter,
 							response);
@@ -437,7 +488,8 @@ static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_bootloader(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_bootloader(char *cmd_parameter,
+					     char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_BOOTLOADER))
 		fastboot_fail("Cannot set reboot flag", response);
@@ -451,7 +503,8 @@ static void reboot_bootloader(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_fastbootd(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_fastbootd(char *cmd_parameter,
+					    char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_FASTBOOTD))
 		fastboot_fail("Cannot set fastboot flag", response);
@@ -465,7 +518,8 @@ static void reboot_fastbootd(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_recovery(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_recovery(char *cmd_parameter,
+					   char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_RECOVERY))
 		fastboot_fail("Cannot set recovery flag", response);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 3c0013490cc..38d4a2678d3 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -12,6 +12,7 @@
 
 #include <bcb.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
@@ -89,6 +90,12 @@ void fastboot_okay(const char *reason, char *response)
  * which sets whatever flag your board specific Android bootloader flow
  * requires in order to re-enter the bootloader.
  */
+#ifdef CONFIG_XPL_BUILD
+int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
+{
+	return -EOPNOTSUPP;
+}
+#else
 int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
 	int ret;
@@ -127,6 +134,7 @@ out:
 	bcb_reset();
 	return ret;
 }
+#endif
 
 /**
  * fastboot_get_progress_callback() - Return progress callback
@@ -138,6 +146,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
 	return fastboot_progress_callback;
 }
 
+#ifndef CONFIG_XPL_BUILD
 /**
  * fastboot_boot() - Execute fastboot boot command
  *
@@ -175,6 +184,7 @@ void fastboot_boot(void)
 		do_reset(NULL, 0, 0, NULL);
 	}
 }
+#endif
 
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
@@ -189,12 +199,14 @@ void fastboot_handle_boot(int command, bool success)
 		return;
 
 	switch (command) {
+#ifndef CONFIG_XPL_BUILD
 	case FASTBOOT_COMMAND_BOOT:
 		fastboot_boot();
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 		net_set_state(NETLOOP_SUCCESS);
 #endif
 		break;
+#endif
 
 	case FASTBOOT_COMMAND_CONTINUE:
 #if CONFIG_IS_ENABLED(NET_LEGACY)
@@ -206,7 +218,14 @@ void fastboot_handle_boot(int command, bool success)
 	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
 	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
 	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
+#ifdef CONFIG_XPL_BUILD
+#if CONFIG_IS_ENABLED(FASTBOOT_REBOOT)
+		/* SPL may omit CMDLINE, so use the platform reset hook directly. */
+		reset_cpu();
+#endif
+#else
 		do_reset(NULL, 0, 0, NULL);
+#endif
 		break;
 	}
 }
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9e8e8889d08..608a62299af 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -240,12 +240,17 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
 	r = fastboot_mmc_get_part_info(part_name, &dev_desc, &part_info,
 				       response);
 	if (r >= 0) {
+#ifdef CONFIG_XPL_BUILD
+		/* SPL does not pull in filesystem probing just for this getvar. */
+		fastboot_okay("raw", response);
+#else
 		r = fs_set_blk_dev_with_part(dev_desc, r);
 		if (r < 0)
 			/* If we don't know then just default to raw */
 			fastboot_okay("raw", response);
 		else
 			fastboot_okay(fs_get_type_name(), response);
+#endif
 	}
 }
 
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
index 028193618f1..ba06468d487 100644
--- a/drivers/fastboot/fb_usb.c
+++ b/drivers/fastboot/fb_usb.c
@@ -40,6 +40,8 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 	}
 
 	while (!g_dnl_detach()) {
+#ifndef CONFIG_XPL_BUILD
+		/* SPL callers own the session lifetime and may have no console. */
 		if (CONFIG_IS_ENABLED(CMD_FASTBOOT_ABORT_KEYED)) {
 			if (tstc()) {
 				getchar();
@@ -49,6 +51,7 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 		} else if (ctrlc()) {
 			break;
 		}
+#endif
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 	}
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index f2aebf4e480..9dd3abe2a5c 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_$(PHASE_)USB_GADGET) += epautoconf.o config.o usbstring.o
 obj-$(CONFIG_$(PHASE_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
 obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
+obj-$(CONFIG_$(PHASE_)USB_FUNCTION_FASTBOOT) += f_fastboot.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
@@ -25,7 +26,6 @@ obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
 obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) += f_mass_storage.o
-obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += f_fastboot.o
 obj-$(CONFIG_USB_FUNCTION_SDP) += f_sdp.o
 obj-$(CONFIG_USB_FUNCTION_ROCKUSB) += f_rockusb.o
 obj-$(CONFIG_USB_FUNCTION_ACM)	+= f_acm.o
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 471c0e87042..49cacde9db5 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -490,11 +490,13 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 	g_dnl_trigger_detach();
 }
 
+#ifndef CONFIG_XPL_BUILD
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }
+#endif
 
 static int multiresponse_cmd = -1;
 static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
@@ -560,7 +562,9 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 	if (!strncmp("OKAY", response, 4)) {
 		switch (cmd) {
 		case FASTBOOT_COMMAND_BOOT:
+#ifndef CONFIG_XPL_BUILD
 			fastboot_func->in_req->complete = do_bootm_on_complete;
+#endif
 			break;
 
 		case FASTBOOT_COMMAND_CONTINUE:

-- 
2.55.0

