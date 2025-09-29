Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783D6CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 17:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C845B832C8;
	Mon, 29 Sep 2025 19:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WeWCCDrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8715F832DA; Mon, 29 Sep 2025 19:46:10 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B8982A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 19:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74c7d98935eso2659082a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759167967; x=1759772767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nQqmwXvn6yFq0cMS4dEj+esrGAsGe4B3Cd+O09p6MiE=;
 b=WeWCCDrjnblvU00+vM9XyHodjuHUPHti9xNY3eF2P9xjwQHCLxRz41cxflRf+QIyY6
 r4vbtk4XZgpYRR9UyPVkedXkfff/wvZZD94pG5OfOiOmQjTmOmRxJQEYnVAufuj/fKsA
 4WhJ67H/0ct7lI7bYhlZlzNkeiA3EknFVJ0Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759167967; x=1759772767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQqmwXvn6yFq0cMS4dEj+esrGAsGe4B3Cd+O09p6MiE=;
 b=dOmbzwEw+778tpLeSjdZdGPcN4uhjHBJkFLcPWIOEPqMX54kLirLfE6chCYIk4MDDL
 EoIipSYB1V6IQO8VRd49EbYS8Z9tZ8Fqw41kFY8MGHGq8nNvWPaTFD/17PY73RVYKCA7
 v/FY7+6ftIuL6kJkeNIw4eq5xxzUdQJZkj3FGKTKNGlqgErpsKI4DhGZlsL4CxYSZ0YO
 jCznm4Xhj4y6CMkHw2Pl3BAPaIQsJXPbHKwjmxc8l0laFj4EuFVJTlV2HLY6ydMxaJXJ
 gTeuyBZmrhEdx0NMvgA3HryeiuZWTzihkw+RM9AxHOuE8ADsyqa4Im9A/8lFMXCIImeb
 dMVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRzsm4969MveG31PZA4LP7RMCZzQIhKEA7t/fV0rOyVPTiSrqNNC66lrrXxt1gH4YKTBr1kf8=@lists.denx.de
X-Gm-Message-State: AOJu0YyuJVW93gOZh3baa019b4a6+sDsS5D+nMej3SWV3U8toYcrcg/N
 8K+czMTIUClIK0aU4Hbikb7Tr1918Kcemz+zCr1u5YF5+T1HI5CPhp0mrv/RzedJgfpm/KWUBG1
 4AgUQoHs=
X-Gm-Gg: ASbGnctz3TlJKla7ePMGsfF3YYoUIEv37kbxUIAoa5UlkJrrXuzpVm+pRhoGWhJsPI+
 NO8oayRNc+/UvUIA/SlsY8cieydl4LHt2BXQfh7V1cpzIPxX8ddlo1NhzRbROXgn7OXzWn7yTzi
 RtWBWaNa/ijLEywA0CrZFiBUsltYegGPoq4XQ+zz+dqVFtdtI1fNBYS34ssoO1/zK1zV2XDzuKw
 K9HPbESoCXvQTtDJXJfmMlITOXR4u2QTU6axVZ3I26CLLWrfTFJLkwBgAxrHLKLzckGiUtR+Zop
 V5eq2unbpyeW08tWbqtJWecANEUK/K89C88OtIkfabrA0/QenXQQKlGKxz10ThGbt7yk7e18OhR
 uJYEuTqTERRmbWAyxFp+gb/nePqb0M9jptoeRSrJLN2IY5HBF6HHwIdMZ
X-Google-Smtp-Source: AGHT+IEfjjZ64Km3vCB5hUwL53C+k0GfvgUuoCQnjFThfe6rvLJBv8PsnOgplHAyJTvobIx4h4h2yA==
X-Received: by 2002:a05:6830:2117:b0:7ae:9799:dd9c with SMTP id
 46e09a7af769-7ae9799e160mr5629199a34.22.1759167966895; 
 Mon, 29 Sep 2025 10:46:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7acd75cae90sm1867286a34.36.2025.09.29.10.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:46:06 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:46:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Add symlink from gpl-2.0.txt to a COPYING file
Message-ID: <20250929174604.GK6093@bill-the-cat>
References: <20250926094546.1904854-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tTok0aMCDith0RE4"
Content-Disposition: inline
In-Reply-To: <20250926094546.1904854-1-berrange@redhat.com>
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


--tTok0aMCDith0RE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[trying again..]

On Fri, Sep 26, 2025 at 10:45:46AM +0100, Daniel P. Berrang=E9 wrote:

> While it is good that the "Licenses/" directory contains the text
> for all licenses that are applicable to u-boot code, it is harder
> to determine at a glance what the default and/or preferred license
> is. While humans can look at the Licenses/README file, this is not
> machine parseable, making it tricky for license detection tools to
> automatically determine/report on the overall / aggregate u-boot
> license.
>=20
> The project previously had a top level COPYING file containing a
> short blurb, followed by the GPL license text. This was removed
> back in commit eca3aeb352c964bdb28b8e191d6326370245e03f when
> the "Licenses/" directory was introduced. For the benefit of
> automated tools, it is helpful to retain a top level COPYING
> file in the repository. Rather than duplicate the license text,
> however, a symlink from the Licenses/gpl-2.0.txt file should
> suffice.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Reported-by: Alex Benn=E9e <alex.bennee@linaro.org>
Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tTok0aMCDith0RE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrF2AAKCRAr4qD1Cr/k
CgvSAQDtwuDFs3zH7g5zSZsTfiSFG81xHl36v+oPJrxdWcnEbQEApiviH3tKj6z+
/SAfeAFI75Yyguq/60yG2dgsPk82sww=
=Qn2p
-----END PGP SIGNATURE-----

--tTok0aMCDith0RE4--
