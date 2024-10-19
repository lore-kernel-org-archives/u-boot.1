Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9339D3C90A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF1F88DC8;
	Sat, 19 Oct 2024 13:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ca3eQWql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF5388D9F; Sat, 19 Oct 2024 13:49:54 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF9687D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4603aced3a5so23481411cf.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338590; x=1729943390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mVEKNZmVmY6Hsioj06fQ9DuqDy+RV2rtu8YdRPtCfyI=;
 b=Ca3eQWqls8yuiBh9t1MYEixf5ctASXgSJ8W4Zyy/Rp8mkzvQwIrLpQrIaXTfhrimUl
 7HZnhsPS4kat43uU2n6BiDRMtJ/c3RwBrtz5qErzY6p50Mro0+0IWR8XVRAdX082udLI
 wZrKUb/FFeFlFe1g5FafyjsNpD6H9Pu5N8iH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338590; x=1729943390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVEKNZmVmY6Hsioj06fQ9DuqDy+RV2rtu8YdRPtCfyI=;
 b=Fa52ep0onm1kxPzDkrYfuMU2WZhYEt4Nu5TbGNOdq5h1FNPtt4onxS3hnLNpHZr23L
 otS2AUhK1dMHfNczZ3miAAlcayAdv1fhQjIf0YHffF5v4s+s//Q0tIsUNMkozgGawz4o
 lyyH+O51XP0TRfhU6pBOjDOF+uNLhfB3B5yutDmmnSQ1kTZMaIlZOv48m3cuSbXKPYvg
 q5t6a2NzRfqmrEL+DzYEajAoy/urP4syIy9HagXXlfYEg189GKZj1mxGcfY1r0A7zcM9
 B35IhHRVtluB53ZHM1XHXHZ2qCNfSyB39W49aXV4W1ppuhftehxYiWV+TfEkE9Wasz+U
 HLEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrMrAxUHh6o3hnzxWctNrsFjZf4PmQOuzgsRe8CutwBJV99BMt8rN3N8/5xgFzOJn0Womonaw=@lists.denx.de
X-Gm-Message-State: AOJu0YznXnfrHnRAENy1lRhK0beKyReIPeIGhf1C7s9+9aoVVe2m4/Fp
 z49lNb1nrVRUVsn14XCfYvcU+qGA8PyD5Da7k98Hz3zSDB7G9Pw+SNBtViH4roEqYywzUcfu7Of
 STKBpfOhDSmz8aJwKcq163bVchOiQpzhuKz4K
X-Google-Smtp-Source: AGHT+IFmVoDAVC2kawlxMJ4rM7xqzmjgyesZ68wJ2O6gH1adzwqn4Cj0sOdaBtmllEIAQqhob6YSc3nG1Ubq1oMDzyQ=
X-Received: by 2002:a05:622a:60a:b0:460:a795:fccf with SMTP id
 d75a77b69052e-460aecfbff8mr72510201cf.19.1729338590558; Sat, 19 Oct 2024
 04:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
 <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
 <20241018213022.GL4959@bill-the-cat>
In-Reply-To: <20241018213022.GL4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:49:40 -0600
Message-ID: <CAFLszTg0=9kvMRG_=S19W5o5Y5ugdXT-chEb=5wZ+jFK0CtQwQ@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 15:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 12:48:31PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > >We want to keep track of images which are loaded, or those which could
> > > > > > > >perhaps be loaded. This will make it easier to manage memory allocation,
> > > > > > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> > > > > >
> > > > > > I'll change this 'hack' to 'feature'.
> > > > > >
> > > > > > >
> > > > > > > Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.
> > > > > >
> > > > > > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > > > > > use, EFI will need to rely on the above feature, at least until
> > > > > > someone can think of another solution.
> > > > >
> > > > > Perhaps I need to try and be clearer here than I might have been in the
> > > > > past. The consensus among off the shelf free software operating systems
> > > > > is "just give me an EFI interface". This simplifies things on their end
> > > > > if regardless of architecture it's the same interface. This means that
> > > > > in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> > > > > novelty. Not a "some people might use". It is a frequent and commonly
> > > > > used feature.
> > > >
> > > > Yes, EFI is everywhere and growing. All the more reason to tidy up
> > > > this piece. I would like to see bootmgr use this new API, for example.
> > > >
> > > > But how does this comment affect this patch?
> > >
> > > Because at the very high level, I wonder if I made a mistake a few years
> > > back. As I understand it, the nominal case is "bootefi bootmgr". I was
> > > saying at the time that perhaps bootstd can just fire that off, and move
> > > on. Now it seems like we're going along the path of re-inventing that,
> > > and not integrating well with it either.
> >
> > In what way are we re-inventing that? bootstd supports lots of
> > different ways of booting, not just EFI.
>
> At the high level, bootflow scan is re-implementing "bootefi bootmgr".
> but handling non-EFI payloads.

bootstd is about replacing the distro scripts, not bootmgr.

>
> > Also I hope that one day EFI
> > will be implemented more as part of U-Boot than as a bolt-on, so will
> > make use of bootflows, etc.
>
> And stuff like that is why I said what I said in here first. To me it
> sounds like you keep implying it's a hack that's not well integrated.
> When it's honestly at this point gotten more traction than FIT images
> have I think (as much as I wish FIT images had "won", it's like VHS vs
> Betamax, to bring in another technology metaphor).

The 'hack' I was referring to is efi_set_bootdev(), not EFI_LOADER as a whole!

>
> > > So, to try and bring things back together. If U-Boot decides to load
> > > $FOO from device $BAR, at that common point is where we need to:
> > > - Is there an lmb for the location this is supposed to go to (for the if
> > >   we know it, entire size)?
> > > - Note down everything else we know, now.
> >
> > Yes.
> >
> > >
> > > This means that we can note down enough stuff so that EFI can construct
> > > the path it needs. And if we're being told a filesystem, that filename
> > > is good enough for the IH_TYPE thing you're wanting, or at least a good
> > > chunk of it I hope.
> >
> > You want me to ignore the type that I know (kernel, ramdisk, logo,
> > etc.) and infer the type from a filename? Why?
>
> No, I want you to save and display the filename. That's probably much
> more useful when debugging than "kernel". If you actually know some
> other type information (ie extlinux.conf says ...) then yes, it too can
> be stored as that's useful too.

The filename is already saved in bootflow->filename, and now it is in
struct bootflow_img.

>
> > For EFI there is only an EFI application. It will always just be a PE
> > file. We don't really know what it is, as someone pointed out earlier.
> > Maybe one day we will check to see if it is a UKI and pull things out
> > of it. But then, it would be component parts (kernel, ramdisk, etc.)
> > so I would want to add them as images.
>
> I don't see why yet, honestly.

For the cmdline, 'bootflow cmdline' allows editing it, for example.
For a logo we can display it in the menu. The filename doesn't tell us
what it is.

>
> > > It also means that since it's at the most common point, it doesn't
> > > matter if we were in an EFI application, a boot script, a bootmeth or
> > > someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_addr_r".
> >
> > For that case (at the cmdline), bootstd is not currently running. Are
> > you suggesting that bootstd could pick up these things and record
> > them? If so, then yes, definitely, I want to do that. This series is
> > the starting point for that. If you are suggesting something else,
> > then I think I have lost you at this point.
>
> Yes, I think I lost you somewhere, but I'm not sure how. What I am
> saying is that since everything at some point calls down to say
> fs_read() to read a file, that is the common point to note what
> we're doing. Not the load command, not the bootmeth, not the EFI_LOADER
> call.

Perhaps what you are missing is that bootstd is a proper boot
implementation for U-Boot, where U-Boot knows what is going on.
Ignoring that information and just hooking into fs_read() is like
throwing away the plan and trying to recreate it from photographs.

That said, yes I can hook into fs_read() and store that info, as it is
better than nothing, if bootstd is not being used, or there is a
script.

Regards,
Simon
