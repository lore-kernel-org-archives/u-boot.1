Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC7AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA188714D;
	Tue, 14 Nov 2023 17:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gS5Iez9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7F08714D; Tue, 14 Nov 2023 17:40:35 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08052870FC
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77891f362cfso481476285a.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699980031; x=1700584831; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xu9KNEDGazPrl9Yb2KKoXEwsibJj77UZWfvTp/yPmhs=;
 b=gS5Iez9rvMB2Z3nGMPKJj06npzD75AOILLdWUQYwk506JA9vOUc3TkEqdgfMKQjFAL
 vEgY4coWK1ObUFNbG8K67uLDZ+aM8eY2AvRuWpv+jvGXuNwbrTD5gVwHrkQuRVr7bC/h
 vBRGjI9mYBoOKt3Bm01SjSlolPSgsGuVxF6/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699980031; x=1700584831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xu9KNEDGazPrl9Yb2KKoXEwsibJj77UZWfvTp/yPmhs=;
 b=NDQKPNDHjtIVWzmlFfApjrSsJagyHRFMutAYWbh1dPlwhOU0vrmCrcnR/niOBK0lvl
 t7KteoaTkbYzgkscGK5wiGynMMYATm0s1YGELIZV3CKBhyGCc/Q9D+VwTlmpmqEdMber
 1NA+3Zk/1bAbGyndEeOctDCfkTtwoyJQ83rADaqzxEpUp3CcHiJKgiQutbKBgnUn4POz
 bS2GMrhxu8aJ3oALxy34OGGGms3eyD2Tot64zEmYcKbR4FrRfIQmebaSxMTKuoPoyKNB
 rhNL10tKMXMZrl2pXjJUZnPMP7NA6yLKtpmsun4Zb34trPAMS4Crpt4UT5HYk/7bg95y
 QL/Q==
X-Gm-Message-State: AOJu0YwFwGVIIvshJC+ob8srD0lR4/15nT3knSEtAAbnP/Y3DmXsy+PO
 XUimQWJcjs7TJXyEvm7sCUfKPA==
X-Google-Smtp-Source: AGHT+IHly+yO0wNVsNRMU6bBLx0HokIFFLlAz4J1wWcXUM3k+G7ST6LJrwVHbBaFX92gzRYwm3u6/g==
X-Received: by 2002:a05:620a:d82:b0:775:8fab:8c6f with SMTP id
 q2-20020a05620a0d8200b007758fab8c6fmr4686650qkl.29.1699980031654; 
 Tue, 14 Nov 2023 08:40:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 bi8-20020a05620a318800b007671cfe8a18sm2793472qkb.13.2023.11.14.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 08:40:31 -0800 (PST)
Date: Tue, 14 Nov 2023 11:40:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 1/5] image: Correct load_bug typo
Message-ID: <20231114164029.GY6601@bill-the-cat>
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231111204954.v2.1.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ltIaKB6IFsTgHKPM"
Content-Disposition: inline
In-Reply-To: <20231111204954.v2.1.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
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


--ltIaKB6IFsTgHKPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 08:49:53PM -0700, Simon Glass wrote:

> Correct a typo in the function comment for image_decomp().
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ltIaKB6IFsTgHKPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTov0ACgkQFHw5/5Y0
tyy35wwAjrsutNxAcEKLsK4MVZrYn6NeHMtxLfDMvrFl2BORSsGTRfxYMkPgqscm
5NG/w1+jPFKIVXcHm1thPwNbq6boXdkPDfmUI8Mz1X0OkTuWPq8Zq8UnzO+P6D4X
QzGWk4M93/tPJC7/3XfvLblzV9Y4WnJxi0BiGeT6wYU0I5RXF+RhqDBrb5dlanSu
eM1Vus51kpg+6ZLZ8zlz3Op3yjWMfYC/+Bas4M+FuVuyjXWmL6PF9oD23nL5NCEA
3LqZgjExCjSSR9Ew+Y75Pv3ZJ+VDPok8ClH9vWij+SIPTWR1bpAWTFG1gDI7I9W+
44JDgoe29RVBp7mBwijslEk3mKLWmgu5H3Vzah06xDToQS0liHp0iAkF7v0WoFGA
8lVv+H3pO+U/Bs/7D7THt8ssRynpkbT4C2pWmSRlFja6Byga17cZPnecYnrtkrKQ
YVtokOf43HUOhPPo5wp1wte2uj5KSMkyqV9d+OsDs1azSZenxa5RCnSDqxe8R50l
wCIqhV6Q
=gzg3
-----END PGP SIGNATURE-----

--ltIaKB6IFsTgHKPM--
