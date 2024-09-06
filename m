Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BA2E6FE41
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 18:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DCD88D10;
	Fri,  6 Sep 2024 20:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IQoNzzYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29F188D1C; Fri,  6 Sep 2024 20:43:33 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A4388CB6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 20:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a99fdf2e1aso39709585a.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725648210; x=1726253010; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dm/8yfGphpxvFcspT2LbK9Vsuwm2/WNxAgp03kRAKl0=;
 b=IQoNzzYsMDBJ7js+H4U4SI+OZCinB6qp2PMTNrVPO5sNlSAfYFWvLZvRSm2OzRsChM
 CLGfOT7jM7gzIhKRyGNbphUk9PBv4IoCaNuR2TdFcZ+/GpQ6It0akxJssy0vPNrPzRa0
 pP2gDCmJyYWtAZOExM8TVatJTRSa4hbThhL+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725648210; x=1726253010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dm/8yfGphpxvFcspT2LbK9Vsuwm2/WNxAgp03kRAKl0=;
 b=sZwUaJYG0qYRSdvGDObaLlFU3C4uQTqeMOA2naZ+rPgGwB2GqVgHTKDhDz0v0fw+mL
 BY9kLQn/Cfa+boqaIxm6uDfx7udGHfAGBM6nysU2VdKZ1WJA354TjexWXTsiptqidOOH
 bENQsH2iqnQykDNFco4yuBbAh2GQiGmmliUvSFCL4/XOjvytVPHzIcaz2fPOg85HIMAE
 JK0SKU2NO5FAkZtk8vTkVRSUelYBJGFH3QRdIq5tAGEtV4COMdIm3nY/xZDRXpnaI7SI
 zLuAkBqWRZxRChVfPNIyKf1gzBx0crjjkrIDwp0mSEWYSkbl3AzMBUury1LTXOMcGmFW
 Dbsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXemjURrEexynDVOwSI/ozCcaovDlCrZqYRGtKVgMP+faUVRq3ctdPtqP38ZQx0w4AYhVB1iE=@lists.denx.de
X-Gm-Message-State: AOJu0YxFvk1KT41+mPn+YtkgFP/2eV6KdNAjaN6l98WXN0BAAb017lNA
 zM8A2grO9J+3cXu4A9o+rfjNAWM8C8ofw6DsYHbjuFoxH7Oipw7M0KmLWV0ZDjg=
X-Google-Smtp-Source: AGHT+IH18Rz0FxpwDBELdVGtzsHMDWz014yy6cUqCY94uMm7wYDgjkGckOlfey1O5EH9jipaZr+s3Q==
X-Received: by 2002:a05:620a:4624:b0:79f:b8f:e1d5 with SMTP id
 af79cd13be357-7a997343227mr381796085a.34.1725648210300; 
 Fri, 06 Sep 2024 11:43:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef4d056sm194025085a.65.2024.09.06.11.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:43:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:43:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
Message-ID: <20240906184327.GH3879073@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
 <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
 <20240830142620.GS2479150@bill-the-cat>
 <CAFLszTjZmKKQSVTU5rhH_xX-neP1ZWByX96xUNxc-JTOY8R2yA@mail.gmail.com>
 <20240903184805.GK2479150@bill-the-cat>
 <CAFLszTh2kuoxEUuHUkoWY_Yykc8N1gOE+Gc_-15jKreHyYmWtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="viZfm7fJ7pcZhjbN"
Content-Disposition: inline
In-Reply-To: <CAFLszTh2kuoxEUuHUkoWY_Yykc8N1gOE+Gc_-15jKreHyYmWtw@mail.gmail.com>
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


--viZfm7fJ7pcZhjbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 06:50:20PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 3 Sept 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 01, 2024 at 02:09:58PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 30 Aug 2024 at 08:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > > > > > Hi Neil,
> > > > > > >
> > > > > > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wro=
te:
> > > > > > > >
> > > > > > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > > > > > Send the Labgrid quit characters to ask it to exit gracef=
ully. This
> > > > > > > > > typically allows it to power off the board being used.
> > > > > > > >
> > > > > > > > Sending those characters every time could collide with othe=
r CI systems,
> > > > > > > > I don't think it's a good idea.
> > > > > > >
> > > > > > > What systems are you thinking about and what sort of collisio=
n would occur?
> > > > > > >
> > > > > > > What do you suggest instead?
> > > > > >
> > > > > > Why do we need this at all? Did I miss where we send picocom the
> > > > > > disconnect nicely key-combination?
> > > > >
> > > > > When labgrid gets a signal, it exits. It doesn't continue its
> > > > > co-routines and execute the end strategy to power things off, etc=
=2E I
> > > > > suspect it could be made to do that, but I already have 62 Labgrid
> > > > > patches, so I thought this would be expedient...
> > > > >
> > > > > I can make this conditional on the new USE_LABGRID variable.
> > > >
> > > > It sounds to me like we need to make generic improvements to our ho=
oks
> > > > then, if there's not a "now call poweroff" hook.
> > >
> > > The thing is, Labgrid has its own internal console, which allows me to
> > > see all the output from reset. If I use picocom or some other program
> > > then some of the output is gone by the time I connect, particularly
> > > when using USB download. Because of that, just killing Labgrid, which
> > > is what pytest does, is a pretty heavy hammer and leaves things in an
> > > unknown state. So I added this method to give it a software signal.
> >
> > OK, but we shouldn't care? You can have the console available to pytest
> > and a terminal at the same time, with labgrid. If you need to see before
> > pytest grabs it, have the terminal be the first console, not pytest?
>=20
> I'm a bit lost at this point...'labgrid-client console' creates a
> console connection and it keeps running until killed, with that
> console connection connected between its stdin/stdout. Then pytest
> uses that.
>=20
> There is only one console.
>=20
> I care because missing output makes it impossible to see what went
> wrong, if something went wrong.

There's not one console, is what I'm saying. You can connect to the
console via a terminal while pytest is running from another terminal. So
if you have a problem and it's in that window where we're just starting
up, grab the console for you first and then let pytest go second.
=20
> > This gets back again I think to your specific way of making use of
> > labgrid contrasting with just generally supporting labgrid with however
> > another physical lab has set it up. Does killing one connection really
> > reset all of them? Or was it just a conflict with your
> > auto-acquire/release?
>=20
> Are you talking about the Labgrid exporter, perhaps? This patch is for
> the client and we have one client process running for each board we
> connect to. You can see that in the Labgrid version of the
> u-boot-test-console script which basically runs labgrid-client and
> let's it do the talking.

It's about the assumptions that are true for your lab (and possibly
others) that aren't true for my lab (and possibly others).

--=20
Tom

--viZfm7fJ7pcZhjbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbTU4ACgkQFHw5/5Y0
tyz4oAv+LYulsxanJnxJEUY26VwIEnTcY14K2QyhOo6mVVZnbHRYgcUlaLgb3JXV
z1t2CidgXohDLbZW0ihNAa4zmWf6qb+JNrxwLzKEE20R4w1uMAZMXFkRZtyXURNu
vWqbTco3QOo24iurj/qPrvlr+Awr0V+ARH+HBlk6VA80AtedhqU6rcSgTCyoiZrv
EtDs6M+BxAenVUcxIiL9wTHZR3j/ghlr6eX1GlJgvVk3D4S64WLFnXuUpJRa8bc5
4ESVdtpbm2KjQp9wxPF4Aw2ObD7hk7LNUyuu7rnKIdC5MJg1QgEZYcMoY6fhpg7Z
gPIXQyqqEDJySH08/ewTC1SOi+Z+um8ZbM0KgHN56SjHqIJFkdSg+BaNVKPB3cXf
QVoDygisjMBcgq7aKFswnC/7yTZVCm7GPDPCqpr9cgtnYMqbLivPUJroraHyBiQJ
e1pGCYvRruUC/Bt8y+LMReComx3C0FJqTlemZIPk4Ibw7W9zk3ljO0brnRIIkC6k
MO1c7yZj
=qDZe
-----END PGP SIGNATURE-----

--viZfm7fJ7pcZhjbN--
