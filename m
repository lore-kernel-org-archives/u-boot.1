Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F57EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 10:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744FC864AD;
	Wed, 23 Aug 2023 12:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1k9dUkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940D7864B3; Wed, 23 Aug 2023 12:53:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78EC86435
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 12:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bed101b70so708085666b.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 03:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692788008; x=1693392808;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e98E3ZhvEihdL9O3R/Qclfqf53NC/hMvcgREf4q1aoc=;
 b=G1k9dUkv32x+roKYuvNnboRUNuBjra2F4uLMiYIhbJpzQbhTz5D/agHR73exXRSvdz
 VO6myXDdfcAmR81iNm7GH6Zgiv9KnPMQsv6STxj4BtZj+NTw6T+1LiYTDB7ZHEE7N0H/
 ORcU1tpy30xZGAk/Sf2w56/smjVHIA+MkSiJBe4D/bHBTFem43iJi63EWpSXeZ5tgXsn
 mZyxUDBots3pllAr7KOH7oki9hduoYmLwaJuejXQ4xKFTF2BZh+0Suf1ktQql0moL0PV
 b8A3yE7f3N5opirA/vZMeQ3gONRSJYlkRUx3R1zgob/8UyM7nwQz9e1u2FGURXDp8ceZ
 0w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692788008; x=1693392808;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e98E3ZhvEihdL9O3R/Qclfqf53NC/hMvcgREf4q1aoc=;
 b=WyQZ4O/Pr0ycvT1fL7zMfpRyS/N8dgiv5H+rRQDs+nC+t0pVa7z5Wz6EvvohSXyWBM
 jYbmEP9l0yIQysMGjFZimnORJpQybZE3sFc+B+Xo90HTsBOyHDkN/ylNcw2PNz5BOmFL
 3dQGrlvPTA9dP5GSsFcD1E0eKM+bI7FsAknvXfqL/O1oZlRc6hGdDgVe3zEyBt8Duy9M
 S9gV/C5fHPHCyyrGePaZZQAR89jYV8VmqUxUuQDbUyJoerunrvbD5L60iYQ11pLZPG+u
 cZqNM3u7MrmdxU8KbKA1lfrXd+vMhv/7SC8hUA3P2jaQYBNePb8tIp6tw1j3QXnk+Wvv
 QQ8Q==
X-Gm-Message-State: AOJu0YylmW8pBMbHZWqX6RH75Y+bqN6N3LR5QwhEePS8nU8w07hQeFcz
 QikNiL6pwD0iinb/kI1AAo2OjpZkgNs=
X-Google-Smtp-Source: AGHT+IGJD9au7azpw6un1v61Lj80BSacokR0PNL/eusP/A1fQrUIsg1HzBF7aqBc80sHnO8Zd/qJyw==
X-Received: by 2002:a17:906:10dc:b0:9a1:bf00:ae4e with SMTP id
 v28-20020a17090610dc00b009a1bf00ae4emr3489355ejv.54.1692788008109; 
 Wed, 23 Aug 2023 03:53:28 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a1709063b9900b0098e422d6758sm9567507ejf.219.2023.08.23.03.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 03:53:27 -0700 (PDT)
Date: Wed, 23 Aug 2023 12:53:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] tegra_mmc: get tap and trim from dts
Message-ID: <ZOXlJmZicgBUINlb@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IAS/W3g8cdl95ybc"
Content-Disposition: inline
In-Reply-To: <20230819153501.77245-1-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--IAS/W3g8cdl95ybc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 06:35:00PM +0300, Svyatoslav Ryhel wrote:
> Default-tap and default-trim values are used for eMMC setup
> mostly on T114+ devices. As for now, those values are hardcoded
> for T210 and ignored for all other Tegra generations. Fix this
> by passing tap and trim values from dts.
>=20
> This commit will cause regression on T210 (emmc may not work),
> fix is applied in tegra210.dtsi and will be sent next week.

Heh... I don't think so. If you already know that this will cause a
regression on Tegra210 you need to rework this. Adding regressions
accidentally is already bad enough, but doing so knowingly is a big
no-no.

Thierry

--IAS/W3g8cdl95ybc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTl5SYACgkQ3SOs138+
s6EwYQ//VVWmKlM3nCvwREWbc3h0UKnP8JjfMzlZbQKwxb+J6cvveoJucfpqOWwD
evXlb+yvOl3V0PvLGuI+WCX1FJbG61OKaJM5IXhKORcn9UnGGECdZwAVZoTlR1Sj
37eHvQMHze4N8cWtOwl+A8DT6vnMMGv746ykHlV1K2VfLHtF4FzL2sSt3KbrW9wb
MSoN9pzyASkMksONfoqdLf+Lb5Ak1ilwUxB40b7EdJ/y6ONgaGmxU48HcQklps9x
uAGNUUMzDHwbBqoM1ZnyW2TBvgDzACVj7ip4f77uxFU+7EQDRNu946ZtUFvysaiN
mHq/JQzjCRD1/EdmdiyDqLB7Cjtj9J0jrH40n1pGX1zXT0ShxmjiEYXiuK3rGm6Z
d8D2ul5szLIS4MO0zSt3p9CsIUL4zoA5Oe2HyfnCdBWPWK1dKuGc4b+HBsbe9997
B1mJekjPDHgu6jZrDZ1sUa6n9dttFXxLhub8u+vO0ktgH+n6WKNFsxY8391zVBg/
p75h1w9Wrde1/5jmGwxSda4i2qh1lwqNG9XUURlmgsfraUvbW7o0vE4v5lrI48Zj
MzsNiXbqCYBn83ruV+eh1JlEBTAFDn4D0oCqnBmfQA5XVecSPJtueizOjJjRTVEe
MU6IKI/egM2do6W4kJzWHkdlaJzWujEiRzHRBQ4GbMpSG7PBNZA=
=TCOn
-----END PGP SIGNATURE-----

--IAS/W3g8cdl95ybc--
