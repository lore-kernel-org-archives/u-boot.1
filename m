Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05F9CFC5EB
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031ED891B9;
	Thu, 10 Oct 2024 20:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RgIndlun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FB088FE1; Thu, 10 Oct 2024 20:25:49 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789688924D
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5e8010de1caso826295eaf.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728584744; x=1729189544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g3O1TUjHOcVgNEEIH3g+4a3+PO01CE0BeYpp0w+zD9A=;
 b=RgIndlunwuMsyIY0uLnLNv2gcqTgXaw6xsMlZP/Fguz0Xkj+F1VlzD0jBr9YPNVwUO
 nLSZg56kb14m/jS1nKXpqaYiS3IAz/u95u++4ODNon7sLOSXBj6s499fTIETsJgYXyq4
 0X+0qMMiKP2SiaxmrqGGu0QP6zJUEjeqheZQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728584744; x=1729189544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3O1TUjHOcVgNEEIH3g+4a3+PO01CE0BeYpp0w+zD9A=;
 b=q8UQQLGQlT6l7n3koLscIKGMr5AC3g/lGIN2up9S0H2c9v3C9iAZflyxfcAb1tcBf+
 ydR2MImEZXaxxR8XhPj0iwg8DMtxbuIRjpI6DQ4u5Rm6aaxXYqvBugbO1aD6SDjIDA3f
 AawVCfeOrpEwSuxYFqD3y9s0UNiJXpAgarW4HuEKNAt4ajiZapiuTLtXdf0RlWSD0l80
 3SifmaQbXb3IM8vU49e91hVyt2BIeSlsFybSe3wcqKTF4pIYwSmqZkJ9gpsV5UqeU5wJ
 wkr40bYdz0gEtJfX2bTm1Qic9Y23YpW256LKjavgdns5DD8VdcQSSujLzXayHyFRXBx+
 9Jxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bW5tLjrl26iLs3b5sGeKmpkx8UNsyk/lt5eAMxPaSqM2Y+a8oj8KT4dFy6EWfDeJeyTuFeM=@lists.denx.de
X-Gm-Message-State: AOJu0YzBpjnUNk97kkX3jY+G7jk2U60HtS4t3JRf3AjsyTBk0gQ6u9Ey
 5jTYUmfS8Nfh2gcleJJVMbMvFBQTmLUC9D5orq0PfWe08wud5FCClPsFwrga6mw=
X-Google-Smtp-Source: AGHT+IH/8m7SU6lidKH+aPLJ0BIg5vuZfMIcWANJR4P1826tqoQduS24ksFMNBrgcJgpNyZZ3NJmIA==
X-Received: by 2002:a05:6870:a70c:b0:27c:35c8:bf63 with SMTP id
 586e51a60fabf-2883452316fmr4969656fac.41.1728584744298; 
 Thu, 10 Oct 2024 11:25:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11497f90esm66094785a.125.2024.10.10.11.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:25:43 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:25:40 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, uboot-imx@nxp.com,
 Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/4] power: pmic: Support pmic pf5300
Message-ID: <20241010182540.GT14210@bill-the-cat>
References: <20240930035531.27079-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T5SDryzL4kSguM7G"
Content-Disposition: inline
In-Reply-To: <20240930035531.27079-1-peng.fan@oss.nxp.com>
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


--T5SDryzL4kSguM7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:55:27AM +0800, Peng Fan (OSS) wrote:

> From: Joy Zou <joy.zou@nxp.com>
>=20
> Support NXP pmic pf5300
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/pmic/Kconfig  |  15 ++++
>  drivers/power/pmic/Makefile |   1 +
>  drivers/power/pmic/pf5300.c | 168 ++++++++++++++++++++++++++++++++++++
>  include/power/pf5300.h      | 100 +++++++++++++++++++++
>  4 files changed, 284 insertions(+)
>  create mode 100644 drivers/power/pmic/pf5300.c
>  create mode 100644 include/power/pf5300.h

This series needs to be rebased based on the feedback I just gave for
pf0900. In addition, please make sure all patches are checkpatch.pl
clean, thanks.

--=20
Tom

--T5SDryzL4kSguM7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIHCQACgkQFHw5/5Y0
tyxTHQwAmzsPGCoSnv4Nap1HRVKQ+VM2yXxfbKMJyNn6GGtGCbhPkZJ0CvKI9exP
at9ESkJzIDl5wI1Q9wiBbvt3quHuSGp9w6TOKPbdT9rVxiN8mQ9sHxAkjaLVmOSc
ALPvbjvsiShVtAkxKLm0EQmoHwCD2Pb4y8tLsV6XtquEgMfdlq15wALBYT3Os3Su
qfEUU2ruORc3Ij5QwsteFSdx9u3T6JynPp1e6mRnOh5FgeCv8Kb0Xhkc+bX1NVqY
a7NgeBM0+k+dcfCaZpfvZ9d0KxOd4tTdtQt0t+PoEhT3VvHEYREB6C0Rdqie/U78
Uxc8EL5LOcEObbpR+3R+GBBDbcRvHosnLfDEwVGihhPu3cbk98zBD5phpYSLGj2F
0DF3sqcyczrRGJ9ZpDgGoSrmE8oE/90Yb6X9473YLs43Et84GLFGtM33eNFxSOLz
macTGuMc3hePTkKHvhChcnEvQgfTcrQbKoRgrzZoPXt48Ao8CWUURurOwKA7bZTQ
b9z7LV68
=pzpl
-----END PGP SIGNATURE-----

--T5SDryzL4kSguM7G--
