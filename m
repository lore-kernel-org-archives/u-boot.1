Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE98F364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C1A84221;
	Thu,  9 Apr 2026 20:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qPd4DX6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EF784099; Thu,  9 Apr 2026 18:34:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D338A83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6841e6a5e51so618572eaf.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775752457; x=1776357257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K+42YOtTpTsIwFY1t3y5cNhYPzsM9Hubl25gyCaPqYk=;
 b=qPd4DX6uSSKA+8jL0iR1mGzEkRUgKbO8eqgxbiB3udG0rm/mn8S0YoUj17LpGAgZcq
 JJdgOY1B7sr3O+8x4u0/Oui8J3ppTZSS74y5HJIyh+CZeWqPRcS76zPMTDSbAi2zvY+Z
 0neusWruElLb/7W5OimkQ8Lbq/Xudv8WZuqJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752457; x=1776357257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+42YOtTpTsIwFY1t3y5cNhYPzsM9Hubl25gyCaPqYk=;
 b=joHOk9X5RrzPj3V1swSzJji5rRl6dqnZAv5K8K2NIBn9fJbd0egx0cAqn/Vo7aoNJH
 jc5IcLNZldMb+bRfJgRccnRJSFSxWkkcU0iXthALGTuQcYNl8O18shXClrSYkbiUjwU1
 xT7lvdoEqbl0urb5AzYO62oE16QGR/OpLxiUOro8a1Yjtr35z4t3zHmz7roAgXwioXTK
 QdDNJD9DsOs75Ml8OjtjPAAnGIVi3JTZcYwaqbRCvtQ/xH+H3Ok0Wg8fjIhfnELZgpkX
 fWfAsC3uQGpEZ8QIGSNnjcqxs/0cNmGqac3HrPD9Hsg8oquOzd8jD9pMCPeG7rKfk3UK
 fdfA==
X-Gm-Message-State: AOJu0YxSNa15zmQJX4gAF7slBXX+ITnHrqJWMmdz2OB/Afnz8Hq3jFJ0
 e/BGQpwGSH5AzWpvSivHCM2DhSrhojo7+PnznwbG/Xrfe9dfjPfNsLW/0b/K4R8tuXXw4aaWT4O
 dwg6zg0U=
X-Gm-Gg: AeBDievnoCWxkCt2qNQzk4uG+1siHHZHR444GqvXuwKJRB1EyPC5HyBjTqewcoIByaH
 fXfAKQldrth32ygLySO0pL3LdK0x5BNcNeANVXmq/rarKeGRhe9UTBT7CBuRGsPY4xEDtgIvolj
 KVVTtQ2ficAh9TCG5adhLubP6psVGIqSiSZT1K0agDdydUfVPjbVoZtZpmk8y9EpRy7t9FD8LN5
 En8ASW1JpmP/o5mxqI/5R7BA96+L4VVjD6mefeabYF7ykUozdF1FZh4KT6LnB/bHggPtCkKV0Ah
 qu/zZt3+TzYL1sceVMEDz2numRVx+xWOTsOxLXhXXVgiRdPajDqgLvP9caxN3p4oI102i44wpmB
 YjprwS9VasWtpP3BF2U6c8l1ZpVEit8lixK1ipXGLw0S58wzPE8X15IxNFo5hStahRylpssq7cm
 QgGKetJV72trpF8FcbXv6stPehHHLdQhemSSEQjB7Wa0BPpbx74KZfr9i+6ZH2zCk7iePPa//kL
 at+HD2oeaB4Nb0aC2gGB/BRznB8ialoLPARwHsRZCUPsmy56ww=
X-Received: by 2002:a05:6820:61d:b0:67e:2ff7:2a6e with SMTP id
 006d021491bc7-68a611a257dmr2242132eaf.18.1775752457512; 
 Thu, 09 Apr 2026 09:34:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bcacc9925sm55854eaf.9.2026.04.09.09.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:34:16 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:34:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Cisneros <jorge.cisneros@hpe.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 8/9] configs: Add gsc_defconfig for HPE GSC SoC
Message-ID: <20260409163413.GR41863@bill-the-cat>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
 <20260408-hpe-gsc-upstream-v1-8-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g9/hgAuN3FtyyNbh"
Content-Disposition: inline
In-Reply-To: <20260408-hpe-gsc-upstream-v1-8-2be1fb7cbbfc@hpe.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:34 +0200
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


--g9/hgAuN3FtyyNbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:24:20PM +0000, Jorge Cisneros wrote:

> Add default configuration for the HPE GSC (Gen Server Controller)
> board. This is an ARM64 BMC SoC used in HPE Gen12 ProLiant and
> Synergy servers.
>=20
> Key features enabled:
> - ARMv8 spin-table multicore with GICv3
> - FIT image boot from SPI flash
> - GXP timer, I2C, and SPI drivers (shared IP blocks)
> - Cadence MACB GEM Ethernet with Marvell PHY
> - GSC watchdog and memory-mapped EEPROM
> - FDT fixups for I3C hub and VPD provisioning
>=20
> Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
> ---
>  configs/gsc_defconfig | 88 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 88 insertions(+)

This should be part of the patch that adds the platform itself.

--=20
Tom

--g9/hgAuN3FtyyNbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfVBQAKCRAr4qD1Cr/k
CibuAP90Ew/+qd0IUXmPykgIBJail00liMSbn/sRPnYicZ02VAEAhwPnxUBjIgsF
dn3YN8YFxfhEFcBxXlkKoosEv7lBdww=
=2mQ2
-----END PGP SIGNATURE-----

--g9/hgAuN3FtyyNbh--
