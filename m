Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D2AC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107A0879CC;
	Fri, 12 Jan 2024 14:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IlcCO2jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E262286E05; Fri, 12 Jan 2024 14:46:01 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03C38793B
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbf2740355fso2295509276.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067156; x=1705671956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5GzexHJoSDqYJWNN0XavbKpjORsPy/TlCfEvaBqKzw8=;
 b=IlcCO2jQiLmnt8isWbh8wKDkcgr2xwEvnrqPEvqGtv73BivDKSNI0CaXzJJwYpWPQy
 Sy6ycPJGbGga2l5cNzUW3sJVpzMGzndp2UuXFlgdp9lUWxMgG+LT7xFGzHA5MheSpywR
 +/F9SRsW+4aKvyQve4wvt/O67e/icpEq3O36Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067156; x=1705671956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GzexHJoSDqYJWNN0XavbKpjORsPy/TlCfEvaBqKzw8=;
 b=daTi6Z6LmlFsUQy0MPyxOc4fKV0WFROcBmejwMbqZwWZIQsVD2DDQGNyDKqEJzz0a9
 DPx39XLm42K0C8BNlPxGQDiuKtUALbgIQvZl0ryhUJnPkjvK5ICRJP+WMM31vj5Uc+K6
 F+a3gI3jqd9OB99jSktUXlAPo9e7nVydhizIJ2lFAl4Sn3pz2YM6gvuqTLHDqdFsrLzl
 UQ0EajfpE+F+ThS/oLmCkyuYhqhAwO/KHwpdeYpVuB7yToQ7BAjE9EI7UrjMIhDBTDip
 jhC2uVQxu6iA3tJQaJ3jANVH/q7fyf92mM1C+/KFKvsDtllhAnWiHHcpghysDB8RFiET
 tDVQ==
X-Gm-Message-State: AOJu0Yyk9m3Nr8IYdkKXsiAC2otOo/bk157xG5nxq44CBeH1sFuSOMBz
 aniNznnO9nk/abWgYdk4M0y13bL8NT8h9w==
X-Google-Smtp-Source: AGHT+IEpqw+nE3dx5NBgi17sUw2aNqbf8rxFgNhD+W3qBMpUh6btE9FrOH8pXTlHkaLi5FIBB4SAIg==
X-Received: by 2002:a05:6902:2847:b0:dbd:c554:e76c with SMTP id
 ee7-20020a056902284700b00dbdc554e76cmr503204ybb.0.1705067156509; 
 Fri, 12 Jan 2024 05:45:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 e11-20020a056902034b00b00dbd15c3b753sm1188938ybs.46.2024.01.12.05.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:45:55 -0800 (PST)
Date: Fri, 12 Jan 2024 08:45:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Marek Vasut <marex@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RESEND 1/2] dt-bindings: phy-mtk-tphy: add properties for
 phy tuning
Message-ID: <20240112134554.GP1610741@bill-the-cat>
References: <20231213064134.12727-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ANGnryvoY3LstILt"
Content-Disposition: inline
In-Reply-To: <20231213064134.12727-1-chunfeng.yun@mediatek.com>
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


--ANGnryvoY3LstILt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 02:41:33PM +0800, Chunfeng Yun wrote:

> Add properties to improve eye diagram which sometimes need adjust
> some parameters of u2phy;
> Add a property to tune disconnect threshold;
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ANGnryvoY3LstILt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQosACgkQFHw5/5Y0
tywmmAv/f9msBjP6YWqWp1q3IK0btiUtMtEfBF1lRWxbU4l8fbO/aHNYsgIXYWEc
MNLrrJbXruLBzKoT8B5qwCoKwtTt9yse+XFgmE/R8nNHc6YLytRb7mAtkKR6SQma
fLQX/qLYxm1orA1TsLFHClsOZl8ij7EYaCayZWBW6+C+zCWlbn73QH0OIRrOh1OI
D4I4IGliGPkjDgi+BCi9M6wUbjX4JPBSqzgelXQ/YfYeat3bkpXBYZkS2SeOnxcC
ihzKmd2ZULshMBvITjE6Wj/fc7latC2KFl2EMx14Eo6zcQ75i+O3mnjoCx98HtRs
uTGi63p8h5XRc7ap9Zi8eQhg5nOs9VR2XeORyQAgVilX/OUw1rQ7GkQKez/TxdEm
FqGGKY8LUonWDZH6l+JJJIptvwWM5QvVvSHdk+nuNWeAQVQNSW+rTcTjIVG4suEp
+bYG7d/s3ncQ1fnU++mFP4D7FPN6fmFMa9LuwFilyxqc6rCg8E/4FIHXOGfke0Px
Dm7f6PI2
=Rq99
-----END PGP SIGNATURE-----

--ANGnryvoY3LstILt--
