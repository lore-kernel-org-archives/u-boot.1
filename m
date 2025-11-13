Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994CECD98F2
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119AA84064;
	Thu, 13 Nov 2025 23:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bdqp/pYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FE284066; Thu, 13 Nov 2025 23:08:34 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D46F84057
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6da42fbd4so557639a34.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763071711; x=1763676511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n0dWPLW4t9ZbbZjm/Qfk8N6/X2HpA84wUyC808RpFKo=;
 b=Bdqp/pYNr2WagTJQUJxRor1EOsvCtA7OsG+UIhNRnbdoK1JE7GYVSj/MmyE1de6X5M
 XE9WK3MsTmuap2berPDzUfgiAMof3s+4hkSjUeUCIasw7i49ExdqT/gkPshVf46h6yWc
 vLz5EXof/fJ2Wl6xIJJQSBuoqr8/WHBcaP8sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763071711; x=1763676511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0dWPLW4t9ZbbZjm/Qfk8N6/X2HpA84wUyC808RpFKo=;
 b=Q9SRzjqtHZgDNgC6IneyUKuFa4yl1CoN43h6Sua2lXOrLn87n53XCX3DDgDTBdR0c/
 Pt1uFcH9dwG7uULqWeEliEOBSxbqbEeIc+/ajlGCiYZZKJ4j5LCF/3Lj80pXYFXF7Zgo
 7emZdmWpeIctLOLhGadDwtZgtjGIXCDkcZf9Af89+gCA0poHILRJgsRfPTqNSt8TdPbV
 44jr+wbb+tnKLV35aFuOKHqxWti2cC2DQXldi7UmlhxsOree4pUDY6UAsyKYWhI4e3qG
 GwvYriPdxbUVDnfOlNof6H91wcV2O+VxeR26cqfay4JTzw+fY1SAj25JFrBMUgAUxWCB
 wsqA==
X-Gm-Message-State: AOJu0Yz6Z6lngGCwO6hDAql3ePg4zq5gB25dlXQlMtKYmwaXBFGVWEpb
 HtIJDYFBHBy9zI0chfx6gHGoTLnun4r4xM/MzAQ5CBot4QcSfxCyHIg4jvyExXZUIx1LESiBnwC
 VC460NQA0QQ==
X-Gm-Gg: ASbGncvwepbQiEUqAW7t8iEhvFtKEqTHuJWGoLaJFRb4ekTnnMLISE5XYzIr0QJmfoL
 0bq9RuQkMixz69xvs5ePABKiPfxk4/zl5rNntgLJkS7BONv1hgg/z2/06ulLe2xf61Z1MExjWSI
 Wf1DACi8qzxnW/1NfD6oNsXGf0K+cXrYn9IWDPEDXON9Tj5SbX8MxXllbCyRTOPxrtnvFEmOwnj
 Rc3GybmSBkep8SL5EUH444TPtb7ZzSrydufBEFntRPzAk/WYdbikoJxBc/nvQH6rgDYFeEGZ4JY
 MGCgy+mdlUi1TsYhHeK+B0cy1U1dOhz5UVDBm5w2RC34O10efxZzfqjKUax1i7qRIbyyN/i58QT
 HJgEz2NV9nyailepdMwuz40zjQ9nZoA/mMfFSTeTWZfVhJ/No1E+GWSx+bfZP3vDyzmI3kfMgyq
 fwI4XteNIFDs/4x0P28jK3aTSHSi3jNC+18lNtK+yV5I8jgAwTFg==
X-Google-Smtp-Source: AGHT+IGRIjtP7slf1YAsqy9ZRi+k7JCuLEMvIWATb9pvLHDDfebsbr0JcmqpIqEimBU+ZQEMsmH8lg==
X-Received: by 2002:a05:6830:dc8:b0:7c6:8c73:aafb with SMTP id
 46e09a7af769-7c744594aa5mr838806a34.35.1763071710798; 
 Thu, 13 Nov 2025 14:08:30 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a2c2602sm1879159a34.15.2025.11.13.14.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 14:08:30 -0800 (PST)
Date: Thu, 13 Nov 2025 16:08:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Dockerfile: Include python3-tk for FATtools
Message-ID: <20251113220828.GS6688@bill-the-cat>
References: <20251113205733.1818836-1-trini@konsulko.com>
 <eddacbad-b443-4597-ac18-fd9265b9ef2d@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OzpsgFJ2MWjzJzaz"
Content-Disposition: inline
In-Reply-To: <eddacbad-b443-4597-ac18-fd9265b9ef2d@mailbox.org>
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


--OzpsgFJ2MWjzJzaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:37:17PM +0100, Marek Vasut wrote:
> On 11/13/25 9:57 PM, Tom Rini wrote:
> > In some cases our tests for exFAT don't run because we fail to be able
> > to create the underlying image. This is in turn because while creation
> > of the image succeeds, it seems that some way of how we invoke FATtools
> > wants to import tkinter, that fails and so the test stops there. Having
> > tkinter available (and then presumably a fallback to non-GUI because
> > it's not available) leads to the tests running as expected.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Marek Vasut <marek.vasut@mailbox.org>
> > ---
> >   tools/docker/Dockerfile | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index d2384219c06a..f62513b86b2c 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -127,6 +127,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,=
sharing=3Dlocked \
> >   	python3-pyelftools \
> >   	python3-sphinx \
> >   	python3-tomli \
> > +	python3-tk \
> Keep the list sorted please.

Ah whoops, k does come before o.

--=20
Tom

--OzpsgFJ2MWjzJzaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRZW2AAKCRAr4qD1Cr/k
Ct5IAQDvKw02SoDoJCOjVSZT4JNGKVL4DLfutOXHbNli43wk7AEAyq54cfO1tixQ
2cJdbt8p/2P2PZ+FRFgRGDH6kCgSwgw=
=CunV
-----END PGP SIGNATURE-----

--OzpsgFJ2MWjzJzaz--
