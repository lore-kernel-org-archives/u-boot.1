Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B106AC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2848D87D89;
	Fri, 19 Jan 2024 17:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R2Phni+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B5F87D87; Fri, 19 Jan 2024 17:10:14 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79C887D88
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc21d7a7042so872701276.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680610; x=1706285410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=znb2SgwRDUK0IwcgqWvhMtJeIsO2H2JLcWByQXN7iYY=;
 b=R2Phni+If0pM2Whip+GxNhjjtp2pJYNJvQtQJZf2Mtmu11/0J1Y6rOAigYTIhk0kcD
 zTtphV3etgaQ6Kj0uRZct9Koo7KEaIweVCdtk8mCM6435za79SdbjwAsYFWd/im1jVy1
 OaQzJH0YfajCSRJIGpT1w6MWKoDLv9HV0JAMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680610; x=1706285410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znb2SgwRDUK0IwcgqWvhMtJeIsO2H2JLcWByQXN7iYY=;
 b=OVBPJOFASb6UQn9J8x/R3/zBF7ypmcLoOLShzYwe/MGGWeDZPymelBorU4FoQ0Ct19
 /h7YG1kt6/40KGJ3jFY+cQrCceIrFXvDc74I7JyreW7lhaA2GeU2//TLuLGGANti1/Kc
 dpVDP8YPDZkssm2YoEMyCGSAKpWnPsL+HgWszmQTixcyNXaFU1oxTj/f8JhO25CBTj0a
 PNLg+iY7OAtGTyEKJyBpbcYxKAZPrpJfH8+9pYPROtrmBxDITKJCy5JMbERPykiKLXdl
 g6cqxBi8hvQRWgS4riP40HWUHuxjr0Xc22FUSRTGknbaY47fuBfKnJPbecPaoEJeFwzg
 6c8w==
X-Gm-Message-State: AOJu0YyJenPydlsjymmmmKJF6RlMtZNr8h8HRgmghHAeBUko2KxhG5bL
 cBdk0CdYgl+QGX811O7ilnNYP3oRfIB1MuLeCFnpbGgmI13M5zUz3ykDk4OyivYsQl09FfRdqZ8
 q
X-Google-Smtp-Source: AGHT+IGrP8SxX3rTpkQoRpxN0JDKfjIO54W/pInmuRZwxk+dJZW3k+1XBhdNUMskvF1sI3URfWiSVg==
X-Received: by 2002:a25:dc03:0:b0:dbe:9509:141c with SMTP id
 y3-20020a25dc03000000b00dbe9509141cmr116692ybe.30.1705680610592; 
 Fri, 19 Jan 2024 08:10:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v8-20020a25fc08000000b00dc23059cbfasm2552957ybd.42.2024.01.19.08.10.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:10:10 -0800 (PST)
Date: Fri, 19 Jan 2024 11:10:08 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] getchar(): Correct usage
Message-ID: <20240119161008.GK12635@bill-the-cat>
References: <20240109225716.3520037-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUTQ95XIacQGsr3S"
Content-Disposition: inline
In-Reply-To: <20240109225716.3520037-1-trini@konsulko.com>
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


--UUTQ95XIacQGsr3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 05:57:16PM -0500, Tom Rini wrote:

> The function getchar() returns an 'int' and not a 'char'. Coverity notes
> that "Assigning the return value of getchar to char ... truncates its val=
ue."
> and so for the most part we can resolve this easily by using 'int' as
> intended, and often used throughout the codebase. A few places are not
> so simple and would require further re-architecting of the code in order
> to change this, so we leave them be.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--UUTQ95XIacQGsr3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnuAACgkQFHw5/5Y0
tyw2sQv/RRsLFk7zLqTn1pPABZD9mrCAMlIEdl22wYkkPp1rk/ux82EwKvWzCpG5
BU5IJgkwIMBLpdHwz35GWXRDyHgk4j73JhsX4AIKP6IQmtcFw8yRRvDfZ54EBObE
0f1WNWzhVQa/GOukh0CNM02bcHW2f2qq1WnlT7J4cbDkHkVNzD0fpUEqq5LrcdDD
Q5hVEbfVROO+Kv0cH0VwXBUEWpfs4cubLNre3tDH2cSUMqZCw9laQ7+XKnHsEbqK
GppmhCQ3KlO6U644k+jhFKKlSgQeNF1bzOV2PE2YPbKzJvyWvpGsaG6Pt3FxsP1q
IkxkElWZiSX8XzJkZKyyiqSOb1kqsmpGTgRbcnDaiN1crAhOM1B2/t5p+x7ww5Ao
wxOTmmgYc/l4zoPdD3Y84HDXPexGeNXP0PTsgpYxz9uiMEZ2UATEmli4YE9005SZ
PUj6FUSVOx6+DegXzM5d/yqqwaKELXmm33YK8smG+ILZk0hh9HXBMt8ojTJaaVyP
t8Im2C8m
=RBTD
-----END PGP SIGNATURE-----

--UUTQ95XIacQGsr3S--
