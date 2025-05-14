Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2881AC3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 20:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553E482AB9;
	Wed, 14 May 2025 22:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hg4pFFw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2972F82ABA; Wed, 14 May 2025 22:21:45 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAC482A9E
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 22:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-401e77e5443so209984b6e.3
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747254101; x=1747858901; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kIO2BD1s+2GPoUr48dU51BJzLSqCU7Mkf1NER3DMalY=;
 b=Hg4pFFw8M0AoUEKdEkKpkFbg9BWSPhdYKnBi399I1L3dqMzywA7bBUUEv8VVmgEO10
 CxuvkysCBCeB/GsEBlfglWgiP5vUEfFlsmcYZicgRPj2xRMSamv5NrP/MAjTRqDwG+Gt
 jKB0tw0GPl5atBS+ijpdnp1zkULKzuEmJtEdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747254101; x=1747858901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIO2BD1s+2GPoUr48dU51BJzLSqCU7Mkf1NER3DMalY=;
 b=eAxTxrbuuRM5jmFqxSMtDgCZx4srVGINLwaipQ9iR5+hpo5QxiNOPHIyB+eqrhn611
 IsWSxlD0J0oJv8LSNUhUiLsWC7SSCQfOb/R0uG/m45v1rftarVtz55lnaL5W7NOkCbkY
 5/TuA1v9KW6vA4GmyX7b2f/+zZv6A6aJAELKEXrnuu+D7rRseX3uAQk4pJi/0SMAvCnt
 8YvtkeAAT0bfYJkyJx0F15kxLBgI7VFoy3y4Ad0dXpMJmXifXBk9OByAgk0H/igbB3/V
 wW/wv44DfdGnNpAeRkeyWNksbxaLx4XLEZw9QQkHiE462Nr3VCH8MBhVybL35QfZi7QZ
 DEig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUzP+6LvUYP8kY+gjgSOouCOd1Jpit7deHeSpV5xeYLRi0kAA5gJ+mc3lGINqwlMnacgfqJWI=@lists.denx.de
X-Gm-Message-State: AOJu0YzFLQMb9JX66MNpUbOfx1MlKva27/3zeeYR+ksMPTNnYdXo3ZX6
 9rsdIbBWC/x5TVGglY3tviS6nWC2InU79JI7WDbCTyakTACiyGctoKCmLLaPjrA=
X-Gm-Gg: ASbGncsRJ4k6LDgLbH7yUBFk+JRpPT41GlE5MGyipHd+KYjrI2lm+R4J+5k+6+FojWu
 1TgY5uO9dCgU2ltVq1Oq/GhLNQpJYnHIwLBABYXaZqpO3p6WMyAGp3hg9pG5qjUHjJo4PR+H4AI
 A+qtfb1Zs4YETQQ4mJ8jCczW0jdn05CDiWsTS4pDDGYf10Y76bIyeXVuOUOwSZ1Z/PD7z600Lg9
 ZrbnSOARO6Sr+5GnnGmyjnlJ5Nk6eBRgghCKp45Dv1LZ55No9+Y2OoJX3WSaSQxM3V9WmceKKTl
 0oJhR9ZkH9oa9P+P5NoKa448oToXXyYvNRPqUd8YkJ0GwfHqEJNUdLXqGJkNXR5NHtpL3gad2Jl
 hqnjVW5G4Mpb3
X-Google-Smtp-Source: AGHT+IHLYBQhGC26RayZOTffEVgIhiCZdV5C5txIlk8YpzRiDzAtJu6rSn1aYAns4LCRiX6h5NqTSA==
X-Received: by 2002:a05:6808:6c82:b0:401:bdd7:6670 with SMTP id
 5614622812f47-404c20439f1mr2664660b6e.23.1747254101140; 
 Wed, 14 May 2025 13:21:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265cd9b4sm2455797a34.52.2025.05.14.13.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 13:21:40 -0700 (PDT)
Date: Wed, 14 May 2025 14:21:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Bryan Brattlof <bb@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250514202138.GB603748@bill-the-cat>
References: <jacjuejbprhinwzul6ktugk76a7hu7lm3mfeqelr3wizpyc5lj@toewgusd6z5r>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ckch7OIMRFZd4iK"
Content-Disposition: inline
In-Reply-To: <jacjuejbprhinwzul6ktugk76a7hu7lm3mfeqelr3wizpyc5lj@toewgusd6z5r>
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


--5ckch7OIMRFZd4iK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 07:25:53PM +0800, Zixian Zeng wrote:
> On 25/04/30 01:32PM, Tom Rini wrote:
> > On Wed, Apr 30, 2025 at 02:26:04PM -0500, Bryan Brattlof wrote:
> > > On April 30, 2025 thus sayeth Tom Rini:
> > > > On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrot=
e:
> > > > >
> > > > >
> > > > > On 4/30/2025 10:01 PM, Tom Rini wrote:
> > > > > > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> > > > > >> On April 30, 2025 thus sayeth Anshul Dalal:
> > > > > >>> As discussed here[1], the go command causes undefined behavio=
r when used
> > > > > >>> for running custom OSes since the icache might hold outdated =
data. OSes
> > > > > >>> usually also expect the MMU to be disabled upon execution.
> > > > > >>>
> > > > > >>> Therefore this patch adds a call to cleanup_before_linux befo=
re we jump
> > > > > >>> to the loaded program/os which disables both the caches and t=
he MMU.
> > > > > >>> This makes the go command's behavior consistent with riscv pl=
atforms.
> > > > > >>>
> > > > > >>
> > > > > >> I know quite a few other OSes are beginning to use U-Boot (QNX,
> > > > > >> GreenHills or all the other RTOSes) each with their own requir=
ements
> > > > > >> from the bootloader. I'm curious if we should make boot* a lit=
tle more
> > > > > >> generic rather than abuse the 'go' command.
> > > > >
> > > > > VXworks has its own:
> > > > > https://docs.u-boot.org/en/stable/usage/os/vxworks.html
> > > > >
> > > > > I suppose QNX and others should ideally have their own cmds as ne=
eded.
> > > >
> > > > Well, what's the QNX output file format (options?) again?
> > >
> > > I've only ever seen outputs in compressed binary formats but I've been
> > > told there are tools to produce an ELF for the simulators
> > >
> > > >
> > > > > > Well, that's what bootelf is for :)
> > > > > >
> > > > >
> > > > > And if its not an elf but some .bin file "go" cmd should be used =
in
> > > > > conjunction with "cache" cmd here to flush/disable cache, I guess?
> > > >
> > > > Well, what exactly are we talking about? Is this an "in theory" or =
some
> > > > project(s) which exist today?
> > > >
> > >
> > > I noticed this thread mainly because of the number of RTOS people ask=
ing
> > > me about low level stuff U-Boot and TF-A is doing. I haven't seen any
> > > 'In-Production' type bugs but I wouldn't be surprised if U-Boot is be=
ing
> > > used in their CI environments today.
> >
> > A number of RTOSes are already supported via "bootm". If they've stopped
> > working (as we don't have tests in CI for them) I'd love patches to fix
> > and at least instructions on how to make it fail somewhere, ideally
> > QEMU.
> >
> > > > There's a whole lot of reasons for either a legacy header and bootm=
 or a
> > > > not-legacy FIT image. The "go" command is for the "U-Boot is a debu=
gger"
> > > > side of the world, not how you should kick off some OS/application =
in
> > > > production. It is all of the "this is dangerous" idioms.
> > > >
> > > > > If so, we should probably update the docs for this cmd appropriat=
ely so
> > > > > as to avoid end users overloading like what RISC-V did?
> > > >
> > > > Yes, we should clarify things as needed and unwind, most likely, wh=
at
> > > > RISC-V is doing. But not blindly so as perhaps there's now, sigh, a
> > > > production / in-the-wild case here and we're now in a sticky spot.
> > >
> > > I like the idea of boot${OS} flags if only to standardize the interfa=
ce
> > > of how each OS should boot. I worry about situation where custom
> > > scripting is being used to boot in production rather than stdboot
> >
> > Right. And that's part of why in this day and age, regular uses should
> > not be using "go". We've had and supported RTOSes via "bootm" for what
> > amounts to forever. We've had "bootelf" for arbitrary things for ages
> > too (and in turn, your custom app/RTOS/whatever using the normal bare
> > metal ELF linker script, target, etc makes it easier on that side too).
> > In more recent times, having a whatever project spit out an EFI binary
> > instead is also possible and done sometimes.
> >
> It might be a novice question, sorry..
>=20
> I'm using uboot on riscv, and noticed that the "bootelf" command just
> jumps to the entry point of the ELF file.  What if I want to boot
> multiple harts?
>=20
> bootm command calls "smp_call_functions" to change global variables
> `gd->arch.ipi` which restores function addr and arguments
> and sends IPI to each hart, but "bootelf" does not.
>=20
> It might not be a problem on other arches such as x86, if I recall
> correctly, x86 can specify the function address when sending IPI.
>=20
> Thanks for your time.

It is quite likely that yes, we need a little more work on "bootelf" to
handle the standard way, if there is one, of passing this information to
an ELF application. I would have assumed that we would put any other
processors in to the (I assume exists) OS-agnostic parking spot and they
can be discovered and handled by the OS as needed.

--=20
Tom

--5ckch7OIMRFZd4iK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgk+04ACgkQFHw5/5Y0
tyxz0Qv/VWtwbj4XhmN1uhvWb/JoOdQqNMqUVZDuJL/3hE5G2ary3JhbC6HaIDNy
04iFEBWhImSinwXUx6cvyvuBd5iA3TCy9pJ5YDMph9XSS25lcjUqNoteIhoBapzT
+zO/Sqn14M13auT22xxkjaOb+G+PDhaXJDA1jHy78fQ6y9aNaJsBojCf8NT0MvD3
qv8VkV4z0ZLp26KHK7kKGXKNfq1YQVZaLdqu2gTiCgCURq92Q1bft9kkNIJD8GBb
UFz+Rv1LNHyf1UMbnycqaRVc46XDsSdjkF7xQVq38D83rXMSfXlCBjQrfiNoW2t6
183cXdojkjuISX6tfNHJ8XZIqhGI3dPQ5PgqY9d6l3WPwU94VbRdHR6VSqGUojS5
YnQuC1YuM4CNMbxPW2Ct7IQ7tEZa1q1S7YYyugsSKjcbDJeCTwCcEhjl7BMdLaXA
984wMGzS+bG/SBD1HnajjCZTa+vrhN09hYFusnctJFV/znoWBavESlMAeQ/ymsS6
YVWgZxo7
=BCE4
-----END PGP SIGNATURE-----

--5ckch7OIMRFZd4iK--
