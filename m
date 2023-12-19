Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA34C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A86A875F0;
	Tue, 19 Dec 2023 14:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uDGE/taN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC4E874F3; Tue, 19 Dec 2023 14:42:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7F1871CC
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e784ce9bb8so7761327b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702993354; x=1703598154; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=49+SFKPwdnMSyKLKXbFjCCJzCMUuXJzSeY/WRH6pqBY=;
 b=uDGE/taNH6oO7DtMhXN+AlRlGUUnqrvNwB+SqP6u3maw3LfciaMN3L67tWvMA4RLG9
 t4Ins/CqfqndKXkd3MMVfvteWEI6tLqWOTSFyh+cSKge4jmHPVw/IqB7eyAx3HLPq42n
 RARuA1snU0vknSI2wPyZQQF1+P7sJ3zav3/eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702993354; x=1703598154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49+SFKPwdnMSyKLKXbFjCCJzCMUuXJzSeY/WRH6pqBY=;
 b=QN7SJ5Li4LIShPhmF5WdsK9oF8NHkQDHfYu03MRwftiljP2l5VFglYnUpzGRB28KNR
 0QKl3NAKZAafOKik5ODlo/BXM9rlfQfqL++m6XZRTAcugQNyNh5Pb78EnMXKeyqL8W5G
 n4BLuTAaoSJWVdblwI4dMojhI5x1j9qaZnhB+vstZgj6jR9fpTS4SQjwW/TMNihQBFeJ
 nK7fo8OuP4f9uyhRg1ybZy/qy/+3y7fKun0TG7yVqPfAsAt4o2DgKqf+vKGR9HjHCcY5
 Wl0O4nUpF5ZvY7RftGYua2yrxddLziimVf//Z0CfGTe66vVbk+5DlNxYT2G+O0pgY7Rm
 8PxQ==
X-Gm-Message-State: AOJu0YzTULglXCfMVV7ABy9IFg7QGJFPVhcZqJOc1weanMhamjUZVvHq
 ndjNl1orskqoZ27nZw1llXv7rbOyX99qhyevbRMpRL2b0ik=
X-Google-Smtp-Source: AGHT+IExks1Agi+/6Z6QLjkNKfqVZ031GKyd5ilJ0I9jQNDuctVG9ZJujonUvYAW4r/n8F3SSADVxg==
X-Received: by 2002:a0d:eb53:0:b0:5e2:78d8:f3a7 with SMTP id
 u80-20020a0deb53000000b005e278d8f3a7mr463831ywe.7.1702993354411; 
 Tue, 19 Dec 2023 05:42:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 x125-20020a817c83000000b005a4da74b869sm9759178ywc.139.2023.12.19.05.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 05:42:33 -0800 (PST)
Date: Tue, 19 Dec 2023 08:42:32 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Haijun Qin <qinhaijun@eswincomputing.com>
Subject: Re: [PATCH] lib: rsa: Print detailed error info in rsa_engine_init()
 on engine resolution failure
Message-ID: <20231219134232.GU2513409@bill-the-cat>
References: <20231214165416.35354-1-csokas.bence@prolan.hu>
 <20231214175402.GN2513409@bill-the-cat>
 <7069b019-cc2b-46fa-b293-034e9dbbc698@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m0LQ66YOIrYoU0Oj"
Content-Disposition: inline
In-Reply-To: <7069b019-cc2b-46fa-b293-034e9dbbc698@prolan.hu>
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


--m0LQ66YOIrYoU0Oj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 02:38:59PM +0100, Cs=F3k=E1s Bence wrote:

> Thank you. Just one question: When can we expect it to be applied?

General rule is at least 2 weeks. This will get pulled in for v2024.04.

>=20
> 2023. 12. 14. 18:54 keltez=E9ssel, Tom Rini =EDrta:
> > On Thu, Dec 14, 2023 at 05:54:17PM +0100, Cs=F3k=E1s Bence wrote:
> >=20
> > > Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
>=20
> Bence
>=20

--=20
Tom

--m0LQ66YOIrYoU0Oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWBncEACgkQFHw5/5Y0
tyx7jQv/dITq35nrUSdE9C20NUCsZCyQhqPlKpLyzH5J3vxgg+tj4X6isemt0dmO
UScoGg5/cZyh0Q8YJ0IBMR4Clf2fvmnfShRMqFfRk5BcsHkNeT0EqF59spgYaDP7
/m5bnz5tv9GUDBR0eIeptU+RCDr8yTk9Zz88nPhoSA7jJxgIv0BZM1qYibeAnAzw
p+0v8xAZRhomYySwZY/iuWlURGxXoYDDWe/tazxPoZerm/GCG7xGaQg1huCLmvnP
/AsbjOBpTG27Kmk/w+oldz+N2S90tP3XAg4SPCCjhgFyqu2NEUSMyOtjDpdHViEB
GB9xcv02ccRMNxaLmObJGv8ntD165vPqYEiUi3j6G9m+u1Neu5MoBpMqGI/nNYKe
hA++Rwm6qEuIV4ZxuiZ36Ke7QCCczRFpPbL++Rh4EUloNfJTpGQ3/Md9LZei6wqF
xGK40ECeJL9T8XX1w83OgO7ZZJnsg61XZ3Bsk2e3+/d5RDp1qc0K13ouLhBvBNdS
V87JOdCy
=RaU5
-----END PGP SIGNATURE-----

--m0LQ66YOIrYoU0Oj--
