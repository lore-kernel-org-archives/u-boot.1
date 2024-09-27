Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48480CEBF8E
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CA888FAF;
	Fri, 27 Sep 2024 12:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MyuP+sUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2510A890AD; Fri, 27 Sep 2024 12:43:02 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8F288D65
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2458774dso13580036d6.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727433779; x=1728038579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mmkoku26XnpwV+gV4cx8Uyae11+wO4XVqXjSaclDRuc=;
 b=MyuP+sUswioIEthr/g1bpsqzqQF1UIq1UJ6p/0dUdT+3Ri0Lu3s4H6EGdjiOTsyYTj
 kdIOwpJN06IrfqE6sD3yFcEuw5oeXjlDx45RUjo8HyNaMBYlEMkg3Pt3Th2F/1WsHGGK
 XnW8XnUKn5Y6T47zoRv731JOvg+LHZru3Sxwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727433779; x=1728038579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmkoku26XnpwV+gV4cx8Uyae11+wO4XVqXjSaclDRuc=;
 b=m7rbmCnDXFA2+/R5eI0dlXD2xD0YhUOk3ymflWxRzj6ze4U6waXGoPXpXMAFBSTIA8
 iYLFcSCQPwvVebpHykSnKZnBiNqydXL9hbjR9TjZN/ecOS2gcD6OCJs4Kk/xcSRrZOak
 0xSMPaZAZoP0vhNV8nA5F8uCh5Y147e1ce+PuM9Vl3wRHKkGcNiCbLt077YRC3lRqOd9
 +Ntjp83iRqjZkK4rgPYKXn9oRgdVj6Tgg4Sz0BmIJY4CVgv9+NtA9+9tnsB1uGEgUkH+
 JAxITh5650NcPS+70fTIlQYjKyDx7ayWVRaAMwICeysJba8kjAvlZZeDJV4buveWe684
 iagQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVftsmbfN/HyP/bxo67iVdhxtNB28WfeIMr4ceAyEjQh+xAjNjWVVHd/ldslufe+Zsl5v7S+ws=@lists.denx.de
X-Gm-Message-State: AOJu0YyIkW38jOCPVsgmbFOCSgD7ZSuMBWdVfr9S7Pl0/0daOWqkF70E
 BqDrz1l8/DGK7prUXa5RwpvIjL0l9pZrDbxwZobKliHyo3KCIfTA6QuSUa2g9iX6KHRdV/4REBz
 GOBmliVdDZskZYEOeEUdc9PxndV5XynO2nFea
X-Google-Smtp-Source: AGHT+IEhQH2g1lcfuXa/Ltl3zYMZxLD7PAaVXKp1h4CiZlFv7gm9PYa8so2D6RZCYiBGs0Cg97ry2DYGyoM2/WrS2vM=
X-Received: by 2002:a05:6214:4383:b0:6c3:6455:85d2 with SMTP id
 6a1803df08f44-6cb3b5c11ddmr34340146d6.8.1727433778579; Fri, 27 Sep 2024
 03:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
 <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
 <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
 <CADg8p94_8znKCR=97kCj-ypMdqW59k7PbC42G-xGFr7t9+t9XQ@mail.gmail.com>
 <CAFLszTg2TvZp37HTjVwnYAw9cgX1-mfipkaw7frEL4cwJbzF4w@mail.gmail.com>
 <CADg8p95eA-qMFtiypaTOyfAkVwdKWWD2yMa+HZyewWfR_vS2kw@mail.gmail.com>
In-Reply-To: <CADg8p95eA-qMFtiypaTOyfAkVwdKWWD2yMa+HZyewWfR_vS2kw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:42:47 -0600
Message-ID: <CAFLszThCXoHkOM5cOGmbrQvVnTARNUsZyN=NH_+JBi-pB=XK6g@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

Hi Sughosh,

On Thu, 26 Sept 2024 at 14:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 26 Sept 2024 at 16:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 26 Sept 2024 at 09:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Wed, 25 Sept 2024 at 18:23, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > > > > > Add an event which would be used for notifying changes in the
> > > > > > > > > LMB modules' memory map. This is to be used for having a
> > > > > > > > > synchronous view of the memory that is currently in use, and that is
> > > > > > > > > available for allocations.
> > > > > > > >
> > > > > > > > The synchronous view problem only exists because we are duplicating
> > > > > > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > > > > > >
> > > > > > > The LMB module only concerns itself with RAM memory. If I understand
> > > > > > > correctly, you are proposing maintaining the EFI memory map within the
> > > > > > > LMB module ? That would mean handling memory types other than
> > > > > > > conventional memory in LMB.
> > > > > >
> > > > > > I am pretty sure I've asked this before, but do these *always* need to
> > > > > > be in sync?
> > > > > >
> > > > > > The efi allocators will call LMB now. So when we allocate something
> > > > > > gtom EFI, even if any potential changes from LMB haven't been
> > > > > > published to EFI, we won't have any memory corruptions. Can't we just
> > > > > > opportunistically update the memory map once someone requests it?
> > > > >
> > > > > I have given this a thought. Because what you mention, Simon has a
> > > > > similar comment. But to achieve this, it would require generating a
> > > > > new efi memory map afresh every time such a requirement comes up. This
> > > > > would mean, create a new memory map, put in the conventional memory,
> > > > > and add other memory types that were part of the existing memory map.
> > > > > And then remove the older memory map. This would need to be done every
> > > > > time a memory map is needed to be generated. And that would also
> > > > > include instances when a user enters a command to get the current
> > > > > memory map. I think notifying any changes to the lmb memory map to the
> > > > > efi memory module is easier, and less error prone.
> > > >
> > > > We need to get some agreement on my memory-allocation patches first. I
> > > > don't believe we are on the same page on those, despite some weeks of
> > > > discussion. We need to resolve that issue first. I did try right from
> > > > the start to first agree on the problem to be solved. We skipped that,
> > > > so now we are having to do it now...
> > >
> > > These patches are currently under review. But fwiw, I think you are
> > > aware that these patches are not related to what your patch series is
> > > attempting. Your patches are related to the efi_allocate_pool()
> > > function, whereas this series is trying to use LMB as the backend for
> > > allocating pages, as requested from efi_allocate_pages(). So these are
> > > not related. But like I said, you are aware of these details :)
> >
> > The thing is, if we actually tidy up the EFI allocations then there
> > will be no use of allocate-pages before the app starts. So we won't
> > need to 'sync' the two different sets of memory tables. There will
> > just be one.

The issue is, again, that we never actually identified the problem to
be solved at the beginning. So we are suffering somewhat now from a
lack of clarity. But in any case, let me try to respond to the points
you raise.

>
> How do we get rid of using efi_allocate_pages() in U-Boot ? This
> function is used, among other things, to allocate memory used for
> loading images to memory. This can be a significant amount of memory.
> Are you proposing using malloc() even for loading EFI images ?

We actually don't use efi_allocate_pages() to load things into memory,
or at least I hope we don't. We should be using lmb. No, we cannot use
malloc() for loading images as the region is quite small on many
boards. Heinrich mentioned it can be as small as 1-2MB on some. Also,
it isn't really what malloc() is designed for.

>
> Moreover, the syncing of the memory maps is currently needed primarily
> as we support printing the EFI memory map through a command. And I
> mentioned in one of my earlier replies that not syncing the changes in
> the LMB memory map with the EFI module would mean that the EFI memory
> map would have to be generated afresh whenever there is a need for the
> EFI memory map -- this would be either when requested from an EFI app,
> or when a user asks through a command. Re-generating the EFI memory
> map is not a trivial task, and syncing the changes in the LMB map as
> and when they happen is much easier.

Yes I have seen you make this point and I am sorry I didn't reply
directly. The thing is, we don't care about the EFI memory until we
boot the app. After all, it is only the app that actually needs it.

I see that 'efi_init_obj_list()' is called by the efidebug command, so
yes, it should show the memory map.

But in my view of the world the memory map (before an app boots and
does what it likes in terms of allocations, etc.) consists solely of:

1. U-Boot's memory (malloc() space, code, bloblist, stack,
arch-specific stuff, etc.)
2. Images that were loaded (which are in lmb)

Since we need to handle (1) by manually adding records to the EFI map,
it isn't a big stretch to handle (2) with a for-loop through the lmb
records.


> > If I were confident that we could apply your series and then clean it
> > up later, I would be fine with it. But given that my two series have
> > sat here for a considerable period of time and are still not really
> > making progress, I lack confidence.

Regards,
Simon
