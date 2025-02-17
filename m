Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F96C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 517C180F0A;
	Mon, 17 Feb 2025 16:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VlkzLMi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51C78083C; Mon, 17 Feb 2025 16:03:24 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C80D807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220d601886fso57299925ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739804600; x=1740409400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DCGlXlZqSnjFVxs58n/HSBZYYv/7GfwT6ulR6k8qqc8=;
 b=VlkzLMi+lEpBknrrYgTRtXutGlvAggA+PWF+mOI4UbLn+kemWQbTubbEX4NqIy/Pza
 Hi+gqPYZGrOkAQo0oxASl327cBDuvpVOqLfI5e/6IOfP/TpZtvL6I7aehXvzhlPXVeR1
 HxlDYQCRjvWxS0ZBOGsM+YXDP4VL11z1atEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739804600; x=1740409400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCGlXlZqSnjFVxs58n/HSBZYYv/7GfwT6ulR6k8qqc8=;
 b=jBd+T2a8WoSitTeVp8c9TMvOKMk5qcqHJQ3c+Ra9j/A7dBQM4IvcWubWJvtbd5QRqO
 uuIxTFtxlfnbug+8iTIiFaKF0mVxIAueiwoHl0LdUW3xLkoldGoZqXSEGCaA6KgTT3Lo
 Z+3d09RTFKJhAhD/ATvB61qePGY66y3+lYdENmqOeeW+LLSxx1cYflbw7L/GoeFWJoAx
 U2rhOgxmdaFv5Cr9eU+lPEj7tVF0HA6KPhZB2YdIGl9QyVFhQB8DnoCDBsdlwlkaHdxq
 NsHhG16oqp6eaInbI9ZsoUXQ/WvQFvpGYWUHWKyV5f+FHpG0mq/TS66VYiGN+NFViSSP
 BG5Q==
X-Gm-Message-State: AOJu0YxPrnCoJrFVwIr9ORX20BVjhWPN1FQcNeYuur1B/lX188z1Lnod
 xvrggYfiTJULRzseZ+TM+MG5rF0AodtsWQasC1WR/ac6jW5LCASyTGJMfDMrG3N9j4BIOz9u50P
 X
X-Gm-Gg: ASbGncsd6YA2Vy491QLIHvFxe5xBHLyRzUFRJzwNVOSMX+eZbZaGpXPMOvFh5kUsCbh
 gj8yRAyH/M4Pj5V1Nf7BjI+Mf0u674qrQFOtH1SRKOZKeiImdaDS5Wd1Sobz/CHP6CAQxyBpQgJ
 d5CnsXr5NL3DDAQT9wGgp++YuicnLXmJexfp0Kq5JFhX7j/r1RygFwsvz7uRB6qUcoP+yLhlROf
 fOwAT/jrpGq3gMLdMh2fyQWMprlVZL4Wzlc6Jw4J5TrcEPg/vmlCDhGIB3wj/WCGVU1rUp0XyG4
 smzuKzI1lS/bXw==
X-Google-Smtp-Source: AGHT+IGYJv4iDf8ZfRnUTONf3HS3h6eEAH6VR2eQ8BTGWJwNCfpfkZCbV+XWAOcevPF8+0aiVkon6g==
X-Received: by 2002:a05:6a20:1586:b0:1e1:aa24:2e58 with SMTP id
 adf61e73a8af0-1ee8cb1f646mr19314879637.7.1739804598904; 
 Mon, 17 Feb 2025 07:03:18 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add21f2149fsm5317771a12.1.2025.02.17.07.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 07:03:18 -0800 (PST)
Date: Mon, 17 Feb 2025 09:03:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250217150315.GM1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YcThX6BpcFlpkM9N"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
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


--YcThX6BpcFlpkM9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:

> Hi,
>=20
> I just wanted to send a note to (re-)introduce my ideas[1] for the
> next iteration of xPL.
>=20
> A recent series introduced 'xPL' as the name for the various
> pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> still use filenames and function naming which uses 'spl', but could
> potentially adjust that.
>=20
> The major remaining problem IMO is that it is quite tricky and
> expensive (in terms of time) to add a new phase. We also have some
> medium-sized problems:
>=20
> a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> can be confusing, particularly when combined with ifdef and ifneq
>=20
> b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> different things. For any given option, some code uses one and some
> the other, depending on what problems people have met along the way.
>=20
> c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> the option is enabled in one or more xPL phases, or just in U-Boot
> proper. The only way to know is to look for $(PHASE_) etc. in the
> Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> and has not scaled well.
>=20
> d. We need to retain an important feature: options from different
> phases can depend on each other. As an example, we might want to
> enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> may also want to share values between phases, such as TEXT_BASE. We
> can do this easily today, just by adding Kconfig rules.
>=20
> Proposal
>=20
> 1. Adjust kconf to generate separate autoconf.h files for each phase.
> These contain the values for each Kconfig option for that phase. For
> example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
>=20
> 2. Add a file to resolve the ambiguity in (c) above, listing the
> Kconfig options which should not be enabled/valid in any xPL build.
> There are around 200 of these.
>=20
> 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> useful in rare cases. This indicates that the option applies only to
> U-Boot proper and is not defined in any xPL build. It is analogous to
> CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> needed at present, basically to allow access to the value for another
> phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> the address to which U-Boot should be loaded.
>=20
> 4. There is no change to the existing defconfig files, or 'make
> menuconfig', which works just as today, including dependencies between
> options across all phases.
>=20
> 5. (next) Expand the Kconfig language[2] to support declaring phases
> (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> declared once for any/all phases. We can then drop the file in 2
> above.
>=20
> With this, maintaining Kconfig options, Makefiles and adding a new
> phase should be considerably easier.

I believe this proposal will lead to the code and Makefiles being less
clear than they are today. The line:
drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D block/
will become:
drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
without being clear that it could reference either full U-Boot (PPL) or
some xPL phase. While the same Makefile will continue to have (comments
my own):
obj-y +=3D mtd/ # Subdirectory Makefiles control build contents
obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for PPL.

And so the situation for humans will be worse off than today because
while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
what can and cannot be enabled in PPL vs xPL.

Doing "something" is not better than doing nothing in this case.

--=20
Tom

--YcThX6BpcFlpkM9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezT7MACgkQFHw5/5Y0
tyx/QAv/clGr7n6EwBsZ3dzyya1istgl3M+XvSRc/cXtWZXnY8X38XCw3LJmTJHM
DvH2BAWL0ye6k/jGjaeW2m9d9dmJimdV82Jqn8aM6zFPsq2IpJBZ2hLt+fht3tjI
WIs5YSq8cioii+SZ1L660hxiRwUfvok0JWmIuKalJ+/4db3sC2Bfc2zRFCFivMWx
fenJ77fKwJ1IKXUHgBkdhMTuKMQ11ws95GQKNrHDPuNcoBjryQ0pPPxycwhkUMIw
/VcJf8VHQqqmI4aXpja+ljjz136KsrUjBdw0c9Wp+V84EySnXtanX/xX0smsVZ5H
xGJBQ747N4qtbfFAcr/K+gDmF5avSNiJhtsXc84bF1NWFggc2l0zbdS+FJcig7ss
s2h37NniyX2CF+cRifoj2LAOBG8glIqHDSA217xEEt2Fr2tO04iXChSEj9JzAw3i
PP3ZQ8KbHiUs4gjOVfm8pPSpIAe323muwPNIgqupF5Fd5qWBqIZy8XfIWcrYsbqr
tfhVVuzi
=w+0d
-----END PGP SIGNATURE-----

--YcThX6BpcFlpkM9N--
