Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FC7D2CE08
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739C18919D;
	Tue, 22 Oct 2024 19:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JJzRdUwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D0188FD6; Tue, 22 Oct 2024 19:01:13 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA5389251
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539fbe22ac0so6622934e87.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616467; x=1730221267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a+kFi46WzXCQVNz2XRUVHwtoR2zJ+5iLmyzXbsXtvYI=;
 b=JJzRdUwomWN1Uk7Xz/1XFxbX/duZR/yo8k8S5k25mBerBxzzZBAHsqf64F9lHN3973
 3dUJmXG6lCCkIR5BZLA9gjEn+TNx3UEidQhfPO9XTUHRYI6aRU4vL4e5kfoseBMTptiE
 Bi4C8Xr5fkNVU+MczhZ7uEeHBwP0dtVK8gdTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616467; x=1730221267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+kFi46WzXCQVNz2XRUVHwtoR2zJ+5iLmyzXbsXtvYI=;
 b=mIQP66PMoEpS2oI3H8++uCOKEBw7okZni2CW/8rKr63pjFVo3r0LI/UVCpWmmdnfsb
 HI0nXloLiXNJQURawKgltRuEMck5MdOxfMtOQ7oaEsR8u7/lO280eQJNNYFJXPe4DEAC
 3YHzwNn+XhyMUII4scf1AAEWxDO7QVpgaJRTnJD8eaQGx4OxPx2kOsJXa5lWLAjCpOmh
 S3CRQNcsmdtZ09ewvS/nxDTC3Qkw+4SQnC4RGgivxkIcTOxBaVCrIrmmB6hgN8B3QKCY
 jqxko3ilQiU5G5ZtypZv5XKQX4+xgLnZiBY+FLmLJ1L0GJ8A/Em5XHU+ocrJReM6ZxE7
 OUbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWndxNJraKC70Bw+K4EyryRWY3ehyEVzK3G9CwRPMePD25jbs0W2HZE/ohgCEEC3FQPtCKnkRo=@lists.denx.de
X-Gm-Message-State: AOJu0YymRHm3+nXmTCF+CNPZJkvFuQ0b5a7HA6HoBMTWSHsI9wbzUNJ2
 aECxmUjcpwKZG/2EgIf+WduuwerNB3BE8r6xaU4khhtVy3zPUMLSTRV+7UEe+OfM6Fdd2R68bOm
 fkqp79ztQH+JqP5NNOEbEqglau/TFjRbV0ARP
X-Google-Smtp-Source: AGHT+IHVjlrcfe1CD8tx/lomo+LblhoqhZfK4Ud6jCmSZL8xeD6AcRhQdugsvYUzaTAJZA9VEWkkHeNgo70p7YilF9c=
X-Received: by 2002:a05:6512:2393:b0:539:f65b:401 with SMTP id
 2adb3069b0e04-53a154a2413mr7541310e87.57.1729616466916; Tue, 22 Oct 2024
 10:01:06 -0700 (PDT)
MIME-Version: 1.0
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
 <20241022150125.GF4959@bill-the-cat>
In-Reply-To: <20241022150125.GF4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:44 +0200
Message-ID: <CAFLszTjnEzUDFRBXvySiMD0bROV5JdFrNt16Q5_BHUFHyBz5Vg@mail.gmail.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 22 Oct 2024 at 17:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 02:16:52PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 19 Oct 2024 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 19, 2024 at 05:49:40AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > >
> > > > > > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > > > > > >We want to keep track of images which are loaded, or those which could
> > > > > > > > > > > >perhaps be loaded. This will make it easier to manage memory allocation,
> > > > > > > > > > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> > > > > > > > > >
> > > > > > > > > > I'll change this 'hack' to 'feature'.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.
> > > > > > > > > >
> > > > > > > > > > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > > > > > > > > > use, EFI will need to rely on the above feature, at least until
> > > > > > > > > > someone can think of another solution.
> > > > > > > > >
> > > > > > > > > Perhaps I need to try and be clearer here than I might have been in the
> > > > > > > > > past. The consensus among off the shelf free software operating systems
> > > > > > > > > is "just give me an EFI interface". This simplifies things on their end
> > > > > > > > > if regardless of architecture it's the same interface. This means that
> > > > > > > > > in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> > > > > > > > > novelty. Not a "some people might use". It is a frequent and commonly
> > > > > > > > > used feature.
> > > > > > > >
> > > > > > > > Yes, EFI is everywhere and growing. All the more reason to tidy up
> > > > > > > > this piece. I would like to see bootmgr use this new API, for example.
> > > > > > > >
> > > > > > > > But how does this comment affect this patch?
> > > > > > >
> > > > > > > Because at the very high level, I wonder if I made a mistake a few years
> > > > > > > back. As I understand it, the nominal case is "bootefi bootmgr". I was
> > > > > > > saying at the time that perhaps bootstd can just fire that off, and move
> > > > > > > on. Now it seems like we're going along the path of re-inventing that,
> > > > > > > and not integrating well with it either.
> > > > > >
> > > > > > In what way are we re-inventing that? bootstd supports lots of
> > > > > > different ways of booting, not just EFI.
> > > > >
> > > > > At the high level, bootflow scan is re-implementing "bootefi bootmgr".
> > > > > but handling non-EFI payloads.
> > > >
> > > > bootstd is about replacing the distro scripts, not bootmgr.
> > >
> > > And the distro scripts are functionally replaced by "bootefi bootmgr",
> > > outside of bootstd.
> >
> > But that doesn't support anything other than EFI apps, so isn't useful
> > for when EFI is not wanted.
>
> Yes, the distro scripts wanted to move more firmly / quickly in this
> direction. For all of the reasons they've elaborated before.

OK, well good luck to them, I suppose.

>
> > > > > > Also I hope that one day EFI
> > > > > > will be implemented more as part of U-Boot than as a bolt-on, so will
> > > > > > make use of bootflows, etc.
> > > > >
> > > > > And stuff like that is why I said what I said in here first. To me it
> > > > > sounds like you keep implying it's a hack that's not well integrated.
> > > > > When it's honestly at this point gotten more traction than FIT images
> > > > > have I think (as much as I wish FIT images had "won", it's like VHS vs
> > > > > Betamax, to bring in another technology metaphor).
> > > >
> > > > The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADER as a whole!
> > >
> > > I wasn't clear enough, sorry. I didn't mean just in this series where
> > > you referred to storing the needed property as a hack but rather
> > > "bolt-on" in what I quoted and "tidy up this" and "tidy up that". I'm
> > > just saying what impression your words leave with me, and quite possibly
> > > others.
> >
> > OK I will try to be more gentle with my language.
>
> Thanks.
>
> > > > > > > So, to try and bring things back together. If U-Boot decides to load
> > > > > > > $FOO from device $BAR, at that common point is where we need to:
> > > > > > > - Is there an lmb for the location this is supposed to go to (for the if
> > > > > > >   we know it, entire size)?
> > > > > > > - Note down everything else we know, now.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > > This means that we can note down enough stuff so that EFI can construct
> > > > > > > the path it needs. And if we're being told a filesystem, that filename
> > > > > > > is good enough for the IH_TYPE thing you're wanting, or at least a good
> > > > > > > chunk of it I hope.
> > > > > >
> > > > > > You want me to ignore the type that I know (kernel, ramdisk, logo,
> > > > > > etc.) and infer the type from a filename? Why?
> > > > >
> > > > > No, I want you to save and display the filename. That's probably much
> > > > > more useful when debugging than "kernel". If you actually know some
> > > > > other type information (ie extlinux.conf says ...) then yes, it too can
> > > > > be stored as that's useful too.
> > > >
> > > > The filename is already saved in bootflow->filename, and now it is in
> > > > struct bootflow_img.
> > >
> > > OK. But that's not generic enough.
> >
> > How about we see how things work out here rather than giving up at the
> > start? It is pretty clear in my head, so far.
>
> I'd really rather not since it looks like it's starting in the wrong
> direction. I really do not understand why when we load the file / do the
> network request / read the flash area / etc is the wrong place to start
> recording the information about what we load.

It isn't that it is the wrong place, it's just that we know more when
a bootmeth is in place. Are you thinking about the distro scripts or
people's custom scripts, or something else?

>
> > > > > > For EFI there is only an EFI application. It will always just be a PE
> > > > > > file. We don't really know what it is, as someone pointed out earlier.
> > > > > > Maybe one day we will check to see if it is a UKI and pull things out
> > > > > > of it. But then, it would be component parts (kernel, ramdisk, etc.)
> > > > > > so I would want to add them as images.
> > > > >
> > > > > I don't see why yet, honestly.
> > > >
> > > > For the cmdline, 'bootflow cmdline' allows editing it, for example.
> > > > For a logo we can display it in the menu. The filename doesn't tell us
> > > > what it is.
> > >
> > > There may, or may not, be further context clues about what a blob is,
> > > yes, and we should make use of them. But we may not have them. Frankly
> > > for a logo we probably need to have dealt with that upon initializing
> > > the display, so earlier in the process. But this is all getting away
> > > from the point I'm trying to make.
> > >
> > > > > > > It also means that since it's at the most common point, it doesn't
> > > > > > > matter if we were in an EFI application, a boot script, a bootmeth or
> > > > > > > someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_addr_r".
> > > > > >
> > > > > > For that case (at the cmdline), bootstd is not currently running. Are
> > > > > > you suggesting that bootstd could pick up these things and record
> > > > > > them? If so, then yes, definitely, I want to do that. This series is
> > > > > > the starting point for that. If you are suggesting something else,
> > > > > > then I think I have lost you at this point.
> > > > >
> > > > > Yes, I think I lost you somewhere, but I'm not sure how. What I am
> > > > > saying is that since everything at some point calls down to say
> > > > > fs_read() to read a file, that is the common point to note what
> > > > > we're doing. Not the load command, not the bootmeth, not the EFI_LOADER
> > > > > call.
> > > >
> > > > Perhaps what you are missing is that bootstd is a proper boot
> > > > implementation for U-Boot, where U-Boot knows what is going on.
> > > > Ignoring that information and just hooking into fs_read() is like
> > > > throwing away the plan and trying to recreate it from photographs.
> > > >
> > > > That said, yes I can hook into fs_read() and store that info, as it is
> > > > better than nothing, if bootstd is not being used, or there is a
> > > > script.
> > >
> > > Maybe we need to throw out the plan and start over then? Since you seem
> > > to not be accounting for the rest of the common paths and assuming
> > > that your design can just be used as-is for them despite not taking them
> > > in to account in the design in the first place.  Hooking in at around
> > > fs_read() or thereabouts is likely where we need to be at least starting
> > > some of this so that we do know information that we want to preserve.
> > > Similarly, there's the common path for "grab a file via HTTP(s)" and
> > > that is where we should be recording information for network loads. We
> > > can then augment that if it was a pxelinux.cfg file we grabbed or
> > > something else, but that's the common place to start gathering
> > > information.
> >
> > Here's what I see as the key point: bootstd knows what is being
> > booted. It knows that the kernel is a kernel and where it came from.
> > If there is a logo or cmdline, it knows about that too. It is sort-of
> > the point of bootstd to make booting more automatic and deterministic.
> > Where people are using scripts and ad-hoc ways of booting, they just
> > aren't going to get the same level of control and visibility as
> > bootstd can provide.
> >
> > I think I recall having exactly this discussion before?
> >
> > I will see if I can construct a small series to show what an ad-hoc
> > bootflow might look like. It will at least collect loaded files into
> > one place so they can be examined, etc.
>
> Yes, perhaps some series that shows what works / doesn't work and how it
> works would be helpful. I'd really like to see where you're starting
> your abstractions from.

OK I'll send a version with an add-on patch for the 'load' command,
with the concept of an ad-hoc bootflow.

Regards,
Simon
