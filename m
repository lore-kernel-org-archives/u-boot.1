Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BFCC25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 17:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2715D886D1;
	Mon,  6 May 2024 19:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P7BEXAxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC22886D1; Mon,  6 May 2024 19:43:40 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F28B8868D
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 19:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c8644aa3feso1581779b6e.1
 for <u-boot@lists.denx.de>; Mon, 06 May 2024 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715017416; x=1715622216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AaGAK/C8uwztmwbwHeeFo+CKL10vshWATCP9DxdVaI4=;
 b=P7BEXAxd5+SyOGZRdxqUH2Ay1V9fgdXtpfGkiJY8MBayW9AZwx70xmfj7AyPBwHatY
 nDV/s2JfKKzXUwYpx4zkfd4JAxxLtxnnsqkSyVuwGiCgJvVVWp/4MoKxrVwZGJSdpUsk
 UGMS9igC1VpxcnvmA440EBcPaDusrUxHzkEDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715017416; x=1715622216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaGAK/C8uwztmwbwHeeFo+CKL10vshWATCP9DxdVaI4=;
 b=LjDAdfIJhqo7KQPRvCjJR0cet9HBdjNGpNxgPV0oOnHkZKcuBu1L+EWbSoxDjdiL9T
 SOdR6svT3jCbxhRuNvqXkbxq0ESl7mQboaNtU0oERH9xBlKO7exNhuCcBgSBYkx81zQ9
 gKgpvW8eSP/4kywxVtIUhhweYyzFt3nlCw0r6SvGgTMqY0HvYfC9Al+dv4t4ekXruTEO
 GXwEYa6bayxOO/iXUjTZmbYs7HKj8MWukcv5Yqtc0a9J6CucQ14HKTQqpICS1sgHhRI2
 O/X2CcAKbuJ9OrC9CphCcqChoBWvy8Z1rF9/VdD1oBIQCn4//sKJMWogjZ6TI1fgTJES
 B2oQ==
X-Gm-Message-State: AOJu0YzcNmEkyUbtVDDSCdCGcMTSvG8aeyRikT04fuKK7Z0ab2y92774
 7wrfATtZT2QCaZwzHxuVx4CMxIG5jrREl5z0+BH3TCP/o1F7J6qYYZQv+lw251w=
X-Google-Smtp-Source: AGHT+IE3Wr6OkIn3bBUqM8JRuUuqkn9tnVVZIkRKtvj6vLSWcWllX4D2hviuBZlf9Z3OhoYJcH81EA==
X-Received: by 2002:a05:6808:e86:b0:3c5:fa5c:7762 with SMTP id
 k6-20020a0568080e8600b003c5fa5c7762mr13424324oil.44.1715017416173; 
 Mon, 06 May 2024 10:43:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 dh1-20020ad458c1000000b006a137e75534sm1098538qvb.109.2024.05.06.10.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 10:43:35 -0700 (PDT)
Date: Mon, 6 May 2024 11:43:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
Message-ID: <20240506174332.GN2568172@bill-the-cat>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y/7uFK5xBHnG3PZ0"
Content-Disposition: inline
In-Reply-To: <20240505135353.1507200-1-yoann.congal@smile.fr>
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


--Y/7uFK5xBHnG3PZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:

> From: Masahiro Yamada <masahiroy@kernel.org>
>=20
> This is a cherry-pick from the kernel commit:
> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default p=
roperty, 2023-11-26)
>=20
> When a default property is missing in an int or hex symbol, it defaults
> to an empty string, which is not a valid symbol value.
>=20
> It results in an incorrect .config, and can also lead to an infinite
> loop in scripting.
>=20
> Use "0" for int and "0x0" for hex as a default value.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>=20
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> Added context that was not in the upstream commit:
> The infinite loop case happens with a configuration defined like this
> (a hex config without a valid default value):
>   config HEX_TEST
>   	hex "Hex config without default"
>=20
> And using:
>   $ make oldconfig < /dev/null
>   scripts/kconfig/conf  --oldconfig Kconfig
>   *
>   * General setup
>   *
>=20
>   Error in reading or end of file.
>=20
>   Error in reading or end of file.
>   Hex config without default (HEX_TEST) [] (NEW)
>=20
>   Error in reading or end of file.
>   Hex config without default (HEX_TEST) [] (NEW)
>   # This loops forever
>=20
> NB: Scripted config manipulation often call make with /dev/null as
> stdin (Yocto recipe, CI build, ...)
>=20
> This was discovered when working on Yocto bug:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14136

I'm surprised this was accepted. In the past I've wanted to avoid this
kind of change in Kconfig because while the empty string can be easily
be checked in the code as "user didn't really configure this, do
nothing" a value of zero is a valid option in these cases and so then in
the code we need a bool symbol to decide if the hex/int symbol is set or
not.

Today this is less of an issue than it used to be in U-Boot with
everything CONFIG-related migrated to Kconfig and so there's no longer
the question of if we missed migrating a file that defined the value but
there's still places we have in the code where hex symbol is undefined
is not the same thing as hex symbol is 0x0.

Is there a specific use case you have for this in U-Boot? It's been a
while, but it's also been cases of newly introduced symbols in Kconfig
files with incorrect dependencies, where the infinite loop in kconfig
happened, CI failed and we caught the problem.

--=20
Tom

--Y/7uFK5xBHnG3PZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY5FsEACgkQFHw5/5Y0
tyzMxAwApqtfkDEjiqvD727pkWQ3WaFmNx31OFOuTH6fbJzex5mw4+Ifo6HJSIPL
2PkBEBvpkh4NqY4veufGPabzmRGxHqST09OVE4Yi9MzPcKbkxgh4ICBbXoB9K8nb
E4NbEf/B9Q9t4CUquZ1hiEjg0b0LA6Zf+Sf+KCy/3kOs5prM0Ch8kOslKRNqP+30
QAOaJfM+BuasUxUtInaAIdWJojvOc/RUeRQGmnaLa7lSOc0f54T3df28er3ceFQR
YOY+T211Gy5zNuYcP+GCvbPWIbKjxFshi49d9QLOSaDUkyiU1rwRa2vpyYUinXJB
ckIQ6ixav3ucegsSIDY3rD9HJz+toGvFTO8AzGkhp83FcbAw/RtHfNlCFM0z5tUt
CvZOKlsVQ/Plf6VW4yNPDrCqZbf0Bjb1qWO8VEar7u5ru7vzth9wyhAJxFcVerrZ
Kr/HjfVpQpjkp5esuW5icHGHI+jPeFm+WabaV5vZYUQmCOcIR0zaE+W+KE2HHcQq
fe6KWkA7
=l486
-----END PGP SIGNATURE-----

--Y/7uFK5xBHnG3PZ0--
