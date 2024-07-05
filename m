Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3EFC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2232F889D2;
	Sat,  6 Jul 2024 00:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AC0MuW3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD57E889D4; Sat,  6 Jul 2024 00:39:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE1488630
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-700d3ffc28cso1123542a34.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219175; x=1720823975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=inaqnmCoHA2sOxix9421U+bE54I8EvZZug9W9FWbn5o=;
 b=AC0MuW3wj5vJLL0VWX59I5asKTkgvPvPbcoaQubs6jCULmgXSgSEQT29Fws4/o2A/p
 NtJEozVI8iKqMjpWpM8wieTCU0Itnk6s/gbJ0VmidG9p9cii9j8diwz3XPL9Bjjgaht8
 oo1huNKkmG4o4Rgez+DNSzfQgywrPL8gz2xUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219175; x=1720823975;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inaqnmCoHA2sOxix9421U+bE54I8EvZZug9W9FWbn5o=;
 b=r5+z9PW48BLGZ5Et1/uwhMBUFLTEKzcaTFjfW7GcJOnm71grk44MpqYazuHmeh/oap
 nDK8+mjN+yewJmZeN//UeRCns1F+bqpYMPy2SQyliMz5PVswnw8DHgAQ5VCZnjVzPsOB
 Pg5xn9Yu2YJ55RRTaXBl2XJSZUguhHxLEin+K9gR0UCzB5uvD/zpaPv25cB2t8Odx27r
 ZQ9IQPynAgBR2mjkUM3M8fR/K4tYAUEo1CPMM9jzhtk/4iylyUKnxf6xDS6hltFeH/fK
 WbWgTR6JvC4tvBglwr/6IfIWwMK3SuRPfdENwg8kQp0rAauo4DJfjlGGq2ZERvwXOnCz
 rSdQ==
X-Gm-Message-State: AOJu0Yy7nL0F67lGaIefWzUqHtr8jCvW/hMkEYvzHLcsbddgBGnPf1hX
 EFC/ZsqsEa5Edp6duKxl1Lw+eWv4IhFX0nFSalL+Vk0/qMudj2M1gYVKkhtcG1I=
X-Google-Smtp-Source: AGHT+IGrB96/hexZ4kMxgiEaZx8n/MU0Gj378AuskDMtVicUbzMOaWayXTPw90PgrTH7B7McRIo0LA==
X-Received: by 2002:a05:6870:350b:b0:254:b3cc:a6da with SMTP id
 586e51a60fabf-25e2bb897d3mr4927468fac.29.1720219175222; 
 Fri, 05 Jul 2024 15:39:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e567a4473sm227813fac.39.2024.07.05.15.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:39:34 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Massimo Pegorer <massimo.pegorer@vimar.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] mkimage: Allow 'auto-conf' signing of scripts
Message-ID: <20240705223932.GS38804@bill-the-cat>
References: <20240620142059.2348379-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NR0fpDiVZwxHbbkc"
Content-Disposition: inline
In-Reply-To: <20240620142059.2348379-1-ada@thorsis.com>
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


--NR0fpDiVZwxHbbkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:20:59PM +0200, Alexander Dahl wrote:

> U-Boot configured for verified boot with the "required" option set to
> "conf" also checks scripts put in FIT images for a valid signature, and
> refuses to source and run such a script if the signature for the
> configuration is bad or missing.  Such a script could not be packaged
> before, because mkimage failed like this:
>=20
>     % tools/mkimage -T script -C none -d tmp/my.scr -f auto-conf -k tmp -=
g dev -o sha256,rsa4096 my.uimg
>     Failed to find any images for configuration 'conf-1/signature'
>     tools/mkimage Can't add hashes to FIT blob: -1
>     Error: Bad parameters for FIT image type
>=20
> This is especially unfortunate if LEGACY_IMAGE_FORMAT is disabled as
> recommended.
>=20
> Listing the script configuration in a "sign-images" subnode instead,
> would have added even more complexity to the already complex auto fit
> generation code.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Applied to u-boot/master, thanks!

--=20
Tom

--NR0fpDiVZwxHbbkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdiQACgkQFHw5/5Y0
tyypqgv+JCtamVBxtzXJVKb51tzQb+T1tacg8Ca9fXKOiIbynun40Bbqz2Hm/q27
ylEzTh4uHwaUcyaoBbOJuviL24tqJPR1v/GsGkF9Dz7suhegI86mtq78eEOxYCnE
3DxTrOPs/+LvR3q0KBh3Rf3mgPQT8TOqC85h1XkS1zP82gkpgkMZOMCNGWEcolgd
cn0LKPiLMjYEwg1KF1US2NPA0fHAJCphEjEQ26We6LpmOODLTO0u51+sM7KZ867Z
LS9aT/3/VwlLRbkGL6CWYZLqD2SynJG2JBIjsg/dKymliO0Y4Yqfd3AIidS2C/4T
OQYs2zsDLDMdA5m83SMLgwUKQbWTeT5VQxXajqIeAfrxOuCM1GNMc6tJsWQq5jk/
QgfEPA3GydI6IbhxI986T93qEuzM5XuM4LHcShgUUXd8gWHWNl/NzJbi01EFoDvY
sT/AhKizHS4To2fUzjIeHqXODStsFymjXAkNqfZH+6vlmmpqCR8nDq9V0foiFqge
Yn1ZNtY+
=wUF5
-----END PGP SIGNATURE-----

--NR0fpDiVZwxHbbkc--
