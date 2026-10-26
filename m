Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD71606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0PnAPDuG;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GUFdKCQ1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E7C40742;
	Mon, 26 Oct 2026 17:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHWDL8rQI2lR; Mon, 26 Oct 2026 17:19:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B397F405BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035168;
	b=aPHavnN0xANYslYNZP0hYPhPLQPrDJaqTULETUsqkCdoGAqbwt9TCE4YE7TL3ydq2D6b
	 lRXaZnvWRlSpGQiiYBUvBMW7/+bqP/3YMwq8ttAFNGWUSgF9kjl9XI7cp2muwVD8b+Czg
	 bvMhVk+PI0VoekM+EOvtuJhC3Zr4GAqpWzyZPTrSJZAP5coWMV75bBfD6Xc27WkNquDP5
	 rprsHIvB2kwwLnXoGYn/QnTXznLVoo/sOEZOAmgMIpIkyAc0uzucWF+C4vcaTxHDJcJwv
	 YmwH4r2X1DKWoxokF+KZuDZ4BszTFevcjZKswAVmup04mcDT7W5dOTUYMB9jdHY63Aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035168;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mLxTvMhB5LyRB+GdGIu87LPvKNRqbBS2jHHkisGvlUU=;
	b=ROWUGzIDS36v8p3BtKVJITkN/x/TjW7epjgcvE9Yl+CEL1b4F5FO1zE88hARHjnfZepm
	 MUATQNxDxtqfw6OkxDhyEeDaFQ6LkVczX/McF675JDOoTFxwvCp/dajGSapc+v8+dAZ1U
	 R1vJc19hGqdJuKbOtp56MtETJ+zYaaGMe2Q/yhUnsGFNgD7fnxS5nJRbx3UplzUiMOEDs
	 gzUjXV8x0cg6XAZ9cKLWOxr53rcfHtS+oe4JH8nJi9nlt/s4LMJLswmA866ukFcxoS81l
	 63ZSvxgyR35cka6Ic7xd1PUJ16iG0TNMMHEwns23fMg+cZwEbfwWv2rMAE9OxxsuoxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035168;
	bh=mLxTvMhB5LyRB+GdGIu87LPvKNRqbBS2jHHkisGvlUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PnAPDuGRcgHC8O9/tsdqmT2gb1gCN9If/bNd5WGhnL7KYV15JEeDAo+421Z/4f6D
	 Arm9szzWRUn/52KsMUWCP6WwET03icKCsLVDMDmIHh3rUdc5qd6Z4Vbs89k7iNkVPC
	 NP4A2v5Ua7S7fLGu5/6XkUnDucPEbw+ir5OhnONo0fT8FFhaGGQ5jjykoxbmzvHUP6
	 uYabbehA8gGSLDQeeY3PexPuNOUzY+PdFvSuTZGC3XubcHj1OkXkQ7kKChn6H0baj1
	 KWDoYhWjkEbC5/ow4NI6JzKK/imnKO6CN3Gc4+9ZyCdSg9IwLAKMPe1Op9pq8eltw9
	 GDI9GYkztfQ0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B397F405BB;
	Mon, 26 Oct 2026 17:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DE08120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F362980CF2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqygPKMYzVjx for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:19:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C68080CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035166;
 b=iAcu3CUztCF4V46tsQX6otsxizFEHljE/iNdCKeRjcUNUSXgqXRpuNIRdhJLyyOsurj4
 Y8L2ocz70+UMGpcHDliYqOeEfXpue6mUbYmN4gdDO4owhOJA3Ehvs94rZOiXmXUqX/oTy
 N6fEbbbCE2M4iCiJf7NWy3rfwBWn5dIWos+VG59GSJ8PN5uAPz9+XhCnor5YN5yquQDpR
 q1UKM7su+uu1VF15VXM+93mJFENY1ZNjX2W7Aw/rhr7S+gXtjnGeFOFdx2SIGQsB7PIx4
 b0xM8q5Na/TtTUMKI2+evZgwV3520QFQJEXK4GBHAhAk22z9CmKAW4jOvnc7KMYqiKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035166;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mLxTvMhB5LyRB+GdGIu87LPvKNRqbBS2jHHkisGvlUU=;
 b=TDfj1J68+ItYznLv/R9JU2uIcB6u8pq83JKPlfKLY1t+XOPcd8QkKm4/H+Huugl0o2bZ
 /0wVXoZSowizk+UEf4oZPS/oAwb+6RslcnPOFckHUClu+Y7igwYqahyveUlbIiWKzUzD4
 tnKaycSta7xfAoV0mnZEpNttteZi5F85GzJ6AL66iQ4QffjI8g/2Ja3BuM3oRVmgsaU1C
 q4xN6lEYWO1MNoHdRbYTNR8qLqmOtZsbCCx16D6uAR5lEKn3qH8xGfQt9+lOougLi2won
 cBTaD89IQp1YGuGa1jNutB4AqXnOjIhqU6rl6gtj38h1PaJ5u+RFLZAzgqZBSHZFf+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GUFdKCQ1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GUFdKCQ1
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C68080CCA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:19:25 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-702fd86d674so2088974eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793035164; x=1793639964;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mLxTvMhB5LyRB+GdGIu87LPvKNRqbBS2jHHkisGvlUU=;
 b=GUFdKCQ1s3fsYJveLuFmddyLUZmKLOrJrCrlgS3DU44mfyD/qU6LU52PREOvNbEj4q
 9lWyfbBT0NLITqFh4QanlQ0dGftroqxBUKgzRbrNaRICSvsf0pa8LLAw3fSsSwG3Gwuj
 Dgby5DiHSz2+oVPZvOTNfZc69F1VxlQdegsZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035164; x=1793639964;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mLxTvMhB5LyRB+GdGIu87LPvKNRqbBS2jHHkisGvlUU=;
 b=ZOXbdwmfqRu1DACyESzAFtN5ltkH0ZSnxwqAnGPAYqCSfudUKN11LyUohNsVSL7RKS
 k2d9V/f2mj6q3jJ6mZq9CHLkdqlx+RdcwBi6SwFgdG/VjfWscJJhHXDoJb+VR574mX/a
 nC2UDpkVV8GZYY/Z69zbTtUSNVrc1Iulwi3u8I+A6veG8DfvQ+3lXG7l+B7ez+vK355o
 A92Hss//xJ7/0pXUAuqVz1W2yhri6E+/J1hIrZDN3GdRw5w135AE0iVYHomIX3HcHvyM
 UXmUM1sC4HjequCL55VwsLLm9o7ATHebafsBiXgz88ZQKgzapuY13xq03Twd+sHXWSKa
 TlHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHNduzm1NaoNMznt2zsrcc63v8VeKtpmsxiBUDr1IlvD0KmNOXRcEsOQqh1bT2w6eYmfk0J/8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJkzlmt5SCKNT4QiJbx4KBBvxpYd2Rs/pKU3ZnVickgYXdnnuRQ
 A6sxNukngEmiyjntimlLeW2VxjhwPwqmdtJqmzI5RFpnFcjhUsHGLasGx3XWY/SadB8=
X-Gm-Gg: AYBFou2eETgR1CCeLfHXd4LeqlbpFMD0RD+3a7CMj1CutWLQ8LrmIbhF0X4NJi18wNj
 627FDu4sztm2pWhDl9So0/xJL4K/MiU3/O/ZNOn4oyft9xp7g4/9tzIDfV3IKIA5q190Ez5S9dY
 kgThZgvXCuiOWcMVhDDv+U4x0bkguvQseLEVhXkvTLp1VbcsWjnXa44YWe9IbQom4RtZr6CMQxc
 IVblIN8sE+jOSOspBygrmIzPeaxN81v3R8oAzIAbq0kjaUy7B+yHM2mkhbTzcgOiBqNUViYVLUs
 9gbmVcSO1SkHZxU+ymQLpvBlHKNGKrujJVBC1Ceqj3u/pECfofqejh/HLKtEcruQjH9z9e1/cHo
 AMCRqfZxdJYJO227l7w6BtnTupoCglUTcYxmgKotlHTa1hsWNSJBrbw3au9Q3evSejaZYmgW6I6
 y5FMjZaN5IudEcix5e33ivMXNY+vDMk0kGNgJaUCEZeMwSdtoNFQmDXPJUy31CF7qTX87lfoACk
 s+pKzEuPJv2SGZnAa6N/DB9re3P9ezMof25GG3RQbs4qysehtJKURrDio/ASv0JK6Vms3YV6rQ0
 m5t9b5e1doICSS74Thl3OgCo+PnX0Tl/cZZUXrD3xmU6q/KrcGrj+/Xxw7gsEJmzYfXisG7WTZ/
 qt+uy4mI2Aibmqd0XubWN/2zmAkQFirYhAWAjZj5Or5PJYVmtLig7QdFso69FIkHvU3UxcjC5E4
 xTo5o=
X-Received: by 2002:a05:6820:a299:10b0:6fa:ae05:1c7b with SMTP id
 006d021491bc7-70ba0da226dmr2726902eaf.23.1793035161671; 
 Mon, 26 Oct 2026 10:19:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e2cd81bsm7037310eaf.14.2026.10.26.10.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:19:20 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:19:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: Bradley Morgan <brads@mainlining.org>, Vincent Jardin <vjardin@free.fr>,
 Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261026171918.GD646438@bill-the-cat>
References: <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DSP6gUP3XhQ9Ahn/"
Content-Disposition: inline
In-Reply-To: <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--DSP6gUP3XhQ9Ahn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 04:55:09PM +0000, Tomas Alvarez Vanoli wrote:
> >>
> >>Hi all,
> >>
> >>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /
> >>mpc85xx) in a product, and we intend to keep up with mainline as much as
> >>we can. We'd appreciate PowerPC support staying in tree, and we're happy
> >>to test patches on T1040 hardware and report back.
> >>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit)
> >>and
> >>linux in 64-bit.
> >>I am in the process of bringing it up to our 2025.07 branch and
> >>potentially
> >>mainlining as much as possible. We have some remnants of it under
> >>`board/keymile/kmcent2`.
> >
> >Would T1042D4RDB affect you?
>=20
> Not directly from what I see in the code, as long as the shared code with
> ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report that
> there are dozens of us using powerpc :)

This is why I'm trying to go slowly with dropping the PowerPC boards
that *probably* no one is caring about. Size growth has been (although I
dare say I will be haunted by this statement) kept relatively under
control for a good while. In all of PowerPC there is one DM migration
build time warning. So to borrow a phrase, if it ain't broke, it doesn't
need to be removed. The amount of active maintenance it requires is
small.

> >>If any of the planned removals or cleanups touch T104x/QorIQ code or
> >>boards, please keep me and holger.brunck@hitachienergy.com on Cc.

Holger shows up for 3 keymile boards, and you show up for one of those
as well. A thing that would really help is adding yourselves to
MAINTAINER entries for any other platforms, especially reference
platforms, that you also still have interest in.

--=20
Tom

--DSP6gUP3XhQ9Ahn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+LkgAKCRAr4qD1Cr/k
CqRLAP9tJBIwkgzDFncGO4NAx7MkUb/o9c4cK+3iuafwD37jnwD/bVRQO+pMfAGI
x32umVjrW6sj/E5NovWaPxafLQJ3OQI=
=ex55
-----END PGP SIGNATURE-----

--DSP6gUP3XhQ9Ahn/--
