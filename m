Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3484CD98DC
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 20:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408A58404D;
	Thu, 13 Nov 2025 21:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RMcgKcnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A9F8404E; Thu, 13 Nov 2025 21:29:11 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017658403D
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 21:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b72dc0c15abso218535066b.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763065748; x=1763670548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eO3wEPM8YxqZYHg+oEUkPx6Q71QQ4IMTNhnTiNbRlGI=;
 b=RMcgKcnW+zbZW4oHiTTaWdljsYeqXPPdlm2y4EF3QOua/x1HWTcsvQvVEcoUxPggRb
 mBBkKDoPknwTcck31EORPpNklpzPq44XJ0lQP+wOGbLL6ovilG5JZ5Ma/3P3FONRqI9f
 4JsySsWOyyiZvFh9sFkzv7CUJ3T3XZ0rkboPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763065748; x=1763670548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO3wEPM8YxqZYHg+oEUkPx6Q71QQ4IMTNhnTiNbRlGI=;
 b=IYSvRU/PsrQ5O0EOklLpwZF8/OXyWgTpWgejKRSb23F4APQT//QUtZmxIcCs1zZrLQ
 kh3lVhGfF1d/5XxBJC/1K46BQpb0jqHXWlOZbG4qJGLwQi1whEVxXLk+ivhcl7fykYM3
 HJgQ1N9fBN8MG4qI0RbiR70cbVx9ND5M1d+ZLjZFGc8dc3h4twL6BG99+bTPnpT+yKz3
 KJOikUkJCdQVFjoYVmHj5PBUAykZq795gHkCtE5fklvqwUiwAUPiZwJDmk4CDuGp2bhd
 U//b6Xx95u4Pgg1VTrQ7yjmsH8QSPPtQPv/sv1Yuv6De8tqdcY9HsNBWdDKt34/Z/0PZ
 nhVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwnkmXtFhx8oau85ENIZQfSEoHOA/zdkmR500lUnt1VSWLcxRFF7ssP/Q7XeuXsmKXGaevnIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyzLxEtOUA8W3s2Vc+7kI6kx/0ACLcJ0tBfB/Nlps6iIy2npHJH
 owY7WfZSns6W43tuKc9Bpnt7WmzHdJnKPhNHwlTLv5vBrLwdQD7j6Dzjdsajdu4GlYohCSqhQ2K
 7/+D893I+26Cq43tFoeK7hDs5bYTMGDj/6T0JFUxC
X-Gm-Gg: ASbGncvokxp6h78zhjwmAr92a1uSTigccF3k5ws2FH7kYMKW54+NS1lBy/K6aVyAF69
 dzEco4EQ5thmU42XU6NbgcG+avYx0Hq6aGLB0KTWI3stj0SVhpw5qq2NcNjnYUcPvkKLV3gUV6W
 5z07MZnaPRCTxekkPEx29V/mHGYLw2MhXaYTuDL0WGiTq982P4c5bO+8mYkXhMMyKahjTIhDWqF
 7hN73xqBAY2KxUjfpR6Zdz/CcvXMNqaE7oUEiBKfFV7FZ/1a4CPTNhfQAi968SIBUP+zg==
X-Google-Smtp-Source: AGHT+IEE8W5ZC9dXtpivb087GvflaEg7/wakLVotFaWy4Zk1kco1HfyEwjYLHj5yLmZ28/IruYQSd+mwYYf1XlGRlxc=
X-Received: by 2002:a17:907:c1f:b0:b6d:7742:c20c with SMTP id
 a640c23a62f3a-b7367962718mr56323966b.36.1763065748378; Thu, 13 Nov 2025
 12:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
In-Reply-To: <20251113200527.GQ6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 13:28:56 -0700
X-Gm-Features: AWmQ_bmZVDFaZ-G3DYHfmOXaCyqeKy_NQwC1SLebhbl2pgERZMQZ1JtGz-drnM4
Message-ID: <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
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

On Thu, 13 Nov 2025 at 13:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 13, 2025 at 12:57:30PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 13 Nov 2025 at 12:38, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 12:33:24PM -0700, Simon Glass wrote:
> > > > Hi Marek,
> > > >
> > > > On Tue, 11 Nov 2025 at 18:17, Marek Vasut
> > > > <marek.vasut+renesas@mailbox.org> wrote:
> > > > >
> > > > > Newer versions of libfdt strictly check whether the FDT blob
> > > > > passed to them is at 8-byte aligned offset, if it is not, then
> > > > > the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> > > > > android_image_print_dtb_contents() passed FDT directly mapped
> > > > > from abootimg to libfdt, and this FDT is not always aligned to
> > > > > 8-byte offset. Specifically, the FDTs are somewhat packed in
> > > > > the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> > > > > long, then the next FDT blob ends up at 0xfd offset, which is
> > > > > not 8-byte aligned.
> > > > >
> > > > > Fix this by first extracting the header into 8-byte aligned buffer,
> > > > > checking only the header for validity, and then by copying the
> > > > > entire FDT into newly allocated 8-byte aligned buffer. While this
> > > > > is not efficient, it is the correct way to handle DTs, which must
> > > > > be at 8-byte aligned offsets. Mitigate the inefficiency for the
> > > > > common case by checking whether the DT might be 8-byte aligned and
> > > > > if it is, map it directly.
> > > > >
> > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > ---
> > > > > Cc: Aaron Kling <webgeek1234@gmail.com>
> > > > > Cc: Eddie Kovsky <ekovsky@redhat.com>
> > > > > Cc: George Chan <gchan9527@gmail.com>
> > > > > Cc: Julien Masson <jmasson@baylibre.com>
> > > > > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > > > Cc: Nicolas Belin <nbelin@baylibre.com>
> > > > > Cc: Sam Day <me@samcday.com>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > Cc: u-boot@lists.denx.de
> > > > > ---
> > > > >  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-----------
> > > > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > > > >
> > > >
> > > > OK, we need to adjust mkimage etc. to handle this. Until then I think
> > > > we should have a way to disable the 8-byte-alignment check as it seems
> > > > to have an enormous blast radius :-)
> > >
> > > We can't. We really can't. Passing misaligned device trees results in,
> > > and has already resulted in for years:
> > > - Silent Linux crashes
> > > - When Linux doesn't crash so many of the read functions go wrong the
> > >   result is incomprehensible.
> > >
> > > It's something that has and continues to waste untold engineering time.
> > > The only reason it's not worse is that we've killed off *most* of the
> > > platforms that disabled device tree relocation and that's how
> > > misalignment happens downstream most often.
> >
> > That's fine, but making the devicetree aligned for Linux is pretty
> > simple. We generally relocate it before booting anyway.
> >
> > But that's not what I'm seeing here. It seems to be updating U-Boot to
> > deal with a libfdt change. That is also a worthy goal, but we need to
> > consider code size and where best in the stack the changes should be
> > made. Doing a memalign() at the last minute is just not a good idea.
>
> Yes, the device tree specification, not the OS, says that it must be 8
> byte aligned. We've needed to do that for ages. Not doing that is not a
> good thing, for U-Boot, internally. The same APIs that blow up in Linux
> (or anything else) with misaligned device trees will blow up in us too.
> We need to make sure we pass ourselves something aligned correctly.

Yes, agreed. It has been sort-of half done for a while.

> Which is different from disagreeing with your specific feedback about
> how we get there, to be clear.

Regards,
Simon
