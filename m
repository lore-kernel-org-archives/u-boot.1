Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4735C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 16:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25A78813A;
	Thu, 20 Jun 2024 18:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ojk1die9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9288834D; Thu, 20 Jun 2024 18:55:18 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B8088126
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 18:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-259884ef4ddso558575fac.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718902515; x=1719507315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ6A/ZpkKNL4KWpLxnbRSZTpxXceYHWpA4P0MHHVN0I=;
 b=Ojk1die975BEtmlt1uTWceFP6AS/G/e0U+KpGGn/7UU8pq06H8LgXYzsaCLGYDDW08
 +H8APoIOyFmCGzsDM5AWp5+YFI88Yq5Mxuo4DNLSxDLanbkmLgi6+O5Uk4xyA8DElmCx
 OVifskyw/4fIuWWrFSR9NOv5cBqgK9zJA3DAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718902515; x=1719507315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ6A/ZpkKNL4KWpLxnbRSZTpxXceYHWpA4P0MHHVN0I=;
 b=OMmrfOhmoSNhdqEwhOuzeETZXjnnZvd17elbjbjrQ7GAMIaQpSNiH/y05V1reZWLdP
 VCWPJjz61wESmuJ5X0olj7XUwUe+S++07idRYzdW/HHQevMQ4lsKmfabWdtd9fQRgqJ3
 ofOesdjMahNImYN+GWZ++PjVyIaZc6eay22ADuWXom7w+3tkrxYAdLCaEidra+8L0Kyc
 jEr/L8Wa/J/3VHuYmuuQuv4KYUemoLpVqTTn+lloAnwENruBLrIiUnTTLFcNdjCYbLQI
 GLHJ5+4BEHoAO3+lHjRyTL11/+M6B/SJxMgxortyroxmijr4cg9t2yiLrjKwxGD/Gv1/
 rWKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdY4f88lWiUsqPVoxsboI6uRZC3U1j5t4ZshWH8xd8XnN+h2a0PB9JDfEcrRS0Ye0vy3gFR9kSyLi2+cwJ254a6Z1P1A==
X-Gm-Message-State: AOJu0YxqyEijWGp5jTaUXrHL7l1ouDt6vUGwIlymH5d+1iMz51FbYde8
 h7jhyRe4bS9Lg/dFnLd03axsNQQ1OZa3h4+KRJsejBQR9dBf8wy1xwCtDV0ug4Y=
X-Google-Smtp-Source: AGHT+IFH0FKCAiAVbVOc4+A8puJd65W7SQSw3CTe7jcniI+TAkapMHLm/jQcf1ZRccEJy5P3j0xyYQ==
X-Received: by 2002:a05:6870:1685:b0:255:2e14:3d9d with SMTP id
 586e51a60fabf-25c948edb0dmr7107004fac.5.1718902515001; 
 Thu, 20 Jun 2024 09:55:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ca4cc858fsm857319fac.40.2024.06.20.09.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 09:55:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:55:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4 0/9] misc: introduce STATUS LED activity function
Message-ID: <20240620165511.GP68077@bill-the-cat>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
 <62bdc69d-edf8-422c-a6dd-4d50e1cdc1d1@gmx.de>
 <66740da0.050a0220.f7eae.7834@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cs0XWUPI8oVBzisn"
Content-Disposition: inline
In-Reply-To: <66740da0.050a0220.f7eae.7834@mx.google.com>
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


--cs0XWUPI8oVBzisn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 06:29:23AM +0200, Christian Marangi wrote:
> On Thu, Jun 20, 2024 at 08:34:03AM +0200, Heinrich Schuchardt wrote:
> > On 6/20/24 01:03, Christian Marangi wrote:
> > > This series expand the STATUS LED framework with a new color
> > > and a big new feature. One thing that many device need is a way
> > > to communicate to the user that the device is actually doing
> > > something.
> > >=20
> > > This is especially useful for recovery steps where an
> > > user (for example) insert an USB drive, keep a button pressed
> > > and the device autorecover.
> > >=20
> > > There is currently no way to signal the user externally that
> > > the bootloader is processing/recoverying aside from setting
> > > a LED on.
> > >=20
> > > A solid LED on is not enough and won't actually signal any
> > > kind of progress.
> > > Solution is the good old blinking LED but uboot doesn't
> > > suggest (and support) interrupts and almost all the LED
> > > are usually GPIO LED that doesn't support HW blink.
> > >=20
> > > To fix this and handle the problem of device not supporting
> > > HW blink, expand the STATUS LED framework with new API.
> > >=20
> > > We introduce a new config LED_STATUS_ACTIVITY, that similar
> > > to the RED, GREEN and others, takes the LED ID set in
> > > the LED_STATUS config and is used as the global LED for activity
> > > operations.
> > >=20
> > > We add status_led_activity_start/stop() used to turn the
> > > activity LED on and register a cyclic to make it blink.
> > > LED will continue to blink until _stop() is called.
> > >=20
> > > Function that will start some kind of action will first call
> > > _start() and then at the end will call stop().
> > > If (on the broken implementation) a _start() is called before
> > > calling a _stop(), the Cyclic is first unregister and is
> > > registered again.
> > >=20
> > > Support for this is initially added to the tftp, mtd and ubi
> > > command.
> > >=20
> > > This also contains a big fixup for the gpio_led driver that
> > > currently deviates from the Documentation and make the
> > > coloured status led feature unusable.
> > >=20
> > > (world tested with the azure pipeline)
> >=20
> > Hello Christian,
> >=20
> > What is the relationship between CONFIG_LED and CONFIG_LED_STATUS?
> > Can they be used at the same time or should they be exclusive?
> > Should CONFIG_LED_STATUS depend on CONFIG_LED?
>=20
> Well this is something that should have been fixed long time ago.
> Given the 2 cmd and some function clash with each other they are totally
> incompatible with each other and one should exclude the other.

Yes, sorry, I missed this earlier on, my fault. The CONFIG_LED_STATUS
code is legacy and indeed shouldn't be enabled on anything new (and
ideally, someone would care enough to transition the few platforms using
the old framework over). So this functionality should be added to the
drivers/led/ framework and then yes, your platforms defining the LED via
device tree, with the same compatibles the Linux needs anyhow to be able
to control it too.

--=20
Tom

--cs0XWUPI8oVBzisn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0XusACgkQFHw5/5Y0
tyydjwwAo/zOxGJ0lU6rcEmHYM177kVjRZhTVLnnoErm7GjXqP0BipaIUJpIU0E+
LhX2L9YFJoD3SJ5X4crmST9YcO44ApSIbBFhG3HZf2Ju1jXstjHrkQC7ZIqJn0aw
JM8o/XrB+fcFcoLryoA/YTv/NB9dnGuPe6LiA0FWLY2C5c4A41AEmmpIjK9duUxf
ulGUJ2zY1YM98Dh+QXhUAkvRgJ9y12McSmaj9qjp9oeoJ1oQtmnoneYcWxSg7XKk
0vSyMGdQ3y8lIkgz8vQWsdWl+Afxb/ZpY3aROVXV701/WD2cbBVYhwiHiOM06Lia
O4+eCf8CCDvhfKV3pQ+A26KdHImvLg3qISodVu5rlPXVK7h840eLuCrl1zarDdFu
lC37eP0hCRoJc11SmjFO99x8Ef22nVhgrTTq9H6y9/IBMc46CuK2WeoK4Bs02HdN
wRbauUvCaPE6cGzwYGm3ygHDswH4WPzeD1OFc4uV+d7nMvK4TDrzyI7HgZJHQF52
+QvRisQ/
=MgDN
-----END PGP SIGNATURE-----

--cs0XWUPI8oVBzisn--
