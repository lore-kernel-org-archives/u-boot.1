Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A9C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FD286C10;
	Fri, 18 Aug 2023 02:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FM0lmiXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9113386B7E; Fri, 18 Aug 2023 02:27:19 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0636986C04
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3491568afd4so1434655ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318434; x=1692923234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMgLVwW+yCQMIjyVBsdgTLS/l1b6gl6ACRyyjBjz88w=;
 b=FM0lmiXsu55yBgzmiUNjsCZsqoReSii9S5MckPxO1avni4e3Hs3KZqTkzvHjrv8Tbb
 Txwxe6clnimdugCna77n5114gjPpKzfaYddped7O7/xTHw69dn148oZEaFVxc7Y9tBpi
 9dCTVrpLx6RIo1HZKBN5aNwnxSKfwXtett3Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318434; x=1692923234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMgLVwW+yCQMIjyVBsdgTLS/l1b6gl6ACRyyjBjz88w=;
 b=ikJ1wk4hBh+Ac6l3ZmLRbVK7SbS0TZMYQyCy0qTGtq9p7/al08Ym+HzTslsULSMgeC
 NkdmGE6jMeC9iFieII63ICv0Q340nzqFOxQq7/Dotc4kfCEqAM/9d4+lYAuqmstrXoK6
 OVyPkbKDy8O0kv3icqGr4B5b3aeJF8XDIDGzFAM9ksSpvvPTGs/7vt5/anOoIDx942Fk
 ef6Z/M2k7adEvmab8nIvmK7jlKULw0kCLpPU9qxgzF2yV1tKZwNrul6evJhJqwe7+WBm
 WFJNO4WStgd6yyfk+4y3+hh1lVzPWoU8HkpsJt90UMXLVjFyuL5IeAmYJJVt+3WYhvTx
 x6Cw==
X-Gm-Message-State: AOJu0Yzz+OVTm3IKOMpv30LK9JsaJp1F3P5bBni4N4vziTi1qBzK5FZB
 rs1az76Zj5G1hEQ/GLd4ZSefIrf8coXj50NMMcI=
X-Google-Smtp-Source: AGHT+IEsftIN6XHOj1ftsb43StsVjO07vcFqfLdR+ccreFOLyrEL3oY24nPUY7JgKJtxbi77RxZN9Q==
X-Received: by 2002:a92:c54d:0:b0:348:8b42:47d with SMTP id
 a13-20020a92c54d000000b003488b42047dmr1339569ilj.28.1692318434606; 
 Thu, 17 Aug 2023 17:27:14 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 01/20] x86: coreboot: Add IDE and SATA
Date: Thu, 17 Aug 2023 18:26:40 -0600
Message-ID: <20230818002706.853550-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

Add these options to permit access to more disk types.

Add some documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig    |  1 +
 configs/coreboot_defconfig      |  9 +++++++++
 doc/board/coreboot/coreboot.rst | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 8aadaa68c279..ded0e6f2422d 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 8e11de663819..56cc542df6c6 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -22,8 +22,10 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
+CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
@@ -48,6 +50,13 @@ CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_ACPIGEN is not set
+CONFIG_SYS_IDE_MAXDEVICE=4
+CONFIG_SYS_ATA_DATA_OFFSET=0
+CONFIG_SYS_ATA_REG_OFFSET=0
+CONFIG_SYS_ATA_ALT_OFFSET=0
+CONFIG_ATAPI=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
 CONFIG_SOUND=y
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index d660a223d9c8..be5b0de5495e 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -41,6 +41,26 @@ At present it seems that for Minnowboard Max, coreboot does not pass through
 the video information correctly (it always says the resolution is 0x0). This
 works correctly for link though.
 
+You can run via QEMU using::
+
+  qemu-system-x86_64 -bios build/coreboot.rom -serial mon:stdio
+
+The `-serial mon:stdio` part shows both output in the display and on the
+console. It is optional. You can add `nographic` as well to *only* get console
+output.
+
+To run with a SATA drive called `$DISK`::
+
+  qemu-system-x86_64 -bios build/coreboot.rom -serial mon:stdio \
+	-drive id=disk,file=$DISK,if=none \
+	-device ahci,id=ahci \
+	-device ide-hd,drive=disk,bus=ahci.0
+
+Then you can scan it with `scsi scan` and access it normally.
+
+To use 4GB of memory, typically necessary for booting Linux distros, add
+`-m 4GB`.
+
 64-bit U-Boot
 -------------
 
-- 
2.42.0.rc1.204.g551eb34607-goog

