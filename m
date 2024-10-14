Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC0D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C300890D5;
	Mon, 14 Oct 2024 21:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dmxjg46r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2EC88744; Mon, 14 Oct 2024 21:13:38 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95D488744
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46045199e4dso51520971cf.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933215; x=1729538015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JztDF3ggadmOr8cSAyBdwmktfzV8tj5mKJMbrym8738=;
 b=Dmxjg46rXgW9WhtYwSTS+CFrITObBhGSlCCJ+54QQU7RSD4hioqSXcrKat6tjfD3Dv
 5jgQfGWFDOYYEnSU73IMGW8Rnj3zh0wZzfWl2MJPGLG0ZdEjGlCXiQJubdkkk1iCszIZ
 OGu0OGj68zj8K/6E29YvKPjroYPkTpec5peM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933215; x=1729538015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JztDF3ggadmOr8cSAyBdwmktfzV8tj5mKJMbrym8738=;
 b=Igxnk6ro5yxJbDdzqviXelNUuZlgaP5m3nLYSHkNYpNdd8lS73PeB//+D5/Id0cCP4
 0qWz7LxaL7NlwH8xuACihJ75QP/wCpuoZLLGKLTlauNs6eA2NJg+XhekeUaSc3EvTdSt
 28G2JucX3vTKmPQm4wb68kS7OmuRn/Zxa2TxVEpSNbIqJIRZ7mV+HPVyqYae9wsvSX3u
 PhEcMt/FTXC4zIPDkNsNxhD+tnCz/zMWvN9eklnArTGCV7c+ITTQTZsUh5HD2rRC/8Az
 KmX0Kg/ynmfkdQuo3NfbV3jKeYJ33Pw4HaAuRHZMmyfrF8ZYd2FQu8jS0u/opLa4A3LD
 5Aig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFFB2loPY4b+ah5W/WB3nLymFShd3D2HSFIfCxcgBGKCmjqqFkmUfQtQsh0Z+cy5Dg+px2fSY=@lists.denx.de
X-Gm-Message-State: AOJu0YxGTUussEJ8U/VnaBMg6rpLhpSCZiPJMzyVZdR3gNVY2OSRyLIN
 D79TK+lxwaho/7EeI6azW0gfY6/O3zHuvQrA/ACpyazmgIty0F/KdFyzRnDaJOgx330yuWwGpT/
 nohxrMbOjdw16F4y4ItTFs49BR7mPVaXOF5F/NUL+zgghfO8=
X-Google-Smtp-Source: AGHT+IEqChxph7I7XsYyNGh3jXUMN0VSTbNm4oHRAgU5tDEhs+GUGDYdkjDPZ8VnUOaKOVxpMGB95L6/nIhp0NJ9Jj0=
X-Received: by 2002:a05:6214:4981:b0:6cb:f853:9eca with SMTP id
 6a1803df08f44-6cbf9d10272mr164884536d6.25.1728933214633; Mon, 14 Oct 2024
 12:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <Zwwg4oXUq6aWlk69@holbrook.no>
 <8341e1e4-b5da-4c2d-833e-bcc45cf5e8a9@cherry.de>
In-Reply-To: <8341e1e4-b5da-4c2d-833e-bcc45cf5e8a9@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:23 -0600
Message-ID: <CAFLszTgmM6DKjssS9f+Qzv9RPSmvSMc9V=RK_Se4CdW3-H2bxg@mail.gmail.com>
Subject: Re: Mainline kernel bad magic for Pine64-A64-LTS
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Louis Holbrook <accounts-uboot@holbrook.no>, u-boot@lists.denx.de
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

Hi,

On Mon, 14 Oct 2024 at 11:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Louis,
>
> On 10/13/24 9:34 PM, Louis Holbrook wrote:
> > [You don't often get email from accounts-uboot@holbrook.no. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > (Also posted in pine64 forum
> > https://forum.pine64.org/showthread.php?tid=19460)
> >
> >
> > In an attempt to troubleshoot failing to get generic alpine linux to
> > run on PA64-2G-LTS, I've tried to reduce the problem to the smallest
> > steps that are legible to me.
> >
> > When booting the kernel, I get "Bad ARM64 Image Magic" I can't figure
> > out what this means, and why it is happening. Sources I have searched
> > seem to be board specific, and found nothing on this board. I've arrived
> > at a point where I cannot find a way to reason further about it, so thus
> > I am reaching out.
> >
> > I am currently loading the kernel and dtb manually at the uboot prompt:
> >
> > setenv bootargs loglevel=7 earlyprintk
> > fatload mmc 0:1 0x42000000 boot/vmlinux
> > fatload mmc 0:1 0x4a000000 boot/u-boot.dtb
> > booti 0x42000000 - 0x4a000000
> >
>
> Make sure that those are absolutely NOT overlapping, i.e. you may be
> writing u-boot.dtb over vmlinux and thus corrupting it. I've not made
> the maths if this is reasonable with the addresses provided there but
> it's good general advice anyway. What I usually like to do is have the
> DTB right before the vmlinux, like 1MB before. No way a DTB is going to
> be bigger than that :)
>
> I have never used vmlinux so cannot tell if you're supposed to use booti
> with it. I usually just get the Image or Image.gz from arch/arm64/boot
> and `booti` it and that should just work.

Right, that isn't actually an 'Image', so far as I am aware. However
on x86 machines it seems that it sort-of is? I'm a bit unsure about
why.

You can use arch/arm64/boot/Image (offhand)

>
> I also do not exactly know if you're supposed to be able to use u-boot's
> DTB for Linux kernel. Eventually we want to go towards this, but I don't
> know if that's necessarily possible today (but that wouldn't have
> anything to do with the bad image).
>
> Cheers,
> Quentin

Regards,
Simon
