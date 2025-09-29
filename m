Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA34DCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DEA8341C;
	Mon, 29 Sep 2025 18:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bvC4wrLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D760A832DA; Mon, 29 Sep 2025 18:04:59 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496D782A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-647588475c6so465749eaf.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759161896; x=1759766696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E6/rvRc+y2+Xy4KMY9sbcQxVrjHi+70Xch0WsUjzRtY=;
 b=bvC4wrLkGSn4rX495mdRrk0a6IplByjwqX/SOXJn/JP/G+s3L22UFvsgDHBMluAAht
 oxWA9gxg1wEau+lolUhqLMy9D7EbvqRKmVJLz1AvIfxIh9hJ3jbSW3QR9xRPq4tUdpAb
 YA5boS897BN7meP0xBFWHn0FA376cflMOmi7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161896; x=1759766696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6/rvRc+y2+Xy4KMY9sbcQxVrjHi+70Xch0WsUjzRtY=;
 b=W8lT1MFn4UJwXxmj0z4bys9KZI0srwNzR9b7OjFHMCGe17/zG523e/UAk9GqAI55cy
 4DMpT5HgP+FKOh+6dOyL9Z4BD5Mt/UB+V12AGidh6gdhDr26ukOczqN/Wy836Akr3O2L
 cmVjBnIn7lu8Un2773j4WxsAZFgsMjh63c7xDWqe/fZOfrBOiCSZdRoW3H5r/ctCOO0P
 GJqZB57QpxVwZWF7F2FY+xRrHAJ/7V1m1dFDrmwFueUJoYluHzLsfeDd0/lP/7DZrCGl
 3z1CyjdVreVBjfqeG8H1SPiFMOksslaoqgPS4QK2dl9JxdBA05OZT9EyhHqEYXnYqRWI
 QkwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfhlm1ZOfoedr3A12f2gpwzb26UJti5rMOq+BQXoj28fzoV7jGyiMrVYqajiKf7LmgJidFodM=@lists.denx.de
X-Gm-Message-State: AOJu0YyNCJJ3TutQDJqz1jq3jZcYKHDxlFCT3I+vLfrou/1+OdlGFIAf
 f6Dr3UHWl3u4CgmkIXpKpf8Gg+UGZa6gQ4rrjiwsNzorwP20f676Th8KhCui1orA+Qo=
X-Gm-Gg: ASbGncvB4tpUX2eD6EQP+xgfPPo3IjUGsSHnwQudlhqxwiscTf/QfVXVRuyFmeJFsFj
 pzkimpWo43nW40lsfCA1zsoWxiGSzg233s2OaJq4/rDT8YcPib40chm4d8Z0YpWww1emUYw2mxb
 wn+3puwUjdV1lRMhemQ6veC4LIfkz/mVYAQL/jF7fDjInjdwT38GkU2JqpfPNtwgF04GMVBQMB+
 RfIlnvsOz74kW62Pko0gQvVCvPxUSGgM/NIdTCzVE867W5ZgyOlz3Jm4oFLwm/5bMDiZFc9l0TS
 78ULJx0edunV7bsGdJltLU4qyqTGd0Mc50XMRLwxIFguwMmpMpAanlhABqkA2NybIdSJRRHymuk
 7esORtNwTNXcEm57JRZbz2SXhLRBLeIAapXDd8xuQ0dd72ERVtlURrzyt
X-Google-Smtp-Source: AGHT+IH5nJobQZAfAJfeiGsddBhkZCF9g4OgLQ1iPG1OzWHBrfKlV19VFq0kQek6LKU6OHN4k3KG1w==
X-Received: by 2002:a05:6820:2d8a:b0:642:2bb7:4c0b with SMTP id
 006d021491bc7-648e2131013mr444512eaf.0.1759161895942; 
 Mon, 29 Sep 2025 09:04:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a241ad75desm2678503a34.38.2025.09.29.09.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:04:55 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:04:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
Message-ID: <20250929160453.GI6093@bill-the-cat>
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
 <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
 <20250929141507.GE6093@bill-the-cat>
 <d1579ba6-35f5-4dfb-b7d7-f6073bd92996@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iuYt09mafiva2oz7"
Content-Disposition: inline
In-Reply-To: <d1579ba6-35f5-4dfb-b7d7-f6073bd92996@linaro.org>
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


--iuYt09mafiva2oz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 04:09:04PM +0100, Andrew Goodbody wrote:
> On 29/09/2025 15:15, Tom Rini wrote:
> > On Mon, Sep 29, 2025 at 10:09:09AM +0100, Andrew Goodbody wrote:
> > > On 25/09/2025 15:12, Marek Vasut wrote:
> > > > On 9/25/25 4:07 PM, Andrew Goodbody wrote:
> > > > > On 25/09/2025 14:56, Marek Vasut wrote:
> > > > > > On 9/25/25 3:20 PM, Andrew Goodbody wrote:
> > > > > > > In dwc3_ep0_complete_data there is a test for 'r' being null =
and the
> > > > > > > code will return at that point if so. After that point 'r'
> > > > > > > is guaranteed
> > > > > > > to not be null and testing for that is redundant. Remove the =
test for
> > > > > > > 'r' being non-null.
> > > > > > >=20
> > > > > > > This issue was found by Smatch.
> > > > > > >=20
> > > > > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > > > ---
> > > > > > >  =A0 drivers/usb/dwc3/ep0.c | 5 +----
> > > > > > >  =A0 1 file changed, 1 insertion(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> > > > > > > index c656cbe25ce..680756532f0 100644
> > > > > > > --- a/drivers/usb/dwc3/ep0.c
> > > > > > > +++ b/drivers/usb/dwc3/ep0.c
> > > > > > > @@ -799,10 +799,7 @@ static void
> > > > > > > dwc3_ep0_complete_data(struct dwc3 *dwc,
> > > > > > >  =A0=A0=A0=A0=A0 status =3D DWC3_TRB_SIZE_TRBSTS(trb->size);
> > > > > > >  =A0=A0=A0=A0=A0 if (status =3D=3D DWC3_TRBSTS_SETUP_PENDING)=
 {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dwc->dev, "Setup Pending=
 received");
> > > > > > > -
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 if (r)
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_gadget_giveback(ep0, =
r, -ECONNRESET);
> > > > > > > -
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dwc3_gadget_giveback(ep0, r, -ECONNRES=
ET);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > > > > > >  =A0=A0=A0=A0=A0 }
> > > > > > Please use ./scripts/get_maintainer.pl to get full CC list and
> > > > > > CC all relevant parties.
> > > > >=20
> > > > > Hi Marek,
> > > > >=20
> > > > > I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to
> > > > > populate the email addresses used.
> > > > It seems to be missing these people:
> > > >=20
> > > > Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > > Neil Armstrong <neil.armstrong@linaro.org>
> > > > Anshul Dalal <anshuld@ti.com>
> > >=20
> > > So it looks like the default command used by b4 for the Cc: section is
> > > "scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-pen=
guins
> > > --norolestats --nom" which causes recent signers to not be included d=
ue to
> > > the '--nogit' argument.
> > >=20
> > > I have added the following to my git config file.
> > >=20
> > > [b4]
> > > 	send-auto-cc-cmd =3D scripts/get_maintainer.pl --nogit-fallback
> > > --nogit-chief-penguins --norolestats --nom
> > >=20
> > > This will mean that from now on recent signers will be added to the C=
c:
> > > list. I hope that this is what is expected.
> > >=20
> > > I will resend this patch with the expanded Cc: list.
> >=20
> > A while back someone submitted a .b4.conf (or .b4.config? I forget...)
> > patch, but at the time it wasn't setting anything non-standard I
> > thought. However, is the above something that can be configured there?
> > If so, that would be good to put in a project-wide b4 config file, and
> > if it's not it'd be a good feature request for upstream.
>=20
> [1] which also incidentally dropped the --nogit along with some other
> arguments without mentioning that in the summary.
>=20
> Yes this could be done in the same way. Do you want to take that old patch
> or should I do a new one?
>=20
> Andrew
>=20
> 1 - http://patchwork.ozlabs.org/project/uboot/patch/20240717-b4-config-v1=
-1-0bc9e80ef582@flygoat.com/

Oh, yes, now that I understand things better, indeed, that patch should
do what we want (and if people wish get_maintainers.pl was more verbose,
we have a conf for that already). I'll follow-up to that patch and apply
it. Thanks!

--=20
Tom

--iuYt09mafiva2oz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNquJAAKCRAr4qD1Cr/k
Cvt9AQDJCI8NKmLzH44jCf4kqxR76uwNa+Eql9gilz5pLb3qDwD/dMrM8LSB3xPb
JKtObCE0Xsh+vVgrGvfPOE9D6X/YtQE=
=dA8C
-----END PGP SIGNATURE-----

--iuYt09mafiva2oz7--
