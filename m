Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD46CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A93E86D1F;
	Wed, 11 Oct 2023 21:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lBKli6bE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFD886E2D; Wed, 11 Oct 2023 20:41:08 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023FE86C53
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7ba0828efso1825757b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049503; x=1697654303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iwuiEVlWHOY7EWbPGScZuZ+Q2MMOnyUcv3tHRguP4b0=;
 b=lBKli6bEfUH0XW11GjHcRCrWiVEl6fRH7S1C7dtnEgFfk0Bd++1YLWJjFXgVXXT3DR
 gaqaUXHMe94Lh5yAoG/TKfl/OZip9gMyLiQ7JuB6bWJ+1NI3JSfYXud4HpzFfq3mT5EY
 7n4hcHsW3JeC0LHLutNJPC+m9ZrjxvxSAtcXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049503; x=1697654303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwuiEVlWHOY7EWbPGScZuZ+Q2MMOnyUcv3tHRguP4b0=;
 b=laIP5SBFR58SJwhA2yaKp1MvL7pK0hknB+l822bg8TUjn6JfjqtRNWRsvT58sZ+v5T
 dPRNfOkRUdFXKNB4kMOKXLMuGsUjCgIEMqB8h7AytDxmyaCGzghTTYVQA1mX0vzVkvmM
 WuTKLSvPk1VTSJzVFsHm9KUTq9Z7S3vIkrF9uvXvzP5sM8dBvpu/Zfwy+DwmtIiyMKjw
 1UMcmp3vl4C6FmUzSDs6Y0YVhmoOfXNh6p8tjR7QMaMlJZQN68+VOg8Dp6q032YDUjoR
 6UfIGw0t75wjJsPD/8Az4uLPNWmhymGShz6Z1gmlXNP6KulqwCb1ehEWGePD89TVT/4T
 pfIg==
X-Gm-Message-State: AOJu0Ywj4mG88C2kO5TQwHBfktiPFQ7uqtBtk6nn31zch3um5vv12Xs1
 /YqcCEagLxw3M5Zm2GNd3W8hOuk2oV7OGeVGcFjJCQ==
X-Google-Smtp-Source: AGHT+IETm4bqM/Ik3sEI7yT5FOQF5hj4x1gnrOxmbqKMCh0l0wT/AOPVts2RdxKzEDLZHP878f6IaQ==
X-Received: by 2002:a0d:f542:0:b0:59f:5361:d18c with SMTP id
 e63-20020a0df542000000b0059f5361d18cmr22084878ywf.41.1697049502817; 
 Wed, 11 Oct 2023 11:38:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a817c02000000b0059f61be458esm5311784ywc.82.2023.10.11.11.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:22 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Makefile: make u-boot-initial-env target depend
 explicitly on scripts_basic
Message-ID: <20231011183820.GF3119521@bill-the-cat>
References: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QhRf0nRYTGeqvZzt"
Content-Disposition: inline
In-Reply-To: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
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


--QhRf0nRYTGeqvZzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 12:02:17PM +0200, Rasmus Villemoes wrote:

> We're seeing sporadic errors like
>=20
>   ENVC    include/generated/env.txt
>   HOSTCC  scripts/basic/fixdep
>   ENVP    include/generated/env.in
>   ENVT    include/generated/environment.h
>   HOSTCC  tools/printinitialenv
> /bin/sh: 1: scripts/basic/fixdep: not found
> make[1]: *** [scripts/Makefile.host:95: tools/printinitialenv] Error 127
> make[1]: *** Deleting file 'tools/printinitialenv'
> make: *** [Makefile:2446: u-boot-initial-env] Error 2
> make: *** Waiting for unfinished jobs....
>=20
> where sometimes the "fixdep: not found" is instead "fixdep: Permission
> denied" and the Error 127 becomes 126.
>=20
> This smells like a race condition, and indeed it is: Currently,
> u-boot-initial-env is a prerequisite of the envtools target, which
> also lists scripts_basic as a prerequisite:
>=20
> envtools: u-boot-initial-env scripts_basic $(version_h) $(timestamp_h) to=
ols/version.h
> 	$(Q)$(MAKE) $(build)=3Dtools/env
>=20
> However, the u-boot-initial-env rule involves building the
> printinitialenv helper, which in turn is built using an if_changed_dep
> rule. That means we must ensure scripts/basic/fixdep is built and
> ready before trying to build printinitialenv, i.e. the
> u-boot-initial-env rule itself must depend on the phony scripts_basic
> target.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--QhRf0nRYTGeqvZzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm65wACgkQFHw5/5Y0
tyzbsAv9F+c6rzykDYbgsExUBtUyACL5L2bgrDLy66d0FeAR1RvL9eU+rF30+/j3
svfdCnACNIyWXFqPZthmWXdv/LCTW84SWgv8U5kjlpxB9HSpCyDfb/VatVKAGYRH
CUwOME2HiTwmm3qwtjOnYD3/8WNwl/8mvQN9JZomC3a9SbfVz37jOVSYWfOn2ujY
rZmMkhnNrGQYLbG88PlQZ7auKLt1hnwT1Ducwq3dQKyuAt33JL25FU4klMEeJlyO
EZCbfiydT4mXTuxL+EWqAWdJv5xpHyilwSAOJEIUCrOkBQ1pCPsWsNOsHsWdwQKe
cYtJtFz4Dhit7BPULx8SgWcl824PLztjBE/W2u+0PIc+VgGDhA0DZsjeb2LEgBEy
3Uwqy17jB/ce2YzblTo1EtiXsfFCY+p0QKoDryJhGlfBfwog6HUuziYIslr0OgEG
nRZrrEeyKP+NdHmnDWuoZWpP94A3Lrja0gpsjM4SxwJRZfYPzZ2GtJOTJy7O75Iz
6ILQBumA
=KD1F
-----END PGP SIGNATURE-----

--QhRf0nRYTGeqvZzt--
