Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A75EED628
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 16:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C918A83B22;
	Fri,  2 Jan 2026 17:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kdshkYQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A31E83B27; Fri,  2 Jan 2026 17:13:56 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2064B839A8
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 17:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45391956bfcso9656669b6e.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767370433; x=1767975233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zyCtT4pZomYY0Y6QH3DdzinXD55fL29j4/1ThwuF1sU=;
 b=kdshkYQAxfo9JhXmAh99KmGIY+IEmM4IUJQRmwlf11XjW1w2MlI3ibQ/fiTi2VGA1H
 3FmYWjO6aN2jEWajNtfNUxqqk65a/XswfYlgRasNsxjHfFpGXX38ihFKXDGtV6mtRstH
 FCypCCSHaJqTldV0PfLqlasD99b4FeaJr9sc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767370433; x=1767975233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyCtT4pZomYY0Y6QH3DdzinXD55fL29j4/1ThwuF1sU=;
 b=PFyQfy0GKsLZNiXZ61lL9lRHycBsPfLQdhs8WDZEOmRZV9h0lKjj6gdxk3ZPP1RYbW
 puXLkz4Mvg1ptGRDUTOCnlftN0VoKWGKFYAKbqcUc4AKRe8nZ2g4jIk88h71R+HzMCE1
 4iRHZ9MTAd9Adj6AXxd3iVuGweubWNLyeoJLPs/SS5DU6xxZxlkr5lviq2gVP8ITreKy
 +/8E7fPsqb9AtGRYehwNy2yeskdnYPhDgKEFWezTdm13fU5GBd9HeWXIK5LP72poLE2I
 NOcvT3xAPp33b7/eNz2wA0YKUIO+olqrTj+V79ynyiVryGH37rdObCCKVOTfDuGsIO3Z
 8XiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGuzLcgnR/+huYINbYz5M0CBNzOH/5NnfxWsWzIPgPK7TgZWRPm567TBMhjQ0MSt3XSfN8ack=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx5W3t+cD75iofIIr8e5RuCeFSvK2qeothoN8jpeIbPnEWICxq
 L+YWmqrPnal+UCohHPSG41LXF5JX8LTXCoeb9EdgKpYy0xVvPAVWnYuvmLeTdQpiN3TB8FGCUCt
 Lk8Tkowc=
X-Gm-Gg: AY/fxX4vTqXFSvToVgITeyHxoUCPLjDfNXjPqSj72TW4SRNAHzeWBh871KooRaMIw/g
 axHKxtz+nrBoEUB2s+7v/9ZnkNblC4UtZCM5Eao0yTWpOEEK48bXxQH4a+6z1GRnQTpj4ywrDqt
 TFzk/CDoybAr+n3XTPaZdzmbciB+yYIyMPmxae5yTxEcvCietPDZm8LokcY+vsDbZAY404E6/Ik
 lH04qSv2P/fL2hd2cgrlgKahduA6X6aTl8/qfT/Od93M9dqowGsmIL/q/rzuR+7KE1ftIcSr4YR
 6K8omuQyS5M+hAhgDV/+s1FvxtUiCzzrBhMZ6v23dG/wStzNdd2jhM34zkzKGObH+QULZvPSQ4q
 kpcQKwnCZz4kvSuk34XkiozC3V39/kJ2XjKonq3hB5DUg4gMV9xfTRs/i0eAGxD5UMNc7ukMtkD
 aFqk8HUlKY2cT6FOzXfdZEWnssI/+uMBFSIlYHw05PMJhDCrbwH7aAelJNLUXe/37hhalo9zIW4
 D52xWn+R3iCJA1f4B6P4ZFGO8zo0jrK//GCnzE=
X-Google-Smtp-Source: AGHT+IFSIsC0fg5u5S92vQMxVCfn6dEF7JFrKsPpYSqANJWoiNVVrx4723hlbIjsZaPaVeZyy+0QWQ==
X-Received: by 2002:a05:6830:4990:b0:79d:eccc:96eb with SMTP id
 46e09a7af769-7cc66a17d4dmr20174188a34.26.1767370432819; 
 Fri, 02 Jan 2026 08:13:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667281fesm28442473a34.6.2026.01.02.08.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 08:13:52 -0800 (PST)
Date: Fri, 2 Jan 2026 10:13:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add missing =?utf-8?B?4oCcbmV0?= =?utf-8?B?4oCd?= prefix
 in help net
Message-ID: <20260102161350.GG6124@bill-the-cat>
References: <20251227181852.4404-1-linkmauve@linkmauve.fr>
 <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
 <20260102154336.GF6124@bill-the-cat> <aVfsRY3_yW3gZudR@luna>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XNsGEV1bW127KX7P"
Content-Disposition: inline
In-Reply-To: <aVfsRY3_yW3gZudR@luna>
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


--XNsGEV1bW127KX7P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 05:03:17PM +0100, Link Mauve wrote:
> Hi,
>=20
> On Fri, Jan 02, 2026 at 09:43:36AM -0600, Tom Rini wrote:
> > On Fri, Jan 02, 2026 at 04:19:03PM +0100, Jerome Forissier wrote:
> >=20
> > > On 12/27/25 19:18, Emmanuel Gil Peyrot wrote:
> > > > From: Link Mauve <linkmauve@linkmauve.fr>
> > > >=20
> > > > The usage of the net sub-system was missing the complete command fo=
r =E2=80=9Cnet
> > > > stats=E2=80=9D.
> > > >=20
> > > > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > >=20
> > > Not sure this is a valid S-o-b as per the U-Boot guidelines (real name
> > > required?). Tom?
> >=20
> > As that is presumably Emmanuel's pseudonym, I would prefer their real
> > name, yes. It's also a trivial enough change that I don't think we need
> > to be overly concerned.
>=20
> I use both names undistinguishly, so pick whichever feels more real to
> you.  I am more well-known as Link Mauve even outside of the Internet,
> but haven=E2=80=99t changed my legal name to include it so far.

Thanks for explaining, Link is fine then.

--=20
Tom

--XNsGEV1bW127KX7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVfuuQAKCRAr4qD1Cr/k
CpyGAP0Q/pMoi9uj7XaBBSw7h1Dr/EMePUxxjk6C6ULO1hk4xwD6AopIgewvrSJA
N7js/J4KWVLldhLV++QZQYGCOW1xUg0=
=No0r
-----END PGP SIGNATURE-----

--XNsGEV1bW127KX7P--
