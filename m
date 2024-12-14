Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D87E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 07:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2E7800B2;
	Sat, 14 Dec 2024 08:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BU1r4V9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46377800B3; Sat, 14 Dec 2024 08:23:03 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB31800B1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 08:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so1684311a91.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 23:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734160975; x=1734765775; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VuGbe9Lmnr9x/11p20akXtTxzGNExJD4IAOaSTHnChg=;
 b=BU1r4V9A953C/XZTjvyLYxzNrWZHkFJBgxDhNZjJXFd+sZkz0a+gmG3oob42QxoLjO
 DnFbxg69reb8694LaNnq7LItKkda3UzAQUnn8Xt1Q+/ZHAZ8pLP32EWwSYU5UrDukNfY
 T+oGqzhtCEjHRNvV7KaFiFjwidR3zR/jBpzOa6tp/UpyQtVDUjAtB2TheW2iapMeFfy2
 wbRtkHA3OqLMPvAIhSpJ0gCT5Iy3CFCzKr2XTpxbXJBf35fowAAgs+dv8tyBHCk6EmRC
 2fl+Yg6pHi7TCEefgjSiyiKfDjtfiV5apfAoWkBjl2N4fyA9jgxQvus+dSRsV65kjXj8
 FZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734160975; x=1734765775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuGbe9Lmnr9x/11p20akXtTxzGNExJD4IAOaSTHnChg=;
 b=ZOre2Dd8e5dnfv+KqPp9YJ/BSViHSsTKoWW+t3szzPza43uumdDIMLPvwnvrxBdu2q
 IuL7pDb4ct8c6pQVH62gb6mVlK1cEmGi8zaVawnEWA6fk10WGY6LChPv47LX/QbX4siE
 FTQeCW5EeGB3msvMsW4a0sCT9v9xI1Dk27kjzRPgPUIcnt+XgF7boqoLiDpLcY8e3yBM
 k4ZMFCK87F6DY3ABcEn8S+dAsM/g2EbsnTtngHsFe5+N2BsMcfUz9Jh59M4HCxitlJx4
 VbBB6ZuJqyWgvQFb9AssEjPPnP3ZNZ4UGHsXbnipON36Lab3CR4BfD31/VonCQ/1EmI9
 z/BQ==
X-Gm-Message-State: AOJu0Yx66Aqsk9W2fGghIabNWcrHGqmxSDXOlaBYZlNkl3DG1oHdFDfk
 d+W9uET5Kpw12UvambBYMPF4XBQIbAxkwD7f/8/SGGM+NMOoemVp
X-Gm-Gg: ASbGncuWYEMkHaOiGSgx4IraPoAezSdetsVNcIn61aD9xoUMJzpx6g2iamLbd0qsjI0
 u63qGeR+m97Xou3Twk8hpsE95AJoPGceJHdg6WMsBbVBFEilC8tFF4NBamvcBcXnLvwqA3SV2zU
 SstyYI7Bzyb0GxAuIqJktYfZZtfGSSUFMxXqf+S4eh2sXxFbW0ymwZZenFz3hGI8a7oq98zoALV
 CTGLfE4pJAqxh5FgG1yi80MDjOJa/RWTqdR/ug31PXVdxCwpMIC/7t9uxmcS4eGVAVhqUlfz0Bn
 04PTZepE2SpvDu9gWxWTkdTrIA==
X-Google-Smtp-Source: AGHT+IFpMszsBN19lQVFeDa4Cx/tezT2p3bEVWav00g9wHnxeODSKF5yDdGrESpOhIQjBL1jsszwgg==
X-Received: by 2002:a17:90b:3951:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f2901b323fmr7556378a91.26.1734160975436; 
 Fri, 13 Dec 2024 23:22:55 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a1ea8219sm856299a91.22.2024.12.13.23.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 23:22:52 -0800 (PST)
Date: Sat, 14 Dec 2024 15:22:44 +0800
From: Huan Zhou <pericycle.cc@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH v6 0/2] riscv: spacemit: add support for bananapi-f3
Message-ID: <20241214072244.7y2l2jof3niyuvx7@per1cycle.per1cycle>
References: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
 <20241214071958-GYA2631991@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214071958-GYA2631991@gentoo>
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

On Sat, Dec 14, 2024 at 03:19:58PM +0800, Yixun Lan wrote:
> Hi Huan:
> 
> On 14:44 Sat 14 Dec     , Huan Zhou wrote:
> > Banana Pi F3 board is a industrial grade RISC-V development board, it
> > design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> > computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
> > 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> > 
> > This patch introduces fundamental support for the Banana Pi F3 board,
> > encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> > operate in serial console mode.
> > 
> > Changes in v6:
> > - Rebase the patch to the latest branch.
> > - Add small comment in bananapi-f3.h
> > - Add tag in previous patch(e.g reviewed by or tested by)
> > - Add fastboot burn procedure in doc.
> > - Link to v5: https://lore.kernel.org/r/20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com
> > 
> > Changes in v5:
> > - Formal the name from Bananapif3 -> Banana Pi BPI-F3
> > - Trailing whitespace
> > - New blank line at EOF in spacemit/index.rst
> > - Link to v4: https://lore.kernel.org/r/20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com
> > 
> > Changes in v4:
> > - Change uart compatible in k1.dtsi in v3, cause related driver in not implemented in u-boot.
> > - Update doc, show how to validate the patch.
> > - Update maintainer, remove kongyang cause he lefted.
> > - Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com
> > 
> > Changes in v3:
> > - Add base commit
> > - Clear redifinition warning while building in UART_IIR_ID
> > - Change underscore to dash in bananapi*f3
> > - Update maintainer
> > - link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/
> > 
> > Changes in v2:
> > - Change license to GPL-2.0-or-later
> > - Add memory node for dts
> > - Add ft_board_setup function for kernel memory init
> > - Use default prompt
> > - links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashell11234455@gmail.com/
> > 
> > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ..
> > Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> it's wrong to add Marcel's tag to the cover letter here,
> instead, you need to apply to patch [1,2] as he gave for whole series
> 
mb fixit, thx ;)
> also for this series
> 
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> 
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
> >  arch/riscv/dts/Makefile                |   2 +
> >  arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
> >  arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
> >  board/spacemit/bananapi-f3/Kconfig     |  25 ++
> >  board/spacemit/bananapi-f3/MAINTAINERS |   6 +
> >  board/spacemit/bananapi-f3/Makefile    |   5 +
> >  board/spacemit/bananapi-f3/board.c     |   9 +
> >  configs/bananapi-f3_defconfig          |  20 ++
> >  doc/board/index.rst                    |   1 +
> >  doc/board/spacemit/bananapi-f3.rst     | 106 ++++++++
> >  doc/board/spacemit/index.rst           |   9 +
> >  include/configs/bananapi-f3.h          |  13 +
> >  17 files changed, 772 insertions(+)
> > ---
> > base-commit: b0b6d0c87082813aada4c052a8b4e20c257dbbda
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
