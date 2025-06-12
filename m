Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B94C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A1082B97;
	Thu, 12 Jun 2025 19:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="omb1+ohG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DA682BD9; Thu, 12 Jun 2025 19:47:29 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3812982B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2eacb421554so141101fac.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749750446; x=1750355246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J6Z1bVZUaR6d6/uk8L4Hl4KbdI2rNtHz+fnz0gYa/44=;
 b=omb1+ohGQs56LwDwRNDKAlLM/+T+HdHo8J8BUGQuQO/XaNukRcunBi+K5mYAjiHyoJ
 kJH1haH6EmjQByztkso9UlzTAswYnbjBp7JmzLHJ5b4jH6/W6tGZN44Xf+tBR02dXvI4
 ik7OLD4DnVRHtOjdU/iuTdPSYBfcQ08qu+5Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749750446; x=1750355246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6Z1bVZUaR6d6/uk8L4Hl4KbdI2rNtHz+fnz0gYa/44=;
 b=mYvn79mY53eUh+nuHdlY16Fh2hzm1YZbJB7ZLfz7jtuOu8ig8odymd6Psb4vWGs7dD
 rQRbxUCaJOFz8s2RGCcqzqbFuETAP5M+wcytHTtMOZPjoI3Ukhq5UnDe44bsWCFoezCF
 BLZSu5YgvhuVq0f17VnhEdCiExZ66ab+gB6R/4PTqqXYpX4QIZG5F+7f7D19gq8C2Pph
 jxHYsuRQon/ttJb+KNBbGs1J2X3NrWvjzzkrjMmEC0/2fTkMdKY09zfwjM1u8KmFO1T6
 X+BTHEDPJrFScp37MP1Ktl71XDE6Q4VjhDdCfBLb1Ws93DQANidTWPhQ3PtBm2VL1hem
 Ys8w==
X-Gm-Message-State: AOJu0YwPZYkgqltRlGjwc0/8lhoY35qm8H7c4HlTJcnuxAtsDkObAFb9
 HTsgIiyEgxDmv9Fb2AvGSdiy1fMiuMi4GD7BKpHxDJ28/JjlP3j3Loa5Z+ppez1JHK0=
X-Gm-Gg: ASbGncseG3PrOsPO3pCyhsc5tf6rK94VAfvecG42Cp4oRYrmG5vFc6CwwAjW0hPhN02
 CgzI5mYWMB5CnhZl8cvCJw8gMfN5ur8W1Xd+ywzOv9BviMKo52xo2eFiFDcxOBZ4kLhHcYSZmrC
 3YdZX7B+Gi7NVgE+2a5zd6kcHQeNCP88hHvcvwd8RNOGj8MnqMHNtTlP65TbxEPAUrutxlpImdn
 PJiNqPcD1rQ82ydm0QX8H5bdW0EjmRQkcjaKarT/ZV1tVGeD4/Keu3MzMKI1YF4Aa6rx6Fd77Wt
 vM7NoEgNkQCk81/OMZ39g+nck0sbG47epdjO9oLYsmSgncp8WZC6OJbZx50ZX1/xRDRCqHZAjPK
 NRI+8fgqZhz4T3mAMLkvr4Vg=
X-Google-Smtp-Source: AGHT+IGkkveUnlB+bCoOZc5fxUucfcnoIKRiGQdPRlYwTo51H5m+rKem3bhJCNILoT1fnWNw6S0bFA==
X-Received: by 2002:a05:6870:6718:b0:2d9:3868:b324 with SMTP id
 586e51a60fabf-2eab432daa9mr2853982fac.23.1749750445732; 
 Thu, 12 Jun 2025 10:47:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-610fd44cff1sm236267eaf.14.2025.06.12.10.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:47:24 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:47:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Message-ID: <20250612174722.GT1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat>
 <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
 <20250609145919.GN1382132@bill-the-cat>
 <DAIPP8VS7YQO.3PK5EYRE3D11A@ti.com>
 <20250610144444.GY1382132@bill-the-cat>
 <DAK9XDDNWUX4.1IRWBI9YA4MKG@ti.com>
 <20250612150528.GN1382132@bill-the-cat>
 <DAKNVHXLKDZP.3261Z1O2BP6D0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c0So8gR2YTWb0qM3"
Content-Disposition: inline
In-Reply-To: <DAKNVHXLKDZP.3261Z1O2BP6D0@ti.com>
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


--c0So8gR2YTWb0qM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 09:01:27PM +0530, Anshul Dalal wrote:
> On Thu Jun 12, 2025 at 8:35 PM IST, Tom Rini wrote:
> > On Thu, Jun 12, 2025 at 10:05:38AM +0530, Anshul Dalal wrote:
> >> On Tue Jun 10, 2025 at 8:14 PM IST, Tom Rini wrote:
> >> > On Tue, Jun 10, 2025 at 02:01:59PM +0530, Anshul Dalal wrote:
> >> >> On Mon Jun 9, 2025 at 8:29 PM IST, Tom Rini wrote:
> >> >> > On Mon, Jun 09, 2025 at 05:38:37PM +0530, Anshul Dalal wrote:
> >> >> >> On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
> >> >> >> > On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
> >> >> >> >
> >> >> >> >> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9=
b4437bc
> >> >> >> >> ("ti_armv7_common: Disable Falcon Mode on HS devices") for ol=
der 32-bit
> >> >> >> >> HS devices and can be enabled on K3 devices.
> >> >> >> >>=20
> >> >> >> >> For secure boot, the kernel with x509 headers can be packaged=
 in a fit
> >> >> >> >> container (fitImage) signed with TIFS keys for authentication.
> >> >> >> >>=20
> >> >> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >> >> >> ---
> >> >> >> >>  common/spl/Kconfig | 2 +-
> >> >> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> >> >>=20
> >> >> >> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> >> >> >> index 77cf04d38ed..bc5a334a1c5 100644
> >> >> >> >> --- a/common/spl/Kconfig
> >> >> >> >> +++ b/common/spl/Kconfig
> >> >> >> >> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
> >> >> >> >> =20
> >> >> >> >>  config SPL_OS_BOOT
> >> >> >> >>  	bool "Activate Falcon Mode"
> >> >> >> >> -	depends on !TI_SECURE_DEVICE
> >> >> >> >> +	depends on !TI_SECURE_DEVICE || ARCH_K3
> >> >> >> >>  	help
> >> >> >> >>  	  Enable booting directly to an OS from SPL.
> >> >> >> >>  	  for more info read doc/README.falcon
> >> >> >> >
> >> >> >> > I wonder if overloading ARCH_K3 like this isn't a great idea. =
Or perhaps
> >> >> >> > TI_SECURE_DEVICE is too generic a name. I kind of want to intr=
oduce
> >> >> >> > something that means TI Secure Boot is supported but also Falc=
on is
> >> >> >> > supported, and then use that as how we disable in Kconfig vari=
ous
> >> >> >> > insecure options. And I assume that it's a matter of effort not
> >> >> >> > technical restrictions for supporting falcon mode on older HS =
parts?
> >> >> >>=20
> >> >> >> I second your opinion here, the falcon boot flow we do have in K3
> >> >> >> devices is quite different from existing platforms but still ena=
bled by
> >> >> >> the same SPL_OS_BOOT config. Perhaps adding a config like K3_FAL=
CON
> >> >> >> makes sense here.
> >> >> >>=20
> >> >> >> And yes, older HS *K3* parts should be able to support a similar=
 falcon
> >> >> >> style boot flow with not much changes to the k3_falcon_prep func=
tion.
> >> >> >
> >> >> > Maybe we need a common symbol for things that are common to all TI
> >> >> > secure devices, and other symbols for K3 or AM33xx (or whatever i=
s most
> >> >> > appropriate for that overall era of parts).
> >> >>=20
> >> >> I was thinking of adding TI_SECURE_DEVICE_(LEGACY|K3) hidden config
> >> >> symbols which TI_SECURE_DEVICE selects as below:
> >> >>=20
> >> >> config TI_SECURE_DEVICE
> >> >> 	bool "HS Device Type Support"
> >> >> 	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
> >> >> 	select TI_SECURE_DEVICE_LEGACY if ARCH_KEYSTONE || ARCH_OMAP2PLUS
> >> >> 	select TI_SECURE_DEVICE_K3 if ARCH_K3
> >> >>=20
> >> >> We can then use TI_SECURE_DEVICE_LEGACY to disable OS_BOOT for olde=
r non
> >> >> K3 platforms instead.
> >> > =20
> >> > The current tech today is the legacy tech tomorrow, so I think a bet=
ter
> >> > symbol name is needed for ARCH_KEYSTONE || ARCH_OMAP2PLUS, especially
> >> > since the next question is how much do they in fact share in terms of
> >>=20
> >> Agreed, I will update the names to be more descriptive of specific dev=
ice.
> >>=20
> >> > tooling and features. But I was also thinking that TI_SECURE_DEVICE
> >> > should be a hidden symbol too, and used for the common-if-any parts,=
 and
> >> > so SPL_OS_BOOT would depend on !TI_SECURE_DEVICE_K2_OMAP2PLUS or
> >> > whatever.
> >>=20
> >> I don't think we should make TI_SECURE_DEVICE hidden since iot2050 is a
> >> defconfig that disables TI_SECURE_DEVICE while being ARCH_K3, it's also
> >> useful to expose it as a config to users in cases of GP devices for
> >> example.
> >>=20
> >> If we are in agreement here, I can post v8 with the suggested changes =
;)
> >
> > Well, with TI_SECURE_DEVICE hidden but TI_SECURE_DEVICE_K3 not, iot2050
> > can be migrated easily. That should also cover the legacy-within-K3 GP
> > parts too, yes?
>=20
> Yes, that would work but why expose two symbols (TI_SECURE_DEVICE_K3 and
> non K3) which essentially mean the same thing "disable insecure features
> on this TI device" whatever the device be. We can handle the distinction
> between K3 and non K3 device without exposing it to the defconfigs by
> keeping the two device specific options hidden. The end user just unsets
> the TI_SECURE_DEIVCE if they need to regardless of the underlying
> platform.

I worry that'll end up being more complicated than the two arch symbols
and a hidden common symbol. But lets see your suggestion in
implementation. Thanks.

--=20
Tom

--c0So8gR2YTWb0qM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLEqYACgkQFHw5/5Y0
tyxAEgv+Kppf/HkdPq87nUhBfftjjcwC2usYcnCrjqywhI5Lcj+CRLV4Vf4UTpAA
4bbHhTupiQkhIqyYir8g8XxXjkJ4z70j6SjuPxnS7w4qJ4kiqpgNnkdzI9zZFJTO
/MOP28zXLPmq8nZma+tye2CYE8tBAbsjAvZXEwE0x3jZLnHmvEwwV5RsGdXw/Ky3
NO7Zfcsv9N5FgkKyzwNyDVasWXlahXdusa1ZF5KnTprLTuW7AZL/0gsOGJuewUOU
jxBJwEQLDh0II8N9+7vNB5I8yciLYNlin/Xj3dWhPCLnio+y8YU1HmHSc4sxnZTi
MHj2nZ2fAz16/sXjQ7DPswaj07ttEqFGVBp0ZAumF6oPCf+7KHakD3ngrak9FUVc
4Dw7ISbHQmiteK/pQ5Cao3Vy26ifJRFmLIGgDsFErqn9PdeMc9zDmjIaal6hPmaf
quo4CEw2+lKNrVkfN2y9i0UdrOh1cs8EHKRWMAHmt3794JQgjjEpGJuqzky6T5E2
5phO1Vrv
=Os/Z
-----END PGP SIGNATURE-----

--c0So8gR2YTWb0qM3--
