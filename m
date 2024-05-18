Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D95C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14318885D4;
	Sat, 18 May 2024 02:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HxcilsQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2465A8851D; Sat, 18 May 2024 02:08:29 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 031C7885A0
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 02:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-79305314956so78572285a.3
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715990906; x=1716595706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xPwDfqKLGYYsNkApu0FUpC/i5xUFmdtrZ91mTapKMsg=;
 b=HxcilsQnXU9ga1CN3nLVRGfnqKGUfArUWakgTWYjgCZF/WRhI4JkWzCjl3B+6+2dNn
 UfKSKnSA/FcdjbuB74FX0CYLmx0aHVeTCxCqdJyPy4JGWtsYqc91MsyJNSui90/QuMqR
 IRnSymdyGRsFd3qSpUGqyvwXgzuUQo/unfuaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715990906; x=1716595706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPwDfqKLGYYsNkApu0FUpC/i5xUFmdtrZ91mTapKMsg=;
 b=YVdDG//Q2LSKAkdQk47KnzX8k8paD0bm0ToLaA3jqDEoJ6Ka0Uu/F5ym9I18wL4Mbk
 NdqkuiqNHzIjeGnAoqD49vZj9uS6/ugE8GGVxjLE65rL2nYwCplci60bx/CX/ghDFtxB
 cXwwKuOAyxnbbGx6yJQ99bdVGIjK5Gvx9DOA3Uhjk+CapgmX9v72PMqOlwlgCO0zAne0
 LTwUjk7V4YebRy50q0b57H8eE5mBVfPq058SiMzZlVNSkCzj2M1JzaJ0rBXZw5KDvlOf
 L/upFR77JvWx0SHiyswD6bxFsi8QtJwpQphJipezk+a8rKmdFHrnn1BZgj0g14pCrCc2
 yYFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/VrPaHagxByLlhMr8UppmCtAyct4TE9lMyXIXycZbsDxpX9CHOXja0VOGu69yLJHimH2foHHwTs5ysDpOtVUBG0OdFA==
X-Gm-Message-State: AOJu0YwKGd5gafDG2A1KWBMSrNpRVbGz0q2F9n/A8MccV/f0s9A+z50H
 IDeN1ve0JE/tEaTDINwPiTdnQWe187MNvVAcnfc05lnfE/muMCb7/ozM6rQBPTE=
X-Google-Smtp-Source: AGHT+IEoXmPVBX+1PJjA4uMBOoBk9jArjhxODdXnJW+29FkIvL0VF5V+us1kldtU/F3TMtkiWKPeAA==
X-Received: by 2002:a05:620a:10a4:b0:792:c480:7d1b with SMTP id
 af79cd13be357-792c75fd7b0mr2396928785a.64.1715990905791; 
 Fri, 17 May 2024 17:08:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f83csm948761085a.32.2024.05.17.17.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 17:08:25 -0700 (PDT)
Date: Fri, 17 May 2024 18:08:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de,
 Stanley Chu <yschu@nuvoton.com>
Subject: Re: [PATCH] timer: npcm: Change counter source
Message-ID: <20240518000822.GN2568172@bill-the-cat>
References: <20240513072603.1598677-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QxaxxrQbt6AlztFo"
Content-Disposition: inline
In-Reply-To: <20240513072603.1598677-1-JJLIU0@nuvoton.com>
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


--QxaxxrQbt6AlztFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 03:26:03PM +0800, Jim Liu wrote:

> From: Stanley Chu <yschu@nuvoton.com>
>=20
> The counter value read from TDR register may not be correct.
> Read SECCNT and CNTR25M instead to get the correct timestamp.
>=20
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  arch/arm/dts/nuvoton-common-npcm7xx.dtsi | 12 ++--
>  arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 13 ++--
>  drivers/timer/npcm-timer.c               | 81 ++++++------------------
>  3 files changed, 30 insertions(+), 76 deletions(-)

This no longer applies to u-boot/next, please rebase, thanks.

--=20
Tom

--QxaxxrQbt6AlztFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZH8XMACgkQFHw5/5Y0
tyzr0wv+OVWJE104uMHNfDfL3xEqHHmVa1F5gNvlfpe9PwXRIORaQFbzKcAyzGaC
xD55/TX8IuJUprQjkODSey4fkIVN2RYeNjN1UfCFsYShBT45PqfooNPijpijQL+/
tfEpS/TiWEUTZaRfWJlGxzQpw5xdy2KkmqNSV8XiRF/xPwQl/+j/DFwEaxSnluxK
gutnaP70M9GvApfiq8B5ug1yc3HZZtjznRAIfz3kwfomtzSt4XTdrNE0GBEBPutE
8n4oBPsBf/2c+3i08+cyKyBo2TNXJbgPz3mA5/89eLox7V4AETpH2NnNwtgzMGM2
xvCFNeH6mILBO3yVrEQ3TvGqMwkiauimbyThogB+wIeROtsS0WOOlupbyDOcOehX
FHoxxefqVa97L+iggvrWyQzMWoJgm2ntyjIN6SSy0gPgBxV6Wfy9XHUTHDj5F9Yg
eCnNqIRFWuXAL9wjuUesrMiLTRWhD26e3mdFTynkJbo1TKMRU/ja1FtNl7L7JSHm
iPANMaNI
=oDgY
-----END PGP SIGNATURE-----

--QxaxxrQbt6AlztFo--
