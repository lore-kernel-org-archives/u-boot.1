Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AEDC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55B68785A;
	Thu, 25 Jan 2024 17:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZZD74JuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE3D8783B; Thu, 25 Jan 2024 17:14:20 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7453878ED
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ff7dc53ce0so52463037b3.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199256; x=1706804056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3x+/V4EQZ/jEYcAsAIkYuz7zS96K9aKPn5uiueyC0Yo=;
 b=ZZD74JuFwQVqdqfY1G608xNdkZiP5hn19FHkaVKjvtVFFlG4mR2qTlO9OFC9gkfPtk
 ZprPxuEsUhyufUve30Nwd9eFyvA5T0/Ncs3sNVnXVr38+EALEpFH3FwHg7lF6WHmrbto
 XjCG/ko/3az3kQvRFNors7fc6tCSozR8AthiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199256; x=1706804056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3x+/V4EQZ/jEYcAsAIkYuz7zS96K9aKPn5uiueyC0Yo=;
 b=rjFapKkvuvbrVFhmXXRIyBAa3rntOxJDHHqCQ9Imfi+9FahLRduoBKtNmgVuDS+nuk
 86EXfARXsI0ZjylHZf+2j9touMKLq41j/1sSkT6pvKcBasN57dw5njURaM4FZDap7JFj
 CsOp9qYFya1p2Baix09eVeoW04nLq/3ilDzyaaP0PnFrxyh+SECwnJ8J3JHKTGmX9t1Z
 9VHQsPb8W58r/+Yj4qPnBVdJODDFcHoQI5RdCcgzPjARvSeU0wqV5sLGslKX/c+3ecaw
 RqfsXsfPFxvjP+1td7cecLshRoMeFRaP7d+/DBys3upVaUxgvLOl0km7nb5UTrFECT1Z
 1FAw==
X-Gm-Message-State: AOJu0YwGzgkb2oXI3KanOXZGiC/6K4Sc0K9d23jssX8pZThKQBDp3Hbi
 goN7QcUnreZm52MjXieqwuz50eyixQWeyqw/FHoMQXQTj0hfCcwgOOnDxejSkyE=
X-Google-Smtp-Source: AGHT+IEFO8AyRjBcT9inV/zic1lVVD/xaBSmQPa8jRMd2hPpdLISM3wh0TeDJ4TBJJLd6EIifsTqBw==
X-Received: by 2002:a81:4045:0:b0:5eb:47b3:f7bd with SMTP id
 m5-20020a814045000000b005eb47b3f7bdmr35518ywn.40.1706199256495; 
 Thu, 25 Jan 2024 08:14:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w203-20020a8149d4000000b00602b93f6f27sm360559ywa.120.2024.01.25.08.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:16 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 5/6] configs: enable smbios command on sandbox
Message-ID: <20240125161414.GN3652023@bill-the-cat>
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
 <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6oLNJqTWhj1eKBhs"
Content-Disposition: inline
In-Reply-To: <20240125155438.47617-6-heinrich.schuchardt@canonical.com>
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


--6oLNJqTWhj1eKBhs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 04:54:37PM +0100, Heinrich Schuchardt wrote:

> To make use of the Python smbios test we need the smbios command.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
> 	new patch
> ---
>  configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)

We should do sandbox64 too I think? Ilias was saying something I believe
about testing one path via sandbox and another via sandbox64 (since they
have different base dts files, putting stuff for one code path in one
and stuff for the other in the other).

--=20
Tom

--6oLNJqTWhj1eKBhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiNIACgkQFHw5/5Y0
tyzLAwv9EcCjRvTj1iVKP5dpLDbIGbTwnHEwRsy1r8n3YUftA20/P4cgeZE7kkmN
04BicCn7QB07HjPdubwMbbFTmQBV91tuNOML6iYmX+pBcteTQvScQc8rq1mR9i56
XVUS8pnxWGv3xv6beskfohkH38oo1dR6smrQl7WXkxsQqmYxR7MFz7CepSzvPzRv
tC8JGFqUkiueyeLzIm79c0yRFSZx1wJHsbZ2W47cQ06K4X5Ljr2hGHHq6fktOQEO
ZWV1fGF4FJdaIa9Iw1/QehIjzDa1VOuGatbiT9AeMD0jBBZhRjSZiR2MBzbJDS1W
G2u6/r7BkdGqOXQKuSoEyUBZpF7/9NrF3pkkftGtnnrbhZyqkhJ+qXYnIpQxZQ8R
1x/5kRE6PH5f68Z9vV9/OI8ANkau+sHsZh56kDQubF7MFYlmHUvenm9mtQgBL25E
CoZUMtCVZWzLrMnjUHmMmetny8lZErI0zIaa1Ex9WpQ+FRDe7oKOqjx/ku9B6usg
v8iNtWPS
=TFFJ
-----END PGP SIGNATURE-----

--6oLNJqTWhj1eKBhs--
