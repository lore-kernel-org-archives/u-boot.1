Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A227B109C048
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD5E83AAB;
	Wed, 25 Mar 2026 18:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uu1MKh0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5D483DA6; Wed, 25 Mar 2026 18:15:46 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD26C83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4138136f02eso67005fac.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774458943; x=1775063743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ph3kag+rDSbsj+10+WviIo2UhZ4LZgrfc5bylYgEBMo=;
 b=uu1MKh0zpdhs9C6pHaJFvAgUNYUiyNm0l0jsf92LXTUm6PK2OHBTR/pYZds3mCaUsI
 pWaUDP2K33d/Js3A6fCxRksaw0KNnUfbZKjrVcdmF0tWy+WtpkWTVd5+vRCUYV6Rfjwm
 YwGELFCFlN78aTJe8Wlq9GYalI2OlPwrXreD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774458943; x=1775063743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ph3kag+rDSbsj+10+WviIo2UhZ4LZgrfc5bylYgEBMo=;
 b=j78gLotiJBDHv02HeijeOkpiYQSmx23bsIq5nZDmRxnVhJnMzZDd1LFU58q9pbnMZN
 trhvb2Ke/B/8tKiZifD2hPPTJQosSK2JAurrrvb/dgtZWk7OlZS4C1yHMjXfwY4Ri7yC
 fzekeK1FVFrg7wXGPBihpvNmLBHnjx4FxlvBiHk/gGVInNT+qI9Fzx/0Cxk5wqCyt4m0
 r0dX3A0fulvHdqaoYBNMLA8hnLE8fw1DemKR+KUz4bVncAwnC58iEzsdNZH46kUPIVVp
 4jCJiDuh8f5c3F0MVwjf5h5ri9vn0b3+szTK0F1rmVz1hq7vENTmq36HsNCmo2JqUTyY
 9xoQ==
X-Gm-Message-State: AOJu0Yym/xDAjPdrwdxgd0HiY86YIJbrRpcy9Ev78qVrLKdO19BF6dnQ
 IksdfwLPv4gYGZzsy+bB0N2YwM8v64rNSa6N80s716g9vYbHI/m1oFqMpfwHLPSlEbv+q4a71TD
 dhxIl
X-Gm-Gg: ATEYQzwBxLNgmodQW/fOa2RwdvElLlcOzxV8aF4XjOLbA6jlXFWPWwV/1WlauJobYaj
 Q6R9+W6tyuW1ZfsHWLg/WWKGsDAoIV9I9Q1vviIKcqLixNoC1OuZKyOJqEdDLvNtnc+3NtBwa5m
 eQ+KwlJRXNlxLcWVO+ztm00BMMT5VYw2QKbhldwK2vrN3gbNQq0JXsLsOoZVuor2pOO+FDhTtHG
 VSfalEIWykjXr36mdJ+Rsjh82HvmqYNXCLr1fJXkywNWQ8zUPFXZtlAvXz5rWruSa1axtOq2UVc
 X5OGc00RfmIl2EAUOXIGUzyuaIsuG8YF0EXGTkTClN8LG/8LdgmbGkA809ZChjGsPurkAiuzsI2
 xUeS/Pdq7aIZSD3JGuIfGmPFt/E91iNzklPB1SeYpm08PQVIIJHew7p6O6WKba6QGxlwzCijKUc
 V1xA4iW6o7QiwynqbAVWcGIl73IUlhakzsQwAJblyc+6x6dGjLvxQnyucNLzSXO0sqyFwI/hQIf
 wPs6zqp2KeGu/kJ174OiHpACDD9a8KAOhynkwiMwk+Pg3di
X-Received: by 2002:a05:6871:3845:b0:41c:f37:ede1 with SMTP id
 586e51a60fabf-41ca6dadf17mr2546166fac.14.1774458943227; 
 Wed, 25 Mar 2026 10:15:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc7bbf59fsm99346fac.18.2026.03.25.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:15:42 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:15:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
Message-ID: <20260325171540.GU502704@bill-the-cat>
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yWw2aQ8Gko36hKcc"
Content-Disposition: inline
In-Reply-To: <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
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


--yWw2aQ8Gko36hKcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > The generated .S files for fonts, splash screens and EFI apps use
> > > .incbin with the full prerequisite path. When building with O=3D this
> > > bakes an absolute path into the .S file. If the build directory is
> > > later used on a different machine (e.g. in a container), the assembler
> > > cannot find the source file.
> > >
> > > Use $(src)/$(notdir $<) instead of $< so the .incbin directive contai=
ns
> > > a source-relative path like drivers/video/fonts/nimbus_sans_l_regular=
=2Ettf
> > > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > > flags so the assembler can resolve these paths.
> > >
> > > The DTB and DTBO rules are left unchanged since their prerequisites a=
re
> > > generated files in the build directory.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  scripts/Makefile.lib | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > This is generic kbuild infrastructure now. Is there a fix we're missing
> > from upstream, a change we haven't pulled in yet (as we need to keep
> > syncing upwards) or a problem upstream too? Thanks!
>=20
> Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
>=20
> echo '.incbin "$<" ';
>=20
> But Linux only uses generated files in the build directory, never
> actual source files. The font/splash/EFI .incbin rules are U-Boot
> additions that aren't in the upstream kbuild. So Linux doesn't have
> this problem.

Shouldn't we be generating these files in to the build directory too?

--=20
Tom

--yWw2aQ8Gko36hKcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQYOAAKCRAr4qD1Cr/k
Cp6xAQCg0wArtF9wgYX+nPEVGzjSg2fiedROKrfRLi0cpzKLjAEAiBNSJ0Y7d+Ry
OAeiuoowPQtJZyV0DwEBS7xc3rID3ww=
=il+2
-----END PGP SIGNATURE-----

--yWw2aQ8Gko36hKcc--
