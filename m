Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F2C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 18:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DE786C8C;
	Sun, 10 Sep 2023 20:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W7iDZ2A2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB9C86C39; Sun, 10 Sep 2023 20:24:59 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9746486BFE
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 20:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ab3aceaf2aso2654800b6e.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694370295; x=1694975095;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8f8NZUQsOxgk4pQjJLMndC3D775L/41GMIatGSh9WE=;
 b=W7iDZ2A2p/QPkdHGuFFFY5Cyu8n6V27pekjXtLn/ffIkiOg7lMEQSL8HA9yH7mHhjP
 +SnxBUZAoaXO4l72x2vie8jjoGIx/4p6aEbpYj8HUah5lF0JfrGW7SWILEQkjPpsxMRF
 wemZQNG+iAikC48MPYPeEz7ubsqWjmb3gf8AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694370295; x=1694975095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8f8NZUQsOxgk4pQjJLMndC3D775L/41GMIatGSh9WE=;
 b=ONN6R1QW8iutCJgzLWxTkkYNA77pR+f8iSYslmR2qQkKQfRTYk73UNfAXa1G5hzX7D
 Pr1nA8wuY6Lbg4M1zBPrwHIew3Kg9a6LwVotYPVhP5f7+mk/hwvE3kU+iIjDb98LgnEM
 OUn7KzvvXenTFknpLNeXLOsSquvO9VgeF+9h/N3RfraIDXgN7X9yFhacHrHg1gNZ39Pl
 1Xc/zI14+McKHU/Mn4N/s3dAEmTl42Y4Y5gtrdGPlYFBtD9lEfU+pxfQqAzsbttOBaiI
 lnfusMSv3s3VdenNryqn+fYXEtnXhRT97iVYh6bBjARD/kgjYm9b+PT6Lt7+HtBvNhnL
 Gdbw==
X-Gm-Message-State: AOJu0YyZFjEu0qnPR4U4DVCO/wzEwbb3qogRdx8c0BaENmIehaXvtBSh
 y2MD+a7M3zL4DKeQ7gF3Qd0zmg==
X-Google-Smtp-Source: AGHT+IGDkUpuw5GEVmC84liARrNQQFVODRvfQtHi13K9aMrCXXlCGhWPVlstNUlToKpzlEvK1+3xoQ==
X-Received: by 2002:aca:1202:0:b0:3a4:894a:9f3d with SMTP id
 2-20020aca1202000000b003a4894a9f3dmr9614638ois.41.1694370295206; 
 Sun, 10 Sep 2023 11:24:55 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a655c85000000b0055b61cd99a1sm3720593pgt.81.2023.09.10.11.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 11:24:54 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 0/4] support for booting the compressed U-boot binary on
 Rockchip based ARM64 SOC's
Date: Sun, 10 Sep 2023 23:54:44 +0530
Message-Id: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

This patchset adds the support on Rockchip based ARM64 SOC's that  compress the U-BOOT proper along with dtb
and ATF in FIT image format.Second stage bootloader(SPL) loads the compressed binaries, uncompress
them and  handover control to the next stage.

Changes for V3 :-

1. Replaced spl_decompression_enabled() function instead of checking IS_ENABLED(CONFIG_SPL_GZIP)
   and IS_ENABLED(CONFIG_SPL_LZMA) in spl_fit.c

2. Removed extra wrapping parentheses in spl_decompression_enabled().

Size Comparision between compressed and uncompressed binaries :-

       size of uncompressed binary    :- 9.0M (94,21,824 bytes)
         manoj:u-boot$ ls -lb u-boot-rockchip.bin
        -rw-rw-r-- 1 manoj manoj 9421824 Sep 10 22:22 u-boot-rockchip.bin

       size of GZIP compressed binary :- 8.6M (89,85,088 bytes)
         manoj:u-boot$ ls -lb u-boot-rockchip.bin
         -rw-rw-r-- 1 manoj manoj 8985088 Jul 25 07:42 u-boot-rockchip.bin

       size of LZMA compressed binary :- 8.6 M (90,06,592 bytes)
         manoj:u-boot$ ls -lb u-boot-rockchip.bin
         -rw-rw-r-- 1 manoj manoj 9006592 Jul 25 07:47 u-boot-rockchip.bin

Test results of  Booting time using bootstage command in Uboot command prompt on roc-rk3399-pc board :-

1) Uncompressed U-BOOT : Total boot time ≈ 12.063971 seconds
=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  1,833,884  1,833,884  board_init_f
  2,959,528  1,125,644  board_init_r
  5,224,521  2,264,993  eth_common_init
  5,523,428    298,907  eth_initialize
  5,523,606        178  main_loop
  5,523,764        158  usb_start
 12,063,971  6,540,207  cli_loop

2) GZIP Compressed U-BOOT : Total time ≈ 12.824968 seconds

=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  2,594,709  2,594,709  board_init_f
  3,719,969  1,125,260  board_init_r
  5,985,450  2,265,481  eth_common_init
  6,284,371    298,921  eth_initialize
  6,284,549        178  main_loop
  6,284,708        159  usb_start
 12,824,968  6,540,260  cli_loop

3) LZMA Compressed U-BOOT : Total time ≈ 17.025004 seconds

=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  6,852,254  6,852,254  board_init_f
  7,940,143  1,087,889  board_init_r
 10,190,458  2,250,315  eth_common_init
 10,487,254    296,796  eth_initialize
 10,487,432        178  main_loop
 10,487,590        158  usb_start
 17,025,004  6,537,414  cli_loop


As per suggestion from Mr.Jonas Karlman (jonas@kwiboo.se) through Patchset V2,that check boot time
with enabling CONFIG_SPL_FIT_SIGNATURE that might impact boot time.

Tried to check the boot time with CONFIG_FIT_SIGNATURE enabled, I didnt find any significant
boot time improvement  with enabling CONFIG_SPL_FIT_SIGNATURE.

Comparision of GZIP and LZMA compressed U-boot Boot time with and without Enable of CONFIG_FIT_SIGNATURE :-

- GZIP Compressed U-BOOT  and CONFIG_FIT_SIGNATURE enabled  :-  Total time ≈ 13.283998 seconds

=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  3,052,571  3,052,571  board_init_f
  4,179,787  1,127,216  board_init_r
  6,445,472  2,265,685  eth_common_init
  6,744,416    298,944  eth_initialize
  6,744,593        177  main_loop
  6,744,751        158  usb_start
 13,283,998  6,539,247  cli_loop

- GZIP Compressed U-BOOT and CONFIG_FIT_SIGNATURE disabled  :- Total time ≈ 12.824968 seconds


- LZMA Compressed U-BOOT  and CONFIG_FIT_SIGNATURE enabled  :-  Total time ≈ 17.005996 seconds

   => bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  6,775,071  6,775,071  board_init_f
  7,902,443  1,127,372  board_init_r
 10,167,546  2,265,103  eth_common_init
 10,466,418    298,872  eth_initialize
 10,466,595        177  main_loop
 10,466,753        158  usb_start
 17,005,996  6,539,243  cli_loop

- LZMA Compressed U-BOOT  and CONFIG_FIT_SIGNATURE disabled  :- Total time ≈ 17.025004 seconds

Manoj Sai (4):
  spl: fit: support for booting a GZIP-compressed U-boot binary
  spl: fit: support for booting a LZMA-compressed U-boot binary
  rockchip: Add support to generate GZIP compressed U-boot binary
  rockchip: Add support to generate LZMA compressed U-boot binary

 arch/arm/dts/rockchip-u-boot.dtsi | 11 +++++++++++
 common/spl/spl_fit.c              | 20 +++++++++++++++++---
 include/spl.h                     | 10 ++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

--
2.25.1

