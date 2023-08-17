Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E6BC52CDA
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F65786BC7;
	Thu, 17 Aug 2023 21:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bxBs3/sh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFCE86BC9; Thu, 17 Aug 2023 21:02:12 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424C886BC5
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58c68c79befso1527667b3.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298929; x=1692903729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9LPCpXT+pK/HPIkHSoUhmJ3kFQMI68hHa5CBaoNkEMY=;
 b=bxBs3/shreGCtvSYaNruCFl1n6aSavla/tMAdCW9Gap1+y5CmdG6s2Cd0f8KOVYTfw
 MKBznJLHZQK+Q7CxL3lFmxIhTdcFP2LbnKo+OQBCtKmG+flVg2E5iSpMWSd+mCSOeD3v
 Ulqof6xksMl5RJB9cG0isGAPMzsbDRsup1/Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298929; x=1692903729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LPCpXT+pK/HPIkHSoUhmJ3kFQMI68hHa5CBaoNkEMY=;
 b=TkkZFiV0m+e+9cGyiaaCJVc557x0GqtSeuLOWpsIjBuRMhmIeJV5yIGwZUGvdK1AJC
 F3KZggxpR2/uQakCmMrOr2W36AsnsvtIkkwd9ew4mMqXtcbktXMgp+zcH1dRGHmgQuot
 epNYQdDpPSH7SC0BmpnjCvfApjZ540QTG1k8sHpuziGOKMvmFPU3Mo7lMI7+X2ElL7S8
 UGywCy8Fq3I132eGxexY2zozlTEJz4R0b9F2yCmP6Z2QX75fSvCsvSVKsRTuWrCl6TqF
 X1puHTTKMjZuxvjymYUe6uGurEOkEYuhrI5bWN81DPGm+nq8zoGEEG5mp0QVBJIQfHYa
 wKcg==
X-Gm-Message-State: AOJu0YxlhVCJ5CnpjoQH1FC/xH9WYYgLUj4oJb5BXGIyBOhk5HT4HDYg
 pW+7Werwstm4sr334ahTHVM63g==
X-Google-Smtp-Source: AGHT+IEjOXg4nzQFQ5GWFCrgE7MDzvvkcWTdsn74/B5cc+mp44RR8Bo2tYwZktFKKVdQkMCbvufedA==
X-Received: by 2002:a81:6cd7:0:b0:589:69d4:f117 with SMTP id
 h206-20020a816cd7000000b0058969d4f117mr206506ywc.41.1692298929017; 
 Thu, 17 Aug 2023 12:02:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a81ab4d000000b00583b144fe51sm45170ywk.118.2023.08.17.12.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:08 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:07 -0400
From: Tom Rini <trini@konsulko.com>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, nd@arm.com, xueliang.zhong@arm.com
Subject: Re: [PATCH] corstone1000: update maintainers
Message-ID: <20230817190207.GM1515023@bill-the-cat>
References: <20230811122257.1619723-1-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CU7MXWPhslN2Y5zX"
Content-Disposition: inline
In-Reply-To: <20230811122257.1619723-1-abdellatif.elkhlifi@arm.com>
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


--CU7MXWPhslN2Y5zX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 01:22:57PM +0100, abdellatif.elkhlifi@arm.com wrote:

> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>=20
> Update MAINTAINERS of corstone1000 board.
>=20
> Signed-off-by: Xueliang Zhong <xueliang.zhong@arm.com>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Applied to u-boot/master, thanks!

--=20
Tom

--CU7MXWPhslN2Y5zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebq4ACgkQFHw5/5Y0
tyyRpQwAgfS8CXI9uFg6H9EWQWWrASHatH6iIS1NOaF6H0coxPMBkCZlG3o3mgPT
WcDlWTTdeTbXPit7Jl9liwTDimU0U2H+PLBjh4NNTR/Ks7Xa3TB3iTjNvxFgSVyG
5J1vjNAtnHDI2POaNXPWkBGwPC2+FUX+Ii7n79EeLBHzmKWI6j5ACoxFbKfjR8wf
rLegz3Hv1nKhFOWBdEwMeHO2C+cT9ud/44RiFUW/iaZxcbgRN4so/TJ2zdgjetDc
SWhRZYsPmYa56R+npOFJGKZIjN8+RNp8k3Nc8cf5peAKy1TjqTgLuzDuHO1xaiKi
Ki73O8X639u2U1GaMtZ2xKFhIbhCB6zpsCvFjQ7BzcTaz+eA8tbwt4AOZCGaxYgm
4A0ovg9qipc1bS9F2OpBn0GMXFe+kvwho3BAIgwMzQhIhX+lYSKQ4Kjkw3/zKror
UcrWBMqctofoSczvoLJoiiOW9z/+pr48O8NB+Cqhp3kGT2HiU2cC8ueMjAl1sf8p
lnOCjCB+
=CDDf
-----END PGP SIGNATURE-----

--CU7MXWPhslN2Y5zX--
