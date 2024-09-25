Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61618CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C0888C94;
	Wed, 25 Sep 2024 19:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ggt7gUor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1626888C1C; Wed, 25 Sep 2024 19:26:06 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A66D88C05
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-457ce5fda1aso254981cf.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285149; x=1727889949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=91PsbCIBqXtz7NTU8E88FNjzY5A9oyRQqHcN/K/Hu+4=;
 b=ggt7gUorMqiWd4ZGhZLST+TDJE9LkSrV2U0xNUHTI03Jpug6PdN8qASIwQG4V/nWVb
 cU53v40eIHjpcNr0IkCW15+9L0Dh13oWO7ZkZ2+GHv/5/aYSuM5NyrGazb/lwwKzM6ui
 QXJbHlA7QSUSiCLauQilbbSHLAuVfCN7P9OiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285149; x=1727889949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91PsbCIBqXtz7NTU8E88FNjzY5A9oyRQqHcN/K/Hu+4=;
 b=hkpVseXW1P4YdaPexo/aSSTAxQIxr2EkWvtzQUuQksqtcl+iudnlL6wX+vzxO3fiHD
 enorIoTgFMyuEWqnlbc4Lrk7h65+5krZNGx98MrVr5DOLwZyy2Zu7Jl9o08SjwDjeDE0
 vzEEJGz1qsC2u6H6grjsLTRVHg8NmKYNONk37UyjetBzjkjqmqdZ+gdbLkPnbUo9yFXC
 79n33R61MEc4albOe8d5snEB+3JqnpQmLiK+M7zgBhcw6mk0D9+e4IA1XjWexXyn0SC+
 DR4CEEee6MiI4f2QYOrDNPV/dHK/r1G7Z+W/x2uX+Qo5KnXe6D314G/9fuHFNV1BAIeg
 hzQA==
X-Gm-Message-State: AOJu0Yz+vnSBMmfP2bTTnwsOTEfVeqlMKjpDsS9vktqHhG8RkVytAmYy
 jpeobuV+GBanqCjJxdwLYcYE9M7jiFihEIGVNPFivsfNFtylDPPTzX3Bua3rr1coRSji8lUHz2k
 9TAc=
X-Google-Smtp-Source: AGHT+IGVu7RUDxdQ5BeQG8TqRnkAxUXNmVRLJnpUBC/XAh1U+fVdh4U/dfEJU7v81z9KBhbEiDDctQ==
X-Received: by 2002:ac8:5d51:0:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-45b5e02c581mr64242651cf.44.1727285148914; 
 Wed, 25 Sep 2024 10:25:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5264d3b1sm17906931cf.70.2024.09.25.10.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:25:47 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:25:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240925
Message-ID: <20240925172544.GY4252@bill-the-cat>
References: <20240925114025.307966-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ySfiRA199MRrs6Q2"
Content-Disposition: inline
In-Reply-To: <20240925114025.307966-1-festevam@gmail.com>
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


--ySfiRA199MRrs6Q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 08:40:25AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 0aea8264f668bdcb2f352e6facc8d1cebe873e=
0a:
>=20
>   Merge tag 'xilinx-for-v2025.01-rc1' of https://source.denx.de/u-boot/cu=
stodians/u-boot-microblaze into next (2024-09-23 08:11:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240925
>=20
> for you to fetch changes up to 99abeaa648052e8e99682f046b8dfd3739b4e181:
>=20
>   net: fec_mxc: Skip recv packet process when fec is halted (2024-09-24 1=
6:55:14 -0300)
>=20
> u-boot-imx-next-20240925

Applied to u-boot/next, thanks!

--=20
Tom

--ySfiRA199MRrs6Q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R5UACgkQFHw5/5Y0
tyxiZwv+NzspESZ4qwIW1JwV+wMsK2pk4ome3U8JIPwYHQe7+6Ol5JYr622CAzi5
Y4fRtgwigC2Zra/XHj+ANQogHlzOcvYU1j2QzBuANS3JmBT79Hb+gfPNKXAzWKiZ
mK03Vs+fenNcBYo4jj/nIW7YuXMJUJOWy7m6hYO8dkk5TxtcUsBYMscJHQzPafa+
kh9s359CvhY+p/zzHvEKLVGXkxh+FE0W6ur4S/r1CzmWWGlajG9SYsJE06SWntjo
MNmqH+3plq4pmkkljd+guvX3ZNtgXxfo8o7wMJ3V9duTB60ed3Lm8pNl9lLs0kjD
3+g9JmSh4LEa/bYJKc9+7V8g0FKhxNkauLdufGso8E/w4xNyFALiDF70PXf+9xmg
2T6v3UZUcWzJ8RwMpcHBfwPiBfqXa5FCPRdzEB2Gl1yoAFnUytrzBF/zHClTxZGf
G215tw4Eny3gurPi6Q07QYCTVwd2RK9UhI/Aq2nuDHaCSddN4e7rvrku02+nrXYX
ktWxVCqd
=yCh8
-----END PGP SIGNATURE-----

--ySfiRA199MRrs6Q2--
