Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB48E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 04:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EA3801DB;
	Thu, 12 Dec 2024 05:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlRY1DXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D08801EA; Thu, 12 Dec 2024 05:00:31 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D80801CF
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so1154073a91.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733976026; x=1734580826; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OkC+Nyz/rrg0BM708dQAZUOVNEUKaVFRVHXU34LEVB4=;
 b=HlRY1DXUgURhS/q1LKJkOiCqhTfw0iZC+DC0tpaAGUiR5NPGMHFrsmnsux788K7BHs
 PzkGafzTbFYbyob53lTfA/V3gYnHCGtL8xPWIgt0sqJyAWHWKMkbKdq/7UPun8+rEp6F
 7muItxkyQ2uLhy4OpLrRPtEnUZEAkqkLea8oEHJCmkGH0TvVUo0v+aKG7rRmbY88a+NW
 HCFxnQ1X64PPNk/wmZxHtTKDrojx+TSZi5QDh6rOyLpeTg2fZb90DoXuv2drofA1wHV6
 dW28Wjge4P/SEgWkK2/4HUX3GhiM4XwcZjZzMkB+s7jDS3/tUqXQlC0fX1/h+lJJK0BU
 sQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733976026; x=1734580826;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkC+Nyz/rrg0BM708dQAZUOVNEUKaVFRVHXU34LEVB4=;
 b=PiFpHXLG9HYR0NirEXYGlGetsZe/HM+KisaKQwdQA3b/8xSSMW6PbSLoKLf7/0hP3k
 umWi0mGOr5OfFvf+AM36aNFGlQ/YPmzYHY6Yofy5fg2i3pyJkcpwZYtVaDv1WhJfEoLr
 j7WNVE+1G3+/pS+V5rl4R4Y4funV6ga8mqw2/djFO+sTRjEKfRDNleUjfrno7Za/SZD7
 23im1Klbn210qsj+1ui1Z/1T7+X7B2WMRSrBkgPV3/yuLURJWhOjClh5qcnns1lOEWNY
 cuTrQlOFjrNicG1DYGJHa+g629IGNsV3mmI73K32Of0XhVFtYPi62pGnawgECm7E+eVV
 qI4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQGhM0Jd22M/F4BNF8VfVG1N6Yu8Ie9P6wxPxXwFnFMG0GInxCC4XZkdRwWkLxUK8lv5ohds4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4aLwDrOtljCBr47/8GiG/rH4pOEeZh3E3Ag4eJ6V4UX63DQWh
 Xa+IIa3SFRYCef+/+9/3uPQXxpmS5RqJDQRzCkZUEperXKFhlfsL
X-Gm-Gg: ASbGncsKx4BbnQm2n+9qXt6g/DN/5vVCO4GI+abBtaogJY/Y6iHLd+UQnE3DRbuFZUV
 AAStPpFaq7Lb+Jk4GEewDPgF4yQ9nZSJ6fmQaoX+2Z6vyU+xk9CcCXOYYgpORbRCISA8i0h6q2N
 GmtAoP6KdS2dWQ2wSdbXGVmRYyFq5JRnXxq9fnIYFNLxxTvNy7ZaMy1y9/o+44wiQGMQiV4pfYj
 GxBZ1133ox/sRy6BjKo+chtb6qwW1dB633wrETtMTzZn+Y9Zm4o8XdRQLD0Gp8Wr9KVfqyeUcoU
 OaWEosDW03/FOvIS3NUfkeNkqek5Tv61VRM=
X-Google-Smtp-Source: AGHT+IEY5zESHAYSB14fx7oo5imX1OobFXOcvedzfdPE4ysQrRIHI/t3QcyVY8JZqxOyEAylrsj34A==
X-Received: by 2002:a17:90b:1810:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2f13ac98c80mr2657084a91.15.1733976026223; 
 Wed, 11 Dec 2024 20:00:26 -0800 (PST)
Received: from per1cycle.per1cycle (36-226-243-111.dynamic-ip.hinet.net.
 [36.226.243.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142de894esm216812a91.32.2024.12.11.20.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 20:00:25 -0800 (PST)
Date: Thu, 12 Dec 2024 12:00:15 +0800
From: Huan Zhou <pericycle.cc@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas Schw?bel <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <20241212040015.ii6f6tklgulfwsqy@per1cycle.per1cycle>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
 <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
 <20241204005808-GYA559515@gentoo>
 <cdf417bfba7bf57379d18eb114822195610ad99d.camel@ziswiler.com>
 <20241208065157.wd7jr4ltjtvbytld@per1cycle.per1cycle>
 <b7b51f70e6271ea38fe2257b8424c41bb3e6114e.camel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7b51f70e6271ea38fe2257b8424c41bb3e6114e.camel@ziswiler.com>
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

On Wed, Dec 11, 2024 at 09:35:12AM +0100, Marcel Ziswiler wrote:
> Hi Huan
> 
> On Sun, 2024-12-08 at 14:51 +0800, Huan Zhou wrote:
> > On Wed, Dec 04, 2024 at 09:52:09AM +0100, Marcel Ziswiler wrote:
> > > Hi Yixun Lan
> > > 
> > > On Wed, 2024-12-04 at 08:58 +0800, Yixun Lan wrote:
> > > > Hi Marcel, Huan
> > > > 
> > > > On 18:52 Tue 03 Dec     , Marcel Ziswiler wrote:
> > > > > Hi Huan Zhou 
> > > > > 
> > > > > On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> > > > > > From: Kongyang Liu <seashell11234455@gmail.com>
> > > > > > 
> > > > > > Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> > > > > > 
> > > > > > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > > > > > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > > > > > ---
> > > > > >  doc/board/index.rst                |  1 +
> > > > > >  doc/board/spacemit/bananapi-f3.rst | 86 ++++++++++++++++++++++++++++++++++++++
> > > > > >  doc/board/spacemit/index.rst       |  8 ++++
> > > > > >  3 files changed, 95 insertions(+)
> > > > > > 
> > > > > > diff --git a/doc/board/index.rst b/doc/board/index.rst
> > > > > > index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53f852ef742eba13dd 100644
> > > > > > --- a/doc/board/index.rst
> > > > > > +++ b/doc/board/index.rst
> > > > > > @@ -51,6 +51,7 @@ Board-specific doc
> > > > > >     sipeed/index
> > > > > >     socionext/index
> > > > > >     sophgo/index
> > > > > > +   spacemit/index
> > > > > >     st/index
> > > > > >     starfive/index
> > > > > >     ste/index
> > > > > > diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> > > > > > new file mode 100644
> > > > > > index 0000000000000000000000000000000000000000..1e6d6ef19be7e25684966bd4a727bd21b147330a
> > > > > > --- /dev/null
> > > > > > +++ b/doc/board/spacemit/bananapi-f3.rst
> > > > > > @@ -0,0 +1,86 @@
> > > > > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +
> > > > > > +Banana Pi F3
> > > > > 
> > > > > Officially they call it Banana Pi BPI-F3.
> > > > > 
> > > > > > +============
> > > > > > +
> > > > > > +Building
> > > > > > +~~~~~~~~
> > > > > > +1. Install the spacemit riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> > > > > 
> > > > > I would not use a specific such toolchain but rather a regular RISC-V one e.g.
> > > > > 
> > > > > https://github.com/riscv-collab/riscv-gnu-toolchain
> > > > > 
> > > > 
> > > > I think any riscv toolchain should work fine here, as I'm using Gentoo specific riscv toolchain..
> > > > so consider it's merely an example provided to demonstrate whole process working
> > > 
> > > Okay.
> > > 
> > > > > > +
> > > > > > +.. _toolchain: https://archive.spacemit.com/toolchain/
> > > > > > +
> > > > > > +2. Setup cross compilation environment variable:
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> > > > > > +
> > > > > > +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> > > > > > +built for SpacemiT K1 SoC as below:
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> > > > > > +   cd opensbi
> > > > > > +   make PLATFORM=generic
> > > > > 
> > > > > What speaks against using regular master opensbi?
> > > > > 
> > > > no idea if master of opensbi would work here, we can certainly try..
> > > 
> > > I tried and it seems to work fine, resp. the only difference I could spot is that instead of 'crc32+ OK' it
> > > prints some random ASCII characters in the last line before any U-Boot output:
> > do you mean the extra '\n'?
> 
> No, it literally printed some random chars, but now it seems fine. Probably some unrelated glitch maybe UART
> related.
i think it may be your baud rate setting problem?
I use xshell and the baud rate is set to 115200 and the random char issue never happens to me.
> 
> Actually, one out of five to ten boots it prints such random chars: �,��&�%Hj�H�
> 
> I tried cyyself opensbi again and after 10 boots it also printed similar random chars. Actually, it even always
> prints the exact same ones when it happens. I guess, sooner than later, somebody might need to debug into what
> exactly is happening there (;-p).
> 
> [   0.579] ## Checking hash(es) for Image opensbi ...�,��&�%Hj�H�
> 
> Anyway, regular upstream opensbi seems to work just fine, good.
> 
> > > [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
> > > 
> > > > but I think it's another story, as we are focusing on mainlining uboot
> > > 
> > > Yes, exactly. I am just curious if it needs combining with some obscure vendor stuff.
> > the spl phase need some obscure vendor stuff.
> 
> Sure, but I hope we can still upstream it after this first part landed.
> 
> > > > FWIK, this branch is generally same version as vendor opensbi, but slightly
> > > >  rebase to more recent opensbi version
> > > > 
> > > > > > +
> > > > > > +4. Then build U-Boot as following:
> > > > > > +
> > > > > > +.. code-block:: console
> > > > > > +
> > > > > > +   cd <U-Boot-dir>
> > > > > > +   make bananapi-f3_defconfig
> > > > > > +   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> > > > > > +
> > > > > > +This will generate u-boot.itb
> > > > > > +
> > > > > > +Booting
> > > > > > +~~~~~~~
> > > > > > +Actually, we can replace the uboot part from bianbu linux which is the bsp_ to validate this patch,
> > > > > > +use `balena etcher` to burn the bianbu-minimal.img to the sd card, 
> > > > > 
> > > > > trailing whitespace
> > > > > 
> > > > > > +and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
> > > > > > +
> > > > > > +.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> > > > > > +.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
> > > > > > +
> > > > > > +Sample boot log from Banana Pi F3 board
> > > > > 
> > > > > BPI-F3
> > > > > 
> > > > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > +.. code-block:: none
> > > > > > +
> > > > > > +   try sd...
> > > > > > +   bm:3
> > > > > > +   j...
> > > > > > +
> > > > > > +   U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
> > > > > > +   [   0.279] DDR type LPDDR4X
> > > > > > +   [   0.292] lpddr4_silicon_init consume 13ms
> > > > > > +   [   0.293] Change DDR data rate to 2400MT/s
> > > > > > +   [   0.430] ## Checking hash(es) for config conf-1 ... OK
> > > > > > +   [   0.432] ## Checking hash(es) for Image opensbi ... OK
> > > > > > +   [   0.437] ## Checking hash(es) for Image uboot ... OK
> > > > > > +   [   0.443] ## Checking hash(es) for Image fdt-1 ... OK
> > > > > > +   [   0.488] ## Checking hash(es) for config config_1 ... OK
> > > > > > +   [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
> > > > > > +
> > > > > > +
> > > > > > +   U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:49 +0800)
> > > > > > +
> > > > > > +   DRAM:  4 GiB
> > > > > 
> > > > > I guess it does not yet detect the amount of RAM available.
> > > > > 
> > > > I would be fine with this, as currently the memory size is hardcoded,
> > > > we should work on follow-up patch to auto probe DDR size, and corret it
> > > 
> > > Yes, I agree.
> > > 
> > > > > > +   Core:  19 devices, 8 uclasses, devicetree: separate
> > > > > > +   Loading Environment from nowhere... OK
> > > > > > +   In:    serial@d4017000
> > > > > > +   Out:   serial@d4017000
> > > > > > +   Err:   serial@d4017000
> > > > > > +   Net:   No ethernet found.
> > > > > > +   => cpu list
> > > > > > +   0: cpu@0      spacemit,x60
> > > > > > +   1: cpu@1      spacemit,x60
> > > > > > +   2: cpu@2      spacemit,x60
> > > > > > +   3: cpu@3      spacemit,x60
> > > > > > +   4: cpu@4      spacemit,x60
> > > > > > +   5: cpu@5      spacemit,x60
> > > > > > +   6: cpu@6      spacemit,x60
> > > > > > +   7: cpu@7      spacemit,x60
> > > > > > +   => test
> > > > > > +   => 
> > > > > 
> > > > > trailing whitespace
> > > > > 
> > > > > > +
> > > > > > diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> > > > > > new file mode 100644
> > > > > > index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67ffc877f9ad323162d
> > > > > > --- /dev/null
> > > > > > +++ b/doc/board/spacemit/index.rst
> > > > > > @@ -0,0 +1,8 @@
> > > > > > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +
> > > > > > +SpacemiT
> > > > > > +========
> > > > > > +.. toctree::
> > > > > > +   :maxdepth: 1
> > > > > > +
> > > > > > +   bananapi-f3
> > > > > > 
> > > > > 
> > > > > new blank line at EOF
> > fixed.
> 
> Thanks!
> 
> Cheers
> 
> Marcel
> -- 
> Marcel Ziswiler         | mailto:marcel@ziswiler.com
> Chäppelirain 4          | https://www.ziswiler.net
> CH-6018 Buttisholz      | mobile: +41 (76) 338-0382
> Switzerland             | phone: +41 (41) 928-0509
