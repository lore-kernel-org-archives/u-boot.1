Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262B109448A
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 17:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1232B84011;
	Sat, 21 Mar 2026 18:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SaYnNquc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2799D84013; Sat, 21 Mar 2026 18:35:00 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FA784008
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 18:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d55b97f358so1921820a34.3
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774114496; x=1774719296; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RRo//9uYS2ynEO1bVoa7pF2ucwUNOhZlSt0MwV+/HII=;
 b=SaYnNqucqJdT8rV2PSrp1yfgG/X+p2Qth/6WuRQL4jjAOaxKICYSnizqH9wkuGqYiR
 F+Pq0N+qb3dplOUsUtLf4YaIeJ6lvtL/r6c8xVJt9StJqT3sXKOihq1okTths+CNQXtA
 AcKAv3u8SAeyNC5aqwxHa1LUYgFvwBo4eKFlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774114496; x=1774719296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRo//9uYS2ynEO1bVoa7pF2ucwUNOhZlSt0MwV+/HII=;
 b=hATe9NDVMJ941g4Z1FD5y3pcAO7pOitBSCeo2YPyng9E6e0znUGvfkMpKVP4sIRZUi
 a1xPukVqL+iC0MM2JrqOVYffg1P0Sywkt/4I2YXIEi9cqMj2d+W3PQu+UfXUwXiCKmRm
 8ZyOnYu7ZAOpMZcAqmYiCNSF3zQ6izHiYxWRcKGyJVa1MNaZsFDo2uuB67zix39x9lvi
 Mb1WFSz0p2wo+Ls2sKIpTKDhXN9vitew4PnssVIfEbc7ITORcH1eKKYq31DNwzDtEikO
 GqVj+j44XHd96V3aMdyrmsaPtTWGveBZ3YCweTHzDzOb8y3ej31wHK82floUpCp/9RBC
 ezFA==
X-Gm-Message-State: AOJu0YwBeFuiZY17jb2AscPetjt8fBnq9dCZjh8AM7TZXhOnsFNkoHc5
 rM+dGDNcrFkABDAGkiGDCroFOt1rrLLFka3OftoUzgPNRTOEoqqXqqHuu3du9MwRdcPwAlta8CN
 SDZLxycc=
X-Gm-Gg: ATEYQzzmJ6n64pKzW2MzD96qCHIDCM4smaWbtkZIC9b7sQbr37AqWaQCbC/UvAnbLRO
 SYGSybuaefZVcdehqzpIALnvrwx64KwgpWgytl5xEmobNmCFGyh4e0EFyBYwWmpsb07nsIqcCEJ
 Q8cY8me6Qn624YAw+sPTJZd8lhoIRvS70iRKidhopa11wLQf9Z0/O+J8iCFxdkf7UrwaoTtDk7O
 C6/dxfVpc7y/tZ3vk9CTAjbbBFaEg32yo8SVGiI2XPQZ/wt1zAdA5lC8txGQZ2CMfUNvq3bVxTi
 mEvCgIT9uyaQ22JUcmOdVRiw5dmgTEzBuJAAlqqk9TOgYsT80aTdg6S64tHHLii/oM5hDBKrpAh
 dWoarGxtqFrvQyJyMsY7UaS9HOzorVI3RF0xsS1Q5DjiFHO9WTpLc/+aTqSo7RBTNwMyzpGMHdC
 Cxn+5dfUAoU/BF0ty4RkJM9ew9u+1F6ubagtvN7rCHklvwoGS7FCEJWQfZqSS99wE5SCG4JH6uf
 nDXjOU3bgZOVutohYTSVil2HrXU7vf+Ii5OeTigYjhQQYj+
X-Received: by 2002:a05:6830:81c9:b0:7d7:de7f:1216 with SMTP id
 46e09a7af769-7d7eb05988cmr4098926a34.34.1774114496629; 
 Sat, 21 Mar 2026 10:34:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7fbee2c6dsm2715562a34.1.2026.03.21.10.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:34:55 -0700 (PDT)
Date: Sat, 21 Mar 2026 11:34:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
Message-ID: <20260321173453.GG502704@bill-the-cat>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
 <20260318012649.GG502704@bill-the-cat>
 <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
 <20260319133952.GO502704@bill-the-cat>
 <b48f3f6c-0403-4528-8de6-0b24caa810ef@mailbox.org>
 <20260320135305.GX502704@bill-the-cat>
 <03a11b96-88f4-4ca0-9705-0bfe8409ee6c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i3rwoRgGwZYZovpw"
Content-Disposition: inline
In-Reply-To: <03a11b96-88f4-4ca0-9705-0bfe8409ee6c@mailbox.org>
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


--i3rwoRgGwZYZovpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 02:53:13AM +0100, Marek Vasut wrote:
> On 3/20/26 2:53 PM, Tom Rini wrote:
>=20
> [...]
>=20
> > > @@ -371,3 +367,11 @@ config SPL_SDP_USB_DEV
> > >            so it can be used in compiled environment.
> > >=20
> > >   endif # SPL_USB_GADGET
> > > +
> > > +if USB_GADGET || SPL_USB_GADGET
> > > +
> > > +# Selected by UDC drivers that support high-speed operation.
> > > +config USB_GADGET_DUALSPEED
> > > +       bool
> > > +
> > > +endif
> > > "
> >=20
> > You don't need to guard hidden symbols.
>=20
> We also do not want to expose this Kconfig symbol unless it makes sense to
> expose it ? In fact, if the symbol is not available and someone attempts =
to
> use it in Kconfig, they would get a warning, which should provide a clue
> that they are doing something wrong ?

It's a hidden symbol, so it's not exposed to the user. The problem is
that today someone is getting it wrong as you suggest but it's hard to
trigger a warning over it. That said, your patch also fixes the problem,
so:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i3rwoRgGwZYZovpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab7WugAKCRAr4qD1Cr/k
CtuSAP4hi+OHxQawQgPruw9qvoX9iwsKpNlZtsJ+vkef5GNW1QD/U7auhOYZ9t2c
162RKx/2C0xrzSVUtj+5FatStTQR2AE=
=62ZR
-----END PGP SIGNATURE-----

--i3rwoRgGwZYZovpw--
