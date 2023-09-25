Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAAACE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FB786CD8;
	Mon, 25 Sep 2023 15:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UWESjpYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC31586BCF; Mon, 25 Sep 2023 15:11:15 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA5686C3E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so104954821fa.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647471; x=1696252271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k4cTTLGXkWdr9lvW5r7oz4s4f6kvZcKn56BksOoJL/0=;
 b=UWESjpYV4IYgTAr3SQUedU881fYlZ9i/y1fhrKGnP/bTW6qq0cWLWBakcLqSjNU3fA
 aN+XnUddNVq9okn1eyF8aasmlOHNPd6tdIrJ0Bk/rvU2p5O9iO7+hkLB65Lp/6sCjIjL
 UsEnczmm642uryQdgoxQfqFMfr05YSknlG9uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647471; x=1696252271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4cTTLGXkWdr9lvW5r7oz4s4f6kvZcKn56BksOoJL/0=;
 b=wcujqFQVV3loEETMi2wQo8E4AlJg/c95eBx+PixiuKv8PPoNW3cowpVEnqvLJKTL+l
 jzqmPnN9LJ2tR0MWqcydZ1nDPM/EyikvGzEXx+easF1O+irh4FkvuQQIKJ88kezYiCx/
 SDT1TVAQkf/sLkcFeMLEe9u6F9Zqq/pxEZUpq/G6r75qPdiBZ/LPM0WtDIEc8rUEsd+v
 U7S+PX23LJSAKNUEmMPrHdfKVqt2yGkQ+iBYpY7vs7AqI5ffFpaL//mK2ez3LnkOiq85
 t4dJbzpFTiBE1mNiVaMQbQCiLfEfM1vx0lnDvRC/X/ok+JdJnqsJq843i9Nlx9VAb2Iv
 h/ag==
X-Gm-Message-State: AOJu0YxwSab0Zw6fXpwo0QvMnosCwqbM326vjwAaI8RQUwxxF+Mf6KgI
 g9MaXhUTNNPyGq/AnCZpMQ9S6kgYt+EhKEO/0s2jJQ==
X-Google-Smtp-Source: AGHT+IHBsIfxClz6Z8bjaxhFMEk58PYPOl7IjPAQTxXEebkRbVMEpuAZYNKYYRKbeVnByIcCnPU7GGCc1YnNwGX/N+o=
X-Received: by 2002:a05:6512:3ca5:b0:503:26bd:7f58 with SMTP id
 h37-20020a0565123ca500b0050326bd7f58mr6898956lfv.41.1695647471348; Mon, 25
 Sep 2023 06:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
 <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
 <CAPnjgZ09St0710SRLzubphauTYMtE1PyxAFWEKsupA2dAhXRbw@mail.gmail.com>
 <b655aee9-ebc6-044a-cc7f-9e28d850b671@prevas.dk>
In-Reply-To: <b655aee9-ebc6-044a-cc7f-9e28d850b671@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:29 -0600
Message-ID: <CAPnjgZ2CMYOpchV0Q3qkdRinaMp8atpW+QE0FJ_VOJfV8YRKJg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

Hi Rasmus,

On Mon, 25 Sept 2023 at 02:47, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 22/09/2023 17.26, Simon Glass wrote:
>
> >>> Shouldn't this be fdt_open_into()?
> >>
> >> I honestly just copy-pasted fit_extract_data() and shaved it down to the
> >> part that does the "align the FDT part of the file".
> >>
> >> I don't really understand your question. Are you saying this doesn't
> >> work (or maybe doesn't work in some cases), or are you saying that
> >> there's a simpler way to do this? For the latter, sure, one doesn't
> >> really need to parse the whole FDT; we could just
> >>
> >>   open()
> >>   pread() length from FDT header, convert to cpu-endianness
> >>   length = ALIGN(length)
> >>   pwrite() the new length in fdt-endianness
> >>   ftruncate()
> >>   close()
> >>
> >> but I thought it was better to stay closer to how fit_extract_data() was
> >> done.
> >
> > I mean that fdt_open_into() does more than just set the size (from
> > what I can tell). But looking further I see other code which calls
> > fdt_set_totalsize() so perhaps it is fine.
>
> Yes, I think it's as it should be - as a I said, this is really just a
> trimmed-down copy of the function which moves the data externally, and
> also needs to make the size of the base fdt structure aligned.
>
> Since patches 2,3,4 touch binman code, could you take all four?

Yes, will do. I didn't pick them up in the most recent PR as I try to
have things sit for a week before applying.

Regards,
Simon
