Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD93C83F3A
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663568669D;
	Thu, 31 Aug 2023 21:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5NKH3s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58DE86546; Thu, 31 Aug 2023 21:02:56 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DE286523
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so869777276.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508570; x=1694113370; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A7akbzf7p6qLMT9CId9srq3NoywPtwEIUUEfPHkZJsQ=;
 b=b5NKH3s8NeMC0+2NmG/oWe78sDkryZFlkaX0lbxcZPDnbbpOXjgQee/1WEm82uno+T
 xpdd/H7N9eISeCdVTbceBglvhjHEwIcvsDjOYvlUGDYYoixokRnCkTCWcyPdSnXq2Qpr
 iB/B6yVXnIIpxtfPP2YUuyHvHdECZygQJp40U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508570; x=1694113370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7akbzf7p6qLMT9CId9srq3NoywPtwEIUUEfPHkZJsQ=;
 b=PfDcZzrJikkABD3BXkJQW5vR6G+pKaeTCUDWpj47RHAnWoPEQOyQS5CsAdGJ1FGZCd
 etKGFxpU3b18ZQHjxwocgJT556WXwK15hhmmlbglj2bHe861eGQiArbfvpx3X5kqPUUf
 VgCQWBYXRpV9cUNAiyhg7M/BxUEw7dy2oynum1b40tcu+E60H9MZ3aQ48vJTXtVXQ1sz
 6g2b4M0E2bZN9gf4Ka7tCUGYVCxLluK4h8zoyZWzkSiuUh/N6Q39WT7vZ390GEDNskTg
 Wx3IjxuqSVqNEg1R3pIvq0xbH443mA3GUPf94oWluIjNINhiWscBH9sSY5+abFB+y2uS
 dQxQ==
X-Gm-Message-State: AOJu0Yzi02nkj1oU9BqheGXB1UGO/B8GNZwP8bTEkFCEmhteqk/FlHrc
 F9Q71yX0VQTdv6xeaoDPQsdZDkAB4l0t/dZ+SrlMJg==
X-Google-Smtp-Source: AGHT+IFgYe5eJwuZnOHD/xqdCqUXVBPgQgw8VXg5sBC7vEsyTGwkyPjGCIC77qC3Yu5PxU7nJiRTcLt23o10COqLM1E=
X-Received: by 2002:a25:460b:0:b0:d67:5d71:d818 with SMTP id
 t11-20020a25460b000000b00d675d71d818mr569947yba.1.1693508569648; Thu, 31 Aug
 2023 12:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230825192842.1957055-1-sjg@chromium.org>
 <af866d03-d097-48b9-994a-450ac4702d34@gmail.com>
 <274DFE38-4A70-4181-9725-EE7BC5A0483B@gmx.de>
 <86ca51bd-8277-45e3-a458-6e4dde3a4d90@gmail.com>
In-Reply-To: <86ca51bd-8277-45e3-a458-6e4dde3a4d90@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:01:58 -0600
Message-ID: <CAPnjgZ0Apssd247Zq2QpQ=27uYdDJY5a1VCyrdVLy6+esMGvjA@mail.gmail.com>
Subject: Re: [PATCH] efi: Correct handling of frame buffer
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sun, 27 Aug 2023 at 12:41, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-08-27 19:32 +03:00, Heinrich Schuchardt wrote:
> > Am 27. August 2023 16:56:51 MESZ schrieb Alper Nebi Yasak <alpernebiyasak@gmail.com>:
> >> On 2023-08-25 22:28 +03:00, Simon Glass wrote:
> >>> so we must allow EFI to write directly to the hardware framebuffer.
> >>
> >> If you want a fix independent of that series, I think the proper
> >> approach here is having EFI draw to fb as it already does, then copying
> >> from that to copy_fb at the end of gop_blt_int().
> >
> > An EFI app can write directly to the framebuffer and mix that with API calls.
>
> Ack. Can EFI apps write to framebuffer without informing U-Boot at all?
> What I meant is, copying whenever EFI asks us to modify something or
> tells us it modified something.
>
> If it can write without telling us, how are cache flushes and hardware
> syncs handled? Asking these because I'm doing some weird experiments
> with video damage and cyclic video_sync() calls and VIDEO_COPY...

Yay! I'd like sync to happen there. In fact I am wondering if cyclic
should have a flag indicating whether the callee has enough time to do
whatever it wants (e.g. several milliseconds) or should be very fast.

>
> > blt functions causing a full copy would be much slower than what you get when eliminating the copy fb.
>
> When we expose copy_fb to EFI, don't we need to keep fb up to date,
> incurring the same cost? The VIDEO_COPY description mentions "reading
> from the frame buffer is slow", so whatever code is "reading" would use
> fb and would get bad data otherwise. But I can't exactly point to any
> examples other than the video damage series copying fb onto copy_fb.

Look, the EFI API is not going to work so well here. but it is what it
is. The purpose of this patch is to make it work. Of course it will be
slow, but it isn't really noticeable to me.

Regards,
Simon
