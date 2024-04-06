Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4098C3A59D
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 00:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABAA87ED0;
	Sat,  6 Apr 2024 02:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S30oVF8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E9587F3A; Sat,  6 Apr 2024 02:42:32 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D65487E1D
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 02:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c3d3710018so1835265b6e.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712364149; x=1712968949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eRYi5RMB+OTGRF6CfsFhaYtUzIDaZtqWPON4293fEBQ=;
 b=S30oVF8kwCrwXbIZOO5RT58fvEIme8ZGb7sV1h9k/OwSjXb7cQ0SANzzivxWveBlvO
 cVH8afvdcrAq8s4haV/pOlod5xkaA0erHc/J8rc54wGkJICZOYzBSaKCcLX5X98KjKbA
 7ZGqV4ug9XG5oWY8gVKsoR7TG1CZprB32hfuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712364149; x=1712968949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRYi5RMB+OTGRF6CfsFhaYtUzIDaZtqWPON4293fEBQ=;
 b=GBDPGUJfby2wVqhk3B2HmzUnBJ5PXDblQmZI9xKgsK4m47DOxOyr4K5HFq6cc/fhf3
 aentlT2G3Q0XhVTrY9zyn9YAca4wwomo/X7EKNi0I9+TmYtssz5muns2iJcusRgmbQUL
 773cGACIsfWd/i4Hn0TWswLIoD2DYOnK7YLIT4cEABDNpjyFONYPmnUyl8tUPso6kp/H
 f2Sh+g0SSuagjVcjjMSjOvkrUSJ3YRzD7cncVGSn2DEEXYvQNEP8kHrBcQ1Mq2E/2CC4
 urUcA4FI7uomsUJbBGcX/8SFCTSNtD4xst4wP1GJc9+0uyO1JY3loiqjBriDcv/QJlK0
 WkOQ==
X-Gm-Message-State: AOJu0Yxj8lwGnDeZmORXEwcuswtKPMcPoB5KYiBORGis1ATrZ++e90wv
 UAjrSSlWp1EiRID5zgB1lCbmZchojmoSB1UIzfUDJLaDiTL5lM47MKeEVDmyEY8=
X-Google-Smtp-Source: AGHT+IE2H5REhrJZ0ah8RS+G5vpR55xEacJpd+U5pj42VheKtOOQCMqG/qSks3NrJHGQk8myyi8KJw==
X-Received: by 2002:a05:6808:8:b0:3c3:e78d:f1be with SMTP id
 u8-20020a056808000800b003c3e78df1bemr2731734oic.57.1712364149202; 
 Fri, 05 Apr 2024 17:42:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 ha13-20020a05622a2b0d00b004344bcaee33sm1254990qtb.63.2024.04.05.17.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 17:42:27 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:41:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de, promsoft@gmail.com
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240406004154.GA114971@bill-the-cat>
References: <CGME20240404085411epcas1p3f10e648bd35670e090592cb4fbb97d58@epcas1p3.samsung.com>
 <1ff501da866d$a93e2370$fbba6a50$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2wW3yP3OzM8b7hIS"
Content-Disposition: inline
In-Reply-To: <1ff501da866d$a93e2370$fbba6a50$@samsung.com>
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


--2wW3yP3OzM8b7hIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 05:54:10PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit dde373bde392c38649c8c4420e0c98ef8d38d9=
dc:
>=20
>   Prepare v2024.04-rc5 (2024-03-25 21:56:50 -0400)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 1751ba9a3b79ea5083ff5c4de58fe3bd9588f32a:
>=20
>   clk: exynos: Add CMU_CORE and CMU_HSI for Exynos850 (2024-03-26 18:56:55
> +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2wW3yP3OzM8b7hIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQmk4ACgkQFHw5/5Y0
tyyDSwv9GVTP6epg3tCJ8qjGGK0++9SEuVwYuWpzj8UewEhYpG9kq/pxLi19AK3C
/EmALR0gqLO6kEfGmOJ5lDZ2hAyH75RdwkFRFrVG7XO8p9KcTcF8CHIswp9WwDUF
yNLjghRpmSP/IbQcNNKII3R2XAOd6h++fzLHnGA2Yi2FCy7KPQWHDH33QAfsEemq
vVf+kKCkXWm69Qymk/sSZHTwn54nm04NwBnHHi1YNNKVvY2gjEYSpk7eCv1WIVZ3
Y1MF97CvHcArm4+IhaGSF2b+7wxMzweDio/tsL7YHPoMczrRGdpRkE+7tvSxpli2
xTNEwGCp9/opUm1H5zyojPJnc/hoPgJ2MfPZdySH9WlUulV7H2EHmFwDQ52yJugf
UnFoSkQJq3QE3gXN3V0dU3O2vgQj/Ni4BSAcv6j+XYsNHnf0z4FkVeHWgnyuXh2R
WV9ulLDN9QNK2YUFNAOBDpV7PB1a2HOtp2S3m5pZNZ+ed0T+LJsBUtukf71iXZIQ
qHC3N/m2
=+1mL
-----END PGP SIGNATURE-----

--2wW3yP3OzM8b7hIS--
