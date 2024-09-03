Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442E0CD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 19:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625D288606;
	Tue,  3 Sep 2024 21:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JJGO5+g5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA4688606; Tue,  3 Sep 2024 21:14:29 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033AE831A1
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 21:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c3551ce5c9so29592066d6.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725390866; x=1725995666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oOyVpepvEZAo7+TDvwOwga5zC1PMUvCP4vYFEmJLyZI=;
 b=JJGO5+g5xJcUwkiZLxtHFUrI0pOOcRU8b8ieYSexjCAZs3MilJRpF0u0DKdUHcd1/a
 QAy/4c/9lQOHc89p9oakn1nU/i/fMZxkYZq6yOB9obIA596MMiMyyX9HAZ2OGNHWvQwS
 41JBUMVhF/WuSJznFkKYUCtEP21ZJmbMuzYWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725390866; x=1725995666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOyVpepvEZAo7+TDvwOwga5zC1PMUvCP4vYFEmJLyZI=;
 b=amoY7BdbYaBXcBrp/+UPzv1SC5WSMLXgODt+5E4vihxhXfsiDEKDrj2FpdA69rbk4s
 7e4qQjl+7ZJtwEm0aZKUnQ5uxQ1SiviuEVp6j1cVo9PxDyvi465FLwRv0hcZTQaN68T5
 b41s64WVhAtgT8PLsTpqo0Tp0iC3h4q9GyHITbGfGn+1ZD2E3H7IXa972xJmvKzb00CT
 E4EhUE++6dPTMtysU/USNb1T96C5NRChOP3RYcZNmHDdgKg1guwQI2uXEtUnWud6MHBp
 CeFlrmKB5GK+SsefY7C/8hqgz+YsPBj6bfb1CGAsE3lU07PBxm98lMQ8CibjmJ+lxpEA
 Yg4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhvw1a5TL9V7NU0/ZGBaJnoKD0eSKcxY6CdScHqCl5+YSGQxysPJApfFNOWlBinaxWeP+ibfg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywim5y2p9tKmIlZGKgsgKxbis7KY/JiuBIx53M0xKKEEJhoeh6d
 o2oOF0kx07LCYhL7cnj6ZI9L4tlITjHTAbRJZgrEFm3w3IxiUN0Oed2ekWO9+Pg=
X-Google-Smtp-Source: AGHT+IHvXJYSMX6k+vx7OexnIv75U/qKOFn6wzFmvwbxpQh8tHsroyYyp62kSfF83w+J7jPEf5BvVw==
X-Received: by 2002:a05:6214:88:b0:6c3:5338:9116 with SMTP id
 6a1803df08f44-6c3533891a2mr184799866d6.23.1725390865700; 
 Tue, 03 Sep 2024 12:14:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c002f9sm56586076d6.45.2024.09.03.12.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 12:14:25 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:14:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
Message-ID: <20240903191422.GM2479150@bill-the-cat>
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JuKXps0dhZ+BdqiF"
Content-Disposition: inline
In-Reply-To: <20240831164639.2298097-1-caleb.connolly@linaro.org>
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


--JuKXps0dhZ+BdqiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 05:46:19PM +0100, Caleb Connolly wrote:

> When using the FDT command to inspect an arbitrary FDT in memory, it
> will always be necessary to explicitly set the FDT address. However it
> is also quite likely that the command is being used to inspect U-Boot's
> own FDT. Simplify that common workflow of running "fdt addr -c" to get
> the control address and set it by just making $fdtcontroladdr the
> default FDT if there isn't one.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  cmd/fdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/cmd/fdt.c b/cmd/fdt.c
> index d16b141ce32d..8909706e2483 100644
> --- a/cmd/fdt.c
> +++ b/cmd/fdt.c
> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, i=
nt argc, char *const argv[])
> =20
>  		return CMD_RET_SUCCESS;
>  	}
> =20
> +	/* Try using U-Boot's FDT by default */
> +	if (!working_fdt) {
> +		struct fdt_header *addr;
> +
> +		addr =3D (void *)env_get_hex("fdtcontroladdr", 0);
> +		if (addr && fdt_check_header(&addr))
> +			set_working_fdt_addr((phys_addr_t)addr);
> +	}
> +
>  	if (!working_fdt) {
>  		puts("No FDT memory address configured. Please configure\n"
>  		     "the FDT address via \"fdt addr <address>\" command.\n"
>  		     "Aborting!\n");

Setting aside the behavior change (which I am thinking about), this
makes the next check of !working_fdt dead code which should be removed.

--=20
Tom

--JuKXps0dhZ+BdqiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXYAoACgkQFHw5/5Y0
tyzZNgv+OkBWFjCKmOLwKhSiDi3RdJdoveKEILx3UnKtnjXTgCuNEvKu0mIEg/3j
n1obNFJNeC+WsC0EJCs6gqYtCAvmoAgb0VfQRbFOPWbrlDqcjXca8ArsHqVYmx3K
QGN4EkPJYD1OmMpFnOIF5dTncdJmlP/j146WD4Ltc080nDsf/d/ov/sTWs++xvWJ
8P4wBraeGUcl28LotTVJ1DKkO9oAmErW4oSFzvPFqNg3NAvWT5QEdx/8Yz+ioiMv
nEjAsInpoYM1KoAsTXCONoD+nZSWl4Uz7VRHG/CJznRpMAIctmQ9ZvR/63Zl/YLP
l6MFz9p/vysZk8g16w8dk1n9bJ+StvQIT7DtrYGDucgFTKrsgxDAMBpwPeb3vran
lo/RFg2KVnaKeiSP5zLFSf7g/OG2RET4uh2bMhUpPrIQAoN4xQxJNCxPERc/Ac72
0D8N3EZkCU+I3IXGDBrWqkrc2VQUQnmsfdZqqpjV4VqE2p0SuX7BykURvOq5BgUl
d30Bp+kj
=/tnI
-----END PGP SIGNATURE-----

--JuKXps0dhZ+BdqiF--
