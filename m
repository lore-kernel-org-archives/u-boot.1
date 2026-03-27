Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F152E10ED65C
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F2183DA7;
	Fri, 27 Mar 2026 13:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f++j3ejt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D417183E7A; Fri, 27 Mar 2026 13:20:22 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E28783C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64eee7b83cfso1720059d50.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 05:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774614018; cv=none;
 d=google.com; s=arc-20240605;
 b=G1yoR7PcvX4HVMqh/BAAflKxqwJA3I1DhkscwHzOxkhW9akZrsADs3nYvzjMV1dXpe
 krlWnnTXSqry+JJkv0JIcN+DLTFMOaoE4vTkBeIuCFOOEZqvmnKjSnZFvjbvTqsWT5Sf
 5EYHQhpTALN5jOOtog/uo1vbP3CqyKZkx+FUUxpnj2aR48Fofj85fEog8u5m6kPGM7Ql
 1uqD4riqrFZE00NU0Vf3uHdoqGGAoA7t4DCn0fkfzCGKKR9ya1J3J7cPmreRygmFydcX
 ykt3pg5MnzQuImB2GNumkbikunffUuqcqYLHctvVT3JzH5DIriSis3AFdKYAgWt70Pgh
 49SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PPwzwVIagWuiP2pDcEE4XS2a+EIX8nNhul+zOo/5Pw0=;
 fh=tAmIpV/Lj6K8EJOARh4gTKLo3PwN+Y7GAgBam+xng9s=;
 b=YizgSwCLp0A1RrWMomih24/L0mn9qCrhnl3pEpMxkedf8wFfgC+6DVuGCOMFCbN9b5
 +xa46n1D2IqkgWOIm8MlL/7m8VpIK1dVCldCA2IsRohPlAWGx89qKyckxNoahzcv+LoV
 zGGQnVulFP71DuKdX/jz5p8Gy8NKviaiOajgt15Sm7X0KLqHUk/31Zl1V5UtqSWCnUX3
 zXpg0p5OkefGH/NYgeN0Tj0iY6ZLHg1ZykKz3rtbIWl8Ao7q3co/NMRmxDZWxTN+YzE+
 ldQ5PIZn3Q7vew4v//J1XNuNC4luYnxbdBZdD+cL9n0bDGtfBKlnvEDY1TZe1M6deJ+l
 j7Yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774614018; x=1775218818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PPwzwVIagWuiP2pDcEE4XS2a+EIX8nNhul+zOo/5Pw0=;
 b=f++j3ejttrg7STflK2rRsorX4DI9f/Y+BYBgYfL0VTcAehkUJZZ7O4fI9WhbPUzD1Y
 DSXsetVTYnSMZg9sBGpT/xk5jjeCgfBHiJsUnCcoYDWstgurC1wjTGal2AAFCjQ16f8O
 s2LC7lyVwQivLadflkUM+GFqjwVnLAGnE3fvC2fLvyKPxr6mH3T9QeGK5gscQEwCCYlS
 KKWR6SrhR7h18Hb0jehB/tYYUhYR61yn2K5M8LSiijxTO8CHoshWcrnb9vfHecLzTqw8
 jtnZ2p6hGZiFmYLsQo4B3DADHREdOJ49/MNf8c+6ggjrZDxezBj1LLoX3QYhXlz7V4Fx
 dq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774614018; x=1775218818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPwzwVIagWuiP2pDcEE4XS2a+EIX8nNhul+zOo/5Pw0=;
 b=jNUIyEHgwE4n2Bv47P3T5AefrrgllOC4CxZ8WK9koG9uvyrHnn/TyjNF9mbDuHo2+M
 QoBfYJ5BDUS6r+fq2mLWtNrJz5jdssquVZcCckptyKv7P/IOSwYuke/uLhLmsvFjTcmX
 loI0F+VhxYTOAqx6XKV95sSWscZOoRrLyuOYTFY+0t/01eAur5f05+KYxSlW47b0Wy9W
 rLzjPjUEDyAR/lNggYW1RrkAipA+vFI4iInuesRtLcvbl7sY2OsgodiywNy2NGonOFXK
 2Vhyj63BEtiDyJpheskA80Gz4eZYtlDiLhPKX5JC9Uucmg91Y4px63gWauNScRagm0Nn
 mtbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7i/eUjEaXyGb9TxPyb2w1xso19v1GGV5qqUDkgT2FUvh8jkoI/mDYUYUBkz5Vzfvu+qgrxk=@lists.denx.de
X-Gm-Message-State: AOJu0YxmujL1F2DjkQBPnwj3G+EE4Kp1YcIJbbAmDxGjnDnba5MrbGox
 xU/Og6lh83GJNalIf+9GUgaATz0UkZAznNBYnycZSzWMfPSmjbzQIcmpae3QJZL4nMImQVtr6za
 PBygYKCiqA02lCmgtGfkt+oH7FLbWlUVbZxssg/QTAw==
X-Gm-Gg: ATEYQzxrCHmybmAvzVdYQ+Q2NzhQ0lH08DuYYZSH7ta2nmZa1rFKf6kBbCS5Kva7X39
 Sq9Z3rc3Cm96Cfw1+vmHnNRIVbMdYSM7QUVcIsEq/wXM5zIDLsuwGqGaoXu39mOvqrf+ehe/Oih
 6c58WqiK5Nly5cXZh9iSQvveB9pudpqfgGDEvaZzK3PvrrEujseb66MyQGLh8weExvfxwApdpHP
 ozeFNy7l+ZBY2juGVB9XYzQvgux7WaEh+ZbIWSbE2ZpXE7KrNx04gKmXo7x6QPWm0ZR7fcTcgYB
 hepisW9u7yZ4N5S/5PCb9ftxL2HMbY+08QpfdclS+I1FnA7JTRE8oDRsZLoNjSeo0NHw3fLyeed
 qzJNbTsBzRDDwveSVGQjzpGnKp1RbCXmG9P3wBt3DaSoBrC0LZLQUhmfNftCWHlx2SXIGv6imsJ
 jw19cyPVtcaZDipzWOpmdI0DWg9LW1h5jSjl4zFJG8EDJmU2dE+t2gWDBAHOXkXbQ5Ifh56h1c7
 dBAwjpycbPJG8I4rw/qCPRkwxY2vMd+fu2qPsyuI8fmftQcthh8zkIdQ65yOdU5XxTFnoDBOIVb
 Q0mUk2orAHsxqDd4756tbJP1b6bwG9pJf46TubyldRFx
X-Received: by 2002:a05:690e:4009:b0:649:d5ca:7988 with SMTP id
 956f58d0204a3-64ff73d9a80mr2311901d50.48.1774614018467; Fri, 27 Mar 2026
 05:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-3-ilias.apalodimas@linaro.org>
 <ce171493-712b-4551-a895-a45f386180f0@mailbox.org>
In-Reply-To: <ce171493-712b-4551-a895-a45f386180f0@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Mar 2026 14:19:42 +0200
X-Gm-Features: AQROBzBcPQwQCnxiK7k0kTWRd1Wbe_KOlRsx0lkB8Y8ghzf2thn3LfLvQ9gJnSI
Message-ID: <CAC_iWjJEOntvBAL8fPhJpsabGBcVVq=OXkbOkyh6OgWottkD5g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Marek,

On Thu, 26 Mar 2026 at 22:40, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 3/26/26 12:51 PM, Ilias Apalodimas wrote:
>
> [...]
>
> > +/**
> > + * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
> > + * available in any memory bank
> > + *
> > + * Decode the /memory 'reg' property to determine the highest end of the memory
> > + * bank and populate the global data ram_top with it.
> > + *
> > + * This function should be called from a boards board_get_usable_ram_top().
> > + * This helper function allows for boards to query the device tree for topmost
> > + * DRAM address.
> > + *
> > + * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
> > + * invalid
> > + */
> > +int fdtdec_setup_mem_ram_top(void);
> > +
> >   /**
> >    * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
> >    *
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index d820f75b031d..c5ee2ecb3a49 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1162,6 +1162,26 @@ int fdtdec_setup_mem_size_base_lowest(void)
> >       return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
> >   }
> >
> > +static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
> > +{
> > +     if ((res->end + 1) > gd->ram_top) {
> > +             gd->ram_top = res->end + 1;
> > +             gd->ram_size += res->end - res->start;
> Since this is called fdtdec_setup_mem_ram_top(), it likely shouldn't be
> manipulating with gd->ram_size ?

Sure. I don;t mind either way. We either rename the function to
something more readable or just add a new callback that updates the
sizes.
I'll just move this to a new callback.

Cheers
/Ilias
