Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220F9C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6408C86828;
	Fri, 25 Aug 2023 16:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jjd4dONB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583198647A; Fri, 25 Aug 2023 16:55:52 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F7C4855CE
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5922380064bso11865597b3.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692975348; x=1693580148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sVwr5P/6fBlR152bzJFcpMQqyzeF9ATTg65tTSRy2SQ=;
 b=Jjd4dONBQlIeaZO4lCtbeo/b35v1zvMVlGTOqdw1Mthiiccdnaw8PLO/ASaLjSuzdo
 IvvSYI8HdU2Wk6M46Syx51/XmdnUXHAnLO0r0BofhALXisDay6rRn600x0JK2QqJ8rW4
 5aEzXintcN/LiA4JdhqSf841grQm4o8JHqSEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692975348; x=1693580148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVwr5P/6fBlR152bzJFcpMQqyzeF9ATTg65tTSRy2SQ=;
 b=Fa2q7GVgxy1vDuK6CdpJ2gdZ6elKWCPNRJ6bKIZk95lgKYrnTbvgDKIyRME92S3GXZ
 RZIfb3WkKxzZ10KT2Y0eYuhYvzDTD0Q8U6lHwwDyPBZLhx3qayaBHf3tvz/sjuvYt6FY
 V/ALJSgWIWdubVPWZS0ZFAAuu+cFBJ+LAdZXNyrv6X7v8toiZn/Wbm0RJAQPcz4myS7f
 V+1ga11nn3ycdgO3zpgwA08gqT64f1Ff4Qo2WKdnmTJQ2PvH/5StvkJ5An7o14Jh//ge
 qvHvgLpOo8eQlxtKOcndLMmoCuSNZhdXfOrtWLDqL4KhFdIDxmQZTz+yP6mhzjMiv7rq
 DOwg==
X-Gm-Message-State: AOJu0Yw/QNSI3GSxgRo3+cPx8N5U2eWXfWURZ0Zz9kPysbOdTuTsvs7I
 YTTunBtJ0j9daDfYFScRcp+P6Q==
X-Google-Smtp-Source: AGHT+IHrGVvZH+IPPfhwKLCQgi3iIKCutvvgiPvkAmDVvuD9Vzg4/rlR2cmxZCtqkABnXxh1zjLXVA==
X-Received: by 2002:a0d:ccc2:0:b0:58c:f957:d1c4 with SMTP id
 o185-20020a0dccc2000000b0058cf957d1c4mr18379056ywd.36.1692975348278; 
 Fri, 25 Aug 2023 07:55:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 z127-20020a818985000000b00589fb1f296dsm536186ywf.51.2023.08.25.07.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 07:55:47 -0700 (PDT)
Date: Fri, 25 Aug 2023 10:55:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH 06/19] FMU: Avoid showing an unselectable menu option
Message-ID: <20230825145545.GJ3953269@bill-the-cat>
References: <20230824195917.1687886-1-sjg@chromium.org>
 <20230824195917.1687886-7-sjg@chromium.org>
 <CADg8p96y_rM7eMWzTD+4zNzjw4B-M-S9ja=rTO5Cw6iY1eFx7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hssGseffrUq7l7pR"
Content-Disposition: inline
In-Reply-To: <CADg8p96y_rM7eMWzTD+4zNzjw4B-M-S9ja=rTO5Cw6iY1eFx7g@mail.gmail.com>
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


--hssGseffrUq7l7pR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 05:30:17PM +0530, Sughosh Ganu wrote:
> On Fri, 25 Aug 2023 at 01:29, Simon Glass <sjg@chromium.org> wrote:
> >
> > Use a menuconfig to avoid showing a menu which cannot be selected in ma=
ny
> > cases.
> >
> > This option should really go with the other 'Update support'.
> >
> > Perhaps we should even consider a top-level update/ directory?
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>=20
> nit: s/FMU/FWU in the commit header.
>=20
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>=20
> -sughosh
>=20
> >
> >  lib/Kconfig             | 4 ----
> >  lib/fwu_updates/Kconfig | 6 +++++-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 9addcfab3734..bfab2f3165a7 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1118,8 +1118,4 @@ config PHANDLE_CHECK_SEQ
> >
> >  endmenu
> >
> > -menu "FWU Multi Bank Updates"
> > -
> >  source lib/fwu_updates/Kconfig
> > -
> > -endmenu
> > diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> > index 71f34793d926..be35ad29fa32 100644
> > --- a/lib/fwu_updates/Kconfig
> > +++ b/lib/fwu_updates/Kconfig
> > @@ -1,4 +1,4 @@
> > -config FWU_MULTI_BANK_UPDATE
> > +menuconfig FWU_MULTI_BANK_UPDATE
> >         bool "Enable FWU Multi Bank Update Feature"
> >         depends on EFI_CAPSULE_ON_DISK
> >         select PARTITION_TYPE_GUID
> > @@ -10,6 +10,8 @@ config FWU_MULTI_BANK_UPDATE
> >           multiple banks(copies) of the firmware images. One of the
> >           bank is selected for updating all the firmware components
> >
> > +if FWU_MULTI_BANK_UPDATE
> > +
> >  config FWU_NUM_BANKS
> >         int "Number of Banks defined by the platform"
> >         depends on FWU_MULTI_BANK_UPDATE

Looks like the rest of this Kconfig needs to be updated to not have
depends on FWU_MULTI_BANK_UPDATE if it's all guarded with an if on that.

--=20
Tom

--hssGseffrUq7l7pR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTowPEACgkQFHw5/5Y0
tyxj/Av9GKEd7hyXN3Qy4z/9lZ6z2iKX4j/CFDtuUckHbzQfxDCYSyXgvayLZFxj
EQFmTkiuBv5lEFFvDHbL/zA2uvsmOGr1FKEA5ujmateCcGWX7518Xt8cYW3vL3hZ
IuhPAomyljzUG3XriESrudBeIsrpAlrhFyLkCWSCKs0Z9WZnPCeUaiyqjrC509Hr
p0nQ9Z4NSiC/+qXDfnG03+wK9xiWKeo09/mEhKUyOCIxiNc9wEbVn35B8dMa6Pvu
DqQvU0cPY5DI6SKvhBLvv+GJBsIf0r1oob3ID9fxj0XZOts2u87+T2jV9Gl/FoOl
EcgF0MIaaNhJ+8wZjWVNmeHQfCSiaN7X2GzNx974V1JDrEsCquicuzQeT7IHd9ze
pXQC5JEj96pJj5kEqAJEo6BLuGrTx341ociwNP8+GCJNLiB0BLHaJswI6l9t/X4/
Y9OPxK9hgNk+4JkAts/t70Y/3kYU0+vDJnthyD1msr/sAlgi3fvHc1eKbjDVITMm
C97dGVWx
=Wf+i
-----END PGP SIGNATURE-----

--hssGseffrUq7l7pR--
