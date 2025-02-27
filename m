Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBF9C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A067381111;
	Thu, 27 Feb 2025 17:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ep6EqT1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A66B81197; Thu, 27 Feb 2025 17:17:30 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243D7810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so12435045e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673047; x=1741277847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VQImvd2hbaJbJjXDXwGdD8q2ycRL8Md6sl2iHN7BnFY=;
 b=ep6EqT1lxxCfkFHkUiXpEKqv1VBK8wwSfEWG7LZ47wbwlpZjcDqyeruCZiT+DjjAOA
 iVlUV2+IJ2cZJXBuJdDK1Bmjt+LJDlJ/PJDvJR9qXipzkOVzk+atKeGhdGCLu9pDxSoG
 Yk12w99+SoWJRUQchEOHLEkp8ESQCV3yWcnhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673047; x=1741277847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQImvd2hbaJbJjXDXwGdD8q2ycRL8Md6sl2iHN7BnFY=;
 b=TnYTzN3rXXL4EwU0C89P10Qw4I/YhDh64h/5V2gkmJvWQ0Xi/Sr/9VF8eer8QOsiNM
 GbVUQZyu5HgZ/c041qBX/EjzZ4zJ8Z6VM4VOZLI75fagZNgldeofRRfNwIWwEsmzFJQ+
 y8GzhFfDLS/6w6EVA8JdjpLvuEaGjqhbOfOtQjRdJjf4m5rVSQmA0elNRAsHE74t/G6B
 7INgAwkB16drJ4xIJ0kkI1XmtTWOACAXxi/37gRlYbJXW9t88+RwZYhF6TThi3bbVXGL
 02hyyua1cHLGvXz4Xu0JkItSYURXnfZElz/+dq+JJVYPeYK7KdIdKZFcgCsy4HfZ9OcP
 WRxQ==
X-Gm-Message-State: AOJu0YzgHapyItsN73pEsuN55KG0decIv4/4OPST+U/Lb0zCMJaXk/84
 JGf8PQFDd1qhIvL1EHKByzm+JX4ivqKczEKRZptQbHFQpLIO5rHdFT/0epTWTigLq/2L5ZCtMIA
 rHAApbo4LrjJSzME7oNWM+lwg51k6xWZUy7Cz
X-Gm-Gg: ASbGncuwhENc2/4MxJaZNhpLRbZc79S0X17Uz6pQ/YnAP1h1EoSvLnuLayBhTKbxwft
 uZK+LMQGytPI7ewGkS7LGqCb6QyPmE/K83o77/EUe/iD3g0Ft5mCp9fJSFzgtYu4RxzPHgQKo7+
 Dvj5avrrOL
X-Google-Smtp-Source: AGHT+IGTFowW6QE7egogMmjgU8ZgRBwcMti1K/MKYESpBgiKQ9h3cW/tIS/J1zKuiaZ2AQPOoSMhBx13ouHcMF94eeg=
X-Received: by 2002:a05:600c:444d:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43ab0f2dcbcmr143375595e9.10.1740673047606; Thu, 27 Feb 2025
 08:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20250226162621.2681677-1-sjg@chromium.org>
 <20250226162621.2681677-3-sjg@chromium.org>
 <20250226211335.GM2640854@bill-the-cat>
In-Reply-To: <20250226211335.GM2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:17:15 -0700
X-Gm-Features: AQ5f1JpR0s7lcg2GbHuing43AjuLlBWHJgzEAJEP7aw202BlqoSSucNtzCcUiu0
Message-ID: <CAFLszTjCQUb=vcNt5m9TqJC0AGcpEOanYwf7kOZoBS=DQDoK_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] samsung: snow: Use BLOBLIST_FIXED
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>
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

On Wed, 26 Feb 2025 at 14:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 26, 2025 at 09:26:15AM -0700, Simon Glass wrote:
>
> > Snow requires a fixed bloblist to operate, so re-enable this option.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 864106f3c47 ("bloblist: Make BLOBLIST_ALLOC the default")
> > ---
> >
> > (no changes since v1)
> >
> >  configs/snow_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> > index 7a1dc80b1cc..f9fd76daa67 100644
> > --- a/configs/snow_defconfig
> > +++ b/configs/snow_defconfig
> > @@ -33,7 +33,9 @@ CONFIG_DISTRO_DEFAULTS=y
> >  CONFIG_SYS_PBSIZE=1024
> >  CONFIG_SILENT_CONSOLE=y
> >  CONFIG_BLOBLIST=y
> > +CONFIG_BLOBLIST_FIXED=y
> >  # CONFIG_SPL_BLOBLIST is not set
> > +CONFIG_BLOBLIST_ADDR=0x43d00000
> >  # CONFIG_SPL_FRAMEWORK is not set
> >  CONFIG_SPL_FOOTPRINT_LIMIT=y
> >  CONFIG_SPL_MAX_FOOTPRINT=0x3800
>
> I'm not going to NAK the patch, but:
> - "snow" does not require a bloblist to operate, just to run the
>   bloblist tests on hardware

That's right. 'snow' is the platform I chose to try to run more of the
sandbox tests, although I haven't done much with that.

>   as implied by d985f1dbddb2 ("bootstd: Add a
>   test for the bootstd menu"), which also don't seem to run anyhow?

The bootstd tests all need sandbox at present, since there are images
required. If you were interested in my idea of building the
'image-setup' stuff into the pytests, then we could change that.

> - We could just as easily continue to use an allocated bloblist if
>   CONFIG_SYS_MALLOC_F_LEN is increased to say 0x800 from 0x400 (which is
>   the same size as the requested bloblist allocation).

OK

> - This very tiny SYS_MALLOC_F_LEN is just the old default value from
>   when it was bumped up to 0x2000 for most platforms and is also safe
>   from a quick test.

OK. I didn't get time to look at bloblist last weekend and this one is
not looking good either, but I will get to it.

Regards,
Simon
