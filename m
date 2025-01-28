Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E93C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84CD81DCD;
	Tue, 28 Jan 2025 15:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nVAeO+KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F57481E13; Tue, 28 Jan 2025 15:05:03 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B8B81B4B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d888fc8300so27900376d6.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738073100; x=1738677900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X4aiJa4H4KPhWN+0Nt/T9kaO4Vq/xTNa/i/pa7ganhU=;
 b=nVAeO+KRT2eCaLSPMfxsHnoMUB1BJDgo/t8njsJBRPS5dcWp0Cy0L1Yhsu31cAoCKV
 F1zKv3yLqVJZrCMupafvwKG5R46cNvFm3r47nLPSjsLCAZvBXdHHvJ7IATcfFLoK9RZX
 +Yhh49xPdIWl3D8eO6Sk5Imw51uA5+a+h4sSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073100; x=1738677900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4aiJa4H4KPhWN+0Nt/T9kaO4Vq/xTNa/i/pa7ganhU=;
 b=TW6gZQU5Pv/f0pcXJKHfk+QpXC+S3hCiBpwSkXeBr2RBbhDkVkWq6o5aR82i5y79Oi
 nvKsV0sSi35qTD5Lm88X8XgYOZdY3uqPNYXidlfpE73QMX3yIsvvHGiTg1hdBqw29Dic
 WzqePmNaClO8a7HyC9UwAc6W+r1cP0A4v1TpBomGZlNCyYvRLwCn+lW7nXfPCGBYkHWo
 3ALJYNX4qwXXONk0Ob3q/ihh+2MYCRmZXW/fTGVOR32IcoRq/WhF8yYlo+eoZSnfkdEq
 WEQwLaV3hJBAiWoC/H6OkXMkwJg3YUyFLDMJ7c+hV4VVFBmZBJRC+ljt6O2NpJvMEaKi
 Yz7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbsY8MysA1JalrjfXXOJKIHLvbno/OAY9+qla7h9L7wNIu/eFivNJeUcw8NX6mo5lvOJL6/A=@lists.denx.de
X-Gm-Message-State: AOJu0YwIPmUvOEGsIb5VNWwYpRbB6oAgxPerCoG6auDs12EMciPVq7XH
 WYw0pPmOb3qPklDsColKQzbnQuhkYnyyZono5j6ImPcbOgreyMpwx60MQiQoV24=
X-Gm-Gg: ASbGnctkfv6kli0UY+4H6bCcgDkoolJ862Myj6T6M521rrr1D/DOeEMFVNmFxx0pu/Q
 hyIX6TMYlS3D+yQOpTmCzHuNyt6WUapxvLRUvN8yPc066FhwSotDXWR1QHz0xYvC8WTXBTC3Eal
 yTzlq3uz3RRSjcjsF55Z/QdedxdbhnspyDgdvimi+v6JuXO2TJKbaqT+1mEPQCUksWuYF1BDXNw
 3oH2FHdl03ukjgIhZ0B/L6xQtBueeHXmxy5NY2ICEoZA2E6PYe7J/9XMwu433GxIlU1fMNb7fWK
 CdRzwUU4rK8UAsE=
X-Google-Smtp-Source: AGHT+IGGdGKaXkEYnsuVUz1fZ4+A5U6OX/EavV5CTiAZC1UXShzR4ELP0DkMclxY8yA65VJHXFE7Cg==
X-Received: by 2002:a05:6214:dcb:b0:6d4:254f:1c8e with SMTP id
 6a1803df08f44-6e1b21e2a5bmr721843706d6.37.1738073099805; 
 Tue, 28 Jan 2025 06:04:59 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20514efb3sm45345706d6.32.2025.01.28.06.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 06:04:59 -0800 (PST)
Date: Tue, 28 Jan 2025 08:04:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
Message-ID: <20250128140456.GJ1233568@bill-the-cat>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
 <20250115144428.GZ3476@bill-the-cat>
 <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u8aXWoFu6MOUBOvO"
Content-Disposition: inline
In-Reply-To: <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
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


--u8aXWoFu6MOUBOvO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/15/25 15:44, Tom Rini wrote:
> > On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
> >>
> >>
> >> On 1/15/25 15:24, Patrice CHOTARD wrote:
> >>>
> >>>
> >>> On 1/15/25 14:19, Simon Glass wrote:
> >>>> Hi Patrice,
> >>>>
> >>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> >>>> <patrice.chotard@foss.st.com> wrote:
> >>>>>
> >>>>> Hi
> >>>>>
> >>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
> >>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_=
BUILD_VENDOR=3Dy
> >>>>> and CONFIG_OF_UPSTREAM_VENDOR=3D"st" are set.
> >>>>>
> >>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
> >>>>>
> >>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1=
* and
> >>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
> >>>>>
> >>>>> To be more precise, these files are using a syntax which follows th=
is
> >>>>> format &{label/subnode} to override some nodes.
> >>>>>
> >>>>> This leads to DTC error:
> >>>>>
> >>>>>  AR      drivers/usb/gadget/built-in.o
> >>>>>   LD      u-boot
> >>>>>   OBJCOPY u-boot.srec
> >>>>>   OBJCOPY u-boot-nodtb.bin
> >>>>>   SYM     u-boot.sym
> >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-mic=
rodev2.0-of7.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
> >>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> >>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2=
 syntax error
> >>>>> FATAL ERROR: Unable to parse input tree
> >>>>>
> >>>>>
> >>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we=
 got :
> >>>>>
> >>>>> &{qspi_bk1_pins_a/pins} {
> >>>>>         pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
> >>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
> >>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> >>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> >>>>>         /delete-property/ bias-disable;
> >>>>>         bias-pull-up;
> >>>>> };
> >>>>>
> >>>>> If i update it as following , the DTC compilation is OK :
> >>>>>
> >>>>> &qspi_bk1_pins_a {
> >>>>>         pins {
> >>>>>                 pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK=
1_IO0 */
> >>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_=
IO1 */
> >>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_I=
O2 */
> >>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_I=
O3 */
> >>>>>                 /delete-property/ bias-disable;
> >>>>>                 bias-pull-up;
> >>>>>         };
> >>>>> };
> >>>>>
> >>>>> On kernel side, the DTC compilation is ok, but not on U-Boot side. =
I am not able to understand the difference.
> >>>>>
> >>>>
> >>>> Could it be that the kernel dtc is newer?
> >>>
> >>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the same=
 dtc version than kernel tag next-20250114
> >>
> >> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
> >=20
> > Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
> > because other changes it made grew the binary size for everyone and
> > didn't get back to it. I guess another attempt is in order.
> >=20
>=20
> Hi Tom
>=20
> Do you know when you will be able to provide a DTC update in master or ne=
xt branch ?

Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 to
be on top of current (the first step to moving to 1.7.0 or 1.7.1)
produced some test failures that don't exist when using the host dtc.
Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
just need to change to building pylibfdt and not dtc as well (as having
pylibfdt come via system python or pipx is differently tricky it seems).

--=20
Tom

--u8aXWoFu6MOUBOvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY5AQACgkQFHw5/5Y0
tyx8IAv6A3eh7ZtVVyy2HEUg+lesnVFnbf3AkytgOxbltX/2QEk9YOIusZY8QFRr
enOuYTkQlX5MzgrywLmWARgdT/Y9cwOK5zTS1DIfD6XA44b3EXIcA0FerH9J4r36
cqCscQoAXHkA+aWfqLWszq7NpKWFgSO63r9mw2E+c8v5vFJY+oMLJ+jThXuZNGmQ
86q611q2BcQ3FQczw0oRy5TYGokxmgdY6hKGbhTNpGh+edgB7Il1CvKxFAD+VSJT
xBSe2UBDO/rrbpa5+z2h7ahCWp5fXjfvaHVKzuuqACBcSFI8gBe811a6/Kn+D2lE
c6sOX7AEv5IUq3Eqey/UXvWGNgAoBImbeaVDfBmhY4KFttaKrUEfpQyaIyPQdbJV
owzDgU692DAmLMcT1rq8b6SyVDw1OdBKDZPvpyudos51TT9P+G/pe/FCFZ8t3TD5
DL4Has/rWaKCpHsjPokeSi0NAhKWTOrfjGAmUqk154MRIzPtvXRLTxQUxtXz4uvn
+pP4XGWK
=DRw5
-----END PGP SIGNATURE-----

--u8aXWoFu6MOUBOvO--
