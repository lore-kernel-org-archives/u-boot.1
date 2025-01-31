Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A257C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 00:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0D580EEB;
	Fri, 31 Jan 2025 01:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F4C1ij68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25E1809D0; Fri, 31 Jan 2025 01:10:28 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059CB80F60
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb9de518e2so650319b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738282225; x=1738887025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nFGwwsfAWUZIVA8Lh6petT+K82NgvQsWj80uinJmZtU=;
 b=F4C1ij68AK+Toz9G5lqPjSFiYy3uglc9UPFBvhn5V0k9iEo2b9JnbiFO1T2tFrwGt/
 3O6wntTR/DzJr6rSPlYeave4ddlcCjFwQYkZfNKvpXLaMjGNhR4Gb/N4oKPhZb+QU20a
 h/tOmhBk6Ex5e/q442+csBsq26jJgeYjLU9Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282225; x=1738887025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFGwwsfAWUZIVA8Lh6petT+K82NgvQsWj80uinJmZtU=;
 b=aw/SsGttod2CBRcm57qO2vZ27NNzT5bi4hXx8uS6ni+apcPycVRBhJ2b13h3q5FuhE
 4pAfUJOPsIkgznUTR4bCKSNdOt0Ek7yamj99HQrkYOZ1qkEC8RHO+R5yoHk2oUWFIP5F
 /z6OhoOgClaV3OEEAFrhOvfCIBUYRtmMubDSbUyh3h5/2uUrUSsRTlQfMQqRos63i/q5
 EqaGPzCde6ROqSHjJjI28iGePGjZXkDe506x5dL9MpBbEP2QAEQH7LCZKt5JxcHmqyIr
 RhAcZlf0uT6z9Dx2Mu4kkINWb6JQ7XQguXGk/iLOcxhdZ+6SpNazk8sGSqgvtFFVJ43U
 436g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrQGg1vkIBeQbrXSMOOhygjwmI2CUlNlwMfaOjol4Y5OyRDqY1GgAmhr72WzfgW3oED+mD7Tw=@lists.denx.de
X-Gm-Message-State: AOJu0YzIA3yjgEpPgac+EY/F+kcO5YF6z4RjUIYx9Y4fJyqZiMqV3jpa
 yIDd3mQ3iSloTGdOMGeomZDx2FlrKANOTB8271JjovvLOx41I/neT5ILUretEwc=
X-Gm-Gg: ASbGncsARULnq/6FwiOzZf/vD1Nf851kAxrhyUahHPsXsYkObrhdIJaxOg7SyGzGLxa
 n1EipcPaBmxmnbYvDOA1QyN0MCxfYySPsY1QkEAwtTLRaR9UgfU30ikfXl/DW9A9it1aKMLJWCw
 uPlGg9hM0btbi6F37P4B5nh03+6rNEI7todZDZTMwA2Ph6hD16mLwOC2LUDESi8CNyGfEOxUr3u
 AOiZewOiscWg4g9pEjOR35n+BqlCkMO+G9ObJrNvckXvZZBTO/NMfHZeFKyR702jhSFwt92zlyI
 hqztfhbDoWBj3n0=
X-Google-Smtp-Source: AGHT+IGjheBogMN0vf1DIEycQi7ctmf8AKWjpyYvht3gZR7hdtqfExI2fepAaTfAadZZNAZ7lzg0hA==
X-Received: by 2002:a05:6808:399b:b0:3eb:3b6e:a731 with SMTP id
 5614622812f47-3f3239ecb4bmr6890663b6e.6.1738282224760; 
 Thu, 30 Jan 2025 16:10:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f3335423f0sm519385b6e.17.2025.01.30.16.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 16:10:23 -0800 (PST)
Date: Thu, 30 Jan 2025 18:10:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20250131001021.GN1233568@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
 <20250123171239.GM60249@bill-the-cat>
 <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="osQmwvT9Mff6ggPh"
Content-Disposition: inline
In-Reply-To: <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
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


--osQmwvT9Mff6ggPh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 12:42:30PM +0000, Harrison Mutai wrote:
> Hi Tom,
>=20
> Thanks for the additional details, that helped!
>=20
> On 23/01/2025 17:12, Tom Rini wrote:
> > On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
> > > On 22/01/2025 17:21, Tom Rini wrote:
> > > > On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
> > > >=20
> > > > > When the configuration option CONFIG_BLOBLIST_PASSAGE is selected=
, the
> > > > > bloblist present in the incoming standard passage is utilised in-=
place.
> > > > > There is no need to specify the size of the bloblist as the system
> > > > > automatically detects it using the header information.
> > > > >=20
> > > > > Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> > > > > ---
> > > > >    common/Kconfig    | 8 +++++++-
> > > > >    common/bloblist.c | 5 ++++-
> > > > >    2 files changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > This leads to failure to boot on qemu-arm-sbsa as seen in CI:
> > > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10392&=
view=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d34=
-fdac-10f5bbb057bd&l=3D423
> > > >=20
> > > Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the=
 source
> > > of the failure is. All I see in the logs is what looks like an interm=
ittent
> > > error.
> > >=20
> > > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10392&vi=
ew=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d34-f=
dac-10f5bbb057bd&l=3D423
> > >=20
> > > Would you be able to share the results XML?
> >=20
> > The problem is that qemu doesn't start anymore, sorry for being unclear.
> > Looking at
> > https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travi=
s-ci/conf.qemu-arm-sbsa_na?ref_type=3Dheads
> > we can see how qemu is invoked.
> >=20
>=20
> I've successfully reproduced and resolved the error. The issue occurred
> because I relaxed the condition for calling the architecture-specific hook
> xferlist_from_boot_arg. Previously, this hook was only called if the
> bloblist was at a fixed address and U-Boot was in the first phase. Howeve=
r,
> since we also need the hook for BLOBLIST_PASSAGE, I've added a condition =
to
> prevent calling the hook if BLOBLIST_ALLOC is enabled, assuming we don't
> expect to receive a bloblist from the previous stage in this mode.
>=20
> However, I'm slightly unsure if this assumption is correct. Generally, wh=
en
> BLOBLIST_ALLOC is enabled, is it expected that U-Boot will allocate memory
> for the bloblist, ignoring the bloblist from previous stages? In the case=
 of
> BLOBLIST_FIXED, we relocate any bloblist received from the prior stage to
> the fixed address. I'm surprised we don't do the same with BLOBLIST_ALLOC.

The problem is that today at least yes, BLOBLIST_ALLOC is only viable
for full U-Boot as we don't have a mechanism to pass our own from one
stage to the next unless it's fixed.

--=20
Tom

--osQmwvT9Mff6ggPh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmecFO0ACgkQFHw5/5Y0
tyzjTQv+K/sC7df20YrwEiV07Sd85IRpDbWq4/akDuiGuyTju+3Gw9C28q1J6SOa
cszlvKkcEHWKSsR9Scm6NJHHMLydcMIZpZEAOk1Pc2UPPA6+AcJEnZo2RDZDmMi3
e1lr6AYVrmCxelZpvARfcaIwPELuzqUhmiHaI1ubJXxWuSDMVtclhm7M2chd+TbI
5TCMgjjlBl3TwAs9LKu8U2ZIPYZrLQ3nyXkwbSm+4ZyfkaEeiAhLlidZaQ5e/qN7
ZRPXJXuq9cnqV3QXdLWABzPh5WmmiSCYn6Zqy0r0NLjf2DN28g1ZHdQAvPRROwfr
Kfy6R5KO5PfZ1/sfwTDG+/VhSWgxEXDkyol3nwgo6NWTpeTVTZQcJ+SFF7Y1lw9I
+gys8Uzb4Wry66XS321lOhu1QEoaOfCm92L0JC0dhqFYZbD9G4r4L3EZdY/v7LnA
/O5SF2KDs34qdBiOd0CwZRyQHv4+EPdNS4/Bk2jOSqk1vLT7DTLkXI9/5i02uA8c
5cSS/E2K
=nMra
-----END PGP SIGNATURE-----

--osQmwvT9Mff6ggPh--
