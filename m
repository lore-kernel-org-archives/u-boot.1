Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13002C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 17:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551FF88445;
	Fri,  7 Jun 2024 19:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hHlHCWK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511018845E; Fri,  7 Jun 2024 19:00:57 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007EA88431
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 19:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-62a08099115so25140107b3.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717779654; x=1718384454; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wXvCk2j4SSpdfgUufI1ZV9Y3Td+Cmsn0IXoIHeZKzCI=;
 b=hHlHCWK5MGuZrFYweVl0ylOGk40lbKmH62vl2IUgsi8sN20uVPs3+ibdffwjVIqiwq
 tgLNn0Ei7vAAB+ItzpbdUDHDaZ78ps1mo68DDahn3+fay+evZYlnbDw7qx+NKz1Kyoqd
 0MKxS5+0WlUBYaflBR2BwpdNl7wP+Wg18i6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779654; x=1718384454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXvCk2j4SSpdfgUufI1ZV9Y3Td+Cmsn0IXoIHeZKzCI=;
 b=oRHWZB/PIMt/hEh+VEtfHWvLLO2Uiam5TxXAQBJzvla+9JyhPZmRUhIuj4mrM7gisj
 hjJwWnOAgyNC65NVbn51vPfy4Vfar4ueSP+GYNZ67AsDK9B0NukOM/a0RJItB9SE6xPl
 dln3KgYcxH2sDszNMi3NvWFdM0ga2ia2Q30THepP7vOO5qMC8HmVexudLFHqeij8QjZZ
 uzU+StDKOqaDt9MDIfK0DRdRYfIQ7yBW873Ydy0KF+BhlFJV1ANoal4ZGY0jvWRepUgZ
 GjzRFoagIyOqibKhNW4nXjnEEkj5V8U+HyVmbRPuRVNOqi1K8GVazdz4s9y39pKNhCWY
 s8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhDpW9KLBkOr5/TwlGX9leboQHKSlhxFnT20WRbY2N0DWWQ9S2Le4H1plEHB6qPszWKS9YfRIh4Q1n7sHHNQUunkAuPw==
X-Gm-Message-State: AOJu0YzYIKPV1ilrRSiC+psT+RVOb/MleetwRLCa3pyV4SVCxT7arccA
 5pr8DLz0ajjwiqRm8ECfjUuexeD0q7PEHGKYDYZx2OgXT6D48xSEB/UREpnjF/Y=
X-Google-Smtp-Source: AGHT+IGiVZeGN8AcP6DYj8h6HKRnnl4BRrg9GZl8/B3DRSU9Ppm4sa3plK9xnMt9Kd2OyibSQF2g6g==
X-Received: by 2002:a81:a9c3:0:b0:627:db26:7a2f with SMTP id
 00721157ae682-62cd5570e41mr28769377b3.2.1717779653421; 
 Fri, 07 Jun 2024 10:00:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-62ccae47952sm7476667b3.77.2024.06.07.10.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 10:00:52 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:00:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] arm64: add software pagetable walker
Message-ID: <20240607170050.GJ68077@bill-the-cat>
References: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
 <20240607-caleb-upstreaming-v1-2-99094dabb3d9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ivxtF4LTvnf0Aho"
Content-Disposition: inline
In-Reply-To: <20240607-caleb-upstreaming-v1-2-99094dabb3d9@linaro.org>
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


--9ivxtF4LTvnf0Aho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 06:51:20PM +0200, Caleb Connolly wrote:

> Add a basic software implementation of the ARM64 pagetable walker. This
> can be used for debugging U-Boot's pagetable, as well as dumping the
> pagetable from the previous bootloader stage if it used one (by reading
> out the ttbr address).
>=20
> One can either call dump_pagetable() to print the pagetable to the
> console with the default formatter, or implement their own pagetable
> handler using walke_pagetable() with a custom pte_walker_cb_t callback.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 202 +++++++++++++++++++++++++++++++++=
++++++
>  arch/arm/include/asm/armv8/mmu.h |  55 +++++++++++
>  2 files changed, 257 insertions(+)

So, I assume that by default, all of this gets discarded as unused code
and that's why it's not behind a Kconfig. Next, please add something
under maybe doc/arch/ or doc/develop (I'm honestly not sure which is
best) that documents all of this. Thanks!

--=20
Tom

--9ivxtF4LTvnf0Aho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZjPL4ACgkQFHw5/5Y0
tyxU2gwAjVYm3u/39mJuuJXcS7h1T8NH6s6Uxvgqk9asVbhBUTK6ZhfjqwnyuaSn
UAM+ZSMzph3Vih3Gy++OIHYtJspDN8Om644Whq7Fr94C0Mv4H/4xaRnnEVr0Ri/h
JGIHqaq7xt/RmRIfe88CeiirY+mBNMaUp5lEFgzLPQuyTKjh0BAs7xRyn6x5bKkl
f4KpyHnkCFyExMfqcTIgB5pX1ui3ZVF+2Q+zCTwOgDGp4DxvtyGQsvrkrK3ycDQD
VsHEQ4E42DUmfotPj4WEG5H59yz4jevBh8HqUsBMjy7rsDjChXwIq5kuKdc1AfxS
OH4d+K9J9CimHVYw68iVAMtEgeCqsgInbJ3QdK/bXBHxOhB0Qd/EskncvI5A6c6t
9oRWDFRQf01WHIZYz/daq3KgQ6qs3mR4ClpEIHcRl0kNZXW7hK3oAkjoxfJeJ9Lz
J2ucS9kGe72yeiuTrNVSStLfR5cdRqpBCVdtS8oPcSq4Pr1JqjmBPJwY4hCXN2fh
eEK/tEe6
=hzKt
-----END PGP SIGNATURE-----

--9ivxtF4LTvnf0Aho--
