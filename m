Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E730CCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AC4831E1;
	Mon, 11 Aug 2025 18:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuV7Jd7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCA6831EA; Mon, 11 Aug 2025 18:31:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581A382BA1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so39300545e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754929891; x=1755534691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YdRLPIMZH2swK7BCy4B9kH/zLDhhL0HbXD3QPuD768=;
 b=OuV7Jd7igFclxuhoTDzbMQN69uefcMr9QiDYqCrLi15eYhpr5Q4TC2Pp/g59UbbihT
 pnREi0G1gRkZgFjC6LnU/xMqSGy0u1qPE+8Wyw5tbTxaqobsERb8jOAMChTt8ifxXjPQ
 pnEEdG7vNuoLKUULUhcH6bBkvqjMKKlN95fig4p2TACYmiuYnL8iJcM8QeZKuDehqETG
 c7WPYx8O4/m7pB12vs2p3AtvuIy4tlXx3CJkRGUr/kjpwoAXPajfFm2BfuzifPZse+kg
 rTMLwAup7+XMKhWDoQml6ll9TeIqTA9PTNl4HqCIvth2w0lHTjfwf+9RKeFKgLP0vRL9
 bShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929891; x=1755534691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YdRLPIMZH2swK7BCy4B9kH/zLDhhL0HbXD3QPuD768=;
 b=a0IVUA2v55ky/MZVKD14pxwftDDNgbgQER8WqSdUV/gInFNglkk8O0vYJqsE4EVUee
 JZ9TUBc580sfNiXk2mU0qnirIQiPj5+laqLMaSIcbGiQ/EX2cr99VmIK1/ReXhNxV7cP
 /PnpAOq/N6TBFHj3L9IeYA/T2DTIxJ3moJ/Q55+5s7gTGbmZjrhUW+2ObMx8emBQ5K/o
 1jfQ11FTux+L0wVGlEny9ku0yPwqMgQ/q5n4T/04DhdgyNDO+RViL6GxqUyPEbptKtHx
 OR4bzjK+0Atze3bkljwn1ElZIp8r7OWaOanmwNPrEAt9tE0eiI8tik0sngdH8zX+ZGQg
 +cgw==
X-Gm-Message-State: AOJu0YwFK/nhdpSLt0G/uVuR7msCY6ebCB0R/FYQdx0t+7BjtMHA/9S/
 I6ybzUMG2WsGMr2rX0zKHpjo2Z7cqvEm8WNHLKGNyFFS+7QsxdWXvRD6
X-Gm-Gg: ASbGnct0z/w/ItNnX9VY+xYTbUtU3Z14mbSNSE1rE+ZvRVbj7A/myGURDf9IS57FSNh
 OFr7xLxQeS8cdP7rOMUdCkw7dBI1NTtlIbL1CkGCmnnt+ihTvwJ434ZRkUyRGOwKOb+CkQ6yhPY
 qwPZhg0ITMpnfwjNHkYYz9ZQJMB/nlc+JMixkJWJAN7l6UWv+R2YxZvVaijXfl0XB8G+wr5qOFb
 m/vB+c2RRmy9nwdxNWDgq6NTXTSsT3BEn7phrWMAYqDUKu10tIXE9iSY6JTHOEIBm5Hr0d39aPA
 eXzK9oEnnkKFlacrrIoUfGBKdWvqvyn41xgTIdf0DpE1sHOal3OszykG2w6dSw32TWHhNSaVHlc
 SQ4Or0ZdHw8lNvLgNWAnDyGjuVkqF+s+4xQG9rdcCEoG3Jt3XzFNGLglCwrVLSxEexEBAyaUdTQ
 ==
X-Google-Smtp-Source: AGHT+IE53jQO2Jsf14EJEngccMbARbtEBpmtlTdNVRzZP1NPhRrZiYXWdGSYahnKSkh6G+rabtvmTA==
X-Received: by 2002:a05:600c:4fc2:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-459f4f04140mr103754445e9.20.1754929890591; 
 Mon, 11 Aug 2025 09:31:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0e70218sm289411705e9.20.2025.08.11.09.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:31:30 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] sunxi: spl: initialise timer before clocks
Date: Mon, 11 Aug 2025 18:31:29 +0200
Message-ID: <3833295.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20250811165225.2a01a93d@donnerap.manchester.arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <3363499.aeNJFYEL58@jernej-laptop>
 <20250811165225.2a01a93d@donnerap.manchester.arm.com>
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

Dne ponedeljek, 11. avgust 2025 ob 17:52:25 Srednjeevropski poletni =C4=8Da=
s je Andre Przywara napisal(a):
> On Mon, 11 Aug 2025 17:34:47 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> > Dne sobota, 2. avgust 2025 ob 01:49:17 Srednjeevropski poletni =C4=8Das=
 je Andre Przywara napisal(a):
> > > Recent changes in the H6 clock code added delay() calls into the SPL =
clock
> > > setup routine, which requires the timers to work. When compiling for
> > > AArch64, we are always using the Arm Generic Timer (aka. arch timer),
> > > which does not require further setup, hence having an empty timer_ini=
t()
> > > routine.
> > > However for 32-bit SoCs we use the Allwinner timers, which require so=
me
> > > setup routine, and hence we need timer_init() to be called before
> > > clock_init().
> > >=20
> > > Swap the order of the two calls, to be more robust when compiling the=
 H6
> > > clock code for AArch32 or when using the Allwinner timers for whatever
> > > reason.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm/mach-sunxi/board.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> > > index fb4837c2082..432b1c10f92 100644
> > > --- a/arch/arm/mach-sunxi/board.c
> > > +++ b/arch/arm/mach-sunxi/board.c
> > > @@ -476,8 +476,8 @@ void board_init_f(ulong dummy)
> > >  	/* Enable non-secure access to some peripherals */
> > >  	tzpc_init();
> > > =20
> > > -	clock_init();
> > >  	timer_init();
> > > +	clock_init(); =20
> >=20
> > I contemplated similar change in past. It works fine for 64-bit archite=
ctures,
> > but I'm unsure for 32-bit. If you take a look at A83t clock code, it us=
es
> > sdelay() exactly because timer is not initialized at that time.
> >=20
> > So, are you sure that this change has no unwanted side effects?
>=20
> No, I am not ;-)
> I was about to test this on some more boards. But I think with the
> change in that direction, the only issue would be if the timer_init() code
> relies on the clocks being set up already. And since timer_init() is only
> *one* rather small function, just doing MMIO accesses, I think the risk is
> quite low.

As long as clock function doesn't need to enable bus or module clock,
everything should be fine. Quick check didn't show any such code so
it is probably safe to switch.

Best regards,
Jernej

>=20
> Thanks for having a look anyway, I will report back how the test goes.
>=20
> Cheers,
> Andre
>=20
> >=20
> > >  	gpio_init();
> > > =20
> > >  	spl_init();
> > >  =20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




