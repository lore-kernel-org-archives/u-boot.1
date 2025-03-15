Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE003C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F285581DED;
	Sat, 15 Mar 2025 15:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lwVYImtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9571381D65; Sat, 15 Mar 2025 15:28:11 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BB281E60
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so7297935e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048888; x=1742653688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=lwVYImtvTiHAzSgWlhYMaDHDRP7gZnCjo9h2UKZNeNIfsmqw0LlJkazESM+t0ikp3c
 b1gYSfS6DEpx2B2TO7RdgtWdLvKgG/+SLD3/VvEAE2D0Arv9fPpE9eI/gj9zvzIwa0dF
 Gehal2O0/m/UkaD+B3DB5FXKL870cOxOf1z1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048888; x=1742653688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=Xm2cIANLCqISZTFwzT6H9pENca4VN6CBiArxZNn5lxqOG7wucpW5nWl9f8yhkCOiwR
 SeY/H0oxtfai3eiA/mouGlRc0WPF2nOQ0pRcrw/5YttFta7If1EFX5JnVOGs1aix7jp0
 8SUiw1ApESR9cL3WKrw+lUSx4AZ0GWr+2Xj2T/O9hN617uSWWRK2ZB9FoH99wkOSU/J5
 6ltjqJJSxtUSngtprBMSqXYcTzZOr78Ym1AI43KYFJMSmxI9tBWAGmM6AN5nwXlIXzoR
 zjRFr8QhqI5lvzKiT6ql9PWysHlj4EdknyLOT453+NCttnWvQyxxGTH+pMh/FNiAvdq3
 gmHA==
X-Gm-Message-State: AOJu0YzrCIIkEAPgj0zwYmg8Cd9nNMCwflkWqMnSFLG7qwooDOzpNSjG
 4KzWHCRzJ+oo+sw+VDOwFZ2odCxx1HB08izR9HOmdBuJw+C3n7gvNYbaxwPlN+8rH2IvwnSXFPK
 yOA==
X-Gm-Gg: ASbGncvX2jo4kus88o+Z33p5ydJhC/pmKbf/0Hgw1BpfYREg6CxP0srQC7B4JKYw7wM
 5OtzePve+oiZhW3j45UO273DuyNR5eC4jjQ/PBhHooKZ6LLOgzb2l5SOBCyftAClmyl7jZ9Qo+B
 I5COrF3QU8+mH3sjiRu9F44AwgxKrLhWZ53U+36eg1kD/2bI96QsH22+NTdxWdsGU+gYmvvtprn
 nkP5tVIce7FwyARYvWRecwLl/L8Uf9yegJYexfuii97dx4gPbfAQ0zHCnKwezhlXIkxpE34qPCu
 zg0E3cBFpr/Sll9UppzYOmlH5C16U64WrCBEmAqSog==
X-Google-Smtp-Source: AGHT+IGu9fj3IB/3JJZSuGapRjOiDGUdzhm6XhlWU53ITcgn2d0W/XgrpVYSlW+dk1imD/Us4n+VhQ==
X-Received: by 2002:a05:600c:510f:b0:43d:aed:f7de with SMTP id
 5b1f17b1804b1-43d1ece301amr72592455e9.21.1742048888257; 
 Sat, 15 Mar 2025 07:28:08 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 28/46] x86: qemu: Support environment and cat command
Date: Sat, 15 Mar 2025 14:25:48 +0000
Message-ID: <20250315142643.2600605-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Add support for an environment stored in the first partition of the
disk, which is assumed to hold a FAT filesystem.

Support the 'cat' command as it is useful for looking at extlinux.conf
files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 6 ++++--
 configs/qemu-x86_defconfig    | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 84b7dc8e99f..ae34cc2a6f8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -41,9 +41,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_CPU=y
-CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_NET=y
 CONFIG_SPL_PCI=y
 CONFIG_SPL_PCH=y
 CONFIG_SPL_RTC=y
@@ -54,6 +52,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -61,6 +60,9 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index d52afa42955..7afa3827e61 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -42,6 +43,9 @@ CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-- 
2.43.0

