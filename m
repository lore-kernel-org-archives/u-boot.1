Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA7DE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720048962E;
	Fri,  6 Dec 2024 16:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbybdVgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7CC89622; Fri,  6 Dec 2024 16:09:34 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB04489637
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a95095efso19742245e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733497771; x=1734102571; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RuEBLdI8jRsO1+jShht2b7UDWbNxN7lhsFz/SrQWD0=;
 b=EbybdVgf4AdAjs5iP28GVfKRdXAQDbl35sP/qBuoBViJa0PW4UDDH6CcLL9nsx75rp
 mBMZzbxY8BYW9/PjUbNSAE5R9m8+zhbgU2yDXdj6YZ7WW8ixNOL5EsNxPzFHbdGHsMh0
 tYQS4KSlxP8DzzGsvN/A+jbBlDRGQ7x5qYzSQ7Rb+tcz/ZTb0pVGeTSV5K109D2CGkET
 JIqbBRMyAM9xtO1g7zyF38mn6mE87gEp81FG1SFKxLDAvSXeHUvD/NVBAl5LFqRfxvd/
 3erZHdK8eV1BaY4pyochYWaGhRjDdJ6eEiyI9vbPdZLPHTfl8qLFDgrIbTRxsqrbziq4
 J0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497771; x=1734102571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RuEBLdI8jRsO1+jShht2b7UDWbNxN7lhsFz/SrQWD0=;
 b=l7nSr0zmKA2vFhuYB7N9JOlQ5d03HEYq0my8qO3Fp1rxA5kLO+vp45O7wfrUhCgU2x
 J1QFvDPtk1sGZ1hMaxDOes8NUTPu33UOSykYpvxn17e8bWmdgkK/4DXEBfX6Eaj4m8lm
 L+6eoBwGMAOEYPxRDCgsHw3/NaGYP4itQYJej4rIyUWzlTJlZwRjFhiA8WVl0nXXs6yH
 Og/uHxLdojyi4dU8QmyjEOZXVgAJEAjRvFtLw+mINY9pEIUEQLbqXD5W5TKzhTRc7Il1
 hJgGQ8dATBEhEDDpB1WMM/8REuT/fF68GHG3xtOI3SOQOve0wHwQVfwl/9piQtM3Cv8N
 42Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnmE9kCCqJrkCo83diZvtg3oa9kfAOhK5PLyVxcy/joP3jEwZ05tI5eQBq5Z9gIxOIHcVbS+k=@lists.denx.de
X-Gm-Message-State: AOJu0YzRsJU0e5gqXnNAUAHrpH0sWLCse3LPFV+QvhRFHStKCo9PFwMn
 kMI1ZpMulicb9wTL+VHRFRUWpb1exMQDAzB5SHq0m7KzkQLHKik6luc0eFSei5HWyKrjV5CZUD1
 5Nr/T+P3Z2QKso0X1waJm+flXs/M=
X-Gm-Gg: ASbGncuydKBxmcNC+TmpMh2h0BUweINCTwc6g7RGlzve0LPJgGwWJ31WIoaH4ptWUfA
 w5TGcPadTFMNMma58zePOhPTQFOz0mdmL
X-Google-Smtp-Source: AGHT+IHJ2n7WaRQK7TI8Q24U0jxBQKBkYF45PCbNYTMfCMdPJGkLCyJYBQQ5BYDvWc2Rz7ogj+IrkTxy2uWlanrl7ac=
X-Received: by 2002:a05:6000:2cb:b0:385:f79d:2196 with SMTP id
 ffacd0b85a97d-3862a8b4394mr3135767f8f.13.1733497770715; Fri, 06 Dec 2024
 07:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20241206060115.4346-1-clamor95@gmail.com>
 <20241206060115.4346-2-clamor95@gmail.com>
 <20241206142052.GQ2457179@bill-the-cat>
In-Reply-To: <20241206142052.GQ2457179@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Dec 2024 17:09:19 +0200
Message-ID: <CAPVz0n2mXefetq38_W-Xo8-2xTKUqxLXjz1MupmdaL8brnayxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver: clk: tegra: init basic clocks on probe
To: Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

=D0=BF=D1=82, 6 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 16:20=
 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Dec 06, 2024 at 08:01:15AM +0200, Svyatoslav Ryhel wrote:
>
> > In case DM drivers probe earlier than board clock setup is done
> > init of basic clocks should be done in CAR driver probe as well.
> > Add it to avoid possible clock related problems.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/clk/tegra/tegra-car-clk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegr=
a-car-clk.c
> > index 9078253d100..4f8405328a3 100644
> > --- a/drivers/clk/tegra/tegra-car-clk.c
> > +++ b/drivers/clk/tegra/tegra-car-clk.c
> > @@ -111,6 +111,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
> >  {
> >       debug("%s(dev=3D%p)\n", __func__, dev);
> >
> > +     clock_init();
> > +     clock_verify();
> > +
> >       return 0;
> >  }
> >
>
> Is this called before arch/arm/mach-tegra/board2.c::board_init()?
> Thanks.
>
> --
> Tom

It does if the device uses pmic with dm driver and has any of pmic
regulators set as always-on or boot-on
