Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFFE94115
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E871286D30;
	Fri,  6 Oct 2023 22:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aatE0h3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA522865DA; Fri,  6 Oct 2023 22:52:23 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B071E865DA
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a22f9e2f40so30354687b3.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696625539; x=1697230339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ao6qFvQJwNA7iOw6yC70NySbKhEkAIWuom18ntyoydY=;
 b=aatE0h3QEe/ZkRzo5/59scN+TC7zrISZzCRuSJfo9xCgmP2CDvTiJvox2dKg1KJ5ls
 49hPepxKMOt5pI8+pXBSGkNwMuaO8MWRU/WEliag19tsAknKjSe+UIkip/vaEPgL2ZiV
 HWI15gJUZ0s5d36mAK5iz/Q4+LWLaGm1pGUsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696625539; x=1697230339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ao6qFvQJwNA7iOw6yC70NySbKhEkAIWuom18ntyoydY=;
 b=arxiHydzcnaQrOkf0I203dUH41INZ5ksRWYEq/48QF4Y9Nv1UmRgzvBztNjXK4lIVN
 a1xwH7MW/O+2WmBxx3I6/6Qqni91e6kNiPHnK5hJgrlNwXPwOVc6l0tR7xKXnl0TBcNv
 fJXakpze62nzPqdMPBka25+cZebVqVR65JUG1WPWo8lg9V8ZcVAuGl/Il1pUgEZCKQhY
 ZFPgkrkShfz8v0FfVCXSv6lSpiiU67Py6gLWqizbnlNdtsQ6aszTnTKjw/SjHbEJiRof
 Jwu9ahNGtCUQj+cAbS6cHC/6RP46VHrHR4xYyNPrYOd7S079b5otP2nSbT4aLjANceOS
 t2XQ==
X-Gm-Message-State: AOJu0YyHRCpUeU28stN2HWV21UZoqmAxFrQvJ1yve9zDTpgeSBaTLFpd
 PIi00oKruof2E6WbT1vrnKHBmw==
X-Google-Smtp-Source: AGHT+IFbMc4s3qn7DNmmD8wxIZY8sxbaehAA37g3XXnrFTBSWMXSRRrvzMqMfDcqntSd2P0F1VS0vA==
X-Received: by 2002:a81:6cc2:0:b0:59b:5456:a9bb with SMTP id
 h185-20020a816cc2000000b0059b5456a9bbmr11067355ywc.42.1696625539277; 
 Fri, 06 Oct 2023 13:52:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-429b-02e7-f294-8f62.res6.spectrum.com.
 [2603:6081:7b00:6400:429b:2e7:f294:8f62])
 by smtp.gmail.com with ESMTPSA id
 i141-20020a816d93000000b0056d51c39c1fsm1520018ywc.23.2023.10.06.13.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 13:52:09 -0700 (PDT)
Date: Fri, 6 Oct 2023 16:52:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@google.com>
Subject: Re: [PATCH] sphinx: Bump urllib3 version
Message-ID: <20231006205206.GD2227687@bill-the-cat>
References: <20231005162738.3327197-1-trini@konsulko.com>
 <CAPnjgZ2w-u68LQSoy_0140PrkGDgrEGi+Wvypcunn0p_shfb6w@mail.gmail.com>
 <084eb86a-080b-4b0b-ad35-98497a290071@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="69RX45iJREq1r7Gc"
Content-Disposition: inline
In-Reply-To: <084eb86a-080b-4b0b-ad35-98497a290071@gmx.de>
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


--69RX45iJREq1r7Gc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 09:50:20PM +0200, Heinrich Schuchardt wrote:
> On 10/6/23 03:41, Simon Glass wrote:
> > On Thu, 5 Oct 2023 at 10:27, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > While not a direct issue for us, urllib3 before 1.26.17 is vulnerable=
 to
> > > CVE-2023-43804 to bump our version up.
>=20
> The same bug is also fixed in 2.0.6. Why should we stick with the old
> series? I could not see any issues building the documentation locally
> and on Github with 2.0.6.

There's probably a number of packages we could bump for similar reasons,
if you'd like to unfreeze, build, check the output and refreeze.  I'm
just posting something to get Dependabot to be silenced since I get this
whenever I push a branch.

--=20
Tom

--69RX45iJREq1r7Gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUgc20ACgkQFHw5/5Y0
tyxNOwwAtkaCj4KsVixv8wYw5Qd+hoCyc65bIv+lF8F0nUedXPCSePWJgPUVml1m
B4sDxKpb6VinXzK/EJac8cBRq3bw/kT2qXGWqFDsvLfkWjZk6rqQeVTfvTKl1cxe
MepH4r670F50qYux6UIIMdwpbIMdXth8zLSAE/u3NjFrUE88j3t1IpxhEAY4YwDN
2lUZCHH6K7B/IAAX7fbRCajoHTZK+lfG70EYm+G3/oiEbft7Y4t76IbKyjg9WU3Y
P6myPjtgHWcylsm4YLEJyVIZhu7oR5hEEuV3P4wktoQ8P8+0+g1/bajPjbSpQcxZ
PbwC9NqnnzhyctyJsZAAHxzd3GngXaXMx/zuqBdnYxHiwbYxEYBFNQGiOxD4nGts
1Jp0SROQ4enDbXkzxtdtIlUmrb729SAzJxDki6VPTqRCQS/OYys06QxH+RnRsqu3
8gwoKlydDHc8NXbSI7Xa+WQeea9KcCHfSLN8oHm6WyH+62zt4aYc5cIi/WlmuTqO
C4JI8cRy
=TiOY
-----END PGP SIGNATURE-----

--69RX45iJREq1r7Gc--
