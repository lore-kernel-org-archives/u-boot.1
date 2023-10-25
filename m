Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FECC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 01:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5D587999;
	Wed, 25 Oct 2023 03:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PW3gWVIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD2887A00; Wed, 25 Oct 2023 03:14:59 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C9187199
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 03:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cacbd54b05so3526115ad.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 18:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698196491; x=1698801291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym8ZaSJVpYIBicYfbaeSIi8s6Bxjb/XB3WUOYdGUw8k=;
 b=PW3gWVIO1OSGUp1Nds+v0sRwIAG5vQ9M9DHEGSXawL31Ra41DY3lw3ZGmb0mTP5nfa
 G6Rh2My8Z2NrUqS7LW/NjzHh3dg1NX0F2mFeeYPGenC5WovayyFlHDm+2vYY+bfBpvgh
 1edCGbhLbPDpdoc8XmZ3wZHzOXQnQyeTaFmenJ+HhfrBg/tX82o8RNmYFYD2nReRJ9mW
 xLvVT+5GFgeO8EQzU5A2OuwwJj4hMCoZVK863DBdTzG7cfYoDMtuPawmOXICO/Ia6iN+
 S5xiVUHWT9HUWPoO2m4mpl0Kg5LfRTAhnDKDU/c713uRDCSXi+iSH2xDdhSQsF/Kv9qs
 VOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196491; x=1698801291;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ym8ZaSJVpYIBicYfbaeSIi8s6Bxjb/XB3WUOYdGUw8k=;
 b=wohE+hV1a4Vf2d2YNC+JhnpAZbbaDG5eyf1L+KHEmJ/J5NlrZpYSl8XYcKrLGwT/07
 we6W91aYIrmmnS7zXzsCE8vGzswgNKIIuTvwHH3D1D3zW2ztdmzuLLIFeUMLPu9CMH3j
 fIYzNqhjvHpncBXKEZTEaXd7y4VZlAbaWcYLSCR7ukPiWsaYHA/W2+2dSaFRcTw2mGx2
 3rRn9roDpMKLu01SBcmBkcb2eOZ0cgt2bdL8KtdO0kBl8707xOrLw0mZxUd3sNvTuAZ0
 wZ3qM4/wCDPM3rS4zDHy1RzgLPvU488AKc2FUfEfSm4sPV7+DyCeT8M1y0s0ooWAk+RK
 5FZQ==
X-Gm-Message-State: AOJu0Yzohkd7eQk4ZZ1oagXfThPTZuv2T7s7pSRirZN17HWoFhJUVQA8
 18gi+wYTQ+s31NmPrd7aoMxlTw==
X-Google-Smtp-Source: AGHT+IG5OmgX/s1sYKSj1umavJbRBNvgY7zsTxs+4NPl1H9vRc8PXixA3ZHbBDIS39HNvFGEcKw7SQ==
X-Received: by 2002:a17:903:74d:b0:1c7:1eed:10f2 with SMTP id
 kl13-20020a170903074d00b001c71eed10f2mr12922727plb.2.1698196491037; 
 Tue, 24 Oct 2023 18:14:51 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:65fc:df7c:6edb:619f])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001c74718f2f3sm8048870plb.119.2023.10.24.18.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:14:50 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:14:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <monstr@monstr.eu>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v5 14/16] cmd: add scmi command for SCMI firmware
Message-ID: <ZThsBtgwAyBjlR7A@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <monstr@monstr.eu>,
 sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-15-takahiro.akashi@linaro.org>
 <CAHTX3d+hU2e-Un244wVzmeanwXkG+cy7+LdLZxYVojM3kX__5Q@mail.gmail.com>
 <20231024222407.GL496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AoleUUdS4XJs8skp"
Content-Disposition: inline
In-Reply-To: <20231024222407.GL496310@bill-the-cat>
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


--AoleUUdS4XJs8skp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom, Michal,

On Tue, Oct 24, 2023 at 06:24:07PM -0400, Tom Rini wrote:
> On Tue, Oct 24, 2023 at 10:27:44AM +0200, Michal Simek wrote:
> > Hi Takahiro,
> >=20
> > ?t 26. 9. 2023 v 9:00 odes?latel AKASHI Takahiro
> > <takahiro.akashi@linaro.org> napsal:
> > >
> > > This command, "scmi", may provide a command line interface to various=
 SCMI
> > > protocols. It supports at least initially SCMI base protocol and is
> > > intended mainly for debug purpose.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > ---
> > > v3
> > > * describe that arguments are in hex at a help message
> > > * modify the code for dynamically allocated agent names
> > > v2
> > > * remove sub command category, 'scmi base', for simplicity
> > > ---
> > >  cmd/Kconfig  |   9 ++
> > >  cmd/Makefile |   1 +
> > >  cmd/scmi.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 347 insertions(+)
> > >  create mode 100644 cmd/scmi.c
> > >
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index 43ca10f69ccf..f46152ace7d8 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -2533,6 +2533,15 @@ config CMD_CROS_EC
> > >           a number of sub-commands for performing EC tasks such as
> > >           updating its flash, accessing a small saved context area
> > >           and talking to the I2C bus behind the EC (if there is one).
> > > +
> > > +config CMD_SCMI
> > > +       bool "Enable scmi command"
> > > +       depends on SCMI_FIRMWARE
> > > +       default n
> >=20
> > This line above is wrong and this was removed from v6 with

@Michal, do you mean the default should be 'y'?

> > "drop scmi command which was intended to be used for debugging".
> > It is fine that it shouldn't be used on production system but it
> > doesn't mean that
> > it should be actually removed.
> > It is useful for bring ups. Can we get this patch merged? It was
> > already reviewed
> > anyway.
>=20
> There was then also some conflict with the follow-up series here. I
> would be fine with the command being introduced again after I merge that
> second series, which I am testing now.

I don't mind neither.
My concern, however, was a test, "ut dm scmi_cmd".
The output from "scmi info" command varies depending on what SCMI protocols
are provided by SCMI firmware (sandbox fake server in this case).

I will try to keep it updated.

-Takahiro Akashi

>=20
> --=20
> Tom



--AoleUUdS4XJs8skp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmU4bAIACgkQJ6vpGq1m
yG1Eawf/c9jEpr1wKzSPB/HLe5PGDrUmDkHFTVy1wtZEQb+FCx1n6QtAz/O8abUa
pHH7d5LS4MAep5o35LqPUCUuUyXz1rIrXK4rxyhaQAfnwqZ+KpdXbOttGZi+3kq0
AvagmSGsKqelFiVtCUM0y0YsxFbLHoMb7vdYe2e43LODSQw7JOSJ+yuefUMVnUGk
35I7fb/S0RRElW9dTKA/mdi+waoXXdvFa7izhCLeOU8FLOOGC0ih3hSiWquJlfjL
rHqXlJyBICOw0AgPStP5haee9+nm0KvVZgppiycGVmkg5p5mKSV+r7N1C4YNU+Dq
DmLqGctbl+vrgAnvACAjAjcJOsY6ZA==
=FsSz
-----END PGP SIGNATURE-----

--AoleUUdS4XJs8skp--
