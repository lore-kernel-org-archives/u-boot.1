Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEF1C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FDFB87CA3;
	Wed,  7 Feb 2024 16:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BLTQhb9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429DD87C8F; Wed,  7 Feb 2024 16:44:50 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65AB87B05
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-783ef8ae70aso46747985a.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320686; x=1707925486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YIqcfodrNWQWOsIMgJrqF+SM2u2Pj8LPg58glXbfcO0=;
 b=BLTQhb9qCCqXCBcEHZc3haI2k2+xv3SJKIu1w2XehH3keAWIB3Ls356sIZOPLhFyZf
 6vO1KO0rR1mx4dlBBL7RLGFOdzSLkYD0o2xh9QiCKyGNL6CGg7ZO1K3DrJzsi3wLvt6U
 /nk5g8J4ExErxpGe0z79NFfdLpeotbVXxRyhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320686; x=1707925486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIqcfodrNWQWOsIMgJrqF+SM2u2Pj8LPg58glXbfcO0=;
 b=cpbRIg09i1FPGEVRbLAaA3UspHQCgeo4/u3xEaWAflzLYKHh5Ru+ypo1m3lgd0MY2F
 85Aov3ybM8CpthvO5C5tf8APwqEB+SNnU6lqCzqY8RalxcMfa4wB9HPT9JSS0+Yl73Va
 mWQ8ytA8Ccy3E4RwQvb4KRVKB9R7uF/DfwPr2AN+ocRN+Opp5P8y1iKCox5oodx7lHxH
 sERl41Md73V9H5IBmP+AwkFn/vT1Lgg1NuRJj5vmNZorHqUbBPfXhu4F4UbnG+3LH99h
 paMZdwwPsHN+KkhQwttAiVw9+ptRdloyDIEBJDrv5oWrzirmesPGJbRh8t+aLnjcjwkM
 8QdA==
X-Gm-Message-State: AOJu0Yw1+DIEjRu4LGA18b+wgYSbdcXz+6yuV8e4V0w4EUJxg68SdG8M
 ejMB8fn5eonwHudYuu0bwldgyKtpMi3ED6GfCPqrWq90F9lrqgRYbNvPs8sKBrsKRO7ahB68CHf
 5
X-Google-Smtp-Source: AGHT+IFWn7EkecE0aQ92n/t88ehUPlxXO6C6flNwROGW11eZOx3eHhlmg7avyZ/MX/43FQXkMBdcYQ==
X-Received: by 2002:a05:620a:2e2:b0:785:8c58:e336 with SMTP id
 a2-20020a05620a02e200b007858c58e336mr5472652qko.54.1707320686605; 
 Wed, 07 Feb 2024 07:44:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c7-20020a37e107000000b00783f77b968fsm615586qkm.109.2024.02.07.07.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:44:46 -0800 (PST)
Date: Wed, 7 Feb 2024 10:44:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240207
Message-ID: <20240207154444.GY1152441@bill-the-cat>
References: <20240207080255.2154861-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XbfDqTu5aSSShACp"
Content-Disposition: inline
In-Reply-To: <20240207080255.2154861-1-kever.yang@rock-chips.com>
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


--XbfDqTu5aSSShACp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 04:02:55PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add board: rv1126 Sonoff iHost board
> - rv1126 ddr4 support;
> - Enable BOOTSTD_FULL for RK3399 and RK3588;
> - rk3036 spl stack addr fix;
> - dts sync from linux v6.8-rc1 for rk356x, rk3588, rv1126;
> - Enable eMMC HS200 mode by default for rk3568 and rk3588;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/19556
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 819abd0a1eaff9a921f5b917e152b85dab302e=
33:
>=20
>   Merge tag 'smbios-2024-04-rc2' of https://source.denx.de/u-boot/custodi=
ans/u-boot-efi (2024-02-03 09:11:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240207
>=20
> for you to fetch changes up to b8f1f60c23c9b3edb70159c4e2b1be232a008ee3:
>=20
>   arm: dts: rockpro64: Add RockPro64 smbios (2024-02-07 10:49:13 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--XbfDqTu5aSSShACp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpWkACgkQFHw5/5Y0
tywr8gwAmSmrea6aY6ElnF38SjJtdt9BSmlLrLswCZL5N9fztm5jbFrHVu7mBV+T
BGcYr/tDWfvkMkOWghXbh0xP44uNXRdp0Jv0wHNgJ2tEf/dl+6pOYRUM1nRq2O2l
+wnfeRAl9Ge0fjvNQO4R3DKi+zaCiv1STsv2slDsLGzkiBcvxEXEIjAGwv/7UqTR
PMMHMfSdMplQZnNGjHX1CSxOYhcC1qAIQcBFJ6jU4Q4TzO9BbPjVhnCMRANSHf+d
yxpB6JPjXweUKtNR/weymEZYb9IrG6Oquw9bG9PQ3hbEIqvU85fmWU+Iphb+OWie
qgZLOtK7FY5SY49r/+MYTDOhiCIWHcbIW/jvHdt0AD58gpK9nZtnIlVILnJEzSwJ
nTDOO3et/2hYlkdMZW9wGdoO4TxHnkJPGkQql07MW6KVPJN1ZsqzXOgl1Sww/Zc5
U36idEEeYCsBPVYhtDi3hVvdkDtJO5IWUpGGQT8LwZDrmCkTW2y63Db6UEOPgvey
N5gNtvHN
=K/cR
-----END PGP SIGNATURE-----

--XbfDqTu5aSSShACp--
