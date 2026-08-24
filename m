Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA184C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7AAD80E2C;
	Mon, 24 Aug 2026 16:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-2vYJs4fxgt; Mon, 24 Aug 2026 16:51:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787590292;
	bh=gDcUfu6CDtAi3d9/LAmG3ycKvQxEl75TPIzaE4gWETY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r6p92kwsUm80Zvh1pg+TI6d9tskOMwKp4N7ta3OOqzj2WBKq3ZqQNXeJb5ubY1YV5
	 Fc2jfFMyGbX6+1g0+I3JJU6tmcrv+SKs4ekmLCl9eL4S3HvJr4Izj690eGd1OawOzL
	 6n8jIjM7Ar91QBjoAmcXQ8sBTwzjEpWw5F+fzf2nUyiaKUe/vJHMPpQGXczcN7klMV
	 7Fk+/EdrS1rb55I1evXq8qBJFkHDa2DrTMHd6Juzs1vI2UP2XPlFWvrP94mjWeBPvh
	 Qnq70h5v2a5ajU1L5mX8dK3dX8sxCMzZDerrC5wb0Dnp958j9B14cEXvg7Ak+PLQoU
	 92x9r8vozO7Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16A3A80CDF;
	Mon, 24 Aug 2026 16:51:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FABD118
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9ACA4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g84brJRpyVXk for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:51:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EGZW0rj8
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1045240029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:51:29 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-45ef699308eso1943038fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787590288; x=1788195088;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDcUfu6CDtAi3d9/LAmG3ycKvQxEl75TPIzaE4gWETY=;
 b=EGZW0rj85bwHC8IKhGE25yDMNqEV99+fD9lRQQGovZiq0XqyqAjYPSR+MLPUt6ZZcZ
 2NXxtxNF1oCAraVRm6LcVOoRmHju7+G+3HsgFEpt+OvNne5MRiRLl2PHFkPL6jwbKRGh
 IwSliJa9a0GXjvVo2ETGpaqjDcir/gYcGNtLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590288; x=1788195088;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDcUfu6CDtAi3d9/LAmG3ycKvQxEl75TPIzaE4gWETY=;
 b=qZvJ52Bvo8uTNcGbEKA7WsAZW+gC9k6/hY5w3cgPqsUr++iGx26mie7Pi2xSUOg7V+
 RwFbQ423+iN+YPIGRrxYeki5P+W89XmStTm6tUPe8msb8s/QtNIALxfTH2sjyyVabT57
 /xh3CoTnuOYt4upohGV7jkxyh97XejnByd0xrmWlkXnmMf/7cPIB9796wjQlGhVNVvmq
 He/3bXFmG8f2nIHFCIHm0xnHIDbzGsGlqiCOQYtvtt7Y5yOEKhPddGHiBwf0RtXFptHO
 2Y66HHFa+LuP+MrbFMizE4788hAyH3hZytZTt/kwBmsC+odkWPpuCLcD6k23ooGuQyfZ
 DuHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY+Jg6HY4NjVM1ey6qswTlnYAUox0go9MvDq6z2jiTdD4m6hOJQjbDggFSgSL+1kXC2hT+/n4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lWi1q8VgTUpaDqMcuQglZKmFPSzOZBJUHIRtLpbjzQsRafZ9Fb
 /ADQEE55HNd8fTBsVgKKHLoTwRnyFe/VEg/zromiQuxrDKEpdCG4DwHd1iNPYeXC4QU=
X-Gm-Gg: AR+sD12wFLVDBoP1JS9O455AZmiEm9OX3YTKoPiMYsBPabq88thaui2OZ9oOz6ZLJok
 BhVMmVNQX9c8dMZctVXgiGUpQkYROlHWtSm18OoYuj2BnCKVJOeXvA20I2eYfvYfnEyMv6jZhOd
 TG9QhTsPHcH0bDKTPQJJQjwdVNhMMCNloqyCc1zYuIe4mk9oUe/5YW2JzvFRt0f1f1t3lGGMu0d
 CJHo0ipVR3fd8hG12P1KjWlEtNFh/z+6QPgyhY6SoAl1zjbjIP7i0pp4m68dw354/eGGCGTnQYP
 vwBphvwwFANO0N6LHX9yRbmzLN7zT4fqgOOcB8tLuXQdLHjxdffm0eehP4SnrfarLYyLXUbS3II
 4adyccg7lrfsdlXWPWO7vUe9Dzc6fQn9GHHCM8u70dehoonQ5wW+XwDVnpiJk4n3VEZxER6FDEZ
 nOZzUUtx8eK/zJI27Qcsdv6iNs0HtCM6HS317HHBMVAEKcSj4voeOLoAkXDpIGfdymyMUtbu9lS
 qVUJvcUhldao5QZ+tqB3NYkAENBYXIVzTbOzOUn2ZL0Z/UbgSPztHNmF4v0wafhH9+eUdLJq/Hl
 paRhAh65gQ==
X-Received: by 2002:a05:6870:31a4:b0:456:cdf2:ae66 with SMTP id
 586e51a60fabf-463516311d1mr28175793fac.20.1787590288471; 
 Mon, 24 Aug 2026 09:51:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463834af0absm5744724fac.12.2026.08.24.09.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:51:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:51:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org, git@amd.com,
 padmarao.begari@amd.com, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20260824165125.GI523975@bill-the-cat>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <20260824150937.GD523975@bill-the-cat>
 <2c9ac202-68a7-4017-a8f9-91e9b3579166@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yXdCtFYMw87KVvN+"
Content-Disposition: inline
In-Reply-To: <2c9ac202-68a7-4017-a8f9-91e9b3579166@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--yXdCtFYMw87KVvN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 05:29:37PM +0200, Michal Simek wrote:
>=20
>=20
> On 8/24/26 17:09, Tom Rini wrote:
> > On Mon, Aug 24, 2026 at 10:17:18AM +0530, Suraj Kakade wrote:
> >=20
> > > cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> > > path) in the HOSTCC command. With a long $(srctree) that command is
> > > too large for /bin/sh -c and Make fails with "Argument list too
> > > long" while building a .dtb.
> > >=20
> > > Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> > > HOSTCC/CPP so the shell command stays short.
> > >=20
> > > This change requires GNU Make >=3D 4.0, since $(file ...) is not
> > > supported by Make 3.x.
> > >=20
> > > Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with C=
ONFIG_OF_UPSTREAM")
> > > Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
> > > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> >=20
> > The linux kernel, and so Kbuild, says that 4.0 is the minimum version of
> > GNU make required, so that is true for us as well, so this is fine.
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
>=20
> We should likely fix this too.
>=20
>   94 # If the user is running make -s (silent mode), suppress echoing of
>   95 # commands
>   96 ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
>   97 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
>   98   quiet=3Dsilent_
>   99 endif
>  100 else                                    # make-3.8x
>  101 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
>  102   quiet=3Dsilent_
>  103 endif
>  104 endif

I think this means we should pull commit
5f99665ee8f4335f334a5292b6d5b41a577fc2c0 from the kernel in, to fully
switch to 4.0 as minimum.

--=20
Tom

--yXdCtFYMw87KVvN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaox2iQAKCRAr4qD1Cr/k
Cs5pAQDGKapNB2X/fgl5jUduwDJeGUAhFBJ5DzK8j4cyeeSyQAEA6BCFdzD0thG8
1hWnmhoasDX49mb7QORRBtyp9jTrGwY=
=iWbx
-----END PGP SIGNATURE-----

--yXdCtFYMw87KVvN+--
