Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64DEC83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 14:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAB483612;
	Sat, 19 Jul 2025 16:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YMMYmgNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9F683510; Sat, 19 Jul 2025 16:58:04 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6D8833AD
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 16:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73e810dc22dso1099094a34.3
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752937080; x=1753541880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0h2ZQHAB47Ls1iQRwy1H+MM6YjSY1r6ZvE47npbt92U=;
 b=YMMYmgNy/Np7539T2sl/iRRLJmeSBpZnCcq7qtBnhuDOHESG+uFfv4mPbSd3wZ78fp
 warYqt5b2t8/PMeKPBlalFW8ccGFpNoStzIDxqLnmcYb1liD2ARWZVyvk2miXSFSEE8k
 FqZF9HkFxutVJG4EoFKB7a7Mr4iMlsNEqDoM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752937080; x=1753541880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0h2ZQHAB47Ls1iQRwy1H+MM6YjSY1r6ZvE47npbt92U=;
 b=YkQ1rR+nLXqfsW1fYtt2Zw+wkUiZkCfkqJqPQTSIWNQaud1hJvM2B+jA3Nd1A8RQr2
 +ChOWNY4G7BhStnuPhsG6aO5w0h7DJZyIsPfW6D2ks062wZ/4BeeheUKZihgnNviXU/i
 Wq7EeCOA7nEo+dDwim4ZbW31O5h3Oec0ZTFUqmmucQyMyQ9J6ZkGFRcqSv+0V0tPjRYl
 tzruwei0IFhtyb7b5xjF5s7orYUzo7OqVq1NaTJZlZPaMKTdQ330Rb0V0PzdiAjhvMKP
 +BWgxqsRvy1WgNDZ1GCBw9EbWsuEVdE58WKxb72ACHwtObyPWHJ8K9n6QQ6NLRNjr7gB
 vJqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtk6cwMWTyuyDhNAN4jHkbGnR7bBYzrK4AE6YJEF680uc/oWduVV7ScgsfktcVOH8XYFS03xA=@lists.denx.de
X-Gm-Message-State: AOJu0YwTpZzI96uNX8B2ORjiDaE8bff++bxcu7tWLnK5UD6D8T/Nsqyn
 ZyvHEgBPdo/WkF0Kyd0Sznlv+AUUa6/q1ElQoTLNGDq6WCKdUKW949Y5/p86XXtbBdlPoqVuS1w
 ZQs+Fo2w=
X-Gm-Gg: ASbGncsYQ/dJXxCbesbIyKy9LWOQeqnmw28TshuL5YU5yq79gIewD25+7J8ZRfYuhq5
 RlGcfHc/wnqMRh6kF2C94egCUQgRRu+vIUHZn7Kun5SfPnitiui4d3ykF7VPWaFMh7Uh8mFsYKi
 NhlvKEoz6SrUQlP3UYxfIDxRLYgDO2EtcNFmdm84MHsAjsmOPJpCo2M31QAI2xp9TEri563Ppua
 3qit9rnLJ/dwedMIMy0+6qS2xEu0kxivv1vHzKGWx2RVxZtCaIUSnGQD6v9+U7+0yiNabZ8hM5f
 pvyjqPKsHl0T04Dy7r43rN4zRppVTOXb39874JaNp6e4lDXYOG0JPfjjxOgBhhVexP5ZC0t0EVg
 sj0jFABMam7ZUPv8/baoP2XAa8G0zmGtpLM3lfpBpl2y+okgqXA8eg8rQcsVRmOmuOug=
X-Google-Smtp-Source: AGHT+IGQrXiQvysG0gxGNh+X8ZsDOvu3pmn5clRYNbDcdY3tUnDoek5AQX6oivkzxJcdlgPh38kkDQ==
X-Received: by 2002:a05:6830:6f89:b0:73e:6317:5d52 with SMTP id
 46e09a7af769-73e66002a20mr13520323a34.3.1752937080201; 
 Sat, 19 Jul 2025 07:58:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e8366da85sm1395888a34.22.2025.07.19.07.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Jul 2025 07:57:59 -0700 (PDT)
Date: Sat, 19 Jul 2025 08:57:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/7] drivers/reset/reset-airoha: add support for airoha
 en7523 SoC family
Message-ID: <20250719145757.GY193579@bill-the-cat>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
 <20250719005717.113842-4-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OrI61TYPvn8XFlmB"
Content-Disposition: inline
In-Reply-To: <20250719005717.113842-4-mikhail.kshevetskiy@iopsys.eu>
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


--OrI61TYPvn8XFlmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 03:57:13AM +0300, Mikhail Kshevetskiy wrote:

> This adds reset controller support for airoha en7523/en7529/en7562 SoCs.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/reset/reset-airoha.c                  | 63 +++++++++++++++++--
>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 5 deletions(-)
>  create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en7523-=
reset.h

This is not the correct form of cherry-picking an upstream binding.
What version of the kernel includes the required binding, to start with?
Thanks.

--=20
Tom

--OrI61TYPvn8XFlmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh7snEACgkQFHw5/5Y0
tyzAWgv5AZH+3ep9knsCezekQqk+AlxvjOt7Fy33pXbTLBztS23M4pLe9oFgg4va
dEP758It/rhTi87FKe65HD5kzNv0Kl4wPTHNQgfsdOb/3ZiVlX4z3OHp+7mU9ML9
LK5pFR0lBlo1PFhWz6Xj6nnlMLsEEHdK2auBB0tWFTsw8fNFqLEDne4c7D8VI6tC
UIOef2WcN+gp7CeKM8IekO2ZW3gx6BfpaV+0S9VxwBbPPpMd7ze/NgawYv4izCLZ
n1MUEgjNIVQVxPav6C/DIXxiDmtw2fSH7M9fnfFmP3O4PzuRcyPYxna/igz8E2Dy
pBA/m4uSy7K8hTAbYI52sbCdW1R7I28vRF6rt9DKCQhADXNacrJXjCTbWH0D6y9r
p42GRarOkPsbVnf77ci7ECt8POKJ2UbIRjjoLSMMlNnIdx5XTx/QcmLwvJeChFFj
cJ5VXokp3WRb0PApkSqeR6X0HcAALxNuRSEaXuAwdhOlnv5eVyZCjN33FYgsQ4WC
q6hx0ewj
=m8S+
-----END PGP SIGNATURE-----

--OrI61TYPvn8XFlmB--
