Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E9FD6DDD8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3A7890FC;
	Fri, 15 Nov 2024 14:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IjB35DLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A0A8934E; Fri, 15 Nov 2024 06:15:31 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5327C89350
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-720be27db27so1174904b3a.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731647727; x=1732252527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5pYOTCGdhnjHfp9pyRCaRbuOR2o8UEMB6X7dgsKceSM=;
 b=IjB35DLFu5aP7Wez0mA+96pp3S4/a4GNF7ZNLtQ54n7lUveTITkcbJ+RGIVJbSNwAb
 SYutLxh1en83aURZgnru8zhL00BLoLI145QQzeGSxXPP6oPlOk+td0GBdl8WuSwwl9Pm
 Jegoy/IF+YIJmmLYLWaf1PZOX/3IWBc0aQ8kf5VuLe/HNOWHimqR3KzOaRkCS/ZmJFtT
 dlFy540whVsDTWEh/1sEnwzjBm9wBJCh3JdPpj7Qi8RXvg6nsMItXKznWnJXlbX+sTtP
 SBnSinRIFlMi/8RaG6R/ovF6JP17rV85DNMjW12y61MbVGCE7G0tO3no7yFSm0gBH42e
 9bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731647727; x=1732252527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pYOTCGdhnjHfp9pyRCaRbuOR2o8UEMB6X7dgsKceSM=;
 b=Lz1UIEKfYnJu5UoMueNcOxaGIWGbEspnTb0p2i7GLXWbA+GKRq0Mtb3dJUjtKxl17Y
 +Y4+j6mLxMevw0ZAN4jWYnpSPuUTq8wa6rR68QJAZg0UiNr3JU1hnoFCUC2UCekDCs16
 29Q73BKMRGCs16H72YHqqHIdzRiYWDcZMb1q5O+ku6BUVCIN0m6fIjKyb91MPQST0BXO
 VDjoLvYcMv3wAj7RYF1rv/OuNLWDuBtAj65Vn0AeiTmHAXhYErzqDcuhd0xsLTSgomLS
 NR5RF2i062i3/H705voQfk0LxgbTYoC9vERj4QivLvQHjCkZkV5igXPeaqAJ/gw3sKnX
 H8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtsa3QRo2sR6xhdZJdRfDJhtKWqPN9c1plakOiWpHEVBXZrE4svEqYNtnh2eG07GWGwJcu5U8=@lists.denx.de
X-Gm-Message-State: AOJu0YxgDqQUSRKtIwGvvjj/GKM+sS9ck/kaUSEiSEKE9YgNyCKdxFPc
 3FimWFd1+AsoEyLeM9nkoQdIUWqTKfSTeoK0r4C7FKag4jYxU15m
X-Google-Smtp-Source: AGHT+IGO3qVuui+kkgWwOvNu99xCqmio36s7o6wzTkunu5VmCCEdGAMiPJtIpewfc5X0E8lp8t9R1A==
X-Received: by 2002:a05:6a21:7888:b0:1db:df34:1683 with SMTP id
 adf61e73a8af0-1dc90c1a996mr1579846637.42.1731647726462; 
 Thu, 14 Nov 2024 21:15:26 -0800 (PST)
Received: from per1cycle.per1cycle (n058153182158.netvigator.com.
 [58.153.182.158]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7247711ce4bsm530322b3a.47.2024.11.14.21.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 21:15:25 -0800 (PST)
Date: Thu, 14 Nov 2024 23:15:19 -0600
From: Huan Zhou <pericycle.cc@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <20241115051519.2mg2rfsyfsg5aqp4@per1cycle.per1cycle>
References: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
 <20241114-pickup-bpif3-v3-2-98a45802ab79@gmail.com>
 <14ba45f7-0941-4a1b-96e1-5423644313cc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ba45f7-0941-4a1b-96e1-5423644313cc@gmx.de>
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

On Thu, Nov 14, 2024 at 11:11:21AM +0100, Heinrich Schuchardt wrote:
> On 11/14/24 08:21, Huan Zhou wrote:
> > From: Kongyang Liu <seashell11234455@gmail.com>
> > 
> > Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> > 
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > ---
> >   doc/board/index.rst                |  1 +
> >   doc/board/spacemit/bananapi-f3.rst | 78 ++++++++++++++++++++++++++++++++++++++
> >   doc/board/spacemit/index.rst       |  8 ++++
> >   3 files changed, 87 insertions(+)
> > 
> > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f852ef742eba13dd 100644
> > --- a/doc/board/index.rst
> > +++ b/doc/board/index.rst
> > @@ -51,6 +51,7 @@ Board-specific doc
> >      sipeed/index
> >      socionext/index
> >      sophgo/index
> > +   spacemit/index
> >      st/index
> >      starfive/index
> >      ste/index
> > diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..ae98a784a7f19a28658b2d6acad0679cf0a4faa3
> > --- /dev/null
> > +++ b/doc/board/spacemit/bananapi-f3.rst
> > @@ -0,0 +1,78 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Banana Pi F3
> > +============
> > +
> > +About This
> > +----------
> 
> Thank you for documenting the new board.
> 
> For such a short article we don't need three levels of sections:
> 
> Banana Pi F3
> |- About This
> |  |- Building
> |  |- Booting.
> 
> The 'About This' title could be completely removed. Otherwise, please,
> put it on the same level as the other sub-sections.
removed in next version.
> 
> > +Banana Pi F3 board is a industrial grade RISC-V development board, it
> > +design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> > +computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
> > +3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> > +
> > +Building
> > +~~~~~~~~
> > +1. Add the RISC-V toolchain to your PATH.
> 
changed in next version.
> If we use CROSS_COMPILE, the toolchain does not need to be on the PATH.
> You could use an absolute path like
> 
> CROSS_COMPILE=/home/user/my_tools_dir/riscv64-linux-gnu-
> 
> > +2. Setup ARCH & cross compilation environment variable:
> 
> Environment variable ARCH is not used when building U-Boot.
> The only usage is in scripts/decodecode.
> 
got it.
> > +
> > +.. code-block:: console
> > +
> > +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> > +
> > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> > +built for SpacemiT K1 SoC as below:
> > +
> > +.. code-block:: console
> > +
> > +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> > +   cd opensbi
> > +   make PLATFORM=generic
> > +
> > +4. Then build U-Boot as following:
> > +
> > +.. code-block:: console
> > +
> > +   cd <U-Boot-dir>
> > +   make bananapi-f3_defconfig
> > +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> > +
> > +This will generate u-boot.itb
> > +
> > +Booting
> > +~~~~~~~
> > +Currently, we use a modified vendor's U-Boot SPL to load a FIT image that
> > +includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot is a
> > +challenging task. And the booting method will be added after the SPL
> > +support is available.
> 
> Could you, please, describe how to build and use the 'modified vendor's
> U-Boot SPL' so that others can test and contribute.
> 
ok, will be discribed with more details in next version:-)
> Best regards
> 
> Heinrich
> 
> > +
> > +Sample boot log from Banana Pi F3 board
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +.. code-block:: none
> > +
> > +   U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 +0800)
> > +
> > +   DRAM:  4 GiB
> > +   Core:  18 devices, 7 uclasses, devicetree: separate
> > +   Loading Environment from nowhere... OK
> > +   In:    serial@d4017000
> > +   Out:   serial@d4017000
> > +   Err:   serial@d4017000
> > +   Net:   No ethernet found.
> > +   bananapi_f3# cpu detail
> > +     0: cpu@0      spacemit,x60
> > +      ID = 0, freq = 0 Hz: MMU
> > +     1: cpu@1      spacemit,x60
> > +      ID = 1, freq = 0 Hz: MMU
> > +     2: cpu@2      spacemit,x60
> > +      ID = 2, freq = 0 Hz: MMU
> > +     3: cpu@3      spacemit,x60
> > +      ID = 3, freq = 0 Hz: MMU
> > +     4: cpu@4      spacemit,x60
> > +      ID = 4, freq = 0 Hz: MMU
> > +     5: cpu@5      spacemit,x60
> > +      ID = 5, freq = 0 Hz: MMU
> > +     6: cpu@6      spacemit,x60
> > +      ID = 6, freq = 0 Hz: MMU
> > +     7: cpu@7      spacemit,x60
> > +      ID = 7, freq = 0 Hz: MMU
> > +   bananapi_f3#
> > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67ffc877f9ad323162d
> > --- /dev/null
> > +++ b/doc/board/spacemit/index.rst
> > @@ -0,0 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +SpacemiT
> > +========
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   bananapi-f3
> > 
> 
Best regards,
Huan Zhou
