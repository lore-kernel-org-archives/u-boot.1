Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27343C36018
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 00:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52878810E8;
	Thu,  3 Apr 2025 02:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="norS54+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12E081DE3; Thu,  3 Apr 2025 02:26:50 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2F08035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 02:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5fc6cd89f85so202795eaf.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743640007; x=1744244807; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=paANgYbRnswfIwjtHjtF67SJ52sec5YAE2TSMQXrDOU=;
 b=norS54+7toBYaIjTGE8UvAXRUQb5IsUxkeFXVIoA/zd6MfmUNBuPNpAhAiE3QQc30u
 G8x4gefKkHK2DETE8T6/2JYUGYVqqhFw5586ZBpM1eemFVhWDtOVbYyL+89dda3UsDmj
 HxJIPAvKSTEzTBJ7wcreVgD+weYtch3kgZKxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743640007; x=1744244807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paANgYbRnswfIwjtHjtF67SJ52sec5YAE2TSMQXrDOU=;
 b=R99G2Ja7hwVCdjj5eBrZ/GrdgP0KbZH5rbF3FzWv/rttMXeqyYdPqPe6/l4m5ww+Hx
 GR68qD2iVNa0f+pdQdhfAzaHUuYp2ARWHj+uWYVSeV1+Zj8i9e5bG3CCP9tPhClvgi7y
 jQnRaRoqEvTdMFF8L8kzWBmCloQsoYxzNgxGhKsjKGD478bbCCiNIzCA/2VrJ/3K9rfS
 BMx4bGwytThyYaFo1f7YoUM/sH28AC22pM1wDnj+1QtBvtx/JhKNSYLSgckEfJ5VduYP
 cwa7W9ehvxyg9E3pL52UkKzcvwvO5aJfj5ktO/3JxQYfO31tb8bNvPikrk3yrcMy7psw
 UbcQ==
X-Gm-Message-State: AOJu0Yys7OKiEJHAnnF5A7i71S2YefQWqBuVm8tbm2jKo5cOdvVzxmw6
 73UlTQhLmiN4A/6TMc8z4IwE3ukpsDUl9OluhO2wtfhsEZsri6ju9uOyzUMx4CI=
X-Gm-Gg: ASbGncu0DJXNX8fVkc4W6b24ACpeuF2SmCAY2KhScQNXE2RuJzIYYGiGbSCmm+ImsCK
 Ri0kx3xc5N54lkEn9EWCv3QtNUyCWvval80gq9wtwBGpP1xJtZBAeC096xIGcNML/1GEoiTqPBB
 BsF5fxDf4jmOn5PCJlCwYkR7jVtqXwG3w4ZgJdXrR1aIfOyBZU7onN6wEHeZdGu7PWtheHAzYmU
 h7nmov/sDmwSiMmpTuAayGNAKbTfeyrpYiiu1P366SgrmdSpnTDLB8A6VkDb3duJAVRUSF0vY0h
 9M0UzGaHe7BbMV7yZ2fdkLb3T8bCNQEi4N5kODPUZ+p+RHfaweb9FxhbxzDtG0FtOH2ujmgc3NR
 YbTrwdA==
X-Google-Smtp-Source: AGHT+IFfLXPHAYJ6Bq2r65fRnFmrlIKRNxgmUlQeyD15GExG4axk7zR+IJfHIoRzZsEnKcW4JCn7pA==
X-Received: by 2002:a05:6870:b149:b0:2c2:561c:47e3 with SMTP id
 586e51a60fabf-2cbcf56480emr10847262fac.21.1743640006944; 
 Wed, 02 Apr 2025 17:26:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc84bc0455sm41041fac.41.2025.04.02.17.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 17:26:46 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:26:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: Re: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
Message-ID: <20250403002643.GG5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-41-sjg@chromium.org>
 <20250402142858.GT5495@bill-the-cat>
 <CAFLszTiCgq6XqK7mVY9YWD6bjod3bWPtp_s2k7_WVgn8gVf5QQ@mail.gmail.com>
 <20250402195033.GB5495@bill-the-cat>
 <20250402195656.GC5495@bill-the-cat>
 <CAFLszTjPi5=ro_4n8oF+ZX_OtzvKxWZvz=ipmXCnEhysVZb9-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HK7QLWroS+jAx2sz"
Content-Disposition: inline
In-Reply-To: <CAFLszTjPi5=ro_4n8oF+ZX_OtzvKxWZvz=ipmXCnEhysVZb9-w@mail.gmail.com>
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


--HK7QLWroS+jAx2sz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 12:54:42PM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 02, 2025 at 01:50:33PM -0600, Tom Rini wrote:
> > > On Thu, Apr 03, 2025 at 08:22:44AM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 3 Apr 2025 at 03:29, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Mar 15, 2025 at 02:26:00PM +0000, Simon Glass wrote:
> > > > > > Update the string to take account of UARTs which are connected =
on I/O
> > > > > > ports, as on x86.
> > > > > >
> > > > > > Fix a typo in an error message in the same command, while we ar=
e here.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v3)
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Add new patch to support IO UARTs for earlycon and console
> > > > > >
> > > > > >  boot/bootflow.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > > index 58a1afa7a75..4054a966af8 100644
> > > > > > --- a/boot/bootflow.c
> > > > > > +++ b/boot/bootflow.c
> > > > > > @@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *=
bflow, const char *arg)
> > > > > >       *buf =3D '\0';
> > > > > >       if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_C=
HIP_16550_COMPATIBLE) {
> > > > > >               snprintf(buf, sizeof(buf),
> > > > > > -                      "uart8250,mmio32,%#lx,%dn8", info.addr,
> > > > > > -                      info.baudrate);
> > > > > > +                      "uart8250,%s,%#lx,%dn8",
> > > > > > +                      info.addr_space =3D=3D SERIAL_ADDRESS_SP=
ACE_IO ? "io" :
> > > > > > +                      "mmio", info.addr, info.baudrate);
> > > > > >       } else if (!strcmp("earlycon", arg) && info.type =3D=3D S=
ERIAL_CHIP_PL01X) {
> > > > > >               snprintf(buf, sizeof(buf),
> > > > > >                        "pl011,mmio32,%#lx,%dn8", info.addr,
> > > > >
> > > > > I suppose we're well past the point where we can delete
> > > > > bootflow_cmdline_auto() itself because that's just going to lead =
us to
> > > > > trouble down the line (5 years from now when the kernel adopts a =
new
> > > > > preferred way to pass this info) and grows every platform by some=
 amount
> > > > > of space every time we add something new here.
> > > >
> > > > Well firstly, why would you want to delete this command? It is very
> > > > useful to be able to change the cmdline.
> > > >
> > > > This command is only available with BOOTSTD_FULL, which is less than
> > > > 10% of boards.
> > >
> > > Because it's automatic non-obvious stuff. We should not be modifying =
the
> > > command line at all. Is it even documented that we're doing this?
>=20
> Yes, the command is documented. It only happens when you run the
> command. Otherwise the command line is not modified.
>=20
> As you know U-Boot has bootargs but that doesn't work with extlinux
> and the like, so we have this command, which does.
>=20
> >
> > To be clearer, the more I review your changes, the more I see a blurred
> > line that I do not this is good between "I found this handy while
> > doing something" and "This is a good generic design / feature".
> >
> > That it can be annoying at times to add the debug uart information is
> > not a new unique problem. It's something that's generally normally
> > solved. I assume you hit this on x86 where it's more annoying than most.
> > But a generic feature it should not have been.
>=20
> I'm not even sure why you wrote this email, then.

Because this is another little thing I'm being flexible on and not
naking, I just think it's wrong-headed. And you seem to think I'm never
being flexible. So I started this by saying I'm not naking it, I just
think it's wrong.

> U-Boot has all the information needed to set up the UART correctly and
> it is extremely tedious to do otherwise. This is a bootloader, so it
> needs to support kernel development. I actually think this is a really
> cool feature.

It's "cool" until it breaks. And grows platforms for features they
can't/won't support.

--=20
Tom

--HK7QLWroS+jAx2sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmft1cAACgkQFHw5/5Y0
tyzxXAv/e6roEhAO89PKC81vN4D3ZeMunyAribqSB+/Tll3XEx8xTJAEA38nv4Vp
HtX0HqMEtVKu2ZWX1hq6bixahUH7ZhCHL43cXeGYUukfPjllF2HlMGYmOXyiYDzx
PEEY+eQ8Ixkh+nhq5NYX9D1XqogzSufDAIpMvc0rdKewvpiYgxanySuNhi0YAeDe
rwJ0vpqDbVi4Mz2xrC8EhzVa1H0gebT4SPqd7083iBUHzxpL3lS6z0cpqUSd4eOU
xG4dp4BUh8mf/lOltUL1+LLrL/PC0sGjbl7Lh2fO474T3E0B8NBKdc8nzEq0wupS
mGcYOVT8NBfGpUeGt/QuAugxI43vxM2umLrcZ0MSOwYuZvvhIvUDM7KjdZ9CXNBS
3nIldSTW8TZ0xv2IjOthJLkybeuacO8m1HKkzLPUYcXBK2QMsEpolBjGbUX9khBq
gudxGxNpiQQLvMXOLeU3/J0xHd35rm90lcPiRIpyYP92w8p1nsypFO6s3qvuoJNd
8Cg/fOs/
=8Tce
-----END PGP SIGNATURE-----

--HK7QLWroS+jAx2sz--
