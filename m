Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90498CF3975
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 22:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16779892E5;
	Fri, 20 Sep 2024 00:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pnchHKPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCC5892E7; Fri, 20 Sep 2024 00:06:09 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE57892F4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a9b049251eso93188585a.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726783564; x=1727388364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/NDqpWNJr6ZlSFXnEIvLL4gazZR3LHmDsBrMt6EmQR0=;
 b=pnchHKPUmKmSWMJ2ppU3tEKLxPqjfZG7aFAHMrUlwHQLzqSnTj2oaBKUXVAeKgnrjz
 sUZzDfutke15RixbQmJjCcedRQ43EKUsUOuBgO9TKvLr8T1Y0//zuGbInLHsijXS4NHB
 +W4g54dKXq8YCY13RlvFtATaGG5Ds/jKHQrCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726783564; x=1727388364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NDqpWNJr6ZlSFXnEIvLL4gazZR3LHmDsBrMt6EmQR0=;
 b=j0GSx1OrQzfSFsgmOEGFpdsHilAUTCQkvYBB0UjZKLTTdTJdfHPEOqbQwRsxkFDVsB
 mako+3JJLEhTClMpaNEorg0TiJXO1N9KOuGuMi98KXZI/y7UJVegUv4bugaklwNfnbgC
 yc80VBt16WT40E4iHYNc43Mx6uzwxchaYk+VykCMma81EljN7LFRS8AjZhmgYMhaT2cR
 EcwKyzSEGTyHxW39xqayAIfi7H9W+xEHQHQfchf/Vzo9T2ZmaAe1lGF/pO1WSehEtl+l
 GfXmNwZmxZIudja40Qzs+k8QCGdQ/+bxa6s+qpsNHjUT9QDUtfjIYvFKWyKmOVLKf9uY
 EgrA==
X-Gm-Message-State: AOJu0Yyua/KZeRpMynH3Lr58yxHRZUgSfp6fR+bv7Urvdih+CTcRr/s0
 QSUqMI2lGk3T7X7XfI4N1hXT5qHpu7wgTxQPn4mg9JmCEZYiPErnFtJribAWGEg=
X-Google-Smtp-Source: AGHT+IHFDFdV4T2SB9XD8W4+iIbBPxxfy3M1bAcaEkVpXs1JMOhuN879xYW4VLAWwafFrQuHugr3qA==
X-Received: by 2002:a05:620a:2412:b0:7a9:dddd:cf6d with SMTP id
 af79cd13be357-7acb80bb8a6mr119079785a.26.1726783563945; 
 Thu, 19 Sep 2024 15:06:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08bddc3sm111318485a.90.2024.09.19.15.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 15:06:02 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:05:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, sughosh.ganu@linaro.org
Subject: Re: Pull request for fwu-next-19092024
Message-ID: <20240919220559.GW4252@bill-the-cat>
References: <20240919143435.209455-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VOCxjkpDJBeZtq1H"
Content-Disposition: inline
In-Reply-To: <20240919143435.209455-1-ilias.apalodimas@linaro.org>
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


--VOCxjkpDJBeZtq1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 05:34:35PM +0300, Ilias Apalodimas wrote:

> This is a PR for the firmware A/B updates going via the TPM tree.
> Sughosh and Michal have verified and tested the changes.
>=20
> The following changes since commit 650883a568653f37ee4ff43beda56152b594a4=
9c:
>=20
>   cmd: osd: Depend on OSD (2024-09-16 16:46:16 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/fwu-next-1909=
2024
>=20
> for you to fetch changes up to 6f933aa963bb971d848ff6bd1c743035bbc98ead:
>=20
>   fwu: print a message if empty capsule checks fail (2024-09-19 10:52:50 =
+0300)
>=20
> The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/22=
364
> showed no issues
>=20
> Please pull!
> /Ilias
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--VOCxjkpDJBeZtq1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsoEcACgkQFHw5/5Y0
tyx0Xgv/eyMqRU7spSfE2K5cdmiwfoz1VSi7f2RlPuR1f1Dse4lV410RMq4LQQue
fQFtU4fXVJW41Oi8AvNLDxCsjcVODN19tJMj37DnOFFeQIDqKQUXbdgULAdDYkDk
N0wNWjkZpJED7ilek5DX6bXjnxllXwAl056hLSLzVcsfvMtEtAvVcjWJ/AD+3mKV
OTb7ekBl+NR/ksyk9+iX74JhOuedjO881AQzo9OM7Ci3xQHksc5M756Ezqo7MB4Q
FxGZqVTDfP9J7RCPE8Ng9xqCU60+i4Pcw6MUJkaZPU6KZ1wKKW/2QyFSXqZamQFj
EyhkIQVXdsfjze4ftPykn/mFgHZtb6Cg/FD+v2sld/q3LyvO8IPytld0DRtJvPt2
K+62DLyCWTSpO4Sw4+pl78L40iaLYeMdObnu643ldM6Glxq0pccp2CW6Nk+vFSWC
JkOSXultBkIO7tBYvyE8QwQkr717PVGVOKguG/mMEfgkrby6sjQSS81SrFCDijKM
bG0tB2vW
=vgzL
-----END PGP SIGNATURE-----

--VOCxjkpDJBeZtq1H--
