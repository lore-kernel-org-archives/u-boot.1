Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEF3E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D983B83C5E;
	Mon,  9 Feb 2026 19:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nZohZQxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25A183C65; Mon,  9 Feb 2026 19:13:14 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1680E83C54
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so3735119a34.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770660791; x=1771265591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hnJf6uO6WWpxcOAv53vViLospfQrr8KfZ2FIy6JgWXk=;
 b=nZohZQxdkz6cdaFx9TPNXbF/Fh1KV+fhnETa86bSB1o7J7wDApj84VY6aMPUHfFsZJ
 ed2eMoYMU4WWLA0OVEo0e/B/90lqJHjo8ERMarJH6PixAEdD7HFZeMtfCmvzYfoQftWO
 I4/WZgDxkIOHy8dBrfiSMNmOeSeQMj/1fCtfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660791; x=1771265591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnJf6uO6WWpxcOAv53vViLospfQrr8KfZ2FIy6JgWXk=;
 b=Mr1evzsQflQBDOCuRNglEc2ZCx450RiiY7UDSWh+BTbAlbPM/E/oJI86btxdZ4EVNT
 IyVP+ZjNXUyeDnO9/jNUkJt3F3nMq6dtD/JqSmGCn0bSVOZONOLbEBmmlWhM4qpDpcid
 /pIGBYWOUGXs9nxbRTsbMalNs/Bs9cdtRwXHl15YS6+DEyL5trJoDJR8jzmjBFe6thZf
 36WI1UdK/iWVCNMgJVGQFxwemkd5FkMWzZRd0hSrxfN2RGDazsKY0gRi4DCBMUUdfaj1
 TLS9A4wPw9FC77Oqb527IK9pn33htt9y5KMIVJVWyfRpn7OnRKRzwEdf0LyWfOpyCqF4
 YgXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpblZ9OcrekTzHRu4CTwYCXVGpQiQRZXmFOmqpsN54D5CK2qjcbSJs3o3QJs7MhycehDPfBPE=@lists.denx.de
X-Gm-Message-State: AOJu0YzmxyZC01tHUF7ziYudVOlwd2+VFqICUv7pN7kywIS88zudvPvm
 R8Nts4UDQzEG7tATG/mELKWIwpThvwd/jjDA08ZyHCLtl8CgXeRVcKjtFd0hvWGz1kM=
X-Gm-Gg: AZuq6aLWI5wtu4CVcl4WevNSzWztGP4Y8wwOS/TEDmm+jSbL9eXBZZp66u3ZwwMuixo
 Pj3CiFPMltU17IBO6Dk4kGhl9mVf1xdAEGZGO4Jce1XvErz97bZaUuVR01Kb/KWyHYRVRFAASQ4
 dIWIoxh8uz0T5kuF8S76YnSkL0hbVUYrSy4xsP1nSwWUQK5uyTeWEnWAZPB/YMjN3QhqsGCnBHF
 bolHW1kYPtN6duXBM47x0pfe1yBF1ELET6gZtRUeLq4eydnAKMck4/IHOKHYM5SrXmrrM8vQjHb
 Zk8XaFOJFFpohEynVNKRi5X3H76E3L5ZzuCnZBSHIyYCr+0Ct07pQ2oq1NI2XUyd3WTidUhkIoI
 wfiPatGA5lSC2tQJN+buytbJ/rfDDU3Yhquijke4qKuEKjMEoo2QRKQM6c7lOtLQ0Ul2VTcWiNf
 Monfhf/V/33tQC4KH1xKigJFkSil02+gPe/g7if077lQ1tDRholL1K5dESzXLwwNsNBGQ/x4wcm
 M0mge94OzRyjooj8sFzSK/1kQRLEmqudV8YOGY=
X-Received: by 2002:a05:6830:f94:b0:7c7:4f2:e15d with SMTP id
 46e09a7af769-7d464429256mr7200629a34.16.1770660790790; 
 Mon, 09 Feb 2026 10:13:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fca4asm7927212a34.2.2026.02.09.10.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:13:10 -0800 (PST)
Date: Mon, 9 Feb 2026 12:13:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209181307.GH2603314@bill-the-cat>
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
 <20260209180726.GB281089@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="57Q6uPFHmBmFCcUV"
Content-Disposition: inline
In-Reply-To: <20260209180726.GB281089@francesco-nb>
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


--57Q6uPFHmBmFCcUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 07:07:26PM +0100, Francesco Dolcini wrote:
> On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
> > On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
> > > On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > > > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > > > + Bryan, Anshul
> > > > > >=20
> > > > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wro=
te:
> > > > > > > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b=
3ee7fa524,
> > > > > > > everything was fine with b5213bbfdcb1.
> > > > > > >=20
> > > > > > > Looking at the commits between the two revision, I would say =
that the
> > > > > > > issue is with this series https://lore.kernel.org/all/2026012=
7081652.506357-1-s-joshi@ti.com/
> > > > > >=20
> > > > > > We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor=
 common
> > > > > > nodes to k3-*-r5.dtsi") that might be the root cause for this i=
ssue.
> > > > > >=20
> > > > >=20
> > > > > Hi Francesco. Unfortunately, I don't have Verdin line of boards w=
ith me,
> > > > > so I cannot reproduce this issue. This is also why I wasn't able =
to test
> > > > > my series on my end and had requested board-specific maintainers =
do the
> > > > > same.
> > > > >=20
> > > > > Since I don't have the boards, could you run the following test t=
o help
> > > > > us ascertain which of the 2 suspected commits actually broke the =
boot?
> > > > >=20
> > > > > * First drop my AM625 Verdin patch, and compile and copy the bina=
ries,
> > > > >   and boot.
> > > > > * Then let my patch remain in the tree, and remove Anshul's refac=
tor
> > > > >   patch, and try the same thing again.
> > > > >=20
> > > > > This could help us ascertain which commit broke boot, and we can =
try
> > > > > fixing from that commit.
> > > >=20
> > > > Sure, I can bisect it.=20
> > > >=20
> > > > Do this difference in the logs
> > > >=20
> > > > Failed to set clock rates for '/a53@0': -22
> > > >=20
> > > >   vs
> > > >=20
> > > > Failed to set clock rates for '/a53@0': -61
> > > >=20
> > > > ring any bell?
> > >=20
> > > The boot failure start with commit 2ffab9da9142 ("Merge patch series
> > > "Firewall ATF and OP-TEE memory regions in Sitara"").
> > >=20
> > > With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
> > > ATF/OPTEE addresses") the board still boots fine.
> > > I have some concern that this commit is changing something, however
> > > CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file =
it
> > > was 0x70000000. I tried changing it back without any positive result,
> > > I just got an EL3 exception.
> > >=20
> > > Any more test I should do?
> >=20
> > Should I revert that firewall series, at this point?
>=20
> I did one more test.
>=20
> It seems that the issue is some interaction between the firewall series
> and commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for ATF/OPTEE
> addresses").

That's the first part of the series, and to be clear I'd revert the
whole series.

> If I keep the firewall series in, and revert 24338c81ec2f, it boots.
>=20
> IMO, unless we understand what is going on exactly, we should revert
> both.
>=20
> Suhaas: is current master working for you on the am62 SK or beagle play?

These changes boot and some pytests run on am64x_evm_a53, am62x_evm_a53
and am62x_beagleplay_a53

--=20
Tom

--57Q6uPFHmBmFCcUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYojrwAKCRAr4qD1Cr/k
CpZuAPwKSwDfcfLZz4hAz6XxLvIE81tcRpT/t2Af/GdvGqs3cgEAyholqo1tlS7S
rrR53GQYQF4iNtSe6HP+MXXaTtK8Pwo=
=OorD
-----END PGP SIGNATURE-----

--57Q6uPFHmBmFCcUV--
