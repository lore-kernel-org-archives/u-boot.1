Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4722C54E58
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306A687FC6;
	Thu, 14 Mar 2024 01:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rVvu5fPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2753587ED8; Thu, 14 Mar 2024 01:40:25 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA335876E4
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42ee23c64e3so1901461cf.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376821; x=1710981621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JZIIOOZ1J9w/tIekUCNRFCN1v3ijka7v/QxW4IVjmQM=;
 b=rVvu5fPtX+bCh8qeo+t+2mZ2ZnSaz72zc+nDYhKep03rfTI3/qQw1IuLgRqfb8Rh8F
 cgL1BoXLQYI8eoPfKk1fbTENei8bdxakScAcS3sOwqs0QwD8dNM8kMciBVDkih3E3GIO
 iLVFRapMxtCcTOBs8qMJ2RB0FQhfIMESRHee0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376821; x=1710981621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZIIOOZ1J9w/tIekUCNRFCN1v3ijka7v/QxW4IVjmQM=;
 b=wmruZLL6IkLfKUtWzsvArprH1Kj0HKGkDaTI2GoQqUOSuIYxWAnpmDB2Sjvi5u+p2Y
 IGzRHhWiCS5VKlhQYm9IOww7XXbg8KleS8EQIo9PPmKyyJyMbEZXzhe7ME7ZLBec4YYH
 CX9njr6y7rjNui98d/mAKTB1e3sUgVPpjxJ2pmR04zltasgvVMysbYOe1L6yL5rgSsfS
 gloEPI+XYSBjeQPo8jAMDpHmnBsf4mfNnyyn4pNzm0bjV4WWWpEymgO4ekbOz1bhPgt8
 oPVQE0Tr+41WXIGrX42gCTrq+mPPbx+k8Y6CKK4jAuVzNg6aLaK+zli+ia+YksNrkZy3
 quSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPFsoaHN45dDUl3hDjHvCkoIPEk1tDIPQ1IrLYC0VPA5CQaPfbAxtU2o+L1gE3twP2YsupxZnAwy3UZ9hhYjK8l17k+Q==
X-Gm-Message-State: AOJu0Yx1HxSNFbivj7hN3fKf9rO3OTKCV4aRE343uASXljeguxy9rFlE
 NJAhqMfxti9xbXIqprooQZkLOdymKI6JG58juLlQ0d7rjUO9ZivTjVnwVV3zJhM=
X-Google-Smtp-Source: AGHT+IEcfYiAHhY5a791dGrOIUrGW2RRHcEeS1d5Xx8N2sH8s4j4KdhC9Sp82hCr04JzR0wxijLOCg==
X-Received: by 2002:a05:622a:50b:b0:42e:cc0f:8f60 with SMTP id
 l11-20020a05622a050b00b0042ecc0f8f60mr286603qtx.8.1710376820650; 
 Wed, 13 Mar 2024 17:40:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 s5-20020ac85cc5000000b0042f01390d5csm137094qta.30.2024.03.13.17.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:20 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Joao Marcos Costa <jmcosta944@gmail.com>,
 John Clark <inindev@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rong Tao <rongtao@cestc.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Jason Kacines <j-kacines@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: Improve generated_defconfig file handling
Message-ID: <20240314004017.GO3442575@bill-the-cat>
References: <20240308033822.28727-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IkP42I1/212VyMVI"
Content-Disposition: inline
In-Reply-To: <20240308033822.28727-1-semen.protsenko@linaro.org>
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


--IkP42I1/212VyMVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 09:38:22PM -0600, Sam Protsenko wrote:

> Commit 2027e99e61aa ("Makefile: Run defconfig files through the C
> preprocessor") adds `generated_defconfig' file, but fails to clean that
> up. It might be useful to have that file around after `make' is done,
> but it's better to clean that up on `make clean'. Also we probably want
> to hide it in `git status' list. This patch makes the described changes,
> and also adds `-P' parameter to the CPP command that produces the
> `generated_defconfig' to avoid generating linemarkers.
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 2027e99e61aa ("Makefile: Run defconfig files through the C preproc=
essor")
> Acked-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--IkP42I1/212VyMVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR3EACgkQFHw5/5Y0
tywNmgv8D8BBzcHumTO2Rk1u86Y5eRLQSPwT5xtp+5Q24aHOZfLJO2GSXH1bX0nH
vmaeh/izg1vN+hT5ZLH2GJEplNwSYACbkWaKWe7VRj/pxF3zcail9M3e+wkxgm6n
fcfIg8IcbRr10UOQW4wJ8GzU/I+WSkfVweBGbfLtE58mqZr7vyUYg6ww9ggVs7m8
dVHHBy4/Yr33btPOTTevmMZ2AKpKN3J9nvLBnt7O4HxF04Qpuc7mjVsh3P7KCADD
t/8GH/jvbTHeK5KUWc/sNW52PXREl5av8y+dnjovgh4ua8NOqi4EN0o2IVJO47C7
RUd/pxyfwwSzikvVhbnIbg0qXjTPcG/B1MjlQGICFs/fdDg2pcfWs+oroyHJ6K55
ImolsjjPuqq70dvNqu6bFeaUlZhbZEhFQo78M9blVLYqBnRjOlgovpLUVw9gz2+N
WQgaJwmthQq2RmA2v0NT1rMkmmyr/X0vkoUG+bxjUjNI6J9vTMb1dCVbkUZAAd0R
vCHTMoVF
=ez54
-----END PGP SIGNATURE-----

--IkP42I1/212VyMVI--
