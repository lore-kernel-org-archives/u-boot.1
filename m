Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B2C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B17D60A8A;
	Fri, 31 Jul 2026 08:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xNoynIk83Xu; Fri, 31 Jul 2026 08:30:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E51B6081D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486612;
	bh=pPx+ivvbSLhmuCC45C+IJRXFSQV62MSmhNjkOCJ6hEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVWoLTODUV6s+XQLSOgqCVHCjIdFcGyUiVQU6e225af1QdytaMatzc8fC8eRWDUgd
	 j91rAL8R8//KpyGamv6NHtuyy+rVsmhbGbN84fB/d+Ok4jYt60QAaiqKzuYb2bKzsM
	 5eMUfKQzlifidRqH7pTwHtNAZl1gWtV+E/AH56lC8a3xz9KqOjIuY5YD7Kfhu4XqN8
	 92xNlT//RTpQJPb6m5j3OatU9Ln2ukOsfvkg5uh90tdElJxedgKO+n0UShiJ6nQYvj
	 XYoGOx6n1oEomjn90BZ55YIx/IR6BXfKrLMNxvkwQkUyYG/qd3zTG9V3Q9R/Lm3sHG
	 l/FCNhYqWAm4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E51B6081D;
	Fri, 31 Jul 2026 08:30:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D34A92E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7F9B80FF8
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH8zLN5_PaoY for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:30:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0DD2280FB2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DD2280FB2
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DD2280FB2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so1137636a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486602; x=1786091402;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pPx+ivvbSLhmuCC45C+IJRXFSQV62MSmhNjkOCJ6hEQ=;
 b=GLIwa5HTG52wcyiiJplUs6oliwDiKhUyxfqDJmb5PiXOIZSrIrLUlkpBMrrVtwSXqS
 F5HiaEQj5PLucprK/5oJ02feaDAGnec0SK6FA5YZf5yHuerpRL+34dNPr/RhkmAHmI6c
 /sMOemFnIZtIVG7xmfXHdWgDBv8FwDcRNujfiyuiDex7WEMkAPWHgyVR+koPHuo7UXZr
 a9ZpzzaEaQr7Y+9JHqZNWc3TtR4piDUWyzoUaMxqzejJmMRQtN//9jfuudLtEIKbl2/v
 A4sNOix3rKSKjcchgVpNzy8gGLA6D6RGfP1D7tEU7pNWEQLEhwRMZvgI7AFrzlV7gdWD
 Dvvw==
X-Gm-Message-State: AOJu0YzDrv1jY7xuEmpPjMlxPFjz3OumSih5uuKtg2/cipbebbWBj24j
 DC8RFj/T3SIeyezBX/qYZYEzZDrY2vcs7MM/uBvHBEzriJcrF1rRx4yRso86FzbQeuM=
X-Gm-Gg: AR+sD10euSU1AEkAFrYl2q6lqogSdoSdJvGaTJk8wTvj39ip11tfwZYno3OxYsoLtsT
 oWuRehatPP5e6QC/ZDHYnT+KUAwIJEQbnIehz6jgkJH6BKx+gDpovknYXUtb2UcHyoen3SBgIAT
 yi52SN7VPFjqqxqO7H6PW77jdEG0BvEV63pzL+nMhLnkxSRj6fXYH5B05c+jHj9JSUzBlRONrdG
 1tr2p3+bFQsTnd55Z87j6RSI4VTfke+lNSJm0DzQ+k00nWLZciBOOZ2U9TbmrfX2wi+ahoXfFm7
 8/+lOr1AKqc8nQxxZWiF7DhkohTKa6uZfcIPIRoPJafLZlruhfUAjyCy8Y6j3+iYk9TP6ca5iuv
 ku10qMI0IvPMuxR5AxDfmm27fQkcl8x8J9yxp2ogDCQccNHjJGshh4DNa50H8NCzrzuefUW9frZ
 Zs2dBaqXmHKYoQoqFCsof5XlYT/NKSqljScie7D787x3vkQ+OZrSeOC/PD37hSR37I0p7da+sp6
 OiylSIWHPPGc8mWHCNpKV8QPCtpXnRWNS+ksPWKgvCljBmzQUOs4GTxECzE1IwBexJpWGxPXFf0
 wkHUAcU4fo0=
X-Received: by 2002:a05:6402:34c8:b0:698:562f:1005 with SMTP id
 4fb4d7f45d1cf-6a098c9d456mr542807a12.16.1785486602047; 
 Fri, 31 Jul 2026 01:30:02 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:30:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 31 Jul 2026 10:29:41 +0200
Subject: [PATCH RFC v3 5/5] fastboot: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-5-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
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
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785486602; x=1786091402;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pPx+ivvbSLhmuCC45C+IJRXFSQV62MSmhNjkOCJ6hEQ=;
 b=MuKVBQTzZiiRnE8Ekw8rov7+nYKtYXkDV+WuOcQ7UVPWukWIxn5gysqf6iv58yQ4cQ
 77RtsubgDL8ZsPNooftzL+2iAUCvpFpGYW6L/Cqq7b2miiPKRUqxCof5ovIe3BEIOwr9
 OX2eeNvRguz9otJ7Gnjr4WnCB2WT0IBDBYphI7PzvRnJzijnRlH+2QIqgziAkQqO8W1H
 ianKLn5tu1oUeN0O+0nDHM4hRn2VZN9sxPEJ9p41l9t/Y7DMuIwHXMIdyzHcQrvy+s3o
 qM5y5dhenPy7L7/wb3sH/3OW6xq1vS+ebjMk65MV1v6ZaDwBPB3IejCWEQGlYbgZ9y1L
 BcVw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MuKVBQTz
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
index 96c544ae11b..885767e450f 100644
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
+   ret = fastboot_usb_run(controller_index, NULL, 0);
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
index ecb27f28362..37e557365c1 100644
--- a/drivers/fastboot/fb_usb.c
+++ b/drivers/fastboot/fb_usb.c
@@ -40,6 +40,8 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 	}
 
 	while (!g_dnl_detach()) {
+#ifndef CONFIG_XPL_BUILD
+		/* SPL callers own the session lifetime and may have no console. */
 		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
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

