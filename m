Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6C9C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AF880657;
	Wed, 15 Jan 2025 15:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jOhw77Xo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C85806FB; Wed, 15 Jan 2025 15:10:20 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFEC80269
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f796586so71333045e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736950217; x=1737555017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W7xOPc2sq06Nia6vGZDktuWlD93ltC9lfzJ5eyaM3Xw=;
 b=jOhw77XoizyThOFohwso44CequM9YNkIRbOxhZG+OYHmrwHPyr5EfpQfn4CUma6GaF
 poAE9r7EN+gq68oA9QuIul7PnRuV11o/gIDMU5/hAh4ssetrXWbGsvisFO3D8RD8RRWY
 veVXWLc/ZzwGBXGOQhc3I/BRMzoQEzMSEL7r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950217; x=1737555017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7xOPc2sq06Nia6vGZDktuWlD93ltC9lfzJ5eyaM3Xw=;
 b=gowhhurVf7v0e5pJMS7RWfpLJkyhc9qEngFWggidbmFYkOL/rtnY8z21zZvZXyVREu
 kicD/44qdHxfQA+R483MkO+KYcctfqLr+ReyXDIRHZcjAFx0GiPhJGxWg2EaMOYaf0fW
 NjVmiF2y4+AgJgJ2+vRiJdQK4uu0LCENliXkoUQW2gpCiBJeBp/goTxE5qVrB4CCmdT1
 D3xu+qf59kI5hPUdipL3MvZ+W4dfzHSRtGWDmp35hKtLvoxWXdm4ki/cmF8qxo4FtJr4
 +OeUAPgruj5644wXegCVCBxOSVbhCwFjNaovI9QiIK+11ZurGCp0UlKFScMvTW2zwGro
 bu9g==
X-Gm-Message-State: AOJu0YwGB3YCZLODWN93ws1J3ylB0VGYAZriNIWSbn7fW2lVwkuo3Aqs
 vmil2RMwTJOtBPdmuWYf/9mox1QOfa/qad+HqmS61vkEWjO74hsnKfZidvwK92sFOBLzsm95p6G
 LMmvpESdGNV7rZRBWRhmc5loDMxoFDcFEcJgR
X-Gm-Gg: ASbGnctWK80HZotrgj2EfcEQlUmhIGaTT8N8zGHsKUgDFu1nQar2b2mAiSoY6ONMB6a
 IcE6jqjQdA5MBFv/Izt9SVA2tHCf4+uri7s11ff8=
X-Google-Smtp-Source: AGHT+IG+CgHqJSBcxDA4It9j7qbOoj0VVMozWP3M9WeQAHQk0VyLzfm9Z/Po3gHzlVJfhbnEwK+Lv9HB1bHhumZwyBE=
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id
 ffacd0b85a97d-38a872fc1b3mr27956443f8f.10.1736950217210; Wed, 15 Jan 2025
 06:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
 <20250114165801.GJ3476@bill-the-cat> <20250114173343.GO3476@bill-the-cat>
 <CAFLszTi1epQ+6AGMK_pkjnTQmDU8--xS-NXfk5iM=q_wi6xyWw@mail.gmail.com>
 <20250115014121.GT3476@bill-the-cat>
 <CAFLszTjW-cpZn5haw-+4fmaFe==_fT+k4V5oBckHr_YbVaBeiQ@mail.gmail.com>
In-Reply-To: <CAFLszTjW-cpZn5haw-+4fmaFe==_fT+k4V5oBckHr_YbVaBeiQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 07:10:04 -0700
X-Gm-Features: AbW1kvbZbEJGMNwhYa66aW8kwFB9hqTu6izQ28Q1s30Skds0NLqitJy7hmIt2Js
Message-ID: <CAFLszTgY6mtFnLTd5xCb0Eh9Asv2Ww3WHMNf1XsgJk1EXiP3jA@mail.gmail.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

On Tue, 14 Jan 2025 at 19:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 14 Jan 2025 at 18:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 06:18:26PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 14 Jan 2025 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jan 14, 2025 at 10:58:01AM -0600, Tom Rini wrote:
> > > > > On Tue, Jan 14, 2025 at 05:58:04AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > Loading a FIT is useful for other VBE methods, such as ABrec, so start
> > > > > > > > a new common file. Add functions for reading the version and nvdata.
> > > > > > > > Also add a function to get the block device.
> > > > > > >
> > > > > > > This is not a good commit message when you're also introducing
> > > > > > > functional changes (blk_dread -> blk_read).
> > > > > >
> > > > > > Yes, I did not actually notice this size change at all, as mentioned,
> > > > > > as I only built for a few boards (firefly rk3399/rk3288 and a few
> > > > > > sandbox ones). The blk_dread() function is the old API for reading
> > > > >
> > > > > You have much faster build machines available than I do, it would be
> > > > > good to run a world build before/after (it might take an hour on
> > > > > alexandra) before posting these big series.
> > >
> > > OK. I used to do this, but with CI sometimes grabbing the machines it
> > > ends up with a huge load and sometimes runs out of memory. I suppose I
> > > can stop the runner before doing it and remember to restart it
> > > afterwards. Or perhaps Alex has enough memory per thread? (96GB).
> >
> > Personally, I would make the script that does the world build for size
> > test turn off the runner before starting and turn it back on when done
> > otherwise build time will suffer greatly and you would have been better
> > served doing it all on a slower class of machine.
> >
> > >
> > > > >
> > > > > > from a block. It didn't occur to me that blk_dread() would bypass the
> > > > > > cache.
> > > > >
> > > > > Yes, how is that happening? That's what doesn't make sense.
> > >
> > > OK, I see. It is actually one level deeper than I thought.
> > >
> > > PARTITIONS is not enabled, for example on phycore_am62x_r5_usbdfu
> > > which means that blk_get_dev() returns NULL
> > >
> > > So long as all the code is in one module, blk_get_dev() returning NULL
> > > causes the calls to vbe_simple_read_state() and simple_read_nvdata()
> > > to be dropped, so their code is dropped too, so there is no
> > > blk_read()/blk_dread() call. It is optimised away. It just happens to
> > > be the only call in U-Boot
> >
> > Ah, that is all also true, thanks.
> >
> > > > > > > Further, this functional
> > > > > > > change seems to introduce some other code being pulled in very
> > > > > > > unexpectedly, and that needs to be explained. For example,
> > > > > > > phycore_am62x_r5_usbdfu is another case and that has
> > > > > > > CONFIG_BLOCK_CACHE=y but CONFIG_SPL_BLOCK_CACHE=n, and yet the size
> > > > > > > growth is in full U-Boot.
> > > > > >
> > > > > > This board currently uses blk_dread(), but not blk_read(), so the
> > > > > > addition of a blk_read() call in non-SPL causes the BLK cache to be
> > > > > > pulled in.
> > > > >
> > > > > But, how? I mean, this sounds like some underlying bug that needs to be
> > > > > fixed. The platform sets CONFIG_BLK=y and CONFIG_BLOCK_CACHE=y and
> > > > > drivers/block/blk-uclass.c has:
> > > > > ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
> > > > >                 void *buffer)
> > > > > {
> > > > >         return blk_read(desc->bdev, start, blkcnt, buffer);
> > > > > }
> > > > >
> > > > > Or perhaps the answer / problem here is that I need to track down what's
> > > > > going wrong here instead of asking you to track this down.
> > > >
> > > > So, digging in to this, what's going on is that the platforms I've noted
> > > > here (and a few others) don't actually enable any block devices. That's
> > > > why, today, with VBE on still, they discard all of the code still. Your
> > > > rework means that while there's still no block devices, we're now
> > > > including the code. What to do? Both of:
> > > > - These platforms *should* disable the assorted block device related
> > > >   library options they have enabled if / when possible (it might not be
> > > >   a neat and easy un-tangle).
> > >
> > > As above, the issue seems to be PARTITIONS
> >
> > Yes, I think we both agree there's a number of useless functionality
> > enabled on these handful of platforms. PARTITIONS explains how it gets
> > optimized away and all of the useless block-related things like MMC
> > core should also be dropped.
> >
> > > > - VBE needs to handle the case where there's not a block device enabled
> > > >   and not fail the build. Part of this requires the Kconfig rework I
> > > >   linked to earlier (so that we can have BLK off) to be complete, but
> > > >   having the VBE code check for BLK being enabled either in Makefile or
> > > >   C code should be the same regardless.
> > >
> > > I thought you NAK'd my patch to drop the 'depends on BLK' for bootstd?
> >
> > I know I NAK'd
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
> > as that should be instead done with
> > https://patchwork.ozlabs.org/project/uboot/list/?series=440336 instead.
> >
> > With that series then yes, you should be able to have BOOTSTD not depend
> > on BLK. But in a practical sense I worry that your changes in this
> > series will break with BLK=n. My point above is to please make sure it
> > still works in that case.
> >
> > > From what I can tell EFI_LOADER doesn't do any block access unless
> > > PARTITIONS is enabled. I don't want that for VBE because the VBE data
> > > is not actually in a partition (although perhaps it could be in
> > > future).
> >
> > In a practical sense EFI_LOADER depends on BLK and I've fixed the
> > dependency with my series and talked with Ilias and Heinrich about it.
> > Making EFI_LOADER buildable without BLK is a mechanical effort, but
> > making it usefully functional still might require a bit more work and
> > they'll cross that bridge when they come to it.
> >
> > > Anyway, from what I can tell, the code-size increase is explainable
> > > and perhaps we should just accept it.
> >
> > Other than the double buffer one, yes, I suppose it's not unreasonable
> > to ask me to fixup the oddball platforms with extraneous PARTITIONS and
> > other block type things enabled. Still need to get back to the buffer
> > one as 200 bytes isn't normal for re-organizing things such that the
> > compiler can't decide to inline something.
>
> What is the double buffer one?
>
> I have a v2 of this series which splits the first patch up a bit more. But the end result is the same.

I can send that if you like, but I just want to make sure I haven't
missed anything from this thread.

Regards,
SImon
