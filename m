Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CEDC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88FCB87AAA;
	Thu, 14 Dec 2023 18:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="epA7Kmfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEB987AAA; Thu, 14 Dec 2023 18:51:14 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D13487AA4
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so84069707b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576269; x=1703181069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qZBxe8P3VI+qZmltexnVjw4l0ApAizUvMwAbj3DnrnY=;
 b=epA7Kmfo/81SwQINk1uVf0d0WYmE/T0mXTy6mKa+hyLls8y28P3KrjbJXEoiLqivU4
 5hNtFg5bu28Qierp+UsZS9xtZ0OK2enak6KByZbj9AnpWW7hmrgqfogBY214UJI9V4F4
 LZJjROEYdplbM0UKx9OkkNULPGzCj6XbeOrXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576269; x=1703181069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZBxe8P3VI+qZmltexnVjw4l0ApAizUvMwAbj3DnrnY=;
 b=c+WkphULnPypkSeQamrF4xM5h1G5hAI/KTXNjZ3/S9fZZYaVrh8Gz43ddOfuPh+9Oe
 5cN+lF6h1Zgn9CYzQndNkxcqLVfbgVGlkbpkQqJ1O2tX7JMNjdV81mylTjuRhlDuSCbV
 JmIah1iYTILYsBnSq/xaF3fnPCWksrkSAGljkIx7eukhz7fDfatylJ+18tNgszqbPJM9
 9TNylW/SArm2ZFc4+dF5Zni/7MORZtJZHwfX4k4Z7BYa1IJwhQPGGnoY7AB1QJOR++C4
 lP0MToUCMnLUXSLDMgtp35Uj0SzLIa5qSXm67UIQTTrxKPMG4IkHlWKoNrofT/C9Bsdx
 +Rlw==
X-Gm-Message-State: AOJu0YyW4CBKZVkHQsy2lMzd1sZVTJqGef3MPHfgSv5xrK6UDFefR/Tp
 n8+wd4gRhZVIVXu9iZSfEbn4BA==
X-Google-Smtp-Source: AGHT+IFRCVdmfyJU+YTt7+D/SrrUEDAPtJ/9n0+QDIVEnL/7SAYgZ1V8oPYz/5OPI26/lH+O27ZTfQ==
X-Received: by 2002:a81:8306:0:b0:5e3:25e3:f92f with SMTP id
 t6-20020a818306000000b005e325e3f92fmr1970838ywf.29.1702576269421; 
 Thu, 14 Dec 2023 09:51:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 b80-20020a0dd953000000b005e2ca09e751sm1479470ywe.110.2023.12.14.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:08 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 08/21] bootm: Create a struct for argument information
Message-ID: <20231214175107.GC2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KOhw8t6hDNjCG+L4"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-4-sjg@chromium.org>
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


--KOhw8t6hDNjCG+L4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:17AM -0700, Simon Glass wrote:

> Some OS functions require the arguments to the 'bootm' command. This is
> inconvenient for two reasons.
>=20
> Firstly, there may not be any actual command, if CMDLINE is not enabled
> and programmatic boot is being used.
>=20
> Secondly, most functions don't require the arguments, so it is
> inefficient to pass them when not needed. For example it increases code
> size.
>=20
> Create a new struct which holds the arguments, which can be used if
> needed.
>=20
> Add the images pointer as well, since this is commonly needed.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -39,7 +53,7 @@ typedef int boot_os_fn(int flag, int argc, char *const =
argv[],
>  extern boot_os_fn do_bootm_linux;
>  extern boot_os_fn do_bootm_vxworks;
> =20
> -int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const ar=
gv[]);
> +int do_bootelf(struct cmd_tbl *cmdtp, int fglag, int argc, char *const a=
rgv[]);

Typo, can just drop when applying if there's no v3.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KOhw8t6hDNjCG+L4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QIcACgkQFHw5/5Y0
tyypFQwAgL7kmmInVURfteXFo8/clauaESNpIsYl7ONmyJL/IQsUxz2NCuR37AS0
tUYSvTxMfchQJAFH0b8N0H5xvCDELGWUaeXSm6I9S6Zm50l5HzplorCfg28Gbjvu
vL36vzZfblbmyf5YGAEwdjJ3TFB2B/yf9PNHj8nHXWJ06xnynnjTHXDG7+D58FO8
k08R7dW8RXh1/ErHxcll8qc3zkmCHgW/3OWHvdBH3pgIYW18SRAayzN7Sc3d3TT7
5oZdLA2cYS2qeluB5GIOxfYkGV4UiYlAIC9Eq+BkL5G12TuWlz8x2JPHq6FYfCaQ
8LVCSNfCXCrfmjA9UD9SAl1fMGImcOibUKl/vgWViI+iqf/B54PNkGoEFdlctUyD
vAuiFXHT/DHxeM7iwwv1/e7itmtO8034lphM6UT+vZK66JIX5rCbfeHxs5b1Y9Lo
pdXY61S0Vq6P04vbYOTfyffLzaaBEWUy7/BYHC2cApprUQP58deVJ1FtDguawcM7
bRnolV2n
=3bsX
-----END PGP SIGNATURE-----

--KOhw8t6hDNjCG+L4--
