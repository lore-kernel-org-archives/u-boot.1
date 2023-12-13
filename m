Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30B1C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDA687905;
	Thu, 14 Dec 2023 00:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SoQEkxI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16EB887909; Thu, 14 Dec 2023 00:06:11 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9408790B
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-20335dd197eso455267fac.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508766; x=1703113566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O4rpO6yBNmbDALcm/8GM7BueJnROmEtNyCeGclmq3gE=;
 b=SoQEkxI8FaOCMjSyRWTypBg2UISj+RA8cs1QqUkDDbEaxrmPDuwCgnB5s/zBsvsm1Q
 TDffo9TOwZKLBj4+8KvA7FFUQelPhhLp32fFgELaWvMxVlaXU/mEiASmbEiKBcan9TH4
 Vy39RUBwFFGjUwE6uS/L/jlrSKGo2crbeBXdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508766; x=1703113566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4rpO6yBNmbDALcm/8GM7BueJnROmEtNyCeGclmq3gE=;
 b=i2GKLwfyj8jhdL0GkZk9I42xz1Rw3MuKhXmO+qJWVDXzQVBGPtXtqMbhp8Ov/voEcj
 6lv49HxoB4c48qwzPB96ewdTOKiMc6N7n4Famr9+big35hZVthSBNE35c4N9R1Tk/bpt
 5mhCbGQdaBoBqsH0ouOgW+Nx6Z4oCW/8PZh0K3PpKq+ydeL7D/5Sieumu/B105wnf+/y
 1cP+vQGLVKp+hz1vg4yuz5zlJ7xofOTOT2jyevF8yhMH6/nY8xix2cuLIyXye5pqDEuT
 lRyCOqBROzV6zoMPPJ5gt+7sXsojIM6vgAMbMZ+RvExcA90ctbKOOzuy+4p8jWjfSdJA
 YRYQ==
X-Gm-Message-State: AOJu0Yx/VC2N4+yMP8AqQ2I1CHce82Vt5eyyAmqUIHG/vG3GuauXSCDR
 nlv3OURCLcjkMQAM4RJMDOucPA==
X-Google-Smtp-Source: AGHT+IG3jLqNnAOqNtx8A9Pk9LBRpFkqMkwthri4DaoeqyVuifaArLooNy2SV2IR5t+ycYThRN/uXw==
X-Received: by 2002:a05:6871:e70b:b0:1fb:75a:c44e with SMTP id
 qa11-20020a056871e70b00b001fb075ac44emr8986030oac.119.1702508766319; 
 Wed, 13 Dec 2023 15:06:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 u33-20020a25ab24000000b00dbcd0082242sm825648ybi.65.2023.12.13.15.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:06:05 -0800 (PST)
Date: Wed, 13 Dec 2023 18:06:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] maintainers: rk3399: remove maintainer
Message-ID: <20231213230604.GQ2513409@bill-the-cat>
References: <20231124120431.115717-1-i@shantur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ken9Hfm1I5xt7br"
Content-Disposition: inline
In-Reply-To: <20231124120431.115717-1-i@shantur.com>
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


--7ken9Hfm1I5xt7br
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 12:04:31PM +0000, Shantur Rathore wrote:

> Remove Akash Gajjar <akash@openedev.com> from
> MAINTAINERS as email is bouncing.
>=20
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7ken9Hfm1I5xt7br
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6ONwACgkQFHw5/5Y0
tyzPzAv/XeBh20NvsN7iEzpl8gxxidsVoyT5vDTgQE2fCvm3gfVg+OKPKRLgymr8
3xukCW93bPV/H19SEs8mh7hinq0ZQW/iX8FBIAdCcij18rGh8SJHDXHJaR7SyqLB
G+ajeKcm9Mqk67Zeb1CKK9LLsAoqO/8+dqjctAQo+eQQ8be1JsUZ66/uoRNfGuDP
QfOKbDf5MrkE3Vco0GNYiEbShtgS3zOGeXzCBHhgocAcS49tXJYBTdUox1XvtuGc
djlHzWGRhiITaTzQOydYgD4UlHjlY9ZoA0O8ONO96cHJPJSXxZAXa4p+5XNwTJHj
lzi1wXEb2B6yrWLXwAoHABDNUb5tf0G3SJdQUD1ePxMulET5jXpDXrBIER/f6r9l
DuHgL/hcIAO4qtm0zPa0y4BTA4iaiE3ggK68qK43Ryjbg3n9zCpQlm1WOyq0BR2b
F5pqLO4Ph3R+s2Lt3+5naKCR5CEBWgOKCLTJiws6aKRZIU9P1cJgR1BxLONJ5NYP
hNfTUKQX
=77Dr
-----END PGP SIGNATURE-----

--7ken9Hfm1I5xt7br--
