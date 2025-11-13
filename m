Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E515BCD8CB0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 17:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7868283FC6;
	Thu, 13 Nov 2025 18:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iXbn8MnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9868083FBF; Thu, 13 Nov 2025 18:46:29 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4FE83FC6
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 18:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c70fcc8561so425414a34.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763055986; x=1763660786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Alb5dvqR3kEEvrR+vWKK9n8gphKNJI7ROgugzjQyhhM=;
 b=iXbn8MnAqWe/gwzHzyKSStfazMb3NIFxARhKO2dr4MegvY7q4JfpZvTRCK+80PUz/9
 0wCMp6P+bPS4p4yyc3aZbSPG5FogZ6vsBjIIe1EMN5Db3ysuwcydoc2wqMzdPoe/JmeG
 xpo+cwzGWPydmdGg2thJRbylPXue9lTh1Eh8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763055986; x=1763660786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Alb5dvqR3kEEvrR+vWKK9n8gphKNJI7ROgugzjQyhhM=;
 b=Lyfl9XGvgZ0rkU0QYEffgEGr8VxjiWt1okYxwBbr+VhCCJZMW4B/ETMP3sC2dE5a7b
 8oKCP+N9Jl8u68kUqmk4jpePM//iFetOAFwNfd7w9KHzmXmw4B474aT75PH9bdrtov2q
 luthAUk/aWMBFMkJ6uZpzxd+0/A4QL3B4za8QT/Nwe2TBOD9MKCglEekAxZBZbG1waYZ
 ATTjjGY4SGDF2p2nmbSIMp7MnrBT5S/XUkC/zJa+HZ0x+6yGOhQGcGQZmE0drl3fz92w
 2RiBaVJxXKfc9hvfaPxq2NsHpL7n/JNV49nQ0z3XoDjmuJcxATebOYoDZScVdy9t6Xgi
 6jHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMzBBC0AliSr+TvQZcd66XMkTYlXy/hWM2tUa8zYJL3kx4FJ/Dl4em8j/F6mK5Ery4/sylsSc=@lists.denx.de
X-Gm-Message-State: AOJu0YxOv1ZClVSg6s1D4vJbqIiae2Ti0cBy/4W/ZPBFIRsXZJNvz8N7
 rJ7/dnrIhy/5f5HYrjFOQbrMHza+q4R8HmmKdDxsKEdMimBPnREm9G8Kx+jHxePFIHU=
X-Gm-Gg: ASbGnctaxZ+q6hWfHf5C9hdGfDoK0yudoAbeMxfGQ5En7u1t41sAr7Tm1e47x+rtUS4
 Rzo3SFXhI/HoyF8HbF155EDPj9gObhfkofy3EQsjIAMpuDlmSVWoZ6dthyt3v3r8Wc2T2Zu0jop
 0UvmOpBMLtVC1oH3e3RAmvye3jG1SA36cudq44rObrmdg3TcyULyHKNcukdm9PJEHEZyl5gMj3B
 zV0XxeYJuQA0cqc/Z2B1jxbqyJ/5uVGymeI7gShRXO3WYQZw2eO8RRssBw8OV7wBt3MiqmQ6uJ7
 pWSh4Qg+O7SRWr8WsfjJQhxj/SVOeoBKuYKq629AWqtaG8LBE89nlaqeB7IKNdzyRRu6N/rx1se
 kPAK7qsTDncaflmXZWkKx8iY8eNSnoNZPaGKksXaHdKVC2M9RgSY47xT5tFXTSupJ7/pk0W4tv2
 ewdgZbnKlJeT5Y5/Ai6uTNijFsAn4dSSTQZSF7JhE=
X-Google-Smtp-Source: AGHT+IH9O8czq7gWKeMmaKXZhKRrucpK4cg9UuCq64n+c/HetRQ2zmeGNvgtm9E0dIrVokIlhS/4WQ==
X-Received: by 2002:a05:6830:6da0:b0:7c5:31b6:435c with SMTP id
 46e09a7af769-7c74453907bmr200760a34.29.1763055985898; 
 Thu, 13 Nov 2025 09:46:25 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a29d716sm1579419a34.13.2025.11.13.09.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:46:25 -0800 (PST)
Date: Thu, 13 Nov 2025 11:46:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Ziping Chen <techping.chan@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 03/11] doc: cmd: document the led shell command
Message-ID: <20251113174622.GL6688@bill-the-cat>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
 <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c94XsnvcoPcc0VY7"
Content-Disposition: inline
In-Reply-To: <c10c2b6b-5daa-4128-aeae-977bb0f72be9@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--c94XsnvcoPcc0VY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:58:23AM +0100, Quentin Schulz wrote:
> Hi all,
>=20
> On 11/12/25 6:48 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> >=20
> > This adds documentation on how to use the led shell command.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >   doc/usage/cmd/led.rst | 95 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 95 insertions(+)
> >=20
> > diff --git a/doc/usage/cmd/led.rst b/doc/usage/cmd/led.rst
> > new file mode 100644
> > index 00000000000..b5623895c7e
> > --- /dev/null
> > +++ b/doc/usage/cmd/led.rst
> > @@ -0,0 +1,95 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +.. index::
> > +   single: led (command)
> > +
> > +led command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Synopsis
> > +--------
> > +
> > +::
> > +
> > +    led <led_label> <on|off|toggle>
> > +    led <led_label> blink <blink-freq in ms>
> > +    led <led_label>
> > +    led list
> > +
> > +led <led_label>
> > +---------------
> > +
> > +Get state of the LED whose label is the one passed as ``<led_label>`` =
argument.
> > +
> > +Provided ``<led_label>`` is *module_led*, the possible outputs for thi=
s command
> > +are::
> > +
> > +    LED 'module_led': off
> > +    LED 'module_led': on
> > +    LED 'module_led': blink
> > +
> > +led <led_label> on|off|toggle
> > +-----------------------------
> > +
> > +Turn on, off or toggle state of the LED whose label is the one passed =
as
> > +``<led_label>`` argument.
> > +
> > +led <led_label> blink <blink-freq in ms>
> > +----------------------------------------
> > +
> > +Make the LED whose label is the one passed as ``<led_label>`` argument=
 blink at
> > +a frequency specified by the argument ``<blink-freq in ms>``.
> > +
> > +The frequency is parsed as a decimal number and its unit is millisecon=
ds. The
> > +duty cycle is 50%. Example::
> > +
> > +    led blue blink 1000
> > +
> > +will make the *blue*-labeled LED blink with a state (on or off) kept f=
or 500ms
> > +before switching to the other state (respectively off or on) for 500ms,
> > +looping endlessly.
> > +
> > +led list
> > +--------
> > +
> > +List all available LEDs by their label and provide their known state, =
which can
> > +be either *off*, *on* or *blink*.
> > +
> > +If a LED has not been probed yet, its state will be shown as *<inactiv=
e>* in the
> > +list.
> > +
> > +Examples
> > +--------
> > +
> > +::
> > +
> > +    =3D> led list
> > +    module_led      on
> > +    sd_card_led     <inactive>
> > +    =3D> led module_led
> > +    LED 'module_led': on
> > +    =3D> led module_led off
> > +    =3D> led module_led
> > +    LED 'module_led': off
> > +    =3D> led module_led toggle
> > +    =3D> led module_led
> > +    LED 'module_led': on
> > +    =3D> led module_led toggle
> > +    =3D> led module_led
> > +    LED 'module_led': off
> > +    =3D> led module_led blink 1000
> > +    =3D> led module_led
> > +    LED 'module_led': blink
> > +    =3D> led sd_card_led
> > +    LED 'sd_card_led': off
> > +    =3D> led list
> > +    module_led      blink
> > +    sd_card_led     off
> > +
> > +Configuration
> > +-------------
> > +
> > +The *led* commands are only available if ``CONFIG_CMD_LED=3Dy``.
> > +
> > +The *led <led_label> blink* command is only available if ``CONFIG_CMD_=
LED=3Dy``
> > +and either ``CONFIG_LED_BLINK=3Dy`` or ``CONFIG_LED_SW_BLINK=3Dy``.
> >=20
>=20
> It seems like there's another led shell command that you can build with
> CONFIG_LED_STATUS_CMD=3Dy that uses the legacy LED API... Should it be
> mentioned/have its own documentation page?
>=20
> Maybe we should spend time porting the 5 defconfigs that make use of this
> legacy API to the new one and entirely retire the legacy LED API. However,
> there seems to be some discrepancies between the LED_BOOT behavior and th=
at
> of CONFIG_LED_STATUS_BOOT. The former blinks for a brief period of time a=
nd
> then is solid on once reaching U-Boot's main loop. The latter is blinking
> sometime after relocation and then turned off on first BOOTP packet.
>=20
> Out of the 5 defconfigs, 3 are using GPIO LEDs with CONFIG_LED_STATUS_GPI=
O=3Dy
> so it shouldn't be too difficult to migrate to the new API just to get the
> LEDs working (I am not talking about keeping the same behavior). The other
> two are configs/eb_cpu5282_defconfig and
> configs/eb_cpu5282_internal_defconfig which I assume are for the same
> product, but it has not seen actual updates (aside from tree-wide
> migrations) in the last 13 years. From what I could tell, this is also GP=
IO
> leds, but controlled by writing directly to the GPIO registers instead of
> using a driver. Maybe we can issue a deprecation notice and tell the
> maintainers/users of that board they have X releases to migrate else it g=
ets
> support for the LEDs removed.
> For the other boards, we probably need to check how to use the DT for the
> LEDs that are currently configured via the legacy API.
>=20
> This is at the end of my todo list though.

Yes, when discussions around the legacy LED stuff have come up, it's
come down to now that we finally have nominal parity in APIs, can we
migrate the older users? For the two m68k platforms, I'm OK with just
removing the code and letting someone that has interest and can test
re-introducing the functionality. Of the other three, I think pinephone
is the hardest / most important case. I forget if previous migration
attempts ran in to non-obvious problems.

--=20
Tom

--c94XsnvcoPcc0VY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRYZawAKCRAr4qD1Cr/k
Co9kAQDDNzOZWNCxu1BEHtjQCVaY5UUWvszZhWhTIvLassEKrAD/VlwKCuhFmHL2
TA7DsL80CTOyOQHfrJys8zzBok4baAg=
=yMNN
-----END PGP SIGNATURE-----

--c94XsnvcoPcc0VY7--
