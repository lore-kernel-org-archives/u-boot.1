Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC5CDB484
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F3186F9F;
	Wed, 18 Oct 2023 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQb4mAEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0616286F9F; Wed, 18 Oct 2023 15:58:46 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20DA786F79
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso1111819266b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637523; x=1698242323; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EGyId9pkgeq6Os8uZDOlExLF2pqrQN5eJax9d5WZf4=;
 b=AQb4mAEJJryFsnu25XEkad+wXlKTDCLynSisDq4jexBhUJ/RG8SUowKioAcwe+11Y6
 EwaYvQq1wiABcaJOoZjZhIrI+x5swudFySTr6CrhSdTbEu+rg7PQZJh0JP12T13CSOFF
 A+YCrLt2FTifLlYV7WoOA+BterIDeJ7C9Y2S/59zjgoDc1+15IFQEzR9r1f17GiulEcW
 KmuvjwyCaRRmNzg2n89Hs295CdRaVtGbVx0waeq+0ZolY52Vfz8KdWxQhCQWhV0+/Zy0
 G8X+eJqtt+dcCzei+oPYqO1hpHShvrI3RdEcle7za9DnqFnD76OMsIZILQWmtBN1tAf1
 BdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637523; x=1698242323;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8EGyId9pkgeq6Os8uZDOlExLF2pqrQN5eJax9d5WZf4=;
 b=VKVGMPsmyBxJkW1DUJZlvxaT6VtgKqmmZ2mDRv2np7nlxSug/PqChRKz+YvRMENJMU
 pg8M0VDR0Q9xZnvNuGZ6BkwwEHu1oQ72C/eoc7Zz0K4n/bg4aEYpPI+RPdvCLP8vI984
 NeE/zCnatqUsnJ0eDRQzpGUSmoBu40Zd7TSL2XGaHpfQCBToA4T6kmQo9npzEgW4Xyd8
 CDArbK9MMabjLQ6ddpsRemuMGGZgfi1qRQbUPyw92h3uWUvq+6MEjAP0Gnx37kC3raRk
 rrPDtQUMELjQsGhvEKbZ3kubVo45nmYTcbs9FYkMyQcDz89l30yWB32Zm0DiU/b3uHOW
 nimg==
X-Gm-Message-State: AOJu0YwYhK/XwnAPqZRW7YBYjxRv/p2RstvM0Xy0IOxvsOK4Azxijs4l
 QZoKA1OiSZ28PqpYNNB4gyQ=
X-Google-Smtp-Source: AGHT+IHu+LvF/jJM8gWCAiHYbQUIBFYz1Va5tL3hc6DHI5JWUf0ESuLQeJx4hWNVEL4XlKeghAWRkQ==
X-Received: by 2002:a17:907:36cd:b0:9a5:a0c6:9e8e with SMTP id
 bj13-20020a17090736cd00b009a5a0c69e8emr4720320ejc.31.1697637523447; 
 Wed, 18 Oct 2023 06:58:43 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170906224200b009c6e58437dasm1759050ejr.37.2023.10.18.06.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:58:42 -0700 (PDT)
Message-ID: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Date: Wed, 18 Oct 2023 15:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 0/8] Add rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
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

Changed V5:
  Add bounce buffer flag
  Use devres_alloc in bind
  Restyle

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
  rockchip: block: blk-uclass: add bounce buffer flag to blk_desc
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
 drivers/block/blk-uclass.c          |    5 +-
 drivers/block/rkmtd.c               | 1152 +++++++++++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig        |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c |    3 +
 drivers/scsi/scsi.c                 |    4 +
 include/blk.h                       |    1 +
 include/dm/uclass-id.h              |    1 +
 include/rkmtd.h                     |  191 +++++
 test/dm/Makefile                    |    1 +
 test/dm/rkmtd.c                     |  200 +++++
 20 files changed, 1899 insertions(+), 2 deletions(-)
 create mode 100644 cmd/rkmtd.c
 create mode 100644 doc/board/rockchip/rkmtd.rst
 create mode 100644 drivers/block/rkmtd.c
 create mode 100644 include/rkmtd.h
 create mode 100644 test/dm/rkmtd.c

--
2.39.2

