Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510F1C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B6484AF5;
	Thu,  9 Jul 2026 03:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iOlj70s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F91F84AEB; Thu,  9 Jul 2026 03:52:40 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853DF84994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-495c63c41ceso793691b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561957; x=1784166757; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jy9vrRc+6Rk23JrqZGfk4+ZYEr/cwb2WT0OYz6d7heA=;
 b=iOlj70s3YCU649Zi/yUV1bkfsFfxkwvqhkFMFxS/fORu15+1TWtl9XJgu6lRv3BEeg
 rfJnCa4TB7V482CUWex3mhYI5j8DMHdU4Sqxy6rY9KIkrtdxBBmoiRwFmzIOKjRHUtv0
 g8vh+Iye0/E2GR8dyp9nMTl/jxK3MKqwR6j90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561957; x=1784166757;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jy9vrRc+6Rk23JrqZGfk4+ZYEr/cwb2WT0OYz6d7heA=;
 b=SljL2Tgi6vJBJMkLmUnnAwLQdwmhxybNUqLHpLfBm5Rg2bxQYLvUcXIhbI5yN1hap7
 lr9hdsPPXjJ8GB9+rQRCXPZsJyaOS3in98J217WTBbSVQtEA+kNYZ3RKvzPjHOzFkG2y
 Rdibfi5t4YU4DwyMCYuqzxKkxKx8kuFdxz6eky59lXGHsEgPANcJA8vaSLGct1nEB8sB
 +6ojWUHNL2niKw1CDU30t7n4hh/EYOusVxjKyJKNPJTI8iDHTqyQr1PVWDG9u7oLd9G2
 XtaYJkP9QThni2NKYews4D0MztUAzTTmAtufiDMcZbI30jBOAhLlpWs13X+9SFHPEWvu
 vEXw==
X-Gm-Message-State: AOJu0YzjBR5r4MGg6++yzeq/sql4rUf0naBT3l75oKvhknUmVuCIWJ/p
 zBT+D2rwTbrcPRaKsoXJQs17zvZDvZ5E0mlkBvBH3eInCmbI/iMUMbrfNblo8PB6zNE=
X-Gm-Gg: AfdE7cm17kff/TK3rRdqbvzfyBW1XOzzhlRzuwedI6oJgqdlWjhPagJDF2PIOab9AOD
 ni1rukpK3j+5SpykQctE9lw+ki5NfqIbqljGobmMqBMu1flJVsK36rNnUCOoMeDdtXEZU/R9Ovx
 +/Ot/HxgyGGnQyi9O+qag8PJ8K2k3RM6Pfk/Pjopn/i3T/cjLQpmzd1X0ymEdvAudpF6NaOMYDp
 URUjjfC4qisX9uxC46ag9x38EHBB4WiLxlfoNKfDe10VathtMI44m9ThyGnS203uvekz+Ue/BuI
 vEmX3bQtcjb2VRPqdniM7wLNCfTAFsyJMHW/edEV9A9lA1aTaIvR/CU36htybIbZwCUHzXpCQfu
 SiiqAtX9nW/4BnQMe8tNcZ6lMUkFfqJNjfV0ksvo3+H0G6tWkxUxZjKSCpmlwojWX11H7fcgPX4
 BZbr3N2irWEmhQ/HyA3060tCADIeOXWQWUcU3N80kCGuIW01WHr3JDiENdlFXdkJBgpOdDaLAKf
 rroq1FkkPa8qGD/g0WCujHL72nAQGMkDqq5PtSPWshf8lSc
X-Received: by 2002:a05:6808:1483:b0:492:9e13:d5a7 with SMTP id
 5614622812f47-4a201beee7emr4294086b6e.6.1783561957248; 
 Wed, 08 Jul 2026 18:52:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm2981830b6e.1.2026.07.08.18.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:36 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 05/11] spl: Simplify xPL_BUILD conditional guard example
Message-ID: <20260709015234.GP749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-6-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G04ffdDcwOHUYSYO"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-6-jonas@kwiboo.se>
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


--G04ffdDcwOHUYSYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:31PM +0000, Jonas Karlman wrote:

> The old meaning of the SPL_BUILD symbol has been transfered to a new
> XPL_BUILD symbol, leaving the SPL_BUILD symbol only to be defined for
> SPL builds, and not all xPL builds.
>=20
> Change to only use the SPL_BUILD symbol in the SPL code example to
> cleanup from an old SPL to XPL symbol rename.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--G04ffdDcwOHUYSYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+4gAKCRAr4qD1Cr/k
CoH/AP90R+1cICKzbHdya47XJGEspJvQE/meh3Z9RZg+jqMlhwD/RP8r+0IwwFUG
otG0nz2vYsFYt4K4p89Mtpq62iGdzgs=
=+u9Y
-----END PGP SIGNATURE-----

--G04ffdDcwOHUYSYO--
