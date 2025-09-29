Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EB8CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DF683071;
	Mon, 29 Sep 2025 16:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTAQpv+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC0C83071; Mon, 29 Sep 2025 16:15:14 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E9D82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6426d56f376so1071267eaf.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759155311; x=1759760111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yFB+Hfzo2Qfd4QlvyDnmwFqNUZu2DDs0hdqMnX8NbzQ=;
 b=rTAQpv+xyOU6mBSsMO+LKfUvWiqVAdhQU7oHzqSjvoxNVvG2hWp6elOceFr9Y3L+zp
 mibN7zlawRbLbQetQQ+jqmB5isG8KzHTTfBo8LrDC/WpzpIWYd13sF/oZWsTS8ScUBXv
 IMJ2KyM0ys4Y6I0gfSwhivXqASdj5YpGvzfv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155311; x=1759760111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFB+Hfzo2Qfd4QlvyDnmwFqNUZu2DDs0hdqMnX8NbzQ=;
 b=QIdbygw7RDDsPvJqJpdrV5Y9VhEb4V5xyf+pokeMniD8M1EZYX+nTE6oHroM9hVNNP
 YVZgZcMLdZr8ZGTulbml0GeTgywLATBLI23vDolxPELiZAs2wPvTprRzoxAxwxBRwquL
 KMBRuyjNjSmq4Dj7x0RraPbFJhebKUAG2gUP0I7UA9xYAUuA8gZkpoi1SXDSK9aADUKd
 rt9r2YYEpHGpY69+MNkGtTJQHDsnzD6fTSCT8mtAwjGLhuhki+mWsqF0gzT2o4iQJOxF
 Rk0BmCPZG4ZOvTVAxC4S8asM949zvXUsSgWDZsFRzBjXedcLpscZK0jsB6xRSNoIXRuk
 8wSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNNgDwLB4ofKWh4/y0ob46Gaqk+5IqA6AEipJ9d3sUSjE7pFf1p/cjlWGIIY/URhk63Wq18tU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvc0v6qqxOFwGs8wIkmbujsmRvmjNY9McrCFvgj6tffwiMlsZt
 xXIxKnlfWCvmV0Pvd3WpSbsnJ0KquhhxoEGHKFwGZ3oOylc1noE17ufznYIMyRSjLzo=
X-Gm-Gg: ASbGncsQfJhE4cUihVCjNIG1KccoMMD474x8Riy1ZnTWbVEIJXgIVRUNNC33wGpfCIa
 mb7K3Z1DtIJ/AfF+bs8OWklvNtRewxng6yOWOwr9y+b6MfttCPf0AntiytHlOWnk0JIu+huNucw
 G186J9nvwISUP+wlcj5LgoLT5oIMV2PMLXnfvFD4R42a2JUdT2LWlTj/DZAjIZ/2YJ/8P5sFql5
 Sh5le6OYaSPKWOU7gByhLtN7yMWFctoFhgbXkc6xDTL9h4sP9L2u1o4qnI6SaWHcQoNc5e3F9xY
 UAYX8J8p3zLr+0OUXNiJs+3XLH0WmjHMdNt4gvyQQUxxvJGGuwqVJkY1bAwX/KY7hh5Mbh+XZpm
 AOtzTH3aWM6e9TMyhGSvO0c/512kiXzwSAAwZ7wN+j5cIJcmxp8gEXgXx
X-Google-Smtp-Source: AGHT+IEIFJPm3o+LugxAJbxo7A6fxr+/yZYIgNPIxnds4xuE6+7/R0MQCKkMCegEdKZuiJIxwVkIbA==
X-Received: by 2002:a05:6820:22a6:b0:61e:2be3:97b8 with SMTP id
 006d021491bc7-63a309fe6admr7836971eaf.1.1759155310535; 
 Mon, 29 Sep 2025 07:15:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23e168301sm2626603a34.23.2025.09.29.07.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:15:09 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:15:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
Message-ID: <20250929141507.GE6093@bill-the-cat>
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
 <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KLroVl2vKDpB41FA"
Content-Disposition: inline
In-Reply-To: <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
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


--KLroVl2vKDpB41FA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:09:09AM +0100, Andrew Goodbody wrote:
> On 25/09/2025 15:12, Marek Vasut wrote:
> > On 9/25/25 4:07 PM, Andrew Goodbody wrote:
> > > On 25/09/2025 14:56, Marek Vasut wrote:
> > > > On 9/25/25 3:20 PM, Andrew Goodbody wrote:
> > > > > In dwc3_ep0_complete_data there is a test for 'r' being null and =
the
> > > > > code will return at that point if so. After that point 'r'
> > > > > is guaranteed
> > > > > to not be null and testing for that is redundant. Remove the test=
 for
> > > > > 'r' being non-null.
> > > > >=20
> > > > > This issue was found by Smatch.
> > > > >=20
> > > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > ---
> > > > > =A0 drivers/usb/dwc3/ep0.c | 5 +----
> > > > > =A0 1 file changed, 1 insertion(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> > > > > index c656cbe25ce..680756532f0 100644
> > > > > --- a/drivers/usb/dwc3/ep0.c
> > > > > +++ b/drivers/usb/dwc3/ep0.c
> > > > > @@ -799,10 +799,7 @@ static void
> > > > > dwc3_ep0_complete_data(struct dwc3 *dwc,
> > > > > =A0=A0=A0=A0=A0 status =3D DWC3_TRB_SIZE_TRBSTS(trb->size);
> > > > > =A0=A0=A0=A0=A0 if (status =3D=3D DWC3_TRBSTS_SETUP_PENDING) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dwc->dev, "Setup Pending rece=
ived");
> > > > > -
> > > > > -=A0=A0=A0=A0=A0=A0=A0 if (r)
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_gadget_giveback(ep0, r, -=
ECONNRESET);
> > > > > -
> > > > > +=A0=A0=A0=A0=A0=A0=A0 dwc3_gadget_giveback(ep0, r, -ECONNRESET);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > =A0=A0=A0=A0=A0 }
> > > > Please use ./scripts/get_maintainer.pl to get full CC list and
> > > > CC all relevant parties.
> > >=20
> > > Hi Marek,
> > >=20
> > > I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to
> > > populate the email addresses used.
> > It seems to be missing these people:
> >=20
> > Mattijs Korpershoek <mkorpershoek@kernel.org>
> > Neil Armstrong <neil.armstrong@linaro.org>
> > Anshul Dalal <anshuld@ti.com>
>=20
> So it looks like the default command used by b4 for the Cc: section is
> "scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins
> --norolestats --nom" which causes recent signers to not be included due to
> the '--nogit' argument.
>=20
> I have added the following to my git config file.
>=20
> [b4]
> 	send-auto-cc-cmd =3D scripts/get_maintainer.pl --nogit-fallback
> --nogit-chief-penguins --norolestats --nom
>=20
> This will mean that from now on recent signers will be added to the Cc:
> list. I hope that this is what is expected.
>=20
> I will resend this patch with the expanded Cc: list.

A while back someone submitted a .b4.conf (or .b4.config? I forget...)
patch, but at the time it wasn't setting anything non-standard I
thought. However, is the above something that can be configured there?
If so, that would be good to put in a project-wide b4 config file, and
if it's not it'd be a good feature request for upstream.

--=20
Tom

--KLroVl2vKDpB41FA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqUawAKCRAr4qD1Cr/k
CgeKAP9TOoLCp54bX6hb6egWzy4jzETk6F7ESRbVKxLtZrkdAgD/RrwpMx4V/SBE
bOqHY2bpjUU9IiBbTd4mUydgokW+eAw=
=QAUT
-----END PGP SIGNATURE-----

--KLroVl2vKDpB41FA--
