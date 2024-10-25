Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9594D149F0
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4346188A1C;
	Fri, 25 Oct 2024 22:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oWpjURwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9859788BEF; Fri, 25 Oct 2024 22:22:23 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2089D8857C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 22:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e290d5f83bcso2589071276.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729887737; x=1730492537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v/zdlAHQIX7u0FPyvGy7OnfeB5IFMoEuVm4rSGqXQXk=;
 b=oWpjURwJ9GjbrmeSUVV7NzFnBVzMOoDrwWSplu1HRTfuxOwXVlIjXXB3mZzzZ5U9JN
 RpMYxetzA0lRp1dYB3czty0JVbChieZ0zfVBNJzAK8RuCH/llpL31juYhWwaBigfVGNo
 wOqqIOyPHr1KCCjBSLmnqZ9JSQovbRRNEWiAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729887737; x=1730492537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/zdlAHQIX7u0FPyvGy7OnfeB5IFMoEuVm4rSGqXQXk=;
 b=lZzqMCqO6CxIbv3bZNpN48CTroU8ab1/SD2VmFcV6pRy2Dh51oxS/cxqx7CnEKTz1X
 rLASQMU9fJgyiL7RUAghI8HWOcqhnJWNhqlX0lncAHIx1aHnqDzpk2iiVaXu+Do5JBv9
 jQsqyXGvnTuQTp1ImR4LBa82be4ARgBb8myMVsS/UfBgu7P+SYKtaNVUuZD1OV7lGD+Q
 ppbCyvrYHRT5Zdvnn4FMxefhxOWX6cvxqkUe+k7zpUesOIDO0vSyphrlu64PY2OEClTj
 uWi+zbdWhGFqQE5BCeSxVAAXAJ56JGGhRsEqo4XwlUwoI/PbuqCrTDJY67A3M1Z44+Ft
 521Q==
X-Gm-Message-State: AOJu0YxaCx9T7OCy+CkNp1o1Ayua2bblR2L/YdTJowAiaEdyv48KHOZo
 PfCwzALSXqjD/H3kB0ZrrikQNsUKMBvdGVXsxKA8zFYmp378567Fd+HomSU6cwI=
X-Google-Smtp-Source: AGHT+IHjVYiC4iQ9c0Hkn/DkkPEPxCyDzgYqctGW13CHNYKcn1VR7uAfBGe3SwY3V88Lv7ILQcaSFA==
X-Received: by 2002:a05:6902:1885:b0:e30:6e8d:b523 with SMTP id
 3f1490d57ef6-e3087bfd43bmr889965276.40.1729887736929; 
 Fri, 25 Oct 2024 13:22:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132297c39sm9299661cf.50.2024.10.25.13.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 13:22:16 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:22:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.01-rc1 cont
Message-ID: <20241025202213.GC4959@bill-the-cat>
References: <70e3a9b6-229f-4db0-9034-19b04dde9f80@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vclXNvSeojNEqa1S"
Content-Disposition: inline
In-Reply-To: <70e3a9b6-229f-4db0-9034-19b04dde9f80@amd.com>
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


--vclXNvSeojNEqa1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 05:50:26PM +0200, Michal Simek wrote:

> Hi,
>=20
> I have collected couple of more patches and would be good for me to clean=
 my
> queue. There are some other patches which have been sent recently which w=
ill
> come later after review.
>=20
> I am especially waiting for memtop series (sent today) from Sughosh becau=
se
> it is fixing issue on Kria platform which is regression because of LMB
> series.
>=20
> Also would like to get rid of SPL_FIT_GENERATOR in this version but I thi=
nk
> we are almost there.
>=20
> We also started to upstream qemu model for MBV to be able to wire this
> platform in our CI.
> http://lore.kernel.org/r/20241017072507.4033413-1-sai.pavan.boddu@amd.com
>=20
> Thanks,
> Michal
>=20
> The following changes since commit 08ae12be8509daf3d1c5a148b8a50c0ffb6457=
c2:
>=20
>   Mark a few functions static inline (2024-10-24 11:21:48 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.01-rc1-v2
>=20
> for you to fetch changes up to b3d9c6c71412fe63320e879d89873da672e69100:
>=20
>   .mailmap: update e-mail address for Padmarao Begari (2024-10-25 16:21:0=
0 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--vclXNvSeojNEqa1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcb/fEACgkQFHw5/5Y0
tywxBwwAo+woIF/xgBvQbTf4CKe3ISvYx01UuTQfbbynwBlezsna3dfEBTGnYlGF
sDtJR95cHlBKfhMWgtYIa3yXdD5z05VxkropUeQhOIGcA/Lx+uAXKT2hsaqOmZ1V
70ziXnqOb+ac8yg+Koipb5i0a3DnKHc8dDMkl5TqdnLSj00fBefAIps1MQP+GuVY
/gymYgJPM1Ugw7+WBw6qF/3X7Kv+Akwf7qh0042bwi0+gzlqASmqlaSzgvBWz3hR
pZMZDWZRx8axl45kK0CYnAQalq3SvV6RcxMh3XwoFn7L6PwdLOqE/SkDhVM7031P
nL1ipjp3XJoR5/PaTG6X3oEdwHb9nnLLEpKlheubyufpuCLBk06/jx0bq0Ty4t5J
MzvcIWfAYGLREP/Eaxhn4sOYS+JWDncigQ+zQt+sAX0U9Y8S1CNTCZ/O03d9FqYV
hH6FgzKQ4OYAAVOk3q1XMMSNaVYGf5veCY88G/gtomnn/Q1NrUURwEGLfZYa5tMR
84T546JN
=hXD1
-----END PGP SIGNATURE-----

--vclXNvSeojNEqa1S--
