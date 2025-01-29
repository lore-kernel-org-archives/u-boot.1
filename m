Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A35C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AEDC80AE4;
	Wed, 29 Jan 2025 23:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wrr9mX66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE6380BAE; Wed, 29 Jan 2025 23:01:35 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53BD805E2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so1614836d6.2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738188091; x=1738792891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Dqqd+c5qkV/p7thJorvThmEivVfgBv45h8qfoijG/A=;
 b=Wrr9mX66SLuCfQQW0X2cujpedyIbJhriT5utFOVtNPX0vksLnUew0lZ5y2H0kc4n2R
 eXjs35E4j307YMKw+r0yGjfK6SIOodekb9vtwwqCh45ndajy/LyoHv+AKrpM+9GSoLUK
 CfYOoOCniorG25yjWnEztHqdhcOoEfj9LbYCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738188091; x=1738792891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Dqqd+c5qkV/p7thJorvThmEivVfgBv45h8qfoijG/A=;
 b=bFSpXk+xxklhCNHOBd/oYLQkAw/RXA0y/HvSgEnOVnUOwnzBGSSXUfyDIOC217HlWK
 w6qNLZIfgm4EhJfnOBfxyCPvfe3N9/ljCaR0z68Brn08HkCv9AbdQZP6QWfLENXNRRnW
 53FXje6mg/POZupbcmpK5ZwqrdCtu9ENwpOW1NLwQbvWJ6jz3qmibPxhSmTaSeUlz2Sj
 0kedWZB7jnyxJGuGR7KzLe6kLrO4TzHtKUf9qgwoKn+HGw4v1c9wio+E3p8nnYhHEjYa
 pYwF29tWw2ZxfLDxU//qNSVP1EqAEfTOry1lnQf+SNuCt2sqo6nqo6SDpbV2o5O87u8k
 q1jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEtl8MQL6LtfAtBmwq82CzK8Xc/3LMAUBqGswkDE7UCDek7U0LMMwPO1J9K7ayxhKpPWSV7Yk=@lists.denx.de
X-Gm-Message-State: AOJu0YytSvG/Y/H+ebCI1hPlSxVyQO+lbsEQj3F7KdCOWKygmwHiYIfZ
 GD8hDG9lHFDTZgMT8IYZTtYwITPM5h2HtNEXkIQ6IvuE1VFYIA5KnDqCxbkqySM=
X-Gm-Gg: ASbGncvf0Zq6bOqk3b0bhzrQC84PG9iUIkiUKlSWOg0tW3OEINPbQ2qcfw9959AW3lv
 zncUZ0OElE6sNVo/VVQ+/7x2P+yKN30zMuE2/pgrfNurE7MOvdrw6CGXGanQ+KqZlvze0CGWFtn
 9XRTH/zXfDNL1etqXPwFI2OgwrxBTgIepoJcvrQUCjkk+Z/JM8Ihsnd9DFEIXaSWuDrJLdlmbDs
 TG8EAI9FXo+cAM4xu2SGnpoC+wwK4Wd2KJgXb4XD+D1X5djHup2a6GWgzX4lEVN8VGfYHxhOqj1
 EcqGc1ctZh2z22M=
X-Google-Smtp-Source: AGHT+IHqpMk+mQ8WMC5yZZSIgJ24mGtSxWYDyVIxBgy4YePT5kWAM5KFJEJrAdnB7rq/WT7bScCZSg==
X-Received: by 2002:a05:6214:2a84:b0:6e1:700e:488a with SMTP id
 6a1803df08f44-6e243bf41c8mr66309096d6.22.1738188091255; 
 Wed, 29 Jan 2025 14:01:31 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a890fsm59096516d6.88.2025.01.29.14.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 14:01:30 -0800 (PST)
Date: Wed, 29 Jan 2025 16:01:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
Message-ID: <20250129220127.GW1233568@bill-the-cat>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
 <20250115144428.GZ3476@bill-the-cat>
 <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
 <20250128140456.GJ1233568@bill-the-cat>
 <20250128150426.GP1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XyX0GY3GQNBE3zbw"
Content-Disposition: inline
In-Reply-To: <20250128150426.GP1233568@bill-the-cat>
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


--XyX0GY3GQNBE3zbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 09:04:26AM -0600, Tom Rini wrote:
> On Tue, Jan 28, 2025 at 08:04:56AM -0600, Tom Rini wrote:
> > On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
> > >=20
> > >=20
> > > On 1/15/25 15:44, Tom Rini wrote:
> > > > On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
> > > >>
> > > >>
> > > >> On 1/15/25 15:24, Patrice CHOTARD wrote:
> > > >>>
> > > >>>
> > > >>> On 1/15/25 14:19, Simon Glass wrote:
> > > >>>> Hi Patrice,
> > > >>>>
> > > >>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> > > >>>> <patrice.chotard@foss.st.com> wrote:
> > > >>>>>
> > > >>>>> Hi
> > > >>>>>
> > > >>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
> > > >>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTR=
EAM_BUILD_VENDOR=3Dy
> > > >>>>> and CONFIG_OF_UPSTREAM_VENDOR=3D"st" are set.
> > > >>>>>
> > > >>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
> > > >>>>>
> > > >>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-p=
rtt1* and
> > > >>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
> > > >>>>>
> > > >>>>> To be more precise, these files are using a syntax which follow=
s this
> > > >>>>> format &{label/subnode} to override some nodes.
> > > >>>>>
> > > >>>>> This leads to DTC error:
> > > >>>>>
> > > >>>>>  AR      drivers/usb/gadget/built-in.o
> > > >>>>>   LD      u-boot
> > > >>>>>   OBJCOPY u-boot.srec
> > > >>>>>   OBJCOPY u-boot-nodtb.bin
> > > >>>>>   SYM     u-boot.sym
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1=
-microdev2.0-of7.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
> > > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.d=
tb
> > > >>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> > > >>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338=
=2E1-2 syntax error
> > > >>>>> FATAL ERROR: Unable to parse input tree
> > > >>>>>
> > > >>>>>
> > > >>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dts=
i we got :
> > > >>>>>
> > > >>>>> &{qspi_bk1_pins_a/pins} {
> > > >>>>>         pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO=
0 */
> > > >>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 =
*/
> > > >>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> > > >>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> > > >>>>>         /delete-property/ bias-disable;
> > > >>>>>         bias-pull-up;
> > > >>>>> };
> > > >>>>>
> > > >>>>> If i update it as following , the DTC compilation is OK :
> > > >>>>>
> > > >>>>> &qspi_bk1_pins_a {
> > > >>>>>         pins {
> > > >>>>>                 pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSP=
I_BK1_IO0 */
> > > >>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_=
BK1_IO1 */
> > > >>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_B=
K1_IO2 */
> > > >>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_B=
K1_IO3 */
> > > >>>>>                 /delete-property/ bias-disable;
> > > >>>>>                 bias-pull-up;
> > > >>>>>         };
> > > >>>>> };
> > > >>>>>
> > > >>>>> On kernel side, the DTC compilation is ok, but not on U-Boot si=
de. I am not able to understand the difference.
> > > >>>>>
> > > >>>>
> > > >>>> Could it be that the kernel dtc is newer?
> > > >>>
> > > >>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the =
same dtc version than kernel tag next-20250114
> > > >>
> > > >> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
> > > >=20
> > > > Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
> > > > because other changes it made grew the binary size for everyone and
> > > > didn't get back to it. I guess another attempt is in order.
> > > >=20
> > >=20
> > > Hi Tom
> > >=20
> > > Do you know when you will be able to provide a DTC update in master o=
r next branch ?
> >=20
> > Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 to
> > be on top of current (the first step to moving to 1.7.0 or 1.7.1)
> > produced some test failures that don't exist when using the host dtc.
> > Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
> > just need to change to building pylibfdt and not dtc as well (as having
> > pylibfdt come via system python or pipx is differently tricky it seems).
>=20
> The pipeline is at
> https://source.denx.de/u-boot/u-boot/-/pipelines/24243 and that's just
> the v5 branch currently under WIP/ rebased to then-current master.

To push this as far as I can at least, there's now also
WIP/resync-dtc-v1.7.1-v1 which brings us to dtc-1.7.1 (good!) but also
some silent failure to boot on a least one of the TI K3 platforms I
have, and some other failures in CI too.

--=20
Tom

--XyX0GY3GQNBE3zbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeapTMACgkQFHw5/5Y0
tyxQhgv7BkH0YmuWqZSX5qwx9ogD1eAQ2wmqdK4TlZYyQqppMvkNw9AcwRwsSY7F
ooPwAyhneyyTh0Buf0n/MTEIq998l3KkORBxnTB4gIKASbMtf+PjGwUrAHyxHLpo
AeS4puBRogA48976ett4x7Ptp9F2cpdJC8DDpwhV9DPaG/azJligpfkKAWG5hNrf
dtWfGOlW0YTlK3CtqfqtNpFTgVJEw1EVLNWL2SbyocIcb1BvyJzJ14vEbqpUvWLC
idmpA7PBWfwKoQzDCc+UkTutu044RngBe8VYx7hMEO+DI/zJERmObkb+X0hQE3Cc
w005Bo6Si3neO/uYB0MNZhxwa8w+F0MZHhNX/mMHfgI8PFVgd+Hb2EVIPgEBcuiM
OH5nKnXKtY1hqyWaBE6+wP1UCUoxY+NWeyXOwIDsBhPcMgL0/ajjrRaLyBtuf5i+
ZpCUxVKq9DZo3pBpXyAL8rMkvNl/S0uRn7j1U378dQddHUNIySJAaOdivxsp/6QI
VxIBBcN6
=4Z9p
-----END PGP SIGNATURE-----

--XyX0GY3GQNBE3zbw--
