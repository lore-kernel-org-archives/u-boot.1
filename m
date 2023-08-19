Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1CEE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E0387005;
	Sat, 19 Aug 2023 23:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LWRm6A8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E1986F9B; Sat, 19 Aug 2023 23:23:29 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE1186FF7
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso75168439f.2
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480205; x=1693085005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3mcZYDOwdV7y6kYzqApDWhZqUC3sCyI5bYPmjcgCBU=;
 b=LWRm6A8c4B1xW2nl7LX5eZatMpSYE4799hgLLIPD1UQSejE86DL2B6427C4n0Cvy0T
 xTC6kuI+0qLeUg4DBePlVQJfWHmLeeCDIPwzDG0K+fLDhWrsSrwYAfZR4NHoFTREoKBx
 1aTB6DZVNSPOLt4oC6fdT48P8WNxt8q7UwSn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480205; x=1693085005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3mcZYDOwdV7y6kYzqApDWhZqUC3sCyI5bYPmjcgCBU=;
 b=XmqFIYvidPePAbJJU4+cBz9tXlGeXcpCcXlVAAy4OPLGrSpt3fr8i9/A8wS7waNybX
 sJyxa7lntbEAOucb4gpjB12h47eREli6Jvva99tPBIjnzq1omZ/VZSHGczDhlmLoWE8U
 UKCbOPHohNEZFnR0GuXqtuOTU4EaTlfIh+g0AXNlwGs1m4BuIXx2FDr55Bc+9oQ44fTz
 GzjKdl0hg0yTlsld+elHykT4Ts/zWLTe84Jjh3l1QoQCBltEUbPRJ7M0dkR01RXlVyWb
 R2SUjjI5Yrnos4EGcONWoykrfArbfkT1gfOJcSadej2wuhs0lIJ80R4uivlR6g45tl6z
 TYRw==
X-Gm-Message-State: AOJu0YxliWICVfKM8uYpAxZk6O1hlk0o+I4ZBNn1+qWNvuQnriWvUExg
 dyL5a301qmxqFqfCIx4KkWbW08hN6uM/EBmTtj4=
X-Google-Smtp-Source: AGHT+IG7g3X8Oz+bbPLut4mgtNGFBIvKqfP6ZmDu3Ay8aybM7OBVVnFbNEMaYhN5EAYYt514dexhHg==
X-Received: by 2002:a5d:9cd8:0:b0:792:2b7a:e3c4 with SMTP id
 w24-20020a5d9cd8000000b007922b7ae3c4mr63073iow.18.1692480205077; 
 Sat, 19 Aug 2023 14:23:25 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/19] x86: coreboot: Align options between coreboot and
 coreboot64
Date: Sat, 19 Aug 2023 15:22:47 -0600
Message-ID: <20230819212309.1094440-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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
---

(no changes since v2)

Changes in v2:
- Update the malloc size too

 configs/coreboot64_defconfig | 7 +++++++
 configs/coreboot_defconfig   | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 29b68d6929c7..2263554a47ce 100644
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
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -51,10 +55,13 @@ CONFIG_SYS_ATA_ALT_OFFSET=0
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
index 2961908f29cd..790b84a87bc7 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -25,23 +25,14 @@ CONFIG_LAST_STAGE_INIT=y
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
2.42.0.rc1.204.g551eb34607-goog

