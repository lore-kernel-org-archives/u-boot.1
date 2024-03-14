Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F64C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E4487F2D;
	Thu, 14 Mar 2024 01:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMhQmeDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A712587F28; Thu, 14 Mar 2024 01:39:19 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B496687F5E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-690cbf99143so2612196d6.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376755; x=1710981555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2LgsAQw5gRlTTTD8vs1tBBkhp7kN1UiPZwztI40C3IE=;
 b=dMhQmeDKKw35lHhniVCe6RM0Hkkku+N7D0oeSZh8xDzy3ZxCPXC3iZvlWadcHtIbEv
 dWqpmMlPSBKEFEB+QOHzLJ8gfnnp5+B8mU8KdyEYNKuYe7jmgEg8qFREfhX4SDYJOF0i
 3gepwCAgGvw6a+AQqedsYx67onG8kDpDsC9N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376755; x=1710981555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LgsAQw5gRlTTTD8vs1tBBkhp7kN1UiPZwztI40C3IE=;
 b=q6o6gpJXKq3cYQJlE+1GYSSh1fYDRgqcQhNls0KutQ9aBrf9DIISDmhn/jrqk2e/ki
 i4FIeiH5Dan/6i4z1kAjSrLUWT3oFrvaP4oOxiQBDGoA2ikJmSLqudrHf7N/21jfyoPA
 +YTg4uORqFU/uVPKj/rwrWqaM0FMw6KvzZELD4bTCRtW93ErBMFwNiscJVZ+PJ4jJmVl
 ME5cRrTmvdb5YA14+8h0vY+b0YfP4XU/jKy5laiacKTvEclqX974UgGfWedHGDuA2B/B
 u7UwteZo2APvOgm6c5Psvxr6oVgjgsrBvp9hurb+WqHhfWPQns6M2hAhJt5GSiVW97HU
 NgzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlye+VH+5E1JzbT/t8VinlPqR8ejW1EcKzrneufJWkTif6hfg3Ap36qBS6DmxjjFzCrfKMeKTkeMoTI2o40itwFC245g==
X-Gm-Message-State: AOJu0YyZ6X5DAYpvZNfUVYzAZ+iQqbePFX2zwxc0TXKqcHGugytgkGpR
 qk0pfeyMgJMLZ9yU7Sbw6pD4oaMQxva7G9+WPfSltRqhzJdt+J3p3JB+7geq3fM=
X-Google-Smtp-Source: AGHT+IFxVbrBHOtquLAkhuGOoumyg8tUrPM4dgTsuYeWdqBcm0lOAyv//hNmrKzDqCUeIT/9077Y5Q==
X-Received: by 2002:a05:6214:972:b0:690:c73a:db09 with SMTP id
 do18-20020a056214097200b00690c73adb09mr317292qvb.24.1710376755303; 
 Wed, 13 Mar 2024 17:39:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 dv10-20020ad44eea000000b0069111c5cdd4sm213211qvb.100.2024.03.13.17.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/3] cmd: rng: Add rng list command
Message-ID: <20240314003912.GG3442575@bill-the-cat>
References: <20240304144242.11666-1-o451686892@gmail.com>
 <20240304144242.11666-4-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JmMa90pMNiRm1110"
Content-Disposition: inline
In-Reply-To: <20240304144242.11666-4-o451686892@gmail.com>
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


--JmMa90pMNiRm1110
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 02:42:42PM +0000, Weizhao Ouyang wrote:

> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed. Also update the help info.
>=20
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--JmMa90pMNiRm1110
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRzAACgkQFHw5/5Y0
tyznJQv/ZZYCmsfZgpWt8mS/aRdakeXcOFEdM0MrTL2LOLCbo5Bpfjxc59zndD39
tc8ASSb++k44GsxQk5gQZ3E6dHWyrY7dYmT9nIZznqFttroFBzETdVXTWYoNuiHx
eEx9C+Dcm/N+m69WLUyGKPRNaQkfLFRo37AhkGDOzrDS31iUIzcrK0L8xAwqN3lX
itat0tmHSrEZXLmQPdmr66qQY84foUnlHUAHBHzO3UMCo+ZslIdxgjR6ZH6/nXW6
DN7h6b+0v9DzjqMauTRnR0kbstOcg1ED7AyKad7E+1Vzms6dZVoaDQlz5gkbr5bP
q3SNWw+Gk8oFPVxOhaM+XSSmD4Xd6kMMtS4eMQIC8E5Hqlr3zlpnP1Je3f+RvHic
OjlV5BpQZSMHLfr5LyxUt2YGmBALygnvjb32GQnBwKFySvZR6aIlYfPF9z+O6xmc
Gxprbc1NWebZ6clgji8Hivv9VsJ49ojZIC7oWQ3x+xKtlhRrUcWLTLc2Zq+yveqe
0cSBeAKv
=2CMy
-----END PGP SIGNATURE-----

--JmMa90pMNiRm1110--
