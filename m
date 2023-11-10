Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA48C4167D
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EB687851;
	Fri, 10 Nov 2023 17:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hNNYls4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658AF8784E; Fri, 10 Nov 2023 17:21:59 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C620887840
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7ba962d534eso881951241.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633308; x=1700238108; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HkrN/zfMUcQxRZZZdzmAdjTU4Ves+9fsDQiSTJ6lZAU=;
 b=hNNYls4FI2VL3B2GjruGlkV5ZCCElLVT/WPW9mEMPuThLttp9rORQhz3asfrMBz/Mk
 XwZa+2gSla2p13AjlapihIqclBR5LK5XOaRhb/VJAfDSbV2uRqol8u8GYUhBO1WfSumM
 gPuXkFTsOEl/dKWbOxPp/WV5HGwXcbWrhOEW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633308; x=1700238108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkrN/zfMUcQxRZZZdzmAdjTU4Ves+9fsDQiSTJ6lZAU=;
 b=b1bekopUMeiAK+hJy70CfIuDuP6bWCpkMvRithYaCgcqaLxz4XuPiEkrfPOuTNo0IL
 5K3WusQCnQgOROWc3pLE0FtI9ltMnfZEuSRVMVaQ+D4k+rq4p/8kgSw12idIwdOoshp0
 EMi+DY+BSUIMZ/d1V1wF5YxFSfJcXf7/ortvMmLS69mOS2evqZudHjYns+CEz+gEXabN
 FdcLb+ctSxbJWS1uMwHQPQsnvM+fqsMCXF//LNVvn5T/r3HguZvwh3d/UIWMsHCyAnun
 JZAfD6X+ZTo0GQTuEKKibxrYOnnhvOpKF+DX63CjfqmyJVcL9BZPq4BDW0azAKEuSnBj
 4FkA==
X-Gm-Message-State: AOJu0Ywkz5/9Dz0/TG3MIeuEBbchLEH8SLL+xJx7ZTFbWRKpC+OJyqfU
 b/C2DMMMvh9HndtvhvlyHE4qGQ==
X-Google-Smtp-Source: AGHT+IH9PLEPrkYQVo/jIGWSOwGS3mIsVYA5PysykqvimOrHu5mytemQsaB+UaAznuSSrtUagZgPBQ==
X-Received: by 2002:a05:6102:101e:b0:45f:a41:b405 with SMTP id
 q30-20020a056102101e00b0045f0a41b405mr8269043vsp.21.1699633306911; 
 Fri, 10 Nov 2023 08:21:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a0cd6c7000000b00656e2464719sm2994973qvi.92.2023.11.10.08.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:46 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: John Clark <inindev@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] tools: gitignore: Fix tools/generated path
Message-ID: <20231110162144.GZ6601@bill-the-cat>
References: <20231026210015.17802-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b675qZZRfgxL5JNt"
Content-Disposition: inline
In-Reply-To: <20231026210015.17802-1-semen.protsenko@linaro.org>
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


--b675qZZRfgxL5JNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 04:00:15PM -0500, Sam Protsenko wrote:

> 'git status' shows 'tools/generated/' after running the build, which is
> wrong. The corresponding .gitignore rule was already added in commit
> c623642d29be ("Adjust gitignore for tools/generated/"), but because of
> superfluous 'tools/' part it wasn't in effect. Remove incorrect 'tools/'
> part to fix it.
>=20
> While at it, remove tools/ path incorrectly added to the top-level
> .gitignore in commit 801c482207c7 (".gitignore: ignore misc include,
> simple-bin, and tools/generated build artifacts"), as it's required in
> the comment on the top of .gitignore:
>=20
>     # NOTE! Don't add files that are generated in specific
>     # subdirectories here. Add them in the ".gitignore" file
>     # in that subdirectory instead.
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: c623642d29be ("Adjust gitignore for tools/generated/")
> Fixes: 801c482207c7 (".gitignore: ignore misc include, simple-bin, and to=
ols/generated build artifacts")

Applied to u-boot/master, thanks!

--=20
Tom

--b675qZZRfgxL5JNt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWJgACgkQFHw5/5Y0
tywO9gv6AsrdxygtRgM30M35BICik7RyzhiJBit/etBPKVGRHT9HtfKXMHhqBH+N
LydQCtgB3jsryrcnOCPlQCzoJCZIrhiPUX24RYaqaIxWF8Zx+ID5C6wPrdSAifM2
K9QHFrztW9vRRO5QSfKPRYNdEdJ1tL72viSvla+gjsucHpZD9qNajHaNcaPJZXr5
F0GmbB0K1BUftYllt05zC2m0SkUKxTBdy9e21iILRfLUTyNrB7G/O3hkvLQvZtW5
BAYFvs5BmsZ6gp4kd+XKsKPa4T8zkPSa2FzNO2v5SbopelkLsdaQLJV9AZh/beU2
u9kYKqc8SkMaCyIMjdlor/Qj7FOICU9acwLmTu6RdDvplA66ji8I0rXwFNiRIvcY
i1tS0nDQcGMUIZI8sAd66ZIO0QDLrfwKVdflimnDfgjZ60vZdFZ6ebxp59WDDAmK
d139dTteSSbBkgfxUFvuox1lYtVUadbQpevVp+VmyCkFVx1jiU/lpSMUlJX788xD
Bz1rn4zD
=7hlE
-----END PGP SIGNATURE-----

--b675qZZRfgxL5JNt--
