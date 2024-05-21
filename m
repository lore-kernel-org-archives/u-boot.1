Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEDCC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044D0881C1;
	Tue, 21 May 2024 18:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZT/l0VNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449928826E; Tue, 21 May 2024 18:25:50 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C791887FEE
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 18:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b4e94ecd2so1230956d6.3
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716308746; x=1716913546; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lqWbdzBqsg2nO8NnIl6SvYKIG6FlpYB7DEYjZLoCBXc=;
 b=ZT/l0VNq7jvvY8gESaUyBN193i80xNEXHpBKBPGLCiz+w271+1oK/e6Q3VogDA8+JL
 aa7615dLPEv5mdZ8TsMDXJQUuH3gZYrkDqweznB6VNwoGhveaEi47bjV7UKuC008ePRU
 1cNg9E5Bcjt5z2wHg4OLLrs+yrZoH6AUwpngY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716308746; x=1716913546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqWbdzBqsg2nO8NnIl6SvYKIG6FlpYB7DEYjZLoCBXc=;
 b=xPUYLbAzmmEv6Eqb9iZN1mZEEmRmOiEiy2+HSoEwp1HjjvOLlDnxkTQVlBE1XYjjRs
 wt5NN9fXjy/YHhw2CipSl8TmSCYNyH03HqGW6uSVtWk6KHjXrChx9G1np7kImrHEWjTI
 pRpfQ8PHZpvB0ojgEJBDedhKFVYg7SSYH1iL0zvZqhtp/c/tVDBFuXqr8sdJaskB5P+9
 EBLpx81AxvzyIIC7gXnbF1iHKL+MF57NJ1wdiV5T3R87cB9b2pGec7E6IxcYVPbmhjcf
 4Hd8YFKP6690SXBe+QFKoR/2+7pvo0La2AbRBkSp+GxbFmJSJ1yw7XHjY30ds7VP4iSQ
 rxWg==
X-Gm-Message-State: AOJu0YztQwQHG9X2qXf3VEGljgdK9mKB63/IGHhImuzylNp1cPRDN2fQ
 ZOYbKLsQp1ryPyugaRUDbaGNoInnqXph86snXhVWX6rq63S1yhQMrfgrfZr2rpX5UwQZX1Csi0Y
 fg/s=
X-Google-Smtp-Source: AGHT+IHZDnNDGShwd8gR1Fhe7ZZkS82KueS2iRxvk2Sf3pFH26/48zF1TZ6aQsyyHbJYh3QFo8U1yA==
X-Received: by 2002:a05:6214:4990:b0:6ab:6bfa:c42d with SMTP id
 6a1803df08f44-6ab6bfac554mr54040196d6.51.1716308746656; 
 Tue, 21 May 2024 09:25:46 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1857e3sm124299976d6.52.2024.05.21.09.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:25:46 -0700 (PDT)
Date: Tue, 21 May 2024 10:25:43 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240521162543.GU2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LPohKnOsw+hqUout"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--LPohKnOsw+hqUout
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 01:21:01PM +0000, Brunham, Kalen wrote:

> Adding Tom Rini.=20
>=20
> Any update from others?
>=20
> -----Original Message-----
> From: Brunham, Kalen <kalen.brunham@intel.com>=20
> Sent: Friday, May 17, 2024 3:14 PM
> To: U-Boot@lists.denx.de
> Subject: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>=20
> I've encountered a problem when compiling the 'examples/api' directory fo=
r ARM64 in U-boot. The problem lies in the assembly code in 'examples/api/c=
rt0.S' where the current CONFIG_ARM code is only 32-bit. When targeting ARM=
64, a 64-bit version is necessary.
>=20
> I have proposed a fix by including a 'CONFIG_ARM64' section in the assemb=
ly code as shown below.  These changes have been check via https://github.c=
om/u-boot/u-boot/pull/538.
>=20
> Feedback is welcome.

I would start by asking why you're using the API on ARM64, I don't know
that it even works there otherwise.

--=20
Tom

--LPohKnOsw+hqUout
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMywcACgkQFHw5/5Y0
tyxrbwv+MZLHkSGLz/68fMdfs3hLDnBktxPd0bH7l4GhR02uf0GSdP8zvi33j7Vf
Q+5Nvn5mn/kBFTK/Q37SrKJxpuaTSd/9HquUKMGRJQfOyo9qZF38I546dUZX8kDZ
nhXiAZc4EnGDdU4ubhuGKiKYoAzRaZZCEHTTtmmSTfoZUUnMv5Q/o0XE6IAUF2cy
N0DlyrZn1wvwYFVZiPOyKsx4eEtZmZ6yX4NGut4w81JX4AxLxcwqxY4flH2c/JFc
Kvudkj5H4sYxpTW8LXvexVPp2DZc9paCe1sjU6eNYKpFBMer1OM6AX/b2QX0Ujhi
EbkalUDVfqKbug3tQ9le9YaNPKOXDOxzSFKIAHvAiIHl48eqhYUTirPqkqoZ7IBU
3z2zSp5eo5sCWPXRzQIznXcJOQPN2YCUVo2Ol2sOKQ5V3pBJiJPHv4TMmDfhV087
MqnR/E4VerUCBAnRmszTFWfOM1z4e9fyWidr5g3agLIh3QXop0z7RVl2iRUzXNfE
6JmjXDAt
=LhGp
-----END PGP SIGNATURE-----

--LPohKnOsw+hqUout--
