Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580C2C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 16:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8195F811B3;
	Mon,  3 Mar 2025 17:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="NLdD2niC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84697811DF; Mon,  3 Mar 2025 17:06:19 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC83811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 17:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741017971; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LZ598iIEuPLXwQKqz/FE52KrLUCwMhh6g/3uhnL1jc+UgGIrETzXrajuUw8Uw+HOja/mQQoj/xZOEhzA5HY2vkEexMPkC4WuinLw3HV9B/jjijUZ8DpNLsMIVJ9wTPpL4CmlJV2kj+rMCo4NUkHuhsrhtTbyXtC9/qb9AteTc2E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741017971;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yRn9jiglUKnpQUG4M3s28zo2hKJ0hKqNskv/5aUaH78=; 
 b=SClSGpFdAQdhVoqJ95reCRJjPprjaZdBaoUvuqmEfi+DKQmxGTDtDa6nmPxs8tgJXxaIGa56oyPpS5dQ7k5aIx+Oqp3yC+RH31y2FT2OD2G7K++a1mdgaDgyEh7IdlDuamhr+VPVdxmw1GoItdGiOUxdKchJBssSJ5jVpx+7ZNI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741017971; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=yRn9jiglUKnpQUG4M3s28zo2hKJ0hKqNskv/5aUaH78=;
 b=NLdD2niC0zPsuJk/8BNX35yCuhVSJ69NiTpv+Sob1T2QGVmFgslbTC/WJplrp0Nn
 ZT8v0Wae2zPGbMbmMlLDimc476G0C37DVlSIDUsxLMT0w21IzAw0BKZjp/QNvmnmkt2
 jmQ03EQnY3/g8TWh50J8MgWAYWoZFngyzVGTjcjE=
Received: by mx.zohomail.com with SMTPS id 1741017968305913.055361266326;
 Mon, 3 Mar 2025 08:06:08 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
 id 65C36180693; Mon, 03 Mar 2025 17:06:04 +0100 (CET)
Date: Mon, 3 Mar 2025 17:06:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>, 
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>, 
 Tim Harvey <tharvey@gateworks.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
Message-ID: <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ls22akzqb5g7xidq"
Content-Disposition: inline
In-Reply-To: <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.985.19
X-ZohoMailClient: External
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


--ls22akzqb5g7xidq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
MIME-Version: 1.0

Hi Anand,

On Mon, Mar 03, 2025 at 01:08:24PM +0530, Anand Moon wrote:
> On Sat, 1 Mar 2025 at 23:41, Peter Robinson <pbrobinson@gmail.com> wrote:
> > On Thu, 27 Feb 2025 at 06:01, Anand Moon <linux.amoon@gmail.com> wrote:
> >> On Thu, 27 Feb 2025 at 00:15, Sebastian Reichel
> >> <sebastian.reichel@collabora.com> wrote:
> >> >
> >> > Hi,
> >> >
> >> > I have a couple of fixes/improvements for the TCPM code. Three are f=
ixing
> >> > actual problems I noticed on the Rock 5B, which prevented booting up=
 the
> >> > system. One of them simply adds an error print before potentially co=
mmitting
> >> > hara-kiri by triggering a hard reset, which helps people understandi=
ng
> >> > why their boards reset themself in case there are more problems. I've
> >> > recently added the same print to the kernel TCPM code.
> >> >
> >> I have encountered issues with the Raspberry Pi Type C power
> >> supply on a few occasions. Thanks for these changes, but it
> >> dose not resolve the issue completely.

I don't promise fixing all issues with this series. USB-PD is super
complex. This series improves things and shouldn't have any
regressions. It also helps with debugging further issues by having
the extra print.

> > I don't believe the RPi Type-C power supply supports power delivery.
>=20
> RPi 5 Type-C power supply is generally compatible with the Rock 5B
> for daily use. I also have the Radxa 65W official Type-C power
> supply for the Radxa Rock 5B board. I was checking the connection
> messages with different power sources.
>=20
> >> Do you have plans to add a device tree node for this board?
> >
> > For which board?
>=20
> Radxa Rock 5B and Rock 5B+ indeed have a versatile USB Type-C port
> that can be used both as a display port and a power source.
>=20
> During my investigation, I discovered that the Type-C port uses
> the FCS,FUSB302 the driver instead of the TCPM driver. The
> FUSB302 driver is specifically designed for USB Power Delivery
> (USB PD) and supports various power delivery protocols.

The fusb302 driver uses the TCPM framework. TCPM means "Type C Port
Manager". The chip is not autonomous (like some other USB-PD chips).
Without a driver telling it, what messages should be exchanged, it
will stay quiet. TCPM implements the huge USB-PD state machine,
which knows when a specific messages is expected or needs to be
send. The remote side (i.e. the power-supply) has a similar state
machine implemented. Ending up in a bad state in the state machine
results in the system trying to do a hard reset to go back to the
start. A hard reset involves removing the supply voltage and thus
kills boards like the Rock 5B. To avoid this the state machine must
be tweaked. That's why FUSB302 is not really mentioned here - the
driver is passing the messages correctly. TCPM is the relevant bit,
as that contains the state machine.

> As of now, I don't have a Type-C power source monitor to test the
> feature

You can also get debug information from the Rock 5B itself. But
then you should make sure it has a backup power-supply (e.g. PoE
or via the GPIO header), so that it does not reset itself when a
USB-PD hard reset happens. Also this setup has some side-effects
to the communication itself, since it affects the timings if you
enable too much debug messages.

Greetings,

-- Sebastian

--ls22akzqb5g7xidq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfF02gACgkQ2O7X88g7
+poNJw//aJG6Xs2KfmTI3JsUAlEGff+KTg1sSUWib/wmUu07B/BH28HQIf5x6qp7
paf3cOdw/Agm9Pc2ZxO5EK8P40bJO2GqpAt5BfFXTSg5xzuFKLNw4H8FP7qjIImb
eo4/D7GgIPTYmVXqEQETi+hjBkwOZbEK/hJKEUVXWfPvgwNX+2IO2kPL/WUrbXJc
Ckgbx8nQIeYRi/qCKsavUpV1c+KUSwIjWNh7g04B+aVcAt/RfnqU1oHKQenf97GT
ezVcmlFTV6/5o/jxA/0NV0j5JO8gPTFRfaIGroCjrM/TvLAwlG/VtumRqEQUmxJ6
Akt8KQacdTtvTNKteOTKAmZWuSq6KHXIOl0cBiZabP72KJ8Yhc0nkuEYDkgfZbPR
fuTtw1ynapxSBDYzAI8mh+HFyxfEnBjfXY1bsO4L9MO3RWX6quSEX+Bg+xzHXoVe
Fgvhs7+fC4UXOx0qECmyLVkDVPHZMz6Z9fTgpjNhCJEzxX3twP7RtWSn592U87SG
/kbmx4/a0CLKZaBwRDm1z/aSXGz4zzm0h2FxlGQZbCJvvI61GDQ6KTtySY1xBqAV
/vBodKoCkuMXLuYAp1Lqx7VNQj9If9rSPaB4BK0Knr0fWlnsRm2VMnspPDUwN1CN
+beBrIs/lmVaHoGoCIqnWgCB2qMRoeOCp0fjJ7nZ1lZGqjZC1bM=
=wSVy
-----END PGP SIGNATURE-----

--ls22akzqb5g7xidq--
