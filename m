Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BB7C4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88A687CE5;
	Tue, 31 Oct 2023 18:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SxqeVqCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262DF87A5E; Tue, 31 Oct 2023 18:46:19 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0114B87D03
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d2de704f53so2826975a34.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774375; x=1699379175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=skj6kf64hN7cSA+KjRSOnXE6w69Hyzwvk3Qjnhn4Zwk=;
 b=SxqeVqCPsnx8TAX3kR+3Fw5urQwtfeD2nC51heaOCa8PY54ak+8o4ugjPAeulgMsu4
 fxAp3ObHzPPBIJDkpUZJE25Hs1Tzh7BIa86mP1vnnfGy3n0Ku+msS90CkZsfzFFRVfDV
 dVismj/pFUbPMvD4aadQ6rTPe+WobCHI8WNN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774375; x=1699379175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skj6kf64hN7cSA+KjRSOnXE6w69Hyzwvk3Qjnhn4Zwk=;
 b=jjSW/NoeUhxDCcIGaGML9n3HPcN9qtgL37VtxFME8fr4xDIIu0lswS3iPtpXfpkU8P
 5IGZCqWyTni6oeA6EG66KGtIcMpoBY2M1IcqVkMfHs+2l7HkIoEMrXc40f5G30ymKIA2
 qFBgQBQO0qcau+mcKgB69vp4LSsALqwXaEcJdNgs/RzbdJyoG6ngGz8xEuTMapHEwUy+
 MmOL6kvFIFDmfz7IXSP+7a4uy+dnCrMmNaBRPlrSezfCG+kcv/JiVOAOu3KrAADYmsKS
 i0j8vGaNlTyOwL71Vg2e/o1sTzlMtGFmEaJvdmVCGRXAheN5EFGJH21PyCvCSlRlzuxX
 lwog==
X-Gm-Message-State: AOJu0YwXhyX+hlpAc9bc89ne3pSzumfVY9xj89S6VW8SV4tcmhHztUtj
 ljtPWkzM7YyITp5giKcSTogqrw==
X-Google-Smtp-Source: AGHT+IFvyYj7r5+Xa4nZPkCny249rHFZ+1abLdXyb8dbv7jnKKz73NbKNOE6CnQKUPEPMVdRgCqaIA==
X-Received: by 2002:a05:6871:4e8a:b0:1ef:c637:2688 with SMTP id
 uk10-20020a0568714e8a00b001efc6372688mr9436781oab.8.1698774375515; 
 Tue, 31 Oct 2023 10:46:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 h19-20020ac87453000000b0041aff9339a2sm670989qtr.22.2023.10.31.10.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:14 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org,
 ryosuke.saito@linaro.org, sugimoto.yoshio@socionext.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 3/3] board: developerbox: update flash rawwrite binary size
Message-ID: <20231031174613.GV496310@bill-the-cat>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mv5PsSKuC3EOHZ3l"
Content-Disposition: inline
In-Reply-To: <20231025065103.3101666-4-masahisa.kojima@linaro.org>
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


--Mv5PsSKuC3EOHZ3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:51:03PM +0900, Masahisa Kojima wrote:

> Current documentation limits the firmware size to 1.5MB.
> When the fTPM and StandaloneMM-based RPMB secure storage is
> enabled, firmware size is bigger than that size.
> Let's specify the A/B update bank size(4MB) for flash
> rawwrite parameter.
>=20
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--Mv5PsSKuC3EOHZ3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPWQACgkQFHw5/5Y0
tyyZNwv9EtRg63ZlrBu+j4U1el79cu7QEhSD3UJa2CbZBAf0k5fe8vSAO6EqtJgc
a5Rkyhc3uo8bz9s2+eruBHGBPptkYt3E2g6qGLAe3dlkPt445YuNYLKZDI7fKSOo
2GUYLu8LnSdMeMoPs2qegHZXffoqQzmjYhn5gD962vdzQAacyllK1gvJvSjL3ZEO
PIW0njPgkvgn2Qc7XAMwrPZ+71iGfvY6oyBnUOAE8NiStHeFsrtCjArWFgltPM3m
k465ysOZXYK26yIWNp3lqF2eTGZEa4HVfowosd/PUm4IIkncZej2XTUts+reSm6j
PRKMnijmnmq2Wo9cOUNYVnMaslHX9FFvfp2+s4+kEykOn/3JDfzAiaJvG1xQ6sgo
wny8mUlompQtJCWlcGlYtIH132TPzq779CYfclG47dFtAGT3+uXZTR/MvMZvtVKD
TkXgNuBOpYkFmHF7t6Y7d15bIDGaaoueDDKJ2rX5+JM3SaeW60p752RCjzyqOen4
Xubf5Bvp
=vMm2
-----END PGP SIGNATURE-----

--Mv5PsSKuC3EOHZ3l--
