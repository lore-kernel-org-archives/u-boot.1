Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6A4C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA578836A;
	Wed, 17 Apr 2024 01:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6EIxn7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95198836E; Wed, 17 Apr 2024 01:15:49 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F58388369
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4347cbdb952so15160991cf.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713309343; x=1713914143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dfAi+oPEwrfVM1iHobbeeU5eIq4KP4aT6rajhXCLwKY=;
 b=Z6EIxn7HNMzxqbIZyW3VC1r9G60SWWrMcpBeAdAZYMGoINnpahFFIU+eyisHJXmrHX
 K5ApJkf5DQ8YGcaDpZAy21QdzyxGkzKkL+O9m1qjkwh6xnLaVWSN5yEq+jujQc801+Jv
 6O7jII4NtRp0gxbZhLfXvPoqB+8R1aF6tTu5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713309343; x=1713914143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfAi+oPEwrfVM1iHobbeeU5eIq4KP4aT6rajhXCLwKY=;
 b=QHJmwfQ4c1MTRZk8tTrKN9ObBsVUHM2bF67XIdGZOajF5ykN2nwaHsUKQSWAbleMb1
 oXiAk0goLcN+Ojx+6w2oUdKBT2cxEy0+GsoODm8m4vUSnWJmC5381WMFpN2T0G4SOnR9
 +tgz8iqbb3PIFb6zyJU57sU6aQV769LuZcwXSEihhmywVFUBO/QQd3Hn7BOnAoN+KZ5y
 jwYAVooBy9PXcPKWelIfLfu5xsoCuJtalvWDUNQ2WxfloXt6GCnCb4JhQdj55GBO5zkT
 pWSIrjJhv2oq9n3kQdbsTXS6iCSsPem/AFGMp7BJs9rPp39werXA8+vikIW2/Oj1niXK
 +ZWg==
X-Gm-Message-State: AOJu0Yw3Ru/6BcW7ybx6XjPxkWzbsRYjWiVw20EamvqBP0ZnnUc8m6rD
 pj/SWZUNx3TMB5qGOdABH9kbzTxOmK7nhCxaEPupNexK3aU3gSdHoCGDPXKEM1o=
X-Google-Smtp-Source: AGHT+IF8SNzrcks/PD2Hx7Xykh863vBE9nEkhieso1n5A+xa/0nhnoQMwdb7F9WyrzHD1L+bpTxIyA==
X-Received: by 2002:a05:622a:40c:b0:434:8f14:d24 with SMTP id
 n12-20020a05622a040c00b004348f140d24mr19443073qtx.62.1713309343408; 
 Tue, 16 Apr 2024 16:15:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 bp36-20020a05622a1ba400b00436a8ee913csm5547991qtb.41.2024.04.16.16.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:15:42 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:15:40 -0600
From: Tom Rini <trini@konsulko.com>
To: vindicator <nroycea+denxde@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: U-Boot/UKI Relationship Regarding Multiple DTBs
Message-ID: <20240416231540.GA1054907@bill-the-cat>
References: <CALaQ_hrVXwbgrCwkw4=OzsV2mvkWaMVMHUpC42byALg6gwtxyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="++CF+oRy741UsHhr"
Content-Disposition: inline
In-Reply-To: <CALaQ_hrVXwbgrCwkw4=OzsV2mvkWaMVMHUpC42byALg6gwtxyQ@mail.gmail.com>
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


--++CF+oRy741UsHhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 11:41:10AM -0500, vindicator wrote:

> Is u-boot capable of selecting the correct DTB in a UKI during boot?
>=20
> I saw "doc/README.multi-dtb-fit", which at least somewhat addresses
> what I'm looking for I think, but I'm not sure if that will relate
> directly with executing a UKI that has multiple DTBs...
>=20
> For my one board, I was working on building a workable "tinyconfig"
> kernel, but then also had the thought to maybe also build another
> "allyesconfig" kernel (one time) so I can figure out everything that
> gets used for ANY board (supported for $ARCH).
> Then another thought came after that, that maybe I could pile in all
> of the DTBs the kernel supports into a UKI (via "ukify"), which is
> where I came across https://github.com/systemd/systemd/issues/31946
> (convenient timing being so recent).
>=20
> So it looks like my thinking is "doable", but just hasn't been done
> yet in "ukify", and I'd thought I'd check here if there's anything
> that needs to be done from u-boot's end as well.

Sorry for the delay in replying here. Yes, it's possible to have U-Boot
select the appropriate device tree in a FIT image that contains multiple
device trees.

--=20
Tom

--++CF+oRy741UsHhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYfBpwACgkQFHw5/5Y0
tyy9ugv+MSPVdHwt0LGqlgnZl+Vd5oCK8xUZt8KFneW3xyWVvTZg3yfsTqP55GL0
8IR5THsaMhjHGMSegqTkbI1feJDIykV/HipuE3HmwZEqcPWjPSB/x68EuvGu0Mrn
PcRYGXkuxkCus14Ca9/up3EBHblq0yIezJJ9gtiwQXrLjU/xdvuo+bj4HlcSqml+
GBtmSacpMgEwW01NhbM/KRlpzBNvHpEeRff/y/x+o1or6nhuA/7B8Z2/E7zNjYdQ
1KPy6+8QC05R0t4eRE8nHfhfDd+6gUZji+xdV/y2WJtWTxfp1wc69qEd9rF7CKbT
4mHFS5OuPgapvP+GmgBe1eTNfvlx4AanW3Vu9aJq6eTN4EUHr0KEzlrmJcmrPSXW
pbglFHjdRdO/wzcrLQppSZ0dtFtk74sxNEuenchTVDQe1hn8ADJvOtM7sGiMRRMx
e9Wflw8IGBHjNi0YyGTGfiUjk4wqKY4tbwguJZ501pa7anxtYJ6uYJMqXi4j+fp/
yrwJCN46
=dVth
-----END PGP SIGNATURE-----

--++CF+oRy741UsHhr--
