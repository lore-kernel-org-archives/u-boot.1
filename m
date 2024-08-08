Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942D3C52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 08:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20C88851E;
	Thu,  8 Aug 2024 10:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o2DMKcj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0893688A77; Thu,  8 Aug 2024 10:50:06 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC820881E7
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 10:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so90103066b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723106999; x=1723711799;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7nWOvPk3exV8lRZUE8rg9Vp4KBRzI7PNGaXxg3ikxHg=;
 b=o2DMKcj2810BVyFDSNjFQFd/OWhyIMTrPsqSmBrwHUgOZhqqwliWHp8rZ1O3mThy0I
 ZlSU/jMYDwmVd2kIz/8uUjJ5c3vPg9CujKIsLC4YxHIbYHk2UObb8dOA29/aaq3bUGEo
 UKb0tdl11STZZJS7roC6a6Soa5taoiYW+R7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723106999; x=1723711799;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nWOvPk3exV8lRZUE8rg9Vp4KBRzI7PNGaXxg3ikxHg=;
 b=oPmix1EYPfjj/6dPAF0sMkzyN+Ni8X7xFwmvympMXaDCU+CYQGGfSSQlScfHXIyocN
 DZjq3A1FYJEdBJ+hEHXcnjBdZk58FIEJXYTqysRNwJU5hMdxUg+vUdA37CRDw7aIznnd
 J1mJAdsHH+RjrQl1/PVbVd8Phqw0g155kIQKcCn//WDiU7ow0kfw4d4GGk50lKYnVgG1
 FBzq9oM9EWVmyrzGnbYyZgYUR+2lpwcBwqC40hsZzid+ezo8WJQ15RNQkGA9KGC1bdIr
 6qTuHBaEZe+a4NYcR1J6c39HU3CYbKITsSEuV97elFUf9bra9VQv8N6H5P/g2fX8Jgkj
 jBLw==
X-Gm-Message-State: AOJu0YygUGJGnL0EuaESF9c4Di8XCYCeWQm5CLLf5V1RUAthFzNDTzVt
 6PvO9Leg4dQrsM1RgwYz0HN1FkML4JuZh7mjHUG32CXf5RTsqu1OWxBhyzoyQWq6RbiGMWcZJOu
 t/CFjK1lhopPLBKduDLK7pm28omcGzZZUSGjWBGwg+09ZrMTq00c=
X-Google-Smtp-Source: AGHT+IHPccQvDD/Ynl8UInobhIX+dGJBoomvu1YwHXM88BfI+Vi8LC0gmv2tilNBFKwQrkmIkCXE8JXCzekqgUDZaBk=
X-Received: by 2002:a17:907:f160:b0:a7a:be06:d8e7 with SMTP id
 a640c23a62f3a-a8090e9dbedmr85707766b.44.1723106999285; Thu, 08 Aug 2024
 01:49:59 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 8 Aug 2024 10:49:48 +0200
Message-ID: <CAOf5uwk7LP3T79P7qP0DsTKR7WOjq68y7y6QCvC9P=UPgU6-0w@mail.gmail.com>
Subject: [PULL] Pull request for u-boot-nand-20240808
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
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

Hi Tom

The following changes since commit b7d5ce05b1b52136af09cf34541c6a91079a4b86:

  Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06
09:36:46 -0600)

are available in the Git repository at:

  git://source.denx.de:u-boot/custodians/u-boot-nand-flash.git/
u-boot-nand-20240808

for you to fetch changes up to 855f9b6241407d19f01d4245456be428b5d88f52:

  spinand: bind UBI block (2024-08-08 09:28:09 +0200)
----------------------------------------------------------------

This series adds support for the UBI block device, which allows to read/write
data block by block. The series was tested by Alexey Romanov on SPI NAND.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/21933

----------------------------------------------------------------
Alexey Romanov (9):
      disk: support MTD partitions
      drivers: introduce mtdblock abstraction
      spinand: bind mtdblock
      ubi: allow to read from volume with offset
      ubi: allow to write to volume with offset
      drivers: introduce UBI block abstraction
      disk: don't try search for partition type if already set
      disk: support UBI partitions
      spinand: bind UBI block

 cmd/ubi.c                   |  78 +++++++++++++--
 disk/part.c                 |  10 +-
 drivers/block/blk-uclass.c  |   2 +
 drivers/mtd/Kconfig         |   9 ++
 drivers/mtd/Makefile        |   1 +
 drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c       |  76 +++++++++++++++
 drivers/mtd/nand/spi/core.c |  29 ++++++
 drivers/mtd/ubi/Kconfig     |   7 ++
 drivers/mtd/ubi/Makefile    |   1 +
 drivers/mtd/ubi/block.c     | 130 +++++++++++++++++++++++++
 drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++
 env/ubi.c                   |  16 ++--
 include/linux/mtd/mtd.h     |  25 +++++
 include/part.h              |   5 +
 include/ubi_uboot.h         |  13 ++-
 16 files changed, 711 insertions(+), 17 deletions(-)
 create mode 100644 drivers/mtd/mtdblock.c
 create mode 100644 drivers/mtd/ubi/block.c
 create mode 100644 drivers/mtd/ubi/part.c

-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
