Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2B6C02180
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 00:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A63805C5;
	Tue, 14 Jan 2025 01:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NiF1YpZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F28C8060C; Tue, 14 Jan 2025 01:13:54 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D15E80285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 01:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so7286833a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736813631; x=1737418431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RoFtq9oA8kgx2D/cQRA7R0zhilTOiNzT75wEefUtPuY=;
 b=NiF1YpZFsl8hcI4k6R9LjxFAypmPXDRpAtTXmOAkhyAoCJMENNbIoaPSZeeR2dQvon
 ieNrvelIf7obGWZ82NTUTH6vJXgzueNGtl6k1iSAc0M5OZuIvdj8t7WjLrOoI5xpN/nf
 xAsCqthBoKWGF/dEw3j9YdeGYLByKl5d+CFrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736813631; x=1737418431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoFtq9oA8kgx2D/cQRA7R0zhilTOiNzT75wEefUtPuY=;
 b=V6NiQF8Wl9yOC0b8DQe/tL5FLeGmLo0nWx1JjfjWGVFsHXNH/stJ5AtFFXeLQmsGdu
 +bAwdf6UhyLFJyGs/nm27iv15eUl3czjWoM4hkrA8ZZlOC55kbUtYOP2ZE+zHSznxoxb
 D3Eyd+FQX/kkKAqhCIYKocCPYKdI0KN0asY8dTQxgonZSuVIu6hTprQGiinH2yKvfgQq
 glrc0Nc508RIYXvel7GUs7m6YW3rbag8tQ4Aq5S7jrouHu1A8/GYAvoAiZoDDNzDa6ov
 i+elb3ckmsqLtRANi7ndSy3OQUloP0bRmxrkRl1/QAtISyD2rbQxYwrcx5ihMym6Ph7s
 9x7w==
X-Gm-Message-State: AOJu0YximaN+1s9CKHyefMb9m1h5euhE5+q+k6YcKHl9jL9M85uRJ/iD
 t6J6PbKNfVqB9OaAKrwU8Vc8ZLWbUtoUA4g+tSrhZMoq4YTJzoRjN/drCePQ0WzmLKrbuLSs6Hy
 gGbOTx4nkmNot1KSebgedkhvoDxYIiciwk1qhy/GKtD0ioEqezQ==
X-Gm-Gg: ASbGncuukTin0Anj6dlxHp7iYuDKh86z+aQWQo3OK8tgyy7JTmeRfm2ky+3TxjFCp83
 XJEvP+A8h5AY08ME0WCoSLtanqEJmZMzckZp1Oo8=
X-Google-Smtp-Source: AGHT+IEzR1yN0m1NYXx1bX8Jc7XeNQaERL53rj/RD+HjIP87rekPBBmbvk8Y/qUHaRJL9QBKB0vC3Rs3vg63+c29fkc=
X-Received: by 2002:a05:6402:520d:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5d972e1da12mr53820751a12.20.1736813630782; Mon, 13 Jan 2025
 16:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
 <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
 <20250113204419.GE3476@bill-the-cat>
In-Reply-To: <20250113204419.GE3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 17:13:46 -0700
X-Gm-Features: AbW1kvYnu5weY0eSbC2-jEte8XssMDhA77-ojY4cYz2U9GL-iNgOQMSeWLY4QQ0
Message-ID: <CAFLszTjo1FcHL4G76u1tS3caEgdpk7FHdstoXe+AhERO8rJJfg@mail.gmail.com>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
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

On Mon, 13 Jan 2025 at 13:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 13, 2025 at 01:03:52PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
> > >
> > > > Loading a FIT is useful for other VBE methods, such as ABrec. Create a
> > > > new function to handling reading it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This causes a bunch of growth:
> > >             a3y17lte       : all +1328 text +1328
> > >                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
> > >                  function                                   old     new   delta
> > >                  blkcache_fill                                -     332    +332
> > >                  blkcache_read                                -     240    +240
> > >                  blk_read                                     -     188    +188
> > >                  vbe_read_nvdata                              -     156    +156
> > >                  vbe_read_version                             -     140    +140
> > >                  vbe_get_blk                                  -     100    +100
> > >                  simple_read_nvdata                           -      96     +96
> > >                  crc8                                         -      72     +72
> > >                  vbe_simple_read_state                      108     112      +4
> > >
> > > Which is unexpected for just moving code around that's not newly used.
> >
> > I hadn't noticed that on the boards I was trying, so thank you for spotting it.
> >
> > This is because it now uses blk_read() instead of blk_dread(), so if
>
> That's not what this patch does? There's no caller before or after in
> this patch of "blk_dread". Just moving functions around should not
> increase size on platforms that weren't using the existing
> functionality.

Firstly, are we looking at the same patch? Here is the one I am looking at:

https://patchwork.ozlabs.org/project/uboot/patch/20250109123010.4005298-2-sjg@chromium.org/

It has blk_dread() in the old code and blk_read() in the new.

> Why is vbe_simple_read_state changing at all here, when
> it's not being touched?

Again, I'm not sure we are looking at the same code. In my version, it
does get changed, since it now calls vbe_get_blk() rather than finding
the block device itself. This is to avoid duplicating that code in
simple and abrec.

>
> > BLOCK_CACHE is enabled, it will use the block cache. We could disable
> > BLOCK_CACHE on those boards perhaps? It is a speed optimisation so
> > shouldn't be used by boards which care about code size.
> >
> > > And even when it's just a move it's still growing:
> > >             xilinx_zynqmp_virt: all +128 bss -72 text +200
> > >                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
> > >                  function                                   old     new   delta
> > >                  vbe_read_nvdata                              -     156    +156
> > >                  vbe_get_blk                                  -     148    +148
> > >                  vbe_read_version                             -     140    +140
> > >                  simple_read_nvdata                           -      96     +96
> > >                  vbe_simple_read_state                      452     112    -340
> >
> > Unfortunately this one is hard to fix. As you know, whenever you take
> > code from a single module and put it into another, the compiler cannot
> > optimise away the function-call overhead. I'll note that there is no
> > increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi
> >
> > So let me know what you think.
>
> You likely need to re-think your refactor a bit then. If it's in part G
> or H that we have more than one caller of any of these functions, that's
> perhaps where it's time to refactor and expose them?

Yes of course I can move things around. I would need to drop the FIT
loader as well, so this series would become quite small. Shall I do
that for the next version?

But just so that I understand...in the next series, when abrec is
added, and I have these same patches, will you accept this size
increase?

Regards,
Simon
