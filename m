Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51C606A325
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGitcZNP;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Y4aBuMJS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6894E81467;
	Fri, 30 Oct 2026 17:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krZJbGDL_P7p; Fri, 30 Oct 2026 17:21:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A69D78146C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380918;
	b=fJ3VT1Mo5JGJV2KPfgmNsRaXeB+SfT1CHn+ZczTM2iZQ4sf0SYT0lBEvdZt5VvWNLwIO
	 1gzvdX9aJwNQjXjMDPp1sDrg1nb5gA7+RzMvUKkxG94l70760ynI6zy8CDAw9PPsT+L/d
	 1G73LAIB9jBgLUwVTUgjGGRR7SlksBqGOU8/msofw5guLSI721u6X/7xkq/ijngzQPd8E
	 DO/CDUDW8qZYP62Xx6gowKZDoKW8Czb3Z4sAp3wH4MlRwN/0SZa7aKnV3AnzL6QQyXxXw
	 fJECuqv0nsFXGqeYs4LsPJn8sRwPQi60Uy8v9zFEEUNkae1sVChTvtoIN6+XmYrGu0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qBhHwVwu4PZ8KcMvt/Hx7mR8wMapnqbrUDlaNrN+GqU=;
	b=bZ50NvPNdkyAh5pxgNE7wZYICKzUIKWWVT8il64Xkx0nysQGW6DJaDoNs66UjuqaNJeQ
	 H6WtagqrlLDYxo1zWFz06xYCJxb25ZbTmw3SNpMkaoUDU28aah+2D69eW0hTkyNUkzvz5
	 UP/tEjuIOphfhS2Ry/nQrpPt0Z764uukBIWYGfaLLfzuXKu/HrT+pmcMN6Vgc1JJhGZ/J
	 oXvnUVLxKUmlhB1wdcBmvmKp60gSxiil225zw4/6Yu2MwAzW200uPGH9/n0DFnWReGg1h
	 2CWYC8rSN+/iz9VEcmstdcq4pR27XOuIYf8ndh6a1ad9IGsRvQseADGMhOwBmvP5EPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380918;
	bh=qBhHwVwu4PZ8KcMvt/Hx7mR8wMapnqbrUDlaNrN+GqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGitcZNPQW1NDBt5hx5mXdsQBWxILoeMYy/8LesB7Hgt3JEJUdMADz7Un/n893zFP
	 eXCZtqXS4dEqDHydnuSKhKcwSi0+hKzh/hZIss5pMQoGnENLlG8r9gZtFjmgbPSmVy
	 tbR6Wzhh8vO950jbrjZPRKp99b+i715Ci8ofM8/MzPUQpI2fT7z1vxN1DXFE7oheGS
	 OAPHYTrDhZ/LFkDnZD3UisiDf7t4kR21VgIjdKCINXAsh3rZV51YHAdQawP3RCyp96
	 yybraVdA7fQEu5HfWKeA9QwKXKkPSb0AdVuSsRKX1Ep2Vl7q9yvttnc1KRuhssB/5i
	 OkpqITb57EXiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A69D78146C;
	Fri, 30 Oct 2026 17:21:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A75F2235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4CF1403EA
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsSoy5d-dkJQ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CDC38400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380917;
 b=LQrd5rqSvMgcbh+Fff7OGQcPE9p3XM+jbOI0wk8uq0m87GfUTP0RI194OmLADkMgqrYB
 El5awaCogPiOoNIVjrIlJHZOTg1uJrGUAn4iZZewu1NVJfRTKIuDQ86XdOK/uChyriSUd
 UY4JbjCXkCsQ0tazHMfgDQFARZmeh7sw09aVc8N0/D+EsdbAg8CXfibT6ky5MX40OXGNC
 Nq+6sCbETkRI5cJSQZfF4lhCL7AJpi20Q9I1aM3ObnU1ZZdin2EH97zZrH2RjqzCk50HP
 EXgniD3dXmANaI7F7oY9O55dhxxbEXUmbJObg2vspJyLZdPZMrzGubhVipwPxOlGVsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qBhHwVwu4PZ8KcMvt/Hx7mR8wMapnqbrUDlaNrN+GqU=;
 b=o7fNtEYfZ6AAE2o7iNGWn6nCkUEV8VzzC+BSm1/Yrb9obJZ+R392NuCbV5DMW0bQ0XPy
 l9siSglt49uJkq/CFFU52YOibu2EZ0MoAOYWE2qh6V5VdMNjaCrNU+JJkzz20MKoBWT3S
 3NnJ0vBUNqsTcb0cS4D/k8eAAx9SU/JCagk75iaMfnvFqqjSSeJ9FtDpipjJMz8qm2l3o
 +yUHVmLiUO7K9hugpuWkMnFHUPdc3mTetSQYNOVEgsIq3PeB/8LoZnGLdxd0vprv8OTGL
 QMrUSJwa36H2rn9OrdjoaCPld08k+FXvUD4ahguZRRhTBwk9tC+t5IhJPBr97rJ058A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y4aBuMJS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y4aBuMJS
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDC38400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:21:56 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-70b875f6f1fso860513eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793380915; x=1793985715;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qBhHwVwu4PZ8KcMvt/Hx7mR8wMapnqbrUDlaNrN+GqU=;
 b=Y4aBuMJS5EzWrXJtjuJaiVTfXzyLidv370FnFvvLx3csR+rr4i//kEay8UlSttlYuN
 3Wu0VwqF9h+OAknPR3IrRbqRKutM2GBWmrlAvAdSTgMpPu6tryJXBgwwL30/VfrRF2Gg
 s6s/cL3Wa8jy4yYVWt7M0wXeH7bBgTpH2d0SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380915; x=1793985715;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBhHwVwu4PZ8KcMvt/Hx7mR8wMapnqbrUDlaNrN+GqU=;
 b=156LyWQn9CSOqhtFZtqZIDPG5VYnR0NnyD3sSYpfOhKv6mWPhs0Dtx9/R6RQlFN3uh
 +Doa4G63DYSvmwSWW71BYGQs5kd82QvofXePwflQjkbTeq2M/K8GV3/mxhjP0V7Vja1n
 S8Vz0pkWgreSH2nGnF/EojS8288nzgwce6ICHNhJeWC0FNysBtRpDCIgpQ3n5r2Te97z
 UGkWnUizdX3w+vuRs+Qmt7A5ODdHfGHv8y322D+Y8va5S6KtEJFYkAJsjmw0ZjnbhjMy
 Re9PbGXleBjF/0jqGJ7mxJkKfdTVRhOtCnojURSktd553VWyKWJ3oHSVznXpt5kqXhAg
 4k0w==
X-Gm-Message-State: AFq9FYLbti0QxxRwe+NZBhHcOedhpM6U36Xn3gw8xWaofjGdbsTLyZ7z
 WRKpkRZ5O3rkktMnlDltoClmEXZvEdExTcc+77NlKqxYkik/Fs1k6Nnn8zLBoGtQ9Yo=
X-Gm-Gg: AYBFou2D8Z1xIQDEPLcgxe/PKQv1IZviTmQyhxkl4DiNDNLd1IutwDHTq3sc8tWmt+E
 dOsZjs8x8OxeinlOEohZxGSTTzaytUeW3f/r7/eY93K5b3mTvUSttoW9VZKu26Vgyk2rk+UGzlL
 6wtlQyhqen12j6TfVgKubdk3tTTXG46+OwiaM5vAtDTXb08VdafoCx59/zmd6eyxe1VSlHUa9Cy
 cq3OtZAcwWG10MZj3fJ+47yjbg01IDHEyokRZxxQM0riVfut8EXGh491T1bvZBerBOotVRqfWPs
 fkCNmWtp7NXoaMegV2SWkYJ5LXmZgEVGMxWY1WyESZSKLMrpl39wPB4N0OcpoWGIPQoj9ReWxPo
 ilcHF1V/OH7+0JmuKEkrdOuOhfRdxwxI5pw9TbPFs7VP9buWAC0feVTvo0p2/0SMtMaPbyUb8Qt
 mLgXnP+o5Udu5/nOJ4hkrGALD7TekczdwObNM2dnRCYMcHbB6AOqhSlQDlk9KV+qzwpkPAukde9
 JwTuyvQEL+uDzCUimUrgXQZCP16kx6k7TqwTHaAvFdN7fZ/707QvIPSWmhDmQwwO1xPeabLKCVG
 xdRT+WY6DXWC5zV0/jmH9ViDgq6kGfRTWWup2gBPJxAaGApBSwxfhArFM3vc8xK/lDAjHgaetCd
 aLYngvi6Gf0bvq9E08n8a55CoYRvzpTeKZui+xVUyfV/53IQn0dglQCHIqWy1GgIhiuieW/OjDv
 /DD+TRdHWAn2CuiSayzEpjnrb96C6Joio=
X-Received: by 2002:a05:6820:f02d:b0:70e:1dd8:66fb with SMTP id
 006d021491bc7-714f2945a3cmr1906706eaf.30.1793380915441; 
 Fri, 30 Oct 2026 10:21:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f3081097sm2293552eaf.13.2026.10.30.10.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:21:54 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:21:52 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?WWFsw6fEsW4=?= Can <ylcncn@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] console: allocate the device list when
 SYS_CONSOLE_IS_IN_ENV is off
Message-ID: <20261030172152.GE3309461@bill-the-cat>
References: <20261030073655.164481-1-ylcncn@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="myOjU04OCjlxl2yG"
Content-Disposition: inline
In-Reply-To: <20261030073655.164481-1-ylcncn@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--myOjU04OCjlxl2yG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:36:55AM +0300, Yal=C3=A7=C4=B1n Can wrote:

> With CONSOLE_MUX but without SYS_CONSOLE_IS_IN_ENV, console_init_r() calls
> console_devices_set() before anything has allocated console_devices[file]
> (only iomux_doenv() does). The stdout device pointer is then written to
> address 0 and read back from there by console_puts_select().
>=20
> That goes unnoticed while address 0 is RAM. On the RK3066 started from
> the boot ROM, address 0 is the ROM (GRF soc_remap =3D 0): the write is
> lost and the console calls ROM words as a stdio_dev, hanging in
> console_announce_r().
>=20
> Allocate the one-entry list when it is missing.
>=20
> Tested on an MK808B (RK3066) with U-Boot started from the NAND ID blocks:
> boots to autoboot with the USB ACM console; before, it hung at the banner.
>=20
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com>

Thank you for disclosing that you used AI here. As a project, we
generally discourage its use.

> ---
>  common/console.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/common/console.c b/common/console.c
> index 54d12494..b436868f 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -248,6 +248,19 @@ int cd_count[MAX_FILES];
> =20
>  static void console_devices_set(int file, struct stdio_dev *dev)
>  {
> +	/*
> +	 * Only iomux_doenv() allocates the device list. Without SYS_CONSOLE_IS=
_IN_ENV,
> +	 * console_init_r() gets here first and the list is still NULL: the dev=
ice went to address 0
> +	 * and was read back from there. That only works while 0 is RAM (MK808B=
: after the vendor
> +	 * loader's soc_remap); from the boot ROM, 0 is the ROM and the console=
 calls garbage.
> +	 */
> +	if (!console_devices[file]) {
> +		console_devices[file] =3D calloc(1, sizeof(struct stdio_dev *));
> +		if (!console_devices[file]) {
> +			cd_count[file] =3D 0;
> +			return;
> +		}
> +	}
>  	console_devices[file][0] =3D dev;
>  	cd_count[file] =3D 1;
>  }

How you found the issue is interesting. But we support plenty of
platforms already where 0x0 is not valid memory. So this is one of those
cases where it's impossible to know, without someone spending time to
verify the details, if what Claude deduced makes any sense, or not, if
this is the right fix.

--=20
Tom

--myOjU04OCjlxl2yG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTSLQAKCRAr4qD1Cr/k
CpF5AP9eWDTirhvHWeclVE/diBPTzB3ReVf5ftfBUTvSgk39CAD8DGrrIKgAD8fB
gWSiS+S1k8gXyXmQ3RfVvdz6yvBFpAw=
=nnK1
-----END PGP SIGNATURE-----

--myOjU04OCjlxl2yG--
