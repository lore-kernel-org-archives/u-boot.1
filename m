Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F272CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C24986C6B;
	Wed, 20 Sep 2023 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HRddMaFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2E086BDA; Wed, 20 Sep 2023 05:00:43 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1266C86C5C
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34fcd36c86eso13623345ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178839; x=1695783639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hw3Yy9YI/uqhvkRv49xo0YdmYt+5WbklY9l9kJjFMak=;
 b=HRddMaFZDWevsNrovowww15HEMMqeyMEk6D0m8tVly90qcAmyupSGD/1NgZ1KOtlla
 3xO7BmaOFRX8niDIyeyWZkuBATUHPw8lO1Tz600lVPPwxn8fNr7UiIiJ43X2FwrjkzLm
 bU6yiUVIwXZEC3+/ys66zjKkeY/57LP3c/THU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178839; x=1695783639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw3Yy9YI/uqhvkRv49xo0YdmYt+5WbklY9l9kJjFMak=;
 b=dZ2cbeQZtzHIouddR78C+wJx8jeK3Vc8AtPcXiDdjbdblyJKfXWdK/mRUrD51aHacW
 F4nBPSJGJjewB288ss5sgIFnKTkOHJhTCbu6LMu+Lgdha3t+cIZ2fubBciXItHgmIRJw
 W9HayUphgoGnTEGTdEVvdN13rmlEm+C1henuDWORwhZ2XKFuqSzd4AtzuLP+aNF1rWA4
 GpO16zy0zo7NaypnNz0Z85I3gKds855AfYnx2JWuGabnUUzRNiakHyFwm/rbFHX/qM5F
 fn1Jo4U4vOD0lPDK1Cgz4S6opL/woMQFUaLjJjpQHhGaCVgYNp0TNK6bex3yPcwamIUq
 03LQ==
X-Gm-Message-State: AOJu0YwdlLE6LCNiIFvSTx38rprjusBNoNNLCdbB26YDCddhPYkq1n5u
 /og+LASk8U5FaHPIbb4mEH38S8WWpoPWIsJugD4=
X-Google-Smtp-Source: AGHT+IFSH2JFeHImRVnRe1p07cwf3s1NuVvz1KVsA9VuIEFTPlSJUg53AeYOkmHr/dVqWa9i73czyg==
X-Received: by 2002:a05:6e02:174a:b0:34d:ee49:5114 with SMTP id
 y10-20020a056e02174a00b0034dee495114mr2076149ill.23.1695178839686; 
 Tue, 19 Sep 2023 20:00:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/20] x86: coreboot: Align options between coreboot and
 coreboot64
Date: Tue, 19 Sep 2023 21:00:10 -0600
Message-ID: <20230920030027.1385833-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

These two builds are similar but have some different options for not good
reason. Line them up to be as similar as possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

Changes in v2:
- Update the malloc size too

 configs/coreboot64_defconfig | 7 +++++++
 configs/coreboot_defconfig   | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index c04056339462..dc3548aa736c 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -1,5 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1120000
+CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -18,6 +19,9 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_LOGF_LINE=y
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SYS_PBSIZE=532
@@ -50,10 +54,13 @@ CONFIG_SYS_ATA_ALT_OFFSET=0
 CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
+CONFIG_SMBIOS_PARSER=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index e7e45c2b0a9b..630eb9aa384c 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -24,23 +24,14 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-- 
2.42.0.459.ge4e396fd5e-goog

