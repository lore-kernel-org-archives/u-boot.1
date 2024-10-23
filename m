Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF30CFA45D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 18:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD7C89312;
	Wed, 23 Oct 2024 20:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QYloJofn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415BD892AA; Wed, 23 Oct 2024 20:41:44 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279B1892F7
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 20:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so867836d6.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729708894; x=1730313694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7/rWXniSkvTqDHHK5MjLjv4utp3DRNQ3IzRYM8HTak=;
 b=QYloJofn6ZQ7O9Q9H+dP76cKPY2B8iWzFitEHJ6HK/R+L59Hg7wxmInl+maV1VnXdM
 Th3h4jB4K6dNmmseCGgzr4zRrJI0pIzDB7NNaNZV9KGg4syR1TcW5OomYoNu1ig0hE2N
 meLW4ybw+UEoNzqe+dawWO656AFjHqIlrQ9R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729708894; x=1730313694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7/rWXniSkvTqDHHK5MjLjv4utp3DRNQ3IzRYM8HTak=;
 b=O5IvucRcNALhk1rUGd3RhiOc4wE31C8M4zpyJq2+91K8a23r3RicPF6kfox1Bu7raQ
 1NEZ3Lq3Xu5jb7a+N/7aQv/BI1LnOgSHzfQcUQ+j+Fuz9lF3J/BKKXpwpBSbuDCqyk7L
 mRN+St0nSd89ExaY0MfqdygfWlSAJWQ0C1e0JC7advu6C2OaGtu4SMzhI7IJPUnB6P/U
 NohlygcaaJ8XHGQTMZsGhAQjG7z9ZMm2eBrjkLfawiWY79AEK00cbYXpuq3rZ70ScBbu
 QHUZH6H/uH9KO0Ln4+z0ssx20fR7xQZjn4EcXJN1NayGuPguxY9srWUhnSdBvYq1Rwu9
 n3Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlQs8vjjNXTu2/KO/4sRHxpszOW6etRxGqaIZZT67YqOnYYo34Po9gjW1tBmiF3sT1aiO0lRA=@lists.denx.de
X-Gm-Message-State: AOJu0YxTSczYmqChxvTj/D6s+s8ct36OayJFnlvIW/+J8ebxEwL4bpNG
 WYfuT+uspgW1YUlOftqheeKMba7SeJR0NyMEgYURM0H7u/vYPg5jIcSMqhYhsic=
X-Google-Smtp-Source: AGHT+IHEgt1SCb6GQ7aXjL5oxZIkOMfScDd8S3Mjp32QU0R5INz3oaKV9egw5vbjVwct94ndLPA+5A==
X-Received: by 2002:a05:6214:5710:b0:6cc:2416:c247 with SMTP id
 6a1803df08f44-6ce343049ecmr46606916d6.49.1729708893962; 
 Wed, 23 Oct 2024 11:41:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009e5407sm42230716d6.129.2024.10.23.11.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:41:33 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:41:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
Message-ID: <20241023184130.GM4959@bill-the-cat>
References: <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
 <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
 <20241018213022.GL4959@bill-the-cat>
 <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
 <20241019163025.GU4959@bill-the-cat>
 <CAFLszTjAYhGGF+dm+egcw_yixo-akmKZUNb5EWnegD0dgETeWg@mail.gmail.com>
 <20241022150125.GF4959@bill-the-cat>
 <CAFLszTjnEzUDFRBXvySiMD0bROV5JdFrNt16Q5_BHUFHyBz5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NjigEOgzbfd0XeXp"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnEzUDFRBXvySiMD0bROV5JdFrNt16Q5_BHUFHyBz5Vg@mail.gmail.com>
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


--NjigEOgzbfd0XeXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:00:44PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 22 Oct 2024 at 17:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 02:16:52PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 19 Oct 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 19, 2024 at 05:49:40AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xy=
pron.glpk@gmx.de> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Gla=
ss <sjg@chromium.org>:
> > > > > > > > > > > > >We want to keep track of images which are loaded, =
or those which could
> > > > > > > > > > > > >perhaps be loaded. This will make it easier to man=
age memory allocation,
> > > > > > > > > > > > >as well as permit removal of the EFI set_efi_bootd=
ev() hack.
> > > > > > > > > > >
> > > > > > > > > > > I'll change this 'hack' to 'feature'.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Please, keep in mind that files can be loaded manua=
lly, e.g. via the dhcp, the wget, and the loady commands. These are outside=
 bootflows.
> > > > > > > > > > >
> > > > > > > > > > > Yes, this series is only going to help if bootstd is =
used. For ad-hoc
> > > > > > > > > > > use, EFI will need to rely on the above feature, at l=
east until
> > > > > > > > > > > someone can think of another solution.
> > > > > > > > > >
> > > > > > > > > > Perhaps I need to try and be clearer here than I might =
have been in the
> > > > > > > > > > past. The consensus among off the shelf free software o=
perating systems
> > > > > > > > > > is "just give me an EFI interface". This simplifies thi=
ngs on their end
> > > > > > > > > > if regardless of architecture it's the same interface. =
This means that
> > > > > > > > > > in U-Boot we need to treat EFI as one of the primary in=
terfaces. Not a
> > > > > > > > > > novelty. Not a "some people might use". It is a frequen=
t and commonly
> > > > > > > > > > used feature.
> > > > > > > > >
> > > > > > > > > Yes, EFI is everywhere and growing. All the more reason t=
o tidy up
> > > > > > > > > this piece. I would like to see bootmgr use this new API,=
 for example.
> > > > > > > > >
> > > > > > > > > But how does this comment affect this patch?
> > > > > > > >
> > > > > > > > Because at the very high level, I wonder if I made a mistak=
e a few years
> > > > > > > > back. As I understand it, the nominal case is "bootefi boot=
mgr". I was
> > > > > > > > saying at the time that perhaps bootstd can just fire that =
off, and move
> > > > > > > > on. Now it seems like we're going along the path of re-inve=
nting that,
> > > > > > > > and not integrating well with it either.
> > > > > > >
> > > > > > > In what way are we re-inventing that? bootstd supports lots of
> > > > > > > different ways of booting, not just EFI.
> > > > > >
> > > > > > At the high level, bootflow scan is re-implementing "bootefi bo=
otmgr".
> > > > > > but handling non-EFI payloads.
> > > > >
> > > > > bootstd is about replacing the distro scripts, not bootmgr.
> > > >
> > > > And the distro scripts are functionally replaced by "bootefi bootmg=
r",
> > > > outside of bootstd.
> > >
> > > But that doesn't support anything other than EFI apps, so isn't useful
> > > for when EFI is not wanted.
> >
> > Yes, the distro scripts wanted to move more firmly / quickly in this
> > direction. For all of the reasons they've elaborated before.
>=20
> OK, well good luck to them, I suppose.
>=20
> >
> > > > > > > Also I hope that one day EFI
> > > > > > > will be implemented more as part of U-Boot than as a bolt-on,=
 so will
> > > > > > > make use of bootflows, etc.
> > > > > >
> > > > > > And stuff like that is why I said what I said in here first. To=
 me it
> > > > > > sounds like you keep implying it's a hack that's not well integ=
rated.
> > > > > > When it's honestly at this point gotten more traction than FIT =
images
> > > > > > have I think (as much as I wish FIT images had "won", it's like=
 VHS vs
> > > > > > Betamax, to bring in another technology metaphor).
> > > > >
> > > > > The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADE=
R as a whole!
> > > >
> > > > I wasn't clear enough, sorry. I didn't mean just in this series whe=
re
> > > > you referred to storing the needed property as a hack but rather
> > > > "bolt-on" in what I quoted and "tidy up this" and "tidy up that". I=
'm
> > > > just saying what impression your words leave with me, and quite pos=
sibly
> > > > others.
> > >
> > > OK I will try to be more gentle with my language.
> >
> > Thanks.
> >
> > > > > > > > So, to try and bring things back together. If U-Boot decide=
s to load
> > > > > > > > $FOO from device $BAR, at that common point is where we nee=
d to:
> > > > > > > > - Is there an lmb for the location this is supposed to go t=
o (for the if
> > > > > > > >   we know it, entire size)?
> > > > > > > > - Note down everything else we know, now.
> > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > >
> > > > > > > > This means that we can note down enough stuff so that EFI c=
an construct
> > > > > > > > the path it needs. And if we're being told a filesystem, th=
at filename
> > > > > > > > is good enough for the IH_TYPE thing you're wanting, or at =
least a good
> > > > > > > > chunk of it I hope.
> > > > > > >
> > > > > > > You want me to ignore the type that I know (kernel, ramdisk, =
logo,
> > > > > > > etc.) and infer the type from a filename? Why?
> > > > > >
> > > > > > No, I want you to save and display the filename. That's probabl=
y much
> > > > > > more useful when debugging than "kernel". If you actually know =
some
> > > > > > other type information (ie extlinux.conf says ...) then yes, it=
 too can
> > > > > > be stored as that's useful too.
> > > > >
> > > > > The filename is already saved in bootflow->filename, and now it i=
s in
> > > > > struct bootflow_img.
> > > >
> > > > OK. But that's not generic enough.
> > >
> > > How about we see how things work out here rather than giving up at the
> > > start? It is pretty clear in my head, so far.
> >
> > I'd really rather not since it looks like it's starting in the wrong
> > direction. I really do not understand why when we load the file / do the
> > network request / read the flash area / etc is the wrong place to start
> > recording the information about what we load.
>=20
> It isn't that it is the wrong place, it's just that we know more when
> a bootmeth is in place. Are you thinking about the distro scripts or
> people's custom scripts, or something else?
[snip]
> > Yes, perhaps some series that shows what works / doesn't work and how it
> > works would be helpful. I'd really like to see where you're starting
> > your abstractions from.
>=20
> OK I'll send a version with an add-on patch for the 'load' command,
> with the concept of an ad-hoc bootflow.

I want to combine these two (and I hope not drop any important context),
to reply. A challenge is that for EFI, we need to know where we loaded
something from. You hope that EFI_LOADER will make use of bootmeths at
some future point, but that's not on your TODO list? What I'm saying is
that in for example fs_read(), we have the common point between
bootmeth, EFI_LOADER and "load" and already need to be doing sanity
checks and can record what information we have now. Can bootmeth add to
it? Sure. But I still don't see why this is the wrong place to start.
And there are analogous points for network, flash, etc.

--=20
Tom

--NjigEOgzbfd0XeXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcZQ1oACgkQFHw5/5Y0
tyxgQwv/QYAiFsC3JRpc1SoGKGsy+smKB1l2e9hbkKAc4EJtHI++vccVpnm+a+BD
NXmeaxsh+qQZ53yX/Z/2aaB8wxu2x0NbzEC31qoBTNyJ8XaybOYXnXCinXYs3R1w
RhuWBAPHaZGAxulZDpKjRrpT0JcI2EiOWWzacO9AisTdm58bDxpY8LBeHyoL7c9f
ONRL+4uGBBaJewKY2Q2axDPfma/3OD1KJTRrX83v/kaUukCt6Vxdx+kCDhInqV42
TiFgnzbyGTxCBblau8hjzjPS7VSPhkkwBK3JGAaxCMfGxV7Ro+cfzOpMiLReu+LR
z+fxvVpcitCzCL1rcQVzEOuauiQSZl71sVkCFJ/OtGPK2shtwRsKdMuqU+LJVnwA
I8UDw0lDKtvyWBNdBWb67NerNhhGwRv0kw9jB2rp0TNaolrR4X7ZUT2X6iSwXgbv
o19k2aN7S9g6RpAHk6f5kuKWPNfPLAkFZ3Ng3C9vmIQVUhCNfoM30LwFZVb1pgrk
Ibrl6Jt7
=7Rt5
-----END PGP SIGNATURE-----

--NjigEOgzbfd0XeXp--
