Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C929DE74AD0
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 20:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0646989667;
	Tue,  3 Dec 2024 21:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elO7NhvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884BD89185; Tue,  3 Dec 2024 20:51:46 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6408F88E42
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fbd70f79f2so5761611a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255501; x=1733860301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PwFyc0U6GgUmwDVxbqx69cdhxxKpP3+Mnvxr4dCavKM=;
 b=elO7NhvS+fJXYhWC0MrARdv62lg9AWoj6YDvGYT/g/i1T1+rxy/4HZCygldw8WVVi1
 byAsbPkHGnyVag6C+/2XaFps3p4IELFNrwD+mubTn1qu1olOK00iXMH8dDp08t4YvbCV
 SyHxpZ7CkKM2FBhUHC2Hekfl3T+jC+0Ydcwk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255501; x=1733860301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PwFyc0U6GgUmwDVxbqx69cdhxxKpP3+Mnvxr4dCavKM=;
 b=RL0x9sAwc5THmZfYL5NflDroIstpJIL7jwwpeAT0PwyAoItjrcY9y7M1fiMao3nCEh
 jYhnQidAMpdsP5hAgT8RZ/bxNyS7l8aIaOjco4aY/7mIZoh6V5v+YoemGi1Xxu7esvln
 Df/8yo9AQQTLY8W5tecR7b7WO1a4I3fmo4EZGUdr7P1iVZA9VtblZNP+hJ6NGpfBKEyI
 mqsrK1TIlYbsXW+0+xSyEG2SQ6G3IvStHhy9rIFAlthaDmjJc60CX0t6hvmJytXXHvSE
 uFyqBLO2FpIE215Cb88xDAMGP6CI+L7s3g114D+BadtxIe9Fx035UF/Q8OfmH/GjJ9LU
 AzgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjSlL68lX65J7Xz2nn15h7hgzC5dXzEsbwTcjZepeeSj/OczQvDK3FQhh+0KsA25FWR8LoKp4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1IaPrz9bEKgQRUvpZZ9PdvBXzrb/JzfcwmX2MJEoA1rjHXLyZ
 a7WadKM/PuXDODe2ySCDKFiO0XVb5w2boUtgmhkH2WND6S21ibC7Tq2fojl9f25UkX3wgp7r7G/
 yHm+f2/ZZbJ7u1wFCx9pG5V85ja5GzHLROxBN
X-Gm-Gg: ASbGnctZyyvL2VZkH0FD8uQDKQ0iTWEyiw02F/vYBRSgG7HzbzFSaAhjw0l8kgPJ2z6
 iwrPGXdTabH9+DNTccN1dL1W/dSLI1K7a
X-Google-Smtp-Source: AGHT+IEHxjmybLpLzVKeGVtx9pSIbjINHHLnsU4NA3iUHwbVNO9puzJ9Zwk9eiD44DU8T3+zoptb4KyjVk5QFPY9Fpc=
X-Received: by 2002:a17:90a:d407:b0:2ee:5958:828 with SMTP id
 98e67ed59e1d1-2ef011fba90mr5729136a91.9.1733255498974; Tue, 03 Dec 2024
 11:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
 <20241203194847.GA4022002@bill-the-cat>
In-Reply-To: <20241203194847.GA4022002@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:51:25 -0700
Message-ID: <CAFLszTgZiJuWMKZg6q--LEp+58Exgs8P+KaeCBgqmTd+B=SNSA@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 03 Dec 2024 21:08:57 +0100
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

Hi Tom,

On Tue, 3 Dec 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
> > Hi Simon,
> >
> > > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >
> > > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > There has been an LED framework in U-Boot which uses driver model for
> > > > > about 9 years now. Recent work is underway to improve it and provide
> > > > > more features. It is probably a good time to drop the old code, which
> > > > > is only used by 5 boards:
> > > >
> > > > I don't believe, from what I can tell, they are feature comparable, at
> > > > the very least I have not been able to get the Pinephone working with
> > > > this so as it stands I still don't think this patch set is ready yet.
> > >
> > > I don't have that hardware, nor the other 4, so cannot do anything
> > > with this feedback.
> >
> > Don't you have any HW that has a LED on it that you can substitute to
> > see what it does?
> >
> > > Can you please be clear what you are asking me to do?
> >
> > Either produce patches that work on the the pinephone, or docs I, or
> > other developers, can use to implement the functionality.
> >
> > Currently on the Pinephone the green LED lights up in the TPL/SPL
> > (very early before ATF) stage and is lit up right through the the
> > various FW stages, with your patch set I get no LED what so ever.
>
> Please note that needing to confirm that we have equivalent
> functionality between old and new frameworks (and
> https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
> might cover that) is why this series isn't ready for -next at this time.

Yes, I'm not sure if Peter saw that, so I sent him the link.

Regards,
Simon
