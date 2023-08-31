Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC3C83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B5D8656A;
	Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUf07dRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6477D86569; Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9B486550
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso353860a12.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450199; x=1694054999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XQEk+BAuHTXDL9WXFe64kd+V4WgpTYQEeDOe8PYQ84A=;
 b=MUf07dRDWf5XKBhJaCuvPqJrS6jMlbR/D51T+JZEmjTaiAXbtuIQcm0Nec5CZGIuxo
 n39lf1UfPtLUPTlWGH00j/Oz84zaNcWTob2YYFCfNj0lHmTivZZo1B8m4p3rlx04mEh8
 odt2Oq0X8g6F5y3o9AyF97X1sIKFzob3ru5aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450199; x=1694054999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQEk+BAuHTXDL9WXFe64kd+V4WgpTYQEeDOe8PYQ84A=;
 b=akJkspni+qMevefV+NWGKv31Sx8g08D8kbvfIf3Mex/3jm87DFifeXcPcDoOpIofj8
 XSZroKTbsbJThnuoOaAVQdNV2siKaxOljMvVuu+jGBv9wHndTbYNyC02gSoirP8Al7tu
 eonREYwJBodJxR654A3kqtWsU9ONmVhTTk74zZ5lct8Es7eL44ie/D+GMJJNmytVW37Z
 WYywtllr+XIBKIR/GURM+Ub7GQzPY8FXapElVRLnDTMbkjVjjru0ggMg28vGkKIDUPrJ
 m8FihK8kz/mfCPDzm+C9tiSTlZC4JpEe+kd0FdIveZpNa+Y+Yt9IPmvQA7yz17qX+2pi
 eAEg==
X-Gm-Message-State: AOJu0YymYjWRnI5KtD5PMMWYORP2d+PRix5osJT/PgD+Nnhv3BY7Wynz
 6wsqzzvgktYmE9DDYwf9ACGxhJxielXN6FCM/Pfdzg==
X-Google-Smtp-Source: AGHT+IH6y/nIGKENiyoyRpRAp+frqPfd1vWPEH7qNEp/87/CnwrP1U3OdmvJDUoKWgbQtED+zEmmsKnmuyUuCsJvHus=
X-Received: by 2002:a50:ef1a:0:b0:51b:c714:a2a1 with SMTP id
 m26-20020a50ef1a000000b0051bc714a2a1mr3469258eds.7.1693450198736; Wed, 30 Aug
 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351@epcas2p4.samsung.com>
 <20230829042803.2606011-1-chanho61.park@samsung.com>
 <CAPnjgZ0XSpoCRp20aOUQ7mwaCnkQGS3ois7kfkkMV064=QWtOA@mail.gmail.com>
 <000001d9db00$416373e0$c42a5ba0$@samsung.com>
In-Reply-To: <000001d9db00$416373e0$c42a5ba0$@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:19 -0600
Message-ID: <CAPnjgZ3ctm3MW==Y_j1YGuxF4gD9-JWz4g6DwoN_wjDg358K7Q@mail.gmail.com>
Subject: Re: [PATCH v2] spl: bootstage: move bootstage_stash before jumping to
 image
To: Chanho Park <chanho61.park@samsung.com>
Cc: Nikhil M Jain <n-jain1@ti.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Chanho,

On Tue, 29 Aug 2023 at 23:10, Chanho Park <chanho61.park@samsung.com> wrote:
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Wednesday, August 30, 2023 1:38 AM
> > To: Chanho Park <chanho61.park@samsung.com>
> > Cc: Nikhil M Jain <n-jain1@ti.com>; Marek Vasut <marex@denx.de>; u-
> > boot@lists.denx.de
> > Subject: Re: [PATCH v2] spl: bootstage: move bootstage_stash before
> > jumping to image
> >
> > Hi Chanho,
> >
> > On Mon, 28 Aug 2023 at 22:28, Chanho Park <chanho61.park@samsung.com>
> > wrote:
> > >
> > > Regarding IH_OS_OPENSBI, IH_OS_LINUX and IH_OS_TEE, there is no chance
> > > to stash bootstage record because they do not return to SPL after
> > > jumping to the image.
> > > Hence, this patch separates the final stage bootstage code into
> > > spl_bootstage_finish and call the function before jumping to the image.
> > >
> > > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > > ---
> > > Changes from v1
> > > - Separate the final stage bootstage code into spl_bootstage_finish.
> > > - As Simon suggests, call the function before jumping to the image.
> >
> > I think you misunderstood me here. I mean, you cannot jump off somewhere
> > in your board code. You must change it so it returns correctly, and the
> > jump happens from spl.c's board_init_r() function.
> > The way it works is you set up the spl_image structure, then it SPL jumps
> > to it at the end of the functions.
>
> I feel like I'm still not clear on what you mean. Sorry.
>
> switch (spl_image.os) {
>         case IH_OS_U_BOOT:
>         case IH_OS_ARM_TRUSTED_FIRMWARE:
>         case IH_OS_TEE:
>         case IH_OS_OPENSBI:
>         case IH_OS_LINUX:
> }
>
> Regarding ATF/TEE/OPENSBI and Linux, they need different number of arguments and formats to jump to the image, respectively.
> I think that's why they can't go to the final stage and can't use jump_to_image_no_args.

OK, so let's move that code into spl.c and have it do the right thing...

>
> Do you want to move jump codes at the end of the board_init_r function?
> The easiest way is that we just move the whole switch statements to the final stage of the function.
> Otherwise, the arguments can be prepared from switch statement and make jump_to_image function to support variable length of arguments.
> (Or we can put switch statement there to support various jump of the image)
>
> Can you elaborate a bit more?

Basically SPL should have one place where it jumps to the next phase.
If you do it willy nilly, then generic features like bloblist and
bootstage cannot work, as you have found.

The way SPL board_init_r() is set up is something like this:

- do some init
- work through the boot devices until one is found that can boot
- prepare to jump (thjis is where the bloblist and bootstage are finalised)
- jump

So we should keep this approach, even if it means putting a switch at
the end like:

switch (how_to_jump) {
case way1: ...
case way2: ...
}


Regards,
Simon
