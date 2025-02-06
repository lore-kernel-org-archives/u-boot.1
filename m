Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEFBC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 16:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1BC80BB0;
	Thu,  6 Feb 2025 17:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D3MbXNFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA3780BB0; Thu,  6 Feb 2025 17:54:49 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C963180A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 17:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso27723725ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 08:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738860885; x=1739465685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NVHInlkpj0kePOWFfglc6mzbDQy5wqroSWQTrIqe3fY=;
 b=D3MbXNFY5QsrbKBPtR1CAYNYtroiWUURMqwNCQ2OKBtzD7FRbXAfokucoUy1lH/Oeq
 2uHFsXHQ/JRK6FdF08YJ8kF2c7LZ22ZhWMjP4s9cJmIyNOm2lcPaxttgdUfJt6b+uwPN
 mEc+sBV75NNitwKvj8uhXVDigibneCHlkuwUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738860885; x=1739465685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVHInlkpj0kePOWFfglc6mzbDQy5wqroSWQTrIqe3fY=;
 b=PZtuY7dK73mHnhAaD50TXalkXbW+USjVoVamMQHnMnmsWnh4iiH6smtVtyn0WOZ7tH
 8Eqh0sgNumvf3JriyCUeklSXMSfyrpP8h+ISBwkhWoPpjRCTiiNbN7DhZ5hkcvDW/hWX
 AXTah99noG291mVXOj4ldYpZTVLo3+sqlsS6Qh52l2UYRZyyT2HrRCl/bpB9ghgMwtLO
 mbqB80W0KqxowCiqZAw16sQKjNiNyeSwtT6sus0kwPpuocumMgt+lFiyVSYzzgjVO0XI
 EjQ6r4HdKgiYhI8sCjQOysWRAG0/TprpPc14Ejk4IsgLVA29FiheO6KZqzp+CyD/5jrG
 uMZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWA0O8Y9LCbA78Uw8+i1Wm+Prt215RiffZmGaTHvVhkdlsYVfJzFRA4ibUkNfUbTvajBz4rHw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs1Z2+rz/NitErDlw0oDGCnKpnCtXYSZY5MpoFY5xgKp+USDhO
 3SvAZLF74c20wGWey3k3fZF/un66y1CWbov/lFDGMonDZlSacmHc1CzSc/JT3cg=
X-Gm-Gg: ASbGncs2HtHQmptJxHyCDJQnqO7MhWWwx8zhG2EzMzYVP2ANFm76Vx8YBSOe4HLFZkd
 yHBrTYdPdk+RTFAzffT06Viy25+N8J65HuNGKuKUDkYVvRjIHKRUYYuyQ29bU27gciA2z8icER7
 YEtGSrroGH3DxI5YuCRs3QhKt/xHbEJRqvYGBhPM/GEvowBDLxjf1Tz7/lAkkVOx21Jo14bOBrA
 3etRXMTBkzY4rfKb1nfCmGNaevCN8WOIiLvi/ccyNKHjKVWXbzmYcsWSwwTkOYQ6CUxKWSQgmT7
 a38l+whzCSyAYxQ=
X-Google-Smtp-Source: AGHT+IHD1uaMDy/bx0wgVGbk6/X0FBvR59aqCzgHDo6P0Vh+vU/jgSlASMWd0omOuVVR1YwPcX9bcg==
X-Received: by 2002:a05:6a20:394e:b0:1e1:384e:20f1 with SMTP id
 adf61e73a8af0-1ee03a9b2e4mr177042637.25.1738860885268; 
 Thu, 06 Feb 2025 08:54:45 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af78034sm1353907a12.67.2025.02.06.08.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 08:54:44 -0800 (PST)
Date: Thu, 6 Feb 2025 10:54:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>,
 Matthias Brugger <mbrugger@suse.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Message-ID: <20250206165440.GE1233568@bill-the-cat>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
 <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
 <CAFLszTjh8qd0ycyqafHUaBuBS0Lhgtp0763FUER6PO_QAw4JdQ@mail.gmail.com>
 <5db27eca-7960-463e-9345-46d40d8a3350@epam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1xhbEQInUbc7yqj0"
Content-Disposition: inline
In-Reply-To: <5db27eca-7960-463e-9345-46d40d8a3350@epam.com>
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


--1xhbEQInUbc7yqj0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 04:07:53PM +0000, Oleksii Moisieiev wrote:
> Hi Simon,
>=20
> Please see below.
>=20
> On 06/02/2025 17:58, Simon Glass wrote:
> > Hi Oleksii,
> >
> > On Thu, 6 Feb 2025 at 05:46, Oleksii Moisieiev
> > <Oleksii_Moisieiev@epam.com> wrote:
> >> Hi Simon.
> >>
> >> Please see below.
> >>
> >> -- Oleski
> >>
> >> On 06/02/2025 14:31, Simon Glass wrote:
> >>> Hi Oleksii,
> >>>
> >>> On Wed, 5 Feb 2025 at 03:15, Oleksii Moisieiev
> >>> <Oleksii_Moisieiev@epam.com> wrote:
> >>>> This patch series provides generic support for Raspberry PI 5 in
> >>>> U-Boot with additional hardware drivers.
> >>>> The following features were implemented:
> >>>> 1) add generic board config for Raspberry PI5 including device-tree
> >>>> files;
> >>>> 2) add support for RP1 chip with additional hardware;
> >>>> 3) add support for rp1-clock driver with dt-bindings update;
> >>>> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> >>>> 5) add clock/reset/gpio drivers;
> >>>> 6) add ethernet support in u-boot.
> >>>>
> >>>> This patch-series introducing the basic set of supported drivers in
> >>>> U-Boot which allows using such features as tftp and\or NFS.
> >>>> I've posted this patch series as RFC because of the following commit:
> >>>> e51ca0d221 (HACK: drivers: mfd: set bar configuration for RP1 driver=
, 2024-05-21)
> >>> Where is that commit?
> >> This commit is part of the patch series. Here is direct link:
> >>
> >> https://lore.kernel.org/u-boot/cover.1738749764.git.oleksii_moisieiev@=
epam.com/T/#m21cf23989fb08cb655e25b1a2d082632b6f865c9
> >>
> >>>> It includes HACK for rp1 driver in u-boot. This HACK is setting bar
> >>>> address in the correct order because RP1 driver in Linux Kernel rely=
 on
> >>>> the pci BAR configuration which initializes BARs based on BAR size.
> >>>> This results the Linux set BARs in the same order on each boot.
> >>>> U-boot does initialization without any sorting so the configuration
> >>>> may be different from the Linux kernel.
> >>>> BAR address configuration is set to match the Linux Kernel order
> >>>> to avoid fails on address translation.
> >>>>
> >>>> This should be changed after upstreaming RP1 driver to the Linux ker=
nel
> >>>> mainline.
> >>>>
> >>>> Probably somebody from Raspberry will post an advise about how this
> >>>> can be properly done.
> >>> +1
> >>>
> >>>> U-Boot support for Raspberry PI 5 was added in terms of the following
> >>>> project: https://github.com/xen-troops/meta-xt-prod-devel-rpi5
> >>>> This is xen-based dom0less system on the Raspberry PI 5 with Zephyr =
as
> >>>> Control Domain and Linux is Driver Domain.
> >>>>
> >>>> It is Yocto-based so it will be easy to build it on your side. Please
> >>>> visit link for the details.
> >>> I tried to apply this but I get a lot of conflicts. Can you please
> >>> advise what tree it is based on?
> >> Yocto build using the following repo:
> >>
> >> https://github.com/xen-troops/u-boot/tree/rpi5-2024.04-xt
> >>
> >> It is based on the 7-8 month old master. I didn't do any rebase on the
> >> top because
> >>
> >> it's unclear if these changes will go to upstream.
> >>
> >> So I've posted RFC before making significant changes.
> > If these add more support for rpi5 your patches would definitely be wel=
come.
>=20
>=20
> If community accepting it I will proceed with rebase to the latest
> master and post
>=20
> v2. But there are still questions about "HACK" and regarding device-tree
> bindings which
>=20
> still weren't upstreamed by Raspberry to the Linux kernel. So I'm asking
> the community if
>=20
> dt-bindings that could be completely changed in future are acceptable at
> least for now.

So long as you're willing to update the bindings when upstream Pi
properly upstreams them, yes. Thanks.

--=20
Tom

--1xhbEQInUbc7yqj0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmek6UwACgkQFHw5/5Y0
tyyUFQv/ddH7W83aX3pVjiLb7x2VZrqLDsFVMjkf82FNc7yaT9Tsrno5KOF7+izz
IJHkLb4M19S4FwcQn7AS7ViAwIB1qetrUPwM1xWFuCy1mMD8Wl+rUWnpBRB8WeEu
Fm03fMJdgWuxPrnA5lxgQRklNvMA7tJAVknIAzPz9MQFOyD0mJar9bMnB+Mmf2I7
QTuYJCeq/w5YanHP/W0X7aeT7SodZWrCOVmJdwLWJJI8deO/1sDfZX69Ph7Vk3iY
Dz8HF374fq4eM65yvWEOuNA6jfalKg/BJuoROk1pTTcp6sMZHki1kOekFNbZr1dj
5jUSyXC+tZN7KITPsZqn2PdGzO5vZvCEYODK5gMSUUXmKJscxYv33vdd+SywtWc+
ahjr9AIv1yDlfb9I9V2DupG69Io1Rpimfj8rBrBpg+PU28/w07vVPkPkhraiJczw
PWyXw1NEC31wNPJ4lli8GuZ3Y0g8vvq7Y/VMp7Mw3FI78MAKeYHYIFfbPGdrgDa8
/Ra4A3p1
=ru6d
-----END PGP SIGNATURE-----

--1xhbEQInUbc7yqj0--
