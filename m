Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06429E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DCB874B1;
	Wed,  4 Oct 2023 04:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMJ6OjrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A6C487479; Wed,  4 Oct 2023 04:12:28 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723DB87253
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-775751c35d4so113662585a.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385540; x=1696990340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJG1+BvMGeSNfoOE3lgM6u6FTPBOLyURxlj4yo1NPBg=;
 b=AMJ6OjrKvZjwK61MOQ0UuBWQdX3fjns0sEBj4L0E9JB6u4VGsbi++hFByRb1koYWBQ
 7V+qTAz91AUAjmzKG1fjDm/lTsxjQJlcock9Te8vWIMPxHaBkg8GZBUwd8+UrV38RxKN
 xRHzx9dg/QmAa9jbJgQXWgV16D3wu1OYwEGYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385540; x=1696990340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJG1+BvMGeSNfoOE3lgM6u6FTPBOLyURxlj4yo1NPBg=;
 b=WQpFqzZ6zcQAORsFT7k94qTQzHwHLkaXKHj4jez7y/0+Dx33zmdsN39ly3fmpe0xeR
 I0+C1ayiS1+jtVabK56CtntPG0eT+W1BAwA2zehFUZl3A/HtrLvn0zRmYx8DnWyE7reI
 6rnGT9IwhaHjD/jHOhanULC2ONyjJGZ13dBEK9txvwV7Oio0K2T2cllpLTyV5bDbGnBR
 3K704P2r9Qg9fLcpUN9wLM/fIeHECIBBgIESRovxUtrJ+d7dxUbazRaIu9KC92POh3F/
 mofH3IUbuKV7g6UjE5XlVn7odEHuW9lYGu4FkLiQpaRiY2Otil0a0HyFPfzU8lImUxto
 XtLQ==
X-Gm-Message-State: AOJu0YxXWJUh3riWBnTX5CV3Oxx5QNkBqXiQAn+T6QXf6qgwDob8wMWi
 L75e7tM1A7gkLYFjaU6+4a3flNOqDygK9xiQyssBQw==
X-Google-Smtp-Source: AGHT+IFYU8xGB9M6T9pEcUXU3J/SvFPa9tf9u+tC03iPkEocxNhVBywip9bEaXnUo1qWDAGZLzi95NVs08NIq/5ozlw=
X-Received: by 2002:a05:620a:c0e:b0:76f:1707:bfe with SMTP id
 l14-20020a05620a0c0e00b0076f17070bfemr1060741qki.66.1696385540456; Tue, 03
 Oct 2023 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <816e7ef3-681b-3b9d-48dc-e3e2ee415127@prevas.dk>
In-Reply-To: <816e7ef3-681b-3b9d-48dc-e3e2ee415127@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:05 -0600
Message-ID: <CAPnjgZ0xnRxz-Y_o5F73fPhWU6hAf8bKQ11GFaiaiZ2skD4V2g@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Rasmus,

On Mon, 2 Oct 2023 at 13:02, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 29/09/2023 18.02, Tom Rini wrote:
> > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
>
> >> Honestly at this point I've forgotten what this is all about.
>
> Fair enough, let me try to recap, though even a summary is a bit long.
>
> (1) I wanted to do what $subject says, and you seemed to be ok with that
>
> https://lore.kernel.org/u-boot/CAPnjgZ1B+3v_5rCSBnUgZ6cVO4odjjDfeS0rx3iMw4vjXUo0VA@mail.gmail.com/
>
> (2) Tom pointed out that, unfortunately, as-is, the patch caused a bunch
> of build failures. With hindsight, that was inevitable.
>
> https://lore.kernel.org/u-boot/c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk/
>
> (3) I still very much would like the original patch to go in, and so I
> pointed out that most of the current arch/*/dts/Makefile are actually
> completely redundant, with the logic in scripts/Makefile.dts being in place.
>
> This is when the thread turned away from talking about the original
> patch, but rather the cleanup of the makefile logic that turns out to be
> a prerequisite for said patch to go anywhere.
>
> (4) Tom tested a patch that nuked most of the arch/arm/dts/Makefile,
> which revealed a few defects, partly in Makefile.dts (got fixed in
> 6923f49d3ac2) partly in a board defconfig (got fixed in 2d158d3c387d).
>
> >> Perhaps the easiest approach is to create a new Kconfig to control
> >> whether a board-level .dtsi is included in the list of wildcard
> >> searches. Then you can enable it for your board without affecting
> >> others.
> >
> > That's getting things backwards, from what this cleanup does.  Today we
> > have messy lists of "build these device trees" and then don't use most
> > of them, and some of the list is just Wrong (listing dts files as an
> > output).
>
> (5) Then a few months passed. I'm still interested in the original
> patch, and also the cleanup. So I pinged Tom to redo that build test
> with most of the Makefile gone. While revisiting this and doing that
> mechanical strip-down of the Makefile, I noticed that the Makefile has
> grown not just one but two .dts files listed in dtb-y, which is of
> course bogus, and nobody noticed or cared because the
> scripts/Makefile.dts logic JustWorks.
>
> So, given that today, each board, in the form of the defconfig used to
> build for it, in 99.9% of cases already includes all the information the
> build system needs in order to ensure that all relevant .dtb files gets
> built [because there's only one and that's DEFAULT_DEVICETREE, or
> there's more and those are in OF_LIST or SPL_OF_LIST], and the Makefile
> is error-prone to maintain and when adding a new board one chooses some
> semi-random-list to add one's .dtbs (or .dts.....) to, we want to simply
> stop having all those lists in arch/arm/dts/Makefile (and the other
> arch/*/dts/Makefile, but those are much smaller and can be handled
> later). No TARGET lists, no SOC lists, no nothing.
>
> Yes, there may still be some 0.1%. We're trying to figure out if they
> exist, which they are, and how best to handle them. An easy fix is to
> drop the condition on when OF_LIST is settable to something different
> from its default (which is DEFAULT_DEVICETREE). But without knowing just
> exactly which boards and which .dtbs we're talking about, it's hard to
> know what the best solution is or if there is actually anything that
> needs to be done.

Thanks for all the details. My memory for things that last across
months is not good. It is clearer now.

I don't really see any specific problem with this.

It does seem duplicative though, in that each board (in a group that
differ only in their DT) has to have the same list. Why not have it
once, in the Makefile, based on ARCH_SOC...?

Perhaps I am unrealistic in hoping that much of the C code for a board
will go away, but we do see boards which don't have much / any code,
but do have hardware differences.

I would love to put a stake in the ground and say that boards that use
the same SoC should be able to use the same C code and work correctly,
just with a different DT. For example I think most/all rockchip boards
are like that. Then we might head closer to the kernel which can boot
on various boards with the same build.

It seems to me that heading the way you describe, we are making it
harder for people to do this, or even suggesting that it is not
desirable.

Anyway I will leave you and Tom to figure this out, since you seem
very keen on this idea. Thank you again for explaining it all.

Regards,
Simon
