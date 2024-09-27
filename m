Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72793CEBF95
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 11:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE70890E9;
	Fri, 27 Sep 2024 13:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HfD53VCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9DB890EA; Fri, 27 Sep 2024 13:01:20 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF68D890BA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 13:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365c512b00so2563666e87.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727434877; x=1728039677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYRw6qI0g79qCSRqIi2D8jKaYiIafh1hZ+ehaXSEuoo=;
 b=HfD53VCv0HXXEf4/FT7U2KieO/Yt3CShlvXBKnaouiouSf41a1ooUzXaklHWsbNCPY
 QmMbU31XcL7i1I6v5rPhruiAvsEjaTj8bnYVF26nBrgdvWHJ9lLUYglJxcL6BoFj7jIw
 ISYMs1Mab4CrUH/6mP3o59b8oasYi/H9pyM26zDc99Sfo042Kj1G16IbpgktKXt8ylxi
 4Rw5rdkebRkM0cRBDPLlfxZiTREJpJNBELcTWiF4kED0HUESco8mc7dsZ5E7qqmTlJ+W
 YkVrlclHUIqSl+PwayU1AGE6Ubl0FDrUJ57o4/WxQSLZhwPtkkpK7VHDlkVdwkDpOZAf
 +mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727434877; x=1728039677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYRw6qI0g79qCSRqIi2D8jKaYiIafh1hZ+ehaXSEuoo=;
 b=GoIVEn9dmxbl27Y1i8mms4lxGSPunz+T1cIuT9vx1NeFMvMtT+OrxJ6qbYSYQWMKY0
 xLGUtpatG+qISJq4n8j7I1uhqr9ibNB7OvbQ+yjqgf2GXKwgxrmZgkY/UqnnLvTwjJI4
 lPn7nwhmxpgTR5LteiS4Fd7bMtkwXqrOBMi3zOp/Bz7+vXq0wx6CL5/3pX5CTxAFLHtN
 /FFxsS4ZxKAd3iMSew0tjc2pYG+iLZpXp0TD6ESppDgTes5a6KcsD30cGENQYAKxSlkR
 HB6IY9awZzk+P7NgOOTsFrrrh1Ct57c0qajxklQWpvsLCQju5H4OJ11a+Eame6qhuvF3
 6RvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM4GNlXRp/UitLNbqWnT1m1J9OaIrrwd8bf/mxiKq9ShNozmndT7tj4R/b/hiOv/V2ZEDtrxk=@lists.denx.de
X-Gm-Message-State: AOJu0YyJicuc3czMb4FktlyyPyFPn4YsmhuGpOmvwl8uyFjRCVmnDX85
 3uR8zg2wp0n+5aJOmGnH8cmiZNOCbXwFdPPVLY16xy2/xdlUMwEb1IOns95YUDKDCF2Ey/PRSQe
 HWuEFLg0DVmegxcymsHK6F+D/iY3tqNlSA0hUYA==
X-Google-Smtp-Source: AGHT+IGR1jJGpKr5ocZbcFRCTG2hDD9sZiJCR0tSl82iTWErfYgAXVZ6AaxFm0ACWZnvY00YM1bGZShyf3bo8eTsI8g=
X-Received: by 2002:a05:6512:4004:b0:52e:74f5:d13 with SMTP id
 2adb3069b0e04-5389fc44010mr1668642e87.30.1727434876795; Fri, 27 Sep 2024
 04:01:16 -0700 (PDT)
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
 <CAFLszThCXoHkOM5cOGmbrQvVnTARNUsZyN=NH_+JBi-pB=XK6g@mail.gmail.com>
In-Reply-To: <CAFLszThCXoHkOM5cOGmbrQvVnTARNUsZyN=NH_+JBi-pB=XK6g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 27 Sep 2024 16:31:05 +0530
Message-ID: <CADg8p9441xGZ9qBzojvxjLaEBy7abKo1RGxC_5VkuKwLO_N3mw@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Simon Glass <sjg@chromium.org>
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

On Fri, 27 Sept 2024 at 16:12, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 26 Sept 2024 at 14:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Thu, 26 Sept 2024 at 16:38, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 26 Sept 2024 at 09:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Wed, 25 Sept 2024 at 18:23, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Sughosh,
> > > > > > >
> > > > > > > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > > > > > > Add an event which would be used for notifying changes in the
> > > > > > > > > > LMB modules' memory map. This is to be used for having a
> > > > > > > > > > synchronous view of the memory that is currently in use, and that is
> > > > > > > > > > available for allocations.
> > > > > > > > >
> > > > > > > > > The synchronous view problem only exists because we are duplicating
> > > > > > > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > > > > > > >
> > > > > > > > The LMB module only concerns itself with RAM memory. If I understand
> > > > > > > > correctly, you are proposing maintaining the EFI memory map within the
> > > > > > > > LMB module ? That would mean handling memory types other than
> > > > > > > > conventional memory in LMB.
> > > > > > >
> > > > > > > I am pretty sure I've asked this before, but do these *always* need to
> > > > > > > be in sync?
> > > > > > >
> > > > > > > The efi allocators will call LMB now. So when we allocate something
> > > > > > > gtom EFI, even if any potential changes from LMB haven't been
> > > > > > > published to EFI, we won't have any memory corruptions. Can't we just
> > > > > > > opportunistically update the memory map once someone requests it?
> > > > > >
> > > > > > I have given this a thought. Because what you mention, Simon has a
> > > > > > similar comment. But to achieve this, it would require generating a
> > > > > > new efi memory map afresh every time such a requirement comes up. This
> > > > > > would mean, create a new memory map, put in the conventional memory,
> > > > > > and add other memory types that were part of the existing memory map.
> > > > > > And then remove the older memory map. This would need to be done every
> > > > > > time a memory map is needed to be generated. And that would also
> > > > > > include instances when a user enters a command to get the current
> > > > > > memory map. I think notifying any changes to the lmb memory map to the
> > > > > > efi memory module is easier, and less error prone.
> > > > >
> > > > > We need to get some agreement on my memory-allocation patches first. I
> > > > > don't believe we are on the same page on those, despite some weeks of
> > > > > discussion. We need to resolve that issue first. I did try right from
> > > > > the start to first agree on the problem to be solved. We skipped that,
> > > > > so now we are having to do it now...
> > > >
> > > > These patches are currently under review. But fwiw, I think you are
> > > > aware that these patches are not related to what your patch series is
> > > > attempting. Your patches are related to the efi_allocate_pool()
> > > > function, whereas this series is trying to use LMB as the backend for
> > > > allocating pages, as requested from efi_allocate_pages(). So these are
> > > > not related. But like I said, you are aware of these details :)
> > >
> > > The thing is, if we actually tidy up the EFI allocations then there
> > > will be no use of allocate-pages before the app starts. So we won't
> > > need to 'sync' the two different sets of memory tables. There will
> > > just be one.
>
> The issue is, again, that we never actually identified the problem to
> be solved at the beginning. So we are suffering somewhat now from a
> lack of clarity. But in any case, let me try to respond to the points
> you raise.
>
> >
> > How do we get rid of using efi_allocate_pages() in U-Boot ? This
> > function is used, among other things, to allocate memory used for
> > loading images to memory. This can be a significant amount of memory.
> > Are you proposing using malloc() even for loading EFI images ?
>
> We actually don't use efi_allocate_pages() to load things into memory,
> or at least I hope we don't. We should be using lmb. No, we cannot use
> malloc() for loading images as the region is quite small on many
> boards. Heinrich mentioned it can be as small as 1-2MB on some. Also,
> it isn't really what malloc() is designed for.

So you are proposing using lmb for loading images. And that is
precisely what this series is doing -- changing the
efi_allocate_pages() function so that it calls the lmb API's to get
the memory. So then I wonder why are we not on the same page ? Yes, I
understand that you have a differing view when it comes to
efi_allocate_pool(), but the changes to the efi_allocate_pages() done
in this series are exactly what you refer to above.

>
> >
> > Moreover, the syncing of the memory maps is currently needed primarily
> > as we support printing the EFI memory map through a command. And I
> > mentioned in one of my earlier replies that not syncing the changes in
> > the LMB memory map with the EFI module would mean that the EFI memory
> > map would have to be generated afresh whenever there is a need for the
> > EFI memory map -- this would be either when requested from an EFI app,
> > or when a user asks through a command. Re-generating the EFI memory
> > map is not a trivial task, and syncing the changes in the LMB map as
> > and when they happen is much easier.
>
> Yes I have seen you make this point and I am sorry I didn't reply
> directly. The thing is, we don't care about the EFI memory until we
> boot the app. After all, it is only the app that actually needs it.
>
> I see that 'efi_init_obj_list()' is called by the efidebug command, so
> yes, it should show the memory map.
>
> But in my view of the world the memory map (before an app boots and
> does what it likes in terms of allocations, etc.) consists solely of:
>
> 1. U-Boot's memory (malloc() space, code, bloblist, stack,
> arch-specific stuff, etc.)
> 2. Images that were loaded (which are in lmb)
>
> Since we need to handle (1) by manually adding records to the EFI map,
> it isn't a big stretch to handle (2) with a for-loop through the lmb
> records.
>
>
> > > If I were confident that we could apply your series and then clean it
> > > up later, I would be fine with it. But given that my two series have
> > > sat here for a considerable period of time and are still not really
> > > making progress, I lack confidence.

So the difference here is, unlike the way the LMB memory map gets
stored and shown, i.e. a separate entry for the total available
memory, and then a separate list of currently allocated entries, the
EFI memory map storage is designed in a different way. The
conventional memory, which is the DRAM memory gets added first, and
that is then followed by carving out the different memory regions
which are being used, e.g. the U-Boot's memory, and other memory
regions that have been requested. So if you try out the 'efidebug
memmap' command, you will see a single list of memory regions, which
includes the conventional memory, and other reserved memory regions.
Although I did not come up with this design, I suspect that it is the
way it is because the EFI memory map is not dealing only with
DRAM/conventional memory, but other possible memory regions as well.

What this means is that syncing the EFI memory map in the manner that
you propose would mean that the entire EFI memory map would have to be
re-generated, as the carve-out's (reserved memory regions) might have
changed. Please also note that, apart from the added complexity, we
are also going to be worse off from the size impact point-of-view.
Especially if we consider Ilias's review comment of doing away with
the event framework, and directly calling the efi_add_memory_map_pg()
directly.

-sughosh

>
> Regards,
> Simon
