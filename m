Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A83CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E8D86F29;
	Wed, 18 Oct 2023 05:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PDA/vOWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F8986F29; Wed, 18 Oct 2023 05:31:24 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A519586F27
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so4937828e87.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599882; x=1698204682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AyJ2avMWX9NAsSve9jQoJ/nU+TrfKhJ0BzfCyPp1TuQ=;
 b=PDA/vOWWiQFX3e7EO76JdWqoi3O6tuiqu9RAMXqzitPy9e/sEpCxPSmGG1tkVdupAY
 jTQ4MYVuDv4sj2+iFWQFdXCqcPFgN5Nh/FOyQUXqyvt4taqlnrQSXQF2Dv/tcDcqIAfw
 aykgvo5iKZDBbVMWXf8cUbWDyAjmTJy8kOTfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599882; x=1698204682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyJ2avMWX9NAsSve9jQoJ/nU+TrfKhJ0BzfCyPp1TuQ=;
 b=Hj9yO23lRARuHcMWKKApus5okNcHnx3Tx+UR6SkJeMPp0ODYJgM96PtlTeOckZszcs
 RO5oGYGTcU2qq1/h+KSyGdvuj6YPfdsMeXiRqmpJI9YKGrohYv/x1wKFUJKmAxRVNV03
 6OW7U2T0C8lNMIlc+bBW3AYlXPfYvfKf6DVVcgotkt0YFagtQKGpvth5FND+/xvCsO8e
 K21wRy/D/Z2tP3b3Z+//eWGCdSXx+I/j1gFTMCs1+tLQUI3bnhsfTeACfM00TtnU7mzR
 cCWme8t/5lDy4vsS5pSRyO/kKHKYR2dWCQS/9ngO+hjzZu6SNwIrzsckwiGaFtSx+q4A
 Chvw==
X-Gm-Message-State: AOJu0YwH6yRlFUAbSSIMv+HOHOhRxzyyn3Y9AXHGa8q1VBG6RAJ7rK4s
 0PtB/DO2uacV/2lZz6YnY/aKF2XG3qmrsqdG193RSA==
X-Google-Smtp-Source: AGHT+IGuruSthHKvQAZG6u5wbSmNKcXGNA5mJXy/dpzxu/5Ms/jarNOdNFUxMihXIUU1z4J/b+JWWtO5v2tDqcM2+KI=
X-Received: by 2002:ac2:544c:0:b0:504:7f2e:9391 with SMTP id
 d12-20020ac2544c000000b005047f2e9391mr3149848lfn.34.1697599881774; Tue, 17
 Oct 2023 20:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
 <fd206328-2ffa-c174-179c-85f6428e5d9f@gmail.com>
 <CAPnjgZ2bs2ZE87W71h_4V91M3gyCtCV7vbHVnGwGE+Hmt2LfuQ@mail.gmail.com>
 <64400549-5a62-8079-cbd6-2a099c2b06ec@gmail.com>
In-Reply-To: <64400549-5a62-8079-cbd6-2a099c2b06ec@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:10 -0600
Message-ID: <CAPnjgZ2HB+Sf=Zpby8pFrnLmkuGW_b31sqdjoATerG-4Xa5zMQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
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

Hi Johan,

On Tue, 17 Oct 2023 at 06:44, Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 10/16/23 23:54, Simon Glass wrote:
> > Hi Johan,
> >
> > On Sun, 15 Oct 2023 at 16:33, Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >> Disable bounce buffer support for rkmtd.
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >> ---
> >>
> >> Changed V3:
> >>   New patch
> >> ---
> >>  drivers/block/blk-uclass.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> >> index 30ad5bbb0024..ac1b43d757d8 100644
> >> --- a/drivers/block/blk-uclass.c
> >> +++ b/drivers/block/blk-uclass.c
> >> @@ -415,7 +415,7 @@ struct blk_bounce_buffer {
> >>
> >>  static int blk_buffer_aligned(struct bounce_buffer *state)
> >>  {
> >> -#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> >> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)
> >
>
> > We should not have arch-specific code in a generic file. Can you make
> > BOUNCE_BUFFER depend on !RKMTD ?
>
> Hi Simon, Marek,
>
> No that doesn't work that way.
>
> On Rockchip mainline boards MMC_DW is always our boot device BOOT_DEVICE_MMCx.
> Therefore BOUNCE_BUFFER is also standard enabled.
>
> The solution in this patch below is wrong as it assumes that if BOUNCE_BUFFER is enabled it must be used all over the place.
>
> blk: Add bounce buffer support to read/write operations
> https://source.denx.de/u-boot/u-boot/-/commit/75191f75bce45f3b9aff607c88f17778d3805c61
>
> All implementations of bounce_buffer_start and bounce_buffer_start_extalign are located in the individual drivers
>
> https://elixir.bootlin.com/u-boot/latest/C/ident/bounce_buffer_start
> https://elixir.bootlin.com/u-boot/latest/C/ident/bounce_buffer_start_extalign
>
> The use of a bounce_buffer in block devices should only be allowed if needed.
> Lack of "ops->buffer_aligned" does not prevent the creation of a bounce_buffer and is not a good selector yet.
>
>         if (ops->buffer_aligned)
>                 return ops->buffer_aligned(dev, state);
>
> Current blk_ops has no option to communicate the needed resources.
> Please advise how to select the creation of a bounce buffer per device or other solution.

OK, I thought you might say that. So what about a flag in blk_desc
which you can set for this driver, after the block device is created?

[..]

Regards,
Simon
