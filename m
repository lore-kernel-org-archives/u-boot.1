Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C0C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF3080FA4;
	Tue, 25 Feb 2025 14:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nbqfyh/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE3D80FA4; Tue, 25 Feb 2025 14:04:55 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2A680977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso8519377a91.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740488691; x=1741093491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hWR5Z2W+BJ/Ko0zO1GpLLp9obW3SbKSwmiX/1DYLT7g=;
 b=nbqfyh/RxH3Ynr0Kue5ceUELWNZkHUusBWToG5+xh1mHupiQHNrR06GlonwLt5RBHm
 o09zgoRFDojViVZCcIkQpJnYzbim2vx3LbbYoj2LtxN+THYYU41wDrjRug+/CsiGJOh1
 eaJhJeo0Jf2+QNsRpIjZ8O5mrHQnBquLabkEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740488691; x=1741093491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hWR5Z2W+BJ/Ko0zO1GpLLp9obW3SbKSwmiX/1DYLT7g=;
 b=ll+J0/HK9bjAHxY0Zw81+o5mkILK3hvKwkmDAD+LM8KDo21xa7wi5T5e1jySPF56ot
 d45ik9aJ8NNRPOhi2Olkld2rasSSPK6rANdM4ArfsoM5hTEJwZvaMKW4mnfqteRY0aCG
 1JaRS5ROat7aZwebi04y1RDK2LIvl39Mf7pHpw0fc3QXq/VTfSn3BfiIYHsxHKRyu+SM
 elczgzGYUNJil72xejWyu6sg3GCXhMEvYjvf1VUD7eRwwLaG3x/0sOWiHnN1hDMzVZFn
 zwBFOONz3eG3IrRIhqMRKnlmpx+MwKbknhvvRenoiTVyLUroCx1798soJVNUR4w0rjP/
 o28w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Jqy9wMd5VCVGIN4aeKMynWKAQY23/FLgDKZtnH7u+E0I9Aw6BKqVw54CEyMoSGO97R7tc+o=@lists.denx.de
X-Gm-Message-State: AOJu0YxSPLJ1PDa4wCRr4dLD0NGpQL28hN50ggHccE05fEY26VsNsi74
 h4cQ4twDwWbbc2KiK2THHlYR7Dl3p3Hmj2qkZCX2vXpeQD0zZpgemEW0wHUew3gr1JMFAZKmM9x
 tgpCllThhiTsWR4AOU5NMbm79G0RctCmFlHNw
X-Gm-Gg: ASbGncuZrp5wpEYZErL5MJgnd0WDsgguqT8pxviyS/V2iANNy4iZnb22uOJdTT8P+o/
 k+8szrqOLQ5TCEqy/7CdpSxVgEDFl16bKRuj7dQNMQ5IYpnthb1fhmm0VW/VDrIMaXFYCkaqt6q
 g+h900bpVB
X-Google-Smtp-Source: AGHT+IEVE3zD4oe+BhIxxIxbrqhiH9la6oUDyq8n3uI29HeIfep1BAyDEsv/6w03iAAVL2xKGHa8IrXfNndB41OqVAQ=
X-Received: by 2002:a17:90b:2b8e:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2fce78cbeaemr25975202a91.19.1740488691373; Tue, 25 Feb 2025
 05:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-12-CFSworks@gmail.com>
 <e92dcfb1-c1c4-41f2-9a98-b710cfee5170@gmx.de>
In-Reply-To: <e92dcfb1-c1c4-41f2-9a98-b710cfee5170@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 06:04:23 -0700
X-Gm-Features: AWEUYZngrwBwqXf_-T9gI03WW8DeUFNewCm-VFJbW6_ILlnLpx5_Se9rdopfTsI
Message-ID: <CAFLszTgm6r76hsXT8TfNQmpKcjaqRo3a9vU-AwqUz1oPkONwhg@mail.gmail.com>
Subject: Re: [PATCH 11/17] makefile: Fix symbol typo in binary_size_check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
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

Hi Sam,

On Mon, 24 Feb 2025 at 02:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/24/25 06:55, Sam Edwards wrote:
> > The start-of-image marker symbol is `__image_copy_start`; by searching
> > for `_image_copy_start` instead, this check can accidentally match
> > `_image_copy_start_ofs`.
>
> _image_copy_start_ofs seems to be the only match for
> git grep -n '[^_]_image_copy_start'.
>
> Can _image_copy_start_ofs seems ever occur before __image_copy_start?
>
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index b32606b69f5..a9194b46ae1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1314,7 +1314,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
> >       @file_size=$(shell wc -c u-boot-nodtb.bin | awk '{ print $$1 }') ; \
> >       map_size=$(shell cat u-boot.map | \
> >               awk ' \
> > -                     /_image_copy_start/ { start = $$1 } \
> > +                     /__image_copy_start/ { start = $$1 } \
>
> Most architectures don't define __image_copy_start so this code looks
> broken. Please, provide a solution that works on all architectures.

This is existing code, so there is no requirement to rewrite it just
to get this patch in. Please review the patch rather than the original
code.

Sam, if you wish you take on some yak-shaving then the .lds symbols
across all architectures could be unified.

>
> >                       /_image_binary_end/ { end = $$1 } \
> >                       END { \
> >                               if (start != "" && end != "") \
>

Regards,
Simon
