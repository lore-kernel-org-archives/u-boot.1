Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92299CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC27186B82;
	Tue, 10 Oct 2023 14:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FjTbD5Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5F686B98; Tue, 10 Oct 2023 14:57:54 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E4E86B82
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7a7e9357eso16573987b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942671; x=1697547471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UZ3MYDRwX93GWljCyvfpTiw/B0rrs156P8pH9IW+cKA=;
 b=FjTbD5ObWYgxbGMnjX21igK92OJAly1YTE+fmWfbX66t4kEZiG2QXOTX1/8TemuCqk
 ipWsq5C69a3YspxYjV50FHRFlIESSlXeYOaScfynqL2hArTm3jtAxP2WT3SD2ubyxb0w
 jCMaE4pZduuvwVcgQMx6NPJLHxamUvCtHx504=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942671; x=1697547471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZ3MYDRwX93GWljCyvfpTiw/B0rrs156P8pH9IW+cKA=;
 b=hLHpfnvXGhEcFUbCv08iBYlvfkA69pRZNSh1eXt2Cgd41O4prEG2oxivIdqI05fDvn
 CkEQ17pOyChLrF1/W18BKRJrNFt65kDLxcPgkBCBrxn5bI4vjgMR5VAym+aco0uM5j5y
 bev+0DkLBpTVdoGjMhn+tU/VjPP8yQcaZSHo8GS+IpJJzF4IMeH0ahz8308CCqC0A0vq
 PijRkwMLgPBt53R2EOXtqNM66w687V24C2voZa7GMNZyGOCy0kmZXqo/QpAFNSCCu8Ga
 4fo/Tpc+qv5GDmgBYM1IE+B3P0jFKb+Rf98ERa3lDqQpI6Z2WhaWOgz/oSWfmhSEaLL3
 +hTA==
X-Gm-Message-State: AOJu0YyH2FEA6CN9Tljli4xLYBvHtrJS7/vACiORKddXC+FEqIb7k3z1
 eE4NW4zbSTLA6Rj1TdB3VIhV9IZQulL6fLmnXsG8sQ==
X-Google-Smtp-Source: AGHT+IEm4pu9ROswelql4g48xLaZ/NJjwY2aYQMFWPJKALU1qnHvFbJKvVXtfFH6+hNY6LbGb+ka8A==
X-Received: by 2002:a0d:ca06:0:b0:59f:5b6d:c9ba with SMTP id
 m6-20020a0dca06000000b0059f5b6dc9bamr17925030ywd.20.1696942670816; 
 Tue, 10 Oct 2023 05:57:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 t194-20020a0deacb000000b005a7d46770f2sm25609ywe.83.2023.10.10.05.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:57:50 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Andreas Dannenberg <dannenberg@ti.com>,
 Lokesh Vutla <lokeshvutla@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] mailbox: k3-sec-proxy: fix error handling for missing
 scfg in FDT
Message-ID: <20231010125748.GT2227687@bill-the-cat>
References: <20230926124254.127465-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eotm42EY8B2uj5Fd"
Content-Disposition: inline
In-Reply-To: <20230926124254.127465-1-matthias.schiffer@ew.tq-group.com>
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


--Eotm42EY8B2uj5Fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 02:42:54PM +0200, Matthias Schiffer wrote:

> The wrong field was checked.
>=20
> Fixes: f9aa41023bd9 ("mailbox: Introduce K3 Secure Proxy Driver")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Eotm42EY8B2uj5Fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSkwACgkQFHw5/5Y0
tywrDAwAsz2OGnJAFYSfVYVjIhNNIU+kj4wKYXjcaGQGgiX0cK1UKDlgbrtBfiG8
JT75D0rK4n1qIFsZwL88cpq19+bTqBSTq7cz2cjfVDNIMqTQ4k7K/jEeFIbEjPpm
EBdVSKuwly/GiABiXmCZoCkqXIjbw3tftLWLWZQL3mrxyIZBJSCkIH9o/mJVXosh
ybARGeC7JftcD3+VWp+qHuLVibykFSug1SJN0fevN9Ybf8KiMrPx55Xls58fAM85
0RyC73999vAy3gxNisK0c7E3gfZwdYZ7yX4PfIHYVOGuV9Xjlqir4IFR7hrvPBud
0I96mRY+k1FQsM6oDcO7bk5zdQuxT/FzZqCrUzvQ9gi2++wq/Z6jxmc3Luxh4B5w
qqfMbSDZYbAucqd0J+AEBdIMEx1FJf4rgsrCZEoh8HGe8si0G/yUDbjG5ZhiJyqA
kuHVmg1XvZMh/qtms1WnzcUF3C22zx/1UxW9MqK1LlQJm9N/3U0e4ciFAQKEWIp1
c0llSCz6
=t9X7
-----END PGP SIGNATURE-----

--Eotm42EY8B2uj5Fd--
