Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DB1CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC2D837E2;
	Thu, 16 Oct 2025 17:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TUbT76kQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816FF83807; Thu, 16 Oct 2025 17:32:41 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CD883734
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7bc626c5467so558865a34.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760628758; x=1761233558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EoytwwgtR3+Nv5BSjBNqehQ8dIqnQSIYS+RbDOWmmgY=;
 b=TUbT76kQ1Xm0nMR4A6XA8L943CBUwK37CXadtM60vciU/l1BQQueZkEMU0JRVbEPyF
 +KdY2Do4GSs1UtfcMl9oFSCgJbgeoS0M3Ft+Vr++7vzw9nMTPsfzq7Q9DUO2Bvnda4dW
 Z+sGebJlz8AGeDpQ0csDKcZKR1eeBtuXlLiSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628758; x=1761233558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoytwwgtR3+Nv5BSjBNqehQ8dIqnQSIYS+RbDOWmmgY=;
 b=TnTVV1AyY3WVS0sZHtatdbz5ovqkvNGLYlal+EBbcaMPk01gmh2ji/jP/zeVmSzL3F
 r6iX7iJHt7w0tIIVqXjiDjjNIcYyzQ0hvxc9BFmLtjtUEiCjYvdGXwc8deKv9njtgYlw
 2jmcXfsV1yvF6JxHNoygsjlyYI7697Sb0vDhcDgddkZ+M4U/ZVtUMeia5mCfUS7ZEI8j
 xQC84pe6KNBEcM/Y1eSyiFCRaRiT7T6sqp1SaVJGn7JQCvG8pNNkIRRTSNZlG/EQmHUI
 8IkcEpCuLj015oXW4xR079MB4D+X93ELqLqJO8XMu1nMQ13MeV64D/FYl2Ub+WRQX0qn
 nA3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDIcOQBQj/ffczShwCrcd4t8cudZ+IzNuto9tW/Sh1sUa3ZDnJ5os5lW39SUIpWq11KyzucrA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7opovHL930D6zIxyzWz49Z+HF/QVPNly0K3UdnltvSsIWtzK1
 h4/Z2F888SBCzF2pWra/yj34CrDiFvBYXPcdcPaDOMlMVfWhajcpQ2+miofPpCAHXvN+Z9J9f9D
 21kT62EY=
X-Gm-Gg: ASbGncsdNlM552aPKKkynJ0uQTnyhyixl6A3hW4doOifMlRAP+Ae8Z+wOMkFA5tZEyj
 K8P5wihnaHxs344gzq5k0dC+/WcOj1VATk1mRKBV2Uj0vpgg1wRjuKnJDcJN3y351Fg+UWyxt6R
 NOmAzxwNolf7+wiSce3j6eEk86r/gkJshdJO8hq+yI2VmMSIhD64a17cgUhKsiBepZr5qtsoa8A
 HvnzJwzEJo4OgQDrtU4cXFk8Zshsp34QmYhiIrJ15PzFfzl5nO3qpwp2uGZdv2DkQSH9yIy/LiR
 K4WqHBfqyefWpTGKSOyfKQHvj+E72bxVXwgLtqxq4IcP48cQhaFhQ+wXbbZyL4yawShCGcl9zrb
 rCQvGEgCudwPCGJMoQWV+6oZcDIz4C2uF3XVjrGsY6mAbPCvw5RiMjA3D4LBGbrXLBstUW1NUSm
 kdcECQ4KSJO8CAtNbfjvhWlmuVJy70sZ6I94SFDwE=
X-Google-Smtp-Source: AGHT+IEzHuDcg97o7ocTlmNLRFUgMHma7GechnuvO1eDdqVU2ueQheJ/VaqOFOiD5YJx0vfoEvVt6g==
X-Received: by 2002:a05:6830:348b:b0:7a5:ddd5:72d0 with SMTP id
 46e09a7af769-7c27cba86c2mr123823a34.17.1760628757839; 
 Thu, 16 Oct 2025 08:32:37 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2795363b2sm321767a34.33.2025.10.16.08.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:32:36 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:32:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [PATCH] net: make dhcp_run() common for NET and NET_LWIP
Message-ID: <20251016153234.GB6688@bill-the-cat>
References: <20251009123034.2441110-1-jerome.forissier@linaro.org>
 <55a322a8-2e3c-4936-998b-786e9e14565f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Cxq8c/K6z7UNX+Ch"
Content-Disposition: inline
In-Reply-To: <55a322a8-2e3c-4936-998b-786e9e14565f@gmx.de>
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


--Cxq8c/K6z7UNX+Ch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 02:53:50PM +0200, Heinrich Schuchardt wrote:
> On 10/9/25 14:30, Jerome Forissier wrote:
> > THere are currently two implementations of dhcp_run(): one in cmd/net.c
> > for NET and one in net/lwip/dhcp.c for NET_LWIP. There is no
> > justification for that. Therefore, move the NET version into
> > net/net-common.c to be used by both stacks, and drop the NET_LWIP
> > version which by the way does not look totally correct.
> >=20
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >=20
> >   cmd/net.c            | 36 ++----------------------------------
> >   include/net-common.h | 10 ++++++++++
> >   include/net-lwip.h   |  1 -
> >   net/lwip/dhcp.c      | 22 ----------------------
> >   net/net-common.c     | 35 +++++++++++++++++++++++++++++++++++
> >   5 files changed, 47 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/cmd/net.c b/cmd/net.c
> > index 886735ea14f6..24099764493e 100644
> > --- a/cmd/net.c
> > +++ b/cmd/net.c
> > @@ -134,8 +134,8 @@ U_BOOT_CMD(dhcp6,	3,	1,	do_dhcp6,
> >   #endif
> >   #if defined(CONFIG_CMD_DHCP)
> > -static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
> > -		   char *const argv[])
> > +int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
> > +	    char *const argv[])
>=20
> Thank you for all this clean up work.
>=20
> Should we move the dhcp command to a new file cmd/dhcp.c to get rid of all
> the related '#if' statements?

Might be a reasonable cleanup, yes. But at some point, the legacy
network stack will be for SPL only, ideally.

--=20
Tom

--Cxq8c/K6z7UNX+Ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPEQEgAKCRAr4qD1Cr/k
Cj07AQCOcewuxEc9EJAfmIwZucSBoepOILL+GTnTMsfe7pP0yAEAtP2iFGb7+bn8
JqFscf8XQ4BWwFKHY+fxY+BxoY3IFQI=
=Df3A
-----END PGP SIGNATURE-----

--Cxq8c/K6z7UNX+Ch--
