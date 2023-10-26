Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D024C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32EE878FC;
	Thu, 26 Oct 2023 14:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n7VKIKhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C512C875F9; Thu, 26 Oct 2023 14:47:44 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9578A874FA
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-778a108ae49so158083185a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698324460; x=1698929260; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l7Y1dDjDFOEZGBGuKuHTsyOD+5g7GbIyMHBi8AWkbbI=;
 b=n7VKIKhujwm+Dvw1ZeAu8Ga5hw9p85rVBJzg6kdU92Ix748LYPVg7fccwGM/qVsntX
 HJXtTbNjmpZZ89DVvgNyKLOTOQhWJn1t3lMHrFC9hrLzeVsAOYjA5dbl3vAppmeU78Wh
 j+/2qv6F9OX/2doZGZEtv5CFnF6XEK4S6uD6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324460; x=1698929260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7Y1dDjDFOEZGBGuKuHTsyOD+5g7GbIyMHBi8AWkbbI=;
 b=PklWHVKJSOQy8LAEedmw1bvlAshQV/e5ZZPYX8huOj22AQuKU5s8bk5MTpUJp/6BFM
 QMwMODJhArxvGyAxMz6Lzx30iePElAjM/E8ALW8Uu3tQtUaRrFFGywKSoYjE+eU4Ex4O
 pZHfFiRahnq4v0MPqty5fWOve+GS/BjMk0sxbF/Z7B3DIbpuViiHi7v2s6jIf34vCnWI
 k43tQCWS/+d+P27nQArfhsd64i63u2qGp2nelAGQ+l5nHEJVN2QGihDk22gv2dYGOzpK
 M0E2flYJXRhKXpp/1QAHBr9Oy0qI8eXDB+/eXf60wXnLJA4V+ujjqOYS3+3JjfAeTLKo
 zi9A==
X-Gm-Message-State: AOJu0YyVOmSEozEkiw6FjrDAcB86qCPX9TR+7bjgu6BmTf2qINf0agfJ
 N37QDPNexQJQwQgrUGNZAtbBnA==
X-Google-Smtp-Source: AGHT+IEXoVHCbKvGva1h1pgvUVRF3M5SUT4tyxn+udzGZJ5C/1IY565fnbID63tShIZi5cyaSYDytQ==
X-Received: by 2002:ad4:5589:0:b0:66d:6a92:16c2 with SMTP id
 f9-20020ad45589000000b0066d6a9216c2mr3073843qvx.8.1698324460060; 
 Thu, 26 Oct 2023 05:47:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 qp8-20020a05620a388800b0077423f849c3sm4984200qkn.24.2023.10.26.05.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:47:39 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:37 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 12/13] lib: uuid: move CONFIG_RANDOM_UUID
Message-ID: <20231026124737.GC496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-13-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oXUj3gS8ffBi/hH+"
Content-Disposition: inline
In-Reply-To: <20231026053052.622453-13-takahiro.akashi@linaro.org>
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


--oXUj3gS8ffBi/hH+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:30:51PM +0900, AKASHI Takahiro wrote:

> This option is independent from any commands and should be managed
> under lib. For instance, drivers/block/rkmtd.c is a user.
>=20
> It would be better to remove this configuration.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oXUj3gS8ffBi/hH+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6X+YACgkQFHw5/5Y0
tyxjOgv8CdFmeLJrMCPoGwYn9Iaobh76pziFOtR2hWwbAskzaElYsGT7+pMtefNU
gJHh4qSFsc8RelmtxZyFsww+VUrKnDV/CoBHziXu0Zm7NQ++Iuby9fzULGu689OP
mtSCuVNJ9myzgvgjMp+BKV/OpOQApmH4eRJU4RbZt8e+IrV1k1MimdiPOM0V2bKG
ILfZIHrfB7jw3b5VVwlT42yaDgHgKZqFx3S5LUZX9omE93a4aXUDqmOGUne8biyb
O0jE9NDEPwVmvYehOueX3AZFpmOSfSStwV8YSAw2K2BlcdH/Zxx0N4QE3bPBR4jo
l5QuYxv2SFHlJjw7ZZBUKRtbiIE7vVxCkukaRZ17+GQ4bCMpBIiCWTMRsjJE5J3A
uMpcxa0h7Y6nAg3enxDEyXBg1rhDhR3lDqoTEhDUELNZdlWHiqrspnLV+HVcjjWH
uYF1Gqlxa7UcaHbwA5P3gJP0PWz6c+XjUofMUdJU2Vr7NRPlbB69Ovj1JcAVkgCx
SOlTrBdj
=UBFe
-----END PGP SIGNATURE-----

--oXUj3gS8ffBi/hH+--
