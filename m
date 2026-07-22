Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9C6C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2813C80FA2;
	Wed, 22 Jul 2026 20:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVDs2q5byKdG; Wed, 22 Jul 2026 20:43:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0C5D80F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753027;
	bh=0wodDv2CzwracAdPjBqLQEauLbWJb9RDLPUsfVLEzFY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Au55AJ7x18OHt7UsTYWH5mrtywAaGOs4MsV+ZoCOJUXUAM+jNN/NcC+yhiNKl01vG
	 /eoaxftws2Nh0/JoBjRIAJMoxZMN5pcbUQlBlPkEyAj04M1GdaMKqhTZ2Ea3i3g23F
	 zVCAjSK+6XoR4aLSm0FfswhG+DZCDTp3rXo2n+Je1iAVlBX5f7ed6HEwk2+oRXJDdj
	 BAlre3MFjhZFD4bPjIFqQNLcmCam+uuDtNslVE0YjY0A5FgjKuNJoY6vqszTCLgLi6
	 3Ro0dX7eEidnl9B329ueK3s3L41asFoMGXosiq+Npy82+TobbBqP2Xw5+rKI6P98hs
	 IH1NI/R59XAug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0C5D80F94;
	Wed, 22 Jul 2026 20:43:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 719B4224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 571456087E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xZ2w4czqceo for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A513A607A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A513A607A3
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A513A607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so37693055e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753020; x=1785357820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0wodDv2CzwracAdPjBqLQEauLbWJb9RDLPUsfVLEzFY=;
 b=aV0pI4A1r3cSthCHyk77GtZ6V96Q/A3/++C0fXtf2AAuQ016OaVaKBHgbrw7PQh+8a
 rOdOPGxWJn9sapTtn4rS13moaIRUyROMEXi9ru0Pkat0u1KgPFJSIdyJAjg5mdS+yTQ0
 sYj6myCBkkzAAcCSulZaXrFVDscpba7+jwfcvQO4yOQlhDpEhauu+aQsen3zh8IxT+Bu
 hYtZhEqHPxk9xSTsi5m2TP1CSAfftkcFSN7rcsYnkL2RqWbcsrslN0UqegCZSdBV0tVO
 cYw/Gl7PsKQUYpnT6Zj2Lh5cfJNHp7v5s4DgMO5d72y5k/xkIODc02tH+defqDbIx8K9
 ZV0A==
X-Gm-Message-State: AOJu0YwBO7ya9mMKrdYSJRBfekNU2bLHBxgG0T2T1Vl2Shd0ksIMiOBv
 O2Tth1EHAScunWpTe3BKJnXKRExMRKQDPHFk9Xbez5KpXEEfiGBKePEhXmaVo/nZ5z4=
X-Gm-Gg: AR+sD12RzLWtnaYeCyvQqjQyJpQ4jwo2QXVWv/OMzYfAGYPrJBFds2RJMQnBlTPe8Ga
 534/w3GDS+wdeOJhmhvx+NJmvQsgMtSL6MT1XTNFsHp4yytYVj0BwzChtGjdSipwwyCLzjE51xE
 mE8FzSpgr3dNQfeLrWjeQq5sdxEnWpXy3VJwCzUrHXVmRg3OhUPCAwabj3FU7gM4urQFK09YWr8
 jEElrz03FjYNuKplw3icdycgJzjc11nuPg2BRw6Au7md9D+LqLkyODtFtMV2mnWYTrb6O/rdBUw
 pE8KG2a4IWAX5PtXoKDH8G6/0A0bCzckn4NEoeejZTfC35xoEWuwjp4iY6ySNOBQHsQjvqvXHDJ
 kr+rP4DiW9NGarVfV2fbA6S5ltgEF1L3NlW4RC04kUjVNdPdNNfTVLulQje6XLxxyn6up9Pze7J
 6QITV/qjjqbKvIRYVENCRuJjbGmLUMZlOdUwBKurmC/XXqGxfYPZPmIMmwOLE=
X-Received: by 2002:a05:600c:3b29:b0:495:6936:120e with SMTP id
 5b1f17b1804b1-49573d27209mr2272195e9.39.1784753020077; 
 Wed, 22 Jul 2026 13:43:40 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:39 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:43:07 +0200
Subject: [PATCH RFC v2 5/5] fastboot: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-5-2ba3f71c42bc@baylibre.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753020; x=1785357820;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wodDv2CzwracAdPjBqLQEauLbWJb9RDLPUsfVLEzFY=;
 b=SNotRlRypgQCDpllzYXdoBYqarrfEAa3PiJovUtqK/Wp5YgcEZMSSvx+U6VpW3gKQG
 4sc+5m4Pv4z1y+NRmoXfJN9dKDxH6gJKkuu/uoe4Wra3ffCTAyoa90uk22P186goFW0s
 MIliWA1I6gmbPVv00iFpNptONqPG7KTsu2K/6hHLcQ/CxVi/651u1AJz36VHPvT6PfpJ
 Hs1eChLsb0WRkg8t4hWViK0tbJuV8TBf5qOe0bdN41uo/Otj0pzuJO7DYLZybjjQhyT3
 RodLn3zhs2zZ5frbhHibPTle7Mf8Uled+bRnl4LUFk7oya899xYW1n0KHuIL/WdQMxsw
 wxjw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SNotRlRy
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 doc/android/fastboot.rst        | 27 ++++++++++++-
 drivers/fastboot/Kconfig        | 89 ++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/Makefile       |  4 ++
 drivers/fastboot/fb_command.c   | 27 +++++++++++--
 drivers/fastboot/fb_common.c    | 21 ++++++++++
 drivers/fastboot/fb_getvar.c    |  5 +++
 drivers/fastboot/fb_usb.c       |  3 ++
 drivers/usb/gadget/Makefile     |  1 +
 drivers/usb/gadget/f_fastboot.c |  4 ++
 9 files changed, 175 insertions(+), 6 deletions(-)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 96c544ae11b..3f9cfb2fa78 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -10,7 +10,7 @@ The protocol that is used over USB and UDP is described in [1]_.
 
 The current implementation supports the following standard commands:
 
-- ``boot``
+- ``boot`` (not available in SPL)
 - ``continue``
 - ``download``
 - ``erase`` (if enabled)
@@ -72,6 +72,31 @@ platform. The location of the buffer and size are set with
 may be overridden on the fastboot command line using ``-l`` and
 ``-s``.
 
+Fastboot in SPL
+^^^^^^^^^^^^^^^
+
+Fastboot can be used from SPL without enabling the command line. Enable
+``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
+then start the session from board code::
+
+   ret = fastboot_usb_start(controller_index, NULL, 0);
+
+A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
+``CONFIG_FASTBOOT_BUF_SIZE``. Passing explicit values overrides these
+defaults. The ``continue`` command ends the session and returns control to the
+caller. Unlike the command-line invocation, an SPL session cannot be aborted
+from the local console.
+
+MMC flash and erase support is enabled with
+``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
+storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
+for GPT.
+
+The ``boot`` command is not available in SPL. Reboot commands require
+``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform ``reset_cpu()`` implementation.
+The ``reboot-bootloader``, ``reboot-fastboot`` and ``reboot-recovery`` commands
+also require a platform ``fastboot_set_reboot_flag()`` implementation.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..017fb7956a1 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
-	depends on CMDLINE
+
+if CMDLINE
 
 config FASTBOOT
 	bool
@@ -47,7 +48,27 @@ config TCP_FUNCTION_FASTBOOT
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
+config SPL_FASTBOOT_REBOOT
+	bool "Enable fastboot reboot commands in SPL"
+	depends on SPL_FASTBOOT
+	help
+	  Enable the fastboot reboot commands in SPL.
+
+if FASTBOOT || SPL_FASTBOOT
 
 config FASTBOOT_BUF_ADDR
 	hex "Define FASTBOOT buffer address"
@@ -79,6 +100,10 @@ config FASTBOOT_BUF_SIZE
 	  downloads. This buffer should be as large as possible for a
 	  platform. Define this to the size available RAM for fastboot.
 
+endif # FASTBOOT || SPL_FASTBOOT
+
+if FASTBOOT
+
 config FASTBOOT_USB_DEV
 	int "USB controller number"
 	depends on USB_FUNCTION_FASTBOOT
@@ -294,4 +319,64 @@ config FASTBOOT_OEM_BOARD
 
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
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 12008ac05e2..43e391d8ec4 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,7 +3,11 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
+else
+obj-$(CONFIG_SPL_FASTBOOT) += fb_usb.o
+endif
 obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
 obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 111516fd1b3..4a3cc4cbb27 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -37,9 +37,9 @@ static void getvar(char *, char *);
 static void download(char *, char *);
 static void flash(char *, char *);
 static void erase(char *, char *);
-static void reboot_bootloader(char *, char *);
-static void reboot_fastbootd(char *, char *);
-static void reboot_recovery(char *, char *);
+static void __maybe_unused reboot_bootloader(char *, char *);
+static void __maybe_unused reboot_fastbootd(char *, char *);
+static void __maybe_unused reboot_recovery(char *, char *);
 static void oem_format(char *, char *);
 static void oem_partconf(char *, char *);
 static void oem_bootbus(char *, char *);
@@ -70,7 +70,9 @@ static const struct {
 	},
 	[FASTBOOT_COMMAND_BOOT] =  {
 		.command = "boot",
+#ifndef CONFIG_XPL_BUILD
 		.dispatch = okay
+#endif
 	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
@@ -78,19 +80,38 @@ static const struct {
 	},
 	[FASTBOOT_COMMAND_REBOOT] =  {
 		.command = "reboot",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
+#else
 		.dispatch = okay
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
 		.command = "reboot-bootloader",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_bootloader), (NULL))
+#else
 		.dispatch = reboot_bootloader
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
 		.command = "reboot-fastboot",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_fastbootd), (NULL))
+#else
 		.dispatch = reboot_fastbootd
+#endif
 	},
 	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
 		.command = "reboot-recovery",
+#ifdef CONFIG_XPL_BUILD
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_recovery), (NULL))
+#else
 		.dispatch = reboot_recovery
+#endif
 	},
 	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
 		.command = "set_active",
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 3c0013490cc..bd8ba8824de 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -12,6 +12,7 @@
 
 #include <bcb.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
@@ -89,6 +90,14 @@ void fastboot_okay(const char *reason, char *response)
  * which sets whatever flag your board specific Android bootloader flow
  * requires in order to re-enter the bootloader.
  */
+#ifdef CONFIG_XPL_BUILD
+int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
+{
+	(void)reason;
+
+	return -EOPNOTSUPP;
+}
+#else
 int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
 	int ret;
@@ -127,6 +136,7 @@ out:
 	bcb_reset();
 	return ret;
 }
+#endif
 
 /**
  * fastboot_get_progress_callback() - Return progress callback
@@ -138,6 +148,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
 	return fastboot_progress_callback;
 }
 
+#ifndef CONFIG_XPL_BUILD
 /**
  * fastboot_boot() - Execute fastboot boot command
  *
@@ -175,6 +186,7 @@ void fastboot_boot(void)
 		do_reset(NULL, 0, 0, NULL);
 	}
 }
+#endif /* !CONFIG_XPL_BUILD */
 
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
@@ -189,12 +201,14 @@ void fastboot_handle_boot(int command, bool success)
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
@@ -206,7 +220,14 @@ void fastboot_handle_boot(int command, bool success)
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
index 08aba7b5c12..b6637c49fd8 100644
--- a/drivers/fastboot/fb_usb.c
+++ b/drivers/fastboot/fb_usb.c
@@ -40,6 +40,8 @@ int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
 	}
 
 	while (!g_dnl_detach()) {
+#ifndef CONFIG_XPL_BUILD
+		/* SPL callers own the session lifetime and may have no console. */
 		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
 			if (tstc()) {
 				getchar();
@@ -49,6 +51,7 @@ int fastboot_usb_start(int controller_index, void *buf_addr, u32 buf_size)
 		} else if (ctrlc()) {
 			break;
 		}
+#endif
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 	}
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index f2aebf4e480..87ec0cf6c40 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
 obj-$(CONFIG_SPL_DFU) += f_dfu.o
+obj-$(CONFIG_SPL_FASTBOOT) += f_fastboot.o
 obj-$(CONFIG_SPL_USB_SDP_SUPPORT) += f_sdp.o
 endif
 
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

