Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF06C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13F9835C0;
	Thu, 10 Jul 2025 00:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBrVTB1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6212383616; Thu, 10 Jul 2025 00:29:34 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F75835CE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73a43d327d6so193927a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100170; x=1752704970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWLpE/RdTaRptj9oYJYxU0WFrxh13dkbGO9fD5b0zT0=;
 b=aBrVTB1Lo5anJCCSIsL8MSvQuN2MOxncG3QJBaIUNlmjTZJqXuxhYWA0uh0prcW/1r
 otzvDuS0KkzLW5VNCw3/EqGZ9cEp3gwjRVx+Hw/YWoICtFhaXuZnlf+ynRwdqAIHMh5A
 j9Sgz2iVoYbMx0Ra5o3MgJk0cJnArGk38lRo5aIcTpMr4RKkNVYszX0dGzszemNPGdJV
 bdrRjDZIxHnMM+Maz+KzgtReWHh3Y1MMpSYCDibFeuqB7QoS7gJ94mjeSdSsmnVihhW9
 bnZHtso+1njJiCPyTom7gB3rDK+At3J8VTMjuGQ4rAGrZVTBhzcj2JeIgY2RAbfgHTdo
 9HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100170; x=1752704970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWLpE/RdTaRptj9oYJYxU0WFrxh13dkbGO9fD5b0zT0=;
 b=lbLS1de8er52lclIrOlDoAJXTkV747XkjNb8coi4zhuTpxXb8TWeeRZmlel71jGbhS
 vFVVlDkm96CV6b0BynyrN76c6MlLD2JQw8tswKSuQ4aHCH7wMu/+AHdICqqC5Q2KwDVH
 aAxK7zo//7IwO++kRxYqj/JzOYUeyFWzETm+4MClQd9/y+sHuPuiYbrc55w0fr2ZEXre
 ugT7zBqWm9cbRrk6dPK5PTYqmtjyi6w+BXFpS+iNnWS5KTpABnX6aGY1LyTr+Fl0bV1p
 j+bqKwU9B/nqogdIpHIMOisHd9FAw87Vcgonsd8G4ZxJq5ztaW02dcwI4qhBGcOzS0YP
 aJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXu5hz0JruA/Ah/ljtTEKY8khkw37lckZ8Kpx3qUGl2PcQHKKi7ixWYna9bqpw84wKO9X5M9s=@lists.denx.de
X-Gm-Message-State: AOJu0YwDVgc2M0XF1nD1nQoaSfL4pBUG3wjM9Lrelas1p2aXSmIiRWpx
 1h5amUWCExHnEEVCElQ5dE3/Xihy0JLvw+MViNF03nvW9FJCok4Vx/YX+oyZGRMsesM=
X-Gm-Gg: ASbGncvNFkMDkQraAHyXoSIEC74eDTgZUe+7A8ssG5rD775hqAlJ0sFLeUGhvZ5NIxj
 ul7cpe0MyWrD1Detfai1YXwm4IBmpOinBCtdo5Gw0Mlb3Mvc6smKbsRm4mkp5oH73XEYxBQrgVw
 oHGNtV1RClnKWZuC7rHOY6UhdxFeIC+HnD1dosQsZqtnDqBT45G0EOZyGsLgstSzEfKXhXVcgZT
 dZAr9UBMQc02+UX0felVTh0qaTWUwHpUKs0lFSuvKh/3O3WRqI8FA0qHDHxgghqXwMQKEI+5FMG
 cxSJ9VH5dlp9nOZjA1zCU6xDeSjzeGsjPCRjO4/6Ul/8JnUp0wYmC80N/WEdDShworQPS7/j
X-Google-Smtp-Source: AGHT+IH+FKSZTK8rOJe3nNqFFQ04vG6IORQ+2llk0tXarhZ2lO9JuYON3oqVUzSDEHg9ur0zRzQhNA==
X-Received: by 2002:a05:6830:4987:b0:727:3664:ca28 with SMTP id
 46e09a7af769-73cf04673a5mr338235a34.0.1752100170362; 
 Wed, 09 Jul 2025 15:29:30 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm22438a34.21.2025.07.09.15.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:30 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 4/9] board: samsung: e850-96: Add dfu_alt_info
Date: Wed,  9 Jul 2025 17:29:21 -0500
Message-Id: <20250709222926.24671-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Add 'dfu_alt_info' environment variable which contains:
  - Linux eMMC partitions ('esp' and 'rootfs')
  - eMMC Boot Partition A layout, where all the firmware reside

It makes it possible to update the bootloader (U-Boot). All sizes in
'dfu_alt_info' are given in 512B blocks (LBA). eMMC size is 58.2 GiB.
The eMMC Boot Partition A (mmc0boot0) layout looks like this:

                 boot0 partition (4 MiB)
       0x0 +----------------------------------+
           |         fwbl1 (12 KiB)           |
      0x18 +----------------------------------+
           |         epbl (76 KiB)            |
      0xb0 +----------------------------------+
           |         bl2 (256 KiB)            |
     0x2b0 +----------------------------------+
           |         dram_train (16 KiB)      |
     0x2d0 +----------------------------------+
           |         ect_test (50 KiB)        |
     0x334 +----------------------------------+
           |         acpm_test (130 KiB)      |
     0x438 +----------------------------------+
           |         bootloader (2 MiB)       |
    0x1438 +----------------------------------+
           |         el3_mon (256 KiB)        |
    0x1638 +----------------------------------+

where U-Boot should be flashed into 'bootloader' partition. So U-Boot
binary size should be 2 MiB or less. The whole boot0 partition is 4 MiB,
but only 2.8 MiB is currently used.

With this change, the U-Boot binary can be updated on eMMC like this:

    => dfu 0 mmc 0
    $ dfu-util -D u-boot.bin -a bootloader

Looking at E850-96 booting diagram at [1,2], it's easy to see how these
binaries are being executed in the same order they are placed in
mmc0boot0 area. E.g. fwbl1 is definitely BL1 (software part of Boot
ROM). So it's obvious the ROM code just reads the binary from eMMC at
0x0 offset into RAM (SRAM?) and executes it.

All mentioned images can be found at [3], as stated in E850-96 U-Boot
documentation. 'dram_train', 'ect_test' and 'acpm_test' areas should be
ignored -- they are not flashed with real images.

[1] doc/board/samsung/e850-96.rst
[2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
[3] https://gitlab.com/Linaro/96boards/e850-96/images/-/tree/master/images

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.env | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.env b/board/samsung/e850-96/e850-96.env
index 5ac76bcef027..c76ea6acdc35 100644
--- a/board/samsung/e850-96/e850-96.env
+++ b/board/samsung/e850-96/e850-96.env
@@ -7,5 +7,18 @@ pxefile_addr_r=0x8c200000
 ramdisk_addr_r=0x8c300000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 
+dfu_alt_info=
+	rawemmc raw 0 0x747c000 mmcpart 1;
+	esp part 0 1;
+	rootfs part 0 2;
+	fwbl1 raw 0x0 0x18 mmcpart 1;
+	epbl raw 0x18 0x98 mmcpart 1;
+	bl2 raw 0xb0 0x200 mmcpart 1;
+	dram_train raw 0x2b0 0x20 mmcpart 1;
+	ect_test raw 0x2d0 0x64 mmcpart 1;
+	acpm_test raw 0x334 0x104 mmcpart 1;
+	bootloader raw 0x438 0x1000 mmcpart 1;
+	el3_mon raw 0x1438 0x200 mmcpart 1
+
 partitions=name=esp,start=512K,size=128M,bootable,type=system;
 partitions+=name=rootfs,size=-,bootable,type=linux
-- 
2.39.5

