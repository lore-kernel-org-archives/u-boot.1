Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E66CC4829C
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 01:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BF787E8C;
	Sun, 11 Feb 2024 02:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uEtt3x7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A44387AEC; Sun, 11 Feb 2024 02:19:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA6B87AEC
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 02:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5AE4D60BF0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D1C4166B
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707614347;
 bh=vRgZ4X9kL6G0yLIjdrHUdsIxsgbD7dDia1eSRYITefo=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=uEtt3x7o+HksY3vIwtDiJSkeCyhDBMcfNdKvwo7m3iwS77NXJt1Im59Ebdb83NPOA
 QTIgMCfquD4QaXI9qsHfuneWgaMuar8iREAiq5ypf2zw2EU02DOazhcf/yaDpnKk5l
 YoNMz4d5YGjMTvd08xdjn3Tlm7uxhb0D8CYVesmMMDflAZZzB7MwOPLwD6zi364ouA
 PkOuZNZFH2kNu5osNZ+ZqnDuv4IP2tVAwnFAY98+MN54OeIVOgjoRzMsKw0Pr4PbEb
 lCLnpnp1PNEwnKeY+w5kIipzR2YLk2MRUOfrC+ZinuZQfxhFDybvomAOIYPmUHh2go
 v49UuXW8IYx4g==
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-296c562ac70so1624258a91.2
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 17:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvQPUnkBgzMuWUxeIRE+D4B/z5wCxOhpiGkp1+7KCyy5ZBaoW+c4u7zBWZy7JFBJt1ky1tNmAe/QhLzk6xzdN3ZKWcHA==
X-Gm-Message-State: AOJu0YxvAxIgmVvIRnXBZyCE5ADX8UM2Ik1TpXkus/ru9IVPqLahDP+2
 9ed1tOt23/vPqREllU41NFdDAKN9MvWAd2E5KFhFZVDnXbFBiUdyLFmYm5NJK+jnbpD+lsCqSUg
 dKYwb1o9DnARx6o4TbfGMU2MNTNU=
X-Google-Smtp-Source: AGHT+IEypMIx18VNzYIsVs9AOuDWPoV0pIk+QGMslRg2S3vulug+tN8SRu8ioDxr9z855o79nhCt6J7FM/PHWQ/Bw10=
X-Received: by 2002:a17:902:e88e:b0:1da:1d0e:dc75 with SMTP id
 w14-20020a170902e88e00b001da1d0edc75mr4625991plg.9.1707614346862; Sat, 10 Feb
 2024 17:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20240210063252.1065611-1-wens@kernel.org>
 <20240210063252.1065611-5-wens@kernel.org>
 <45cb7235-3760-4ea2-a8c4-21b781bc2b54@kwiboo.se>
In-Reply-To: <45cb7235-3760-4ea2-a8c4-21b781bc2b54@kwiboo.se>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 11 Feb 2024 09:18:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v654xo9NBn6O8FtgHHzpjVa_J7czZF-3BwQU0r+mWnK33w@mail.gmail.com>
Message-ID: <CAGb2v654xo9NBn6O8FtgHHzpjVa_J7czZF-3BwQU0r+mWnK33w@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: rk3399: regenerate defconfigs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tianling Shen <cnsztl@gmail.com>, 
 David Bauer <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, 
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, u-boot@lists.denx.de
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sun, Feb 11, 2024 at 3:49=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Chen-Yu,
>
> On 2024-02-10 07:32, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Regenerate RK3399 defconfigs after adding imply statements.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  configs/chromebook_bob_defconfig          | 2 --
> >  configs/chromebook_kevin_defconfig        | 2 --
> >  configs/firefly-rk3399_defconfig          | 2 --
> >  configs/nanopi-r4s-rk3399_defconfig       | 2 --
> >  configs/pinebook-pro-rk3399_defconfig     | 2 --
> >  configs/pinephone-pro-rk3399_defconfig    | 2 --
> >  configs/puma-rk3399_defconfig             | 2 --
> >  configs/roc-pc-mezzanine-rk3399_defconfig | 2 --
> >  configs/roc-pc-rk3399_defconfig           | 2 --
> >  configs/rock-4c-plus-rk3399_defconfig     | 3 ---
> >  configs/rock-4se-rk3399_defconfig         | 3 ---
> >  configs/rock-pi-4-rk3399_defconfig        | 3 ---
> >  configs/rock-pi-4c-rk3399_defconfig       | 3 ---
> >  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
> >  configs/rock960-rk3399_defconfig          | 1 -
> >  configs/rockpro64-rk3399_defconfig        | 2 --
> >  16 files changed, 34 deletions(-)
> >
>
> [snip]
>
> > diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-pl=
us-rk3399_defconfig
> > index 18525c8bf504..12587b1eba10 100644
> > --- a/configs/rock-4c-plus-rk3399_defconfig
> > +++ b/configs/rock-4c-plus-rk3399_defconfig
> > @@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> >  CONFIG_ENV_OFFSET=3D0x3F8000
> >  CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-rock-4c-plus"
> > -CONFIG_OF_LIBFDT_OVERLAY=3Dy
>
> This patch seems to also remove a few OF_LIBFDT_OVERLAY, guessing this
> was unintentional?

Yeah, that was unintentional. I have a local patch that enables
OF_LIBFDT_OVERLAY for ARCH_ROCKCHIP by default.

> If you are re-spinning this series, please also include change to:
> - add CONFIG_MISC=3Dy to ficus-rk3399_defconfig, its required for efuse

I suppose we should just also imply CONFIG_MISC.

> - drop CONFIG_ROCKCHIP_OTP=3Dy from nanopi-r4s-rk3399_defconfig, soc have
>   efuse or otp and on rk3399 it is efuse

Will add a cleanup.

> And possible also drop CONFIG_NET_RANDOM_ETHADDR=3Dy from:
> - evb-rk3399_defconfig
> - ficus-rk3399_defconfig
> - khadas-edge-captain-rk3399_defconfig
> - khadas-edge-v-rk3399_defconfig
> now that these boards will have proper ethaddr.

Will add a separate cleanup.


ChenYu
