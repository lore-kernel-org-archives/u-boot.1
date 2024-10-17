Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22123D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB78E890CE;
	Fri, 18 Oct 2024 01:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NNcFhEaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BEB890E7; Fri, 18 Oct 2024 01:23:22 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAC289083
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cc2ea27a50so20446726d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207399; x=1729812199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gFUR3qusmE6/rvgp/m6xGI9s/DFzBEfHMEwWFZUTTDo=;
 b=NNcFhEafwwCq2FIwjLAAa7eFQ2Mb+V7us8QIRU3tdFYLrxfH/nUlmyzIXL2/A6ATVv
 SC+PT58k7GvZJDkbkQJLe74UnLwYa3O3/bMpaAQqg4SvEmKLMR9EE7WbtfJk3jKMCe4L
 P1/OoiI1xhNcYA6GrzDjTwfFBuSZXN07xpN3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207399; x=1729812199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gFUR3qusmE6/rvgp/m6xGI9s/DFzBEfHMEwWFZUTTDo=;
 b=q+vwOrB7lD99JTeY9jD0JO1EC9DibgcEi6PAZuRF62jvhIm+aYXg4q6rJcTiViu+9M
 1uyKxCXauRVAe6DzCyI1OmhebFM7BZMxkMQrjlXXu2YqecdgY6FgVgjfZ0oK2gU4k7Ve
 lZL3V1GG4VPa+ILb2mxToDM9cJBkTDrtfuu9xse48r/pmjaq+3M4TCo4UPiyUGvyHUg1
 63RhA8Eg3BVAph2IsWEvy+ONyIPYtwWOGweSBczxTeL2OvkBr0rZjIVvuINnB+P0OmHg
 gBwhklXynPDF/HbUGrJ00GpRQjH6P1N5hanQZw0fS4A5R+fElRhCjhbiem/ggdZcSvK/
 Iaow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU+rYgNW92O51nnrtxa873uaiO1x27Nrv3G8BxBPSPjjk0vJKf95FrnjLUtrYX3GnArF6R6OQ=@lists.denx.de
X-Gm-Message-State: AOJu0YymSQLEn94e//pt7hLgO5NycHK+cfe9AfQfTX5vrjr5HgSTMjEv
 nuoBzo2Bk0aj0bOH9DtnddKcNE5hlKaIaC7Dn9vMiM2FuIntbyzNoNPaSwSP//46efl8m+3VZg6
 jbx5Q2uT5Yn2eLiAGKrL1Frer/588VSoKACYJ
X-Google-Smtp-Source: AGHT+IF/o9cbLEH6P0Wekyf30IB6v/4h3+Dx8dMuSZxx98FW4gLX/1OlrsnOXPyVu1Pz+e+wfOpQsoTQrZpxuBVeElk=
X-Received: by 2002:ad4:4f94:0:b0:6cb:c9cf:cd40 with SMTP id
 6a1803df08f44-6cc3785176emr63110446d6.8.1729207399294; Thu, 17 Oct 2024
 16:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
 <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
 <20241014230725.GH53053@bill-the-cat>
 <CAFLszTj6y-aC=bJ+9c8un+=zG=yGb7bs60wPzDOeMVAKMgVchQ@mail.gmail.com>
 <20241015190513.GR53053@bill-the-cat>
In-Reply-To: <20241015190513.GR53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:08 -0600
Message-ID: <CAFLszTi22i661DikXOR=PvqEL=URGRsKC1pmU8QrJyy1GAxnCg@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, 15 Oct 2024 at 13:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 15, 2024 at 07:10:27AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 17:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 03:55:05PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 14 Oct 2024 at 15:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > > > > > > > Hi Sughosh,
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Use the LMB API's for allocating and freeing up memory. With this, the
> > > > > > > > > > > > > LMB module becomes the common backend for managing non U-Boot image
> > > > > > > > > > > > > memory that might be requested by other modules.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > Changes since V2:
> > > > > > > > > > > > > * Use map_to_sysmem() to get the user-visible address to be shared
> > > > > > > > > > > > >   with the lmb API's for sandbox.
> > > > > > > > > > > > >
> > > > > > > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
> > > > > > > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > When efi_init_obj() is called, it should be able to add the lmb memory
> > > > > > > > > > > > to its own tables. There is no need to worry about lmb after that,
> > > > > > >
> > > > > > > Saying "There is no need to worry about lmb after that" is not true.
> > > > > > > Invoking the "env" command for example will have efi_init_obj() be
> > > > > > > called, among the others that Heinrich listed. And to possibly refute
> > > > > > > a next issue, that is intentional so that efivars, the standard
> > > > > > > mechanism used by an OS to talk with the firmware can be available to
> > > > > > > U-Boot, if I recall things correctly.
> > > > > > >
> > > > > > > My understanding of your assumption is that you believe that once the
> > > > > > > EFI_LOADER subsystem has started work on a payload we're just a few call
> > > > > > > chains away from the OS being started and runtime services aside U-Boot
> > > > > > > being done.
> > > > > > >
> > > > > > > My understanding of how things are used today is that this is incorrect.
> > > > > >
> > > > > > What I am getting at is that once we have called that function we know
> > > > > > we are booting an EFI app or using an EFI feature in preparation for
> > > > > > doing so. Let's start there. Is that correct?
> > > > >
> > > > > No, it is not correct.
> > > >
> > > > Can you give me a code link?
> > >
> > > env_set() -> env_do_env_set() -> do_env_set_efi() -> efi_init_obj_list()
> >
> > That's with the '-e' option, though, so people doing that are
> > specifically choosing EFI.
>
> They're choosing a feature, yes and from there may not use any more, and
> can / will be using "load" to put things in to memory.
>
> > What I am saying is that, if we are not booting an EFI app or using an
> > EFI feature. Since 'env set -e' is an EFI feature, efi_init_obj_list()
> > is called, and EFI is in the picture.
> >
> > Even if efi_init_obj_list(), I don't like treating U-Boot's memory as
> > a stack to just grow into. But as a first step, I do want to ensure
> > that non-EFI boot can be more like U-Boot.
>
> I think you intended a negation somewhere in that last sentence.

It looks right to me.

>
> But among the points trying to be made here are that no, we didn't start
> an EFI app (a previous point of contention you had), even if we used an
> EFI feature. We may or may not use more.

Yes, we have ended up with what I feel is a dog's breakfast. I'd like
to tidy it up.

>  But saying "I guess now we can
> live with the EFI pool doing what it needs" is quite silly since we've
> potentially done almost nothing else.

Do you mean that it is inconsistent for me to say that when
efi_init_obj_list() is called, any memory can be used? Yes it is
inconsistent. In fact I may as well just say that we should use
U-Boot's region until we can't, e.g. we exhaust the reserved space. By
that time, the boot will be well-advanced, I suspect. I'll take a look
at some Ubuntu boots and see what happens in practice.

> And so why did we make this
> special case anyways?

Once an EFI feature is used, we know we are booting EFI, so it might
start using memory outside the U-Boot region. That's all.

> This is why I keep saying various versions of, you
> need to re-think what you consider "U-Boot memory". If you have concerns
> about our stack smashing in to things, that's the problem to address (it
> could just as easily smash an initrd placed high in memory by a non-EFI
> bootmeth).

I am not yet ready to re-think that, because my intuition tells me
that I have this right. I would like to get some of my ideas in, to
solve this problem. To do that, we need to be willing to let U-Boot
allocate memory (on EFI's behalf) as it wishes, within the spec, not
necessarily based on just what the code does today.

Regards,
SImon
