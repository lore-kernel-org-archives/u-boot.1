Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDF8CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F19384948;
	Thu,  4 Jun 2026 18:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W0hY3o9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C98E8495E; Thu,  4 Jun 2026 18:05:54 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DCA0848D8
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43d2c7b5a6aso839320fac.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780589151; x=1781193951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PHryWqC3UtoCb61qMJY+D+TEQV4l6GtxncoTGXQSJts=;
 b=W0hY3o9coKGfVW6/mKDF5tU3/BblgiIC5AEuXD8RPRPyBI4Oevqy/TJGJIPL2inN4Z
 Z3NzjeCRNLfWbBJB/fFy+5P3VzCPnPu/6pVDkOat1Y9Va0gojZJ43742ImCuXfL7FKxU
 LS/8VqdHSSN78tFBXmplYeazmK703B6hVk+YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589151; x=1781193951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHryWqC3UtoCb61qMJY+D+TEQV4l6GtxncoTGXQSJts=;
 b=nzMLoVpAvX6hEtYWeiyBbnUe0jMDTo/gzl/XxOkKHKqbe1n/62k9UnOHgtFWsArR3o
 +9NkEjVjQuA7IPV+Dx1CPCWiqUep2cRCzok0m79qq8S6kRX9U+W+9yzinBmO6LmaBjum
 ZdsU54sr2nhDHfHbAu8HWcu2M4E5DTU/QVFDB74CV77NZlWUbgrX8hy7ZTNBWPmxxMyD
 II9uLPCCr39dxDJtVNJ7GBmnIbqBBc7n1UyeKpFOzO+Qt51ukIDeTrlhc3/FV3jGQgEL
 aLZhQRs/wPu+TB4zWezqENp4iqtKstF6pH1SmD5tSOx9Vj2LruMricm/Yvs6ymWR6s5G
 iMsw==
X-Gm-Message-State: AOJu0YzysRRt+d2DU373fIyNtx4E0Q8Sn6oES6ZBb3BZ6/DhDUaKym29
 KPyouTKyh5eua8nf8rqjoP0279XiKWXtcYMyFebato2TeCw24J54412j4WPkmLICl84=
X-Gm-Gg: Acq92OFgNkTFMjogxyEyMZ8Bd0cJedv3DsXBrOA8OzPGDDG7lEWvvx84jF7gelfEEd/
 H0eI/6otAsMM4yC1jeMbIxKT8SM2Jyo5uefGkXmCixnnOWKwbSsCAB9a94M2U+c+wbzyTTzsI2g
 ZXP4I2kLH1pv55hCX0zzUxbachLAWsamvV4w9EQwtedhKZJZjThi0yaY1WE3zyRStjatd+WJ2l+
 XiXs//DBxGDzjNvcBlHc21JR4LJgPz0hL9bL6g2dfhCusYyGlmGtlNJ9z8mIVO0ozcTjk5AMwKN
 CrqnSr5Cj7kmcm7mVgLFBrHWdpiCWL6JNbWdXHCpNuM4ZwDfoLLUEf8THr1IwaY4rsuvUYkDgQK
 +CIRc+OyMDUlzDxGDwtwCSwndd43d0DdtcMvnw0IkZjE0UzfM3xTJteYfeEeVQue06w2Q8r7W9S
 B5dnqX4rI2WUZPQRkFpLkRE6dZrffXUB383pcqbob9elwW9mhYACP5gU+ZV5lJRhW2ILruwFzzl
 Ztxv7/Rl/vUocBILX3TkiB7XGsunjh4q14q8CDWhtJJqfvXoza9x9L/irbOZQ==
X-Received: by 2002:a05:6870:a447:b0:43c:fc47:d29 with SMTP id
 586e51a60fabf-440db431e68mr5408628fac.7.1780589151017; 
 Thu, 04 Jun 2026 09:05:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7b79ad4sm5779776fac.4.2026.06.04.09.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:05:50 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:05:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot
 on top of them
Message-ID: <20260604160547.GR627328@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9uWbugbPDdoSQ49t"
Content-Disposition: inline
In-Reply-To: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
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


--9uWbugbPDdoSQ49t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 07:31:05PM +0400, Alexey Charkov wrote:

> Add support for the Boot Loader Specification (BLS) type 1 boot entries,
> as generated by default by systemd's kernel-install when loader=3Dbls.
>=20
> Given that the format of BLS entries is pretty much the same as PXElinux,
> reuse the existing library for the parsing logic.
>=20
> BLS type 2 entries are out of scope, as they are effectively just EFI
> applications and should be booted as such.
>=20
> This implementation is also only allowing a single top-sorting entry to
> boot, as the standard boot infrastruture currently doesn't support
> multiple entries per partition-bootmeth tuple. I have a proposed extension
> to enable that and will post it separately as RFC - that enables the use
> of `bootflow menu` to select the kernel to boot without jumping through
> several menus with different behavior as is currently required with
> extlinux.conf.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

This is good to see, thanks for posting it. One concern I have is that
out of 1529 platforms, this would be enabled on 1392 of them. And the
size growth is around 1.5 kilobytes. Is there some smaller percentage of
platforms this should be "default y" for ? Or is the expectation that
something like Debian will be configuring for this moving forward, so
yes even something like PowerPC platforms be using this? Thanks!

--=20
Tom

--9uWbugbPDdoSQ49t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiGiVQAKCRAr4qD1Cr/k
CpNoAQCTK8CbxmifMXP9fMd1yweiUCmFhbXEqKKVcbeHDGmlkAEAnXdPzLu5gx1H
bHAb5g7suePNUYP8RIyQdu59PkoQtgM=
=rFxF
-----END PGP SIGNATURE-----

--9uWbugbPDdoSQ49t--
