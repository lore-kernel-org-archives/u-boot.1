Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8586F10F6FBF
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D9283CE3;
	Wed,  1 Apr 2026 17:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kq/3B05U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B139884011; Wed,  1 Apr 2026 17:48:45 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8536C80517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-464bba3a9easo4319601b6e.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775058522; x=1775663322; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9rutpnVoJSLnF7OiqDC7eCZIloDGgoriI+mnYPKEaNw=;
 b=kq/3B05UO0abkczveqV06GDBD3UrWt9JE2VYbFxhz6iuE1hiQNrDRVZYRWBoasdL/7
 el45APDDVQPdDNpmNlUwei/hVCABeuXJlTH/TjtgWz488NgwKDe46TNVY06Vo4R2Rbry
 u99MVwgEVgn0smxlpj8KL5OJIOVTXEex3aMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058522; x=1775663322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rutpnVoJSLnF7OiqDC7eCZIloDGgoriI+mnYPKEaNw=;
 b=YNClIr6njos1PQq+fWc+NI388MEmmjcDpERdF5uVfo+Vb5B5m7Yfx3VbGBRaQTDRiq
 OtZSaAthGMMwOyMrPT5QBM+L9lLwKrwsPMWhWe4ZNIbYhnpkVmGlLiaHxeRatCS141f0
 hI0f2WaZxKrHSgLVD7A4nDagKF3oxgOTGlYg9Z5kHPqAxQzCXq3rZuEP0zj/A0JwXtaF
 kMaeW+KE2x2uhj0lgfo5hCPl5EzKwbdPZikFNoWjQPKF16ej3ya7occiDVxKAuBmK2AA
 yQ0YrCH4pq71Qd4qL5ylc7hWejzt3pFbkfVhRjkJq9udPCWwqwnMKjC2ql9Tqwbhw7oU
 b3WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+RlAauJ/0cWBM7yRFWZ4OAiaAFieeHN0DR4wFAnyGGiKqAJwvaGaP8MYAU6NVpCYCO+eCz/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8BAWCcWCBUr3Fz8oL0vMZLN0Ch40jhXjCSVF2xGEeoabodyvj
 SoFrGXGE9M2oPeTYS2lh4lxpyKyDHymUkkMzADd9IcGMaxMUnUAd+1Mqe/TXhADSCiE=
X-Gm-Gg: ATEYQzzpW3Rpl/kbK9AYgG3Nj76fBu72cXnZdPqFtXhVsPPO6GpVyPOba924x5rMMWO
 QQi6lhtsLu8+glOZs4MaK4q6ii3EN63j+5HKFOcJ/dfmTqMjchMN5628UFYYTr8MrEZkd9mpqIp
 P4hGJfk/Sp0wks+tCMq2i1QaMxBgD2lDm4IewTfcm/8FaoAI+XAU3000O1iDz4izpG2vNDQRHa2
 +t4GTXyf4NMboUxm63xGPx70IcWkt2/bgq0eRE0u3Ca0dYYZ7eSS+KicJCtIfJ5y2dEmKxzGf7m
 5sQesGXS7OGEMgotJRI3deeyY0V4N8P6JKfk2g+0cEY6V9CIHkoO3mcKnVJWhoDkWmFP2YrB7zg
 T2o296S+QmAsa0vbXqaZ8BzlkpLYXrMm7CUxwJ1FVwD8BMuPFQ8fmBiCXrERlF6GSm7RaVhNE9R
 j1RNqxT+Yese+EvBUSx9WE4K/SLpyTExHgOjy21puaD/HcoKawWl48tZCodz94KijKiSd3BvQ5a
 MgmyXNbWzsd0p9ZBOpabZLJ+MqTMYig3ffoqrrdEUpTB4b52EjGOc6BRTY=
X-Received: by 2002:a05:6808:3089:b0:469:eb5f:891 with SMTP id
 5614622812f47-46d89b4fc5cmr11701b6e.39.1775058522107; 
 Wed, 01 Apr 2026 08:48:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a9fedaf8esm8839624b6e.6.2026.04.01.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:48:41 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:48:39 -0600
From: Tom Rini <trini@konsulko.com>
To: chunguang.li_2@nxp.com
Cc: meenakshi.aggarwal@nxp.com, andy.tang@nxp.com, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, u-boot@lists.denx.de,
 mingkai.hu@nxp.com, Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com,
 camelia.groza@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: Re: [PATCH 2/4] ls1043ardb: refactor EXTRA_ENV_SETTINGS and add
 board-specific overrides
Message-ID: <20260401154839.GF41863@bill-the-cat>
References: <20260401085947.1670191-1-chunguang.li_2@nxp.com>
 <20260401085947.1670191-2-chunguang.li_2@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="keVNS4KYnnQskUgk"
Content-Disposition: inline
In-Reply-To: <20260401085947.1670191-2-chunguang.li_2@nxp.com>
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


--keVNS4KYnnQskUgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 04:59:45PM +0800, chunguang.li_2@nxp.com wrote:
> From: Chunguang Li <chunguang.li_2@nxp.com>
>=20
> Upstream-Status: Inappropriate

And you cc'd the community list. Please use --dry-run to catch problems
like this, thanks.

--=20
Tom

--keVNS4KYnnQskUgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac0+UwAKCRAr4qD1Cr/k
CmJZAP9HzqQYciFVvGyRXnaSOLBeiX5lIUHRhMMkc5OniEMYBgD/bjKjE+sp51Ba
5Av2KqwsProhOFaMkW9IYnZYNiZftQE=
=tcYh
-----END PGP SIGNATURE-----

--keVNS4KYnnQskUgk--
