Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6DD6101A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 14:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C651B83FA3;
	Thu, 29 Jan 2026 15:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HVLaPDhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A439083FBD; Thu, 29 Jan 2026 15:59:14 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8348483EF9
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 15:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45c962424daso425215b6e.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769698751; x=1770303551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7JYB3NeNgM7/FJnc09gQYlTmEqn2oJLiYsP3o7XbmWI=;
 b=HVLaPDhBajtVPqWvQyZO4WUB6HP75G7Vt1R6qfm9ftbR7crSr3GmozZCSqBmhZCcS+
 bW2M6llScUI34bx7v8mbmXGH1B9xo8tJ+eMnHvYGwqiISbN4rS59Qj/mkfZ2BhruEtCG
 It5CiSTdTBRyHtC4QY+dkaLExHZP/763614DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698751; x=1770303551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JYB3NeNgM7/FJnc09gQYlTmEqn2oJLiYsP3o7XbmWI=;
 b=uymqjACjXz4LWSw51rKcEN4ztVvaedo4nDtx6tBh0WNIeJ6UVvLzS3RhMIt1mfcxJh
 Qg57C4SzNfRhqPiGwp213K9RoUDYzm+8dqQUT3bRxPi8JusfvUHYKQiJJyf8sYXcTUXD
 hAbo/aJY8/+1SRLXv/GpqNDDmVFtlagW88VNUGzmbFYDEm9HjaRUn1gW7z9pBFiMGW+T
 Vaf3Ij4nB0/ZpQM8IwIeafkHF/Fx6nRmIIE1Nu26Ymqnwekjh0Cii+7u6pv0JYLyP9B3
 DdTJmt7B0uoggAWZO3/MddUKZTnDzTa4pQk2zn1wbXXS9aFg86Bt0VvMQqe3R0duxROw
 rJgg==
X-Gm-Message-State: AOJu0YyyZRVfJiaJtXw9uB3ljbZY7ZebS0l8B2Yvenqzpyc5gQpDepC8
 1dykF065FIyILRyxKTJ9f0x13H+qD0U09950dtHNFa8pVzMAERofxppgJafei/D2N2Ss/DaULZV
 VvCRHiUw=
X-Gm-Gg: AZuq6aKifmgXivQeg3VkYJSpziZFbMZNKblyzFc7DrlKBRpuC01z4sRDOJ0rhMWUyQO
 YPrJCpg7A7T03+7DL8lQXQHjK+A3SVDx62AB7qgp7yK3hNq+dIXNgeWbjr6LSxbj0jYKcQT7TLC
 mZcpafVtAJsvJwFFUChiT2PLbv1Gf5JeOlrBh2n6TVqsZ5qTHQP4kI3GorkbA93aNyTmn48KkU5
 oM38BdNLculkXVg/TcdUaLiEmmjqRh8CGcYbihvZ2RBnneXpJWxerH+A0HfwTBr1ZSWehSYf01S
 kZTvkohDnqn6V9st31npWNeWyH/11mRqfG+pJazlaRCG7eH9P8bS/tVh+LfCwGCn58KPNFMQBbG
 fnTo81Vf3DI0vkkv7dE41d/5/TYxRnRYVfM//8SVxXgtTUobicEMPu5dwacLbXHp7yW6bUqY/Xt
 bOGdCd5NWzGS30dVVdn1lh7YfItbN3R5azSO2UcNLbwCc3NI/uQ/Uave7MjLjb+8wMOuxuaxPa2
 9PAHoiuwgcibAQrJV4+ywRv2C43Ss6J1Xk5rBo=
X-Received: by 2002:a05:6808:1a26:b0:45c:944e:a463 with SMTP id
 5614622812f47-45efc4846f6mr5679833b6e.7.1769698751206; 
 Thu, 29 Jan 2026 06:59:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08e23c09sm3176671b6e.9.2026.01.29.06.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 06:59:10 -0800 (PST)
Date: Thu, 29 Jan 2026 08:59:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Mateus Lima <mateuslima.ti@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Message-ID: <20260129145908.GS3416603@bill-the-cat>
References: <20260128192617.1724570-1-trini@konsulko.com>
 <CAP8WwTETA8ZXSC19bhvtTRLP2t-nvcqa+ER3HrYpshQDr05iAA@mail.gmail.com>
 <20260128202105.GQ3416603@bill-the-cat>
 <CAP8WwTE-q1S5S_QYja8OnjWvS_hhpdiMW274vxKhDrEBUuvh5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tQHpH3Pohbfkc3wa"
Content-Disposition: inline
In-Reply-To: <CAP8WwTE-q1S5S_QYja8OnjWvS_hhpdiMW274vxKhDrEBUuvh5w@mail.gmail.com>
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


--tQHpH3Pohbfkc3wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 12:19:34AM -0300, Mateus Lima wrote:

> I understand, Tom, I'm just asking Peng Fan if this won't break his build,
> as he mentioned earlier.
>=20
> And please, Tom and Peng Fan, forgive me if I made any mistakes in the
> patch submission procedure, it's my first contribution to the project and=
 I
> truly admire you for maintaining such a large project.
>=20
> I hope to learn from you and contribute more to the community.

Yes, thank you for the contribution. I'm really just lamenting that the
error here is one that we can't catch in CI at this point in time.

--=20
Tom

--tQHpH3Pohbfkc3wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt1vAAKCRAr4qD1Cr/k
CgodAP0cBg6o30vpKBGhoEcDxHkP2WKeL+teVo4/u62B8CwYYAD9H4RkVz2BYYZh
uMNFZHY6rrpXt7NGH+hqRizdg9Ejlw8=
=VCAh
-----END PGP SIGNATURE-----

--tQHpH3Pohbfkc3wa--
