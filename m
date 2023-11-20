Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A972C2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 20:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C689D86A4B;
	Mon, 20 Nov 2023 21:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qroQbUmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36A887562; Mon, 20 Nov 2023 21:58:58 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A6E87579
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a877e0f0d8so45655787b3.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700513935; x=1701118735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IX/VNw2IqKrO/dcr0jNEs79Fyl5w3Rj4C7xwHvm3zZY=;
 b=qroQbUmUPsXm2qLehqEM9yRqKZhcbIRytPlDp9fGZXq90dXZcU2BjAL0gQw62tTChu
 +3rPSxwFW23TRPvy/xZo5W9LgKsmxgnrNt5JzHM+dmXl97KXaG14TxnYrv1G/RE94Hp+
 Y3nI59wqgkVpCA2UrwLK87+u4eCZa6LsA9E4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700513935; x=1701118735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IX/VNw2IqKrO/dcr0jNEs79Fyl5w3Rj4C7xwHvm3zZY=;
 b=mYlBgYFoso765+JoY1TJQDAaEnBSFO+shGRtoOvsGmnn0bL9zj5vLdhTr0/GgsYgdw
 DIdL4q3G8eMdwEW7PfAHN2o7WHwC49amyqdvxpsT77g9qwqgiPXljQxWgozqZQYMrGKL
 8T6/4Bqaprc4VOsBKFtroAeMoEhRf7nyG6GIiFoPgUhg0qLsGlwQL/heU4U/UCELRbph
 NWzHGuJV8hwBHB8+eTS2AYC8t5cFnNpPSxuJbq9CNAFCCehIp4MPFGNw7N1wBvNEv6DJ
 hx+s2i7aSiH86nCj7vhJq+BFCjVg5Ie/HaFeuIVXgXFlVopakTiELNtKAxeFdqnsqW6b
 dcPA==
X-Gm-Message-State: AOJu0Yxmxb+eu8cvNBZVWuAl9clLQaUBMkttGzy0zWhIgViSWNdmQ0Od
 soO7GqB26RVhi2/2FNxSLjqp1w==
X-Google-Smtp-Source: AGHT+IE4tdcGH75L58mFIH8npEHtuTObDfVhNcaum+DEPugDM174KkttMfhMKK0GfuA+aNq9o2mh3w==
X-Received: by 2002:a81:f802:0:b0:5ca:9794:34d4 with SMTP id
 z2-20020a81f802000000b005ca979434d4mr658806ywm.19.1700513935437; 
 Mon, 20 Nov 2023 12:58:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 h71-20020a816c4a000000b0059beb468cb4sm2592017ywc.1.2023.11.20.12.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 12:58:55 -0800 (PST)
Date: Mon, 20 Nov 2023 15:58:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH 1/5] cyclic: Disable in SPL builds
Message-ID: <20231120205853.GK2513409@bill-the-cat>
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-2-sjg@chromium.org>
 <20231119155909.GC2513409@bill-the-cat>
 <CAPnjgZ0LDXcstrAgx8nb53Cw1=1Y8Zait-e884A5i8H5CY6hnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CfHC62yX1rrFbTTH"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0LDXcstrAgx8nb53Cw1=1Y8Zait-e884A5i8H5CY6hnQ@mail.gmail.com>
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


--CfHC62yX1rrFbTTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 11:23:41AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 19 Nov 2023 at 08:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 19, 2023 at 07:46:39AM -0700, Simon Glass wrote:
[snip]
> > > diff --git a/include/cyclic.h b/include/cyclic.h
> > > index 44ad3cb6b803..d3b368dd90df 100644
> > > --- a/include/cyclic.h
> > > +++ b/include/cyclic.h
> > > @@ -11,6 +11,7 @@
> > >  #ifndef __cyclic_h
> > >  #define __cyclic_h
> > >
> > > +#include <linux/kconfig.h>
> > >  #include <linux/list.h>
> > >  #include <asm/types.h>
> >
> > Is this really needed? What's blowing up since we should have -include
> > .../linux/kconfig.h cover this.
>=20
> It is the CONFIG_IS_ENABLED() when building. We have kconfig.h in a
> few other places (used by tools) too.
>=20
> In file included from include/watchdog.h:13,
>                  from tools/../lib/sha1.c:25,
>                  from tools/generated/lib/sha1.c:1:
> include/cyclic.h:47:22: error: missing binary operator before token "("
>    47 | #if CONFIG_IS_ENABLED(CYCLIC)
>       |                      ^

OK, for this we need to cleanup lib/sha*.c include directives. I'm
tackling that now.

--=20
Tom

--CfHC62yX1rrFbTTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVbyIoACgkQFHw5/5Y0
tyzXRgv/aU4WzL2uW860Gy4pldpjpZKwrDECbkHsNOx4cFoz4MmTXTVjArJnVXwc
ic5wrO1nGehRBwS636XFxHHuHsIrgnosWmkBtLIx0QOOtNBuWIMW8BqxELlVMW2q
jdTGC/Y5ThDbmkyGqGZcuIEtmKcZAbdD3yUNsG7S6MECkrTqD/a1RjGoVMZm1rk6
AZWQHiXytvEeUea+UYYQ3FlX9aiQUaO0cRPsASwZiy88eLEtYt5EXkO2/bNTU7/S
eBk6NCj0il/Tiwylx7dRLPU43ASHxsr2OG8BhTMASwVULD/M1a6X39ZuVhHP+YlX
3XaBpU0ClDt30p7mYlXzHpza7rogzjS1KInhwTwwCQQTTsTbcCZ3aptAb/gQo90J
MtND/m3Wixz7ekfxiBPWKb4Rk5seQXdA6dNbamZWR9JCpHLhokJ8Dyss5wHNR2Lb
ZPjyzAToxVVyU9+gbTRC+onujySXIknXUiOYqQkpo1IBt7QDUTPaxCtwsqoAyTfd
RICp8qqt
=22DD
-----END PGP SIGNATURE-----

--CfHC62yX1rrFbTTH--
