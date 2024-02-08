Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACEFC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DD587DDD;
	Thu,  8 Feb 2024 22:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nNQsDxqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73287E34; Thu,  8 Feb 2024 22:40:55 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB0387CCF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-60491cb9571so4173007b3.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707428451; x=1708033251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rO8F7dmO+ZHd2XzR0sR22Zih36cYITrLCgrlSWU0FdY=;
 b=nNQsDxqS26EmKs/Wto3Jjx/DqaThEnIYf1T/UP+JCLZYSxCdbuRXOpeQaMtCBo11p4
 7vIadkos+hpk0MORazIqzEW6rqutrNxZCzeq4K5i/AGQpzxbTKAuEfYPKZnyy+DlxBP3
 yJTNf+sJP5TJ9sEhTzthL49+rcRQWKoZeMdi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707428451; x=1708033251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO8F7dmO+ZHd2XzR0sR22Zih36cYITrLCgrlSWU0FdY=;
 b=AfMPRurif7D76b6yZqTti0z3XZipz69LqgNB3tmr0GlB79m7KxVkY4g2KZ6Icu6Ky+
 h738l5t5PMtmOq58ozoApajX+HKCM7kuVC5ApgT7hE5iy9bihtGEJJ8KWq5A+2IcFjZR
 lmeoMovyJWTWRxEY/wHsE04vMu2A50lXmwMkhx2gu2l1I98jjRfv6bWvuBPqY4dxqQLG
 ByW8FI8fu5nYMjoU7bqV1Q/wBlvgAGmeQVAEJ9AbVZkF9BkPU69RtA8DnGjhSTTxbZ9E
 nx6ULV06R73LuITnOIKN2ndYuhzb6PD7mV/zLm6xgx3vp8UrfpDpHbeFJzx77tsAKnVD
 qtpg==
X-Gm-Message-State: AOJu0YyUJGL/OgytraULaAfm3adefCjEawEvPfCVAX2VNYit/6CLaO8/
 TdM2CPft8HcfHgONasmntvWjPjRFkzmhQ2GeGuFG7QPjewlPGU7bo3R8IrShh7dDvnofK3qfdfQ
 XzYE=
X-Google-Smtp-Source: AGHT+IEtJdxaYrCcsUGrwM+5mDlk+eQU+amT3k54+oWYaReS7n+6Og/LpbYUpJj4acA79IYtkz5aPA==
X-Received: by 2002:a0d:d893:0:b0:602:9d9a:a3de with SMTP id
 a141-20020a0dd893000000b006029d9aa3demr724686ywe.14.1707428450683; 
 Thu, 08 Feb 2024 13:40:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 r12-20020a81c30c000000b0060499d3a893sm47683ywk.116.2024.02.08.13.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 13:40:50 -0800 (PST)
Date: Thu, 8 Feb 2024 16:40:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrick Walton <patrick@careweather.com>
Cc: u-boot@lists.denx.de
Subject: Re: Bug: PDF documentation doesn't build according to instructions
Message-ID: <20240208214048.GM1152441@bill-the-cat>
References: <lscgrcfp.54a556b9-85d9-4bd1-91e0-33993fcf0f4c@we.are.superhuman.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1kd+sfRLBYqWSRvy"
Content-Disposition: inline
In-Reply-To: <lscgrcfp.54a556b9-85d9-4bd1-91e0-33993fcf0f4c@we.are.superhuman.com>
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


--1kd+sfRLBYqWSRvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 12:17:56AM +0000, Patrick Walton wrote:

> When I follow the instructions for building PDF documentation (
> https://docs.u-boot.org/en/latest/build/documentation.html ) , I run
> into an error at the texi2pdf step=A0(attached). It appears to have to
> do with the boot flow diagram of k3_current not being an acceptable
> format for the pdf compiler. I tested this on several releases and it
> appears to have appeared in the v2023.10 release and continues to the
> latest. I was able to build the documentation on the v2023.07 release.

Unfortunately PDF docs are not part of CI and it seems that we would
need a bit of work to make it automatically build as well. Patches to do
this as well as fix the problem you reported would be much appreciated.

--=20
Tom

--1kd+sfRLBYqWSRvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXFSlwACgkQFHw5/5Y0
tyz/zgv9Evh8u9/UrqCqnFB1igDbUE2zCM9TKQLlqeiVotkIbNADLLlPaEmP0Egw
kB12rKZ4d0Fve8Tpj24DJ3OgFLFfvc2OXGPz53hlAdF9y2c1yGlA1pSR1eGXy1BT
SPHggtxC1jw6bqndqqXt1UqXw9qlynFUqvAmd7u8yMNGNxuYAVuj2SuI2QIIdh+K
csw2M/+S/YtBsYkwFwY2JBRjYe4Fcsnd6hrZjZVzFE2ZXhA5t18AT1KoM1ehX+Ek
8zauTxngJ0/Xp0B/bjZ31Jgluv9TRYn+uDiQlwQ+/BsI17PxpEvERGS2jFhNz1GF
aomMM34UnKTf8s+zdmey5YNbFfbPEWwGxFZabhKhxK/NKE/rJ8LbLr2xWHBZ86P3
jwXQlhiSVuarGMqLuyyX4Cq5T7I7FZUVhnsoHHY/pHTshkLe/VrKDoHz+otJZy+D
1gwCG5Q1V6YKEhgEykBTQJtUefK/kQnf+Cs2MgaDNPBqGI0VedLPjYHnuoLtn6YD
BSfxHcfE
=zmfO
-----END PGP SIGNATURE-----

--1kd+sfRLBYqWSRvy--
