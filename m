Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374CFCE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3D886D48;
	Mon, 25 Sep 2023 16:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H4UW90Ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A3E86D48; Mon, 25 Sep 2023 16:36:07 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC1D86B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d7e904674aeso7752455276.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695652562; x=1696257362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qh/6pevEX68H4rr+xgTcJhnWAKJTWpM+FC0PK5gj5bI=;
 b=H4UW90AxkOVHtp8653PtICEl1xulRYb3v/I78U09uuP+Xrz15Ev/HES1ZLuLMusesL
 LRnzPIFpC440vDTooAgV5/ITGq6f3ZB+TRxQWkNbH7IJBUE/8WsbYxHvPljzihvwhlxe
 RvtlqgP5hk/BLgttpLkePbPHm2I90ppEEXJAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652562; x=1696257362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qh/6pevEX68H4rr+xgTcJhnWAKJTWpM+FC0PK5gj5bI=;
 b=eGFpkGHq3rlVv8ZtrLbBOwZaNXW62r2Yko67Z75iytKFm28pSNh6sJsiTZ7EctqOr1
 kJp2/2WbU8pwYT7qLz/Je51Uy7QrLr2GODsgdjcEVBsyQioO66UuFOrvz4p9LGitBvjr
 a+hKF0RGDut+qNe3K+ZtWkeCQH2ZKaxysGF+tGnnvMr9VD1B2bjHw18yMxQKLyR80oUL
 kOADyYlAQfx+9L3nYRO3jz2kpwktB/SVTQKa+NRqU3glGjWjerBwStE3Yd6Ox+N0WO8y
 J/4hIGqMF0PP7ar9vUdJCujRs5URw6Ku29f6KJxusZzlZASz7dBkkRovTsVy4SRt9TGY
 eyjQ==
X-Gm-Message-State: AOJu0Yx4n2qQKVMCXRgXBt8UkcExWX/CgyMYGodZIUaok7CciS+EXy9R
 Yueh0fMd9POaYWJNMw7pjzVtOn4MYQBFrCcdkzPipXQz2QTxb5iOc98gKA==
X-Google-Smtp-Source: AGHT+IFEKExo5j2CB+FEWvPy1+8kSBtm1+4GS54mTgG/74yOZM8TRglX+Z8O/u+iDEHkVp3a8d0QIosjZB2N2z04QjI=
X-Received: by 2002:a25:d04d:0:b0:d78:2431:177b with SMTP id
 h74-20020a25d04d000000b00d782431177bmr6658484ybg.13.1695652561518; Mon, 25
 Sep 2023 07:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230925023958.1913268-1-sjg@chromium.org>
 <20230925140838.GV305624@bill-the-cat>
In-Reply-To: <20230925140838.GV305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 08:35:44 -0600
Message-ID: <CAPnjgZ2gBRWt6v1i21Mq+bnqScnHYKATCURMtJ6E7DGspOdpnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] common: Remove a few more header files
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

On Mon, 25 Sept 2023 at 08:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 08:39:49PM -0600, Simon Glass wrote:
>
> > This series removes two more header files from the common.h header. It
> > also tidies up code style for time.h functions, to simplify similar
> > maintenance in future.
> >
> >
> > Simon Glass (3):
> >   Fix code style for time functions
> >   common: Drop time.h from common header
> >   common: Drop linux/string.h from common header
> [snip]
> >  1709 files changed, 1854 insertions(+), 34 deletions(-)
>
> This is where I start to get worried we're possibly taking the wrong
> approach to the problem.  Perhaps it would be better to:
> 1. Start finding headers which include <common.h>, remove and fixup the
> breakage directly.
> 2. Move on to removing <common.h> from files, a directory at a time.
>

The bigger question is whether you want common.h gone or not?

I shared my script with you so you can see what it is doing. But if a
board uses memcmp(), for example, then it needs linux/string.h
included. We can discuss why so many files use string functions, or
whether the script is not perfect, but ultimately that is the
question.

Just these simple queries give you a sense of the scale:

 git grep -l strcat |wc
     45      45    1134
git grep -l memcpy |wc
    834     834   21643

If you are suggesting that we add fewer includes for now, relying on
transitive includes in header files, then I don't think that is very
useful in the end. I had a series a few years back which removed
common.h entirely and it foundered on this same issue.

Regards,
Simon
