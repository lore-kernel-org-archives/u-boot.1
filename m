Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CA7C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2D688CC2;
	Wed, 25 Sep 2024 14:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/Iwu3XV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7194A88CAE; Wed, 25 Sep 2024 14:51:12 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6218A88CB9
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb2458774dso3227886d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268666; x=1727873466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gBLrw4jkZ3TKRiJZEQF9xltLkd6qGtQJ/PrPDbbaTpU=;
 b=e/Iwu3XVsUqTj1kRY7OK3Z3PtB8ek4A9k4H3frqJjGENWsCy8J+c+b+fFIB66oNHVN
 Zj//4UeeH2pGlZDlFj3WfyVI1fpbrCat1CvO/vR74kvgVRvIpCOY3kAQMF3FImaG0liD
 t9YaWrj449JZfnV/PiL3ztWhCpx+KBAscFXbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268666; x=1727873466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gBLrw4jkZ3TKRiJZEQF9xltLkd6qGtQJ/PrPDbbaTpU=;
 b=VUqq51jUPCRoF2JwjrdFJ96n1PXsvqXUh35TbAyhUJEVqYEah3EKE0jBXW/PcEJEcy
 8h4ISs1D1D5TBxhuRgStF4BGVW9XnzLz7k9e3fk9E1YKhb5DNe+lCsoZTscCGyyIr30r
 eWyS7fUr5HtFmbGtKL+PByf78DuvdWOpa28Yf8lhIPnZtn+Mt5FWZiQ/pmjUn/JloouA
 4J+HQAfptfSnoJHx2B8HuuGrJOgDKQToIqjm490wtiUrGgJpq3h3a+hI3ZxjcW+BKvVU
 Xf0y/boN2vPj6PM8bLYLSN0F6MyGlI5yoN/400DyP8VJwC5oyPxK1zTZE8WdGRUmq64+
 bsjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn568p8yL6hN7sl+2TXKbnCU6XikkfKmP92J81OqO89OEqguGe5/wlC57fALhYdDgwO+v/Jyo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx85bEkC3Pa615tLq3t0ctASDGkFhtsQOdH6ApFLDbTCMUqgUyQ
 U23R7jwGERZ7uF6EsBbg2/uRpkKW/kIMeBQn3plPc9VUVyvYvpxsL61v8yieAa27ywHCM7qp2WI
 kz4qCYp33+TmT6HwRr3YeQSHeDjQk/xbcJ+g7
X-Google-Smtp-Source: AGHT+IEy4UQOpKbSruUHaKNE3++T+MZt5Lgh2VACpPKdp9ZME/gKLRfUJGGWHT8djY0R5U0RjFpPzoAlw8k3ChjjCB4=
X-Received: by 2002:a05:6214:5548:b0:6c5:1a21:b8b9 with SMTP id
 6a1803df08f44-6cb1dd3fd26mr39184396d6.13.1727268666187; Wed, 25 Sep 2024
 05:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
 <20240830004936.GP2479150@bill-the-cat>
 <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
 <20240830014622.GQ2479150@bill-the-cat>
 <CAFLszThE7mrnOyGCzPcC01soCvoT++SgvUp4WpHiJZH4CXhWQw@mail.gmail.com>
 <20240920150136.GD4252@bill-the-cat>
 <CAFLszTjQAH-87Gv_VoXVRE77+foCm=Aq9WBev0PzTfM=Kyw99Q@mail.gmail.com>
 <20240920164031.GH4252@bill-the-cat>
In-Reply-To: <20240920164031.GH4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:52 +0200
Message-ID: <CAFLszTi-qU7-Do-erBtFBzweC4GtuRib7Rt==F44p7nvi=ib5g@mail.gmail.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Apurva Nandan <a-nandan@ti.com>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 huang lin <hl@rock-chips.com>
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

On Fri, 20 Sept 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 06:04:05PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 20 Sept 2024 at 17:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Sep 20, 2024 at 09:25:53AM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 30 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 29, 2024 at 07:06:32PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 29 Aug 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> > > > > > > > Hi Peter,
> > > > > > > >
> > > > > > > > On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > > This includes various patches towards implementing the VBE abrec
> > > > > > > > >
> > > > > > > > > What is abrec?
> > > > > > > >
> > > > > > > > It's a VBE method which supports A, B and recovery images and permits
> > > > > > > > updating from SPL onwards. The idea is that you can safely update
> > > > > > > > without bricking a device.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > bootmeth in U-Boot.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Simon Glass (18):
> > > > > > > > > >   sandbox: Add missing header file
> > > > > > > > > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > > > > > > > > >   gzip: Correct function comment for gunzip()
> > > > > > > > >
> > > > > > > > > Is this from upstream gzip code somewher?
> > > > > > > >
> > > > > > > > I'm not sure, actually.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >   fdtdec: Support separate BSS for all XPL builds
> > > > > > > >
> > > > > > > > Needed so that VPL can use DDT
> > > > > > > >
> > > > > > > > > >   tiny-printf: Correct return values
> > > > > > > >
> > > > > > > > I can't remember, sorry.
> > > > > > > >
> > > > > > > > > >   tpl: Support numbered aliases in device tree
> > > > > > > >
> > > > > > > > The MMC needs to be accessed using its sequence number
> > > > > > > >
> > > > > > > > > >   ram: Support driver model in TPL
> > > > > > > >
> > > > > > > > That should say VPL...but again I'm not quite sure
> > > > > > > >
> > > > > > > > > >   serial: Support debug UART in TPL
> > > > > > > >
> > > > > > > > This allows debugging of the jump from TPL to VPL
> > > > > > > >
> > > > > > > > > >   armv8: Support not having separate BSS
> > > > > > > >
> > > > > > > > VPL doesn't want a separate BSS since SDRAM isn't available that early
> > > > > > > >
> > > > > > > > > >   arm: cache: Drop a stale comment
> > > > > > > >
> > > > > > > > Just something I noticed
> > > > > > > >
> > > > > > > > > >   arm: Fix up a stale comment in sections.c
> > > > > > > >
> > > > > > > > Another thing I noticed
> > > > > > > >
> > > > > > > > > >   mmc: Support driver model in TPL
> > > > > > > >
> > > > > > > > TPL needs to read VPL from MMC
> > > > > > > >
> > > > > > > > > >   mmc: Add more debugging for SPL
> > > > > > > > > >   mmc: Log the error when init fails
> > > > > > > > > >   mmc: rockchip: Log some error returns
> > > > > > > > > >   mmc: rockchip: Allow clocks to be missing
> > > > > > > >
> > > > > > > > These all help with debugging reading of VPL from the correct MMC device
> > > > > > > >
> > > > > > > > > >   rockchip: mmc: Fix a missing colon
> > > > > > > >
> > > > > > > > Just something I noticed
> > > > > > > >
> > > > > > > > > >   rockchip: Provided SPL control over efuse presence
> > > > > > > >
> > > > > > > > We don't want this driver in TPL or VPL
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I'm not sure what most of these patches have to do with VBE?
> > > > > > > >
> > > > > > > > Basically there are a lot of little tweaks needed.
> > > > > > >
> > > > > > > Well, I think this gets back to some common feedback. You have a lot of
> > > > > > > little bugfixes, which is good, but they get sprinkled in to the next
> > > > > > > big series you post, which is bad and hard to review. And that leads to
> > > > > > > fixes not getting merged / reviewed timely because nominally simple fix
> > > > > > > A is in part 3 of a series to introduce something larger and to which
> > > > > > > there is feedback to work through.
> > > > > >
> > > > > > I actually thought I was splitting them up quite nicely. What do you suggest?
> > > > >
> > > > > I would refer back to your own comments about what some of the patches
> > > > > do and say that "Just something I noticed" should be a one off, and
> > > > > little fixes for this-and-that should be a 1-2 part series and so on.
> > > >
> > > > I really don't have a great workflow for keeping track of more than
> > > > 6-8 pending series and even that is sometimes a struggle. For testing
> > > > I need everything applied so I have every series in a sequence applied
> > > > locally.
> > > >
> > > > I will have a think about what can be done. I wonder how others do it?
> > >
> > > I believe the answer is multiple branches and merging them as needed. Or
> > > what I do is make each subsequent series a branch off the previous one
> > > (and set the upstream appropriately) and then rebase as needed.
> >
> > OK. That is my current workflow, but it can get out of hand,
> > particularly something like VBE abrec where over 100 patches in 6
> > -or-so different series are needed. I suppose that is why I keep
> > putting over doing the final two series...
>
> That should make re-branching things easier? Get your whole set of
> things in roughly good order then you can:
> git branch vN-fixes-foo commit-hash1
> git branch vM-fixes-bar commit-hash2
> ...
> git branch -u vN-fixes-foo commit-hash1 vM-fixes-bar commit-hash2
> ...
>
> And there's your series broken up and re-branched so you can have
> however many branches you need to split everything up in to something
> reviewable and mergeable in parts. Taking one of your branches that has
> everything and rebasing that on a new upstream commit that has some
> branches but not all merged should get things correct and drop the now
> upstream parts.

Yes, that's what I do. But I have no tooling to manage it, so it is
quite error-prone. I have a manual note of the series order, but as I
say, if it gets too large I just lose track.

Regards,
Simon
