Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DA5C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF34387545;
	Tue, 21 Nov 2023 14:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="K/cdlBA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3379875BC; Tue, 21 Nov 2023 14:00:53 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECC7870BC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so3687712b6e.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1700571650; x=1701176450;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBqwEyCYvH//c+tCZH/nJG9SeMSF2vfv+9HMrxFEKXI=;
 b=K/cdlBA4OgE7kKeuO/jpVoVXx1q4INoVovOWUtfhT1cqUoothocXwzAc7felMMfXvo
 ipnPSRgJl+FSEHpyuNCKWwY3QknjoEFSTJJgxkxD69GOig4Rn5li0gPD9DUHBW7bHwyi
 P//xlIx16IF7NG8Z2WPUcO7Pu4QYN4sdTHN/qMaHG+5hkMFIrVWbrs1QkwlPEFkLK7Vt
 xgnWUX7uJjrhwYkUQuZFNozMJQqNV6JAzpRSlcFSKWfHHspaG4utAIxOHAfsct0Ki1z/
 A+is2wc8I98p7D8hhPDN8SE/yPMajtBGA9VXihuvX6RuhPXdQjQBm5qYTEGpNMKCBQsN
 b+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700571650; x=1701176450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBqwEyCYvH//c+tCZH/nJG9SeMSF2vfv+9HMrxFEKXI=;
 b=X3F/FcfC3G8BtXVHzLMLzoeaMJLO2RosRcmhRXvv5InM2xhvXqOClMgOUq//nQYJk0
 qKv+QPQhsCZpn0xj7tC0Uu24w2pynru6wr44v2Fqnqdj6c1bBAd2ARGaidllYkwB1SdO
 xmoiCUS0bPaJy8jbIjrePcr6sIMkZUZXrf7HFo08sux7+zHnzcJwITbC34kKpbcWkgFh
 +E/i3pFnyLmarUD/XtcnQZ3l5aaBr0ve/kUKgeRhX2pWkQ8yjEXWhmHxhCVdHa9/Ochn
 xX0BqR0z2B1fxqveN6TlAaVrv/WZY1/Q8HSV/EWXlgNuxQTJXlTtKxgsAG7CQ2YU/g/w
 DWPQ==
X-Gm-Message-State: AOJu0YyyTmvk9B/Oier8wwvClxqu5zrqgEb9akPFKi9eR1SU0Moje4pt
 PIxw1mrdzpCqZuGepS2ry9IgjtQ2KY8hQE5rl7fsUA==
X-Google-Smtp-Source: AGHT+IGJW2wdx/6fRrR7S0AP3NEjYTZXgIC7mxk/BbVf9HwDl7czRmSOYmzeAfMy4R9hTM9MTRPO7mdDw/AZvEuBanM=
X-Received: by 2002:a05:6358:248c:b0:16d:b577:e9f5 with SMTP id
 m12-20020a056358248c00b0016db577e9f5mr13123665rwc.11.1700571649923; Tue, 21
 Nov 2023 05:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 21 Nov 2023 14:00:38 +0100
Message-ID: <CAHTX3d+fSzncQc3phh9qAQk5fhSf=j6kPaMrjOw1nnAqbwEQ8Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] spi-nor: Add parallel and stacked memories support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com, 
 vigneshr@ti.com, git@xilinx.com
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

=C3=BAt 14. 11. 2023 v 5:57 odes=C3=ADlatel Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> napsal:
>
> This series adds support for Xilinx qspi parallel and stacked memeories.
>
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly
> between both the flashes so, both the flashes that are connected in
> parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
>
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can diffe=
r
> in sizes. So, except the sizes all other flash parameters of both the fla=
shes
> are identical.
>
> Spi-nor will pass on the appropriate flash select flag to low level drive=
r,
> and it will select pass all the data to that particular flash.
>
> Write operation in parallel mode are performed in page size * 2 chunks as=
 each
> write operation results in writing both the flashes. For doubling the add=
ress
> space each operation is performed at addr/2 flash offset, where addr is t=
he
> address specified by the user.
>
> Similarly for read and erase operations it will read from both flashes, s=
o size
> and offset are divided by 2 and send to flash.
>
>
> Changes in v2:
> - Fixed the compilation issues.
> Changes in v3:
> - Fixed the CI issues.
> Changes in v4:
> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> - Fix the compilation issue by including the DM_SERIAL config.
>
> Ashok Reddy Soma (4):
>   mtd: spi-nor: Add parallel and stacked memories support
>   mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>   mtd: spi-nor: Add parallel and stacked memories support in read_bar
>     and write_bar
>   spi: spi-uclass: Read chipselect and restrict capabilities
>
> Venkatesh Yadav Abbarapu (2):
>   spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>   spi: zynq_qspi: Add parallel memories support in QSPI driver
>
>  drivers/mtd/spi/sandbox.c      |   2 +-
>  drivers/mtd/spi/spi-nor-core.c | 389 ++++++++++++++++++++++++++++-----
>  drivers/spi/altera_spi.c       |   4 +-
>  drivers/spi/atcspi200_spi.c    |   2 +-
>  drivers/spi/ath79_spi.c        |   2 +-
>  drivers/spi/atmel_spi.c        |   6 +-
>  drivers/spi/bcm63xx_hsspi.c    |  42 ++--
>  drivers/spi/bcm63xx_spi.c      |   6 +-
>  drivers/spi/bcmbca_hsspi.c     |  34 +--
>  drivers/spi/cf_spi.c           |   6 +-
>  drivers/spi/davinci_spi.c      |   6 +-
>  drivers/spi/fsl_dspi.c         |  18 +-
>  drivers/spi/fsl_espi.c         |   4 +-
>  drivers/spi/fsl_qspi.c         |   4 +-
>  drivers/spi/gxp_spi.c          |   2 +-
>  drivers/spi/mpc8xx_spi.c       |   4 +-
>  drivers/spi/mpc8xxx_spi.c      |  10 +-
>  drivers/spi/mscc_bb_spi.c      |   4 +-
>  drivers/spi/mxc_spi.c          |   6 +-
>  drivers/spi/npcm_fiu_spi.c     |  14 +-
>  drivers/spi/nxp_fspi.c         |   2 +-
>  drivers/spi/octeon_spi.c       |   2 +-
>  drivers/spi/omap3_spi.c        |   4 +-
>  drivers/spi/pic32_spi.c        |   2 +-
>  drivers/spi/rk_spi.c           |   4 +-
>  drivers/spi/rockchip_sfc.c     |   2 +-
>  drivers/spi/spi-aspeed-smc.c   |  28 +--
>  drivers/spi/spi-mxic.c         |   6 +-
>  drivers/spi/spi-qup.c          |   4 +-
>  drivers/spi/spi-sifive.c       |   6 +-
>  drivers/spi/spi-sn-f-ospi.c    |   2 +-
>  drivers/spi/spi-sunxi.c        |   6 +-
>  drivers/spi/spi-synquacer.c    |   4 +-
>  drivers/spi/spi-uclass.c       |  23 +-
>  drivers/spi/stm32_qspi.c       |   2 +-
>  drivers/spi/stm32_spi.c        |   4 +-
>  drivers/spi/ti_qspi.c          |  14 +-
>  drivers/spi/xilinx_spi.c       |   4 +-
>  drivers/spi/zynq_qspi.c        | 120 ++++++++--
>  drivers/spi/zynq_spi.c         |   6 +-
>  drivers/spi/zynqmp_gqspi.c     | 140 ++++++++++--
>  include/linux/mtd/spi-nor.h    |  13 ++
>  include/spi.h                  |  26 ++-
>  lib/acpi/acpi_device.c         |   2 +-
>  44 files changed, 765 insertions(+), 226 deletions(-)
>
> --
> 2.17.1
>

There are some issues related to sandbox reported in CI that's why v5
is required.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
