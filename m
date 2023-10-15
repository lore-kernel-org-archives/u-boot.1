Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B15CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4538692B;
	Mon, 16 Oct 2023 00:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROvPrp11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D73886940; Mon, 16 Oct 2023 00:30:13 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D744803AC
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e16f076b3so6915748a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409003; x=1698013803; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0A9SBabl2K2Up6gZJx7gFSsvpRvPlL+YY1T3jqXqs8=;
 b=ROvPrp11z7J0aYJA9uek8nf6Sg5MvWGKxYeT7Iu9GCbR88aHbsOeufiJgAypCeml/I
 d0yojwrvu7Tk4crMm2N4Cuf03J+krb3TG+5/yIWY2fPUBXnH7ealwzhtHJHCC3x8Z7Jr
 kRD8RKdAWVdC2+P5o00RCeSDrnq3v62SM/hQpmJrfqxgHXPfxvCsQc079cnH4SdExy7o
 cVivcBunTA6lvxnu8QRsmMukhJEVMDo7CrtZOmWLahHZGjkeM3YyBHCfeinbHPCcLH6I
 DnQfq0p8L7A6L3DI0Fyjdms+Y8CBTZ8gClfe9Be92d9mooYg5QsII8Cqcdhet1/TcpXA
 kA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409003; x=1698013803;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z0A9SBabl2K2Up6gZJx7gFSsvpRvPlL+YY1T3jqXqs8=;
 b=cX27R4QN4w8jys8RG7yLE8CRZKDn0aYrbFv+zEjuyhvniQe/HM2KgEgY5KlER0jzq5
 W3m24Lmd8ycNi21M/Ads5HvdF3sE6CdwZgUuRob6QhP6j0c8/yIFolvgm9n4j3bFJlOB
 F3kY7uwiHSk7swzpBEhk5wzvsGDER2AqTRIt6DXK4wggOUYTLbjy+AY1/RtR3dEtO9TF
 OgkAhMBGrBb8o/K/XZ3HZAYvaplDuvdHr8k22SkCJvsT9nHiVnTnd1Q4BTA8Xxrjd/r+
 HB7RWtcaK+7XLjkQIim2dbrfyLYBLI73yiERYClw35zDZWSUaocVZleSRVCIP8leIdDM
 EKaA==
X-Gm-Message-State: AOJu0YwpJ8cXJoDCWGWNdZBLp8HAMaHhdc00YYkfJCE6eJcoLTFPMY8C
 GaL2U8Mhg1jPUGNidUVwsxE=
X-Google-Smtp-Source: AGHT+IE564hCWcSqX5Wnx8em2r/pXSRBqb78R8+dqsgix9GH8BeyhIInmw8rZD6YLkgfa7StUMG7qA==
X-Received: by 2002:a50:c318:0:b0:533:c3d9:767a with SMTP id
 a24-20020a50c318000000b00533c3d9767amr5506429edb.3.1697409002538; 
 Sun, 15 Oct 2023 15:30:02 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a056402101a00b00533e915923asm14395825edu.49.2023.10.15.15.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:30:02 -0700 (PDT)
Message-ID: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Date: Mon, 16 Oct 2023 00:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 0/8] Add rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The command rkmtd creates a virtual block device to transfer
Rockchip boot block data to and from NAND with block orientated
tools like "ums" and "rockusb".

It uses the Rockchip MTD driver to scan for boot blocks and copies
data from the first block in a GPT formatted virtual disk.
Data must be written in U-boot "idbloader.img" format and start at
partition "loader1" offset 64. The data header is parsed
for length and offset. When the last sector is received
it erases up to 5 erase blocks on NAND and writes boot blocks
in a pattern depending on the NAND ID. Data is then verified.
When a block turns out bad the block header is discarded.

Changed V4:
  Sort includes
  Replace constant by define
  Enable rkmtd command in sandbox defconfig
  Fix minor things in test

Changed V3:
  Add documetation
  Add test
  Split driver from command
  Split header
  Use devm_kzalloc
  Remove out of memory debug
  Restyle

Changed V2:
  Rename to rkmtd

Johan Jonker (8):
  mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN option
  rockchip: dm: prepare rkmtd UCLASS
  rockchip: block: add rkmtd class and drivers
  rockchip: block: blk-uclass: disable bounce buffer support for rkmtd
  rockchip: cmd: add rkmtd command
  rockchip: test: dm: add rkmtd test
  rockchip: doc: add rkmtd.rst
  rockchip: configs: sandbox: enable rkmtd command

 cmd/Kconfig                         |    8 +
 cmd/Makefile                        |    1 +
 cmd/rkmtd.c                         |  204 +++++
 configs/sandbox64_defconfig         |    1 +
 configs/sandbox_defconfig           |    1 +
 disk/part.c                         |    4 +
 doc/board/rockchip/index.rst        |    1 +
 doc/board/rockchip/rkmtd.rst        |  105 +++
 drivers/block/Kconfig               |    7 +
 drivers/block/Makefile              |    2 +
 drivers/block/blk-uclass.c          |    7 +-
 drivers/block/rkmtd.c               | 1135 +++++++++++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig        |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c |    3 +
 include/dm/uclass-id.h              |    1 +
 include/rkmtd.h                     |  191 +++++
 test/dm/Makefile                    |    1 +
 test/dm/rkmtd.c                     |  200 +++++
 18 files changed, 1878 insertions(+), 3 deletions(-)
 create mode 100644 cmd/rkmtd.c
 create mode 100644 doc/board/rockchip/rkmtd.rst
 create mode 100644 drivers/block/rkmtd.c
 create mode 100644 include/rkmtd.h
 create mode 100644 test/dm/rkmtd.c

--
2.39.2

