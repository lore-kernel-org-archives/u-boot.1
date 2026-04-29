Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B7FFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FF5848A0;
	Wed, 29 Apr 2026 16:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CO+UUTx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4658848A9; Wed, 29 Apr 2026 16:24:08 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3088489E
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so16208499a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472646; cv=none;
 d=google.com; s=arc-20240605;
 b=lnP0qycG1fQbIQ3ovTxxPGesx6aEH4Duwi0KxCuG4BbUoVR7F4ddQ+3i6Jp7nRQHce
 hqxb32wN4SxY7+8IBCVgv8kUyYLi1pb5vJ9Z296QRPDRu9+TqbznRIly67QAPECQrriU
 Ajq2SDEIN813nfNhCG+t5W6a7gGlRWEZ+PFgp1X9bGwcUpy5x54EvSV0/bP9m4+b7XS0
 ZlTeB7WkIF9OO/4E4Kp2fBfxwkFV08SnsKpNDK6nKXf5PomcblxYC9mfTjheYDompHPd
 kbyW43SsVB6kxCTo5Qi7LbA/BjHKyahjGElzVC7aPKCQHdFXkowRLv0tLQVi6r0D1XZJ
 HCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+yg51scI8XVFo5DX3YOkteK35ztzxduU6L3M6fbNOYk=;
 fh=ogTju0zVNNdWq7fLA5CcYqbgIfSAakEYKqfLLenscwQ=;
 b=OB4ruWPd21+/rzyhYygLVWz1qV6wl8LWvPnbila6AuvlX2uYw4TrOr62/mbHinb8bN
 /SCKhRaBqdSnOTVfjbx2amC60flWxbzcLmJ07wD/TQpLNF5qGHrrtcRv51Qth2qAGM8v
 hrmc0CHcINaezNE1bfvqT/AOdIoqs2j1aFm1IMSjV8oB7bGXFnbidiGqgJhpjicUQ1cM
 zzw1g1NIbvQqGEdi2mLPzdEnJEt8czfaHhRKYysmtAc4Z8jMRopuePW9JGfcj0O4AYjO
 D64QBmS9QugK2lyYwjsW5+xLhagxuHpBtRPqVIX/ojpvCfu7NADYje8QUXSSSYNc9cxl
 uB7g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472646; x=1778077446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+yg51scI8XVFo5DX3YOkteK35ztzxduU6L3M6fbNOYk=;
 b=CO+UUTx9eMq0/EUkuVGN5AJkT7NJgCXCUfseo6+TefnIkkdO6yJ0qzQxFR7YPCw97G
 sxvFEl2UITFYgRGy4rEz4wr2VOCQslwozWcFEyh7gaNHRD6NgN5UHQvr73A3SnVnuEvv
 hQeROdgphThuUWjapXqzVn7ZHr7w1y1xpSurA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472646; x=1778077446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yg51scI8XVFo5DX3YOkteK35ztzxduU6L3M6fbNOYk=;
 b=i/QHs090sYqyHQIM5onmr7eSw6zi0+wWdW7XwS2Vu61Xd/C9u9tkXfTzS3dOaveeGa
 WE/u2CztyCKrrUV0ySHNYYLBW9S0DzIcWtWaHo+QM0iHJb2LMZlAughfhf9tZXTi6RxS
 IUyt2uT8/RVbPGvOtev86DMmmNulIvMxMMF+FHJkyXGdpZRIljGQBHekp8M6JXnTq8Ef
 6a4veFAryPcIWS6vc9p2BmzLfza8d5iK38d4ud1xwhRxosH6OwoQA4W3Jl9GHMfGk/bI
 U6OMS9aNCQMDNu7ig4mdCGMngIIofYjHznW9Z9rOCRReKNTixFdrYZjVyfRCwFOR4h8x
 AZJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BQjYtFzOwmnxblr52m+WOYYa9IrJNRZ5GHzN6QNclS+tLZ6HJ7QRPtFQ70Lb7IrCdOntcJyU=@lists.denx.de
X-Gm-Message-State: AOJu0YwJGXNCTqt8rDjUtKBH7exmKNOP2Xju79ixYX17oiIMm6UvvQqw
 AiIZeFB2mRlnA1pctXcgSJsiyvN7A78SpHiebQtoRGz0gBsL5xRu0ltdJNXiFMlYoaJHRaQezSg
 3pvzaiQAceSR5ZT4QzRWlWufnyn9p3TQYNqWoEHZ2
X-Gm-Gg: AeBDiet9HE3nwK1P6oTwcEFm98j44LIG48n1VifP4cBEDci4+/fGsgARWdfNg1wNwA+
 w7dDk8h9cJq/VPHNjC8x471HQSmVXQAeZ2D0ew3E3OuQpPRGBmqji+x7xrWwYfAHFLUNG/Nxqb1
 kbAtNSV5dBGMSURJinN6U8FTTNx5zhWhemVoWyXJj+LD0LJhxg9tSfV2IWw4yRZhX15xjf4GHOK
 qLc0DpVVaMG7EgtTVyEolAYiJI7TjIXF1qSVXNTl/YTQ7FjxPA4R4+ZPHZn9YrCYxGOKFQIL3Dr
 nqG/rRD9JUJoYcdF
X-Received: by 2002:a17:907:8dcc:b0:ba3:5d15:502 with SMTP id
 a640c23a62f3a-bb8022c26e5mr535256566b.9.1777472645956; Wed, 29 Apr 2026
 07:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
 <20260427195405.GL41863@bill-the-cat>
 <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
 <20260428140606.GR41863@bill-the-cat>
In-Reply-To: <20260428140606.GR41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:23:53 -0600
X-Gm-Features: AVHnY4L_iJOBk9Q0thAGPqyH8UH0PJ2Iqk3_uyQnf3uhbSCmmy5omKuiwxOEBZE
Message-ID: <CAFLszTgBzgYYF8s9u_5=-4Yd-zV5Z+wNF5SzP6M+MSowRreJOA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
To: Tom Rini <trini@konsulko.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, afd@ti.com, bb@ti.com,
 anshuld@ti.com, hnagalla@ti.com, 
 jm@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
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

On Tue, 28 Apr 2026 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 28, 2026 at 04:26:31PM +0530, Beleswar Prasad Padhi wrote:
> > Hi Tom,
> >
> > On 28/04/26 01:24, Tom Rini wrote:
> > > On Sat, Apr 25, 2026 at 09:07:32AM +0530, Beleswar Padhi wrote:
> > >> In cases where the 'load' property is not defined in a FIT image node,
> > >> fallback to using the data address returned by `fit_image_get_data()`.
> > >> This enables FIT images to omit the 'load' property during FIT creation.
> > >>
> > >> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > >> ---
> > >> Cc: Simon Glass <sjg@chromium.org>
> > >>
> > >> v4: Changelog:
> > >> 1. None
> > >>
> > >> Link to v3:
> > >> https://lore.kernel.org/all/20251231173621.1069988-2-b-padhi@ti.com/
> > >>
> > >> v3: Changelog:
> > >> 1. None
> > >>
> > >> Link to v2:
> > >> https://lore.kernel.org/all/20250506104202.16741-3-b-padhi@ti.com/
> > >>
> > >> v2: Changelog:
> > >> 1. New patch. Add support to load images without 'load' property.
> > >>
> > >>  common/spl/spl_fit.c | 16 +++++++++++++++-
> > >>  1 file changed, 15 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > >> index 46ebcabe56a..87d01b8b8e6 100644
> > >> --- a/common/spl/spl_fit.c
> > >> +++ b/common/spl/spl_fit.c
> > >> @@ -799,6 +799,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> > >>  {
> > >>    struct spl_image_info image_info;
> > >>    struct spl_fit_info ctx;
> > >> +  const void *fit_image_loadaddr;
> > >> +  size_t fit_image_size;
> > >>    int node = -1;
> > >>    int ret;
> > >>    int index = 0;
> > >> @@ -889,7 +891,19 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
> > >>            if (firmware_node == node)
> > >>                    continue;
> > >>
> > >> -          image_info.load_addr = 0;
> > >> +          /*
> > >> +           * If the 'load' property is not present in the image node,
> > >> +           * use the FIT image's data address as the fallback load
> > >> +           * address. This allows flexibility in omitting the load address
> > >> +           * during FIT creation time.
> > >> +           */
> > >> +          ret = fit_image_get_data(ctx.fit, node,
> > >> +                                   &fit_image_loadaddr, &fit_image_size);
> > >> +          if (ret < 0)
> > >> +                  panic("Error accessing node = %d in FIT (%d)\n", node,
> > >> +                        ret);
> > >> +
> > >> +          image_info.load_addr = (ulong)fit_image_loadaddr;
> > >>            ret = load_simple_fit(info, offset, &ctx, node, &image_info);
> > >>            if (ret < 0 && ret != -EBADSLT) {
> > >>                    printf("%s: can't load image loadables index %d (ret = %d)\n",
> > > I guess the real question here is, does the spec allow this to be
> > > omitted like that?
> >
> >
> > Could you please point me to the spec? I could not find it.
>
> Sure: https://github.com/open-source-firmware/flat-image-tree/

It is mandatory for kernel and firmware images. Instead of allowing it
to be optional for 'kernel', we created 'kernel_noload' some years
back.

Which image type are you using in your case?

Regards,
Simon
