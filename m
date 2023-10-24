Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C965CC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 22:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F1886F3D;
	Wed, 25 Oct 2023 00:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nS3r5rUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EC286FA2; Wed, 25 Oct 2023 00:24:14 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B2A86EF1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9ac9573274so4583778276.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698186250; x=1698791050; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoLGVs0G7tCmZ0MkCQC7uGrj8zbRGZzUktoVG2/0/2g=;
 b=nS3r5rUFaEBUDnZ2jzQhR4YKEe6FF0MfLf8KGMok78ZwcY+sOkHBm9Fi4GMbOqwHa4
 Uazy3pyjff4Zhk1WuaHiWsTISX2h6HgL3OeUGDmZctawrapF28Ist2Le83w/CEOWicLS
 bcCa9m8toxO8vQkXmrqnTt/q8XhboTT1lFWH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698186250; x=1698791050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoLGVs0G7tCmZ0MkCQC7uGrj8zbRGZzUktoVG2/0/2g=;
 b=XPLRvDbMZGiRR5DD0uakXC59LlGdAyvYFI5OI76FnYWAkJJO82LfTRhyLeugMaJXP7
 10dsNpLnQwCPWNk7cWCc5w9L3kR6mJ27EywSgwXf/qF7n5kM47+SQcHVo+QrwOVe93rE
 yF/D2s7IhOpekKg376+1DiZCV8dagdtQdeKr2dqsXWGykMRdsmUy/dcCS8iBx7t/Oyas
 cnC0/Zweu7UK8wi/CuJ2afJiqa8F77YtgeDOM+V/zzDQj7JyKwXOVK/kzkI4Sit1QaoQ
 b81Znr6Ts809FTWlzlkcMfzyeWlgYWDMpgR2l/4DvEd47axeVDryDvC8iFiFvUNZxVZ/
 ynRw==
X-Gm-Message-State: AOJu0Yw7tvRhgLBH4n68yXMgkVzIDmeS8lc1ehD99MZT2nt/9ZQHmqT2
 jdjMlrTU/nroRkq6q2fBPA9ZUg==
X-Google-Smtp-Source: AGHT+IG3bcWK2ikbv+MtCp5HS61bdumZ/vac5TF9T7A4IuyIY1zH/OQzbf/KlwEfwlayT7WGIij+oA==
X-Received: by 2002:a25:2404:0:b0:d9a:3992:192d with SMTP id
 k4-20020a252404000000b00d9a3992192dmr12656452ybk.16.1698186250038; 
 Tue, 24 Oct 2023 15:24:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 9-20020a250d09000000b00d9c7bf8f32fsm3927572ybn.42.2023.10.24.15.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 15:24:09 -0700 (PDT)
Date: Tue, 24 Oct 2023 18:24:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v5 14/16] cmd: add scmi command for SCMI firmware
Message-ID: <20231024222407.GL496310@bill-the-cat>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-15-takahiro.akashi@linaro.org>
 <CAHTX3d+hU2e-Un244wVzmeanwXkG+cy7+LdLZxYVojM3kX__5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PPJCeVsYjugUIfMq"
Content-Disposition: inline
In-Reply-To: <CAHTX3d+hU2e-Un244wVzmeanwXkG+cy7+LdLZxYVojM3kX__5Q@mail.gmail.com>
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


--PPJCeVsYjugUIfMq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:27:44AM +0200, Michal Simek wrote:
> Hi Takahiro,
>=20
> =FAt 26. 9. 2023 v 9:00 odes=EDlatel AKASHI Takahiro
> <takahiro.akashi@linaro.org> napsal:
> >
> > This command, "scmi", may provide a command line interface to various S=
CMI
> > protocols. It supports at least initially SCMI base protocol and is
> > intended mainly for debug purpose.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> > v3
> > * describe that arguments are in hex at a help message
> > * modify the code for dynamically allocated agent names
> > v2
> > * remove sub command category, 'scmi base', for simplicity
> > ---
> >  cmd/Kconfig  |   9 ++
> >  cmd/Makefile |   1 +
> >  cmd/scmi.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 347 insertions(+)
> >  create mode 100644 cmd/scmi.c
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 43ca10f69ccf..f46152ace7d8 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2533,6 +2533,15 @@ config CMD_CROS_EC
> >           a number of sub-commands for performing EC tasks such as
> >           updating its flash, accessing a small saved context area
> >           and talking to the I2C bus behind the EC (if there is one).
> > +
> > +config CMD_SCMI
> > +       bool "Enable scmi command"
> > +       depends on SCMI_FIRMWARE
> > +       default n
>=20
> This line above is wrong and this was removed from v6 with
> "drop scmi command which was intended to be used for debugging".
> It is fine that it shouldn't be used on production system but it
> doesn't mean that
> it should be actually removed.
> It is useful for bring ups. Can we get this patch merged? It was
> already reviewed
> anyway.

There was then also some conflict with the follow-up series here. I
would be fine with the command being introduced again after I merge that
second series, which I am testing now.

--=20
Tom

--PPJCeVsYjugUIfMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4RAQACgkQFHw5/5Y0
tyzVtQv/QHTH7Ue3GmxXk9xTtwiIpF1OX8dxdVrexo70kdbaAQ1sdDno9JUz4ux1
/Dlm3UdqDLLBJXmrEE3SPrevDBx5dlY33nEkfncaxMkDJg3J6chYDgVp3CO5Vtzx
a9W2FDFZ7Ki/WaWkIC2Y61+7ET2dquMpB3BwNao1NviRY8IWSEjf7NvMxTP7mdcl
dO+0+D/bDEEytJBhnawe+bE2pqQ6dsf3rs+F1/AuUlbYQs4ER5XRV5+y3i+hn8mI
4BeX0A9I/CS0W9Lf+lRJfasJ3qG5EK8avnxzWhSFhPWV5u8ERySmssjMvYWyVn9x
Lb93D90KX4ppXH6It4OstiUOwQdICYjK+GLEziOwKX6RTe7b8DXNPbZ+dghuUIK7
5xA1ftInMMXO6JJamY3tXpu3miB5gEP1NUhBqOPT6hSvtdjxIxPLsSs/35k2C80d
RixurwWm816GI7NXsxcqGOaj/e1E/BZSmWZLul6+4frIv/xdtD5V+Xo78+Q1sm97
9qS02FkJ
=aRva
-----END PGP SIGNATURE-----

--PPJCeVsYjugUIfMq--
