Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5709C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA278780C;
	Thu, 21 Dec 2023 22:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nsaLKY4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D333869B6; Thu, 21 Dec 2023 22:07:36 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EBB877DE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-425a3cdbda9so9072381cf.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192853; x=1703797653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7UpeT/h4qRm2Cw05z16Sv2Wx6LmKwF4ryvg9c1pOC8I=;
 b=nsaLKY4Qm2vwkGcawSObs3pT8JADrbW8IeHWq9Z2Fcewq/V88n8gmSwN22PUVe+lOl
 D8a+a7yTUUo4BpS7TtpY3rmUJeplwhSzwQFZO1X8OLAi81Z94P6+48+1CBP3j0dJRx2l
 pNICCqjeKeAlDrObcKE1pUM4/0SnEb9QLW/UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192853; x=1703797653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UpeT/h4qRm2Cw05z16Sv2Wx6LmKwF4ryvg9c1pOC8I=;
 b=IAYsef8/sGw5VKZK9Q3cn1F09zNZNVpajbYEO+whwOMg6F0uftpuUnzlpapEDhEC0S
 qAyIDN/D4AmngURvgtRzPQQ1EUZqbBu+IdFSrus+hXgq9JMJ31yOSNeXtI7bt+XLMBlH
 vkfbKBaVB1VTkj3EqkqMOdsKchZtzdwzNr6LCL8p1XOMrD84UX8vmS/AQMQGf9G+SDAQ
 lGWU6hwHbL8p+TT0P0QNTLqjj97KE9HJhVr/NNk1SQS+JI9BHQaOLX9Gw56FC1sJ0o79
 YEiv5W6YRe0XZahDU7aVf5mKT9dAmAS2D6CxIK5CAlCUaEdGweXzLf0qbobWH8yiETX9
 3JCg==
X-Gm-Message-State: AOJu0Yy9IcjpFlWcwikMICAEPn7aT2lO5JGmdEZDvfB91jTfJNb2taWw
 4kGEhjANmJYWcKdFkiOnh6WRsRhnMnhG6g==
X-Google-Smtp-Source: AGHT+IFQUqHTp6bLEuQpaELthWNyTiUwW2Om2vfX59faFn9O2vMvsRqxUR7OZapG6SevLzVHeKBHhQ==
X-Received: by 2002:a05:622a:94:b0:427:8e97:1054 with SMTP id
 o20-20020a05622a009400b004278e971054mr607605qtw.50.1703192852953; 
 Thu, 21 Dec 2023 13:07:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 ks22-20020ac86216000000b00423f2acc614sm1148327qtb.87.2023.12.21.13.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:32 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:30 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Haijun Qin <qinhaijun@eswincomputing.com>
Subject: Re: [PATCH] lib: rsa: Print detailed error info in rsa_engine_init()
 on engine resolution failure
Message-ID: <20231221210730.GV2513409@bill-the-cat>
References: <20231214165416.35354-1-csokas.bence@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ehtVfohFWLLO4J+N"
Content-Disposition: inline
In-Reply-To: <20231214165416.35354-1-csokas.bence@prolan.hu>
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


--ehtVfohFWLLO4J+N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 05:54:17PM +0100, Cs=F3k=E1s Bence wrote:

> Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--ehtVfohFWLLO4J+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqRIACgkQFHw5/5Y0
tywBeQwAlVNmYDIzZ9sTlINQMqPsV+RNob2bsaxbh0Fywl5Zc7zSot1+qImHc6c7
YdHpZt1/ediyGL8K8H/emETlbJ2x4HdE9gweiQG0/CFpvQrQixUZlsr9m1zzWtI2
spY32ufxi1I4WEBOzBW1arlNwtzd7NfeKMkrlF4OCXmchYL9UvzdU7fN4xQ1xOjF
Gok714qg1hbGuhXtQ+ObEZ7RVdBWkbSZHI6r8HOss2eD8JsR5riNIvoPSZJeMBY+
LDQ0zTJU3TdmtRlGzr0T12lS/Dx81GR60oSN+LIn3obp55AUCepF/2QcjVS9C4WM
6nRiNxm0EOI59zAV1O1F5sspFfeoXv5EhDnmQfghXrowFnKXSW79TYbhbqelaCwg
hknRih4q+Xj3x35iE/1xCL2kyqALxfW/df++aNAZXPFNyvIgTNW4Fjx/kdDuDFzj
Si9qJQbXtCdwts2MH+YtXerN/OwleQbJBiHJReFGBGwF8CCaZDdSDDxdWmbpVZZx
AniYnNcW
=qKFF
-----END PGP SIGNATURE-----

--ehtVfohFWLLO4J+N--
