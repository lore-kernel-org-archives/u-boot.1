Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344EE8FDAC
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 18:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B430083A1B;
	Fri, 26 Dec 2025 19:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QipmgjM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF06A83A1E; Fri, 26 Dec 2025 19:09:11 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E105D838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3f5aaa0c8d7so5357847fac.3
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766772547; x=1767377347; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+sHyBQ09zHRAyAPCqM32b5v2oc9HZ/DRjtvcYY+TVa4=;
 b=QipmgjM9laTY3YQOSv1jQCDqInbxH3gsuwbnPvrzNH5ODqXnXdY+0T7L4ov7DRDXGP
 xRJY8kljfvxcXIYhPQXa+zzPso0epo+rgph/9SuVxHHk67GlZH5xB+CsuXfwzo43VjGi
 CiPJB/GHMm4otoLRHd6LWlvRLqbR5rH6pmwi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766772547; x=1767377347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sHyBQ09zHRAyAPCqM32b5v2oc9HZ/DRjtvcYY+TVa4=;
 b=ooCGMF8RlXxzXWsqKIOME/wRWe3hIw9VprmspeExr/gOp3VtMaI834UjzhJhkoV1TD
 eamBBIoxpeIswTHWHjOb4BRtFpBR2SurgzTIa0u9eTc/YCCyDJCWmQ2Lm3uqURA+/Zt5
 QeV3JotO3oh2WxZlQn9cDgGENvvehWMjcl80VcB3JMTOFVSz5AqpuzeM2cos8VHNr/jL
 YUDTWkvIkDFQ4dCwWm3yHvDe1+yQBuWd51g6ehizZt9mTmeYdBowS/XRkKqAa3P5b0MJ
 8p0lWmvRvSiWJj/11p2Q/DZ9lhO5Z3L6o3y2NIndduSEr2opcdGTOVCIbTjjLOGZHh0h
 RbOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKDG2RNai7cF1z8r6y6IfoKmfcuKiTnr3OaNNZm357JRTPoqU7IjPnYwJJLCiBTvGBlcxmdd8=@lists.denx.de
X-Gm-Message-State: AOJu0YyKOmemUYMhkTgQb02i3dXSJe3PznqDujGMnr6chX9TSSRzL4sA
 cW5IEuVR5yL/qYgMzRvpO0u5BQEHA4WnoKgfWQgAqwXAPCOu+KFcugYUnpdKefER2As=
X-Gm-Gg: AY/fxX4BoLwIyPyePU4xJf13S1pjAX17vQNJryhm3EYmLFqfUOTQd0izj4hhdQQjx6j
 LQoyVVnWXyEIUbi7NSoLUil1XiT9moAbQQOIAJdeWLl3Y/4x60Li6jEhks8PP3L8ktpRLHhWLj4
 TC5TY7q9RQkuCAHe8PxZslatj5yFEZrQNnC7AK/hcxHaoRyS+RBsQBQW25WtBSNQei6L5alR7MS
 VadWPTVD66o3rnYivJx9qFADonhKuakGvVoAGXYLdH6VwPUix03jrVmykVjhVD6LlgfgfknD2Fg
 6wTDVuwUEskt9frcsezm0oafPGFOkFrw/jBZjGQUKIo199dGaDkXl2aKEpvS2v1X9B5R+mx+EN+
 PLSe3IuaVtBEUFsyKGfPT5XfX0BDqMuJDxQ637Puf3pAgVk6raUt8ZxrPIIjm2cThXSFLMfw5e6
 LJj5H8xpi8E9NkzTHjPeJ/Ifa4rujzCeYezmPLyos3JN1nNw4q+w==
X-Google-Smtp-Source: AGHT+IGIy24AddAXNfcoQ8xSv88elMK3IjjYAlo2IjTSzbqIIY/0s04hn7xPfEYzWSSZoCwJNKBWig==
X-Received: by 2002:a05:6870:41cc:b0:3f5:4172:129 with SMTP id
 586e51a60fabf-3fda5949356mr12397315fac.58.1766772547584; 
 Fri, 26 Dec 2025 10:09:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaabbadacsm14440576fac.15.2025.12.26.10.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 10:09:06 -0800 (PST)
Date: Fri, 26 Dec 2025 12:09:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] CI: Add test jobs for QEMU m68k virt machine
Message-ID: <20251226180904.GF710860@bill-the-cat>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-5-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QqpcpsZ5Zf2N5m9I"
Content-Disposition: inline
In-Reply-To: <20251226175400.1154417-5-visitorckw@gmail.com>
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


--QqpcpsZ5Zf2N5m9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 05:54:00PM +0000, Kuan-Wei Chiu wrote:
> Enable CI testing for the newly introduced QEMU m68k 'virt' board on
> both GitLab CI and Azure Pipelines. This ensures the new M68040
> architecture support is built and booted correctly in the emulated
> environment.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - New patch to add CI testing jobs for gitlab and azure pipelines.
>=20
> Note: This patch depends on a corresponding patch to the
> u-boot-test-hooks repository to provide the necessary QEMU
> configuration: "travis-ci: Add config for QEMU m68k virt machine"
>=20
> The gitlab CI job has been verified locally using gitlab-ci-local tool
> with a passing result. Azure Pipelines has not been verified.
>=20
>  .azure-pipelines.yml | 4 ++++
>  .gitlab-ci.yml       | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index e4695f1c55b..41bba8ed0f1 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -518,6 +518,10 @@ stages:
>            TEST_PY_ID: "--id qemu"
>            TEST_PY_TEST_SPEC: "not sleep and not efi"
>            OVERRIDE: "-a CONFIG_M68K_QEMU=3Dy -a ~CONFIG_MCFTMR"
> +        qemu_m68k_virt:
> +          TEST_PY_BD: "qemu-m68k"
> +          TEST_PY_ID: "--id qemu"

I see why you set TEST_PY_ID but that's only used in this manner for
platforms which can be real or virtualized, for the qemu targets we just
omit that (and then name the u-boot-test-hooks files to be "_na" or can
just omit that part. Thanks for adding this!

--=20
Tom

--QqpcpsZ5Zf2N5m9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU7PQAAKCRAr4qD1Cr/k
CoTMAP0fC8sGk+H1U7FV57sWLYI4O81vWUgXKN46FxCcfdb2qAD/T2R5/XA7qCDs
gTqIzM6f1hm6OvPM8Z6QWNaTEK/k7wo=
=+F7c
-----END PGP SIGNATURE-----

--QqpcpsZ5Zf2N5m9I--
