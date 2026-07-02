Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632B1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 16:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7322884671;
	Thu,  2 Jul 2026 18:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dKoZpsSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4938F846A4; Thu,  2 Jul 2026 18:34:05 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2126284409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 18:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb34c17b96so1169501a34.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783010041; x=1783614841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cYPrrIT1JyrnBWvE8r+guJmgnuUNeOgh9fSUfYyPjr0=;
 b=dKoZpsSxP2YA64bLtdWy2bAILKaunjrUjiC/wzo8rY+FI3hDeviNSw+jj23rU1Bbtl
 ETL0yFSyZasYGeul3opcf22Ia9nzIsu4LQX51EyeoJ6xRP+6gIFNe+cslTOVQ0fkmUUM
 BOhARrDvFc0fb6X9ht/p80hxjUZu+HmLTsvQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010041; x=1783614841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYPrrIT1JyrnBWvE8r+guJmgnuUNeOgh9fSUfYyPjr0=;
 b=ObEGAhi0NO6AxkWTMagCmMlIG+LYKGdia0kAlj7YRW74r3LQwiJB+jnPDNdv7f6uRq
 gNRjRhukwlrhGC5N+dJ6HB1F5e+JRLjp81SFakoJnwhDS+NoH9gSpmBL8qdaAdQ/Qq4R
 nI9sC/GcpDKBvfjoK6OtJhFCTQq73/88zRvH2hV2u1/lcpWcdWNikRgwxYR5OR+W8mVX
 Gpzyxlyij9B1C07H0gbg+dYElnD03eKcfKtk+DdLmgj0AF7G/OZnqJG3dn8gUHBkz0Xb
 FPpCcZai6vR06SsGLiFgOt6YNem7BGTPGoUjWjLHAdo4MRt6ef7miNKI2dt9oJorE9rq
 GsLg==
X-Gm-Message-State: AOJu0Yz2PIrE41TcOn+6y94CtCKIaBX5AnWOsv2f8KAKZj2Pa1dK9hmP
 +DcoDhgR3MsLXPYvBCAzTnW9Q5bOJ5EBNzVzzmeNkfE3KtkFJNNAxj6/wlG5lDwMgSo=
X-Gm-Gg: AfdE7ckujeeRlGvaIZ0SDxP8JjYRyCr+m3BqLunnAtBuH1rJiQ/u2rADRj/yZG+bZBl
 kUlACiPx8h62C6Wscw5oJnfEpBQDy7IIXAApzKXWyz/d0/8EpRL5KcdJTeCkOxD/4sX4bt3tJD6
 KdgfzzRHZSTLuAEsb2y6MLnJafm8y/phQ1Jx/8s3aRa5ebYqqYc4ot3AFjzifVP+dwkoNvVPquW
 /Ti7kv8sCg9DS6n56f7DgEZoA55KimRoBd1fp7biLNFkGYG2GHzPPYiu6M1yV4Plwi9lwZh7jTc
 hSKvvI1vYmwIL5YzZ25C/MpEPhSsgS3Qp4ih+FRLbTOqjNNMbGbHJs8m9CI/QKbtJ2fKX/CGmzz
 nhPrNXkB02ibCsB/bd3mgoECAjVAiLOyE5GIT5Kh/QmqZ5jaWNfHQB5lUBDQcY3EZa+QVqQzoTY
 AH4ck3byRF+E8cA3rSbI2S3FxBqkfAlJrPw/JtSMWR6pDFaBr7/3rPMaxR24mK+i1tPcl3BW/W4
 XgtoYm/yVSETrmivJUdLNHgLCfCUmGdc10eXQ==
X-Received: by 2002:a05:6820:6aea:b0:696:1450:ff24 with SMTP id
 006d021491bc7-6a309a890e3mr4028080eaf.36.1783010041539; 
 Thu, 02 Jul 2026 09:34:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe8d9c13sm3130321fac.7.2026.07.02.09.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:34:00 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:33:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v2] cmd: kconfig: i2c: add missing I2C API dependency
Message-ID: <20260702163358.GA749385@bill-the-cat>
References: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="93SEJCsBL7sX4/7b"
Content-Disposition: inline
In-Reply-To: <20260702-cmd-i2-add-dm-i2c-dependency-v2-1-e048ab426191@baylibre.com>
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


--93SEJCsBL7sX4/7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 05:26:57PM +0200, Julien Stephan wrote:

> CMD_I2C relies on either the Driver Model I2C API or the legacy I2C
> API, but its Kconfig currently does not enforce either dependency.
>=20
> As a result, enabling CMD_I2C without DM_I2C or SYS_I2C_LEGACY can lead
> to link errors due to unresolved i2c_* symbols.
>=20
> Require either DM_I2C or SYS_I2C_LEGACY to prevent unsupported
> configurations while preserving support for legacy platforms.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--93SEJCsBL7sX4/7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakaS8gAKCRAr4qD1Cr/k
CtMkAP9oI0Sa2VxSqInCn+xZU6i/hM5ekFJ+mLMd/NVomTwnGwEAxkk+JsdKoOm1
RuwkeGZdcZKHQ4/Ipy/bD4a4dYxrfgE=
=G6g/
-----END PGP SIGNATURE-----

--93SEJCsBL7sX4/7b--
