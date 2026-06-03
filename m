Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D48CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26936844CF;
	Wed,  3 Jun 2026 19:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lxo2Jvn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8438486B; Wed,  3 Jun 2026 19:08:59 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C98683FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so603148766b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506537; cv=none;
 d=google.com; s=arc-20240605;
 b=Q4L1hh4P5cLdhlh6D2I6JWiLtN53y2XyMVbHPN/u4uh5f1RLv4kRtmaFSXZ4VMO1G+
 nQqRVdkFX3eSUnT2SCs2tvvvlG1baNSB88ERTvvmVbcBoPyg/wuB2DZaEpEtQ46c1txX
 ALsPnD7MrvDY33C3tqaSM+M6li4oS5Y76JOf+muYaAy3RXNKB8DiHOLqEFA36nmVqwCV
 VPbfU9yREtCmkj24s+BvlcIV/6EZCvqDuY4uU3eWWhVswKT/WBMEHWy+Ad/BJZ6QhNTK
 N4Yk2We7jt4OKcN1Sds8MWB9TPucLb/MVz4+BHqaux3PtrNZlncBfcMhqpAAS4cjQ67l
 bRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i1inTjWQk7nHCe8oGLVQEup03sMGIlMLBkJBDh6h7C0=;
 fh=Hlhgev5xB0xlM2njeo0mv1AJniEuivCiBjj7I4NN/4E=;
 b=EhmeG41uRflgJwGtboYiyAkh6oGEbOW1RS0K9gFkqbPLtqC2hWPepwdIv3GKLLKWdH
 IudRiPSfWcscZhw70/oCMTmHegFh5EzpcPXhG7qVgP1RKiMHoVmbU/Jiv93hw8tcvM6Z
 Kc4zvYUBnEYGHBBlASFOxJlRatrnojfkkd6QsU0n7iE74IO6/MRrbVhglqffbeWbD2o0
 30zjVz9RA7OaQbgk/a8SdDdqfFkdGA8HYt0Uz8Yp+ulZtpyP9rdL/TmLUWCGgrGrCe1k
 TtxsZQvV7MgC2hNB3VrNZ3sImXUrQ1defsKrm5vgzYekQJFDVcHtv5ZE6GpAhitr4T+a
 Gh2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506537; x=1781111337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1inTjWQk7nHCe8oGLVQEup03sMGIlMLBkJBDh6h7C0=;
 b=Lxo2Jvn/yh7U2uJyhh0RgPyLJCNbShZCV/6fWVAiSCPfU/vTH0nQ9IJyTdq4zAU05q
 DwCSsxwqV1i7XAnmmeUOTaZTJYfMzIvL9ik+wqqu8nfy8KBcL5i/TpWF2DJCcBdEjjY/
 zeCv5nKjjYT4iXUcR83rdFMfKqEznK+txwNK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506537; x=1781111337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1inTjWQk7nHCe8oGLVQEup03sMGIlMLBkJBDh6h7C0=;
 b=Nranq12PNGz/pHEfObKd3t0KMOKL+OFzbWuRKgo1HNGMdf6miUeax9VFQ3IgHJ9a/Q
 0h11wQT9lEk8OSpNSKb8qYKT0296M0lHYmkhpxmp231uKvvX5rXqqZ52OmvMd0bzkHEz
 l37H7Z4a55nI2iVy65Rg2BKza39uV9kwUpmS8+n88VuskY+5NHRTRf8Mf/Gm2yUsmqxK
 4TJ4vrfqYWzKUmPuBVqxJsLDqcF8K+thcn/SrTkzJI006ixj1Kg10qFPN3Tya4sVHuKc
 MVv+Xzzh4nbSzZW9wV+etl5BqMCA2nrEIs5AtEkFj+zE3rsGFZIRjvlwZcxa20gsCZ/u
 zfFQ==
X-Gm-Message-State: AOJu0YzrW5HEmE3P7R6TJ3rtBMnDy3NHZK/VzqI/ppXci6WQ8zRh9977
 j7Jq1RVgzZvVdypMp2MrssX/vCAs4vRgRvbYf8Dx5M07ZBLJPFxP0zNC9demTmcxWxuAlSyyuyo
 G9AMzFLeEwE5bhfaDydVzZU33GRXGAgEYgW+OgnBI
X-Gm-Gg: Acq92OFXWHBkk25V/B3s4ODqNu6b6QnwG9kQOx8GcMf6TMNo/ZycNXCslp1skgBDBsH
 qtV5ydK5ACeCnNpFld3KOJw66wJFHfO04+2Y/VglSGhI9usEAilbonqeQS8U3iQpVsp2kzM5Hh4
 0CORfCDgeAxLgD8WLQE+Cl13D+2tIASzcUMPKHBnERdpLButVIgZDPeZ+b1vmO3nrjFD1sqWqie
 m5jP6h68BfKpka5NjqNuwvmMoQIqiIXXKreWZk+eRHhw5/sna4frqax4fHE43irAM0/g+GNQOYE
 yRhbZ+NnAHKQE5u9
X-Received: by 2002:a17:906:5a4f:b0:be2:3678:939d with SMTP id
 a640c23a62f3a-bf0aef043e4mr153800166b.41.1780506536897; Wed, 03 Jun 2026
 10:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260527112518.16085-1-anton@binarly.io>
 <20260602183052.65247-1-anton@binarly.io>
In-Reply-To: <20260602183052.65247-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:08:45 -0600
X-Gm-Features: AVHnY4IHqK_aylspYvpffXMwfR-l8RNnERYdgCwQHBwzHFYwn4rztb8Simq6TPo
Message-ID: <CAFLszTjpFQLXSJYp-Ceh7XaVhbzWczZKGZAgnPuV1J4kxKGkRQ@mail.gmail.com>
Subject: Re: [PATCH v4] image-fit: Validate external data offset and size
To: anton@binarly.io
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, vr@binarly.io
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

Hi Anton,

On 2026-06-02T18:30:52, Anton Ivanov <anton@binarly.io> wrote:
> image-fit: Validate external data offset and size
>
> fit_image_get_data() uses the data-position, data-offset, and
> data-size FIT properties without bounds checking. A crafted FIT
> image can specify values that cause out-of-bounds read during
> signature verification of an untrusted FIT.
>
> Validate that the external data offset and size are non-negative,
> and that the data region fits within the FIT image bounds.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/image-fit.c            |  16 +++++
>  test/py/tests/test_vboot.py | 165 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)

I think I have lost track of the versions here. But we are now on v4.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1087,8 +1087,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
>
>       if (external_data) {
>               debug("External Data\n");
> +             if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) {
> +                     printf("Invalid external data offset: %d\n", offset);
> +                     return -1;
> +             }

The offset < 0 check is after the offset += ((fdt_totalsize(fit) + 3)
& ~3) addition on line 1082, so we could have a signed-overflow window
is still open

Should return -EINVAL as -1 is actually -EPERM

On your uint32_t question: yes, that's the right direction, but it may
be best as a separate patch. Changing the prototypes of
fit_image_get_data_position(), fit_image_get_data_offset() and
fit_image_get_data_size() to use uint32_t matches what was done for
image-fit-sig: Validate hashed-strings region size. Please go ahead -
it lets you drop the < 0 checks and do the bound arithmetic safely in
unsigned. The callers I checked pass the result through as integers,
so the churn should be small.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1087,8 +1087,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
> +#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
> +                     if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset) {
> +                             printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
> +                                    offset, len);
> +                             return -1;
> +                     }
> +#endif

Please split into two checks so the subtraction can't underflow (if
(offset > max || len > max - offset)), drop the FIT_SIGNATURE gate so
non-signature callers are protected too, and use if
(CONFIG_IS_ENABLED(...)) rather than #if if you keep any config gate.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -563,6 +563,171 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        ('off-bounds data-position',
> +         {'data-position': 0x7FFFFFFF}, 'FIT external data is out of bounds'),

lower-case hex

Regards,
Simon
