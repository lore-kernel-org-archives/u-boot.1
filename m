Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7CDC27C4F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 01:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B73CC88644;
	Mon,  1 Jul 2024 03:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jmzWqNil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F84187D0A; Mon,  1 Jul 2024 03:07:29 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A420088655
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 03:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c9cc66c649so1576324b6e.1
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719796044; x=1720400844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7qWF9y9M6nW393FpyFS9byH2hKoQGgvqWjnl3YngjMQ=;
 b=jmzWqNilw4rU630pD1lgXBugBA2LkLBGEVjdCBEIJSkF0tKzOZWVtKN/wAUXSNdFnq
 eJ352axebK4aQ6nuCx7Os6Y8n6Aa75wfLF3jiD47C0PGGOqPRJYT0roi/JS40LU+QCj1
 E4qV6TV8VFGFcj/R9fw5ZTTKFQLGwmGXPW5ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719796044; x=1720400844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qWF9y9M6nW393FpyFS9byH2hKoQGgvqWjnl3YngjMQ=;
 b=myiiQ78wD02vd/VoAGLJIpuJei1jchMapsEcaEm39UjMdyma6+jxFoEu+EBTH+VZ0x
 rIn01G9j3b5gswhQz0Kk8su20aHNYwPzs7To5s7tXxTW8MMKWQmnGkf/IWh2WWYKL7/2
 FORr2YfQp22w6gN29xbghmhValHPLOGyFTVxH8Q3LJUKVoyTHy2xD3X9He7O1sVl+C1h
 FxWULZhE5dC/lSdcY5+K6s0qPLUPP/s8FUePwtc8vGDK8qm3wpJedvSNAPfctaWckIfY
 t8E7DT+8jv6ZB+1hfxVpC5AQbvks8p7fbM1mZiv41rCWH56zkOiDh0PWHYyeHYnjYCLt
 dFWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV7tuCUP+9v7YeldP5xM4tTKiZhbtQd3/71azTv+ySQdEg/raNsibGEoA69YY04c4ACXBigj50ginRgu0UumGBoPy7OA==
X-Gm-Message-State: AOJu0Yw9sM9a0dJGXlcOXLbAJw91B49r4euSgQ1JUzF7B1RlFsQDeYOl
 sWquCjuJdZtOhdxKuujL+A2wlWJr2ROzQ5vcLxfkAUScAPbJ43X1MKwuPwQ21sg=
X-Google-Smtp-Source: AGHT+IHVlJlo6tW6yin8KOKnyisk6GWTxW9svk5WtH+FHym1nqnngA5tRI3RCQ2DYhNDE0ykXRaSdA==
X-Received: by 2002:a05:6808:199e:b0:3d2:4fe3:50f0 with SMTP id
 5614622812f47-3d6b50c0b65mr6239367b6e.41.1719796044385; 
 Sun, 30 Jun 2024 18:07:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9b9cd8sm1198203b6e.11.2024.06.30.18.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 18:07:23 -0700 (PDT)
Date: Sun, 30 Jun 2024 19:07:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Alexander Dahl <ada@thorsis.com>, Bastian Germann <bage@debian.org>
Subject: Re: [NEXT] Pull request efi-2024-10-rc1
Message-ID: <20240701010721.GK38804@bill-the-cat>
References: <55093256-50af-4d2e-9a30-433bee153f13@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6LpYdIJjUASv9UMf"
Content-Disposition: inline
In-Reply-To: <55093256-50af-4d2e-9a30-433bee153f13@gmx.de>
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


--6LpYdIJjUASv9UMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 03:21:07PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 899b088674b6905710ce546f0a884866290485=
2a:
>=20
>   Merge patch series "pxe: Add debugging for booting" (2024-06-26
> 13:17:52 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc1
>=20
> for you to fetch changes up to 636480e4e7088d05d7ff77af72ca00443c62b3e9:
>=20
>   doc: develop: Add a general section on gdb usage (2024-06-30 13:58:31
> +0200)
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21383
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--6LpYdIJjUASv9UMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaCAUkACgkQFHw5/5Y0
tyznlAv/WusUG66S6rdvDluIOyfSq8qs2dR9UMNtOaEvH/6kN2bS9ARSQtT/vAsR
dWghLVf5sieI4YAjiUsr2p3mgW0lW63OlCqbcnHq5Y0hXSAOcivgMsm1AeEhzNoZ
cVmiVaTHpk/pS9qxW69Txjs70hf5qXy9ysdk3pBmhh22ehsprazIYdbsCs/kqb0t
eLIJN8c7Y7A9TrSZtIgycNK7/CwWHq4qGzux7wz4MnGoet5Fzs1RxzLDXAfDlE3F
OqS9mGPqlO3Ccs9RiHVqiY00AUyCTNZ6iDfCpPWpXIiZPOj6Kd937LZ2JyxeJng6
+A86WsHmsrnBwLMEoiUDUV8hBnYkYXAQvQnpxpxduGl0vLnIRLdTTfVQssVNWeBp
6NAUdR/qyh68zz7GU5BtScpJEOG37dZGyA/PIyjEQV2Ih0chXwehj7n0sxUEGuWU
eJIw6ijR5TT9MfmE6fcc1wzaDAAUPxOV8XHqC6G5fUdiR9s/7qwog8rWZCiypMIP
XGNoqKSO
=genl
-----END PGP SIGNATURE-----

--6LpYdIJjUASv9UMf--
