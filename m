Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC3AC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 16:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35642801A0;
	Fri, 31 Jan 2025 17:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GGC+vmEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC763801A0; Fri, 31 Jan 2025 17:01:48 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2CD826C2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 17:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6ea711805so302646685a.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738339304; x=1738944104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bfOVLL93octR8ECWc2CFuU08FRifwBs9IwgE3ifPrFc=;
 b=GGC+vmEmzlQ7g29gU19lG3C9ehcfej2i0ZSqg8pMsD4vydw9EZHm++REG95W382Z6m
 Yh0JCwGGbc+D2FWucJmjcwhoIIAOX/qXT//OKGN1Wzmgv/IQIIfncir5l5C+J6Hzlh8K
 vAjTb/PhEw2zIz/0mjuON4GWJBVjlEw7+vAss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738339304; x=1738944104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfOVLL93octR8ECWc2CFuU08FRifwBs9IwgE3ifPrFc=;
 b=UHTTiRb6kMEMqNhMST2aqteWT4wVppSU98wxY1CQCCaPkRaVLrxwMJWtgep7aKquhm
 uF44/bbh5mzaRq8UVk1+bebXulcoVvk83YWZLgBdmFA4xBwp3CxLxK7N/6sI65MyWsoU
 9QX2GhyEIG3dnOPfub30mLQcZb/8MBuHnIfBFrh2EfptQruEueI1g6gL9M5G22QSr5Xi
 DkmwJ+T0vFZXg7cSPsifIoE3mgAwE0uyux01qNPlYeVVJO1yEk9U/lT/fQsfpz1hTAKC
 FsgINUL0uNUAQVkMNrrXH/AcbaYjScG3JqMulW0BpMsrmpBKNrkj4DPizEEqWF551JfZ
 5XUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlYN1IHaARCxwRtHRqpgOdjiyG9WoB66MrENaQwXxGnbOF86lNAhNdO4nR8VFORR7sCzM3uqM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1paeFumtGj8KwFUOHIEjDQTQ+iQL8eV0hytkCbwSXUmqDNKcz
 U76VlTpPYBwJdVyG+/ayjCMSCuaoPScHw0/U+WGOom2w1UVR64nJUJMLM2zdPgU=
X-Gm-Gg: ASbGncuX+FZI7IYO5fCIUNRbKxLb5FpvN01S+bmFcUOVjD7nZlgOJbpgN9D2kh2GMIS
 wrzbngCyBhCmADbcNHC9fbDX9wQj2kqgT4REMnWCJFsrXEtsegEw1G1a/WRnV8t0JNYsVO1ueuc
 8lVDqJjv2NCfL7svL+FnA01D5+eMXTjbRFRzyby1TcK8Y3lu88DzCwR5/3/uxMsksA39jomYaJj
 RzSRC+YzffohEH3FreayVbELOh9eoqYCVIdZdDwUUnUhTAWXogjQXkxHfzQHliDefbshkW/wnj+
 rPrZX1gvSLsij90=
X-Google-Smtp-Source: AGHT+IH6o6PxPdg6KRnsBqwfSINhaFbGY/KwvGvzEwgbD76O96q+LuBnr0vnSA+37jMfZeMdT4ndrw==
X-Received: by 2002:a05:620a:44cd:b0:7b6:c92e:2e83 with SMTP id
 af79cd13be357-7bffcce6156mr1578244185a.17.1738339303788; 
 Fri, 31 Jan 2025 08:01:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d9697sm206808685a.55.2025.01.31.08.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 08:01:43 -0800 (PST)
Date: Fri, 31 Jan 2025 10:01:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
Message-ID: <20250131160140.GQ1233568@bill-the-cat>
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
 <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
 <62ed68c3-a029-4bf9-8918-39d5aa5d8b6b@foss.st.com>
 <95ab524e-c532-4eb5-a65f-a1d1c1b190a2@foss.st.com>
 <20250115144428.GZ3476@bill-the-cat>
 <329ceffc-c5b6-4f3e-81dd-03b1d4b7b9a7@foss.st.com>
 <20250128140456.GJ1233568@bill-the-cat>
 <20250128150426.GP1233568@bill-the-cat>
 <20250129220127.GW1233568@bill-the-cat>
 <2858f505-d64d-4583-bca2-30f9a83a9ef6@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kbscZAvjvCthHuXt"
Content-Disposition: inline
In-Reply-To: <2858f505-d64d-4583-bca2-30f9a83a9ef6@foss.st.com>
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


--kbscZAvjvCthHuXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 03:41:37PM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/29/25 23:01, Tom Rini wrote:
> > On Tue, Jan 28, 2025 at 09:04:26AM -0600, Tom Rini wrote:
> >> On Tue, Jan 28, 2025 at 08:04:56AM -0600, Tom Rini wrote:
> >>> On Tue, Jan 28, 2025 at 08:47:37AM +0100, Patrice CHOTARD wrote:
> >>>>
> >>>>
> >>>> On 1/15/25 15:44, Tom Rini wrote:
> >>>>> On Wed, Jan 15, 2025 at 03:39:20PM +0100, Patrice CHOTARD wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 1/15/25 15:24, Patrice CHOTARD wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/15/25 14:19, Simon Glass wrote:
> >>>>>>>> Hi Patrice,
> >>>>>>>>
> >>>>>>>> On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
> >>>>>>>> <patrice.chotard@foss.st.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi
> >>>>>>>>>
> >>>>>>>>> I am currently converting STM32MP platforms to OF_UPSTREAM.
> >>>>>>>>> As we use same binary for several boards, flags CONFIG_OF_UPSTR=
EAM_BUILD_VENDOR=3Dy
> >>>>>>>>> and CONFIG_OF_UPSTREAM_VENDOR=3D"st" are set.
> >>>>>>>>>
> >>>>>>>>> So all dts/upstream/src/arm/st/* dts files are compiled.
> >>>>>>>>>
> >>>>>>>>> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-p=
rtt1* and
> >>>>>>>>> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
> >>>>>>>>>
> >>>>>>>>> To be more precise, these files are using a syntax which follow=
s this
> >>>>>>>>> format &{label/subnode} to override some nodes.
> >>>>>>>>>
> >>>>>>>>> This leads to DTC error:
> >>>>>>>>>
> >>>>>>>>>  AR      drivers/usb/gadget/built-in.o
> >>>>>>>>>   LD      u-boot
> >>>>>>>>>   OBJCOPY u-boot.srec
> >>>>>>>>>   OBJCOPY u-boot-nodtb.bin
> >>>>>>>>>   SYM     u-boot.sym
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1=
-microdev2.0-of7.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.d=
tb
> >>>>>>>>>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> >>>>>>>>> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338=
=2E1-2 syntax error
> >>>>>>>>> FATAL ERROR: Unable to parse input tree
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dts=
i we got :
> >>>>>>>>>
> >>>>>>>>> &{qspi_bk1_pins_a/pins} {
> >>>>>>>>>         pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO=
0 */
> >>>>>>>>>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 =
*/
> >>>>>>>>>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
> >>>>>>>>>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
> >>>>>>>>>         /delete-property/ bias-disable;
> >>>>>>>>>         bias-pull-up;
> >>>>>>>>> };
> >>>>>>>>>
> >>>>>>>>> If i update it as following , the DTC compilation is OK :
> >>>>>>>>>
> >>>>>>>>> &qspi_bk1_pins_a {
> >>>>>>>>>         pins {
> >>>>>>>>>                 pinmux =3D <STM32_PINMUX('F', 8, AF10)>, /* QSP=
I_BK1_IO0 */
> >>>>>>>>>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_=
BK1_IO1 */
> >>>>>>>>>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_B=
K1_IO2 */
> >>>>>>>>>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_B=
K1_IO3 */
> >>>>>>>>>                 /delete-property/ bias-disable;
> >>>>>>>>>                 bias-pull-up;
> >>>>>>>>>         };
> >>>>>>>>> };
> >>>>>>>>>
> >>>>>>>>> On kernel side, the DTC compilation is ok, but not on U-Boot si=
de. I am not able to understand the difference.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Could it be that the kernel dtc is newer?
> >>>>>>>
> >>>>>>> I have tested with dtc Version: DTC 1.7.0-gbcd02b52 which is the =
same dtc version than kernel tag next-20250114
> >>>>>>
> >>>>>> I mean, it's ok with newer version of dtc : DTC 1.7.0-gbcd02b52.
> >>>>>
> >>>>> Ah, so, sigh, we need to update DTC. I stopped my last upgrade there
> >>>>> because other changes it made grew the binary size for everyone and
> >>>>> didn't get back to it. I guess another attempt is in order.
> >>>>>
> >>>>
> >>>> Hi Tom
> >>>>
> >>>> Do you know when you will be able to provide a DTC update in master =
or next branch ?
> >>>
> >>> Unfortunately trying to update resync-dtc-v1.6.0-31-gcbca977ea121-v5 =
to
> >>> be on top of current (the first step to moving to 1.7.0 or 1.7.1)
> >>> produced some test failures that don't exist when using the host dtc.
> >>> Can you confirm if dtc 1.7.0 is new enough for this syntax? We might
> >>> just need to change to building pylibfdt and not dtc as well (as havi=
ng
> >>> pylibfdt come via system python or pipx is differently tricky it seem=
s).
> >>
> >> The pipeline is at
> >> https://source.denx.de/u-boot/u-boot/-/pipelines/24243 and that's just
> >> the v5 branch currently under WIP/ rebased to then-current master.
> >=20
> > To push this as far as I can at least, there's now also
> > WIP/resync-dtc-v1.7.1-v1 which brings us to dtc-1.7.1 (good!) but also
> > some silent failure to boot on a least one of the TI K3 platforms I
> > have, and some other failures in CI too.
> >=20
> Hi Tom
>=20
> I rebase my "STM32 OF_UPSTREAM" series on top of your branch WIP/resync-d=
tc-v1.7.1-v1,
> that fixes the issue i described in my initial mail.
>=20
> Thanks for this update

Well, please note that branch is a problem. I have no idea why some
tests, and then some platforms fail. I also don't have the time to look
in to it. I posted this so that at least the groundwork is done for
someone else with motivation / need to finish fixing things.

--=20
Tom

--kbscZAvjvCthHuXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmec89wACgkQFHw5/5Y0
tyxjywwAiok0xCfxKwzh/87TRQHYY4p5Q7by7FQABD8Nt+J0D/TIkUNUsKlSMuJu
bxqxb8aKbhc/NN976BhH0FPd6jxxoeXua8FPFu6aF6+fVG2SiBKwvGp8L6K5NZ2r
Vb8Q1VxJDnoa/DonG2s55xjmKPD9gQ4V434oaQE8S1yL6MjK0OfYGtHK1XoJJ4w9
mRaYmkdC12+fTQSvmofRhwje4s6UDAJ4BgyDj0fsK+zwhDHn6YtvAtqYYbjkrsv2
8Gx90zZ6DB3I3iIb2upcXEgze/O7PJcvfTvng6YajYMiWuf0DO8xxnAp2+3oPvjI
4HcaIUhegO0DBXy5d5ITMF2E86jqI9F750jnFb0DMwCGo2VKxGEliO/bXW7jRniX
Osl1Bq9v24FR5prJdKQ+GJBpGtcqf+Q5wj53CwKQlkpWGIlNHLuJVe+sLnEO7NqZ
1EpWljRIpdmimNMXtms9JZW+CWIkqcInO07gHOkRRzkOasa6NQCXXzuJvG6QifeS
X73jYR0J
=0cdz
-----END PGP SIGNATURE-----

--kbscZAvjvCthHuXt--
