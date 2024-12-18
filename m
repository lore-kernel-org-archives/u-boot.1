Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD52E77184
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 01:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD73A80214;
	Wed, 18 Dec 2024 02:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Su5ISpyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20878022E; Wed, 18 Dec 2024 02:47:12 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8DB801CE
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso828669766b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734486430; x=1735091230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4khZYoReIso6RJAmvpcmWtN5PiMp0+HL8tbmD/Jeq34=;
 b=Su5ISpyvDTyXET4FhBRgeJJZ64Srfpoo9j0u86VlpBuJyfR5rFZeA6KjMNzGuWkKNa
 KSg065H8REjVvUjbAwHZQ53CZirG9yt6RPrnA1ZjvWycMuLtAGaHInsn0F9hvNApgbnA
 sj+EAMdC206WmoFL+vCnUq9d0C43ulY0rVZhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734486430; x=1735091230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4khZYoReIso6RJAmvpcmWtN5PiMp0+HL8tbmD/Jeq34=;
 b=QjpCAa8PNpPznYLWBGlhfE5qfiHWECW0KBGcmzKk26rV8IWQkhrvAB4sYjgW2PpL7x
 iD1lDZw2V0eqEAgFHTJ8HBnvzm3Rv63fFjIk/9FqnAagpF+0avxaojfFnnFoWmcFbs9W
 YSH8iGQ/tdscZSLAHYK6HFaysJKDP6hWfV2oS2VGtL2SG8dbodK+wL1kfMpC8CSXh695
 RnG4FKhno7VZWdydav9wxVCdruD86WUwXIBS90Bpb0LAvMb/tjUTcwc15/U97pg+J13L
 /Ow9oNXwxkU6aau/Lv0NxdaVo1TPyHL9RNHq/vCFk3ALtZ1paJTKSc/PBX5bTGE0FSHF
 +4xg==
X-Gm-Message-State: AOJu0YyE+52npNgft0yQMwG/rI8TidTnb5eVHGzNfjkxFT3PiHMNWZQ+
 6WP0YvBSzzetnSEO30OiMwNzlcQrJRt5I6G2VhSyRUsbFoeoNzwdGyTkF1EivyEMrg6v8Me74K7
 5UcimlDiam+nhjqwaygYzIYBKigG8FQUis8hFRrNFlAGmmRo=
X-Gm-Gg: ASbGnctVS5qhfpV+uU3agaatPC115iJkmPzxL9TW20aZtfpwsWZZUMMK3CzzinYj6IM
 Ml4mmaVuJbfDRQH6KB+IZXpoVjBxQ3zGBNZKHYIk=
X-Google-Smtp-Source: AGHT+IFIHUd/v1Yt7dmic31k7KJmff8VwT246U/HQ9vw8ZyZ+nmV+HfEu8j7aNJt1485f5ujJYp7f7EHn+5roMXt4UY=
X-Received: by 2002:a17:906:309b:b0:aab:9145:30a8 with SMTP id
 a640c23a62f3a-aabf490fc62mr70214666b.50.1734486429607; Tue, 17 Dec 2024
 17:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
 <20241217040040.GJ1505244@bill-the-cat>
 <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
 <20241217201546.GS1505244@bill-the-cat>
 <CAFLszTh6euHToEvwF_Trmr0fhotxCVipj=wYafOkyx-6jujo-w@mail.gmail.com>
 <20241218001805.GW1505244@bill-the-cat>
In-Reply-To: <20241218001805.GW1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 18:46:58 -0700
Message-ID: <CAFLszTguOaXyZH3odnOVFx7Sk=sAv0Nq9g818AT2m08rxz6NrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Dec 2024 at 17:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 04:42:26PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 12:45:46PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 16 Dec 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > Introduce an option to control if we expect that a prior stage has
> > > > > > > > > created a bloblist already and thus it is safe to scan the address. We
> > > > > > > > > need to have this be configurable because we do not (and cannot) know
> > > > > > if
> > > > > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > > > > > > > on-chip memory and so it may or may not be safe to read from this
> > > > > > > > > address this early.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > ---
> > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Since this is the essentially the same as my OF_BLOBLIST patch, which
> > > > > > > > was rejected:
> > > > > > > >
> > > > > > > > NAK
> > > > > > > >
> > > > > > > > The issue is not whether some 'previous stage' set up a bloblist. For
> > > > > > > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> > > > > > > > that TPL set it up. But it doesn't mean that TPL put the FDT in there.
> > > > > > >
> > > > > > > This is wrong. The root problem is saying that the bloblist is in
> > > > > > > possibly uninitialized memory. The code is quite happy to NOT find the
> > > > > > > device tree in the bloblist and continue searching other paths.
> > > > > >
> > > > > > But until the bloblist is set up, it doesn't exist.
> > > > >
> > > > > An almost philosophical statement, yes. How should the generic code know
> > > > > if it exists, or does not exist? That is the question.
> > > >
> > > > U-Boot code 'knows', since if this is the first phase which enables
> > > > CONFIG_IS_ENABLED(BLOBLOST), then the bloblist is available
> > > > before/after relocation as well as after RAM setup in SPL.
> > >
> > > And when U-Boot isn't the first stage?
> >
> > The only case where that matters is for the devicetree, so we have
> > OF_BLOBLIST to control whether U-Boot looks for it. Eventually we can
> > drop BLOBLIST_FIXED and use registers, perhaps even on x86, which will
> > make things easier.
>
> The only reason it ever matters is if you're picking memory that's not
> always accessible. Which is a bad choice and should be avoided whenever
> possible and practical. Which it is here.
>
> > > > > > We should not be
> > > > > > looking for a bloblist that we know is not there yet. The bloblist is set
> > > > > > up by bloblist_init(). You seem to be imputing your own semantics for
> > > > > > bloblist.
> > > > >
> > > > > We don't know if the bloblist exists or not. That's the problem. It
> > > > > could already exist. That's the whole reason we're in this particular
> > > > > argument.
> > > >
> > > > See above.
> > >
> > > Yes, you seem to be missing the case where U-Boot isn't the first stage.
> >
> > I really can't see how you came to that conclusion. Just enable
> > OF_BLOBLIST - in fact we can enable it for almost all boards today and
> > it won't harm anything.
>
> I mean, there's very few places using BLOBLIST today. But we can't
> enable OF_BLOBLIST for any of them unless we say that the BLOBLIST
> exists in always accessible memory. And that wouldn't be most of them.
>
> > > > > > In SPL, init happens in board_init_r(), i.e. after RAM is set up. So don't
> > > > > > look in the bloblist until it is set up! It doesn't exist.
> > > > >
> > > > > Unless of course it was setup before. We don't know if it was setup
> > > > > before or not until we look. A big part of the problem is that for prior
> > > > > to U-Boot bloblist we don't need to use main DRAM, the bloblist is tiny
> > > > > and we have some other persistent memory available. Unfortunately, x86
> > > > > does not.
> > > >
> > > > The only situation where this matters is for the devicetree, which I
> > > > why i created OF_BLOBLIST, a way to indicate that the bloblist should
> > > > be checked for a devicetree.
> > >
> > > Yes, you keep looking at this from the wrong direction and seem to have
> > > backed yourself in to a corner. Why are you insisting that for the
> > > normal use case of memory infos and maybe display parameters we need to
> > > carve out a hunk of main memory? A bloblist is perfectly capable of NOT
> > > containing things. We can avoid having to care about what phase of
> > > things we're in too.
> >
> > Devicetree is the only 'strange' thing here because we need to look at
> > it early.
>
> Device tree is also "strange" in that it's the only thing we read (not
> write) today prior to U-Boot too from bloblist.
>
> > For Raymond's patch, it shouldn't need any conditions.
>
> Yes, and I replied to him that way too.
>
> > > > > > In U-Boot proper, we look for it before relocation, so we can relocate and
> > > > > > expand it for use with ACPI tables, etc.
> > > > >
> > > > > I'm not sure that's relevant. This means we've taken what we were passed
> > > > > at a fixed address and allocated more space for it and are using it
> > > > > somewhere else.
> > > >
> > > > Yes
> > > >
> > > > >
> > > > > > Take a look at this patch, too:
> > > > > >
> > > > > > 3d6531803e1 bloblist: Support initing from multiple places
> > > > >
> > > > > I'm not sure it's relevant. It does show we have a problem of not
> > > > > knowing if the bloblist exists, or not. And I don't think we're solving
> > > > > that right today (nor does v1 of my patch).
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > > An alternative here would be to better document the requirements of
> > > > > > > BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> > > > > > > someone is inclined to move DDR init in to TPL, or someone finds a
> > > > > > > non-main-memory address to use for BLOBLIST_ADDR or switches to using
> > > > > > > BLOBLIST_ALLOC.
> > > > > >
> > > > > > Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It cannot
> > > > > > do DDR init in TPL because the DDR blob is large (160KB?) and there is a
> > > > > > ton of setup to do first, in any case. When CAR goes away, its memory
> > > > > > vanishes, so you need to have copied the bloblist somewhere else (the
> > > > > > bloblist holds the MRC data which needs to be written to SPI flash later
> > > > > > on, when possible). This all works perfectly and there is really no need to
> > > > > > change anything.
> > > > >
> > > > > Ah, so there's some of the details finally. And oh goodness, we're
> > > > > writing to the SPI flash on each boot? That's not good for longevity...
> > > >
> > > > It writes a sector each time, across an area which can hold quite a
> > > > few writes. It only writes when the details change, so it is fine.
> > > > This algorithm has worked in the field for years across tens of
> > > > millions of devices and is common on x86.
> > >
> > > To be clear, I wasn't saying that its your design.
> >
> > No, it isn't my design, but I would be happy if it were. You were
> > suggesting it had a longevity problem, so I wanted to explain it.
> >
> > >
> > > > > > Again, you seem to be imputing semantics to bloblist which don't exist.
> > > > >
> > > > > Unfortunately some things were missed along the way, and are still
> > > > > missing.
> > > >
> > > > Well we should have started from OF_BLOBLIST and then dealt with
> > > > problems as they came up. In fact, so far there are no problems which
> > > > it can't solve.
> > > >
> > > > As it is, we have Raymond sending a patch to push the prior-stage mess
> > > > into TPM, for reasons which make no sense to me. It is just adding
> > > > confusion.
> > > >
> > > > One other thing we would have likely done by now if my patch[1] had
> > > > gone in a year ago, is moving away from BLOBLIST_FIXED to using a
> > > > register protocol. That is more deterministic.
> > > >
> > > > Regards,
> > > > Simon
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
> > >
> > > I think once again your obsession with OF_BLOBLIST and device tree is
> > > causing you to miss everything else. Today we can take a *bloblist* via
> > > register. Linaro wrote that, even. The next problem really is that we
> > > can't pass that bloblist along to the next stage because all of the
> > > U-Boot side of things assumes fixed address.
> >
> > Perhaps if we had applied OF_BLOBLIST a year ago, so my special 3
> > ancient chromebooks that nobody cares about or uses apart from me,
> > worked, we could have got bloblist to where it should be today. You
> > are missing the big picture, but stopping me from pursuing it.
> >
> > I am disappointed that it is only at this stage that you have shown
> > any interest in getting my special 3 ancient chromebooks running.
>
> And I am disappointed that it's only at this stage there's an
> understanding of what the actual problem is with your special 3 ancient
> chromebooks. Everything last year was read by me as you arguing that you
> need a way to control passing the device tree because that's where the
> device tree is:
> https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/#3174895
> And if not every at least most of your other replies in that thread are
> about how device tree is passed in. This is why I assumed that your
> boards were working after having a way to enforce that the device tree
> comes from bloblist.

That thread is crazy. I should have given up at v1. I wish you hadn't
assumed that and I am still a bit shocked that you did, particularly
after 4-5 revisions.

>
> So if there's some "big picture" about bloblist being delayed, it is
> because once again your vision isn't communicated to everyone else
> you're trying to work with and that is the big problem.

Yes, agreed, that is exactly the problem. I hope my tree will solve
that problem and everyone will be happier.

Regards,
Simon
