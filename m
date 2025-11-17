Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173C4CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 16:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84CA783B99;
	Mon, 17 Nov 2025 17:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fX3Kug32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC82E83BFE; Mon, 17 Nov 2025 17:47:00 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C9883A8F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 17:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c28bf230feso5442299a34.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763398017; x=1764002817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GB/pDp5zjIu1jcWLkAY4Y6SqSr99YIhyOxObu3qP/mo=;
 b=fX3Kug32IsoMyRZbWlAo7BeUph+UCq6G3/Br52C1gI6U6c0JKJqQToqGRjRfTFel1t
 5uLUR1Up0X/4BieNDu0GX+96QCJOjG2tFVCS1fnD5hAY4O7GccmZFxEiBXKUUbK50sUu
 8wAHIbyWTIGHw/IZcv+zoQc7Oq70AEmTSyctA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763398017; x=1764002817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB/pDp5zjIu1jcWLkAY4Y6SqSr99YIhyOxObu3qP/mo=;
 b=i2Li40mJNupyrkDHNqx/K3fdMLdYu5gwft6cDDGe+o2WnhDzIGbnoUf5Re1LgN5Zh6
 b53iwu/Jc217lAPOWVK62Si38yee5Z3wpQJOm5OV9PKEN1YJIGItHlx9crU8GOSF/+kz
 17nOPict4C0WNUASCztN2UmMynkyPLRJ0yZutQ1KMEeWsFBswoJ3Ewobg5XALJUDbm6I
 pVXDzpx82n+8i/P+hkx/8Q5apPj+fKY0HX0jvn9ijVRhSmcCISASwu13etIL7DdVTZ9u
 /RKXs7UxReSC4az6ZvoYLFtajPWGhT8tz+YyiAiWmn2IWzFvnzA4FM2PaFm4qfFe/JaT
 yS/g==
X-Gm-Message-State: AOJu0Yz75yqyLLByTszLdlu8bL5m88EI8zfaF+hX+vqc1YeE6xAshPJ1
 bwBPFRqUmOChq8NrK7wfG0uzYdDUxyPE8XDWYF9HUpEONnAAlOWQnOwC1IhzqedDm9w=
X-Gm-Gg: ASbGnctuL8Wh/5EFL5k2cH39i5xGpxfnm5SANM2P7k65jPR/ZM28JQj6dxWCYx4BQ0d
 2zFvQbWTYYxiKkRMQO32ERPfIJUwfLky/XrKslp/9ad48FOAWkaSLnYgnq3UqCmjo7gu4N/6kdz
 VdJ+5Y4Y/lmDJOsyWNyrpd60NHC4XEvoRU6m/BaZ+S2wk+62/y3DQfkGjZ+yAVG2SkceNnaf7+P
 6VWiSw47ZwxcLZwujk3Hqnyil0NWYaeU0l14Chef0gfMp/ph/TExDMshlAQJ0+TkRz6V11pNed4
 E0IYmGLltxR1cuxPoZQPxJ2aoSosJIzhEXOEjRK1NBqa0lrHhOpG3lwNlPEPTe9VYHwsDjX/WjY
 v/eGwPVrtcBeN6XjhflErL6ViG2FhVRrqPhyjR4Go2ylvXPopmAqYWF7XSbYwaSEjgCaiZbJ3lu
 njr2Av4UygPjDo3teiDVfaos1jyUPyOhK4Av4SliLAHBbKed52/g==
X-Google-Smtp-Source: AGHT+IFtUAGsaFFArysNnqNuRa/ujVeQp377fLe1hQuTG7iPgtWrAHpK8H0+q23yPbsb0QzzI0wevg==
X-Received: by 2002:a05:6808:4a50:10b0:450:c46b:8149 with SMTP id
 5614622812f47-450c46b85a0mr1877653b6e.33.1763398017101; 
 Mon, 17 Nov 2025 08:46:57 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bddbasm5598947a34.27.2025.11.17.08.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:46:56 -0800 (PST)
Date: Mon, 17 Nov 2025 10:46:54 -0600
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
Message-ID: <20251117164654.GK2125796@bill-the-cat>
References: <dfa99b38-b75c-42da-b631-a158699b3f0b@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VJFj8sGrDdrzx97t"
Content-Disposition: inline
In-Reply-To: <dfa99b38-b75c-42da-b631-a158699b3f0b@foss.st.com>
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


--VJFj8sGrDdrzx97t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 09:33:03AM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/master, v2026.01 =3D u-b=
oot-stm32-20251117
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/28392
>=20
> Thanks
> Patrice
>=20
> The following changes since commit 365a7079fb918643da0f0709660a7d8ea76dd6=
f3:
>=20
>   Prepare v2026.01-rc2 (2025-11-10 11:30:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20251117
>=20
> for you to fetch changes up to 66e2e941cd44db9c642b64618bd16ef132fca83e:
>=20
>   ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM (20=
25-11-17 08:09:23 +0100)
>=20
> ----------------------------------------------------------------
> dhelectronics:
>   - Move dh_add_item_number_and_serial_to_env() to common code
>   - Read values from M24256 write-lockable page on STM32MP13xx DHCOR
>   - Add MAC address readout from fuses on DH STM32MP1 DHSOM
>   - Keep the reg11 and reg18 regulators always enabled on STM32MP13xx DHC=
OR.
>   - Fix boot for stm32mp15xx-dhsom.
>   - Fix build of ST DFU virt code on DH STM32MP1 DHSOM
>   - Introduce DH STM32MP13x target.
>=20
> STM32MP2:
>   - Add support for stm32mp257-dk board.
>   - Fix arm, smc-id value for stm32mp23/25.
>   - Fix stm32mp235f-dk boot (add syscon compatible, add txbyteclk).
>   - Add display support:
>     - Introduce LVDS driver.
>     - Add LTDC support.
>   -  Add Ethernet support for stm32mp255.
>=20
> STM32MP13:
>   - Add ADC support.
>   - Add power check for stm32mp135f-dk board.
>=20
> ----------------------------------------------------------------
> Asadeds (1):
>       arm: stm32mp25: add ethernet support for stm32mp255 series
>=20
> Marek Vasut (7):
>       ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due to ETZPC
>       ARM: dts: stm32: Keep the reg11 and reg18 regulators always enabled=
 on STM32MP13xx DHCOR
>       ARM: dts: stm32: Introduce DH STM32MP13x target
>       ARM: stm32: Add missing build of ST DFU virt code on DH STM32MP1 DH=
SOM
>       board: dhelectronics: Move dh_add_item_number_and_serial_to_env() t=
o common code
>       ARM: stm32: Read values from M24256 write-lockable page on STM32MP1=
3xx DHCOR
>       ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM
>=20
> Olivier Moysan (1):
>       adc: stm32mp13: add support of adc to stm32mp13
>=20
> Patrice Chotard (7):
>       ARM: dts: Add stm32mp257f-dk-u-boot.dtsi
>       ARM: dts: Fix "arm, smc-id" value for stm32mp23-u-boot.dtsi
>       ARM: dts: Fix "arm, smc-id" value for stm32mp25-u-boot.dtsi
>       ARM: dts: Add txbyteclk clock in stm32mp235f-dk-u-boot.dtsi
>       stm32mp: Add stm32mp23 support for syscon driver
>       configs: stm32: Enable ADC support for stm32mp13_defconfig
>       ARM: dts: Add st, adc_usb_pd property for stm32mp135-dk-u-boot
>=20
> Raphael Gallais-Pou (6):
>       ofnode: support panel-timings in ofnode_decode_display_timing
>       video: simple_panel: add support for "panel-lvds" display
>       video: stm32: STM32 driver support for LVDS
>       video: stm32: ltdc: support new hardware version for STM32MP25 SoC
>       video: stm32: ltdc: properly search the first available panel
>       configs: stm32mp25: enable LVDS display support

I'm fixing this up while merging but in the future it can be helpful to
run scripts/checkpatch.pl --git on a PR as I see a number of duplicate
signature warnings (which I fixed), and one spelling problem which I
also fixed.

--=20
Tom

--VJFj8sGrDdrzx97t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRtRdwAKCRAr4qD1Cr/k
Ch5QAQCxXw5nxyo7bsRxgAxKkeAtLB2mdGgkqVdxJ0wnd6ny7gD8CqnSH7GNy9Bb
RKQpGfjUCMBxM1CN5erHYiR3xUYReQg=
=Ihqn
-----END PGP SIGNATURE-----

--VJFj8sGrDdrzx97t--
