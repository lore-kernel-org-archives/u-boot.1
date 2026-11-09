Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741C606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x8JvSGFu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZI9LPzOQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 226B7405F6;
	Mon,  9 Nov 2026 19:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CcBRjOA-43eT; Mon,  9 Nov 2026 19:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A7FC405E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794251618;
	b=sBvu6gdtGOsn5xWxZqqJtMyt89xt7Tu0AoGmTlqSK3uv4y+RlZkfFwkR0r0QL42TSBiy
	 srSP2jrEMsROYM3l8XldjCX9qpoWblTnGIsF2ru0sLNAMlq+RKrsS9Cngz2E39BkDitpW
	 g4AiUa2hVNgszgNMYBBsSaqojxT59VxrBl/Br8Ymar4M+MduI9Xc4iERLJhiBpk3zSzcp
	 Fe0jSe2Al2b2uFEcpDf94G5FD0VKQf8zD9fk5YNjXAfGnzTYfX99/zrmohWsn45OPKRtB
	 97yjq+qKrJzX8sqCwACi9YNKdoepAIV971H3J2dxubsacEVtnHL9goxaTkDqdSAKqcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/yPB6aqIJD9vER3RRMui9OzdyApna6cm2lDipC3Sou8=;
	b=m8rzZwaychs0fTiRHJbr/v3Vushvq+TIdZsjO1Ogw+Vq+BDoS1Sq+DWZCR7yWye6nYIx
	 DgbiH3Cg6opqLrikJJVYx6dn3QKuG8kQb77XeOTEnGYDaw9GvaQUmQY1KEpyo0/p9TO9V
	 KLiY8uUHfANi10+a3X2+Ef8Dz/ge8N+TVE9aWDl8HbNis6GKFB1c1BZ0eetni0SuQb1UU
	 yaxT2VtsXIJa3LEq3Rl+5yifc//0XZ2F2PKypSnyU/PGw15Kj5o0QXA/+Yg/d8kowIJCz
	 gbNEie5ObnXArXHbdMIwyf/pJ6nrqfMN0L5WS/DS+jIISrDPWMqucUvitJBNDGI2U8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794251618;
	bh=/yPB6aqIJD9vER3RRMui9OzdyApna6cm2lDipC3Sou8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8JvSGFuIxa1ltOCermXpPNyPZ2SNQmh8zMcrxaA6iRFUeG/J5GM9R9qSAi4IOAZJ
	 nvjgYfBJ9aREH/sqjysqkqOF+ff0PSHT1UNrtf9yBBubPqcp4Q+a1/vNBVXcZESsux
	 CLt1PtuEW7nMSr5w0kUz16GwKplKcRYPhM8vqehzLXrLYdhcLzS+1n5glKu+7nmXw4
	 qH1dGh7ocdr4FL7UzQ2YJHVo+dfC4HfllBuTwhWvwPvsVkAsTV/eF3dHedSrWmn5R0
	 SzIIOlenn5c1sH0IDpgdWLK0v0aot0Z3NNra8gAFz9ONHmuz4Xw42fK05QK//IlgOb
	 z4+iXDb+39+9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A7FC405E6;
	Mon,  9 Nov 2026 19:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A491D1FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 800EF402C8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVMEIdFT_gRS for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 92514402CF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::8;
 helo=mail-oa2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZI9LPzOQ
Received: from mail-oa2-x08.google.com (mail-oa2-x08.google.com
 [IPv6:2607:f8b0:4864:30::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92514402CF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:13:35 +0000 (UTC)
Received: by mail-oa2-x08.google.com with SMTP id
 586e51a60fabf-4ad827109b4so263277fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794251614; x=1794856414;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/yPB6aqIJD9vER3RRMui9OzdyApna6cm2lDipC3Sou8=;
 b=ZI9LPzOQT2jEP2OUYm/uTE5QE06TaoxJm/fW6JvIGbuIFkJnCvfkAn7Lx0hUzkKc/N
 u58EQVcDgsQ2q+f0ybp/exevv67AirUmXaSE84dkZXBTdzef00Mhv3Ud9vAfCBLffXTD
 6Bc/B5soqX9hEk3Mc2Knkw79Civ78rA55bdOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794251614; x=1794856414;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/yPB6aqIJD9vER3RRMui9OzdyApna6cm2lDipC3Sou8=;
 b=XengosoxIdjR7/lNN/q0g3syB0GPfQcF92B1ELnCyEOQcgwXM6jpG9Jiz/ewLNgjxg
 YnDX4eMI64JcHvvEh1UtVT+kBclA1BPbzRyV4yGU4OFQ4IFgaXPfnio2vt7XBuOVO5cE
 x5N5oEy/xComEdmRaVKYX3JlC65YYc8OSbXBf5cpera4DDAaRZCi/PsFSUAuroXLj4wO
 Qe+wceGDM8T3ZZdkIp08CZLVW9p2Oqb7Rc0Zh29bHEvFxO7i9gVymi3sX8+fHJgP20am
 xdeSCaINNyEZ7KHb7RHEwOWrdLL05cFw2pAIMNGl+nAKqMA56cv4xinfIVHGozBBdYOt
 PtTA==
X-Forwarded-Encrypted: i=1;
 AL+hErHfJZ4R8JWeKwoXZ6A68aYtnEuzG96Z8amIwJL3c98HfgjjzlBgnHANvz9YPh2eKkmKlecflaQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9f5isQYSZrcwzblD4TxKIwOOSmSYrZrsEkQr3YmtrND0HCdx3t
 hPdB2VSx1/JLUMFsbZAm1MkNBB8mc/EiJVAECr89HyrZr+EN7Nj8oZgiRHFiq7MXns8=
X-Gm-Gg: AYBFou0AzyoEKZ7p5nbP+QneLQWRTcRH/VnkEilRelvYlKKgGbgplzE0lr2T0UOwD4D
 jCiFRMNbOhmhR9NwnxmZi8gECZ/8tvXY/oh9MapUY7RhXOEe+OwOzmDUvtZQRA9hotxKdaM08ea
 rWmqFZ2bRmfEdwlF9lQAD+uVo/jRLEqmHt9jzjqq4kcmN55xzmQWxhhZSjX+MANnlmg17WgmD0d
 bcRm+Bb4nu5Px6fS3FzFUcgISsA43FC1gevuVXYrmSWKtaUFirXt/gANzQyVRRNh4KNzNNb41Mo
 qBpF8qbuupAKMTyXk7EKyPwJW0MCnnn1husnIxpvIXUWC9GaEQNWjM9u+gtB5rrKNd8v1GRsL9+
 L2P6/ZMKNPmesSanybGLCvcUe+I1RbbBQ5YTaeEpgB+6msGQuyfxU2swtlBTouwwx5aZtW/Tw7Z
 zkE7y7gAwgfraMyKtcLdsEvyo9at0bICaaKsy+h2u9osutNsf32QTSoTqMqnSCh3gxo8wtG01jx
 LVHvL+FrqaKqADr1dsOxYZvmFroVgaCKKztJrQ9VJ09XrfAsh7IGjphjTMvKwvbj4zzd07tcbWh
 tXGbqYC1cD+ndV79sZqfO+8VLL1eTkh105dZ7l5KdpcmJdQW+EpxPYJV31gkSDQw9H9LiCnhQVR
 EGiHR8F69hJ6u6lKTnI1RzX1VuLSqejqFWdGaOa25/+5D9IZTVb3w1NcQ0lWP4nBLzRiDdvD4dp
 7xCv5ow/I6FErL9Rp3/ydhjjQUwXRojhtuGXz9l0nsLWxci1SwBEw=
X-Received: by 2002:a05:6808:150b:b0:4c3:7073:8c4d with SMTP id
 5614622812f47-5683cc1660bmr445336b6e.20.1794251614148; 
 Mon, 09 Nov 2026 11:13:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905f39c60sm3665b6e.14.2026.11.09.11.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 11:13:33 -0800 (PST)
Date: Mon, 9 Nov 2026 13:13:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <20261109191330.GW3741582@bill-the-cat>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
 <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
 <avDgloDmuQcYP7ec@L30177.local>
 <8229e24f-bc71-4232-b1bb-8cd6c976dd3a@freeshell.de>
 <avIBHFyUj8mDk6PQ@l3017727.home>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IuhH1MXUuSLJ8XsU"
Content-Disposition: inline
In-Reply-To: <avIBHFyUj8mDk6PQ@l3017727.home>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--IuhH1MXUuSLJ8XsU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 06:21:32PM +0100, Vincent Jardin wrote:
> Hi,
>=20
> Le 08/11/26 16:58, E Shattow a =E9crit :
> > Hi Vincent,
> >=20
> > There is a concern that vendors would normalize this and make the
> > situation even more fragmented, contrary to the intent of having
> > Linux as the device tree upstream in-tree as a 'dts' sub-tree.
>=20
> I do not want that neither: the DTS of a board SHALL be upstream
> in Linux and in u-boot -> "upstream first"
>=20
> What I (we, I feel I am not alone) want is only to smooth the local
> bring-up, the months before the board is upstream, when the .dts
> changes several times a day and the build is the Yocto or Buildroot
> image of an internal team and its CI.
>=20
> Compiling u-boot outside of any build system does not help there,
> and the copies into arch/<arch>/dts that the layers do today [4][5][6]
> are a fragmentation.
>=20
> So the question could be how to make EXT_DTS_DIR usable for a bring-up and
> useless as a permanent home.
>=20
> For v2, I can explore more upstream "guards" for U-Boot like the one that
> already applies to CONFIG_OF_EMBED, which "crept into use":
>=20
>  - it stays a make variable, like EXT_DTB and DEVICE_TREE: no defconfig
>    can set it, no board can depend on it
>=20
>  - a stderr banner as CONFIG_OF_EMBED whenever it is set: the
>    device tree comes from outside the tree, not for boards in mainline
>    I mean, https://git.u-boot-project.org/u-boot/u-boot/-/blob/master/Mak=
efile#L1404
>=20
>  - maybe, an error when a name of the list also exists in dts/upstream or
>    arch/<arch>/dts: the directory can add a device tree, never shadow an
>    upstream one -> I do not like it because it avoids improving/preparing
>    a new DTS before sending. Maybe having an experimental flag.
>=20
>  - control.rst: a third option in the Configuration section, next to
>    arch/<arch>/dts and update-subtree.sh pick, for a board that is not
>    in the tree: a board sent upstream must come with its .dts
>=20
>  - others ?
>=20
> The SoC .dtsi are still taken from dts/upstream, only the board file
> would come from outside, as it does with EXT_DTB today (that was the answ=
er
> for the VisionFive 2 question last April [7], with a precompiled blob
> because DEVICE_TREE=3D cannot build a file outside the tree).

It's a fine line to walk. Vendors who are trying to do the right thing
should be encouraged and so not walk in to "walls" that block progress.
Vendors that don't care about doing the right thing will just patch over
whatever check we add. Probably that first option is enough, it can be
set in metadata that builds U-Boot as needed.

--=20
Tom

--IuhH1MXUuSLJ8XsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIbVwAKCRAr4qD1Cr/k
CohBAQCb6rzu9ydbYN7u++1lQSlc9pCGyHOWBT9XGoQzIq7FZgEA0HQJ/ExczDjU
6EBfWZR8beasdKXIMu1zusEaHNA4Agc=
=tkwY
-----END PGP SIGNATURE-----

--IuhH1MXUuSLJ8XsU--
