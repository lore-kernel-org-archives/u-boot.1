Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322E7C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CD3801BE;
	Tue,  4 Feb 2025 18:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qb+Xz3vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63ABD803B5; Tue,  4 Feb 2025 18:54:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B29800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D2C5D5C5FAA
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC2C4CEEF
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738691645;
 bh=R1GzRSYeTG5ImR/nW/Fa35m+TaK3d1RCggzzbyh6LBo=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=qb+Xz3vvK/Dm0aDkotudacuYvLhWKCmFbx/Lqufo3WZi4a/cfWrXTOa1BaelKC2HQ
 Kzie0zv/poQbDcjUAi0O/bytJIpGFHh9nnENkcZeAZSpRHV78NrsTII3VpixkUFZTE
 847ru8uk+p0Dsf/leWMZBU2OBeMbNqKCSxKlpT/WaAPfwu1N2K1t4Hk+sus0BpLkYT
 HFaDJgXRkK41kFhgKUOEckxt1Vcaqu4te1/8seLYgwWRiLqhxAko+Ija2vlKAUk55p
 u4dFePeNM2Vod9IcxyHeuD8T220ZlhvKTXG5a2gjJTe7S35Xe8nxdYWL/mfhTOBDbN
 irRV6uma3cBGg==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-30761be8fa8so53779281fa.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 09:54:05 -0800 (PST)
X-Gm-Message-State: AOJu0YxoHgssOlJnygNIyxuu1uaRYFU5MH61As705LYBAuKfxOBBfV80
 CwaXVBU2AvNjg7ZXN9WuG3VicqJdABRzjpwDHVMq7CZamAw/3wnNeI3cVObzoURSabid1nHMnyL
 TUZPnz3K1+UUHh0VhPvImSZxObh8=
X-Google-Smtp-Source: AGHT+IGPvJR5VAxjD8NqUfCME4PBvaAJ7MI13qn6qw5mPemEnD42rS4D8Y5wylPX45rXkzb6nsG5KbVm/lf4Gkj7Lv8=
X-Received: by 2002:a05:651c:2225:b0:300:33b1:f0c4 with SMTP id
 38308e7fff4ca-3079684e70dmr105057091fa.11.1738691643212; Tue, 04 Feb 2025
 09:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20250204172151.3361714-1-wens@kernel.org>
 <87c853a6-2eed-4bcf-a32b-021966d10f71@cherry.de>
In-Reply-To: <87c853a6-2eed-4bcf-a32b-021966d10f71@cherry.de>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Feb 2025 01:53:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v64EPgW8A4TK3GZ4_7UQ=YMU8kOPZyneMZBzkpdvb5cXkw@mail.gmail.com>
X-Gm-Features: AWEUYZmd6zEa7CzyHTANz7YnpOEapEFkJlGdthnO9JpgU-JfrVKg2BpH0KUb4gU
Message-ID: <CAGb2v64EPgW8A4TK3GZ4_7UQ=YMU8kOPZyneMZBzkpdvb5cXkw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: Enable OF_LIBFDT_OVERLAY by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, Feb 5, 2025 at 1:49=E2=80=AFAM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>
> Hi Chen-Yu,
>
> On 2/4/25 6:21 PM, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Device tree overlays are immensely useful.
> >
> > Enable it by default by implying it from ARCH_ROCKCHIP.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >
> >   arch/arm/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index f504d7d07601..2797030d3501 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -2061,6 +2061,7 @@ config ARCH_ROCKCHIP
> >       imply DEBUG_UART_BOARD_INIT
> >       imply BOOTSTD_DEFAULTS
> >       imply FAT_WRITE
> > +     imply OF_LIBFDT_OVERLAY
> >       imply SARADC_ROCKCHIP
> >       imply SPL_SYSRESET
> >       imply SPL_SYS_MALLOC_SIMPLE
>
> Yes but not entirely enough right now.
>
> See:
> https://lore.kernel.org/u-boot/20250129-px30-overlay-v1-0-4729b3fcb4c0@ch=
erry.de/T/#t
>
> At least it still boots even if fdtoverlay_addr_r isn't set so that's
> not too much of an issue.

Sure. Though having it compiled in allows the user to set fdtoverlay_addr_r
manually on the command line or through a script to be able to use overlays=
.
Not having to rebuild the bootloader is already a huge improvement.

> Would be nice to check which SoCs do not have this fdtoverlay_addr_r set
> and actually set it as well, otherwise enabling this doesn't help much
> :) (at least with pxe/extlinux)

A quick grep shows:

include/configs/rk3308_common.h:        "fdtoverlay_addr_r=3D0x01f00000\0"
include/configs/rk3328_common.h:        "fdtoverlay_addr_r=3D0x01f00000\0"
include/configs/rk3399_common.h:        "fdtoverlay_addr_r=3D0x12100000\0"
include/configs/rk3568_common.h:        "fdtoverlay_addr_r=3D0x12100000\0"
include/configs/rk3588_common.h:        "fdtoverlay_addr_r=3D0x12100000\0"
include/configs/rv1126_common.h:        "fdtoverlay_addr_r=3D0x02000000\0"

I don't have any devices with the SoCs that aren't on this list though...


ChenYu
