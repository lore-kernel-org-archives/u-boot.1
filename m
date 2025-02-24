Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F2AC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B497F8121A;
	Tue, 25 Feb 2025 00:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g60SAuP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAFA811B9; Tue, 25 Feb 2025 00:07:55 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5C281120
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d19e40a891so16503075ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438471; x=1741043271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=g60SAuP1sU281oQ6RcdVbIFEX4gwNsjddBHJTTGtjPZ/C1rkqyloC5zIn0utM0i9/P
 DNTBqy2OaDVDe9Gv2eYIQ78/EubcUrhu83o4ihTbzJ1/pEzOqJ/G8Nye/BD6Ga0HLKJ5
 F50Eby9Ll88SRIqzkrBDe+2kCNkL18krZNiZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438471; x=1741043271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=Hu0ayIlBWUe5TojRLTMpA5r51B8BeaFqit2f16Ga2oF88IcG4tJ/aFrK0ggb7N9j+x
 1zd91SQlgBDv/7EQ2NffrInfa9fTp50sV19RYNwxahueQ57YmvI71VgCYcO7X3uA8QyT
 5+Jb2fVvDT96z7ESOPz7ucIbJ42oB9D9lQuWmKnzYikJAHy02jiF7661yQK42LCcqK3D
 fDdEpjCos5hUQVPMXNIapSB6m+WRpkrllOr5/EXf3GckVjmqRobTR06MInWCC3N8avq+
 itIFVRXik1nmAlBlpW6eCfsYogWkkcGMuGY4azri4xR8avqlB1tgXo4zKO3TtD1CMulh
 s9eg==
X-Gm-Message-State: AOJu0YxmxmDLjOjgxWzLUCAuvFWnYlET+3g7aSg79E15WZgyYzXvXiDs
 PLT9ZBSHO7tn2PoWMe04hvimYL1QWD0vgGJTPC+/Cf/fyApmmjXKTeh48GqfmDa1X3lXxFGMU3w
 =
X-Gm-Gg: ASbGncscwasxIttF/i9F8BTRN8v8ySwDgYRxvKjgciRA/NtH+cQlR3qsxVXaDtlyaDq
 0gsjUrBGbtsTgKgxU77l5C/jY4jRpVSPvHKHP+dFJVtSu6OMVr+vg4fNCRaMX8W5Qn+iWqZ12bP
 mghyGwLgMzZB233pXNYxYWtSkYlrptLMbX0SC9qbOyKCWtRsuQ+wCgBmjEHFk5WgZ+2w+RrgaFK
 JKOTw209mXud4YWRo7EmcYTVkxWCD8jV00dtYpldJ9nTjHYeRsfU2oMUQrbAKVLw095uMB2TNkJ
 wzMZ2aiopsALWGfsQ9LPsHKV8Xnaf/MghJkOozn5mNDcjPfbFbmry07KUP/wLt4=
X-Google-Smtp-Source: AGHT+IGJ0PyYA7aN2H+Wd3AUmLTHv4nsQ7t+eBZtCay/PdzBHbeJLHh3U9MgQnXeG1vnXSkUazdOJg==
X-Received: by 2002:a05:6e02:b2a:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3d2fc0ea5camr16148325ab.12.1740438471564; 
 Mon, 24 Feb 2025 15:07:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 26/44] x86: qemu: Support environment and cat command
Date: Mon, 24 Feb 2025 16:06:15 -0700
Message-ID: <20250224230640.2665206-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

