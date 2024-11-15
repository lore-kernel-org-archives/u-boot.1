Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FC6D6DDF8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8F589618;
	Fri, 15 Nov 2024 14:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ins+t+qM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DCE8934C; Fri, 15 Nov 2024 12:34:34 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E6488D3C
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 12:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so18241295ad.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 03:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731670470; x=1732275270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bcHYZIy9l8+GCdFoe98Xb1WnbgWsIoKjeu9wapIG7vo=;
 b=ins+t+qMctjWsoMZ8ocSfnA249uJhFuOGk5Pq0XAzyx5y61bSBG0LQsRogd70X6kaG
 FFkqGj3jxQ4jBFBx+XRhitSifdikTaUzsFZdF9AEbMP8gAWidpLz23TSUO5il66bD92t
 IgfpN/YtIjh6KTGODLE22z6goiJ+FcBhJxVm9m0LnRRquO/7Cz2HdTblwIGL+t9uVc5T
 zTbcPsDOYZrCDk69vlz9QtCjluBMnUThiipjgq0ibkrPBy5nD/oMf/0hrFNklr2ZMeGK
 t992G+ppdHsyvS4YrZ7jVK06Q/zFIDYJnygtw03kUOu64dQjshV59HjY2hQkJYLmngZa
 +vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731670470; x=1732275270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcHYZIy9l8+GCdFoe98Xb1WnbgWsIoKjeu9wapIG7vo=;
 b=udxgMtWWYTk+8shBeRFra94Fc6pVi3PeLM7mBoHQ8LSvdBVEQGLKF4JHHNIxKgKVdf
 ybQz2kPEC64VsKnjCFnzykrLl/s4foTutFUNcBYcNiBksK4J4IgcT6dG09DN4xgRqO3W
 cDp4z7RxFVF605q8Y6m7KPSwP3YLRUNr5eNNbm+Hs2jsIjN/dvXUarj8nu6Xp92PTZ4K
 SCeZ9enQcmNd+fuQUA/BMkrOrWkcyJQ64czXN4PBTdM3QAU4AxWtEz9+imuJfRHIDths
 hZvZmOmbXlRSCk5LNl5/uCgmzkTEzZ6WFNe7z3P8TnSBgljF4oZq7S12NxKeSiSCUR9Q
 MdBQ==
X-Gm-Message-State: AOJu0YwE+59UpvX92VlRk8NK2UTTu5NKWOF1DqaYlaJLv/mw6YwRiUtW
 NvF6c4hOsjev6bhd4zjoPr1e4nR0jhUo+c6yRG/kDZcQSpX4H4Ti
X-Google-Smtp-Source: AGHT+IGMcN35QKKurJp0hWeJ3JhqeV4G1i067ipXSTJcx2VMKlQRXE4QQF/TmTVatG8srcFRJz/vEA==
X-Received: by 2002:a17:903:2452:b0:20b:8776:4902 with SMTP id
 d9443c01a7336-211d0ebf325mr30325595ad.38.1731670469699; 
 Fri, 15 Nov 2024 03:34:29 -0800 (PST)
Received: from per1cycle.per1cycle (n058153182158.netvigator.com.
 [58.153.182.158]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0dc3075sm10511515ad.34.2024.11.15.03.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 03:34:29 -0800 (PST)
Date: Fri, 15 Nov 2024 05:34:19 -0600
From: Huan Zhou <pericycle.cc@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Bin Meng <bmeng@tinylab.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v3 0/2] riscv: spacemit: add support for bananapi-f3
Message-ID: <20241115113419.ydmwbnyzjhhp6xle@per1cycle.per1cycle>
References: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
 <20241114132432-GYA1088330@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114132432-GYA1088330@gentoo>
X-Mailman-Approved-At: Fri, 15 Nov 2024 14:04:27 +0100
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

On Thu, Nov 14, 2024 at 09:24:32PM +0800, Yixun Lan wrote:
> Hi Huan:
> 
> On 01:21 Thu 14 Nov     , Huan Zhou wrote:
> > Banana Pi F3 board is a industrial grade RISC-V development board, it
> > design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> > computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
> > 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> > 
> > This patch introduces fundamental support for the Banana Pi F3 board,
> > encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> > operate in serial console mode.
> > 
> > Changes in v3:
> > - Add memory node for dts
> > - Add base commit
> > - Add ft_board_setup function for kernel memory init
> > - Change license to GPL-2.0-or-later
> > - Clear redifinition warning while building in UART_IIR_ID
> > - Change underscore to dash in bananapi*f3
> > - Update maintainer
> > - Use default prompt
> > - link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/
> > 
> although you're taking over this patch, the "Changes in v2" log should be preserved
> better also add the "link to v1" URL
ok, will be added in next version
> 
> 
> > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > ---
> > Kongyang Liu (2):
> >       riscv: spacemit: bananapi_f3: initial support added
> >       doc: spacemit: bananapi_f3: document Banana Pi F3 board
> > 
> >  arch/riscv/Kconfig                     |   5 +
> >  arch/riscv/cpu/k1/Kconfig              |  18 ++
> >  arch/riscv/cpu/k1/Makefile             |   6 +
> >  arch/riscv/cpu/k1/cpu.c                |   9 +
> >  arch/riscv/cpu/k1/dram.c               |  54 ++++
> >  arch/riscv/dts/Makefile                |   1 +
> >  arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
> >  arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
> >  board/spacemit/bananapi-f3/Kconfig     |  25 ++
> >  board/spacemit/bananapi-f3/MAINTAINERS |   7 +
> >  board/spacemit/bananapi-f3/Makefile    |   5 +
> >  board/spacemit/bananapi-f3/board.c     |   9 +
> >  configs/bananapi-f3_defconfig          |  20 ++
> >  doc/board/index.rst                    |   1 +
> >  doc/board/spacemit/bananapi-f3.rst     |  78 ++++++
> >  doc/board/spacemit/index.rst           |   8 +
> >  include/configs/bananapi-f3.h          |  13 +
> >  17 files changed, 743 insertions(+)
> > ---
> > base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
> > change-id: 20241112-pickup-bpif3-245ab208b9a4
> > 
> > Best regards,
> > -- 
> > Huan Zhou <pericycle.cc@gmail.com>
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
