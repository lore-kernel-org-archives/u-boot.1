Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0BC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BC787FED;
	Wed, 20 Mar 2024 13:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6kNt1C0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0034A88013; Wed, 20 Mar 2024 13:41:46 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD87687FED
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-609f060cbafso80112077b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938504; x=1711543304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=77W8zolL8k+BqtVnytVCm1FAAlSvZdn0KMXWblBUrsM=;
 b=Z6kNt1C03YHtL3XQYM62AMHUSVgl2/3TOPNOfd8SsyLQKFjItDl1waMJ4zArcg9dzk
 2v4SiWd3w8V1Q7V7fiQPHaxgkMdkLEHpwktGkfxjtV6UDFvqoNAO/CWaWrWcE9JuM4+/
 E9zvM4VEMrAxT/QNAB+MRJ3hl29AxiLxCgIiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938504; x=1711543304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77W8zolL8k+BqtVnytVCm1FAAlSvZdn0KMXWblBUrsM=;
 b=GsU5qf8hqpJiHq3YuIH6VuuFkKCfUljGBUHHzRjV24aAmNNcZRGPsz6x3EhX/z7cq+
 /PlMxxYjTjcZhz8Q3GlZRt7F+864TqZyXE/YBzpAka+HhjKOegzEluUWrospRpUUZu6C
 ERx5iFs76UTVRiNo3ZVetsm2f9FXHJMXwsAUCPyom2UNMrYu7MW4tuNFCCbUT6dCeA81
 7SoYUOlPhCxxbV7KIZjU8aF6zxpaHX+tGjx5gDESlOljjInsBe3e18O6NkDdSrx63fTI
 nykmyCBQVtkRh75GcX5Qzht5SlkyIxHzzdoYDe5JigqFEN9jA5mZ6GWSS6CqwHONjkoC
 0sPg==
X-Gm-Message-State: AOJu0YytLKFjl2gDraw+IvJcmAoyFUOsEIP8uxYGieptb4pOPc3hnzzn
 pjPnsg/HDxlukvjuWk5t2d0YiH75hWchEqDHuh3efu8kwQcHy7nGJikvlvfnrZ7ivJn7q8fj3zx
 G
X-Google-Smtp-Source: AGHT+IEK1rQEIm+uaXtEI45ipSJ4a6t4GJ17LEbhddKCVIB4HuoHDGj8CsPt043beuXPwU+BEekvww==
X-Received: by 2002:a81:8743:0:b0:610:fb90:ece with SMTP id
 x64-20020a818743000000b00610fb900ecemr805501ywf.4.1710938503778; 
 Wed, 20 Mar 2024 05:41:43 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 fj5-20020a05690c330500b006048e2331fcsm2726014ywb.91.2024.03.20.05.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:41:43 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:41:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH] arm64: gic: Add power up sequence for GIC-600
Message-ID: <20240320124141.GN3442575@bill-the-cat>
References: <20240306112441.1606878-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TS3j9PWCLOb23DBD"
Content-Disposition: inline
In-Reply-To: <20240306112441.1606878-1-venkatesh.abbarapu@amd.com>
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


--TS3j9PWCLOb23DBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 04:54:41PM +0530, Venkatesh Yadav Abbarapu wrote:

> Arm's GIC-600 features a Power Register (GICR_PWRR),
> which needs to be programmed to enable redistributor
> operation. Power on the redistributor and  wait until
> the power on state is reflected by checking the bit
> GICR_PWRR.RDPD =3D=3D 0. While running U-Boot in EL3
> without enabling this register, GICR_WAKER.ChildrenAsleep
> bit is not getting cleared and loops infinitely.
> This register(GICR_PWRR) must be programmed to mark the frame
> as powered on, before accessing other registers in the frame.
> Rest of initialization sequence remains the same.
>=20
> ARM GIC-600 IP complies with ARM GICv3 architecture.
> Enable this config if GIC-600 IP present.
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Applied to u-boot/next, thanks!

--=20
Tom

--TS3j9PWCLOb23DBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62YUACgkQFHw5/5Y0
tyxNyQv9H+n+4VBMJDUQzmyPkUSMCuBGoel8AD/ho9Ujd0M6Bkg7pWK8edyZsln8
NQZZHXpknP7FhRG80J/qJaInNNHp15l9YTZMkCzI/jayeAqSh8inuPqZ60JoiH6n
hvvhev/GQoCCHdI50giOyyDVMnNhLnbUqBClDh0hyZYl+f2/Rni4jjjtHSqMrrGc
ywAtLQkyOPweeej669EqEpA7WflGg41kcgYBgsOWsrYRIwf+Jj64pff6C/q8uYTZ
1GuT+9sbY6lmSgSeMO+oNMn46x5sRek7OvPl/wSP2Wy2dpl1E2rjCvzYKc0KjGIH
cSmIdaFFePbqode+avJD9TMCGG1DbsGWcmW2niQAnr2wDfboQ6v8C2h+/1eAZde7
IXzMDvk/LG1TACyTGaMa4MRqBrgSGHdSjLNK916SLdlPm5u/7YSHBVIszrJetcrs
LQR+jJRgksNCrLCdRBOyEcTJunz6TRBd68RVbrmE1iE5hmQ+ZTq+o/Za4bKRTAch
vtDz91iU
=Stjr
-----END PGP SIGNATURE-----

--TS3j9PWCLOb23DBD--
