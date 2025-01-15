Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB77C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0F3806D4;
	Wed, 15 Jan 2025 15:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i/LYaYQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A6D806D8; Wed, 15 Jan 2025 15:44:35 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF9C80657
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so560896985a.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736952272; x=1737557072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oMRV+WnlaDa9+JKjWEzMMFtBgvdTohFmAW4Kj0cAtEk=;
 b=i/LYaYQhrgfxAfBVg4Cp5D7SZ0ff2J5+gBh/Nmw2mSNWBxBQ8VsO0aSfpW8t9GDekV
 kKLFH9MXf9KxUeUPZW1Wzzj1IgwpvMuGzMu3PPa8e0z8U5bF8vOw8OoP0zRvYmHMmVKD
 fCRcBwHYs6EXUL4j5fjlWr8WNhzIkvrEy08lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736952272; x=1737557072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMRV+WnlaDa9+JKjWEzMMFtBgvdTohFmAW4Kj0cAtEk=;
 b=PZ72RsqlW8an3zSObs/kr0yq9sHYXKEgtilIThUf6OdDH0D3DXv/+1NV4hFWgoJcCF
 99lgZYZhAtMal1mYDk8zahqQEUxogJZMFLiTvsA+aCAxLdgl95UOZW2384kZs1FFjPHC
 yxIuDpbtKrg4L93jGm5hGgulQJrGkI6kxne2l0yzwvTC1nq0bhbmTQZf7mcvFKU6x+k1
 rjyQ0moUHgOlfMBd0+MMFqRefCr0AQB8/ozRLt8hWRW6ZTAUKv8jRVlTao4bCgiB0/uL
 IkgQaDyUhTv0Abr+AgJWn1P/mDYErrweOjb1juVGuXU1PY9h6X5fnzKCSeCB3bNUMTHu
 lrXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKDnMDW3wC8YFY1m/Xb+2RqLIlBfpGtjnaXJ5Vwfh9B0Bg5knjwifa0ZON07zHQw1jdgLLpd0=@lists.denx.de
X-Gm-Message-State: AOJu0YwYHWlJTDEJvFrYHjw7ZI//V+pHIgQUxvni9YlIUktWhlVfucUB
 Z/oyEXxSD+/GHvXYrNEnLhT2o2y7q4jA3nxevsqrKxH4+oQMVxBWDWLkn7c9R18=
X-Gm-Gg: ASbGnct+saVSByO3xORHHkr6UVGdAJhl3ZuA176M3gcLUPV+F3Sw1KlQvg4jW9ZP62P
 btB6keFlOhdwPR6L0Zepmz7shGbtzQCy/pl3ZJaOtGD/9HhOwBguQNhpNgejXNGcVRc/QAOJw6/
 rfWaGCmdZ4F4NblhOFizLBCiZKaL3BT4yf3L1ujpoXA79CD9l0nz88NbhcZNuB80fHJ9CljX7oN
 ABplkcV90h42GvfbbmL4Fc3tGPhMfXspAXc29o8Rynn3EQmtoEQug==
X-Google-Smtp-Source: AGHT+IF/N6BuDpIytE7LYkrvKhIbnlSdN4JAL4MlsAooQ7pmaSG4ZWhfFR3aAwWdXkMnX+2buGZDBg==
X-Received: by 2002:a05:620a:4002:b0:7b6:d050:7213 with SMTP id
 af79cd13be357-7bcd970ddeamr4464862385a.19.1736952272324; 
 Wed, 15 Jan 2025 06:44:32 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce327b8a0sm723668385a.60.2025.01.15.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:44:31 -0800 (PST)
Date: Wed, 15 Jan 2025 08:44:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
Message-ID: <20250115144428.GZ3476@bill-the-cat>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="56Q83nXzduLBVFkX"
Content-Disposition: inline
In-Reply-To: <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
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


--56Q83nXzduLBVFkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/15/25 15:24, Patrice CHOTARD wrote:
> >=20
> >=20
> > On 1/15/25 14:19, Simon Glass wrote:
> >> Hi Patrice,
> >>
> >> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> >> <patrice.chotard@foss.st.com> wrote:
> >>>
> >>> Hi
> >>>
> >>> I am currently converting STM32MP platforms to OF_UPSTREAM.
> >>> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BU=
ILD_VENDOR=3Dy
> >>> and CONFIG_OF_UPSTREAM_VENDOR=3D"st" are set.
> >>>
> >>> So all dts/upstream/src/arm/st/* dts files are compiled.
> >>>
> >>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* =
and
> >>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
> >>>
> >>> To be more precise, these files are using a syntax which follows this
> >>> format &{label/subnode} to override some nodes.
> >>>
> >>> This leads to DTC error:
> >>>
> >>>  AR      drivers/usb/gadget/built-in.o
> >>>   LD      u-boot
> >>>   OBJCOPY u-boot.srec
> >>>   OBJCOPY u-boot-nodtb.bin
> >>>   SYM     u-boot.sym
> >>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-micro=
dev2.0-of7.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
> >>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
> >>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> >>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 s=
yntax error
> >>> FATAL ERROR: Unable to parse input tree
> >>>
> >>>
> >>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we g=
ot :
> >>>
> >>> &{qspi_bk1_pins_a/pins} {
> >>>         pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
> >>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
> >>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> >>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> >>>         /delete-property/ bias-disable;
> >>>         bias-pull-up;
> >>> };
> >>>
> >>> If i update it as following , the DTC compilation is OK :
> >>>
> >>> &qspi_bk1_pins_a {
> >>>         pins {
> >>>                 pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_=
IO0 */
> >>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO=
1 */
> >>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2=
 */
> >>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3=
 */
> >>>                 /delete-property/ bias-disable;
> >>>                 bias-pull-up;
> >>>         };
> >>> };
> >>>
> >>> On kernel side, the DTC compilation is ok, but not on U-Boot side. I =
am not able to understand the difference.
> >>>
> >>
> >> Could it be that the kernel dtc is newer?
> >=20
> > I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the same d=
tc version than kernel tag next-20250114
>=20
> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.

Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
because other changes it made grew the binary size for everyone and
didn't get back to it. I guess another attempt is in order.

--=20
Tom

--56Q83nXzduLBVFkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHycwACgkQFHw5/5Y0
tyyL2gv8CJpzYYFWTMkyLKN9f8VL1DSRrylXvplEKFQhC2i+U62/eID6jkPTkqfz
jF0b6IFG47EXlGo4/yUHQKVuI/674VV/MbdRsLGhW4PtMNSUVxQ1QL/pxilh20ss
+GW3ZIQ9AZuGMZxaGSIh9ioIPKEdgXZZhPENdCAX0dj/eEva41VVKVyRWu/hE/dc
aH6Sv3hZOrla0kmlhwEUvitc4OXqKt+EiiYTcMdvMxKEiFu3I55/ye58eLKeBIMw
axyoUnbISDEJyWSFi8CIC76priL6N+E/53wPN7DJuJonVxQDw8eVaBwpq2pPCwr/
hYxWp0UqPavRjDT8ZxU7MYfKZv9JyvNDSrttLJH6ql/DSA0CZKSPtOGmuoiTlYQC
GalbrAEUAncYZKDbWFY2XBV7nmF9pXNSYxbXPehhWL9aAyemTyjjdbsMN71/8yxY
zA0XkjsS/45TIoIhRFBQ/OAkQjR6WbsCat5GnSPn06W5YoA5q/G+edatzofzrOfN
2agxf+mM
=Mupi
-----END PGP SIGNATURE-----

--56Q83nXzduLBVFkX--
