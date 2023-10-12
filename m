Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD41CCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 20:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A400986B18;
	Thu, 12 Oct 2023 22:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A++Nl6gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F5B86B36; Thu, 12 Oct 2023 22:49:39 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7270484003
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so2532009a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143771; x=1697748571; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jc5d+on9l1HY694SQifPzaYJgKufqWgp9ash1w47VT8=;
 b=A++Nl6gkLILQvv2kwhSQdvukdhf6vPrd8UqoIN3/pD9sa/RhS/aKpB6KINMkh/4d8F
 Xy4uCTF9jYSF0GzjgueIrzrbEzzR2RCDDN28lZwenfXJmpQDl28mHhSat3tZ77v4zE4E
 wgaOpvrC7yC0Bpz0cEa+cmt6GIMu3KO/yvIribUyYQmzOM8QEmFU6+m0uqTF/z7PClSv
 OyUiSZAK0BhV0IOArqhHmQmoKjf8fozIC9LCx/zVRSVknDE9Zs8n2Th/EPUBm6MLrYl3
 sY4hdh5VJy0chrfBTdoTF1hGx/SZi4su6uswM1Liv7MVK7r4Uv6Ge88a3oua/KoiO4NG
 NoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143771; x=1697748571;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jc5d+on9l1HY694SQifPzaYJgKufqWgp9ash1w47VT8=;
 b=Ma66GGegmGDTGSbB9hF3WF6gOdvW/7T/OLOFNIzXNji1RlIU0XnIw0viV6QIJvFUqN
 mS6rz2o3Gy+0hg1OQ+AbzjJwgfyv5hFjPWrfYOyZFhP1KYCdKxaG/Vfvf2ni8jZy12bX
 gvFo+eb/+Ke8TUc0lQkxOOhFHRyfNXlw53bKSbMmnHvb489YhHsv1ae8HmVP/BvSKg/x
 m0RLkkbyd9JJmk2WoDLE6fYQXpf5fv9aLn3gz99Ch+BYwKJEPLXmuj7Arv8x++L9OxpP
 cvIFwL8roGgUz2/EyV/+xpqpgq2T077+dWdHddhU6UqC+Kn+Y65hiq8kly0VaBZ9LVi5
 dmBw==
X-Gm-Message-State: AOJu0YxyS1Eos52Dd1+qxS5lm71arabf1zyX7QYTwj2HF2MW5lUll+lf
 58fEpJYNzP6motv0uTVsojg=
X-Google-Smtp-Source: AGHT+IEtyaBtXC/JUdYJeP0E2ENTPfYEqeBo6d3dnawnGlkSFJQJDiHcK2RSBNEE0UUWzxeSeIj6GA==
X-Received: by 2002:a17:906:3050:b0:9b2:be5e:7545 with SMTP id
 d16-20020a170906305000b009b2be5e7545mr21370658ejd.36.1697143770613; 
 Thu, 12 Oct 2023 13:49:30 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 kf24-20020a17090776d800b009b95787eb6dsm11412922ejc.48.2023.10.12.13.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:49:30 -0700 (PDT)
Message-ID: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Date: Thu, 12 Oct 2023 22:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 0/7] Add rkmtd command
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

Johan Jonker (7):
  mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN option
  rockchip: dm: prepare rkmtd UCLASS
  rockchip: block: add rkmtd class and drivers
  rockchip: block: blk-uclass: disable bounce buffer support for rkmtd
  rockchip: cmd: add rkmtd command
  rockchip: test: dm: add rkmtd test
  rockchip: doc: add rkmtd.rst

 cmd/Kconfig                         |    8 +
 cmd/Makefile                        |    1 +
 cmd/rkmtd.c                         |  204 +++++
 disk/part.c                         |    4 +
 doc/board/rockchip/index.rst        |    1 +
 doc/board/rockchip/rkmtd.rst        |  105 +++
 drivers/block/Kconfig               |    7 +
 drivers/block/Makefile              |    2 +
 drivers/block/blk-uclass.c          |    7 +-
 drivers/block/rkmtd.c               | 1138 +++++++++++++++++++++++++++
 drivers/mtd/nand/raw/Kconfig        |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c |    3 +
 include/dm/uclass-id.h              |    1 +
 include/rkmtd.h                     |  190 +++++
 test/dm/Makefile                    |    1 +
 test/dm/rkmtd.c                     |  201 +++++
 16 files changed, 1879 insertions(+), 3 deletions(-)
 create mode 100644 cmd/rkmtd.c
 create mode 100644 doc/board/rockchip/rkmtd.rst
 create mode 100644 drivers/block/rkmtd.c
 create mode 100644 include/rkmtd.h
 create mode 100644 test/dm/rkmtd.c

--
2.39.2

