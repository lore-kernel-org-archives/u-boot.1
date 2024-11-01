Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2992E6F07D
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 19:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E12788FBB;
	Fri,  1 Nov 2024 20:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YuEtCPLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1EC988FC8; Fri,  1 Nov 2024 20:02:28 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F1188E2D
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 20:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b1488fde46so171980785a.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730487745; x=1731092545; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JRKs4BSHqJQWn9O5ZZK8/Tg0zN/luV4mk2Qs7sL0aRI=;
 b=YuEtCPLHjvtIql63WWTAr5kUeJlLFo4N/KPXiB6j5CQQYAH5GSO+QDBlLf2HpYgLCL
 HZKViXMrA75UeFKCMNt0q8isUNuq6LE2Bj00ECjpC7d6RFfB5yOF0RSEbW3tYDDhEn4M
 N+uSiKYcaa+CXRD+IHsP+XTcJZfYCqNSf/0po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730487745; x=1731092545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRKs4BSHqJQWn9O5ZZK8/Tg0zN/luV4mk2Qs7sL0aRI=;
 b=B5EnULZv8kzu47szswpZQrfES5NTpxnEh22yEoUFtW+JsUM8Lsk/XYwl9M//dUoM5s
 iyjTe4Zbtv884lJAEw3fkRm8KGpb6wO2k3VwyRTxq9JAngV2HHtSC/3eYxNRpZjhfPpi
 sM9J4V254134mhrlaCsXKEB7nDLUHsKtxJhHKQbfLnGXznKBeMhhR0uVRkOOcfyPfixd
 j+79d9rTfG+KYuTo2JMbUtVNJ0oCvdn5hJzdciKdEvJ513WXhk15RdXZLNTlkcNWDI4A
 J1dTy8USSHNgRa4bPYdHI77wwa1/tfMTt2WrtWOa6eonfX3JNaipei7UBBrEHdlgjyP/
 BAmw==
X-Gm-Message-State: AOJu0YzNvqKpnLUP0OXw1QnmQBJm8hkuZAhulbJbaHANG/9pdK2PKWVs
 sCYmhgCjbEb8A9z6TCWbSXfW/p5WjYRMHkEYjcqbknPs8FoMnQriDx+3dMd6N8U=
X-Google-Smtp-Source: AGHT+IEnyxkdAA5dwTZyuyxtRv+JYSF6UE6SveytlbqKwXCVYCsCYMGNFfxCFCGW4QABcf7O4q1pfg==
X-Received: by 2002:a05:620a:2410:b0:7a9:abee:992 with SMTP id
 af79cd13be357-7b193f4d8e8mr3514153285a.50.1730487744903; 
 Fri, 01 Nov 2024 12:02:24 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a10500sm195886085a.67.2024.11.01.12.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 12:02:24 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:02:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20241101190221.GS3600562@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
 <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
 <20240927025159.GR4252@bill-the-cat>
 <CAFLszThvvU8uEYSBh_F6NQViNJ+bFr6mMYzd8yrTAwOp9dhLLw@mail.gmail.com>
 <20241031182822.GA3600562@bill-the-cat>
 <CAFLszThB8urxxjBZcvO8teuu5M+eLaRBb0UHEwoRm+GVyF0CdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7GBw0fvHd0EesPSd"
Content-Disposition: inline
In-Reply-To: <CAFLszThB8urxxjBZcvO8teuu5M+eLaRBb0UHEwoRm+GVyF0CdA@mail.gmail.com>
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


--7GBw0fvHd0EesPSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:33:41PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 31 Oct 2024 at 19:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 07:03:19PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 27 Sept 2024 at 04:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Sep 26, 2024 at 11:36:00PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> =
wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > > When Labgrid is used, it can get U-Boot ready for running=
 tests. It
> > > > > > > > > prints a message when it has done so.
> > > > > > > > >
> > > > > > > > > Add logic to detect this message and accept it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > > > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > What happens is that labgrid can also be told to look for a=
nd then
> > > > > > > > interrupt autoboot, just like our pytests can do, and the s=
ystem is at
> > > > > > > > the prompt. But this is also what it's like for a system wi=
th autoboot
> > > > > > > > disabled. Do we actually need this patch to achieve the fun=
ctionality
> > > > > > > > you want? Doesn't that already just happen?
> > > > > > >
> > > > > > > The point of this patch is actually to remove code in pytest,=
 by
> > > > > > > allowing it to skip all the banner-detection stuff. It does n=
ot affect
> > > > > > > things in Labgrid, since it still needs to watch for banners,=
 etc.
> > > > > >
> > > > > > But you can't remove code from pytest, people can and will run =
the suite
> > > > > > outside of labgrid.
> > > > >
> > > > > Yes, that's right. I meant that with Labgrid the code is not used.
> > > >
> > > > OK. I still think this (and I assume the related flag to tell which=
ever
> > > > helper that was that the platform is ready to go) are too implement=
ation
> > > > specific.
> > >
> > > OK, but it does have the virtue of working properly on all the boards
> > > I have, rather than just a subset, without this patch.
> > >
> > > >
> > > > > > > Without this patch, we have to tell Labgrid's U-Boot driver t=
o do
> > > > > > > nothing, so that pytest does it. But that is not a good idea,=
 since
> > > > > > > Labgrid has a lot more info about the board than pytest has. =
For
> > > > > > > example, look at all the SPL-banner-count stuff.
> > > > > >
> > > > > > Why do you have to tell it to do nothing? The pytest suite work=
s fine,
> > > > > > today, if the board stops at the prompt automatically. To be cl=
ear, the
> > > > > > labgrid yaml file I'm using with my scripts has the information=
 to stop
> > > > > > autoboot in it and it's not causing a problem.
> > > > >
> > > > > But if it wasn't causing a problem I would not have invented this
> > > > > annoying scheme.
> > > >
> > > > Well, I honestly thought it might be a remnant from development that
> > > > wasn't needed once everything else was done. I do that from time to=
 time
> > > > myself.
> > >
> > > OK.
> > >
> > > >
> > > > > For several boards, by the time pytest gets to see
> > > > > the output it is too late to press a key and stop.
> > > >
> > > > Why / how? Do we perhaps need to adjust the timeout upwards, slight=
ly?
> > > > Especially in light of the changes you also did to detect a "dead" =
board
> > > > and so we don't wait 30 minutes for a test run to fail.
> > >
> > > Why / how - because the board prints its SPL banner as soon as reset
> > > is released, then waits for U-Boot proper to be sent, at which case
> > > the U-Boot banner is sent .Then labgrid disconnects from the console
> > > and runs microcom, which connects to the console over ser2net and
> > > misses some of what has already been sent.
> > >
> > > This is actually a fundamental problem, not something we can adjust
> > > with timeouts.
> >
> > Wait, what? *Labgrid* is the thing that's the problem here with dropping
> > the connection to the board and re-establishing it at some point?
>=20
> Er, yes. Somehow I must have forgotten to mention that.
>=20
> I actually have a change proposed to Labgrid to adjust that, but it
> might take a while...in any case my change is just an option, not the
> default.

Can you please link to that specific one? Thanks.

[snip]
> > Well, I hate to get on a tangent here, but I think a common thread is
> > that after you've spent hours debugging a problem and working out a
> > solution you then omit much of the details. I'd much rather see a much
> > longer commit message here describing the problem, or a longer
> > description under the "---" where you explain that labgrid uses minicom,
> > gets things up, drops the connection and uses ser2net and so there's a
> > chance we miss messages and so need something like this. Or, that you've
> > been debugging on *x86_64* a bunch of EFI_LOADER things and off the
> > shelf distributions aren't working (and ExitBootServices() is where you
> > had a problem with Ubuntu I gather still on x86_64).
>=20
> Sure, I will try to be more descriptive in future.
>=20
> The problem in some cases is that I write the commits much later
> (weeks, months) and forget what they were for. It actually took quite
> a long time to get my lab running with Labgrid and for some of my
> responses I had to go and try things to figure out what on earth the
> change was for...some of them I dropped. I should have dug more into
> this one to really clarify the problem.

A thing I learned this year at some point was that you can pass -m to
git commit multiple times and get multiple paragraphs. It won't be line
wrapped correctly however. But it helps make "commit early and often" be
more like "commit early and often with whatever you were thinking"
easier to dump more information in to. I think something like that might
help with review on your patches, which I know is a problem we all want
to get resolved in a positive manner.

--=20
Tom

--7GBw0fvHd0EesPSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclJbkACgkQFHw5/5Y0
tyz/mwv8CfV9tGV+WyltAP+5a2zX4papkkUBk2rxx/vM6poX3o/WJs76NxXJpaaJ
uMnTHjIm9BOXu8fjVVB5fqw2+DIgdnBeeMe4hPanM4Lx6u/pRoUTx42fmy+PNhlM
+hRyxV23e9hMA9B0jzAmEMbL8NW/K8SH5/0yfzPVA7ybFhyd3vRzq6YeSYF9cYqv
A8/JmTBFU5RIQ5pbCBE8hBy0i8PnFD9u6T5/xYOFDaltRKmATTMUNMGlY03fSUpG
vOs8Ru73yK3NocZAsIBG3KCyR2ENaSsUZvZXS62WqjM20YvrDmzTVnsplmVTeXPz
7DH1lyfySnor3U85RK+7XRkQV5/da3bsVMP7pjDqU/EwrLh6elZxPnXsP+f2jUar
/Kxhe9hWa8BoEFLvFeTVqEXoWtdbqWYqR6ej9p7qFdqzJBP+00O9iA+MDZZMFi1z
ou0TTx3sCP1xKt4ynIzNjgydylTsiFj8OawuDE4CihzVj43CElow3rLHI7EzPdAu
M6t7vLBf
=4Tnq
-----END PGP SIGNATURE-----

--7GBw0fvHd0EesPSd--
