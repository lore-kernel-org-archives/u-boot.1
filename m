Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE194C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CC1864BA;
	Mon, 28 Aug 2023 19:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eV47Jmag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1591B864CB; Mon, 28 Aug 2023 19:56:16 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B6286518
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58e6c05f529so43996997b3.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245371; x=1693850171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aNlkP/JYdxpuHICj3p32hkyfwtTEddLrXvcABtbgF5s=;
 b=eV47JmagulhuvTgEWWtVdscmoM+KyHIvDkrtkjhcly9RxND4zFV8rWr/wB/l2WD+GY
 mvvDKLhYzj8ZJEhN9k5bskV64MFeFq+spymdDuFgCqHugwsMtttly7e9r6lm4VrQ7mdV
 704mJXNremnISpcgYELNrt0EmCNSLVpln8oqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245371; x=1693850171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNlkP/JYdxpuHICj3p32hkyfwtTEddLrXvcABtbgF5s=;
 b=iQTj4O2lDqL7UFcrNJpGB5v/BjOVc14OeikjiALQxYNsF6jOIhvhjK7LKsOxFLZA3j
 CiKq9wCQ+FLQAEmdk2QK/x+qgYVGiinbo69zHiAZAL0+PnpJMn/v4IiuxlUWQUKr2jv4
 3Fxpt2sIHasUXPpGbue2KJBe1qg1wSQFQ9GPF+ten9b8JWnjsX20E7GFQZqJGNQaDFOZ
 YvPQSJq+eAevaPOYtlhX1vrQke5RxForXau7+o/X89ApJ+LBw2ZAB7W05Iky9VzS4u4f
 XnQj2Lc2m/Kv8XnLV5+DyqwLUoK9kaplgQuXblg2Aw+0uytBa2fjfOaRnHErVBty5xzS
 naJA==
X-Gm-Message-State: AOJu0YyGkpWR7PZkjL/UL9bBKWZdA2ixxjeegZ9wSkCX7bBSJ1JzamoC
 v55y4neUANEemD1ZQP2UQuhd3GnF9fhhVgVbduL5EA==
X-Google-Smtp-Source: AGHT+IE35yvKz4M6pytCHlG8151za7nyy+fUiFgc5wB7AynoJlTla1W1fPazv07VjNep6b3hjVffwQLNfLPKm6AAP6s=
X-Received: by 2002:a25:9288:0:b0:d0e:b924:8e20 with SMTP id
 y8-20020a259288000000b00d0eb9248e20mr23106408ybl.22.1693245370561; Mon, 28
 Aug 2023 10:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
In-Reply-To: <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:49 -0600
Message-ID: <CAPnjgZ2=tgDhXhm70RXcdXdJctJVqhO1vmH_==1N5YyzNH5cDg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Alper,

On Sun, 27 Aug 2023 at 09:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
> > Hi Alper,
> >
> > On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >> I actually want to put the root.img device first so that the VM can boot
> >> into the installed system when it reboots, but U-Boot can't find the
> >> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
> >> scan -lab`, but it seems to only ever search the first virtio-blk.
> >> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
> >
> > Yes, this is annoying.
> >
> > The problem is that the scanning is getting so complicated. The
> > boot_targets var lists things which can either be a uclass, or a
> > uclass with a device number. The currently implementation sees
> > "virtio" and moves on to the next thing in boot_targets once it has
> > processed one virtio device. That is obviously not correct, but...
> >
> > Would it be possible to just drop the 'boot_targets' var? That is what
> > is stuffing it up, but we don't actually need it now. The defaults end
> > up doing the same thing, apart (perhaps) from the strangeness of
> > virtio which can be both a network and a blk device.
> >
> > I believe it is possible to do the right thing, but I'll need to
> > create a better test mechanism to handle all the cases.
>
> I think some kind of a "priority score" could help -- iterate over
> boot_targets first just to generate bootdev priorities, then carry them
> over as bootflows are discovered (adjusted for bootmeth order), then use
> those scores as the order to boot / to show a sorted menu / to test?

We sort-of have that, in that bootdevs have a priority. We could add
something to struct bootflow which takes that but adds more
fine-grained information, e.g. based on some sort of filter function
that can decide?

Bear in mind that we normally want to boot the first thing we find,
and we also want to use lazy init (so no USB unless we need it). But
yes for the case where we display a menu I think we could make more of
the priority feature. What are you thinking of?

BTW, even for the menu, my original vision was that the menu would
display immediately, with new bootflows appearing as they are
discovered.

Regards,
Simon
