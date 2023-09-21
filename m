Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8663EE7108E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0708E86B35;
	Thu, 21 Sep 2023 17:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qj6JPvPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BE886B09; Thu, 21 Sep 2023 17:36:43 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6C386661
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A4B0EB82132
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541D2C4E770
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695310600;
 bh=hw/ck6FwM+9TAp5BkQ5Ju6ReeJ6fUDz1ft583pHYwLE=;
 h=From:Date:Subject:To:Cc:From;
 b=Qj6JPvPWMC/uEqqIb1smEq5z2BoIWGtf9i5xyaYbbTBbz+xQO4bWdNyNRm+LGhgcx
 uR4mIvED5nxZOG5b3DXx+htaoR/W/sX+gB/fmPHfYtEpK3YirpFcweXiYSjF9l3TZ6
 YsB+NKmbekfFZ9PESxKdnfY7KqfQU6UAVod3Lfl+ROQnpuJcP+RmTXjEMUIhnGeV7U
 tzUYU3ANBGukUemMO1G86dCm+xzvIZtHG+8B5mqiRpd6HOwKC5X4HIb1nzpMznKBSs
 m/HV1hIhUftInQRTYEi3alvZLW/Axcn2gBv+NDNYs5XEJ2uzeCrzkjdkCW9vbZHLNi
 HiGSD/kNkoilw==
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-6c07e122a78so678117a34.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:36:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YwRszPLO6g4nFHcqrTpByYiph39upp9W3iaHeFjVXrZ1NGm4gmi
 HzIgL4HK6oKoG++ijjfxbUHASwdZ68QMY3hB3Iw=
X-Google-Smtp-Source: AGHT+IFcTTKmdlyr6zFm6WVFuTs4zzLq1PuzyoODsledOOptGgorPXeDOUXiqYLlPyY32tjrzn9Rp2aOAs8ewjUcDUg=
X-Received: by 2002:a05:6870:d0c7:b0:1d6:925:83fe with SMTP id
 k7-20020a056870d0c700b001d6092583femr6668221oaa.0.1695310599650; Thu, 21 Sep
 2023 08:36:39 -0700 (PDT)
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Sep 2023 00:36:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
Message-ID: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
Subject: [Question] TI's u-boot.img is built twice
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, srk@ti.com,
 n-francis@ti.com, s-vadapalli@ti.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
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

Hi.

Since the TI platform migrated to binman,
u-boot.img is built twice.

It is created by "mkimage -E",
then overwritten by binman.


So, the data are embedded in the FIT structure
instead of being appended.

Is this intentional?

To me, it looks weird.




To confirm it, apply the following hack.

Since u-boot.img is overwritten by binman,
copy it to u-boot.img.backup.




diff --git a/Makefile b/Makefile
index 87f9fc786e..4cffa8a061 100644
--- a/Makefile
+++ b/Makefile
@@ -1112,6 +1112,7 @@ endef
 # Timestamp file to make sure that binman always runs
 .binman_stamp: $(INPUTS-y) FORCE
 ifeq ($(CONFIG_BINMAN),y)
+       cp u-boot.img u-boot.img.backup
        $(call if_changed,binman)
 endif
        @touch $@



Then, build it for the main core.


make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
   am64x_evm_a53_defconfig all
   TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
   BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
   BINMAN_INDIRS=~/ref/ti-linux-firmware




Compare the two files.
Run fdtdump to see what happened to them.


$ diff -u u-boot.img  u-boot.img.backup
Binary files u-boot.img and u-boot.img.backup differ


$ fdtdump u-boot.img
    => u-boot and dt are embedded.

$ fdtdump u-boot.img.backup
    => u-boot and dt are appended after the
       FIT structure



-- 
Best Regards
Masahiro Yamada
