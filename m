Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8489AC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 05:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECD6884AC;
	Thu, 18 Jul 2024 07:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pw9zYP2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382FC88AEE; Thu, 18 Jul 2024 07:48:30 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35C188354
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77c0b42a8fso258174766b.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721281707; x=1721886507;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFBeE1m+hZsN1quFXrMJZCRlfDvWzytjMMRETRzYe1g=;
 b=pw9zYP2zybpLK23BkUVKUmHmw2AazYPglHDXBCmo6Dc/QQ+65176WyfPiJv442dH4T
 VGhAKEApKdLIFUobSfYw/gW3M/4gYWTtebRaA4LKaAazPqmPZS8IVbTcUsYnSfMwV8c/
 zMGJrOFe7tB9vx2UY3jM9s9epkEYHD5/xQdOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721281707; x=1721886507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFBeE1m+hZsN1quFXrMJZCRlfDvWzytjMMRETRzYe1g=;
 b=ebqHBsIT+vGmbVN4qEQ/uRwwTA9FAb4n8ClxSyWRxdaKCW2vYeFj+xllwVKdYrERD/
 4F+TbUjo6kCp5ZqlIp5CXOB0u837N0iPMsJ7h/Dvvtig64TisQcauBZH7e9WMp9vTIIS
 QhWD8uwqFQiAvAMma34by6dWgF14KXWIfYCr8MyjRYUQUQXKRKhMIETD6p4FtPHQonx7
 TactvmU5jlOl+Z1z2KlaU8BHTWO1ZmimAG6tcDsAAnUrHcQQA+Rgy2q6OdEXoI+R54VP
 QUm8jSw/jAR/xZ0XzM9ARvDe4MGsxBwM3R8s0XB4uwB5kRGKfkhYt6WoOOARybl4RHq+
 xY5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdRr/bNjVLEIXqyyXWBGBTfZR2zy4tpHoC/W35GTD3sic0UcWjqmghts2U3lGkhVVmz9LYzO39Z7unFL1Y7qWcVizCrQ==
X-Gm-Message-State: AOJu0YxNN2eT0fmNFiX7ys9wWdMaqgR+kknAV9s3JVArUycVjsGWXo6K
 sfNTgF3li8QmXR3Zz5XUDgFhdCslsAVTEzSjX1vb+/VvHsQEC8UyGBx9I6fz4g2Yvew7X7Yj5uG
 thJRewM6tpiPH77zYmltTOUP4Q6WJkPB8jfp+hw==
X-Google-Smtp-Source: AGHT+IE0QUrht4Rn0ghyysyZUzPJiHjEGk5lzy9b1MVBOfAW8ccbzN68EScMZ4xG1yeOofVY+LmtW7uTsCceXolP22M=
X-Received: by 2002:a17:906:f294:b0:a77:e6dd:7f35 with SMTP id
 a640c23a62f3a-a7a0f137e24mr165791866b.13.1721281707248; Wed, 17 Jul 2024
 22:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240718054528.799539-1-avromanov@salutedevices.com>
In-Reply-To: <20240718054528.799539-1-avromanov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 18 Jul 2024 07:48:15 +0200
Message-ID: <CAOf5uwmcexSSzZMjLNQ4A=qrMDvDc0k5t1mwteScAcWmgM4Qhw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Introduce UBI block device
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: dario.binacchi@amarulasolutions.com, frieder.schrempf@kontron.de, 
 kmpark@infradead.org, hs@denx.de, joe.hershberger@ni.com, dunaev@tecon.ru, 
 sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de, 
 tobias@waldekranz.com, jpewhacker@gmail.com, marek.vasut+renesas@mailbox.org, 
 kever.yang@rock-chips.com, jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, 
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com, 
 kernel@salutedevices.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey

On Thu, Jul 18, 2024 at 7:45=E2=80=AFAM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Hello!
>
> This series adds support for the UBI block device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
>
>   $ bcb load ubi 0 part_name
>
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers. Can be used with mtdblock device [1].
>

Did you run the CI on it? It's important not only that review get pass
but even we don't
create regression on other build

Michael

> ---
>
> Changes V1 -> V2 [2]:
>
>  - Rebased over mtdblock v2 patchset [3].
>  - Compile UBI partitions support only if CONFIG_BLK option
>    is enabled.
>
> Changes V2 -> V3 [4]:
>
>  - Fix build warnings: use LBAF printf format string for lbaint_t types.
>
> Changes V3 -> V4 [5]:
>
>  - Rebased over u-boot/master.
>  - Fix build errors and warnings if CONFIG_BLK isn't enabled.
>  - Fix failed tests in cases is ubiblock device isn't binded.
>
> Changes V4 -> V5 [6]:
>
>   - Rebased over u-boot/master.
>   - Fix build errors when CONFIG_MTD and CONFIG_MTD_UBI isn't enabled.
>   - Use auto blk device devnum generation when call
>     blk_create_devicef (pass -1 parameter instead of dev_seq(dev)).
>
> Changes V5 -> V6 [7]:
>
>   - Rebased over u-boot/master.
>   - Introduce CONFIG_UBI_BLOCK which is disabled by default.
>   - Fix undefined reference to `__aeabi_ldivmod' compiler error for 32-bi=
t ARM targets.
>
> Links:
>
>   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
tedevices.com/
>   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salu=
tedevices.com/
>   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salu=
tedevices.com/
>   [4] https://lore.kernel.org/all/20240325144148.3738195-1-avromanov@salu=
tedevices.com/
>   [5] https://lore.kernel.org/all/20240524111319.3512009-1-avromanov@salu=
tedevices.com/
>   [6] https://lore.kernel.org/all/20240603155740.1840571-1-avromanov@salu=
tedevices.com/
>   [7] https://lore.kernel.org/all/20240626104527.2811828-1-avromanov@salu=
tedevices.com/
>
> Alexey Romanov (6):
>   ubi: allow to read from volume with offset
>   ubi: allow to write to volume with offset
>   drivers: introduce UBI block abstraction
>   disk: don't try search for partition type if already set
>   disk: support UBI partitions
>   spinand: bind UBI block
>
>  cmd/ubi.c                   |  78 ++++++++++++++++++++--
>  disk/part.c                 |   7 ++
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/nand/spi/core.c |  12 +++-
>  drivers/mtd/ubi/Kconfig     |   7 ++
>  drivers/mtd/ubi/Makefile    |   1 +
>  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>  env/ubi.c                   |  16 ++---
>  include/part.h              |   2 +
>  include/ubi_uboot.h         |  13 +++-
>  11 files changed, 348 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/mtd/ubi/block.c
>  create mode 100644 drivers/mtd/ubi/part.c
>
> --
> 2.34.1
>


--=20
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
