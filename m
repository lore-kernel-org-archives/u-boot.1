Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6989CC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4151817C4;
	Tue,  1 Apr 2025 09:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fyL23vWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B587E801BE; Tue,  1 Apr 2025 09:31:40 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6CC81DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D636744D41
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 07:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAD9C4CEE9
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 07:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743492696;
 bh=oLwfho37NDfxsA2LOBp/UHmzVyRne4A1CxMEgCLEBS8=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=fyL23vWaNsMS1115aCRxaFkI8GZNRS7OK/V805LbrGoQzZ6a3U3A0zyGke5F/yo0n
 ObkIV9hnhCeSh/pW2b/mZ6M9lInBYFOeO5WoDq/fqEqU6dOrDTzHsd+KA7pCHA5tjS
 Wy1AyZfG/vj1c3vtulbeHclGMdmhaSPbLzI7El2glVjc5SSVJuxwloCE9TbaMPzEfL
 xjmR+Lzzf+LK6UIYudsPi3cwrzOcWWCq6kyrQa/08eySBVwu/ag8rHrd+/+0P6iZtW
 vJJEtFF9enVm5uDfXlwB1deWVs2DNbX0qPhvGicI1YpxuS/8qG6Vq/5dRT+2MMun+0
 Trq8tI8EhM1tA==
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-30bee278c2aso65654231fa.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:31:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1ySFV80rzzwkyM3DgN5Xdpwe/FWddIyb+hDVFd+wHXLBHLH8N
 GacBdLCbRD/fVtMHAu/Ym03YowEeMBuHVnQLMRQsX8gKwaRWrSneVpoeAxq53Dzdu2p5GZ93Lyx
 w72wXvnnzZMOy/qACVEluKHC8XlY=
X-Google-Smtp-Source: AGHT+IFHzNTP6bzKIHNMEZPrw76sTEiWDe/483htVcjtpYVdJm96hy0dubQ3Fnzt0CvTPgbi6Oh3Aom0zaYsfpo2h+k=
X-Received: by 2002:a2e:8698:0:b0:30b:9793:c1f6 with SMTP id
 38308e7fff4ca-30dd40d91c8mr41327281fa.17.1743492694501; Tue, 01 Apr 2025
 00:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
 <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
 <CANAwSgQB9ZdsE9vh2jOCGsATsjAUSUZQAfftPp=VsrogazmdOw@mail.gmail.com>
 <CANAwSgQS-ky7TF=k7OMOW4bQCJaozfYBjDS-5wXZ+3+3gU6crw@mail.gmail.com>
In-Reply-To: <CANAwSgQS-ky7TF=k7OMOW4bQCJaozfYBjDS-5wXZ+3+3gU6crw@mail.gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 1 Apr 2025 15:31:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v679u3aFwgMBA4y_B8sk-bO3OwRrj0py4hXc5anyG=FAKQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqwN-5kJ7xz7BzRw3ywsPny-umAP4cZUzMHyyL1RgqnW3JESO7daAu9_Mk
Message-ID: <CAGb2v679u3aFwgMBA4y_B8sk-bO3OwRrj0py4hXc5anyG=FAKQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Anand Moon <linux.amoon@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>, 
 Alexandre Vicenzi <linux@alxd.me>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nick Xie <nick@khadas.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Xiaobo Tian <peterwillcn@gmail.com>
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

On Tue, Apr 1, 2025 at 3:22=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> w=
rote:
>
> Hi Kever,
>
> On Tue, 1 Apr 2025 at 09:11, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Kever,
> >
> > On Tue, 1 Apr 2025 at 08:30, Kever Yang <kever.yang@rock-chips.com> wro=
te:
> > >
> > > Hi Anand,
> > >
> > > On 2025/3/30 21:33, Anand Moon wrote:
> > > > Hi Chen-Yu
> > > >
> > > > On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
> > > >> From: Chen-Yu Tsai <wens@csie.org>
> > > >>
> > > >> The IO domain driver controls the I/O voltage for various pins,
> > > >> MMC included.
> > > >>
> > > >> Enable it by default for all supported Rockchip SoCs.
> > > >>
> > > >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > > >
> > > > Can we enable following config default for all the boards
> > > >
> > > > CONFIG_MMC_DW=3Dy
> > > > CONFIG_MMC_DW_ROCKCHIP=3Dy
> > > > CONFIG_MMC_SDHCI=3Dy
> > > These two driver, SD card and eMMC, are board specific, not all the
> > > board has enable all these two interface.
> > >
> > Ok,I thought it should reduce the configuration options on all the boar=
ds.
> But can we implement this for each SoC, such as the RK3399 and RK3588?"

Of all the defconfigs that have ARCH_ROCKCHIP, only three don't have MMC_DW=
:

    configs/coolpi-cm5-genbook-rk3588_defconfig
    configs/evb-rv1108_defconfig
    configs/geekbox_defconfig

So maybe we could have the default by y, and negate the option where
it makes sense.

For MMC_SDHCI there would be more defconfigs, but only a couple SoCs
support this controller, and we could narrow it down to those.


ChenYu
