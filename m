Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC1CD2C568
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 15:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C098888969;
	Tue, 22 Oct 2024 17:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hatY6Nmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A64B8899C; Tue, 22 Oct 2024 17:01:33 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EEE885B3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so43529206d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729609290; x=1730214090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f9ldt6jt/WitgQmeHSP9TWBVDDlvYm7wybxCI3/qOMg=;
 b=hatY6Nmf9VTAlTNQBGB2dKfAyL4XhZsQw96e7NE4GH4zoYzM8q4t+W9JtEnaVCW3g/
 xvrSq/vE66Z/PKuJn8uHKKNi536BoOhHDLDCE5anXlSO+QJsCiSP/mFtz/lxNsf5UN0m
 zaCutDdlo3lwAtWyOPl11++OYq/r6mRN6xNQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729609290; x=1730214090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9ldt6jt/WitgQmeHSP9TWBVDDlvYm7wybxCI3/qOMg=;
 b=ibSFRDdHW6DU2MZ3D601+S36+7PtqNADZy7VGzxbbxGMSkkUyJ2mrgxyNMo9Bty++n
 UYq7CG6cnzGuHIcSEZIbkrsy14K+J6g76B06qIOcIX7pNS0L5BdU6on6XV5gVz6FxGWe
 Oshg62PVbIyMl9JU/upZzXC4ldZ720E34ikgqK8iB6WdGRqLo5cAmctmI0i7iys0bEZs
 feEoeN7+4RP+22jy2PqUZlWnsqeoxANvqRm1Ip1kkxD3o6YoZOy23izPGaPS1TRVpac5
 6fYICtiLW4ew8ZUbkbDzQ98udSisIoEmsqzNgpo5CVcOGSMQdsGiyylEiUpUF/Vrf2SB
 xBaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBtVP9CwwqDa3lzcld7dRoHcRPVxeC3x8n9CK5Yv4I0gvoMIyImAHKZcMgrMzj3VDGsXlsV3w=@lists.denx.de
X-Gm-Message-State: AOJu0YzNYG2UxuJUnnwn5C6fWz7s9HUG6OpSRiXoNlgVJNbbw3g0nQU3
 9Tx0TGe2fr3ERXwcblVSO2PVuVh5lFaEqrtDYuBX4hiPUEyiGS6Iwy63WgcrcMs=
X-Google-Smtp-Source: AGHT+IFhSug0JBMdJsU4srlNjoYu/65xsKhN0uhM69A5FgT8L+zlLrJQPV6ggL9sJQvENMIIqvMlFw==
X-Received: by 2002:a05:6214:5543:b0:6cb:ecb1:e6c1 with SMTP id
 6a1803df08f44-6cde1508007mr222374146d6.17.1729609289083; 
 Tue, 22 Oct 2024 08:01:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008acc2asm29534826d6.19.2024.10.22.08.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 08:01:28 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:01:25 -0600
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
Message-ID: <20241022150125.GF4959@bill-the-cat>
References: <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
 <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
 <20241018213022.GL4959@bill-the-cat>
 <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
 <20241019163025.GU4959@bill-the-cat>
 <CAFLszTjAYhGGF+dm+egcw_yixo-akmKZUNb5EWnegD0dgETeWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QnNYqTS4lrHOKHel"
Content-Disposition: inline
In-Reply-To: <CAFLszTjAYhGGF+dm+egcw_yixo-akmKZUNb5EWnegD0dgETeWg@mail.gmail.com>
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


--QnNYqTS4lrHOKHel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:16:52PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 19 Oct 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 19, 2024 at 05:49:40AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <=
sjg@chromium.org>:
> > > > > > > > > > >We want to keep track of images which are loaded, or t=
hose which could
> > > > > > > > > > >perhaps be loaded. This will make it easier to manage =
memory allocation,
> > > > > > > > > > >as well as permit removal of the EFI set_efi_bootdev()=
 hack.
> > > > > > > > >
> > > > > > > > > I'll change this 'hack' to 'feature'.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Please, keep in mind that files can be loaded manually,=
 e.g. via the dhcp, the wget, and the loady commands. These are outside boo=
tflows.
> > > > > > > > >
> > > > > > > > > Yes, this series is only going to help if bootstd is used=
=2E For ad-hoc
> > > > > > > > > use, EFI will need to rely on the above feature, at least=
 until
> > > > > > > > > someone can think of another solution.
> > > > > > > >
> > > > > > > > Perhaps I need to try and be clearer here than I might have=
 been in the
> > > > > > > > past. The consensus among off the shelf free software opera=
ting systems
> > > > > > > > is "just give me an EFI interface". This simplifies things =
on their end
> > > > > > > > if regardless of architecture it's the same interface. This=
 means that
> > > > > > > > in U-Boot we need to treat EFI as one of the primary interf=
aces. Not a
> > > > > > > > novelty. Not a "some people might use". It is a frequent an=
d commonly
> > > > > > > > used feature.
> > > > > > >
> > > > > > > Yes, EFI is everywhere and growing. All the more reason to ti=
dy up
> > > > > > > this piece. I would like to see bootmgr use this new API, for=
 example.
> > > > > > >
> > > > > > > But how does this comment affect this patch?
> > > > > >
> > > > > > Because at the very high level, I wonder if I made a mistake a =
few years
> > > > > > back. As I understand it, the nominal case is "bootefi bootmgr"=
=2E I was
> > > > > > saying at the time that perhaps bootstd can just fire that off,=
 and move
> > > > > > on. Now it seems like we're going along the path of re-inventin=
g that,
> > > > > > and not integrating well with it either.
> > > > >
> > > > > In what way are we re-inventing that? bootstd supports lots of
> > > > > different ways of booting, not just EFI.
> > > >
> > > > At the high level, bootflow scan is re-implementing "bootefi bootmg=
r".
> > > > but handling non-EFI payloads.
> > >
> > > bootstd is about replacing the distro scripts, not bootmgr.
> >
> > And the distro scripts are functionally replaced by "bootefi bootmgr",
> > outside of bootstd.
>=20
> But that doesn't support anything other than EFI apps, so isn't useful
> for when EFI is not wanted.

Yes, the distro scripts wanted to move more firmly / quickly in this
direction. For all of the reasons they've elaborated before.

> > > > > Also I hope that one day EFI
> > > > > will be implemented more as part of U-Boot than as a bolt-on, so =
will
> > > > > make use of bootflows, etc.
> > > >
> > > > And stuff like that is why I said what I said in here first. To me =
it
> > > > sounds like you keep implying it's a hack that's not well integrate=
d.
> > > > When it's honestly at this point gotten more traction than FIT imag=
es
> > > > have I think (as much as I wish FIT images had "won", it's like VHS=
 vs
> > > > Betamax, to bring in another technology metaphor).
> > >
> > > The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADER as=
 a whole!
> >
> > I wasn't clear enough, sorry. I didn't mean just in this series where
> > you referred to storing the needed property as a hack but rather
> > "bolt-on" in what I quoted and "tidy up this" and "tidy up that". I'm
> > just saying what impression your words leave with me, and quite possibly
> > others.
>=20
> OK I will try to be more gentle with my language.

Thanks.

> > > > > > So, to try and bring things back together. If U-Boot decides to=
 load
> > > > > > $FOO from device $BAR, at that common point is where we need to:
> > > > > > - Is there an lmb for the location this is supposed to go to (f=
or the if
> > > > > >   we know it, entire size)?
> > > > > > - Note down everything else we know, now.
> > > > >
> > > > > Yes.
> > > > >
> > > > > >
> > > > > > This means that we can note down enough stuff so that EFI can c=
onstruct
> > > > > > the path it needs. And if we're being told a filesystem, that f=
ilename
> > > > > > is good enough for the IH_TYPE thing you're wanting, or at leas=
t a good
> > > > > > chunk of it I hope.
> > > > >
> > > > > You want me to ignore the type that I know (kernel, ramdisk, logo,
> > > > > etc.) and infer the type from a filename? Why?
> > > >
> > > > No, I want you to save and display the filename. That's probably mu=
ch
> > > > more useful when debugging than "kernel". If you actually know some
> > > > other type information (ie extlinux.conf says ...) then yes, it too=
 can
> > > > be stored as that's useful too.
> > >
> > > The filename is already saved in bootflow->filename, and now it is in
> > > struct bootflow_img.
> >
> > OK. But that's not generic enough.
>=20
> How about we see how things work out here rather than giving up at the
> start? It is pretty clear in my head, so far.

I'd really rather not since it looks like it's starting in the wrong
direction. I really do not understand why when we load the file / do the
network request / read the flash area / etc is the wrong place to start
recording the information about what we load.

> > > > > For EFI there is only an EFI application. It will always just be =
a PE
> > > > > file. We don't really know what it is, as someone pointed out ear=
lier.
> > > > > Maybe one day we will check to see if it is a UKI and pull things=
 out
> > > > > of it. But then, it would be component parts (kernel, ramdisk, et=
c.)
> > > > > so I would want to add them as images.
> > > >
> > > > I don't see why yet, honestly.
> > >
> > > For the cmdline, 'bootflow cmdline' allows editing it, for example.
> > > For a logo we can display it in the menu. The filename doesn't tell us
> > > what it is.
> >
> > There may, or may not, be further context clues about what a blob is,
> > yes, and we should make use of them. But we may not have them. Frankly
> > for a logo we probably need to have dealt with that upon initializing
> > the display, so earlier in the process. But this is all getting away
> > from the point I'm trying to make.
> >
> > > > > > It also means that since it's at the most common point, it does=
n't
> > > > > > matter if we were in an EFI application, a boot script, a bootm=
eth or
> > > > > > someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_=
addr_r".
> > > > >
> > > > > For that case (at the cmdline), bootstd is not currently running.=
 Are
> > > > > you suggesting that bootstd could pick up these things and record
> > > > > them? If so, then yes, definitely, I want to do that. This series=
 is
> > > > > the starting point for that. If you are suggesting something else,
> > > > > then I think I have lost you at this point.
> > > >
> > > > Yes, I think I lost you somewhere, but I'm not sure how. What I am
> > > > saying is that since everything at some point calls down to say
> > > > fs_read() to read a file, that is the common point to note what
> > > > we're doing. Not the load command, not the bootmeth, not the EFI_LO=
ADER
> > > > call.
> > >
> > > Perhaps what you are missing is that bootstd is a proper boot
> > > implementation for U-Boot, where U-Boot knows what is going on.
> > > Ignoring that information and just hooking into fs_read() is like
> > > throwing away the plan and trying to recreate it from photographs.
> > >
> > > That said, yes I can hook into fs_read() and store that info, as it is
> > > better than nothing, if bootstd is not being used, or there is a
> > > script.
> >
> > Maybe we need to throw out the plan and start over then? Since you seem
> > to not be accounting for the rest of the common paths and assuming
> > that your design can just be used as-is for them despite not taking them
> > in to account in the design in the first place.  Hooking in at around
> > fs_read() or thereabouts is likely where we need to be at least starting
> > some of this so that we do know information that we want to preserve.
> > Similarly, there's the common path for "grab a file via HTTP(s)" and
> > that is where we should be recording information for network loads. We
> > can then augment that if it was a pxelinux.cfg file we grabbed or
> > something else, but that's the common place to start gathering
> > information.
>=20
> Here's what I see as the key point: bootstd knows what is being
> booted. It knows that the kernel is a kernel and where it came from.
> If there is a logo or cmdline, it knows about that too. It is sort-of
> the point of bootstd to make booting more automatic and deterministic.
> Where people are using scripts and ad-hoc ways of booting, they just
> aren't going to get the same level of control and visibility as
> bootstd can provide.
>=20
> I think I recall having exactly this discussion before?
>=20
> I will see if I can construct a small series to show what an ad-hoc
> bootflow might look like. It will at least collect loaded files into
> one place so they can be examined, etc.

Yes, perhaps some series that shows what works / doesn't work and how it
works would be helpful. I'd really like to see where you're starting
your abstractions from.

--=20
Tom

--QnNYqTS4lrHOKHel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXvj0ACgkQFHw5/5Y0
tyxdMwv+Iddv1if8SvA7ODbI4kgATCWfj/MX0qWVjw/2AQdEkD7JBZJjZL+PTDVi
gSe1VX6Y8u7GMhp2HOJXUpmgniEGJAW8NN7irdJDFLHyUYaqcaCGi/u3Ofv8IVmh
j7gBST1vCImyWFu84N/DbT8+WJCtz5qr2EblOMUiYALU/jMO81ENTX9E6sigoa3W
ZESHrd1zOV2pc0t7/RCQ4Yqvxlitdyn/JMiRXpAQLa4N5q2ATA+QO98+0gAaALwN
9btHq8y3kXtw7fWzKx0TKaCB42Zzjb85d+lCRRSO8a03GdClc3CQa8M8mqDIZbQQ
tBArcdpUry0sFCXAe9xJz2lws+S4cJXxZfOAKC9DnNLtnggLIEcp9EWMW+rKuezA
yhRR3nCpxthWVqfDZz3iNQIYVR2Om847xd1LzadOGxYL2U5tsSPYoGJjSgXVS7IG
hzUJA9sft0ypswN0njTfNbCyTwHrKivWWAM/oYbLsbyc9E2BcYLqilOx8oOlxjap
bDobQ2K5
=u59V
-----END PGP SIGNATURE-----

--QnNYqTS4lrHOKHel--
