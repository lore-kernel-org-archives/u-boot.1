Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4242C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 08:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC8E87E74;
	Mon, 25 Mar 2024 09:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hzgT+lqu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lOqgNBCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F74E87E13; Mon, 25 Mar 2024 09:18:59 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9884B87DC7
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 09:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V35Rz2L1Gz9scN;
 Mon, 25 Mar 2024 09:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711354735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wn+V2r/RThszGH7LNDrisHPRRkfHCSzPfbOOI+cqwig=;
 b=hzgT+lquPopgR1yypqtuEZpGnXfOk4l/V4oQBu8msoZOXj9dX+VI2KIq5gHdEyHe++4FCs
 i+Bw1vPUxlp32cBEHoDQmII/Ic8YYnn2jVAOqOSvSEalw2k1Nw2RU0fW6Y2iHm8odVUKXr
 /hE3YxzlPHbSVlLilHVOVkwQbDvd9akwessM00aE0AzsosnouUmPILt+QFwTELV7bhyThg
 yP9lvdJCkg0bHl40EhHLNr4lBvLRNskimw5xqTjbEhR3VxofpAE8OZ9qU5jou0gAEvZIHZ
 Ex79fMPgA6JlBTPtH26zqNwyuGnBOEM5hLmAp4qWhTci4pMoHqeNTj8j4eH8IA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711354733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wn+V2r/RThszGH7LNDrisHPRRkfHCSzPfbOOI+cqwig=;
 b=lOqgNBCqseeLkjtNFJWoryfDdNoOt0jO9Bo17lIG3qIDDPNCxX0abEz88N0jsIIvQD8C3w
 mfj74De5QQd0CfJc6SNesrVDLWpkhRN8tEuvJ/cZS234tHl7UmS4FBaNWnckMkODrsRpdU
 eFinMkacGM5HPMfb9nHFKWQ3zgw0Uhat/ZE7PCfoXmGXXHSuZdp6oy156ofzJJ+UlImMTU
 K38K7qqG6mUYBP+heh8c+Mj/tJYtazhaoX1EJ7gcX9x73zgVN1ycISTyeKhi5ry3irUrkE
 Trb6Vwl+AMW0KiRfroncnv7DyxWiwGDr2+czmO6bC7DK/ARnIJskAoOnwklgng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Switch to using upstream DT
Date: Mon, 25 Mar 2024 09:17:54 +0100
Message-ID: <20240325081834.5519-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2625ccd1cde7302cc33
X-MBO-RS-META: x46t16r7gtxrwosm1x6gy6kgknfrnorj
X-Rspamd-Queue-Id: 4V35Rz2L1Gz9scN
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

Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
directory.

The configuration update has been done using the following script:
```
sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@="@&renesas/@' `git grep -li renesas configs`
sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas configs`
```

The RZN1 Snarc board does not seem to have a matching Linux kernel
DT counterpart, this is currently not switched to OF upstream.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig             | 1 +
 configs/alt_defconfig        | 2 +-
 configs/blanche_defconfig    | 2 +-
 configs/gose_defconfig       | 2 +-
 configs/grpeach_defconfig    | 2 +-
 configs/koelsch_defconfig    | 2 +-
 configs/lager_defconfig      | 2 +-
 configs/porter_defconfig     | 2 +-
 configs/rzn1_snarc_defconfig | 1 +
 configs/silk_defconfig       | 2 +-
 configs/stout_defconfig      | 2 +-
 11 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a0842e19330..ab8f30f1142 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1068,6 +1068,7 @@ config ARCH_RENESAS
 	imply BOARD_EARLY_INIT_F
 	imply CMD_DM
 	imply FAT_WRITE
+	imply OF_UPSTREAM
 	imply SYS_THUMB_BUILD
 	imply ARCH_MISC_INIT if DISPLAY_CPUINFO
 
diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index 06e9e11f297..c9ca22cbe8f 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7794-alt"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7794-alt"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Alt"
 CONFIG_R8A7794=y
diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
index c392055e5a7..a2823a614a5 100644
--- a/configs/blanche_defconfig
+++ b/configs/blanche_defconfig
@@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7792-blanche"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7792-blanche"
 CONFIG_ARCH_RENESAS_BOARD_STRING="Blanche"
 CONFIG_R8A7792=y
 CONFIG_TARGET_BLANCHE=y
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index 35edc677c48..0f76ae147ef 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7793-gose"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7793-gose"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Gose"
 CONFIG_R8A7793=y
diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index 0c581b634a2..70a80088bfb 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x80000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r7s72100-gr-peach"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-gr-peach"
 CONFIG_RZA1=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index ad411b45141..a912e58cf4d 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7791-koelsch"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7791-koelsch"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Koelsch"
 CONFIG_R8A7791=y
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index f60d4db5ec2..03f29b8849b 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7790-lager"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7790-lager"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Lager"
 CONFIG_R8A7790=y
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index f05a0baf215..170ca3a5f43 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7791-porter"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7791-porter"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Porter"
 CONFIG_R8A7791=y
diff --git a/configs/rzn1_snarc_defconfig b/configs/rzn1_snarc_defconfig
index 29a96d1aefe..1c313d2d4da 100644
--- a/configs/rzn1_snarc_defconfig
+++ b/configs/rzn1_snarc_defconfig
@@ -21,3 +21,4 @@ CONFIG_CADENCE_DDR_CTRL=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 # CONFIG_EFI_LOADER is not set
+# CONFIG_OF_UPSTREAM is not set
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 40ac8759d08..2e4fab8ac54 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7794-silk"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7794-silk"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Silk"
 CONFIG_R8A7794=y
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 428a0241986..ee87ea53d6e 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7790-stout"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7790-stout"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Stout"
 CONFIG_R8A7790=y
-- 
2.43.0

