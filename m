Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF9C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 18:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A0DA86F1F;
	Sat, 18 Nov 2023 19:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tiTT8q6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2159D87087; Sat, 18 Nov 2023 19:04:21 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51275868BF
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 19:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7788db95652so197008585a.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700330656; x=1700935456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CONeuM0eYy/4aiCbMhM38L6gSwwtBTn4e8LVQOFxUws=;
 b=tiTT8q6aG0VrxPmnvVhgxc1qclAPSLBeSpCqB86FCVBw6pckI5vXQkC+xjPBNuER4h
 /mND2bQM9SPWGCVxlIIy+R/SXRROW7vx3GGk8+hRHKUrOLfluwSy+WahcjiUL3uXX2aZ
 xBbUCaMjFfi4eObq1uRXZF+zWEiGS5E1I8UeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700330656; x=1700935456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CONeuM0eYy/4aiCbMhM38L6gSwwtBTn4e8LVQOFxUws=;
 b=pYUFXVIrrRTuc+CbphsA3kaDPcsyC79wE6f3zuabmzarYvGoT0rbeW7tWL5j4Q1qUt
 lzJBcnh+/mBSAkS3Wdm5Qa5spcdcDqINxBsQWF0x1M5niJLoc5zGV+ek2vgPlj7teyMh
 SEsTzuSvhrNvWFIZbED4vm6hJfDqZ0IduqpTIvZfauOT5gOs+BgPHFGQJNV+3K3hlib3
 3OuC9ZBNvL5SSAneRhJ/CgWeSK9OJ3MN66TrBbVeRwuFIoemBeOV5tPszJepxULY7vaI
 1/UuR4DML5D2uFBv27H7dS+cZrJo6yBN3DAR2VXXc6YznAima7yekgJNbFFVhOUlcT4z
 PWMg==
X-Gm-Message-State: AOJu0YwutgZxN9iHSFfRabfm05648i3MNPCgsD55ttD6xQKtEIg8PoUV
 ijl+Pp0kVKhIzY3ALNz/uoD/L3OTRUHyXTYJ/liaWQ==
X-Google-Smtp-Source: AGHT+IHIZNK6+mrzmgUD2zV0dHkaUp9PWji7CRUn1grl3lTtcNxPT3KADWcHunADiNVlGMnv3Pa+6A==
X-Received: by 2002:a05:620a:3955:b0:779:f0a1:3128 with SMTP id
 qs21-20020a05620a395500b00779f0a13128mr3442648qkn.63.1700330656065; 
 Sat, 18 Nov 2023 10:04:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 rv13-20020a05620a688d00b0077a7d02cffbsm1442293qkn.24.2023.11.18.10.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 10:04:15 -0800 (PST)
Date: Sat, 18 Nov 2023 13:04:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
Message-ID: <20231118180413.GJ170968@bill-the-cat>
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
 <20231118174550.GI170968@bill-the-cat>
 <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ImJWLyq9XMq1MfFZ"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
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


--ImJWLyq9XMq1MfFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Splitting this in to two different threads..

On Sat, Nov 18, 2023 at 10:58:50AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 18 Nov 2023 at 10:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Nov 18, 2023 at 10:09:55AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 17 Nov 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Remove and replace common.h and config.h in sandbox when it's not n=
eeded
> > > > and add some explicit includes where needed.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >  arch/sandbox/cpu/cache.c         | 1 -
> > > >  arch/sandbox/cpu/cpu.c           | 1 -
> > > >  arch/sandbox/cpu/sdl.c           | 2 +-
> > > >  arch/sandbox/cpu/spl.c           | 1 -
> > > >  arch/sandbox/cpu/start.c         | 2 +-
> > > >  arch/sandbox/cpu/state.c         | 2 +-
> > > >  arch/sandbox/include/asm/io.h    | 2 ++
> > > >  arch/sandbox/include/asm/state.h | 1 -
> > > >  arch/sandbox/lib/bootm.c         | 1 -
> > > >  arch/sandbox/lib/fdt_fixup.c     | 1 -
> > > >  arch/sandbox/lib/interrupts.c    | 1 -
> > > >  arch/sandbox/lib/pci_io.c        | 1 -
> > > >  board/sandbox/sandbox.c          | 2 +-
> > > >  13 files changed, 6 insertions(+), 12 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Is it possible to move CFG_SYS_SDRAM_BASE/SIZE to Kconfig?
> >
> > Possible? Sure. But I think it would end up being fairly horrible. What
> > would be nice I think is some Zephyr-style "convert
> > CONFIG_DEFAULT_DEVICE_TREE to some defines" because we could parse out
> > /memory to CFG_SYS_SDRAM_BASE/SIZE and that's something we _need_ at
> > build time.
>=20
> That would be pretty easy to do. But I would prefer to have it create
> CONFIG_SYS_SDRAM_BASE/SIZE so that it fits in with Kconfig, just that
> the value is set for you.

I _think_ we need it to be non-CONFIG namespace or we'll run in to other
problems? We could get the new autogenerated header to be included along
with generated/autoconf.h but since we couldn't use it within Kconfig
logic it would be confusing.

> If you like you could create an issue for it.

Please, thanks.

--=20
Tom

--ImJWLyq9XMq1MfFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVY/JoACgkQFHw5/5Y0
tyws4AwAuo4EGs3o0xT6iuEKWzdj9DdiIR5kBzqAMK/X//gKJM164wAt4fBoTErz
ijtxeLNZMHWf3y+putRy/r45b2utV+eNoe7aYlnemU3bGpGLfqjEzPaCz7/1ixvK
arzZ5hhSYlIWtDcA9lylYaD0ZAvegP2pwOoXYPm06K7yFNoP7e5+eAyaE56NmD2O
wybstMeq/i0eWNJDjjCx+RP0V607d7U0UtcWJ+azeL2VUF0aX9AMnfZblbmh2dxO
yW3LB023MQ3+iT7hvlaMB5w1C5og4y3A+K/T6R7Uqrl7ZMhHsLSDV9cNk7JNysPm
UOrvy2nB68NVMQYZkyWtb72zaZ0RbxPs/Iche4qORLVTCw/H8gsk1KYlcCM1l+al
AY7fCPMMlhnh4EqWvIMyR+gf5l4AJxQxgfKuwbAox5iJOZ3Uz/N3QmslS9cLW6GI
MlKXGZQIiRZhEQLlJrA2ct29lMt3lswx/YRSeR6jgjVUvJh/GZY10IloAtg3k0/B
QI9FhRFz
=/Ma6
-----END PGP SIGNATURE-----

--ImJWLyq9XMq1MfFZ--
