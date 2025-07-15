Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFCFC83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 11:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B6882F6F;
	Tue, 15 Jul 2025 13:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T8FbHts1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B553782F8F; Tue, 15 Jul 2025 13:11:14 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5F982BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4220024f8f.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752577871; x=1753182671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JlakVpbSoR63oF3YpxxzLDbY7ikJ6lljuPgsfBb8Xuc=;
 b=T8FbHts1mHaGmmJDKFKL3be9lOzV2UqslaLBGHVacOjdEia+Aay8bIkOfEjvlE6vsU
 Nd743lhMlt+QOTL9NF5BjRyTLLCQQTFK9LimGd2WLygUPtcVvesMtrozVSyEdN1hzUZv
 GovMZFqCu4E0CgLw7I4qM/wY1UkyUDcUUwhctdfxHWnvYvd6+GlbirEPnI0CIA7mSgBg
 5hCdYWGSzok1gBtXYpd11i8ypC4IEwnyKibyyZmFmC98fbRUJez0m7dIOdN/N2aAcbzb
 05j1qyliniX8xScNCpeXJ+sxoaJtZU3mwfBSohRf+et/hJ23K1MyFPjbah6i1PpG82jR
 aNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752577871; x=1753182671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlakVpbSoR63oF3YpxxzLDbY7ikJ6lljuPgsfBb8Xuc=;
 b=ksuno27XxQ9GBRatZID82wqsB3W8pkThN1yseJd47Dl75Z/3Y9O2xd0mZxmuoPJfXs
 uioJSugW5gJWrPVc8XJ5vkUG++1DhiSoeHwqNrpgIuAnAaf75gsHZwk75x63CIk4NcXK
 M+AEHn9fxuT8lSjjZW3K15h2h8ErXMsmQ/EKjqK36xnLjwo3V05lJV1sstZcCPJOtmux
 KWoeyTZXmuhmu4v4WBfyCudUWF6z7RrJnActCdaXyhkH2BO4+cdRIdg6NCv4uXrjUmTr
 vHH0T8WTfeyLFl3yc6V7IEjjIJQdKLdbR0G98X+EyTtWIvKp9nidYkmhWBFkfZf4k/HK
 tc7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiP+WmDOKXi6zcMfnld/r5s5IVu0XrHk9XCVuXBQv0TSf7+HNBgmYsitbB78Tk4PJFGi2P5oE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxws/LfbzvY4IxV662zUA8mdPcS6cIs70UfFnbhcYovTGzmgCMB
 nD5CRHYuo+B1zZ6x1xoH1d+jF/4sxtg5lZ8ltmI/T2ImF7Wv31o/yqaD
X-Gm-Gg: ASbGncsRM/dbPlLyX6ICEtw/DXuADVL5zhE2U7LvqmgVn4lyDa5FoMOqJ0H2kUv8U1Y
 +s8oCKYlzNKyX1l73cMo9pj6L2957fmemrvKCRY6S3QBDpJF1fugMJR6U4IuNV00O+roTLvyp7Z
 lXIvFwdgQCYwZtqx1AMoIscOsEVOQ4NcOafhVppA/hKpwAlqUFSoVnP459dmyH1aHAM0t8wjv1m
 23i1BnDFnXmYcoSitrZ+bTyXTLPlTAYiezs2HgIc3mKgJlrmESpWekFq1JwTXUJ0myZZtynwDLK
 wddjlARBDGonwS1rMhieeRWmC6kQl41QRLB5/y8smZ4dlfa1bVxTNwo6sQA0ZYKHByYlScFsZY3
 1HxbGFeG0sL5//Vf3/4f8mofkwyTeX2KJU6scSdW0wc6/Fl2zsb33glDD
X-Google-Smtp-Source: AGHT+IFetuabXhAji8tSy3u4dVefChTO40S321bWZh8tWNN/EKDQtMIEfARriayVvtQpbeY7vm0XVA==
X-Received: by 2002:a05:6000:2d11:b0:3a4:fbaf:3f99 with SMTP id
 ffacd0b85a97d-3b5f188d7b8mr9990477f8f.13.1752577871122; 
 Tue, 15 Jul 2025 04:11:11 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:55d8:78ff:485d:b45f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18ffsm14604551f8f.9.2025.07.15.04.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 04:11:10 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chris Paterson <chris.paterson2@renesas.com>,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] configs: renesas: Set CONFIG_TEXT_BASE to 0x0 for R-Car Gen3
 PIE builds
Date: Tue, 15 Jul 2025 12:11:03 +0100
Message-ID: <20250715111103.1092458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.50.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

For Renesas R-Car Gen3 platforms with CONFIG_POSITION_INDEPENDENT enabled,
override CONFIG_TEXT_BASE to 0x0 in each defconfig. The top-level Makefile
already compensates for our PIE builds by appending:

    OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000

so that the flash_writer and legacy recovery tools still see an SREC load
address of 0x5000_0000. This change prevents the "Program over size Error"
reported by flash_writer when programming PIE U-Boot on these platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 configs/hihope_rzg2_defconfig    | 2 +-
 configs/r8a77970_eagle_defconfig | 2 +-
 configs/r8a77970_v3msk_defconfig | 2 +-
 configs/r8a77990_ebisu_defconfig | 2 +-
 configs/r8a77995_draak_defconfig | 2 +-
 configs/rzg2_beacon_defconfig    | 2 +-
 configs/silinux_ek874_defconfig  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index f5bb28cb0c7..931183cc34b 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m-ex"
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 4ab362f0d43..7d6ba1b9cb4 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 5ef81682caa..991050e5855 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 414bfdebab1..b1dbecdbef7 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 12d92067de5..1bf861a516f 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 0b91337b17b..0aa7a91f77c 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -3,7 +3,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index acdd1ad5205..68157f17943 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
+CONFIG_TEXT_BASE=0x0
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3F0000
-- 
2.50.1

