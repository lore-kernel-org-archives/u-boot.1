Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01AAC54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA40F88A27;
	Tue, 27 Aug 2024 21:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BRlIIzer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDC888A74; Tue, 27 Aug 2024 21:25:17 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2455888C1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-498dccd3ce1so1852952137.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724786714; x=1725391514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v34+u9/zq8MPMfG5zjz/vRNf0DrFxtg1lcLU/SfoGfU=;
 b=BRlIIzertg/U8M0osbC4kNACihHhtIVdMBtBHjSJFwjgwmh9p/Y6LPyq3pDt71NkZ2
 RxxwG7DplLV6RTmasbMg4qxdVH7Ga3bLQnWx38TviYdKw509/32JpHBklOBKmwF5VWgW
 YIpQ9ZByXSLVs+uVdj3kVBPLMzsxCZZHjVFHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724786714; x=1725391514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v34+u9/zq8MPMfG5zjz/vRNf0DrFxtg1lcLU/SfoGfU=;
 b=X4WTaUePiiyGA6RcCT7FBjkJ+gKsE/LMSPEm2t6AVzM6Le4+ImjD39ZMeF3peSYRYS
 8N6Qhqlb1legf9+FNk5KuvzSEREcH2aElFuFu7VsCkwRX/FvfMbrO8kDY7rT71ZjRl18
 CvShS1aX1yLq+C4eSda8XJPFdqb09TRKAJXOY30kYlpo30pOJgJ+qLvNxRiYRARTjacd
 S22esnZrgQ0Cttg/mPYzMtVDTXqaOrP12/4Gf+ORaNbeGZpVeWxDU2bi68G1mNQgPwjl
 0HOjzUv7Swr7pTFzvl0WOLpDYgLVy42eALrac0ekuXz99XHAeYO2yY6LaEcbxNFJ59Oc
 YS/Q==
X-Gm-Message-State: AOJu0YwmUhQCXlMXddSnmugUVVxToUdqxiZeq8mKhbwWmlnLHK9ttyuh
 jed1iqyEwYmjBEYb9AIDpyHvBHCdCkWSIWTxwo53FmfAbCVYF0DMHbtZEjoL540AMKFIP7LaipA
 Q8WLM3s5gVpzQoZqGE6zo5D4+cqZOeKSbxses
X-Google-Smtp-Source: AGHT+IFkdq2565cfPCvwIxtO+3GdlsRxjrJ7QE3H616Vf5RP+yH+Eth+nhJcU/0p45lEqizdF8FbmJpW/NqJgRTn5+k=
X-Received: by 2002:a05:6102:2ad0:b0:497:1b98:1f82 with SMTP id
 ada2fe7eead31-49a3bb62257mr5095944137.6.1724786713646; Tue, 27 Aug 2024
 12:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
 <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
 <20240823210723.GY1626301@bill-the-cat>
 <CAFLszTirvuCkhb7BTj84Y3oNey34fmi=+V=fFTwb73rV428i=Q@mail.gmail.com>
 <20240823214940.GC2479150@bill-the-cat>
 <CAFLszTh5JTmtm55TrHTpHSjYPzGSyxBVOa8hG=yUVfPg1y3jsw@mail.gmail.com>
 <20240826183318.GL2479150@bill-the-cat>
In-Reply-To: <20240826183318.GL2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Aug 2024 13:25:03 -0600
Message-ID: <CAFLszTh-gRK-3eTeF3rvNJ5yO5=X87Bgx7u8ND1rERiMq7_b_Q@mail.gmail.com>
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 26 Aug 2024 at 12:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Aug 23, 2024 at 05:30:48PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 Aug 2024 at 15:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Aug 23, 2024 at 03:44:45PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 23 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Aug 23, 2024 at 02:30:04PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > The early malloc region is normally quite small and is certainly less
> > > > > > > > than 4GB, so use a 32-bit value for the limit and pointer. Update the
> > > > > > > > comment for clarity while we are here.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  arch/arm/lib/bdinfo.c             | 2 +-
> > > > > > > >  common/board_r.c                  | 2 +-
> > > > > > > >  common/malloc_simple.c            | 7 ++++---
> > > > > > > >  common/spl/spl.c                  | 4 ++--
> > > > > > > >  include/asm-generic/global_data.h | 6 +++---
> > > > > > > >  5 files changed, 11 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > This breaks booting on am64x_evm_a53 which is an odd platform that does
> > > > > > > SPL->SPL->U-Boot.
> > > > > >
> > > > > > OK, I can repeat that on the Beagleplay in my lab. I sent a v3 patch.
> > > > > > Thanks for bisecting.
> > > > >
> > > > > Oh good, beagleplay is run after the EVM in my loop and so I didn't see
> > > > > it was broken there too.
> > > > >
> > > > > > I'd love to be able to push trees to gitlab and have them run on my
> > > > > > lab. I think you said that the patches[1] break your lab, so let me
> > > > > > know if there is anything I can fix.
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=420392
> > > > >
> > > > > Well the good news is that I've got the tests running again here, and I
> > > > > think I mostly understand where the challenges will be in updating this
> > > > > lab to a newer labgrid version and so being able to migrate it to on top
> > > > > of your patches. The challenge next will be time. Likely the next steps
> > > > > will be splitting out your serieses in to test fixes and labgrid
> > > > > implementation details.
> > > >
> > > > I just sent v3 of the u-boot-test-hooks series. That needs to be in
> > > > for Labgrid to work.
> > >
> > > Yes, thanks. It reminded me how far apart what you have is from what I
> > > have, for labgrid.
> >
> > Oh...is it posted somewhere?
>
> I posted it in response to your other lab grid series at various points.
> At this point there's not much too it because it's just one-liners more
> or less like:
> $ cat console.labgrid
> exec $LG_CLIENT -c $LG_ENV console
>
> and so forth (and LG_CLIENT shouldn't be abstracted honestly, it should
> just be labgrid-client).
>

OK I see

> > > > The only other series is [1] which makes the integration nicer, but is
> > > > not necessary. That makes sense since we still want the lab to be able
> > > > to test older commits.
> > > >
> > > > From that series patch [2] fixes a problem which breaks pytest runs,
> > > > since without it, pytest gets a double echo of a few of the characters
> > > > of the first command it sends. It is a pretty annoying problem which
> > > > took a while to figure out. I tried very hard to fix it without
> > > > patching U-Boot's pytest code, but I gave up. One thought I just had
> > > > is that it is possible that setting up the terminal in the
> > > > u-boot-test-console script might work most of the time, i.e. before
> > > > calling Labgrid.
> > >
> > > I know with previous iterations of all of the test cleanups and changes
> > > you did, my non-labgrid lab also started failing immediately. Keeping in
> > > mind that today I run all of the pytests on a few hardware platforms,
> > > both with and without labgrid, I need to see what changes you've done
> > > lead to what behavior changes here, and then eventually get things
> > > boiled down to just the your labgrid implementation specific parts, and
> > > see how to work with them, or if it's too far away from the rest of my
> > > use case.
> >
> > It might have been that it stopped running conf.xxx files...I fixed that in v3.
> >
> > OK, I will wait to hear.
>
> It was I think a lack of the new top-level scripts being present, I
> think. We might need to re-work that part of the series to be 3 parts,
> where release.none/u-boot-test-release are added in preparation for
> adding the labgrid specific one.

Yes that will help.

I think I have a simple way to keep both things working at the same
time, so let me try again with that u-boot-test-hooks series.

Regards,
Simon
