Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E9C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 937A986EF6;
	Sun, 19 Nov 2023 15:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WOCnz/TC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9793086EF6; Sun, 19 Nov 2023 15:43:52 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E7F86EF6
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3594c100735so8773175ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405028; x=1701009828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gDDuSb6z5LoAjT4G5HlvqsQ80XrpG+/Ef3l8jhXaeRU=;
 b=WOCnz/TCIfNIF0fF6PzGKYcMERtPEvODYH4KT7Kg4MuWrdViXkc43Yaeoj82I1WnlH
 kz6m2EW+fgRSFOunqnwWePaF8ljtEvmCKIOZoic23b//DPsGDNkyIaTNpIousW3Cu5SV
 so9bOHzfIC+ezkCJzYZ6sOTEfqL52wKRLM4XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405028; x=1701009828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gDDuSb6z5LoAjT4G5HlvqsQ80XrpG+/Ef3l8jhXaeRU=;
 b=dQAkRPeBfTy5LRpHcuQLzsCyzjnKxCZfb2RU/5z0+U8eSe0gPyHz0/1sSSu+fO78EF
 fViQ0CTAhP+K8RzLN3nfbE2XwszXaCko1tCCdszk7dbrU5yhSSPIBYrOIX/Kogbe7+Zk
 4bVI/w2PdD3L+zq/LToFEmGnO4Ztryo0oQ0Hb4qj87Ap7TI2JKAQZ/MnZG7nFbRVevck
 cQgHRUdPxnbcGuXW8OxvzTK02S+7WzA2ViupHatXsMSrTsrmZUcQil1pdyCIO7jpqQzV
 OKdHivu1sqBuOsASc5svJ7jjPecI0XmCWmlGLh1ztKtU6af+k+2T6/tkO7o+VApv/PDK
 pB2Q==
X-Gm-Message-State: AOJu0YxnbXsr8qJh5QA7CEeokO7Vnh95XQ5YHug7NOyQl7mXn6vqxPAG
 a3FGnTVwAAqfaDY5LPubd8F/QH1Rr/ekzfqbhs4IJQ==
X-Google-Smtp-Source: AGHT+IGTxYh6TGsnHSJMnAAP2wH1AxOcn/VIld3l777Nco8Y3Lu2ihInO0iXDEi8JSyaxQda8ZyuoA==
X-Received: by 2002:a92:3301:0:b0:359:31a1:4702 with SMTP id
 a1-20020a923301000000b0035931a14702mr3295897ilf.6.1700405028223; 
 Sun, 19 Nov 2023 06:43:48 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a023505000000b00463f8b3e34asm1511196jaa.23.2023.11.19.06.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:43:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 0/4] bootm: Handle compressed arm64 images with bootm
Date: Sun, 19 Nov 2023 07:43:30 -0700
Message-ID: <20231119144338.630138-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

This little series corrects a problem I noticed with arm64 images,
where the kernel is not recognised if compression is used:

   U-Boot> tftp image.fit
   Using ethernet@7d580000 device
   TFTP from server 192.168.4.7; our IP address is 192.168.4.147
   Filename 'image.fit'.
   Load address: 0x1000000
   Loading: ##################################################  23 MiB
   	 20.5 MiB/s
   done
   Bytes transferred = 24118272 (1700400 hex)
   U-Boot> bootm
   ## Loading kernel from FIT Image at 01000000 ...
      Using 'conf-768' configuration
      Trying 'kernel' kernel subimage
        Description:  Linux
        Type:         Kernel Image (no loading done)
        Compression:  gzip compressed
        Data Start:   0x01000120
        Data Size:    13662338 Bytes = 13 MiB
      Verifying Hash Integrity ... OK
   Bad Linux ARM64 Image magic!

With this series:

   U-Boot> tftp 20000000 image.fit
   Using ethernet@7d580000 device
   TFTP from server 192.168.4.7; our IP address is 192.168.4.147
   Filename 'image.fit'.
   Load address: 0x20000000
   Loading: ##################################################  23.5 MiB
   	 20.8 MiB/s
   done
   Bytes transferred = 24642560 (1780400 hex)
   U-Boot> bootm 0x20000000
   ## Loading kernel from FIT Image at 20000000 ...
      Using 'conf-768' configuration
      Trying 'kernel' kernel subimage
        Description:  Linux
        Type:         Kernel Image (no loading done)
        Compression:  zstd compressed
        Data Start:   0x20000120
        Data Size:    14333475 Bytes = 13.7 MiB
      Verifying Hash Integrity ... OK
   Using kernel load address 80000
   ## Loading fdt from FIT Image at 20000000 ...
      Using 'conf-768' configuration
      Trying 'fdt-768' fdt subimage
        Description:  Raspberry Pi 4 Model B
        Type:         Flat Device Tree
        Compression:  zstd compressed
        Data Start:   0x215f820c
        Data Size:    9137 Bytes = 8.9 KiB
        Architecture: AArch64
      Verifying Hash Integrity ... OK
      Uncompressing Flat Device Tree to 3aff3010
      Booting using the fdt blob at 0x3aff3010
   Working FDT set to 3aff3010
      Uncompressing Kernel Image (no loading done) to 80000
   Moving Image from 0x80000 to 0x200000, end=2b00000
      Using Device Tree in place at 000000003aff3010, end 000000003afff4c4
   Working FDT set to 3aff3010

   Starting kernel ...

   [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]

The problem is that the arm64 magic is checked before the image is
decompressed. However this is only part of it. The kernel_noload image
type doesn't work with compression, since the kernel is not loaded. So
this series deals with that by using an lmb-allocated buffer for the
uncompressed kernel.

Another issue is that the arm64 handling is done too early, before the
image is loaded. This series moves it to after loading, so that
compression can be handled.

A patch is included to show the kernel load-address, so it is easy to
see what is going on.

One annoying feature of arm64 is that the image is often copied to
another address. It might be possible for U-Boot to figure that out
earlier and decompress it to the right place, but perhaps not.

With all of this it should be possible to boot a compressed kernel on
any of the 990 arm64 boards supported by Linux, although I have only
tested two.

Changes in v3:
- Rebase on to bootm-refactoring series
- Support compression with an lmb-allocated region
- Drop patch to disallow kernel_noload with compression
- Drop patch 'bootm: Allow omitting the load address'

Changes in v2:
- Rework the patch based on a better understanding of events
- Add a 'success' case to the cover letter
- Redo how the arm64 support is implemented

Simon Glass (4):
  image: Correct load_bug typo
  image: Show the load address when decompressing
  bootm: Move arm64-image processing later
  bootm: Support kernel_noload with compression

 boot/bootm.c    | 63 +++++++++++++++++++++++++++++++++++--------------
 boot/image.c    | 13 ++++++----
 include/image.h |  2 +-
 3 files changed, 55 insertions(+), 23 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

