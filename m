Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80976EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA65E8644D;
	Tue, 22 Aug 2023 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="1UwXVmk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343B18644E; Tue, 22 Aug 2023 17:33:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE9B86439
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so27345115e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692718391; x=1693323191; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9ENabRDYo8stcQwvuKig0CEktQqxLlhPYpENaTJ1XPE=;
 b=1UwXVmk9bDqGbIiqaIJJnlS0GA1nWw3r+Rif1XQ1pQrS7HgV+7DikHQA5i6dUTsoP4
 t31Fwtd15W7sV3jqFilLEBl2g2CFm7KPzptaeKNa+IbJ/STFNGl5vqJdnPQswhOo20Gw
 TN0YKK9MhDcjEJ9Kwa29yzZw5rgxCyi1QkmHmFTJFMknRKf3EURDmMYcoLOX2ybEje2u
 cx/hgyQ8F5jBC8pp90d5E7w2fSn3j8u/eRmQvdD/hYz0Q0mS31apGNnRT5uVF4OJlpMk
 7zR0X8ODKSD6QnsDbjCCRnBrPCNLtKIQHWYBe1ru0v2p22IDanqkiBui9YOhy3b3BjgY
 kIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692718391; x=1693323191;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ENabRDYo8stcQwvuKig0CEktQqxLlhPYpENaTJ1XPE=;
 b=LlGipwEzY33x0LPSh4ZGlgruMdIKfbKAT0ZsNNEqKZmfeubHReyL5Vn/ggII8hIEA7
 SlohaAeWkaSFxralF7TPHmRahr4zXdrVSRlmah6yxXUFcGCYtmP5W825LKrpxnBfUvpr
 HqDQ7ByHG4sTeKQI03E0geqfSCJGofCnAhmJJ/AyOIDvqq/pK5P3LIo8GlSe63qoCeJU
 ApJuV5OeLQ4gMsywG5tgKamlYwequceliQXhm4MLQrEltewyAVTIdj1yGxr7ktkFc4bM
 OaEjQhpvKw0aUjVekz4WaGyCov6FWUgaV3fvEmrPLd8VAi61Yeme+eb2MhSPyi5ZwQBF
 NNDw==
X-Gm-Message-State: AOJu0Yzn0b9cOsXGdlMEOVyG5jp70qYDUfcyzyImxVCCr7yILR0NXf46
 CDwLUqoZphbApG9bz5OBSXBCdw==
X-Google-Smtp-Source: AGHT+IG7BnWQUzvPTTWB+G67nGBj4CVxE+NA/e2tnuNYQf6FBjudyoK9H2WepiyXtG+MnGvCOThEfQ==
X-Received: by 2002:a7b:cd85:0:b0:3fe:2011:a7bf with SMTP id
 y5-20020a7bcd85000000b003fe2011a7bfmr8360849wmj.6.1692718391237; 
 Tue, 22 Aug 2023 08:33:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 t9-20020a1c7709000000b003feee8d4b92sm8517353wmi.47.2023.08.22.08.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 08:33:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, n-francis@ti.com, trini@konsulko.com
Cc: bb@ti.com, praneeth@ti.com, afd@ti.com, Robert Nelson
 <robertcnelson@gmail.com>, vigneshr@ti.com, u-boot@lists.denx.de, Nishanth
 Menon <nm@ti.com>
Subject: Re: [PATCH V3 0/4] board: ti: Add support for BeaglePlay
In-Reply-To: <20230815164440.2713726-1-nm@ti.com>
References: <20230815164440.2713726-1-nm@ti.com>
Date: Tue, 22 Aug 2023 17:33:09 +0200
Message-ID: <87ttsrrt1m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On mar., ao=C3=BBt 15, 2023 at 11:44, Nishanth Menon <nm@ti.com> wrote:

> Add support for BeaglePlay - rev 3
>
> Boot log: https://gist.github.com/nmenon/3e99b44380873263e39ba4d84788db89
>
> Full series(including dependencies) can be found at:
> https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3
>
> Caveats:
> * I have kept networking out of picture for now as it is still in debug
>  (See
>   https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3-enet-d=
ebug
>   if anyone is interested)
>
> Changes since V2:
> * I have rebased to latest next branch
>   bdc682437a67 (origin/next) Merge branch '2023-08-14-assorted-general-up=
dates' into next
> * Uses config fragments by default.
> * Updated MAINTAINER file as well
>
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/
>
> Nishanth Menon (3):
>   arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
>   board: ti: am62x: Add am62x_beagleplay_* defconfigs
>   doc: board: ti: Add BeaglePlay documentation
>
> Robert Nelson (1):
>   arm: dts: Add k3-am625-beagleplay

I tried these series on top of next on my beagleplay with the intention of
booting U-Boot from eMMC.

Base commit: 7e6e40c57233 ("Merge tag 'v2023.10-rc3' into next")

I can't get this to boot. Seems to be stuck in the r5 spl.

Boot log is:

U-Boot SPL 2023.10-rc3-01591-ga4f9ddf99438 (Aug 22 2023 - 17:11:47 +0200)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
SPL initial stack usage: 13400 bytes
Trying to boot from MMC1
mmc_load_image_raw_sector: mmc block read error
Partition 1 invalid on device 0
spl_register_fat_device: fat register err - -1
spl_load_image_fat: error reading image tispl.bin, err - -1
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

It seems that when we try to find tispl.bin, we read from the mmc0boot0
hw partition instead of from the user partition.

Per my understanding, BeaglePlay has the following (simplified) boot
flow:

1. boot rom loads tiboot3 from mmc0boot0
2. tiboot3 loads tispl.bin from mmc(user), first partition (on a FAT filesy=
stem)
3. tispl loads u-boot.img from mmc(user), first partition (on a FAT filesys=
tem)

With the folllowing diff, I can boot all the way to U-Boot proper:

diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beaglepl=
ay_a53.config
index 4889e1bc6f2b..d59a3ca6926e 100644
--- a/board/ti/am62x/beagleplay_a53.config
+++ b/board/ti/am62x/beagleplay_a53.config
@@ -18,3 +18,8 @@ CONFIG_SPI=3Dn
 CONFIG_SPI_FLASH=3Dn
 CONFIG_SPL_DM_SPI_FLASH=3Dn
 CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
+
+CONFIG_SUPPORT_EMMC_BOOT=3Dy
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=3D0
diff --git a/board/ti/am62x/beagleplay_r5.config b/board/ti/am62x/beaglepla=
y_r5.config
index ce64561bee92..239d0d6a55bd 100644
--- a/board/ti/am62x/beagleplay_r5.config
+++ b/board/ti/am62x/beagleplay_r5.config
@@ -9,3 +9,8 @@ CONFIG_SPI=3Dn
 CONFIG_SPI_FLASH=3Dn
 CONFIG_SPL_DM_SPI_FLASH=3Dn
 CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
+
+CONFIG_SUPPORT_EMMC_BOOT=3Dy
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=3Dy
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=3D0

The above is probably not the proper way of doing things, but it seems
to resolve my booting issue.

>
>  arch/arm/dts/Makefile                         |    2 +
>  .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  172 ++
>  arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
>  arch/arm/dts/k3-am625-r5-beagleplay.dts       |   87 +
>  arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
>  board/ti/am62x/MAINTAINERS                    |    7 +
>  board/ti/am62x/beagleplay_a53.config          |   20 +
>  board/ti/am62x/beagleplay_r5.config           |   11 +
>  doc/board/ti/am62x_beagleplay.rst             |  121 +
>  doc/board/ti/k3.rst                           |    1 +
>  11 files changed, 3376 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
>  create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>  create mode 100644 doc/board/ti/am62x_beagleplay.rst
>
> --=20
> 2.40.0
