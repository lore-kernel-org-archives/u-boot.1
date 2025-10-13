Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6F9CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEED83695;
	Mon, 13 Oct 2025 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IziwDm73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E214835FD; Mon, 13 Oct 2025 16:15:51 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29021836D2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a7d79839b2so3553227a34.3
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760364948; x=1760969748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1yQzxRdZCXbGVGBdpbCFQrZIBYPGKTj5uaL6jqkDdI=;
 b=IziwDm73zi6f4pS1wZrd2js6IWEhC3JM5hlupD3jtCYSD0ngDlhgb5FdW1g38anxbG
 E2El6AqnfdmmdlxG7uJyrFEc0KzhCy6+Doik9rgEEwO50qDMt5moTWcZVt2nAPyZm+15
 kP48vClPv1LivX8Z44CEXjDDWbKrdUFJeDtQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760364948; x=1760969748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1yQzxRdZCXbGVGBdpbCFQrZIBYPGKTj5uaL6jqkDdI=;
 b=vpgNTPqlJN4exaOP2LA/XGxwWluNlIjP7pYTrOY0Nju6SiT8r0k4EVdDWUaUYYgOiS
 KJh4xGABe+dJdv87XqbqRIFZeWqInAEp/9uOc3XO2bzPtZvS/tnSq7/7PK+RwLCtqCPq
 n8y5luOaILDP3pAKb80aYVpYFaH9XlTRuNT/vB+/RxIYC7WgguZiDc5VYgyupcCPEKiz
 ONbpHlajZazaS00kwHqjr6GvE4GaKCiF8S8YlRmE0lPNX1qrkjxri25LK6RyQIYMPp0c
 Bzkt6NMy2faukCBh0OL8HJdF+QR0tAZEfLTcKDL2SiHjfgihusXEyfqL9U9rnEitX8Aj
 Ad1w==
X-Gm-Message-State: AOJu0YxGBfxtZUQh+ja2ebLyaFpL9EJ+v0xt0TkWfh/tv3Bxei1mOsz3
 Ob+7kjga4Bx8cvVvS4m28g9XjYrlW7rv5Ge9SMhU7D8iecysjKzJZX3hwd6r9zJemIg=
X-Gm-Gg: ASbGncsdUZXd5qM7chAYHe3UaPwums9JOVt6G1xuwirDlpcjuu8WgJCt/W9D6E0QYZI
 nt8zrtxsMd55SQjjZwm9vdNeCDUoxcZdD4jopvgwvKcRdjdPV66MKPgc2XLal/Xhe/FFsS9lEEC
 BAKTznf0Qr1kpkjDWtx99nXfFpeHaLcVMtQgIaCYDMfHv+TL6GgtOxPY50uiz2/I5U+stJrOr9i
 VeXbEogowSRqNsiBdKMq8EvPmxo4PoEEunmEKQsnM8tqga6fGW4vTfQ7mz4ntORq1g6NQxyTKWE
 HBjuhA2iZeglzGQ3lI+CU0hmua1K2Gl2XuxQUPbkFNxwekXJNjtirPxbUOqcqnkhuyk66fBxSfW
 q+RYrIZuk/KAVtFtHu/wNKmWa58ogMnLI9A+Ga/eWWukd2pSfUttoiBdUAhVT9RuvQ6QRG7MnX7
 gB/gIEvj/AZdCopOc=
X-Google-Smtp-Source: AGHT+IFY8YVXlvicfmYHRddyiNQVrv/c4CV76cbi2qA96NhuQJUcE5FUtd9PMBUCSesLtTn7vF8ntw==
X-Received: by 2002:a05:6830:270b:b0:7bc:f443:fa3c with SMTP id
 46e09a7af769-7c0df7f3a9cmr10187879a34.25.1760364947631; 
 Mon, 13 Oct 2025 07:15:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90688cdsm3527107a34.16.2025.10.13.07.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:15:46 -0700 (PDT)
Date: Mon, 13 Oct 2025 08:15:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
Message-ID: <20251013141544.GD6113@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
 <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
 <20251010143528.GZ298503@bill-the-cat>
 <CAFLszTh+K2Yr0OtZ_cNk9YrrGxg3KAv2SEppK=a-g1sw=hncLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qYXFr3kJUYKplkR5"
Content-Disposition: inline
In-Reply-To: <CAFLszTh+K2Yr0OtZ_cNk9YrrGxg3KAv2SEppK=a-g1sw=hncLg@mail.gmail.com>
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


--qYXFr3kJUYKplkR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 08:19:53AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Oct 2025 at 15:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 11:36:10AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
> > > >
> > > > > This function is the core of the bootstd iteration. Add some debu=
gging
> > > > > for the decisions it makes along the way, to make it easier to tr=
ack
> > > > > what is going on.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  boot/bootflow.c | 23 +++++++++++++++++++----
> > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > index 78df09f369d..de69e27bec7 100644
> > > > > --- a/boot/bootflow.c
> > > > > +++ b/boot/bootflow.c
> > > > > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *i=
ter)
> > > > >       log_debug("entry: err=3D%d\n", iter->err);
> > > > >       global =3D iter->doing_global;
> > > > >
> > > > > -     if (iter->err =3D=3D BF_NO_MORE_DEVICES)
> > > > > +     if (iter->err =3D=3D BF_NO_MORE_DEVICES) {
> > > > > +             log_debug("-> err: no more devices1\n");
> > > > >               return BF_NO_MORE_DEVICES;
> > > > > +     }
> > > >
> > > > Thinking more about what I said in the previous iteration about git
> > > > blame history, ones like this should be log_msg_ret (the history on
> > > > "when did the test for =3D=3D BF_NO_MORE_DEVICES come from is uncha=
nged, but
> > > > now you can have debug statements when enabled).
> > >
> > > Yes we can add that as well, but I still want to have the log_debug()
> > > as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That feature
> > > produces a lot of output even in normal operation since it shows
> > > errors dealt with by higher level code. It is really only designed to
> > > find the source of a particular error when you are stuck.
> > >
> > > >
> > > > [snip]
> > > > > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *=
iter)
> > > > >
> > > > >       if (iter->err !=3D BF_NO_MORE_PARTS) {
> > > > >               /* ...select next partition  */
> > > > > -             if (++iter->part <=3D iter->max_part)
> > > > > +             if (++iter->part <=3D iter->max_part) {
> > > > > +                     log_debug("-> next partition %d max %d\n", =
iter->part,
> > > > > +                               iter->max_part);
> > > > >                       return 0;
> > > > > +             }
> > > >
> > > > Shouldn't this be a debug message instead in the caller?
> > >
> > > I am trying to log_debug() every exit from this function...so you can
> > > see the entry and then which path it took.
> > >
> > > >
> > > > [snip]
> > > > > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *i=
ter)
> > > > >       }
> > > > >
> > > > >       /* if there are no more bootdevs, give up */
> > > > > -     if (ret)
> > > > > +     if (ret) {
> > > > > +             log_debug("-> no more bootdevs\n");
> > > > >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > > > > +     }
> > > >
> > > > Then do we actually need both a log_debug and a log_msg_ret?
> > >
> > > Please see above.
> >
> > I guess my question is, but why? Is this something that's going to be
> > debugged frequently? Why doesn't every function have meaningful text
> > string log_debug messages, just in case? And then why bother with
> > log_msg_ret at all?
>=20
> I have found myself in this function quite a few times, trying to work
> out what it is up to, so I decided to add more debugging.
>=20
> Anyway, would you like to just drop this patch, or something else?

I'd like to fix the underlying problem so that we don't have a similar
discussion on your next series. As yes, I think in general all of these
patches to add more detailed logging on top of log_msg_ret logging are
too much. And I gather you're debugging these problems on real hardware
where using some source level debugger with sandbox isn't an option?

--=20
Tom

--qYXFr3kJUYKplkR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0JkAAKCRAr4qD1Cr/k
CrQJAP9/suU1m8o0U5hkcNqayajpB1kENOwgBqcXqJFkKt/JuQEA8hW3ZQ5hKSKE
GAr3/sbeAT0QuHPxWM8XdTiUukoEvAw=
=5q8T
-----END PGP SIGNATURE-----

--qYXFr3kJUYKplkR5--
