Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A4AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 08:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C58180548;
	Tue, 18 Mar 2025 09:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jBfqhM/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A163805D7; Tue, 18 Mar 2025 09:32:43 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA1580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso405858366b.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742286760; x=1742891560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6pHcl2peZHY0pSZTS3c5S5ikqO5S9znICwA6rhpb4Io=;
 b=jBfqhM/WXibSFTalbJbYQE/yHFZx91xxSC6O09wBVjbHlL6SnXwpVWu7hsAvcPg+Lq
 X5U5Yug17KuQtygvYTTqips/GFSAn34cLs1aZ7t5yiOMlXpPzYN08vtJpWuWpzClkuQ0
 N8kDKcyqJucT3Wr/yFKFQrDunKaCXTBlgnAiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286760; x=1742891560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pHcl2peZHY0pSZTS3c5S5ikqO5S9znICwA6rhpb4Io=;
 b=FIa3FPxLpHeAXFB3EFTe80Ci5999tawe/6c/Xfj/vpwqHD7Wd8DtOTlHVlGHMeP9TN
 fjocGo5+ITDTmu0p0JtInD/fDeo0PRJT5zAnzcmTqQPtwzd0vZgWrMSlvOGnWdD3kZal
 IelAU/uj+wNaaNLI2DjP0gOPN4Hgbu6SBYb6I7LzAF5kgKWqS9NoSdG1wHjmDIXFYHze
 0Dsp1mv0bYjrxkNMu+BZJTl07FTaXaiXhc/oi82CNVShNn9mc5e8TIvnE4DJABqj6msv
 eSwDyKXk1TdYmaaI5IAkKkJuAewExVD7aVLzmWgsPl71uPZqS8mRHvq7N0iRamMvELK0
 TqaQ==
X-Gm-Message-State: AOJu0YyNeuEA0kz3cjueqOpBZ/uRtgYAbkWNQNc+tk6cPtaUGC2+2FEj
 v2BlTwd2gV2PObi334px2Suqhf8F7dGQeHGrRR2nQoCaGsFHeh/EezgW7CtouErLeJ19ePDstXs
 kBCBLkey+Sh2rqKlY8kTin1u5GcjHA1/3nUQ9
X-Gm-Gg: ASbGncubTlUA7HTVlwcNfg69XvZS14pRaBXwOmrItRkALgbzXaUXTLcrZ1iNHvob2In
 pKV8r8d6bxrWmeaCbAfsa+BjfK5ZotGee0tPozcUK8bCY3vGiOiqwxAMLDfbzxud7pxd8vsuV0/
 9grSKOsNlNGzOIneOUULUXeCsHBxk=
X-Google-Smtp-Source: AGHT+IGP2jUe5wXaXtY/8CkOtJD1Xys0f6rov2ANSY3c/KMmjJ76D6o6zSqsgeNaDDZjA9tw7Xlo3GfzuFrL0hE2ngM=
X-Received: by 2002:a17:907:9725:b0:ac2:723a:670f with SMTP id
 a640c23a62f3a-ac3301e6170mr1314416366b.24.1742286759850; Tue, 18 Mar 2025
 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
 <20250315135749.GI2640854@bill-the-cat>
 <CAFLszTjEONSErVbE0O5E0+izUDO8yFNZ+hwzvHjvx-nTczzeSQ@mail.gmail.com>
 <20250317230521.GU2640854@bill-the-cat>
In-Reply-To: <20250317230521.GU2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Mar 2025 08:32:27 +0000
X-Gm-Features: AQ5f1JrxNmr3KOSSAlVhqG1kt-hSf8HD0HCF9Rvt3q5mJ-iqH4Vt9y50q2JG3ag
Message-ID: <CAFLszThJTWD1hejKfr9TfQYJRCiMoVQufkB+4=3K9Vf+bEBPYg@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Rasmus Villemoes <ravi@prevas.dk>
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

On Tue, 18 Mar 2025 at 00:05, Tom Rini <trini@konsulko.com> wrote:
>
> [cc list trimmed and adding Rasmus]
>
> On Sat, Mar 15, 2025 at 02:38:29PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Mar 2025 at 13:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > > > > > > > is not perfect.
> > > > > > > >
> > > > > > > > With both builds, executing the VESA ROM causes an intermittent hang, at
> > > > > > > > least on some AMD CPUs.
> > > > > > > >
> > > > > > > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > > > > > > > is done in a way that works on real hardware but not with QEMU. This
> > > > > > > > means that performance is 4-5x slower than it could be, at least on my
> > > > > > > > CPU.
> > > > > > > >
> > > > > > > > We can work around the first problem by using Bochs, which is anyway a
> > > > > > > > better choice than VESA for QEMU. The second can be addressed by using
> > > > > > > > the same descriptor across the jump to long mode.
> > > > > > > >
> > > > > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > > > > > >
> > > > > > > > In v3 some e820 patches are included to make booting reliable and avoid
> > > > > > > > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > > > > > > > support memory sizes above 4GB reliably.
> > > > > > >
> > > > > > > Do you plan to rebase the prerequisite series' this requires so that it
> > > > > > > can be merged?
> > > > > >
> > > > > > Here's my understanding of where things are:
> > > > > >
> > > > > > 1. You rejected the membuf series and my replies to try to resolve
> > > > > > that haven't gone anywhere yet. So your tree doesn't have any tests
> > > > > > for that code and still has the old naming.
> > > > >
> > > > > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> > > > > gratuitous summary of why the series as it stands is a step in the wrong
> > > > > direction. Tests are good. They're not a reason to pull an otherwise bad
> > > > > series. This series should be rebased to not depend on that series. The
> > > > > tests from the other series should be split out.
> > > >
> > > > It's not a bad series, unfortunately. I replied with my own comments
> > > > and I stand by them.
> > > >
> > > > I don't mind if you want to drop the #ifdef (which shows how a flag
> > > > could be used and the code-size impact). But other than that, I am
> > > > firm on this for now. I've already applied it to my tree and a membuf
> > > > implementation with tests and without a power-of-two limitation is
> > > > important for my current work on distros and expo.
> > >
> > > Well, you need to rebase this series without that then as I'm not going
> > > to take something another long time project contributor said was wrong
> > > and offered lots of constructive feedback on.
> >
> > It doesn't affect this series. It is for future work.
> >
> > We'll see if the LTPC replies to my concerns.
>
> Well, I guess I'm going to regret choosing to not chime in there at the
> time and say that no, working against your tree is the wrong direction.
> There's certainly enough feedback in that thread for you to make a v2
> against mainline.  Because to be clear, no, your v1 isn't going in
> mainline.

Firstly it does not affect this series, so I hope you can pull this
series in soon.

This is the first I've heard of a v2 for membuf. From my side I don't
want to rewrite it to use a different algorithm, nor force it to use a
power-of-two size. That was not the point of my series. Here is the
cover letter:

>>>>
The membuff implementation curently has no tests. It also assumes that
head and tail can never correspond unless the buffer is empty.

This series provides a compile-time flag to support a 'full' flag. It
also adds some tests of the main routines.

The data structure is also renamed to membuf which fits better with
U-Boot.

There may be some cases in the code which could be optimised a little,
but the implementation is functional.
<<<<

As I said, I'm happy to drop the addition of a compile-time flag. It
was mostly to see if anyone thought it was a good idea.

So how about just applying the first 7 patches? I can do a revert of
patch 8 in my tree. Then if Rasmus wants to rewrite it he can do so,
so long as the power-of-two size isn't mandatory.

Regards,
Simon
