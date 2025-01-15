Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5255E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62DBB806DD;
	Wed, 15 Jan 2025 02:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iO+nM+65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48D3806EB; Wed, 15 Jan 2025 02:13:24 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3605A806D6
 for <U-Boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so901677185a.2
 for <U-Boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903601; x=1737508401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lr/ISJsnxJ19CsYyu59HVWSGAvvAo6FPmyKu5Ofxfow=;
 b=iO+nM+65LaHOZzET/XT0GUSsNMYvUyVgl9qUT4VLH4Rhdz1BO//Grt7o4+oS1UxWht
 slGQ84bOYMsU7wxMXJGN+viaxCyJ0JEcW3blndZ7aYAyI+d0w+VH7INQdvjpOwaEKYUR
 Hj/6lCsgvp/SsQNa6TRxDOT0nWXDQxsgxF138=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903601; x=1737508401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lr/ISJsnxJ19CsYyu59HVWSGAvvAo6FPmyKu5Ofxfow=;
 b=fWTwX6WHbeCEiLMdLm2o4Sa8AFOElRq6HUVISOumgK37xxiGj2BcOo3rUfwU+hQQjV
 8d1qVdebwsuggZOOa0P9imgSj0s+h3dJEgRKb4NkpU3hnGlD+Z6bgsrfZu9BYxoY4jXs
 P6c4/bSscxGif0iO64Q5FUbYkG/Z7wqgfv8EXzVu5hEWDKuN0l43g6YzRWJGEDXHVsPt
 iS0qE2z2i0IzwyyeeKQJ0TevZ+KPLvMelEcqFDP4zNaB+3XQMDtl5Xj8q/4fvlhIKRL4
 kl/fqxVsCuDofP/qexAK3FmCzYsXufZp9tr2ub5VWbZ2OM80V2+egOQ/YeoFp+xtS1Op
 +VBg==
X-Gm-Message-State: AOJu0YyWKdvURbwSIn1jEUwhUEwZ/QKM9R7MiNsncX6j5rHVxMYoMkH9
 uDGbgAi+7tHcuHk2hJUxI3Vlw3ZfPDA1sQdO9E1sAQv9IETGTK+/bcFSdfMygp0=
X-Gm-Gg: ASbGncsTHPxBmlfbmN/YrGO3bonHtGLMPYsWmlSNUkZOIysYOzr1QVeUqG/Ywkrc7TP
 ccFTcwdoY7y0eAXWR6WwyIiYXfA9qI/ggBHi3zlnFQL0cXqqq87QAlEJ53OC1ZfUKgDADK6criY
 8syAvzDSVTPfr2U2WHIADFYtrzC8DTmN774tPuV3EMU2IpqYnhpwRDznrfqnvaSeohXYn32giuN
 DsNfIyTveatRwuelJMaZJfcHfK7f7/1CFr5H68LZ+ErmsTRXqrW+g==
X-Google-Smtp-Source: AGHT+IF5LvenyO8N+xrwyV7YFSNthDxYay/db0+6q+VtZHt2jYT1PT8pyMaSfqYcMP6bj7+HYZVO/Q==
X-Received: by 2002:a05:620a:479a:b0:7a9:d14f:2374 with SMTP id
 af79cd13be357-7bcea545144mr2424823685a.44.1736903601122; 
 Tue, 14 Jan 2025 17:13:21 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3281612sm666588385a.69.2025.01.14.17.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:19 -0800 (PST)
Date: Tue, 14 Jan 2025 19:13:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>, s-ramamoorthy@ti.com,
 u-kumar1@ti.com
Subject: Re: [GIT PULL] Please pull u-boot-pmic master
Message-ID: <20250115011316.GP3476@bill-the-cat>
References: <CGME20250114015324epcas1p4c2c83151f7110658531d7ac9c5222630@epcas1p4.samsung.com>
 <302404b9-bd4a-4797-9b50-012b68ecf170@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xQMBEFzSoBxCbiA2"
Content-Disposition: inline
In-Reply-To: <302404b9-bd4a-4797-9b50-012b68ecf170@samsung.com>
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


--xQMBEFzSoBxCbiA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:53:23AM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
>=20
> Please pull u-boot-pmic master into u-boot master branch.
> If there is any problem, let me know, plz. Thanks!
>=20
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/24175
>=20
> The following changes since commit 6a0db9ee030f634731b792d864fc7a9df6cc6b=
80:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-usb (2025-01-13 08:25:00 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-pmic.git master
>=20
> for you to fetch changes up to b9fe3ec8a235e2f4cb1091dd4b24150313944ccf:
>=20
>   power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable (2025-01-14 07:=
44:51 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xQMBEFzSoBxCbiA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHC6UACgkQFHw5/5Y0
tyzYswv8CfEuXy8IgrlIUDrMANFbDcRq/LSmbWgotMYMLnOsG0//wRskb0VUC2Yq
DoZX8JC1acdiSoey0M1j5d0880ZXAgPlhvjjGJEcFLNa42QvtKW44A9OmI9GFhXP
THhJC5796jw7VTs2WC1EtardCtewdUAwpgczvwmpQbCi4b8SOiyOyJvTtlqvTUkP
4vA7eslDvy8IhLJ+EoyEvPNJm3xlhAS6AneS6asfKXSvrtIopPou+TGEMy1sHf95
VCtLeuLPYtvNzpll97rVmUIuseyhw8IzkhELmrHCp5uMmj33OwDFHpqwPlDBiZZB
vJ+XDbHP74C0UZghZxGSpLEWIlxFXQoHldp6VzXjQJ5Atl1jtCVTW/7bdfDrXhWv
BIX0lKHqME2WupOlJxu7D30apMwRvoNPRDrHOA1nuxf1paEsj/Ct/LeDQxsPYth8
8RiS7PJbjY+oOjYM2i7rTAMOpaFQC5pKIuSuzxZGkDwfOY2Eg+LdViH2PXk5+3Xk
D1QE1cTK
=yjKl
-----END PGP SIGNATURE-----

--xQMBEFzSoBxCbiA2--
