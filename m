Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C7CCEE355
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45D8839D6;
	Tue, 18 Nov 2025 21:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WaqYuPZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F373A839E4; Tue, 18 Nov 2025 21:50:11 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFC98398D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c75a5cb752so1868971a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763499008; x=1764103808; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vi1Vh6GczfW0X/m7CPkRjHz9SCS04d3SI3sUvwhvzY4=;
 b=WaqYuPZ02MoeMmee1mGTuWzysOIdAIE1bP8HhfZWl7lWFJYo5lU/pm0/OBwbFqaWSf
 W0mbz9e5wx4L4UzHhATciG2c/dO9M6Vm8JJEA6j86yYPSHKhvLaAFdEj8QbyXu0fmXLb
 PR5F9E3I4h7vGD1qpMXjUuwES30cYfdrSxbKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499008; x=1764103808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi1Vh6GczfW0X/m7CPkRjHz9SCS04d3SI3sUvwhvzY4=;
 b=TVfnxpj9aH3AtFs86BfGsYDpT3a7/blOHHOxbioaXXL4HoKoFEJFL4wWx8nexdfohg
 qPYSzw8kyH4hubkVvbp00MLHQ/1KtPfadaGDiQbvi+60WVbIm0dyebgRvBorGTWO1pTD
 4uqhPQwEo9dZNTF1dzF/27pJUuc/YxQW8pJvYlTZ0a/ddsBPXE5+yqk0WMVptnOzzUI+
 SjV7ydTc3cyn1cCbAMx+/XHVEHIBYWTzDHWhtuYLIm1HsJuKriR4qt/lidsATuCf1py8
 01hTJy4HOd2vvrkkFitx6Egfl/jmxdK7e34W1ZTcKhg6CHoafrsqcygPrjOHuDq1Jom6
 LHFg==
X-Gm-Message-State: AOJu0Yz088GqieUkoYJs/cH8+/cLSDYpJm/EAz4mBkNW+gfCt64Caq60
 NfCKiFijD4F3EJ1LkXkUOFR1q+iZFuixl6aDDXKhBtvunYct/Zk9JVAF9SSNaVA6658=
X-Gm-Gg: ASbGncvqTFETgIAzQcVtCs5e5Fe+W+S0DV9GrkhGDr9uxHW/5YqFYDODKbAYNpESnXP
 1k539dBNKzscX+d2SQDuasN6PS955lgBo2L6LyZ9P+CpxWi6VI3kB/mDhQsqhXzg5OHdJwbw7Xz
 yZ8SUK05qSqj8lLN2Pxty8zKBD64MzdrGJh4jkZ6FxnPaw+tzYHtI/8qOJh/TeLAtKqb7NLRKpB
 GhCi8Am8IVMaaEM6DotAfYlm/xpLTznh3bQmqs+MROLi2c6Ejw4j+y5zWXR9+AiV/aNwtnkVsCF
 G9IwYlrpWhomBk1TTsuxEp2dS0I/sWpNpuR09Op3DQaTTPScu/u81iyBrCc0LwjqylbByTATk68
 omN0DqXC0A6N3Zirj6mGUF83Q2x3YiztfHZ/M+A3mtfeVhS+kNJgskHGNRihbikbcBFxCqAHb5F
 kQpEZNHEgyNKTN8cfgf+WG9bS+Nkq4zQrkLp4pcPTTXAUXtjvP/Q==
X-Google-Smtp-Source: AGHT+IHSpyiUQZsjk6wGycJIZfKncW5tectHyNxdfeyyUI6FAVS+YDm2oiixfz2wJWCt9vXyjr90cQ==
X-Received: by 2002:a05:6808:2229:b0:441:8f74:faa with SMTP id
 5614622812f47-450efa72e1emr277567b6e.55.1763499008013; 
 Tue, 18 Nov 2025 12:50:08 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450d5ffdc84sm1626105b6e.19.2025.11.18.12.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:50:07 -0800 (PST)
Date: Tue, 18 Nov 2025 14:50:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Asadeds <md.asadullah@eds-india.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.01 =
 u-boot-stm32-20251117
Message-ID: <20251118205005.GV2125796@bill-the-cat>
References: <dfa99b38-b75c-42da-b631-a158699b3f0b@foss.st.com>
 <20251117164654.GK2125796@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="97LScv8mu2W9Er76"
Content-Disposition: inline
In-Reply-To: <20251117164654.GK2125796@bill-the-cat>
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


--97LScv8mu2W9Er76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:46:54AM -0600, Tom Rini wrote:
> On Mon, Nov 17, 2025 at 09:33:03AM +0100, Patrice CHOTARD wrote:
>=20
> > Hi Tom
> >=20
> > Please pull the STM32 related patches for u-boot/master, v2026.01 =3D u=
-boot-stm32-20251117
> >=20
> > CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeli=
nes/28392
> >=20
> > Thanks
> > Patrice
> >=20
> > The following changes since commit 365a7079fb918643da0f0709660a7d8ea76d=
d6f3:
> >=20
> >   Prepare v2026.01-rc2 (2025-11-10 11:30:56 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-s=
tm32-20251117
> >=20
> > for you to fetch changes up to 66e2e941cd44db9c642b64618bd16ef132fca83e:
> >=20
> >   ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM (=
2025-11-17 08:09:23 +0100)
> >=20
> > ----------------------------------------------------------------
> > dhelectronics:
> >   - Move dh_add_item_number_and_serial_to_env() to common code
> >   - Read values from M24256 write-lockable page on STM32MP13xx DHCOR
> >   - Add MAC address readout from fuses on DH STM32MP1 DHSOM
> >   - Keep the reg11 and reg18 regulators always enabled on STM32MP13xx D=
HCOR.
> >   - Fix boot for stm32mp15xx-dhsom.
> >   - Fix build of ST DFU virt code on DH STM32MP1 DHSOM
> >   - Introduce DH STM32MP13x target.
> >=20
> > STM32MP2:
> >   - Add support for stm32mp257-dk board.
> >   - Fix arm, smc-id value for stm32mp23/25.
> >   - Fix stm32mp235f-dk boot (add syscon compatible, add txbyteclk).
> >   - Add display support:
> >     - Introduce LVDS driver.
> >     - Add LTDC support.
> >   -  Add Ethernet support for stm32mp255.
> >=20
> > STM32MP13:
> >   - Add ADC support.
> >   - Add power check for stm32mp135f-dk board.
> >=20
> > ----------------------------------------------------------------
> > Asadeds (1):
> >       arm: stm32mp25: add ethernet support for stm32mp255 series
> >=20
> > Marek Vasut (7):
> >       ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due to ETZPC
> >       ARM: dts: stm32: Keep the reg11 and reg18 regulators always enabl=
ed on STM32MP13xx DHCOR
> >       ARM: dts: stm32: Introduce DH STM32MP13x target
> >       ARM: stm32: Add missing build of ST DFU virt code on DH STM32MP1 =
DHSOM
> >       board: dhelectronics: Move dh_add_item_number_and_serial_to_env()=
 to common code
> >       ARM: stm32: Read values from M24256 write-lockable page on STM32M=
P13xx DHCOR
> >       ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHS=
OM
> >=20
> > Olivier Moysan (1):
> >       adc: stm32mp13: add support of adc to stm32mp13
> >=20
> > Patrice Chotard (7):
> >       ARM: dts: Add stm32mp257f-dk-u-boot.dtsi
> >       ARM: dts: Fix "arm, smc-id" value for stm32mp23-u-boot.dtsi
> >       ARM: dts: Fix "arm, smc-id" value for stm32mp25-u-boot.dtsi
> >       ARM: dts: Add txbyteclk clock in stm32mp235f-dk-u-boot.dtsi
> >       stm32mp: Add stm32mp23 support for syscon driver
> >       configs: stm32: Enable ADC support for stm32mp13_defconfig
> >       ARM: dts: Add st, adc_usb_pd property for stm32mp135-dk-u-boot
> >=20
> > Raphael Gallais-Pou (6):
> >       ofnode: support panel-timings in ofnode_decode_display_timing
> >       video: simple_panel: add support for "panel-lvds" display
> >       video: stm32: STM32 driver support for LVDS
> >       video: stm32: ltdc: support new hardware version for STM32MP25 SoC
> >       video: stm32: ltdc: properly search the first available panel
> >       configs: stm32mp25: enable LVDS display support
>=20
> I'm fixing this up while merging but in the future it can be helpful to
> run scripts/checkpatch.pl --git on a PR as I see a number of duplicate
> signature warnings (which I fixed), and one spelling problem which I
> also fixed.

For the record, this is applied and pushed out (and b4 got mad about the
changes I made and didn't think it was merged so I couldn't do a b4 ty).

--=20
Tom

--97LScv8mu2W9Er76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRzb+QAKCRAr4qD1Cr/k
CnWPAQC/uYfH9tu8dD+CLH1kc9IiecEWx1dqCmMDjYK4DKJCDAEAvcdal10kVd+/
sgs0vrTCw8iu4AMpnlMJnppU+XMIvw8=
=K+CG
-----END PGP SIGNATURE-----

--97LScv8mu2W9Er76--
