Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FE7C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9898678A;
	Thu, 31 Aug 2023 21:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lqBMp37o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D4B867D0; Thu, 31 Aug 2023 21:03:10 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC56F8678A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7bae413275so2711705276.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508581; x=1694113381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W1JFcX9WHWkg00QfiUkIuJ5AP7pHbxureKfxn25blLQ=;
 b=lqBMp37oZHiHbUFKCS4o6m1gTGepftmr59myfKOkQHRtGXH8foQ31AwxxKCU2GOMJI
 I/6eYjjyYObupIy/v1arfa37h3GUC17hCulMeXY219hxlnrzOcouISGiBG0+bqyM7c36
 mCJWQ4p5JuP1sMmvB4PudVzajW3oQdWXRbqx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508581; x=1694113381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1JFcX9WHWkg00QfiUkIuJ5AP7pHbxureKfxn25blLQ=;
 b=BUYe2Nm1QDjhtCxn2vvLHs2IDo/by7QJSUhc6VbQXbc8tVcwgxn0ig09EjFT1OBfs2
 kxN4s4xn5xBKqu0MHIGPQCl/SoBhnjJBFaMInt+5NX7HW7zHTsShlQWFnlz63uBjN8A3
 T8TBhnXAusIvpvZMinWbZC2wAeVumTlrnHjnrUmHZ0g7d54+kpK9QtyE0vZF1zUYRWOm
 UN441+wDHiAuH2N/Yoga+HwJzCJsMiv07cuKyxYYCcIy6EVwNtSn3gu5r5r+iz7Ryt5n
 V7nrZ4YxA/h4mx1pzlYewFiArtopWehweiUHbxXmi5NQzdaqR3XyVNh2zyDeW3UDwYnx
 wrBw==
X-Gm-Message-State: AOJu0YzM8E7oDryab7s244Yxkb84kpqaPK8KkCqEi1PqJS223Zh9uyMT
 CdMxqjtxWaCuZRSku4NEcKF5O17BoGe0cqXMWSxtnBF9g6YeL2JVBXY=
X-Google-Smtp-Source: AGHT+IGMLFEdbZGX9BHA++fQRCBTHqI5kHC9D9eUEcurq8dZ8sHKRu+fjsWvhoZSggkIBVywq+OtDXN1zZ5uDi5fXnc=
X-Received: by 2002:a25:c78f:0:b0:d10:6b39:b602 with SMTP id
 w137-20020a25c78f000000b00d106b39b602mr542315ybe.16.1693508581420; Thu, 31
 Aug 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
 <CAPnjgZ2=tgDhXhm70RXcdXdJctJVqhO1vmH_==1N5YyzNH5cDg@mail.gmail.com>
 <7dc5a62f-28e1-4318-a14a-53702c26a5c2@gmail.com>
In-Reply-To: <7dc5a62f-28e1-4318-a14a-53702c26a5c2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:01:56 -0600
Message-ID: <CAPnjgZ1dcCkKEqOhA4oeU-28NpP2=RYqGs6M-UZGXM5zBgYH1Q@mail.gmail.com>
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

On Thu, 31 Aug 2023 at 03:57, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > Hi Alper,
> >
> > On Sun, 27 Aug 2023 at 09:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
> >>> Hi Alper,
> >>>
> >>> On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>>> I actually want to put the root.img device first so that the VM can boot
> >>>> into the installed system when it reboots, but U-Boot can't find the
> >>>> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
> >>>> scan -lab`, but it seems to only ever search the first virtio-blk.
> >>>> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
> >>>
> >>> Yes, this is annoying.
> >>>
> >>> The problem is that the scanning is getting so complicated. The
> >>> boot_targets var lists things which can either be a uclass, or a
> >>> uclass with a device number. The currently implementation sees
> >>> "virtio" and moves on to the next thing in boot_targets once it has
> >>> processed one virtio device. That is obviously not correct, but...
> >>>
> >>> Would it be possible to just drop the 'boot_targets' var? That is what
> >>> is stuffing it up, but we don't actually need it now. The defaults end
> >>> up doing the same thing, apart (perhaps) from the strangeness of
> >>> virtio which can be both a network and a blk device.
> >>>
> >>> I believe it is possible to do the right thing, but I'll need to
> >>> create a better test mechanism to handle all the cases.
> >>
> >> I think some kind of a "priority score" could help -- iterate over
> >> boot_targets first just to generate bootdev priorities, then carry them
> >> over as bootflows are discovered (adjusted for bootmeth order), then use
> >> those scores as the order to boot / to show a sorted menu / to test?
> >
> > We sort-of have that, in that bootdevs have a priority. We could add
> > something to struct bootflow which takes that but adds more
> > fine-grained information, e.g. based on some sort of filter function
> > that can decide?
> >
> > Bear in mind that we normally want to boot the first thing we find,
> > and we also want to use lazy init (so no USB unless we need it). But
> > yes for the case where we display a menu I think we could make more of
> > the priority feature. What are you thinking of?
>
> For the priorities, I'm thinking of ChromiumOS boot flow where there is
> an in-method order that's different from the order we encounter things
> in. And I'm also thinking of customizing boot order for same-uclass
> device (I guess boot_targets="usb1 usb0" works?). And a bit worried

Yes

> about if we would want to mix and match orders. If we say methA > methB
> and dev0 > dev1, do we say methA-on-dev1 > methB-on-dev0 or the other
> way? Not sure if I make sense here at all, need to think more on it.

I hope not, but at least we have the data structures now and can do
these sorts of things.

>
> In general, what I want is a graphical boot menu like rEFInd [1], but
> more specifically with a better theme more like [2]. Or, at least to
> support rEFInd better. (More bugs here, upstream builds don't start at
> all with U-Boot, Debian builds boot on arm64 but not x86).

Could you implement that as a theme on the existing 'bootflow menu'?
It looks like you might be able to.

>
> Regarding lazy init. If we don't init USB, rEFInd can't search USB
> drives to boot things from it. Not sure if that's a fundamental problem
> or there's some way for EFI apps to tell firmware to init USB etc.

EFI sort-of has a fundamental problem here, I believe.

>
> [1] https://www.rodsbooks.com/refind/
> [2] https://github.com/bobafetthotmail/refind-theme-regular
>
> > BTW, even for the menu, my original vision was that the menu would
> > display immediately, with new bootflows appearing as they are
> > discovered.
>
> Shifting list elements around while people are choosing from the list is
> definitely not good, only way that could be OK is if the list was
> append-only and not centered-in-append-direction.
>
> We should be displaying a priority-sorted list, I'm not sure we can
> guarantee we will add things in priority order, and I would like things
> centered as personal preference...

Yes that is annoying, but all UIs do it these days. It is better to
display something, even if you have to move an existing thing. Two
other points:

1. The good news is that you are almost always adding at the end
2. This is often using the keyboard, so you can move the highlight
when you insert an earlier item

Regards,
Simon
