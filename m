Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC4CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CAC87257;
	Thu, 19 Oct 2023 16:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UzYrxqy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C956B86FFD; Thu, 19 Oct 2023 16:57:33 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C17087257
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a8628e54d4so7996927b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727449; x=1698332249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X5ZiBOZWBAPNhzogYM8eBR+I7+6PEyUe2zfkusiCM60=;
 b=UzYrxqy9/aQTzJJXFGPnneXGSXG7H9/gwUovEIGQYnj4bb5Y70qDnPnsjKoNQIhlL1
 erEiRzHvgpTATPEcrBJB8m9o8mmKsmBNDfhijvgM0znhp4Pz0hwDcE1Plg87fRVJr3Hs
 Bkbr73so5kLNBxU7f74MSO+69ubkWuL1NTRVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727449; x=1698332249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5ZiBOZWBAPNhzogYM8eBR+I7+6PEyUe2zfkusiCM60=;
 b=Vc+NkmrkMICgsUZOwzs9l1iZhaDUSe+JC9Enx7AllzQX4YUdc8JMnmQK335acU/tn8
 DzR9Hxl3qb2t11+V68XnN9/0ThBwlMzo7NM+0ozjOJTKRu/E3GktreQowjdwUQbnFCFh
 TsAS4z2Lv1jS+wFRKGqycYprjhbKO4n1n2rDwl6MgEX+SuPC9ctCppfbBoxS/YczvKX2
 nt2Mvo2P5IV6B0z4dgnPVNkZ+wpObD/ytv2dLxczXxozmQoCexKj1y6PsLAzd6CpsG82
 m6P2d2f0xIqyFwEz/LQOThJQY2BZG5dynIih+YkVlb7jjgfFIQ7HO2Kj0Wl4GGtYKQgF
 FF7Q==
X-Gm-Message-State: AOJu0YyE12vlx+GW+vuA8xePvlKzV8Xxb3C/31Jx//yH2ID2OB7vNrWp
 mpoK1DuLYvlRrsN//C5qXejn/MslrfN46wgppb9Cyw==
X-Google-Smtp-Source: AGHT+IFXANUQg+ElLx2XrIBc6DLrIKPgONW7xztux9y8hotUdxdeeLOGhnwRGsXQGy/1C6MGSAzDnA==
X-Received: by 2002:a81:8341:0:b0:5a7:d8c8:aa17 with SMTP id
 t62-20020a818341000000b005a7d8c8aa17mr1683800ywf.13.1697727448956; 
 Thu, 19 Oct 2023 07:57:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 o63-20020a0dfe42000000b0059a34cfa2a5sm2442167ywf.67.2023.10.19.07.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:57:28 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:57:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: rick@andestech.com, u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-riscv/master
Message-ID: <20231019145726.GB3119521@bill-the-cat>
References: <ZTEV5KksRDvCHqkT@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fk4/RFDdrwbFvvsM"
Content-Disposition: inline
In-Reply-To: <ZTEV5KksRDvCHqkT@swlinux02>
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


--fk4/RFDdrwbFvvsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 07:41:24PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 9a0cf3993f71043ba08c315572c54622de42d4=
47:
>=20
>   Merge branch '2023-10-17-spl-test-some-load-methods' (2023-10-18 08:28:=
00 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to bc5a50452bd42029d6587e1596b44ff235655e90:
>=20
>   riscv: Add Zbb support for building U-Boot (2023-10-19 17:29:50 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18215

Applied to u-boot/master, thanks!

--=20
Tom

--fk4/RFDdrwbFvvsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxQ9YACgkQFHw5/5Y0
tyz4swv/aRk8o+W6CVNgQdSCwIkShZuH68QSUx3015GfKB3+oOygSl2IlvOBI1tZ
5c+h7HjKXF/3CDEFwawk4wA9s07f+WorN7IcDYfrQR7vNMHlqwrHBMBryeGk8vxE
amMjQ4W0H3eDAYE+mrbgJe0oeaswg6PpqYlkj6vPlgPd8PTIj6rzYOIZLX7jGNKl
Ca3gQBo6ZGVy0z1h8YtUF1aLiZrTGMVhY+5VqpPWaY3iE+TnKSDyCCmq+Jfc+3HM
/K6g79+tmo7lGHyEm1QsrWJOLar7Lcd55o0A5IjWdT0yTf9+Tp8y98dA3wEh5A2O
Np6qst1DYEqZRU8cWBoZlnrBaw91PfeXJ/aXDiUpowwyRNwBCDj7MxQXcUj0Y1u3
oq+j8og7+ddGxBGBardDCD5czJz221qVb7SF0ZkADGbvItxdjoKqfIvZSGhuzegC
sMe1/jotX1VFBg3FQF+HgCKcjSIEpQhnfNCQS+UzHag1CbnJt5NJOfJS9JbeQHWI
LihVJoVk
=4q3E
-----END PGP SIGNATURE-----

--fk4/RFDdrwbFvvsM--
