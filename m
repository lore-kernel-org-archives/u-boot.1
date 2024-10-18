Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6DDD3DEAB
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C412688C7B;
	Fri, 18 Oct 2024 20:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/C6CL7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E6088D13; Fri, 18 Oct 2024 20:48:45 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387B488BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd550b648so16963016d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729277322; x=1729882122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BF6ljcM5qectWxbMgScZEdT6pZhDGLGLDntn8MSSKTo=;
 b=W/C6CL7Al7/6DqWmmMDyunuUXj8RXDs+P0XVezGidpAlVBOdLjz9Ykrj9RndnQdyeV
 Usxs7jNORZsWUe1m4hvjAv9OxBqFXk0bXp1T5nGisAhGI8z71NjUvbpwkSoOknnfGq/4
 y/47ttt/CsjHKrbbrQC3yLOXafFHroZKSFSbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729277322; x=1729882122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BF6ljcM5qectWxbMgScZEdT6pZhDGLGLDntn8MSSKTo=;
 b=P3MrgPmofAQvIai7NJoqgjyirGg34+xeCdptASkAC7K/CFcjZRyh86DXEGMQ0e8TLQ
 7eCex6BM5cuD6lyfSUdLvKezbIHvuYUiyi+iAQvBn29Nra2hl3uKAdF9+Zd1IglOk9xP
 OKA18KPeIP7aT6WX6Z4+tUqQ7PIcaTaFiDPecFJn6mYo10PwoDoA7D5BcHTvCYv4W1Gl
 JMOF8iXCYaeIpV4XCWVALOAXQK9DJSGGMrAapIb5pSMMUsN7il68mXeETRPtwNOm9flt
 1Z6i4JHfuAwyXCpNynyyszo2GDHEjO6JjgV8iYANoOL6/4qijRx9SpzAeab+u4a1t4UN
 pnPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNEQfKI2PqJKh0zWQSfz80i2CSTnzGG259w9nEEtDB0QDOTWXr+Nc4nFjKa6fxMQYg51Nmd80=@lists.denx.de
X-Gm-Message-State: AOJu0YzGUgvAyC8o3p3Ytix86uMApzy5tK3URJKlMOmO8HxqtfGcMIIr
 vh5G5QQg2+O/LxxmKfhNzhKlcpteJ5eJMmDiT22cCkTfYSR2KQTWvSQpaHTK33iKfza7KxAX+rz
 68pOCVMTq3/lAetaWYfA5Sl33YPMnv2ZKNzQe
X-Google-Smtp-Source: AGHT+IEHWx5yZGNL0bJGa62+XSO9V9kiIHbF36eKbV+Bq1F8ez0r+waQxt1ZBO8EV7bHMRsjrnmtjfLWBsGEXWGTjcc=
X-Received: by 2002:a05:6214:4a92:b0:6cb:ecb3:4d43 with SMTP id
 6a1803df08f44-6cde153f07bmr45901616d6.26.1729277322130; Fri, 18 Oct 2024
 11:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
 <20241018163303.GZ4959@bill-the-cat>
 <CAFLszTi2+2si4bq-iZK5fncnUnBHVLnpp6kqJAGFyK5Lis9OZg@mail.gmail.com>
 <20241018180439.GD4959@bill-the-cat>
In-Reply-To: <20241018180439.GD4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 12:48:31 -0600
Message-ID: <CAFLszTjEvoPLiq5iuCRk8q3iA50q-UHGF4GBJJeNNWwqMXD_aw@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 12:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 18, 2024 at 11:20:52AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > >We want to keep track of images which are loaded, or those which could
> > > > > >perhaps be loaded. This will make it easier to manage memory allocation,
> > > > > >as well as permit removal of the EFI set_efi_bootdev() hack.
> > > >
> > > > I'll change this 'hack' to 'feature'.
> > > >
> > > > >
> > > > > Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.
> > > >
> > > > Yes, this series is only going to help if bootstd is used. For ad-hoc
> > > > use, EFI will need to rely on the above feature, at least until
> > > > someone can think of another solution.
> > >
> > > Perhaps I need to try and be clearer here than I might have been in the
> > > past. The consensus among off the shelf free software operating systems
> > > is "just give me an EFI interface". This simplifies things on their end
> > > if regardless of architecture it's the same interface. This means that
> > > in U-Boot we need to treat EFI as one of the primary interfaces. Not a
> > > novelty. Not a "some people might use". It is a frequent and commonly
> > > used feature.
> >
> > Yes, EFI is everywhere and growing. All the more reason to tidy up
> > this piece. I would like to see bootmgr use this new API, for example.
> >
> > But how does this comment affect this patch?
>
> Because at the very high level, I wonder if I made a mistake a few years
> back. As I understand it, the nominal case is "bootefi bootmgr". I was
> saying at the time that perhaps bootstd can just fire that off, and move
> on. Now it seems like we're going along the path of re-inventing that,
> and not integrating well with it either.

In what way are we re-inventing that? bootstd supports lots of
different ways of booting, not just EFI. Also I hope that one day EFI
will be implemented more as part of U-Boot than as a bolt-on, so will
make use of bootflows, etc.

>
> So, to try and bring things back together. If U-Boot decides to load
> $FOO from device $BAR, at that common point is where we need to:
> - Is there an lmb for the location this is supposed to go to (for the if
>   we know it, entire size)?
> - Note down everything else we know, now.

Yes.

>
> This means that we can note down enough stuff so that EFI can construct
> the path it needs. And if we're being told a filesystem, that filename
> is good enough for the IH_TYPE thing you're wanting, or at least a good
> chunk of it I hope.

You want me to ignore the type that I know (kernel, ramdisk, logo,
etc.) and infer the type from a filename? Why?

For EFI there is only an EFI application. It will always just be a PE
file. We don't really know what it is, as someone pointed out earlier.
Maybe one day we will check to see if it is a UKI and pull things out
of it. But then, it would be component parts (kernel, ramdisk, etc.)
so I would want to add them as images.

>
> It also means that since it's at the most common point, it doesn't
> matter if we were in an EFI application, a boot script, a bootmeth or
> someone at the cmdline doing "load mmc 0:1 /boot/Image $kernel_addr_r".

For that case (at the cmdline), bootstd is not currently running. Are
you suggesting that bootstd could pick up these things and record
them? If so, then yes, definitely, I want to do that. This series is
the starting point for that. If you are suggesting something else,
then I think I have lost you at this point.

Regards,
Simon
