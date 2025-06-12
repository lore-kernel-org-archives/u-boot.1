Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0FC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 15:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03F682B70;
	Thu, 12 Jun 2025 17:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GHjyEzOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9254282B70; Thu, 12 Jun 2025 17:05:35 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B3E5828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60d5c665fceso554877eaf.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749740732; x=1750345532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U0K15BfZBAgqX/jTvBoswhxbYUl7qJfjxDjedF37tzQ=;
 b=GHjyEzOKQbmdQlzwoRXamFw0+4d09bG5AqByBw7aHcnHCg4t/yGyv+tQE2goPiaq1f
 EAplhCqyo4QWerAqN1GODpuHRrFMp66+vsWKs9ieUrXup4mQEHjry1JfVst7s6Jic0/Q
 5nkuy/D6N+Dqna+aMmlWnWY6sRIsYykagDyD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749740732; x=1750345532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0K15BfZBAgqX/jTvBoswhxbYUl7qJfjxDjedF37tzQ=;
 b=Of6oki1HaLRXecJ6/X2wbqYuJfbCMP8UDDVWNvfLBjRhLiAnpnAmZBTvQyhvynpmQb
 zvaMI3pTFyY+7zGBIvmGs4GDekwKvJcJtrwYT5ZEs+VNDSoZgFZuFJgfo67GalMWZP44
 LpA49kCntN6SWmZUqX4oAn5WHvLb8Jg28k1zmeC/tZEjmqkUyQ0UaeezvajNmb5bqP24
 aICBT0SYdZn9BESDgh4s08Ri3LnXjZstNh0y/q0GjZPDRIIOQIbI0v6083y79PiB8TNH
 ASjlXhbOKaO2UZ8zv5PQCTKu3U9jvLIuLg9FgbONpkyWsPZ/5c+YEM5595gWd1JHAnDY
 C16g==
X-Gm-Message-State: AOJu0YwCYVbPG+N1uLdneftVHrT5yfQYxI3jQVZHLpBaEUcckm0zZK9W
 GEXyaHm7+5cUfvfZegvOw2qjrIWPzp6NYwG0t3vT/EJcznPQydvhkRly1zNTL26Lyhw=
X-Gm-Gg: ASbGncsqchnJkEkaCaM4J2xf5pJ/YF1eFHn4YvqL8lhh/jot4620OFBl7545I6PbZ/p
 Fc0XrDyFYteJHNk1gklu0ZM2nBR94nAxTIgrIEjA6j+JbhQJpEJ5g4gbQKSBKFl2kZN/cKfd8/n
 ziuQ0iCSWeyodiYU3Hm7kpOwa8HViNhMJXkJkEMZDdibvHK3mMFyevULuuUFpHf3/i9gwHZSDW4
 swP372mtiKIza5OZQ6qZqbvWmPKNUddZNKBWj2iihtQly60QT0ws9AoLmn4aaoVqRc9YCqGkQNi
 Du9nOXJy5Evov1VcM+kP1WkcyIDE320fmWQHegmrBxfbTbt29r+ZDDxXBBu0nn+qIkWsb+vC+nc
 ej9raIaiWYAaChwYDtmKCX8E=
X-Google-Smtp-Source: AGHT+IHYi+5axosDlyOTqxxEITLPf+XHJ9Mn2MKwpwF7JoKUMTbLjyYyw5kYPEs86T3FwAAA8HNtMg==
X-Received: by 2002:a05:6808:3318:b0:406:6825:da34 with SMTP id
 5614622812f47-40a70b274a4mr210567b6e.16.1749740731707; 
 Thu, 12 Jun 2025 08:05:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a682fb574sm321638b6e.30.2025.06.12.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 08:05:30 -0700 (PDT)
Date: Thu, 12 Jun 2025 09:05:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Message-ID: <20250612150528.GN1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat>
 <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
 <20250609145919.GN1382132@bill-the-cat>
 <DAIPP8VS7YQO.3PK5EYRE3D11A@ti.com>
 <20250610144444.GY1382132@bill-the-cat>
 <DAK9XDDNWUX4.1IRWBI9YA4MKG@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WjGbTA2SdHJYfxDv"
Content-Disposition: inline
In-Reply-To: <DAK9XDDNWUX4.1IRWBI9YA4MKG@ti.com>
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


--WjGbTA2SdHJYfxDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:05:38AM +0530, Anshul Dalal wrote:
> On Tue Jun 10, 2025 at 8:14 PM IST, Tom Rini wrote:
> > On Tue, Jun 10, 2025 at 02:01:59PM +0530, Anshul Dalal wrote:
> >> On Mon Jun 9, 2025 at 8:29 PM IST, Tom Rini wrote:
> >> > On Mon, Jun 09, 2025 at 05:38:37PM +0530, Anshul Dalal wrote:
> >> >> On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
> >> >> > On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
> >> >> >
> >> >> >> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b44=
37bc
> >> >> >> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older=
 32-bit
> >> >> >> HS devices and can be enabled on K3 devices.
> >> >> >>=20
> >> >> >> For secure boot, the kernel with x509 headers can be packaged in=
 a fit
> >> >> >> container (fitImage) signed with TIFS keys for authentication.
> >> >> >>=20
> >> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >> >> ---
> >> >> >>  common/spl/Kconfig | 2 +-
> >> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> >>=20
> >> >> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> >> >> index 77cf04d38ed..bc5a334a1c5 100644
> >> >> >> --- a/common/spl/Kconfig
> >> >> >> +++ b/common/spl/Kconfig
> >> >> >> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
> >> >> >> =20
> >> >> >>  config SPL_OS_BOOT
> >> >> >>  	bool "Activate Falcon Mode"
> >> >> >> -	depends on !TI_SECURE_DEVICE
> >> >> >> +	depends on !TI_SECURE_DEVICE || ARCH_K3
> >> >> >>  	help
> >> >> >>  	  Enable booting directly to an OS from SPL.
> >> >> >>  	  for more info read doc/README.falcon
> >> >> >
> >> >> > I wonder if overloading ARCH_K3 like this isn't a great idea. Or =
perhaps
> >> >> > TI_SECURE_DEVICE is too generic a name. I kind of want to introdu=
ce
> >> >> > something that means TI Secure Boot is supported but also Falcon =
is
> >> >> > supported, and then use that as how we disable in Kconfig various
> >> >> > insecure options. And I assume that it's a matter of effort not
> >> >> > technical restrictions for supporting falcon mode on older HS par=
ts?
> >> >>=20
> >> >> I second your opinion here, the falcon boot flow we do have in K3
> >> >> devices is quite different from existing platforms but still enable=
d by
> >> >> the same SPL_OS_BOOT config. Perhaps adding a config like K3_FALCON
> >> >> makes sense here.
> >> >>=20
> >> >> And yes, older HS *K3* parts should be able to support a similar fa=
lcon
> >> >> style boot flow with not much changes to the k3_falcon_prep functio=
n.
> >> >
> >> > Maybe we need a common symbol for things that are common to all TI
> >> > secure devices, and other symbols for K3 or AM33xx (or whatever is m=
ost
> >> > appropriate for that overall era of parts).
> >>=20
> >> I was thinking of adding TI_SECURE_DEVICE_(LEGACY|K3) hidden config
> >> symbols which TI_SECURE_DEVICE selects as below:
> >>=20
> >> config TI_SECURE_DEVICE
> >> 	bool "HS Device Type Support"
> >> 	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
> >> 	select TI_SECURE_DEVICE_LEGACY if ARCH_KEYSTONE || ARCH_OMAP2PLUS
> >> 	select TI_SECURE_DEVICE_K3 if ARCH_K3
> >>=20
> >> We can then use TI_SECURE_DEVICE_LEGACY to disable OS_BOOT for older n=
on
> >> K3 platforms instead.
> > =20
> > The current tech today is the legacy tech tomorrow, so I think a better
> > symbol name is needed for ARCH_KEYSTONE || ARCH_OMAP2PLUS, especially
> > since the next question is how much do they in fact share in terms of
>=20
> Agreed, I will update the names to be more descriptive of specific device.
>=20
> > tooling and features. But I was also thinking that TI_SECURE_DEVICE
> > should be a hidden symbol too, and used for the common-if-any parts, and
> > so SPL_OS_BOOT would depend on !TI_SECURE_DEVICE_K2_OMAP2PLUS or
> > whatever.
>=20
> I don't think we should make TI_SECURE_DEVICE hidden since iot2050 is a
> defconfig that disables TI_SECURE_DEVICE while being ARCH_K3, it's also
> useful to expose it as a config to users in cases of GP devices for
> example.
>=20
> If we are in agreement here, I can post v8 with the suggested changes ;)

Well, with TI_SECURE_DEVICE hidden but TI_SECURE_DEVICE_K3 not, iot2050
can be migrated easily. That should also cover the legacy-within-K3 GP
parts too, yes?

--=20
Tom

--WjGbTA2SdHJYfxDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhK7LQACgkQFHw5/5Y0
tywv+Qv9H/gmJifCQskaPtaEAuCPFnakwUMG+QbGElwqcoqSNgzgieRWWIoBsYHs
Grwi6SO+Y3p6thhR1QEQIt+72PzAk0Bfnyi/Y4ozqGHtb8n4PIG0/3VOv41JaMuz
PQfmgqMhxQmGoBK4ti8qnzGUY9OULc8v2HECVi3ZbClPSqGn9NscxdqXdCKGdVAu
rR4Mrg/BJ8yh8zBofTUjC/dOutb58sHWbG4NziJvc4hHnulKiAXuw1vYyYChnKEo
yXnw8JNkU+ea3T5q9yNHKh5rt8H14b9aKIlvGNX5pRWkzgzqjDDuyvCK9yvmHBSx
DWXpZzuz6y47F9XsR5DuYdbWa+yl+rnhYspX+JRavkaDSIfXOf/ZhPU+Gd5gOjxC
D6J5ZrHHrsblMfYfTRGXEhLRCl6s4PRkNVEOmzjs1c7UBe0W2ZnjY63zNEsHp097
H2Vn7aX+jEN+tyH7VDUiY2KZKFCbGHJ21WWE7L9GawnTl6gDFm8iZubEvU6Nd0DL
vjQA3TwJ
=4ZMx
-----END PGP SIGNATURE-----

--WjGbTA2SdHJYfxDv--
