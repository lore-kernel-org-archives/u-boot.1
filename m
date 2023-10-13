Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B08CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9B486E04;
	Fri, 13 Oct 2023 15:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbzH/bbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1005086E5E; Fri, 13 Oct 2023 15:24:19 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC98868BF
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-774141bb415so133060785a.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697203448; x=1697808248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9MpgcERVMqM2QiDIKxrnCZ05ZmkMykKlh0aAySFJjkI=;
 b=ZbzH/bbEF+06+lePYFGM4q8DCsyLY2Pi2T5WkUioeaPqUK5brLWYI4FHsZskstgWqF
 eCNz9rzgxoL9xhzno+y6dk2xGdbzC6WKXeC9YcMfHFKoAYjzv4X01OGDwPgYdwnrNGKf
 hl0UN17jBpl55Gv8qj3fjn0LavMVIcU5jVq9IpZ8zIT7qNH+bxp14DsgVfb9fKVZE/ur
 /odnV8FLs2WazyMcb5bObSBSTDeEV6qda3f0HLQFgdMVIkwz5Zbg8QrKKaSEermh72AG
 2pBus0PjrLx90eeeH41Lwzy7Zlwenzv0q/KTXU4H/ZbjUmydRkpsbHTVeIq3VbBlDBys
 NVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203448; x=1697808248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MpgcERVMqM2QiDIKxrnCZ05ZmkMykKlh0aAySFJjkI=;
 b=vpH6vI8g9SiqCtiqTR+U7wW2Yi0a9ukvHgHVdhHT4YWH5xim0phRtaq/G2/UFpKsgk
 XU/CHLmi6cALIMC5VXJjamz5iloJQe5vpLSwCNhuOcTF+lviiwCOd3NRguHu6y55Iz+o
 /FINFCccYSkczCBMQeVKXH8VNRU8jg2Ldes23pVTdUsffq7LiNzwHpBhlQusdNe+ZVos
 9DAJZnQkMU+dvbHH8USqZfPVs261r/5zBmIpQ9S3J2eD2WZU18QsLFc7IUMsBfSqSazQ
 sr/iS3e29xf+ToABF2JCq9VdE7yGASyXiNm2SsSxO0i5qf0F7Y/ngI/sBnXX7uLep0sA
 g6dw==
X-Gm-Message-State: AOJu0YxzSnIKBjVoexvP9c3w4udtDGygUINJ2ZfPOQfsp/CyDtrLU7OE
 eB6g5e7RY8Hf11UFBG+a1cg=
X-Google-Smtp-Source: AGHT+IEdG77yylS++F9/5e1oe1MbdeUwU4Zok+WkRg8VBXroneqbTNVM1ca7vVecDM7FhOnv2nk5JQ==
X-Received: by 2002:a05:620a:2847:b0:775:ce3e:7bff with SMTP id
 h7-20020a05620a284700b00775ce3e7bffmr27563450qkp.32.1697203448055; 
 Fri, 13 Oct 2023 06:24:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 d11-20020a05620a140b00b0076cda7eab11sm611960qkj.133.2023.10.13.06.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 06:24:07 -0700 (PDT)
From: John Clark <inindev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: John Clark <inindev@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] Makefile: remove misc include and simple-bin build artifacts
 on clean
Date: Fri, 13 Oct 2023 13:23:07 +0000
Message-ID: <20231013132338.42127-1-inindev@gmail.com>
X-Mailer: git-send-email 2.42.0
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

make rock5b-rk3588_defconfig
make
make clean
git status

before
~~~~~~~
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	include/autoconf.mk
	include/autoconf.mk.dep
	include/config.h
	mkimage-in-simple-bin-spi.mkimage-rockchip-tpl
	mkimage-in-simple-bin-spi.mkimage-u-boot-spl
	mkimage-in-simple-bin.mkimage-rockchip-tpl
	mkimage-in-simple-bin.mkimage-u-boot-spl
	simple-bin.fit.fit
	simple-bin.fit.itb

after
~~~~~~~
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean

Signed-off-by: John Clark <inindev@gmail.com>

---

 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b204a50043..7ba4ad45c8 100644
--- a/Makefile
+++ b/Makefile
@@ -2156,15 +2156,15 @@ CLEAN_DIRS  += $(MODVERDIR) \
 	       $(foreach d, spl tpl vpl, $(patsubst %,$d/%, \
 			$(filter-out include, $(shell ls -1 $d 2>/dev/null))))
 
-CLEAN_FILES += include/bmp_logo.h include/bmp_logo_data.h \
-	       include/generated/env.* drivers/video/u_boot_logo.S \
+CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
+	       include/config.h include/generated/env.* drivers/video/u_boot_logo.S \
 	       tools/version.h u-boot* MLO* SPL System.map fit-dtb.blob* \
 	       u-boot-ivt.img.log u-boot-dtb.imx.log SPL.log u-boot.imx.log \
 	       lpc32xx-* bl31.c bl31.elf bl31_*.bin image.map tispl.bin* \
 	       idbloader.img flash.bin flash.log defconfig keep-syms-lto.c \
 	       mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
-	       mkimage.rom.mkimage rom.map simple-bin.map simple-bin-spi.map \
+	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S
 
 # Directories & files removed with 'make mrproper'
-- 
2.42.0

