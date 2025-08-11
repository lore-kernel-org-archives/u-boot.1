Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA77CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F5082BA1;
	Mon, 11 Aug 2025 18:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYmur5+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8748C82BA1; Mon, 11 Aug 2025 18:28:23 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BB782063
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso2787082f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754929698; x=1755534498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6pZhPkTmPwrStRmjBBeOOl3BPnkkUEqZ/JYcvCMxtQ=;
 b=GYmur5+k7mE33qAxgxETQ/0CRB1+wC/EbKsPPItAkH/u1jxjIRKs92xySUMwV0yeWI
 egz56dMvnSnHxE3UGCrQtCFLC2F2q4Dg5Fj6MRAJOfFXcNJdAHUFXjPglgs3ay/W0Ir3
 PqjYSbvK0OehGWZVkDRHinDQNs3DhHRdInvVgAbBr7rXSFcNZCVTZFukpi9BU3h4kDhZ
 u89dhkTzflSl+nF+lQOqYKkTEh4Ni1oSMMriH7f1eqTdhUpKD3VeriGMcnOjQONkNKgv
 sGTqructATb3vsZtwk2A+tcQnKnqxmCP/Fyt5MHFpqwLJI7S2VJmPHPk0UFmtSVhVB67
 9rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929698; x=1755534498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6pZhPkTmPwrStRmjBBeOOl3BPnkkUEqZ/JYcvCMxtQ=;
 b=ewqhLhx0BVrZGgBl52snHoQTtJOKOlCj8+Pjl5JkULkv1Y6cTFyJMAzrjMq53QpZ9R
 uFmCGdrBSJJhzCdsdNfH3qIQiEJ8ph2/br5d85uiCeaG6qabgxnYqlovJVT6Js6vjKj0
 XcrzB7+t5dk9CP3h8gMqzPSL+F2ADrpwByYGxEF6yZisRj533pdS0UoszKyWG7qoww8x
 nQ/r9I6Gx0zxW6odx90ZJlcYolcvC1Ar4M4Q5xOv9gTsA28bQykHGK0OggsUZfGVsL9G
 TvvRw0UVr64euYp8oAuHeJ1j3L/REhMzWmvyrIm3HI9T8ETsDSU2WXRW/3lx0GJzHWWd
 1cQw==
X-Gm-Message-State: AOJu0YzDjmwx1fqmZtJalv/MOmg/xqC3Sfm9nfLdEiY/1g4YmxOsPoxb
 zm6q0P7510hyegnUYUJqa/FYUSQT8HfUMoyntTfKhiAVYLCk7XC9HO6Q
X-Gm-Gg: ASbGncvc8swgJDFSxqacuLRuj45tAKj28n89pcigY0kzBP3dKsa/D3axEj/RoG4uje9
 9KuP1fF1Lcyqtf+6tDZqc99ickJwE1JZ8vvQzYDsD/eOt4KsmjjMvh6cx8LJV2gtqjcAX0+dV7B
 2vVgQM046h1kb6IIgjF/ux0B0hPDM6a6tLY0KVTBuMh16l5xpxKR6b11UVuceBGB9SMEC4A43fo
 yyU+sKY4xa20TwOHL4ydQAlUQmxqttMVCEiQgI7eF+rwtRQT/7y5Nr5Jk9d03voyla73HNT6VVw
 3Su13M5UbZJkzt/T3hWqnGtJVzwAS0h+bz2hLC7blUhYQd/2HjYZl6SJJ4ATQcbS1SQ7gtP6G6+
 ZW/xRsB2/dyTB0mwWC+3ha3UKRIFua5nPGuJa1iRqMGeA8O7e7nKZCap2MX0fLbTSMEpDZZIbdg
 ==
X-Google-Smtp-Source: AGHT+IHSrH1ZW1fBH0gun9ZPAWYWoCnyX1s0CbkYhM+HManBK+cp2Z8O+AsqWZl4xD8QQV09FD8rUQ==
X-Received: by 2002:a05:6000:220f:b0:3b7:924a:998f with SMTP id
 ffacd0b85a97d-3b900b499cfmr11694247f8f.5.1754929697663; 
 Mon, 11 Aug 2025 09:28:17 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm324974175e9.13.2025.08.11.09.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:28:17 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: dram: fix LPDDR3 mode register settings
Date: Mon, 11 Aug 2025 18:28:16 +0200
Message-ID: <4444430.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20250811170816.60e57b14@donnerap.manchester.arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <7836068.EvYhyI6sBW@jernej-laptop>
 <20250811170816.60e57b14@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 11. avgust 2025 ob 18:08:16 Srednjeevropski poletni =C4=8Da=
s je Andre Przywara napisal(a):
> On Mon, 11 Aug 2025 17:49:06 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> many thanks for having a look!
>=20
> > Dne sobota, 2. avgust 2025 ob 01:49:18 Srednjeevropski poletni =C4=8Das=
 je Andre Przywara napisal(a):
> > > The JEDEC LPDDR3 spec defines mode register 0 (MR0) as being read-onl=
y,
> > > so there is no point in trying to set its value.
> > > Also the H616 memory controller encodes the mode register index to be
> > > written starting from bit 8 in MRCTRL1 (for LPDDR3 and LPDDR4 chips),=
 so
> > > we need to OR in that number to tell the controller which MR to progr=
am.
> > >=20
> > > On top of that, the mode registers between DDR3 and LPDDR3 are
> > > completely different, so writing values crafted for DDR3 into a LPDDR3
> > > chip is just wrong. Due to the above mentioned bugs the writes for
> > > MR0-MR2 did not have any effect (as they were all trying to set the
> > > read-only MR0), so the mode registers just stayed unchanged. =20
> >=20
> > Nice catch! Looking at BSP DRAM code, it only sets MR1, MR2 and MR3.
> >=20
> > >=20
> > > Looking at the LPDDR3 spec and the BSP code, let's write the proper MR
> > > values into LPDDR3 chips, using the proper addressing mode. =20
> >=20
> > Please explain how you find those values. Are they always set in this w=
ay
> > for all boards using LPDDR3?
>=20
> Yeah, that's a good question! At first, I tried using what JEDEC describes
> as the default settings, but that didn't work. Then I looked into some
> parameters found in some BSP image dumps, but that didn't work either.
> JEDEC describes those MRs as write-only, and I haven't tried whether
> reading them would work nevertheless, not sure about the exact algorithm
> for reading MRs anyway.
> What eventually worked was to use the BSP values written by exactly the
> boot0 on the eMMC that boots an LPDDR3 system - which is actually only one
> in mainline: the Tanix TX1.
>=20
> So yeah, those values work for me (TM), and there is only one LPDDR3 board
> supported, so fingers crossed. But actually I wonder if those MR values
> really belong into the timing routine (mctl_set_timing_params(), since
> parts depend on the speed bin. I see some other SoC/DRAM type combinations
> doing that already (H6 DDR3/LPDDR3 and A523 LPDDR4), maybe we should
> follow suit here?

Historically, I checked several boards and if MR value was the same in all
configs, I just hardcoded the value. While this is a bit naive, it works mo=
st
of the time. There are some cases where it is set dynamically in BSP code. =
Those
cases can be a bit annoying to find. Ideally, MR values shout be Kconfig
option with default values.

It's up to you to decide which approach to take. Since it affects just one
board and changes were tested:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
>=20
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Use the opportunity to document the LPDDR3 mode register bits written.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm/mach-sunxi/dram_sun50i_h616.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-s=
unxi/dram_sun50i_h616.c
> > > index 877181016f3..3345c9b8e82 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> > > @@ -1078,18 +1078,18 @@ static bool mctl_phy_init(const struct dram_p=
ara *para,
> > >  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >  		break;
> > >  	case SUNXI_DRAM_TYPE_LPDDR3:
> > > -		writel(mr0, &mctl_ctl->mrctrl1);
> > > -		writel(0x800000f0, &mctl_ctl->mrctrl0);
> > > -		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > > -
> > > -		writel(4, &mctl_ctl->mrctrl1);
> > > +		/* MR0 is read-only */
> > > +		/* MR1: nWR=3D14, BL8 */
> > > +		writel(0x183, &mctl_ctl->mrctrl1);
> > >  		writel(0x800000f0, &mctl_ctl->mrctrl0);
> > >  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > > =20
> > > -		writel(mr2, &mctl_ctl->mrctrl1);
> > > +		/* MR2: no WR leveling, WL set A, use nWR>9, nRL=3D14/nWL=3D8 */
> > > +		writel(0x21c, &mctl_ctl->mrctrl1);
> > >  		writel(0x800000f0, &mctl_ctl->mrctrl0);
> > >  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > > =20
> > > +		/* MR3: 34.3 Ohm pull-up/pull-down resistor */
> > >  		writel(0x301, &mctl_ctl->mrctrl1);
> > >  		writel(0x800000f0, &mctl_ctl->mrctrl0);
> > >  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> > >  =20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




