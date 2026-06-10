Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24ECD98CC
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47C18489D;
	Wed, 10 Jun 2026 21:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cC71sMXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6737848D1; Wed, 10 Jun 2026 21:00:17 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D37584852
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-486503ae8f0so5358812b6e.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781118014; x=1781722814; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=esWI5oAiwbFwl/cyhVvrQ5Ii8MaW4r1OJDaD2jKLa9s=;
 b=cC71sMXIwfoBgNSwde9nBScQQruO/lQrbOt89hveiXIr+SVfVv5hMcq4ubxKN+u+2x
 mfngn7ywkdm3IaZPDQj7quBRHNycBVhoZKnho9RaujFc5giTqHyLHt7tOUDxfFbVjBIx
 +bXbCLc6rQxEyzx90nIHaeGc15ZLYoy5RLo2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781118014; x=1781722814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esWI5oAiwbFwl/cyhVvrQ5Ii8MaW4r1OJDaD2jKLa9s=;
 b=NyMkwplx1K6BvPBTYy/mhTdArix98sSLj5EppbbHRaSqBSKhrqbAHxo0SBJEgq8fy/
 G6ljVyVjmcAN8xG92fbYcN+U9O9vpcnM5zU5II2Eo7rkMEGp4ThUYuU2xPtkDWt0BAmp
 vQwgGOyz2bmAxU+4wogh2f01shbl+uf5ccaJOAEiurVUFTe8AHddt3DsZE0+VapuRuCa
 3ohD/0Pang10picVq7cYoiqjVaqai7RUk0+rDFIvIj9beb7pSYxBiohBWKFkJgoAcYrM
 /CJN8oT8+PI16Pr6/SRFySkhsmaDul9OP7H2a/K9szmPq9h7PCrv51R0+ON5OKQ60T4x
 6/Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v1UsvqGbmwOVJrCQxetlImFytDwj/iszYD2fvlHkdMfNNGgM4xnmNdmRDxZzFQvTATmxtIzc=@lists.denx.de
X-Gm-Message-State: AOJu0YzvAQoHrtj5BkHfkt1z3zxlMnyqH/vjGZxWeWaBfZQhNUfa4Yo+
 URB9NnUG6oB57g0MGF+OmMfUmK1aYlnpzzQoX4UKcSTczQVYmc3MbiVJF5VSgYqtFhI=
X-Gm-Gg: Acq92OEo5MyXxdheerhiroZVMAEVZkRGlmy4RuqyFfRUnJSCbvxjCoeh/je+Jktbwd3
 5YaCF7sroToo16mc2uL/O07GfGTyxov4PdfYxBmKY2PDkNB58ybelJo1yd8aGKzcYkU2XdwYBNO
 Igl53GFWQTVvqGYWNM79KcDlHXqGbCFMg4MLdf3E0s6lkIsILERWgDgeh8o3N3A1RLI7VBmW7Bf
 +9C9UsDx3zM+qrbSIKBsgk07I1nUlNjoEqX3usy2BLZL1e84pnuOQF9UG6brM88hLhf/PBqnR+O
 CErJ855AozqgDdOpJfQY9GSfA38Wb/zWZPlrvzyYvO+8wF99dIund7S5dqS8/6YOzqB4+cClb1b
 i7fa+Apk8rdrnVAprzn0UfPNQlnvBj7T5S4DBndPg1qVg3W4MvEOtq3G0Jwu/rpqJHDgOGLVjdm
 JB5BBS7XLkQp/eKHDhgK4oEWFZ+lNntIjzHiJi+txb2GdKgG2JfbNn7BmHu5SmIrjI8Mlb+ieEt
 reeCcoj9bPQmw5wKYl5QtmzHsDVyzebDTIy27ft8pYECT0ikDyr2UTqmFVKVg==
X-Received: by 2002:a05:6808:2388:b0:485:48da:132e with SMTP id
 5614622812f47-4868def1ee7mr16306486b6e.27.1781118014337; 
 Wed, 10 Jun 2026 12:00:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91f944sm19192702b6e.9.2026.06.10.12.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:00:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:00:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shiva Tripathi <s-tripathi1@ti.com>, Andrew Davis <afd@ti.com>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, vigneshr@ti.com,
 bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com,
 kamlesh@ti.com, vishalm@ti.com, k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260610190006.GD382693@bill-the-cat>
References: <20260522061515.GA8642@francesco-nb>
 <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
 <20260522162048.GA114365@francesco-nb>
 <20260522173637.GW1858239@bill-the-cat>
 <20260610055141.GA13255@francesco-nb>
 <9b1540d5-81dc-45f2-a188-915a8b4b4c90@ti.com>
 <ailsTM32enspRT6P@gaggiata.pivistrello.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gHvnU+RS2fQTqX0k"
Content-Disposition: inline
In-Reply-To: <ailsTM32enspRT6P@gaggiata.pivistrello.it>
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


--gHvnU+RS2fQTqX0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 03:53:16PM +0200, Francesco Dolcini wrote:
> On Wed, Jun 10, 2026 at 06:57:54PM +0530, Shiva Tripathi wrote:
> >=20
> >=20
> > On 6/10/26 11:21, Francesco Dolcini wrote:
> > > Hello Shiva,
> > >=20
> > > On Fri, May 22, 2026 at 11:36:37AM -0600, Tom Rini wrote:
> > >> On Fri, May 22, 2026 at 06:20:48PM +0200, Francesco Dolcini wrote:
> > >>> On Fri, May 22, 2026 at 07:49:27PM +0530, Shiva Tripathi wrote:
> > >>>> On 5/22/26 11:45, Francesco Dolcini wrote:
> > >>>>> On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
> > >>>>> On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> > >>>>>> This makes me think we are at the stage in boot where EFI variab=
les
> > >>>>>> are trying to be persisted to some media, and when trying to use
> > >>>>>> the fTPM for this it fails (as would be expected without RPMB).
> > >>>>>> So this should be harmless, but why there is such a large error
> > >>>>>> printout we need to investigate and try to make it less verbose.
> > >>>>>
> > >>>>> Any chance TI can help on this?
> > >>>> Yes, I am looking into it. The logs are showing up as OPTEE's fTPM=
 TA is
> > >>>> failing to load, since the eMMC RPMB isn't provisioned.
> > >>>
> > >>> Thanks for looking into that, and I am glad you can reproduce the i=
ssue.
> > >>>
> > >>>> Even though these logs don't affect functionality, you can revert =
this
> > >>>> patch to avoid confusion. I am checking if there's a cleaner way to
> > >>>> handle this.
> > >>>
> > >>> I am using mainline U-Boot, if this needs to be reverted, it must be
> > >>> reverted here. Given the release timeline, and the fact that this i=
s not
> > >>> breaking the functionality I am fine waiting a little bit to see if=
 it
> > >>> is possible to fix it, we have some time before the v2026.07 releas=
e.
> > >>
> > >> And for the release I would like to make sure someone has a clear pa=
th
> > >> on what changes are needed, if any in the end, on mainline U-Boot by
> > >> rc4, which is June 8th. We have the last one on June 22nd but I'd ra=
ther
> > >> not have to revert then unless things are just unresolved. Thanks!
> > >=20
> > > Shiva: what's the plan? As of now the issue is still there.
> > >=20
> > I have sent a fix patch to optee_ftpm[1]. With this patch, the fTPM TA
> > gracefully handles RPMB unavailability without panicking, eliminating
> > the memory dumps.
> >=20
> > For now, there are two interim approaches:
> > 1. Revert the u-boot patch that enabled k3 fTPM configs
> > 2. Apply the optee-ftpm patch in meta-ti recipes
> >=20
> > I am waiting review from optee-ftpm maintainers. If it's accepted, we
> > will upgrade the optee-ftpm in meta-ti to the fixed version.
>=20
> Given the current status I would not revert the patch in U-Boot.
>=20
> Once the patch is accepted in optee the issue will naturally solve on its=
 own,
> and in the short term you can have the patch in meta-ti.

Thanks everyone, we have a plan here then.

--=20
Tom

--gHvnU+RS2fQTqX0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaim0MgAKCRAr4qD1Cr/k
CteqAP9k8ar6RqLQDr80e/EhDDFYoGXAR1YCn7PP6PKiTeXxdwEAudm352GzrRZo
2AuhNsUGs3ygBRKDwjbpO3SfE38fdgA=
=gQao
-----END PGP SIGNATURE-----

--gHvnU+RS2fQTqX0k--
