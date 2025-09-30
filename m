Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9797CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499D9802C1;
	Tue, 30 Sep 2025 16:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d8cZgL6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B55E81D6A; Tue, 30 Sep 2025 16:48:27 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DB6800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-426813b9712so46855195ab.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759243703; x=1759848503; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f8V9Y7V+dYVAfDNISJYfHZVF/mWVoyvFuU/3B+iXS2o=;
 b=d8cZgL6eEO96X0fIdPmejSqp7/Mk8lKf6SOym/QKDKt66BavHBEQITGI0/o5D0NB2j
 4XL7mseIINFxEjMgxkZ1uSwXqbuMyFKXM5slLw3eQiSVw3U4BpGXDLIiXTy1gUo2QR5i
 ZummrNpzzL9Zj/hS7Z4Wy/w0uy2ZHgMAZEs2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243703; x=1759848503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8V9Y7V+dYVAfDNISJYfHZVF/mWVoyvFuU/3B+iXS2o=;
 b=oC0B4zxOEOxeJo0iBaBAirhJzomibfKJ8IkyPu8D13/Ia6Eb6Uom2Axdv4/3/+Eixt
 lgWaL1KItkCZ0G2abMXBq5VEqAM7YX3YPt0ccNwDMfYJ7xRsPQGDPRugJt9Kidx3WSsI
 Tn1A9lJkVdZaEHDWAvEopkNlczADL//FdJbTzgszAffuGZm45BE9fmqcb/wsYZcsDGvh
 MtJ6yQwDTXrpGBvFCoK1KfCc7nGhehZeK4Kkz4GifbfJaFihuhHsJ7CK2cypBGpqAv2E
 AcmrBkQpbSwdE/rgkbYvNb0oVC5rT6Y8cVnk/OaQ0EHYK8RUTdww9cK4d73/mqs1Pqks
 tlmA==
X-Gm-Message-State: AOJu0Yw+jxRLBPwtp4VYfZLt23fNlu1IZN6O5+xCWKE+qu89cfDsTwMl
 NB3wNXvp6L1T+RgwbH3+3tWC6SDVysLcw+hjfnOAB/8l/ZxjEeSJyUjp10J6eJm7W1maeLSllO2
 8vYfpubA=
X-Gm-Gg: ASbGnct2Jl8gQRCkyKo798HSM7CEYJIlj3NBeYm90fZ77pzNqU5x0pFzM7Pv9fKmG3A
 6bpd2LqpiGafwjbhns9vuxXSCIgArjKgGlAUbntdpD12lodsdiMXeAlv/VLwBVngR9PLGMNYTB0
 1JA6d263CXcrrES26FSwTwUCZm6JwY9Bb4qU9rzZAcYiX9kz74O3DJypnT/cdAC2uNin2FU0LrD
 vBDBWWH6Rvbqd2Irz/8g7Mb/RVywap6nJLjXuYcHG1YsAsDP8GmkEFBXLoQL1x3TPI0tJLXh4Mf
 /TqUAyxAdZZQdHJdk5OZFniNuHLmFzHY2GLBlrWuzoA9X6i376Dl6YsaeBq+goNcFkF03dhmbsb
 VgHbX1OaGd2SXmYoxXe/PH+0Zd6epWoN6XRa/xreqWyNN2TgXpPLyfluZphofKquYZJaLlqH8Fh
 YdhG6ElgbjDHFBlFo=
X-Google-Smtp-Source: AGHT+IELL0nbDp6zF+sChr8kBL2F5MMx4mXu2uBXELbAFLv9czDZ5hOSm8Oz/4P/Bgjxy4EzRSHKWQ==
X-Received: by 2002:a05:6e02:3c06:b0:42d:7dea:1e2b with SMTP id
 e9e14a558f8ab-42d81687e1cmr1586185ab.24.1759243703087; 
 Tue, 30 Sep 2025 07:48:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57223e36f8esm2705102173.54.2025.09.30.07.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:48:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:48:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
Message-ID: <20250930144820.GY6093@bill-the-cat>
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
 <20250929181133.GM6093@bill-the-cat>
 <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g1U+a5UdWq3DhaXT"
Content-Disposition: inline
In-Reply-To: <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
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


--g1U+a5UdWq3DhaXT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:53:22AM +0100, Harrison Mutai wrote:
> On 29/09/2025 19:11, Tom Rini wrote:
> > On Fri, Sep 26, 2025 at 05:09:53PM +0100, Harrison Mutai wrote:
> > > Hi all,
> > >=20
> > > We recently applied changes to the transfer list library [1] to corre=
ct the
> > > checksum calculation. Previously, we used a simple byte-sum approach.
> > > However, we later realized this contradicts the Firmware Handoff
> > > specification, which states:
> > >=20
> > > > The checksum is set to a value such that the XOR over every byte in=
 the
> > > > {tl_base_pa, =E2=80=A6, tl_base_pa + used_size - 1} address range i=
s equal to 0.
> > >=20
> > > This discrepancy creates problems when interoperating with Bloblist.
> > > Should Bloblist=E2=80=99s checksum calculation be updated to follow t=
he same
> > > XOR-based method?
> > >=20
> > > [1]
> > > https://review.trustedfirmware.org/c/shared/transfer-list-library/+/4=
2548
> >=20
> > Erm, since this has been out in the wild so to speak, we can't just
> > change the algorithm without bumping some cardinal. Or are there yet
> > other implementations that were doing what the spec said?
> >=20
>=20
> Raymond; Thanks for setting up the handoff tests. The next release for TF=
-A
> is planned for mid-November [1].
>=20
> We=E2=80=99ve run into an issue where TF-A requires specific tags from th=
e transfer
> list library, but we can=E2=80=99t consume them due to the recent checksu=
m changes.
>=20
> Tom; As it stands, ours is the only implementation currently using the
> updated checksum algorithm. There are two other consumers - OP-TEE and ED=
K2.
> OP-TEE already has a patch in upstream review to move to the new algorithm
> [2].
>=20
> I=E2=80=99ve also reached out to the author of the EDK2 implementation to=
 make them
> aware of the change.
>=20
> [1] https://trustedfirmware-a.readthedocs.io/en/latest/about/release-info=
rmation.html
> [2] https://github.com/OP-TEE/optee_os/pull/7531

OK, but since this could also be deployed, I'm again asking, can we make
a breaking change like this without having to check some cardinal /
version field / something? A mismatch in expected algorithms will break,
and so updating deployed devices and getting a mismatch is possibly
bricking the device?

--=20
Tom

--g1U+a5UdWq3DhaXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvttAAKCRAr4qD1Cr/k
CjLOAP9u6y2gd9LYWVefAuWKFT+cEmQZsMP0nhHKYwlGlBvATAD+NKo0PR/TucfL
WoRz5OmxhgjgaOXus5OInA+HbkVMHQ8=
=o0T3
-----END PGP SIGNATURE-----

--g1U+a5UdWq3DhaXT--
