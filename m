Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68033EDEC50
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A417A86996;
	Wed, 13 Sep 2023 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J6qgiRf/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8AC860C9; Wed, 13 Sep 2023 15:21:31 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198EE860C9
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fc4eaa04fso70311857b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694611288; x=1695216088; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=POK4i+17T24psBo2j5We60YnyeBtVNj4Xo8bUDJRXnU=;
 b=J6qgiRf/0auWbZjvTTm7rxZUUUxeL3HoX6Ps4IO+sC0YXGFOucKme0ZQpsJfEci9Lx
 71gUCwIx+5WQKMGQ7e2qtpoKO838jwjCvoXteTZXtjpR2jx9HgiEmVFBTNqO7XbAH4Gh
 q0PFlzRtGdZVTNkRgtxYVZtHCmgN2ZDbIWw2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694611288; x=1695216088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POK4i+17T24psBo2j5We60YnyeBtVNj4Xo8bUDJRXnU=;
 b=Ix5GD/gnjV0fk7wYcuda7vqRKqmHkNq/rrtljNXO6J7SJudMEIPluH4VS1GwALQwhI
 +AgYU5UJRLectO0VZn3fZykEit/3nvzCxlGr6n9Bn5dWF14UQJhmBpN8ozrJOMu8dMfF
 RbjLD+y5+MjAMTdVbfdeByAuiygV05ueAcjo0XhnwcGhKpSwn65JTMGhB43w1r8bIQBg
 JbW1e7QF3oZfHCB+JCYFMLZfj7u6HhPhTOuZEjRoWUzttaWVNS8Xd8wrcSPrQmvc612g
 BWRqVQOfHemaJJl+37lrtIsdGTg+npObHQvj2qX+FMfSBj7hjLXWObrNsixPOArHwQru
 uvRQ==
X-Gm-Message-State: AOJu0YzXT/lea3P9Rqs46sZRRChu7Ii1WfkWQp0s0BN+7TN6sKGfQ7Y2
 feDl1lhxHgEfxzubKKNrGxy73WE48Efoh1ICD67jtg==
X-Google-Smtp-Source: AGHT+IGnFRZRIOYbT2C1MxDWO7fqd1HDpoO244DfGH8msMZYjOFuanskcyTnlhZGRrEb0Ru5p88Ngg==
X-Received: by 2002:a0d:d9d4:0:b0:589:e7ab:d4e5 with SMTP id
 b203-20020a0dd9d4000000b00589e7abd4e5mr2625871ywe.0.1694611287867; 
 Wed, 13 Sep 2023 06:21:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 g140-20020a815292000000b0059b1f6d1959sm3067127ywb.101.2023.09.13.06.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 06:21:27 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:21:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1] CI: allow jobs to be run in merge requests
Message-ID: <20230913132125.GJ305624@bill-the-cat>
References: <20230912110022.28420-1-andrejs.cainikovs@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v4ZZguVaUvUDoz/h"
Content-Disposition: inline
In-Reply-To: <20230912110022.28420-1-andrejs.cainikovs@toradex.com>
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


--v4ZZguVaUvUDoz/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 01:00:22PM +0200, Andrejs Cainikovs wrote:

> Out-of-tree users could run an out-of-tree CI with limited coverage,
> however it is convenient to be able to run the upstream CI from time
> to time. To enable that we would need to change job rules to be able
> to run on any GitLab event. Excerpt from GitLab documentation:
>=20
> > Jobs with no rules default to except: merge_requests
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  .gitlab-ci.yml | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)

This seems fine but please rebase on top of current -next, thanks.

--=20
Tom

--v4ZZguVaUvUDoz/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUBt1UACgkQFHw5/5Y0
tyz8/Av/Z2acTNY/XivUvcyXyrryfCL3GT3+WpHgZUaG92sAGoucR4RlJLOHoCtA
9e0PMh7XA7iKK1IgB+wO7ZROK4v/ndQ2XPpUZ0+CQEXDMQGzPsCTUmRwlHJaonOB
6kPCAUPcTVKZ27tZ2UNMhFgghpaO25XHcF/5KG1JaNzqUSfKiPiiedivxERSROif
6e7WRNVqR9Z4ebTt08d3VFSVKPwW17yYIHzZb2Yv4DvqJFgkc8NiKOC8kztmtgSF
jljEHxhlcsaY6U3SA71fqQT4tafsVWfGRiA3H0FVtws6DEldOi0GYMl3GJyrbBIt
7vPQft/y9vo8B8/d6AT+Kp+eHZmOtr9WtslJPQ9KSJMat2mx4IMnHRQc7+zOD3Zc
++Q6+aJ68Mdn+6wJitZxFwNv6tz+mt13+T2QBxUBCj+HeB4YQfdkAF+JMLeT9udn
SC6IKmobTOA2vQ3yDbcQmV7TLd10ZuILtvPr742wcTGPeHMg6w02AS+DRjqaM47i
UlpZXAY5
=2Dq2
-----END PGP SIGNATURE-----

--v4ZZguVaUvUDoz/h--
