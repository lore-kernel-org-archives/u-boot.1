Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E559C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AA6820E2;
	Wed, 30 Apr 2025 16:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QzwtxGRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84492820E2; Wed, 30 Apr 2025 16:17:04 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 488778007D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso2367771b6e.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746022620; x=1746627420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rgU6xZ7C5nGd0qZrkMro3LIKYdbLIAT28c50z/PHgQM=;
 b=QzwtxGRj3++n4rmajIvacZ87TzxlD4HHIguiJIcFVJIstMr+Xm0sW4KXn+BwMCeuJ1
 JRU1ytQakLzxP4ezOAS7qCa7Tg/BV1cB/gz3MVdAI9g3ug3OLMl7gitOSFya4qP69yEa
 7BYgORh5K57UTFZg9RU6T9KRaeiNdB+8VbiBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022620; x=1746627420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgU6xZ7C5nGd0qZrkMro3LIKYdbLIAT28c50z/PHgQM=;
 b=Yzum6nkzA3LfHC0GkAEhEAdlzRAftLPc/k7Q0uAcIeENqcCtK3A/7bNt0PDIzPQprk
 fg0L+aC9q1fXghy+3+QG8i6cYSMw26OBBLEMeDfUc1Ckqxke3B4fmWqvIfQa5ZyZyK1m
 Bt/wlJsjCbl6i7ucnXumxq1/pQJSx3qOwxYgHEhoU17nTBOlVZCKaBmcUf+cZOReeEoW
 lngyx4jtyEMrtePg8fV0kYD6KmpB2l6bm8W7qgpN7vIbg0Ik05RSRdf3kwrpAFsUNQZo
 uQjvj4cX31uJpUvVkvtviiz9+cTHhKoxs2BCk2y3Cj0EYoETTLJco8kV37RcPgYiK384
 FBbg==
X-Gm-Message-State: AOJu0YxI21Cj6E5y+xzuPxtmn32XLZGXofGlDKjH8NFdmVprL9oRweg7
 3QchnGOBCx02cKPuG7ilMnb8emWqnfCB1XswUQoDqF6wUGi8x1Zkd3RZJVczSVQ=
X-Gm-Gg: ASbGncthv6dOkNKot7kRSPBi6y2hkYNYk/+PldwDQsM0rc5Zkl0dtvU2UvwtnShNSzA
 C+SHWAX+GBjEqRrCfCtxNM4XtSkz4Qpy1HjdBHUtvf8Yyyl0TnOjnuIi9kD0MC8rz3Uy1C/asqu
 8pTbj6Chv+n2HPo31gUBFJrKwb05v0ivtuR2knSm3rg3yfwkJUTJ8TFWINwYuKJSnoB60+64AUz
 RSHt5oT+YsxDeBdU0/AUyhzkP4oRXc5gEEVRtdUIy31CzEYHSXJHp0dlCpenMoCV1Q8P1XOd/UR
 wuInBao/dlRaoxLmKv6wFoly3WiCEr0j7CxH91bWKFUdjm6uiP+/22uLjEwpbl+UQFnbMbtHzGN
 W2A==
X-Google-Smtp-Source: AGHT+IECObyu4ByehDGObU0z7eiiopK/Vsjfx7LgDVHm2qAU4dmM47FubU2+YRL0Lhxj+tDxOuUMUA==
X-Received: by 2002:a05:6808:476f:b0:3fe:af0a:f8da with SMTP id
 5614622812f47-402439a3dd2mr1569224b6e.38.1746022619963; 
 Wed, 30 Apr 2025 07:16:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4021291e609sm820241b6e.5.2025.04.30.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:16:59 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:16:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430141657.GO1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9m1eAWu2/R0sceSw"
Content-Disposition: inline
In-Reply-To: <20250430135751.2626849-1-anshuld@ti.com>
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


--9m1eAWu2/R0sceSw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:27:50PM +0530, Anshul Dalal wrote:

> As discussed here[1], the go command causes undefined behavior when used
> for running custom OSes since the icache might hold outdated data. OSes
> usually also expect the MMU to be disabled upon execution.
>=20
> Therefore this patch adds a call to cleanup_before_linux before we jump
> to the loaded program/os which disables both the caches and the MMU.
> This makes the go command's behavior consistent with riscv platforms.
>=20
> NOTE: This might cause regressions with users expecting a configured MMU
> but I'm unsure if it's a supported use case for the go command anyway.
>=20
> [1]: https://lore.kernel.org/u-boot/D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com/
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

This is the inverse of what needs to be done, sorry. RISC-V shouldn't be
doing this type of cleanup. I know it sounds reductive but "go means
go". We have all of the other bootX commands for "prepare the system and
boot the thing at $address".

--=20
Tom

--9m1eAWu2/R0sceSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSMNkACgkQFHw5/5Y0
tyw5jwv+Ndilpkqe5HiS1qtC2nLkJjeOQ7t71YJfWTlm6aGSXQGvaCTyVXwE2viu
zEUSbAzIrFUTPkDUIcYj8YSim6Xuz6wdlJPt2MukuvFfHsiXX6Bt5u4VECLosvg0
fhpIOV9czXf/hZd+EUmKa0Gtwl/zKFALcQ0cXfcuE0Toyib5OT0n1L8jqYAvMTlx
ZDM8O+YMN+vROkOdNJWUvDDCUIyHC+NN2XxxkB008A5k6FfgOjRgItUl1dtykh8B
WGyMvQAUoHkq5/nNF5e0soHpp6unSbYtzW4dw01jsIRKmApye1CclaQrfogpjEn0
OiMonR8gH9Xx9ZcJJd27jwRPPXYTKm10sR+Dbq5tMJII4Q+0NNHBUiFrFq7MYAVS
42BgSOWmXNKpxy+r/1RlHI7TEdIfa35WQpQ7+KG8MgxMqmHjZBkifutLof/htCFL
dqiXJIjJrMxyarx20wb8pAdaAxenvYOAcoLmPnBjoQgo5H0ykromlb8qj8CMeFin
cJNL5wVk
=1ouz
-----END PGP SIGNATURE-----

--9m1eAWu2/R0sceSw--
