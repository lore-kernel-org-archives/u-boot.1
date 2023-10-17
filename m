Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE44CDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 16:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6942886CB1;
	Tue, 17 Oct 2023 18:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n72G8a89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1646B86EE2; Tue, 17 Oct 2023 18:35:54 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BCF86489
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 18:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7dd65052aso80308847b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697560550; x=1698165350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QN7MvF748DTi0mGFB/Xi/0kWzkxagwrA7OqS6IJG3/M=;
 b=n72G8a89X0QLoZBUUGKiBPISa0dzy02r/kfNc/Ze0vLB4CtM2g/0SQpVDYFzeYrxYA
 s8pW7bm7w1vU1BFa5Zas3mzYAMZ7tNAi7BxqWTSyGPUnn8OH54YGzzP53KPbDJH15+Ah
 8iGhEjzYSs5apziT7MO+xotizbkGGoEuZOdWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697560550; x=1698165350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QN7MvF748DTi0mGFB/Xi/0kWzkxagwrA7OqS6IJG3/M=;
 b=m4EyNpKJdsYggoYWZCSmtm1ZeD/gGCBf/ACP/woYz6S4kZ3Ccghu+GnPoBQVEBel0N
 w6Br5XWLm6yq0ykyRr3kKYZ6guQdfgx36EDxmJwyhF+GXUqZeJA78Esx2zwP9aPgvgDD
 1hWC2efNalRluQQ25OUBGmQJeQh0RezjpbO7YAiUOIjEgupij6XLBgOvo6lhW6geA529
 IGciDSDWC7BuKNW0ZiCW5jySxWjdeksWYZXZ7dbnDeEaZVI9838YX4lvVTb24zy245kH
 vgCnJ5AqYChlOJPX67XMTlrkEBOiQb3e+V20ygFUFPltJKJbEvGfq7mcAIR0IdvP6fsu
 tO9w==
X-Gm-Message-State: AOJu0YwxShueJi9Jb4+D3/R+4medPav0fWx0TrTFPl6rpXyNZIdrLKek
 rYL2lDL4dR+1Wl0EwHa/Ru3zpQ==
X-Google-Smtp-Source: AGHT+IH1wlg3jazm1m7UaCP6QcHgNrDjBxqF188HUbtsz3KiDcr7pSXGXtlR7W5abbJeG+A2FtKhLg==
X-Received: by 2002:a81:8384:0:b0:5a7:bd2b:d4ec with SMTP id
 t126-20020a818384000000b005a7bd2bd4ecmr3268871ywf.3.1697560550142; 
 Tue, 17 Oct 2023 09:35:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v186-20020a0dd3c3000000b0057736c436f1sm727149ywd.141.2023.10.17.09.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 09:35:49 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:35:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Piotr Kubik <piotr.kubik@iopsys.eu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] bootm: Fix flags used for bootargs string substitution
Message-ID: <20231017163547.GL3119521@bill-the-cat>
References: <20231017105305.417338-1-piotr.kubik@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gyx/G194tVhAADrw"
Content-Disposition: inline
In-Reply-To: <20231017105305.417338-1-piotr.kubik@iopsys.eu>
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


--Gyx/G194tVhAADrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 12:53:05PM +0200, Piotr Kubik wrote:

> Commit <51bb33846ad2> introduced a feature of bootargs

Checkpatch will complain that this should be:
In commit 51bb33846ad2 ("bootm: Support string substitution in
bootargs")
And this is the kind of thing I would fixup on applying if there was no
other feedback.  However:

> string substitution and changed a flag used in
> bootm_process_cmdline_env() call to be either true or false.
> With this flag value, condition in bootm_process_cmdline()
> `if (flags & BOOTM_CL_SUBST)` is never true
> and process_subst() is never called.
>=20
> Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
> ---
>  boot/bootm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 8f96a80d42..e96489e549 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -778,7 +778,8 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, =
int argc,
>  	if (!ret && (states & BOOTM_STATE_OS_BD_T))
>  		ret =3D boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
>  	if (!ret && (states & BOOTM_STATE_OS_PREP)) {
> -		ret =3D bootm_process_cmdline_env(images->os.os =3D=3D IH_OS_LINUX);
> +		ret =3D bootm_process_cmdline_env(images->os.os =3D=3D IH_OS_LINUX ?
> +										BOOTM_CL_ALL : 0);

This gets hard to read. I would prefer a comment and something like:
int flags =3D 0;
if (images->os.os =3D=3D IH_OS_LINUX)
  flags =3D BOOTM_CL_ALL;
ret =3D bootm_process_cmdline_env(flags);

As the compiler should be just as smart, and that'll be clear about
what's going on.  Thanks.

--=20
Tom

--Gyx/G194tVhAADrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUut+AACgkQFHw5/5Y0
tyy53Av/Q2NzPN55+etA0EnqRypD9KVH3O0FJQ03SqwFE+ntXJzjdUVtaRlKR9wj
K0FWvoiXNwluQ5IIOriSjUcnZ5/b0yA8Yn5cDNmY/Kn9Oc/dmxZuFNUqiDrRq9Jp
gvALFUKZKnBjMPuoGq4TKwPqPGQ7h+I6YhjjWiBcD1RqnkLJsxPH1U/gAVAh+O9A
6JpphcMVIzHjQKcRVEsLl5XuzZ4VAh9uAdH5zpaKsE2qc6jdKCLW2+UmegVqoJGT
Gzr9TsdO7I150/YwRZ85asRiqoMMWFdwslCIN+7THg1flBEtKNTU9qjR2dswFjtZ
pO6ADdjRVwTQZt0+drjZ6A+GixGQuPx05zzxrYvxQYdI1miVee5oIqWuU4+Aoplr
rTjKVwsiAsPU0Jzuo1xpeRe3BhdTgY1DPLLA/1hfvB4O+D963JnOpdMsQrPZOEA3
H4Pk5LrActWEjgF/vt2lBPJpjeT5sz+EAuxs1cR0N1ab1oU2aqTyt1pYyISCr0S6
4k/D2CB4
=OD1y
-----END PGP SIGNATURE-----

--Gyx/G194tVhAADrw--
