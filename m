Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFED1A443
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 07:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AC688975;
	Sat, 12 Oct 2024 09:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oESPJeiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 896C888970; Sat, 12 Oct 2024 09:37:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E86F88D4F
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 09:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so67698a12.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728718626; x=1729323426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F7gS1aLLokIMyuDjKLXrot8Zbl0XgIxMYtVfp5T10xU=;
 b=oESPJeiSQBZHvM0I2VwoCmXQ13zYl5bP3Slcyr2aWrE6yGQg5nGBpTHEDfjUxegSr1
 kM6ehGo+B9B4QHzEJmrZOdxw4XgPs0KkwJFapyfXOYo6VC/0lqqGDdBRRJo37dII4Aji
 Ear14Xwp9Ccsv4EtY4kuA3tgaXmLUN7geXkq50+LHWr5n+uToUgxeUyj2n7eZPry+IDw
 kXkTMABj/5sCrPugKmPtRq5025QzpBQb6BCVPF1eydrQT8l/ZLY24s6P2fhC6HH22hyK
 2wgd9mvRMJjSic7gJ3+sZ1/I3ZecYm9t1MoFNYdpTzVCVt71K5xCY/x9Wmgq9/hRmnTO
 +ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728718626; x=1729323426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7gS1aLLokIMyuDjKLXrot8Zbl0XgIxMYtVfp5T10xU=;
 b=MvlcbJgT0UJ70u+nSgyjXWqioiJL6K6cMzdd3Wl+eDq0ObVAse+3nGIpJThxW/0UiF
 CkzXhSbpcdD7u9tjHcJ5xXXf64sG+YGdtu9qNkK7Mg+7zgM6NhvwI428I5aVNeAtKCf5
 T9H5fEktvvOTi7qegZ8sZDrasi9F/uaU9jzia7gdNIiz2/yz08LB986cqNzEvCBBZ5oQ
 13iqpFU0dGeZ6wwxDxN2U8ExkuJmRMBF0K8Y9hx1VVOdXoo7d9rMgzqF5MLVP4Fdvuuo
 XIHKn6ZVWycif9r3f6dj7pCeb5T4+almvSYkmucKboVBoBpUGfldrxBvUX9spUYr9CIz
 BqrQ==
X-Gm-Message-State: AOJu0Yy8thZSOPLPPfQ7fM1cshv6b+9k97Q1CsQA9Wr6i59LN9ejAkPR
 XQ9lV0y1JVer/hDFrbMP+7+Y1j7QzJtUugz2rU6NlFJy0E78K9q+uoB2lS1qPTKg6QfPt6dZwQx
 sJb/5tfRpBpP3x43y0Vwi8p26Jg1aqd8qo3dJPw==
X-Google-Smtp-Source: AGHT+IGkSt5GUEyl3AIfPr7eqISD881RCwjte6BCWoSuURRYTh8b0UHcxtgwqn2nIMD0IG7AoxxFfaItBS6RnSvwAXM=
X-Received: by 2002:a05:6402:27cc:b0:5c9:492c:f80d with SMTP id
 4fb4d7f45d1cf-5c9492cfae3mr3066520a12.19.1728718625819; Sat, 12 Oct 2024
 00:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-3-sughosh.ganu@linaro.org>
 <CAC_iWjKfPVRSwcinmTUv1QtrFpfgqY5fNH2BNXumx817Nw2yiQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKfPVRSwcinmTUv1QtrFpfgqY5fNH2BNXumx817Nw2yiQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 12 Oct 2024 13:06:54 +0530
Message-ID: <CADg8p942QeT9qrLzto_sYM_LkQcjcS7v3Mfoi3evv1BqD_7oeQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] lmb: add a flag to allow suppressing memory map
 change notification
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Fri, 11 Oct 2024 at 15:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Tue, 8 Oct 2024 at 21:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > reserving memory. This will then result in no notification being sent
> > from the LMB module for the changes to the LMB's memory map.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: None
> >
> >  include/lmb.h | 1 +
> >  lib/lmb.c     | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 0e8426f4379..a76262d520d 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -23,6 +23,7 @@ enum lmb_flags {
> >         LMB_NONE                = 0,
> >         LMB_NOMAP               = BIT(1),
> >         LMB_NOOVERWRITE         = BIT(2),
> > +       LMB_NONOTIFY            = BIT(3),
>
> I haven't gone through the rest of the series yet, but if if we remove
> the notification event why we would we want the flag?
> The LMB will directly update the mappings no?

We are no longer using the event framework for notifying the EFI
memory module of the changes to the LMB memory map, but the
notification still ends up happening. The efi_add_memory_map_pg() does
get called from lmb_map_update_notify().

-sughosh

>
> Thanks
> /Ilias
> >  };
> >
> >  /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 0763f6174c1..a4886db4c45 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -30,7 +30,7 @@ static struct lmb lmb;
> >  static void lmb_print_region_flags(enum lmb_flags flags)
> >  {
> >         u64 bitpos;
> > -       const char *flag_str[] = { "none", "no-map", "no-overwrite" };
> > +       const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
> >
> >         do {
> >                 bitpos = flags ? fls(flags) - 1 : 0;
> > --
> > 2.34.1
> >
