Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45796C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CCE82A9E;
	Fri,  6 Jun 2025 16:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihh7+Etw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D53F5800C1; Fri,  6 Jun 2025 16:17:12 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB5782977
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a5a196f057so41574621cf.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219429; x=1749824229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JNtvEWWvRPQzYhH67Q58lh0jXzO/BQAGtmXBiCgiRas=;
 b=ihh7+EtwL8l7IPcF0wK9xMKq/ZsC6Ldyc2wYXQCTE6QPumlr40N2T0NF8sLhkwBA90
 P7UQlajWNHNAzXMzm64BR/u725wq+kng26B6aXM53Vc0LKBKl73jybqz+HgcG+nUxcb4
 2fRLlBS4dMTvkqYRhCD2UZNSce9dS2kUFMSFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219429; x=1749824229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNtvEWWvRPQzYhH67Q58lh0jXzO/BQAGtmXBiCgiRas=;
 b=uN9hRIhqnQlDYh6+zJzku1bMIZN9Pe4rawyrFrwxqQhgOcEJBckYO05zvQ9OzFyp9r
 8XlWg3e12l/oPhCJr6SkRLedtJ1/V9h/Up0oUkvmjGJaOcp+Vdfr3tkIKxuGdvCPg6EN
 nailyoKKkgAg2bDL3JeUwdCWzHDXUxpqpeeIFuZtz2+RNrvj96nwMhsi277TI7heEkGg
 LSpysNdH9peM1f93K1S9Fjlpt48ru5aaZ+ovNjxK/AYOG3pAgxDccLIX8qUUdFCFqxKE
 D8G608VY6KHVKChfNKEoKHPgwDVhzD2zazUoTMxPxgUeKLMNJlSZVVJh/1mh0u2EVVQy
 pRxw==
X-Gm-Message-State: AOJu0Yx8BfOPL21UZMbAhBe5kj7cZ5C+dxdJhUmMoz/mwfrHOkq7ICY4
 IKZfPD8U6DmeLho/g4p1Yo2F+onzBH1zVYyGf9/2t1AhVK7pCECskzOXj+xALc3biPRsklEP1hK
 Bdq8JlXU=
X-Gm-Gg: ASbGncvwTgNWSh1HQRNWWblHVEP5pBd1aGFGkGKbOfO7/I+84pQhPS8lboIWpH0vLKE
 yvaT3hBkTs+2ShmVIaqDFVoyak/oy3e8/2D0TSP2eD+o5epQkB42k95HbTjlHTTwC3BeT3mON6i
 gKRMnIkJpnksrQKRDC53/cNBq7Kh6OmOtwTc36sWxKAk67ufO4RWaZ3O7P6ZOgHZ3/MVne1k5rR
 ckaLArHtcyKZwcNU/cbutIDEqdWyXyJKazumW/+ka1dJ0Uw+xx6AykXhQou5rKNLOrxsg1SG6Xa
 ojf73KBVMiLhtxPixVIQ1VfRF4aHHy0windj0LowG3TDxJnQ/Mm4A0iERoOyxheyECsiKZplRYS
 ZKV8HdFsvMEW9
X-Google-Smtp-Source: AGHT+IFNJkGP4NrZRNYb6Lk/G6AKjRap8qEhO3z1FNhEl3XwFMeuknj2G+ZJjURaYpiekqxy2lAF/g==
X-Received: by 2002:a05:6830:611c:b0:72b:8889:8226 with SMTP id
 46e09a7af769-73888dbf65amr2378330a34.7.1749219419123; 
 Fri, 06 Jun 2025 07:16:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f57113sm291255a34.15.2025.06.06.07.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:16:56 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:16:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 02/13] lwip: split cmd/net-lwip.c into one file per
 command
Message-ID: <20250606141653.GL1382132@bill-the-cat>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-3-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m1UDc83waUe8pck4"
Content-Disposition: inline
In-Reply-To: <20250606064211.3091237-3-jerome.forissier@linaro.org>
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


--m1UDc83waUe8pck4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:41:38AM +0200, Jerome Forissier wrote:

> Move each command in cmd/net-lwip.c into its own file
> (cmd/lwip/${cmd}.c).
>=20
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--m1UDc83waUe8pck4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+E4ACgkQFHw5/5Y0
tyxvswv+LwgjM5i/cbSBcFcIheto/eQKE+uj17bJz3SCCMZprBq2vtUE6R2yJBbk
VZfYMFb1BrhiKtQRQ40T+/4P2vIZZXX2mEkhQWj3ViD178NUwZPKLrjFj5X0EEzx
yAPRFuSMuj1ow17+qaXWfVBUidfZn6aBdYcPglJ8XuJ2NLefqv4Ue5cDlWRI/UlM
0dR5M0uj5V3dbIG3Gzp2nqWo5pwU3OitaH/BGUuHEp971jeLVE+O4GtjohTnIE3Y
MX8Sq8Blnm2/nQpCG6rJPj0CMcpA3/7Btlcc3vw67crWUMWjNuj0XdTKFbCFSSjC
PJlA5MvpzeuKnvMw2HfIEvhCBGGiLOGyrsmamrmSQra71wuPQvJyQ2ZAfNnHZSdW
CXe217ciKU+U+mkVTG0zoV9udlfjssKAzFhnEnP45s3oBDxegOz5I1GMG5122UKY
nHAjlnGwSybNbUjNX0XoBSxv1EJIWdts2y0xhyawMd0fRZ33rQ+W0DVapqJVPEDS
UuBBwTCs
=w11h
-----END PGP SIGNATURE-----

--m1UDc83waUe8pck4--
