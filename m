Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133FEE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 09:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E67800AD;
	Fri, 13 Dec 2024 10:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="juuhx9zJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA94800AE; Fri, 13 Dec 2024 10:16:42 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD65800AA
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 10:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fbc65f6c72so1383495a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1734081398; x=1734686198;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOS74b9oMTp4D7v1mAN60EpIujXQULH2AFNHhGOJ8Us=;
 b=juuhx9zJ5PWfZeSWpT69U+YJrVKO6CuWkjRf/rLb81jFg8sKc5zdbAsFTx6szdk3g7
 xzyg9ZhfbhKTYZrq3fv01TydWaJKRPZmw34t9DnU3ViEu6b6UoYaFrvQm5H1Sn+zeqGf
 ymx7h3kgfr79zlqnLt/VBYTV/EexqyNUB+aiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734081398; x=1734686198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOS74b9oMTp4D7v1mAN60EpIujXQULH2AFNHhGOJ8Us=;
 b=LnK0Bko52H6fzF7z3/FOtPJHTEZl9siAhZ4qLHMJB2UO/+IIIheuFqYVGsFZikHwuv
 EcfAPwlF61xhgl2XWUtgMqjYjFplTtag2dJtZRZVd33O6taJVMdw8xeT9W/i1lO6kC2P
 Md4HyI0ZE2q5e4zYB81kwbmqrjdQOf97PujnN8Oxthg8QJyNEwx4+e/tFelbfVvcjHUm
 vsUxYA9HxCenLAJwYFDfDihhERUJs8F8XnpUm6he1q4fJlcXd/sJwG15LB8o7OY4WuV6
 C2XtaV3ujp8pGTz3ml0mz/KiLCjzj4Az05Y/lwX05DLzQuwJs8a32aNBZCZVfJDGSS7F
 v8bA==
X-Gm-Message-State: AOJu0YwGH9CNHrdTBJHAbqCfGcCFi0OfiuguVcD9nu+/MWokYTOB7yFk
 97Uy9LVTDWneZOhGvaGFPQ2PBxCqFRcyE3SyborWrbmTFjf5rBMBn1bhgRoghDdocuGfcSbfjnj
 jenvDG3Mfnm+qq6RdOrsr7EJF7eu/t/H0kPWKEA==
X-Gm-Gg: ASbGncvwPXWomBxfF1UbJ7bwjiM9RLl4DT0TCPqVrJ/ZEco9lEGlqJkOGPe1Rb+ny5b
 PsJwo+p3Dca+oojKSHEtw3xftLbRfvklHJGjmYmxymthl+fpjWsjrRa8CpRaVWpbwy7P0m7E=
X-Google-Smtp-Source: AGHT+IEtSaQnDP4PW6uKxRi4gq1PJKaHhlQz6jo2TdnOPoNs0RqyjWQkvuqjn3vSksyJo1Kh1MUXMRaAOxcO8corxZE=
X-Received: by 2002:a17:90b:2652:b0:2ea:4a6b:79d1 with SMTP id
 98e67ed59e1d1-2f28fb6e8dbmr3000487a91.11.1734081397921; Fri, 13 Dec 2024
 01:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 13 Dec 2024 10:16:26 +0100
Message-ID: <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
Subject: Re: [resend v2 00/19] Add Cadence NAND Driver support
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

Hi

On Thu, Dec 5, 2024 at 10:23=E2=80=AFAM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> This patchset add Cadence NAND driver support for
> Intel Agilex5 devices.
>
> The NAND driver is leveraged from the cadence-nand-controller.c
> from Linux version 6.11.2. U-Boot will support read, write and erase
> NAND with Cadence driver. The driver further enhanced in U-Boot
> to support NAND booting from FSBL and support boot to kernel
> via UBIFS.
>
> Patch status:
> Have changes: All patches expect Patch 19
>
> Detail changelog can find in commit message.
>
> v1->v2:
> --------
> Patch 1 - 18:
>
> - remove the "this patch is to" commit phrases
>
> Patch 4;
> - minor refactoring of code to match the stable version 6.11.2.
>
> Patch 14:
> - Add maintainer and "#include" mechanism for new variant
>
> Patch 16:
> - leverage the existing nand_spl_load_image
>

I have tried to build but it does not work. Have you tested in github?

Michael

> History:
> --------
> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20240919035512.138=
54-1-dinesh.maniyam@intel.com/
>
> Dinesh Maniyam (19):
>   dt: nand: add cadence nand dt-bindings
>   arm: dts: agilex5: Enabled cdns-nand dts setting
>   include: asm: Add support to read/write 64-bit
>   drivers: mtd: nand: Add driver for Cadence Nand
>   drivers: mtd: nand: cadence: Add support for read status command
>   drivers: mtd: nand: cadence: Add support for readid command
>   drivers: mtd: nand: cadence: Add support for NAND_CMD_PARAM
>   drivers: mtd: nand: cadence: Add support for NAND_CMD_RESET
>   drivers: mtd: nand: cadence: Support cmd SET_FEATURES & GET_FEATURES
>   drivers: mtd: nand: cadence: Flush & invalidate dma descriptor
>   drivers: mtd: nand: cadence: Poll for desc complete status
>   drivers: mtd: nand: cadence: Use bounce buffer
>   drivers: nand: Enabled Kconfig and Makefile for cdns-nand
>   configs: nand2_defconfig: Enable configs for nand boot
>   drivers: mtd: nand: base: Add support for Hardware ECC for check bad
>     block
>   drivers: mtd: nand: spl: Add support for nand SPL load image
>   drivers: mtd: nand: Enabled Kconfig and Makefile for Cadence-SPL
>   drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE dependency
>   drivers: mtd: nand: Kconfig: Enabled self-init for cdns-nand SPL
>
>  arch/arm/dts/socfpga_agilex5.dtsi             |   14 +
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   28 +
>  arch/arm/include/asm/io.h                     |   25 +
>  board/intel/agilex5-socdk/MAINTAINERS         |    2 +
>  configs/socfpga_agilex5_nand2_defconfig       |   33 +
>  .../mtd/cadence,nand.yaml                     |   98 +
>  drivers/mtd/nand/raw/Kconfig                  |   19 +-
>  drivers/mtd/nand/raw/Makefile                 |    2 +
>  drivers/mtd/nand/raw/cadence_nand.c           | 2424 +++++++++++++++++
>  drivers/mtd/nand/raw/cadence_spl.c            |   59 +
>  drivers/mtd/nand/raw/nand_base.c              |   71 +-
>  include/cadence-nand.h                        |  529 ++++
>  include/linux/mtd/rawnand.h                   |   14 +
>  13 files changed, 3293 insertions(+), 25 deletions(-)
>  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
>  create mode 100644 doc/device-tree-bindings/mtd/cadence,nand.yaml
>  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c
>  create mode 100644 drivers/mtd/nand/raw/cadence_spl.c
>  create mode 100644 include/cadence-nand.h
>
> --
> 2.19.0
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
