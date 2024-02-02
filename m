Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F26BC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 17:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962AA87D13;
	Fri,  2 Feb 2024 18:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XGmZe33O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA7F87C3D; Fri,  2 Feb 2024 18:16:06 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951BB87D4D
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 18:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6818a9fe3d4so12324386d6.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706894161; x=1707498961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdJzThSy2XmZDJ/rhyXpEH+hmmaNE9j13N3OXHcLgT0=;
 b=XGmZe33O+CiTxmG3yYs9H+ms8P4vr/8tUDHjoLtaWrGGHKhNB5x/qPGXr9rl3p89UF
 9ZDxgXCF8Uz+UugRZtfuEkiFoCLQi5DqrFfvSJkEVpbfT++11iP856AlZB6M4Oyy2kLe
 SLNowwPmg2/JAKzErvlLlJP6+Tuc10wdNlYZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706894161; x=1707498961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdJzThSy2XmZDJ/rhyXpEH+hmmaNE9j13N3OXHcLgT0=;
 b=dw1Tf39Yv/MtyLd9jkl3ZojZYEUJDpC0scWxrUVjvcRUHUd61yIpkRxzXV2BhDCy0Y
 ld2YqB9CGt9qyF8fD8HYgiYj+RDBow/acwNcY4G1BPZJ5iu8MdcGB3YhHgoS0YbSbvG7
 YmbBOTmjCIKtxfu7XZEcFGRX9hTRV3rXtQgX2WyRnGeEjsC96FzaXl71fRFGesaGVyI2
 Vx4uFE6AovWgakvKbQul+NszxTUVUN6GTu1iX3pJQW//b7n9N/9CjwqqFxlMzW3uZzSA
 Ts7kbHHZfvfo+SbeIWzKjKTUgLvLgN8pDzSzo6cPQInb4XRFVcLdu3FYW4/cgglEQUJt
 vqSw==
X-Gm-Message-State: AOJu0YwkufRS4qftw+W/Abr2IHvshTzxsGRI8p6mgiiVS7bBhipcpU5K
 oNnEGDyocohByYhQSR8A/KrabHeT8Uc8bvtLiq4HgqqK3jublHhBUTCGniNznsg=
X-Google-Smtp-Source: AGHT+IEnVOlQ1ZP9670aT5vWaSAWH+o66hpTCK9Dc2nPXY/nDHSRAyJpWypr01GvmtCeDzGpRUTGdw==
X-Received: by 2002:ad4:5bcf:0:b0:68c:6b70:ff4a with SMTP id
 t15-20020ad45bcf000000b0068c6b70ff4amr9864023qvt.37.1706894161239; 
 Fri, 02 Feb 2024 09:16:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXJYFHTY+lyWKCpgYcafzdCcE9EDSWdfyYUjSZzjR496nio9wR/yL8nfeAEOQASnm9hY+0RYfmnz/Lh2gM9vB4s3LvvBcF3HNMT9KQ80qfFPa8vapxiBFZAO2XxXU/yW3cVOs1Ud0UXSaE=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 mz9-20020a0562142d0900b0068c4b6000ccsm973635qvb.121.2024.02.02.09.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 09:16:00 -0800 (PST)
Date: Fri, 2 Feb 2024 12:15:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 2/3] mx6sabresd: Convert to watchdog driver model
Message-ID: <20240202171558.GE1152441@bill-the-cat>
References: <20240202160405.4126192-1-festevam@gmail.com>
 <20240202160405.4126192-2-festevam@gmail.com>
 <20240202160702.GD1152441@bill-the-cat>
 <CAOMZO5CupvpiGeQDSNve1xho5s7=CPiYWezs4O=fjmZVo_vTtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="86Xi7dx7FPlh1mm2"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CupvpiGeQDSNve1xho5s7=CPiYWezs4O=fjmZVo_vTtg@mail.gmail.com>
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


--86Xi7dx7FPlh1mm2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:17:06PM -0300, Fabio Estevam wrote:
> On Fri, Feb 2, 2024 at 1:07=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > Can all of this be upstreamed as well?
>=20
> I can try it, but that would go into kernel 6.9 in the best case.
>=20
> For now, let's keep it in u-boot.dtsi.

Yes, sorry, I'm not saying don't do this here, but can you please submit
it so that long term this can be converted to OF_UPSTREAM and also not
have a -u-boot.dtsi potentially.

--=20
Tom

--86Xi7dx7FPlh1mm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9I0sACgkQFHw5/5Y0
tyzWhgv/fnHzDaeJPeTDNI5LkypEXZAF29mjLIyjVCPFxmW0+i9Q9vbMprZNH9TE
Kl9gggX7mIQ6N4ZF54UAocFeIlM5kIVBD0vHGdqC61lEDit0U6fYD5VqvuQHiXbM
2l6OJfb86MIHiovCszsPVCGy9iEBh1Q7sKnsryCIKeUhoj3l1oxeVrZ/Ii1Ci+MP
3WyiGIv3/l2qwZxSbUYE7ZHgpSBGzSq9F/ZQQoGSAVnilyC1aVcydlmc8IcMnxY+
lRZebgdZj9XOj3iuSlHb1OvK08YQJvMdnuXOnodXq6m6DG7SXbTWi13mGMXr9DfA
R5dKvwCBQtPQrOCPvKXpG7X4YQlgF2i1VcVIud72KSuyWiSLQauRKl2ZDJQrrZsX
OFXtlZTpEq1Z7w3MvH2jxFPBNwtsUl+e3h3KNfSp0+eT1IqH0jUqLYXhj+Ij9hSJ
uCLcfcVZXqOKFjV7lc6WjbvedTXDJFtVXfmlzc+GdOEWB9Z85zzoxv/onc7PjDnX
l98+hQHW
=Lsge
-----END PGP SIGNATURE-----

--86Xi7dx7FPlh1mm2--
