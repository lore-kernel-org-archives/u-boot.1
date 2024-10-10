Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D819CFC5EB
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8239E88C98;
	Thu, 10 Oct 2024 19:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r794cwL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A5988CF1; Thu, 10 Oct 2024 19:58:32 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D3488C7E
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7afcf0625a9so109015985a.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728583109; x=1729187909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EV/c7BhCsJwAFKtdJ5wNzoqLM0J9LAM77bNKQpMZsIs=;
 b=r794cwL7t3IJ+fti1G17fQQaSf1GOBsx3LMQVhs8E+qVzYpjdcqVMr8byLIeczj1M6
 a3Mve27/IgVIxZqPCwVPXhaOK2vfVc3kuMAM1MBFDnkGXGieZsjay7cDbNR/u/fqoasA
 aYxDk1K3romHQ8blM4112VoHPFb/jbZbV0/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728583109; x=1729187909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV/c7BhCsJwAFKtdJ5wNzoqLM0J9LAM77bNKQpMZsIs=;
 b=vfSHppX8W7rCCSAJRDynfRLFItgdyi7K5xxhX0yqhugsSlBFajpPvzop1OiwWc+UVx
 UXE0+PBJIcAkgAUFVF28QWlRIqW5wLr2gyQKAQ0bFff20uPKg5Qfyq0N57EnRcww7mgx
 JEp6QPFJNFFslrDTOkGSpSJmXZFAdMs2oGsaJLa0DIj5iKtf4LzwYMj8rfBiWrqyz0AR
 gCfqwTzyO0BinrBUE7a9+SiD/z1NHIDmlKxMONjaYpSOinVxiUDlZwIwj8EKxJTR6GzQ
 D75y2Nr3fzuc2CvjgV1X9l9ujK5yYPST6MOPpR8S6bOi2EcE/JUTTlIuA9sVjm/UtJHg
 qjfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGxkI5Y6GvdyX74b+U6xiUEwabsd9ELARfRAd1ZqihQW5nem85+yTi95mR1eXEhXrq2xCamF0=@lists.denx.de
X-Gm-Message-State: AOJu0YzvaQbJ8dEzLD55R0+Tuay2XwJgu3JiJNFk1/H7NhnqfV466buv
 nJipr3LFzYLaFN721Cl09f5b5dV9DE5n/X08Z93h1ch92f3rHFRhcMqdE+ozFQU=
X-Google-Smtp-Source: AGHT+IFgxI2uKSBHDI/hQKYkRhgNxY6VhT/NCBKbnou7itQ3g0EtBD/27ggLyDajjoo+6qkmyT4N/Q==
X-Received: by 2002:a05:620a:178e:b0:7af:ce93:1fc8 with SMTP id
 af79cd13be357-7b11a36508emr658485a.7.1728583109506; 
 Thu, 10 Oct 2024 10:58:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148de1f4sm64248485a.53.2024.10.10.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:58:28 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:58:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, devarsht@ti.com, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] boardf: Modify DRAM message
Message-ID: <20241010175825.GP14210@bill-the-cat>
References: <20241010070909.288313-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+MyGTR8sGejrncDF"
Content-Disposition: inline
In-Reply-To: <20241010070909.288313-1-n-francis@ti.com>
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


--+MyGTR8sGejrncDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:39:09PM +0530, Neha Malcom Francis wrote:

> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
> modify the message to show exactly what is meant:
>=20
> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/board_f.c b/common/board_f.c
> index 154675d0e40..b7add8f7d3d 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -254,7 +254,7 @@ static int show_dram_config(void)
> =20
>  	print_size(gd->ram_size, "");
>  	if (!sizes_near(gd->ram_size, size)) {
> -		printf(" (effective ");
> +		printf(" (available for U-Boot out of total ");
>  		print_size(size, ")");
>  	}
>  	board_add_ram_info(0);

We're growing a constant string in every build here. I would rather see=20
doc/develop/memory.rst start to get updated to spell out that when we
print "effective" here it's because we do not have the full 64bit
address space available, only 2GiB.

--=20
Tom

--+MyGTR8sGejrncDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIFbsACgkQFHw5/5Y0
tyx86wwAmAiNflQGopIKKy7bUSJdBaSm6KoqhL9Bt0mvCnhz+3r466Au4Px4zL9O
qQ0PRw351VqseCPhMck+tCuO1J0Aq4yd2iUQcBwqezFvtnQnZElcgCa+UvgVD/CP
kwZPXG1j6huigO9/qb618KQCGtcKGJl82pgIVbhgKY5w+77WrbWuyaTkyVPGX+Qv
2HlQGHzXC3j1ckA/sBomxmRjBHy8eRRtLhvw8rl6lP/Qk1thufxcKBsE2kFPMKBV
FiImRke6BJD0Dcl5M1nVQUCktbY/pR2jMHxNwpOrgv/Ygcv/4FkvyuMw64bH7GjI
TrVops+lqbpJ8nyD6hGQZrJVBpewrWnBYrWhGKiheBY2NPknel9hNygJEW0oOsc3
uKXY82DARtvDI93t1jifJ50XafXChugMawHsXp+crepjqadp96pVR0UYSdQg/JIu
YXw8xMwhs0fFeiNZIp74D6S73U7W9vYZx4LzI0oRrOgeVeDTvAKcu5NC0XL1WO1t
YANBsdnq
=h2Qn
-----END PGP SIGNATURE-----

--+MyGTR8sGejrncDF--
