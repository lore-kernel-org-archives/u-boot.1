Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB35C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 13:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1DE9809A5;
	Tue,  8 Apr 2025 15:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m2RFhWpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83A38171B; Tue,  8 Apr 2025 15:34:24 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154F08091A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 15:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f8df49e75fso1667420b6e.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744119260; x=1744724060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IaK8R5Cz0zPpgYdOmAZ2raQY2BmuXUn9kpRW+ii9Aqc=;
 b=m2RFhWpuTEVTMxF6IlPE0KSSJ0WQKlpXTKVAtrqBX9AudEwia6ID40+G+pbRndFmic
 eU/yTLouxqSAT6rrjsUvkwlbJRnaDgpKUK4qgkclNj8wl0Kz1Zyj7mkMYqqtBD4G25aV
 JonMeHh8kU4krsgf40Pn+e75Cb5nIOrCI5Ja0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744119260; x=1744724060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaK8R5Cz0zPpgYdOmAZ2raQY2BmuXUn9kpRW+ii9Aqc=;
 b=HHwhysA1pFvLEDHH2VINs+cO6+jyduyakCGsfzxGXWNjgkoRbWme/LTtu/55htFn3J
 O9gUX9/GuO4Z/suLFD3n1A/m2dQh7IKlE8ay1gJSO0fGnBhR1WQlOj5dWvgS52QFHUNL
 8SJ2sI05wzulz1gyK2w6SYnFfWiNcFZx3G05LAfYjXH/8L6tSifuppjWwHTtIz+xHbPs
 07421TM7pxiOnuVQVMfrJjpwc0CAWXTpjYpdNuPWW8cMkm001idKuK/CN085OXSORqTv
 H903iePrK9Yb71ITtf/FrbNpOhs6dyW90NVRZcQDh0e6VPFxUYq+BceNG9BQPkEHAS5W
 9dFw==
X-Gm-Message-State: AOJu0YzLVY37TGrf24eS8pbuLaOazmuYA03sPtDVGPHvozPVPS/uRS6s
 PIxwveG1GC93k/vt82HTJ6gAa7NpZB+AXp2oQJWOHLFkS5Bz32LsSHL9tD2MiIbMv1TAcxhxphJ
 R
X-Gm-Gg: ASbGncvAQqqtGc4RsxGWTltKqJTr+vRJk+CAiXiWKC7dvSrWjkHw74Q+2ZaW2FcJLN5
 ktiQ6RCInKdU3NZpCZHr8OA7mp3RIZ8EyiDVUt0ERowxRD77JW5sQlKKQaXMC7LnrTT0IWSrIII
 N40VAZAUWY+1+qpS8Yl7UTPB+bTjTakIRWmGXfF8MlRTADSrV0fQObtSDTJAUi3y8saGSs1aHKE
 WfKSuNHE1PPTBjUmNhiYyBoBVwRn00GmoJB6XBjZZsfrHMqKCu7qpHzl8/BLlwySfb2Qs7scf+p
 l7KaxBHbUPz5rFsKOwOtmuAwzCxcj+Hf0MyA4hX6CfFSiXh7B6XSuOS+q90ePxdKsR7O8YvvnO2
 hwuv+Gw==
X-Google-Smtp-Source: AGHT+IEgr1pm4LGSLB65yxeSf1DRuX4foSsokIdQhuYuMzf01tJBXty4v3YH1ZeUQHDciGwrgLPVsA==
X-Received: by 2002:a05:6808:3989:b0:3f9:aeb6:6eac with SMTP id
 5614622812f47-40045620058mr11311814b6e.30.1744119259809; 
 Tue, 08 Apr 2025 06:34:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400690c76d0sm449781b6e.8.2025.04.08.06.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:34:19 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:34:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] doc: release_cycle: fix next release version
Message-ID: <20250408133417.GU5495@bill-the-cat>
References: <20250408062847.1520368-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CTx5UTl5U+148r6W"
Content-Disposition: inline
In-Reply-To: <20250408062847.1520368-1-dario.binacchi@amarulasolutions.com>
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


--CTx5UTl5U+148r6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 08:28:28AM +0200, Dario Binacchi wrote:

> The release commit for version v2025.04 forgot to update the next
> version (i. e. v2025.07) in the section where information about the
> merge window is provided.
>=20
> Fixes: 34820924edbc ("Prepare v2025.04")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20

Whoops, fixing all the dates got me off-track from updating the rest,
thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CTx5UTl5U+148r6W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1JdUACgkQFHw5/5Y0
tyzWJgwAsIMMQAGMR+36Ul/lSN7sipI7zZf1ekVQNdPKUiZrfOuCceIQLhU/d7nF
eJ6I18nFFjc+9cEVxZdzvJyHPCffSMB/78cKPM/xm4BDD5Qx4NewKs3dFIE11XIk
DsCYEkk96Oa/olrD3PhLtrqQpj0GJwShCGqhZA3dEVgg2QDx8grrHLkaIcmadYKI
skEAg0qLzy4Bg0QAIIq8JShgfa/GwV1mpm6C5mHyAIovYytmD7Lrr3PU9EneO5jz
6geDwxhXzULQ1xcySoNf0Xl6HkrEPfz+YwTK06VAUfk0oFsc+MUPAz93+vYn1pE7
/lwydn58lheHVw0SK1U0fkjAM4/nsZfumTUfMEdGbW2aOz+H3JZYUd4bsykYgdhT
hbmW/k0W4dwHy5LYqEQzQQ3UuGnWOlP71lzOZSLEflUILIcExR6RqLhmMneKsePw
CSgr2bJzZubhOke8sGM6vRnGaf0/f93zLQJqoVJqI1ksK3JDipCNIsGvdnxU9Nqo
L6tozNT7
=6FzZ
-----END PGP SIGNATURE-----

--CTx5UTl5U+148r6W--
