Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837FBD3E2BB
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F388907E;
	Mon, 28 Oct 2024 20:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MqRLLAKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9D38904E; Mon, 28 Oct 2024 20:33:11 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3C4890CE
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b155da5b0cso326889285a.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730143988; x=1730748788; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9GQ/SoqLQ4HwEciTS9BB4GCxYzLvCp5PcYtJXhTzGQ=;
 b=MqRLLAKw/s2UBOVb273wtGCX7x2QK/pZgQPHbAflhjQFgSfAE82lfqHOQl4VBhiEac
 REys4PUfuLC09fGf1uJButDvkAzKG8H6I2Prm8RNV8I8PM2GoctYYb5IN2YxSJwqgBuw
 X38oNo+2UtUuOcJ2YXhnd+6Z6bkEIV/+pZVXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143988; x=1730748788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9GQ/SoqLQ4HwEciTS9BB4GCxYzLvCp5PcYtJXhTzGQ=;
 b=ZjsBfREb5N5+vTqWGn/XVWee85LkYuS6eqG44OniRpSnFvzsz0zopA4c7cEOhi/J9G
 q0WxwadNMpQp4JhzAnBYuGcOQ0LJa5M/XsN01aqY268U+r8ORSdmV8XtJ+OSLXs1WJy4
 RBKYS/cD2/GFfuU5qiIgveaXpfXGy7g/3kq/Gj5shLcH2xk3R7JzaSmifO2UZQRyciRm
 797u6azXg/Z5jtcnVbIkYezi8ciUcR+dGVbSv96nzhiReicFPXTTlcywFLWdzQoPg9yJ
 euUoz8ARMMhCtH3p3qqEa0igBgpoJJQ35FZvJRn1u2YboADNZ/7r8cPd1ReAyPGs//yn
 HpLg==
X-Gm-Message-State: AOJu0YwPXc9OfYnvLTTZejGW2h4uk6ycuBNcj6Fho/PcdFnH9pzLakPi
 Zr1XiytMokIgVX+A6tpwC+S/0nAWnaLLG0yfKSj0fm/bqMOI6iIaZyyDqaFHx6Ct1pQcC9d6d0H
 XRls=
X-Google-Smtp-Source: AGHT+IE3VIf6kY03uQWzllH9hTD2iqcTF5gND/+tNdAvbsOh9/ByBih8Jgq52MKkKrdZ//JLHpvYKw==
X-Received: by 2002:a05:620a:440a:b0:7b1:5549:4303 with SMTP id
 af79cd13be357-7b193f076edmr1492479085a.36.1730143987771; 
 Mon, 28 Oct 2024 12:33:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d27b955sm350091485a.13.2024.10.28.12.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 12:33:07 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:33:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20241028193304.GR4959@bill-the-cat>
References: <Zx-CZxLR6dNGASwK@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NOe7mpLu4lGiDpvI"
Content-Disposition: inline
In-Reply-To: <Zx-CZxLR6dNGASwK@swlinux02>
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


--NOe7mpLu4lGiDpvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 08:24:07PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 3df6145db0ed3430a2af089db5a82372bea3f4=
d5:
>=20
>   x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE (2024-10-27 20:11:36 -=
0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 9e859849e2caa17d730bc4507fd6ef3c7959d3b4:
>=20
>   riscv: cache: Add CBO instructions (2024-10-28 18:56:54 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/23051

Applied to u-boot/master, thanks!

--=20
Tom

--NOe7mpLu4lGiDpvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcf5uwACgkQFHw5/5Y0
tyxvMgv9Ebm64OmRUz5Cmo7VtpaQa4Pl1MiNx+fm08tiYY65hO01wZkvURQTFVZH
nCZAAFtE03PSpjq0ziC2HCsOOZ9u69nM6TPHSjvfKTpBf3ucLWV8VUMb68qJjGfm
gCCuyBAwmjfNGKVDKmO/Jk93KyupkVAJBzJawy4AmJO2s17KsXf8Wb90jW8Rol31
IIYxS8o4UPibAuVmbG0a3+F8hOyRmMBj9St6DBg4JH7MrccYP4lOA5adKsOYol2T
MRlQxUDXRqvaCyN5+tT82jPglIDByauZtTaW5hF1jq/Df2scEMClpmUwpCfSIhwS
sUs1TK3yV+bUPk1FvXdLNTdU+JFtfWTsSYRrl+ImYCx45/FkchVCh45DVE6Eq+cf
APxrNQ3lCV8UNNwpamIdTGu6H5+dv8nM8u78bsQZ2Ccab9E6bbbG1ZXnis907cPG
bQ3vkMX3911P1sK4WBeC8gEFlcCRVsAxdoW0+3HnojoGHQijKDvdsk5nbQM9nG/n
04NTwrRz
=LBtV
-----END PGP SIGNATURE-----

--NOe7mpLu4lGiDpvI--
