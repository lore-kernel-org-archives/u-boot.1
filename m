Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97F5CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 19:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B92D865AB;
	Sun, 17 Sep 2023 21:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YxwvRtRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8969F865A2; Sun, 17 Sep 2023 21:26:41 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093EC863E5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 21:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c451541f23so5719305ad.2
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694978797; x=1695583597;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT0ch5GpF3wBu/SgOUHKc8/CIewsySlnvcw9Dd8Lgsc=;
 b=YxwvRtRejtAVG8RxLvP5GC38symtQ6rqawz0d2/GUQhNZxms3IJMyLOA8vOoN5RDfP
 RfrpoAyAc+vbZdwq/gpnhTrDXZT5+T1hk9lkXgn5TjhrnGL2dogD2jnIXZtQaxUngHc7
 KDZLaLCCOXja/ckfSTeD6MChPlCK7ZaNp/RYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694978797; x=1695583597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XT0ch5GpF3wBu/SgOUHKc8/CIewsySlnvcw9Dd8Lgsc=;
 b=PGYynJle9vmGuIhHBqlM3JDa5ujYU11T11sjUF1UTajR52utuT0YJOM8H1/RpSCbnc
 2EVVSeZ4uNbc2uxrpR/JCYyI6W+TA3kPZc5wSGURV3In901cO9osWDIzWi0vN1w3xHhU
 oyqGAduTFPy9rnk9f3DvmK1oj4sChEN5p3S9zCJGp8rdQheCbZB4CEuhc1fQa8uQtTA6
 kfTaNLIlP+CkeXAvbCryWyA8iIvld6TTKWjPdx4mRM5OCX3BtSDNOva/w0ROVUW+1a25
 teVliipmpU1WpUNqlo6faG+X/jqXEej+D91vKIRxVyvaSSAMmf89nJNfhEMplqFdfV/l
 PPQQ==
X-Gm-Message-State: AOJu0YyrarQHnR51eIIDK4PcBSAKAP8EVzngExX0W+ajijrwVcJcQ4wr
 QfmNzqlo1JeXMwefL2vGy3/zxg==
X-Google-Smtp-Source: AGHT+IETZLLr6Gg+tXrqmk+/ilB63Nhw2pl+6isNDirbMGDggAFDubk8w1qFkD2/CMm9ADa78b+S2g==
X-Received: by 2002:a17:902:c24d:b0:1bd:edac:af44 with SMTP id
 13-20020a170902c24d00b001bdedacaf44mr5420812plg.51.1694978797289; 
 Sun, 17 Sep 2023 12:26:37 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.54])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a170903044700b001b83e624eecsm6976991plb.81.2023.09.17.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 12:26:36 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v4 0/4] support for booting the compressed U-boot binary on
 Rockchip based ARM64 SOC's
Date: Mon, 18 Sep 2023 00:56:24 +0530
Message-Id: <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
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

This patchset adds the support on Rockchip based ARM64 SOC's that  compress the U-BOOT proper along with dtb
and ATF in FIT image format.Second stage bootloader(SPL) loads the compressed binaries, uncompress
them and  handover control to the next stage.

Changes for V3 :-

1. Replaced spl_decompression_enabled() function instead of checking IS_ENABLED(CONFIG_SPL_GZIP)
   and IS_ENABLED(CONFIG_SPL_LZMA) in spl_fit.c.

2. Removed extra wrapping parentheses in spl_decompression_enabled().

Changes for V4 :-

1. As per the suggestion from Mr.Jonas Karlman (jonas@kwiboo.se) from  PATCH v2 and v3 ,check boot time
   with the following RFC patch  with CONFIG_SPL_FIT_SIGNATURE enabled that might impact boot time and
   As seen there is an improvement in boot time with both compress enabled and disabled ,
   I have added the logs of it below.

    [RFC] rockchip: spl: Enable caches to speed up checksum validation
    https://patchwork.ozlabs.org/project/uboot/patch/20230702110055.3686457-1-jonas@kwiboo.se/

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

1) Uncompressed U-BOOT : Total boot time = 12.063971 seconds
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

2) GZIP Compressed U-BOOT : Total time = 12.824968 seconds

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

3) LZMA Compressed U-BOOT : Total time = 17.025004 seconds

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



Test results of  booting time using RFC patch from Mr.Jonas Karlman(jonas@kwiboo.se)
with CONFIG_SPL_FIT_SIGNATURE enabled  on  roc-rk3399-pc board :-

1. Uncompressed U-BOOT : Total boot time =  10.728 seconds
=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
    477,024    477,024  board_init_f
  1,623,670  1,146,646  board_init_r
  3,889,493  2,265,823  eth_common_init
  4,188,402    298,909  eth_initialize
  4,188,579        177  main_loop
  4,188,738        159  usb_start
 10,728,000  6,539,262  cli_loop

2. GZIP Compressed U-BOOT : Total time =  10.708 seconds
=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
    457,663    457,663  board_init_f
  1,604,222  1,146,559  board_init_r
  3,869,505  2,265,283  eth_common_init
  4,168,410    298,905  eth_initialize
  4,168,587        177  main_loop
  4,168,745        158  usb_start
 10,707,997  6,539,252  cli_loop

3. LZMA Compressed U-BOOT : Total time =   10.86 seconds
=> bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
    612,427    612,427  board_init_f
  1,756,176  1,143,749  board_init_r
  4,021,522  2,265,346  eth_common_init
  4,320,433    298,911  eth_initialize
  4,320,610        177  main_loop
  4,320,768        158  usb_start
 10,860,001  6,539,233  cli_loop

As I can seen there is an improvement in boot time with Enable caches in SPL to speed up FIT checksum validation,
with the following RFC patch from  Mr.Jonas.
[RFC] rockchip: spl: Enable caches to speed up checksum validation
https://patchwork.ozlabs.org/project/uboot/patch/20230702110055.3686457-1-jonas@kwiboo.se/

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

