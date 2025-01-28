Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5997CC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 15:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81CF881DFA;
	Tue, 28 Jan 2025 16:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oXPS0pO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2594E81E13; Tue, 28 Jan 2025 16:04:34 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8369881DD3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 16:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b702c3c021so566452385a.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738076670; x=1738681470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fK0koiY9e6boyrHlHPGmBknAykzvBAcDRFGnxxVDTCI=;
 b=oXPS0pO2SpepLnI0F3/FCy2td2Bu4CI1Zyz0ehl/VHUNHwZA7obmreG7PPUGl1z4E2
 oZFq30U4oeEBeLT8PgKoRASjbccVBbee4mIjI/sOzHq3KI/yrZ/bTuA7yLkwCpGYDVTo
 DlL/7EL073EOtpV5t6p2SSbj8vivZ/2e6QIo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738076670; x=1738681470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fK0koiY9e6boyrHlHPGmBknAykzvBAcDRFGnxxVDTCI=;
 b=lrlB9CkwxEB/mvufbKMwLuCFL7L60kXjmZtCSy1+ifQuB+PVXrevsG9TxCTwyxabQO
 VFClSkGJxWzW2XXYC5f1SO9N/X0ZeovUrYpqQi+IfJeMfgd/hNKdC2FqCoFaE0HY1x5Y
 V0dIyqREDzMNMAN0OcWmlYTVkmYIxK2fmWEl/41aVRc+MHpX+VEfZaGLZe8R3P5cAzK1
 u55js2E2ewEMhjol6cSK6cvW4Ci3LCa9Mb3r/JO10m5bfATmVbv0+W9Hk+kFOQEjx31A
 T+g+/Pge0yiwTgrXYijybj8IXBPjS0rPcoC1Bml2GTadp++d6eCVL5rllWducUd9J4CE
 Om4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWkhr6GN+U4uUARXyAWJrc7symYzjp/g8v3iMNBeddL4KJRzAfsWsR2pJCICgaJP8i3+wupqs=@lists.denx.de
X-Gm-Message-State: AOJu0YzduEHv1X6/ToPnpyNH/xYsof6H5k4HbYpvvOIjb7tgJz7v7ta2
 VMvAZFzEWzi+fVCdXJkhBRnAur2lAlSI8KsMSfcoO001PDhjNQ0y4eEMXczpB+w=
X-Gm-Gg: ASbGncuN1B1uelw2fhQmyM/qPc7vjyO6WyJE73C19v6hTHHqKswdVrdsS8+dg7R+Baa
 cGLWGfMvMOVjjXDU6+UfK2P1lHD0L3mkYyqOUbHQdgsIdVIZxtLTF+Wl17+34jXVaMYC1gHejUq
 XpQLpM5ymOdEt1LWn7wpILSNu3ceUiP7FyBWVIqnm6J3ZmVDCNYLRs3RLd9x3e0qTBRlSWJ3dE+
 ma6Y9ac6gPCPkqyIq56ZAz07+A/BmbmdyAIe+3oRSomdRBqunHEtcvS182yohXk7egJeUxxRFSD
 Eu/SVSe0lpsZ3lo=
X-Google-Smtp-Source: AGHT+IHjxihrM4X9vlTfuMvPWfS0ZpnsurhtyMTyo8i/IBn2C/8t3zlP/iideVMZgDyA/XVgDQKwWg==
X-Received: by 2002:a05:620a:46ac:b0:7b7:342:a0a5 with SMTP id
 af79cd13be357-7be6325c750mr8256551485a.55.1738076670229; 
 Tue, 28 Jan 2025 07:04:30 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae7dcf8sm520398285a.5.2025.01.28.07.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 07:04:29 -0800 (PST)
Date: Tue, 28 Jan 2025 09:04:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
Message-ID: <20250128150426.GP1233568@bill-the-cat>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
 <20250115144428.GZ3476@bill-the-cat>
 <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
 <20250128140456.GJ1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tU8ZFqBYNW0kvKVh"
Content-Disposition: inline
In-Reply-To: <20250128140456.GJ1233568@bill-the-cat>
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


--tU8ZFqBYNW0kvKVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 08:04:56AM -0600, Tom Rini wrote:
> On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
> >=20
> >=20
> > On 1/15/25 15:44, Tom Rini wrote:
> > > On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
> > >>
> > >>
> > >> On 1/15/25 15:24, Patrice CHOTARD wrote:
> > >>>
> > >>>
> > >>> On 1/15/25 14:19, Simon Glass wrote:
> > >>>> Hi Patrice,
> > >>>>
> > >>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> > >>>> <patrice.chotard@foss.st.com> wrote:
> > >>>>>
> > >>>>> Hi
> > >>>>>
> > >>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
> > >>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTREA=
M_BUILD_VENDOR=3Dy
> > >>>>> and CONFIG_OF_UPSTREAM_VENDOR=3D"st" are set.
> > >>>>>
> > >>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
> > >>>>>
> > >>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prt=
t1* and
> > >>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
> > >>>>>
> > >>>>> To be more precise, these files are using a syntax which follows =
this
> > >>>>> format &{label/subnode} to override some nodes.
> > >>>>>
> > >>>>> This leads to DTC error:
> > >>>>>
> > >>>>>  AR      drivers/usb/gadget/built-in.o
> > >>>>>   LD      u-boot
> > >>>>>   OBJCOPY u-boot.srec
> > >>>>>   OBJCOPY u-boot-nodtb.bin
> > >>>>>   SYM     u-boot.sym
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-m=
icrodev2.0-of7.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
> > >>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> > >>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1=
-2 syntax error
> > >>>>> FATAL ERROR: Unable to parse input tree
> > >>>>>
> > >>>>>
> > >>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi =
we got :
> > >>>>>
> > >>>>> &{qspi_bk1_pins_a/pins} {
> > >>>>>         pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 =
*/
> > >>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
> > >>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> > >>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> > >>>>>         /delete-property/ bias-disable;
> > >>>>>         bias-pull-up;
> > >>>>> };
> > >>>>>
> > >>>>> If i update it as following , the DTC compilation is OK :
> > >>>>>
> > >>>>> &qspi_bk1_pins_a {
> > >>>>>         pins {
> > >>>>>                 pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_=
BK1_IO0 */
> > >>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK=
1_IO1 */
> > >>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1=
_IO2 */
> > >>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1=
_IO3 */
> > >>>>>                 /delete-property/ bias-disable;
> > >>>>>                 bias-pull-up;
> > >>>>>         };
> > >>>>> };
> > >>>>>
> > >>>>> On kernel side, the DTC compilation is ok, but not on U-Boot side=
=2E I am not able to understand the difference.
> > >>>>>
> > >>>>
> > >>>> Could it be that the kernel dtc is newer?
> > >>>
> > >>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the sa=
me dtc version than kernel tag next-20250114
> > >>
> > >> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
> > >=20
> > > Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
> > > because other changes it made grew the binary size for everyone and
> > > didn't get back to it. I guess another attempt is in order.
> > >=20
> >=20
> > Hi Tom
> >=20
> > Do you know when you will be able to provide a DTC update in master or =
next branch ?
>=20
> Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 to
> be on top of current (the first step to moving to 1.7.0 or 1.7.1)
> produced some test failures that don't exist when using the host dtc.
> Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
> just need to change to building pylibfdt and not dtc as well (as having
> pylibfdt come via system python or pipx is differently tricky it seems).

The pipeline is at
https://source.denx.de/u-boot/u-boot/-/pipelines/24243 and that's just
the v5 branch currently under WIP/ rebased to then-current master.

--=20
Tom

--tU8ZFqBYNW0kvKVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY8fcACgkQFHw5/5Y0
tyyCvwv/XNK9i9aUxxiqH9xsPG+O2N6/4pWty+1e4osMBDWJlLLSX94Kf/VlaOBO
+C68kcVVbqH1HhrDHGxg2QDlKZRshLw3M2Vas/OSgdtN5tdCs4CRh3zeO0/omVmD
Pj1wWl2vq0uQCM/WBSOJtD0btNpqEunWWdtuX07yDFbwuNbfBIop2FvY7pAclh/f
g4581Ne8x1NKsUiD7RNMBr6dEYp06HkbvrUi3PSaK+6bddkjV3SWnjdijMWkZs0Y
Y/2sFAKi6yn6iQNOFgGC+i52zGz4WYJBVYFDRJMbWauwGK370Wew/N12YovoyTUe
ZkX2kFVZ9g9nNeSfBsS+edis9ULrICV6xPZyMdqA7MC7md2KLAKod274wqD2ryMh
SjwdZu6cNpN6x8y7S2wKAXfyojNEuuBD6Pz6MaKy1oR/U/oHbfKUgRUHISL5n1/d
MifvoNoO7se76WQKEmTHG57QAdWB6j76TERROb3dZK/K014CdIJgD8BxKi78J88x
Dccq2O/G
=qmqE
-----END PGP SIGNATURE-----

--tU8ZFqBYNW0kvKVh--
