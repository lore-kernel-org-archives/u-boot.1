Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCFEC5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 06:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ED2580C36;
	Thu, 27 Aug 2026 06:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDj9jQUfucT4; Thu, 27 Aug 2026 06:15:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787811318;
	bh=i5Fl0QSyQtNkAIvN1H34QwhA3OWPnEanmUhNeaUmJBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDcUXWYVZkJChhIhV8rHbmOkVOXdMNkXxKIyIJHw3jQDsbXZ7j9BlEA3SiB7dHUui
	 RMgyrKdtq4qT/WgZ4zupACBBL/qoogjXVEDQtvV+lEacKAns9SEHA2qTuCbaazjTsC
	 eUE0QRHCZ/VhwwPqdQl4JeAsoVuqUky7NRLSWutdiD9cMFgVwto2sdN+AGsrCrGJb5
	 B2HvKv70a7sTqPTJFzYhAj6PUH6cEbHb/ht+7GjDDLC6l52DBN08c/WTQgftvX9Lg1
	 gge2hgDVwasczMyZSL624s5xQSen80SoE/A3EHCmFXs5HqtyoyGV0ggO0AkJCxxys2
	 Qh25LyLGZw79Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C87280C38;
	Thu, 27 Aug 2026 06:15:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 694E239E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58B1C406A3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fa5Xr-P0JvlS for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 06:15:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bJV3qnei
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AF08406A5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:15:14 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-836f34a0ceaso14928917b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 23:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787811313; cv=none;
 d=google.com; s=arc-20260327;
 b=FIfhcZFDJUYQZmuWCG2FXldncWrs8eKv8Fhvw4xxdWRMoPZJAdrUQl3/Z6dgvGDVUk
 qTn1RGTwlY4y/6i8AL9X45y9oJcSmWF+9o9SNisRnyQ91Ih1BWGWdNpxa9m0X4cS23Ha
 qi5IfMdV2rPhAFvjE3BKbWGj6OUzd2nAWhWDZoqcxVdvSuURQ9o/o5Gkl5hI3W7vyFZ/
 h8fD2O85ua0bG0l7PUrgIrpi0TezuXCJfBHxAJl8LJqMsv+czdvsv1fbOmB7UUrBb5de
 zS5sZ+xBRvnAD5rxxN39b/Df6NjZSZnaWpC9ISPeAOE/QMQ6NnYsNf9krOpsLrsRlBqc
 bSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i5Fl0QSyQtNkAIvN1H34QwhA3OWPnEanmUhNeaUmJBg=;
 fh=0hOO+/barOgVZ6sGZ7s40W3u5dhrHc6OHj38C5R8rvc=;
 b=W+ljWw3fn+M9WPJS6AvtJ6ZVkNxsLAvtgi4J1qAvKnlHKSnfqUlkGhY3Yln2HQVIJI
 SS4m6sp5fKsw0IUmdb6L74Sb4/sKBgdQJuq5rVZdQhAQKJxVWJcXOmWbeMbJsbirwqqe
 E+XzZKZMEJtZ5HHQN/f7qWupAWqZjiuucNKWa7BEYL5TqAEr+DMLsnTu7zzz4QbbM5qY
 xva0Dc0Gebx6pbiiKc6rUG77NXKKo6lIrP2o7/UbhoszW6mmn60/T4FX0SjoB4qurzF7
 zG0sgaN/fEbp4OjTw5BFUwTs3gTvxSSZq4hqXY8AoB0O8EDkf7kPXM3e/ZTDegaeZ1Hs
 2v+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787811313; x=1788416113;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i5Fl0QSyQtNkAIvN1H34QwhA3OWPnEanmUhNeaUmJBg=;
 b=bJV3qneiVkInAztgWBSpJvWs/IPi+vyDvm8J4lesZPCV0oE5ccjWWiGY2CwNfQXWS2
 gkwKi2fLLQchLbaH7ze9PB0u1ggbtYFGPETO8wyrMkNvPvrti+VTTiNZkFx+K5OXhYAK
 qUsIke1m6YCkHqHoUpweNFJHtESVfbBET6vQlhpoSeN6Aqm5cyl/fEuXJaqGDaMMLf+h
 KapgkTngZQ9hg8Jo1slZ8YcYpOlkasvkoxWyVGa7fEmf0H9dm1dkhL9AkgXtJewxv1aO
 W+NVAcIPZGBQCuDIwGjvLj2MrqOKojDMSmCBb4sEXyBc3nqz6WwHaDw2o1cXj7Fw0Rlc
 B5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787811313; x=1788416113;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i5Fl0QSyQtNkAIvN1H34QwhA3OWPnEanmUhNeaUmJBg=;
 b=mltBK/fM/FKNqHcbKr0Pucy5stqY1QiLubkeycx07vl/QWBEPi7lICwJbBNz5IHm6Q
 JhAASudwgaaeM2Ek0XLlvMykij2qGIIRTVbH8osedCqte/zlZ+jufnsQrXMgRBNErwrh
 DSlV6aX+oFkwR4l7oGXeBRLKnbQmi+DXk3kmeM6tvWigeY6yGK95WRkziGS0gBHgEp8S
 lHpQcGmJdLKSDP1oCCwlH3H6YyHbLzomPBQv8hLXisow1s7gs/YLosqvwWbXbB6yGU3P
 aUL0Yst6JlIw40qm+wHxds8vzsCOBdmTzVGWWrVerrRD8YOgInyq7u0lSzQZ1zmmTbL6
 W0fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRCdoltwGpqWKt+GYxQvQQWHn9Evn6+FNQOaUxjk7O6gKfMO3DJAULbvYe6VC3LhTr8uhClPo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mbo/7Yp5bKD7eEWfvqXY+JQUWqRdF/9bVZYeD1GRjHXF8We/ee
 F2S9kFDarlv3bkcSHV4/CAaKgSxi3OHWcwS0zdUyDhYceDq+wcERi3A/PEfNrPbJNGUQLGDl6AV
 PIowxDQ0x16g53GCPuNUSXARthjkJgrT4XF2SXNYJmP/2VF/ezWDxvAw=
X-Gm-Gg: AR+sD13trJKzXlDJrdHQSr1k9c/ASgRZ/9gMoqcder/TioEzQbwv0OhqPmB/8F8rsbW
 uhBwNiQjETUnAlxCZ4voSP/a97WwDCMYm5ZQKyQFXfSZe873KzAa8Wuc1gr2mQKvFTK4r6hTtZE
 zcHaiXmxQt6y+oTuBAJmnIMboNwhhGGJpNAMSAmoItjW5j5VvQDsrTrEmMeW4cXz3kZbXQlTooy
 zxT/LTeizIPd7/YvK4DmuY4Q5pEesDLufA7TgOADjrP1nNuxYi6BeMX46UN6CtO8l3L8oKRE8X+
 JETqQbVEXSnNpzk0gO5E0iCViplTq1kKnb4vS8abQAo5CHqVKK2CcDXoqevnLhmdwts8PJ1U9E0
 aalwcudWlP68GdIRcQCZ+rFZf4EOF13hFUKXdjPkfF3wqRmwnEJhN1mbOyAks51Oi0xavyEFLV5
 XB6vt5ZLMsNYOlOvPOsKYt0tqNtPkc9hZ6O/DFseJNwfT/HBEettcLRJr03o3LfyV2wxiHZQj9F
 U3G+AX+kC3COcLw/mRf1D5WHD10c313YK+b5jT5L29alBfNG3ndvy9eekzeHXZ6tY2FPBQImonE
 CcBjJZro8baAVT6aknxlvmzD1f9PWEO4cMxSg1WrPivqBxknIojFwbV6qqASi2k/mr1Pl72IIK2
 5bs5L09D8rX9Ay4QQ8p/k5krjgSBxWaVvbAMOM8JzMMlArAblfDNO2g==
X-Received: by 2002:a05:690c:6601:b0:81e:fc6c:452c with SMTP id
 00721157ae682-85aa00cc539mr19837537b3.9.1787811313516; Wed, 26 Aug 2026
 23:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
 <20260820130746.164424-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260820130746.164424-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 27 Aug 2026 09:14:37 +0300
X-Gm-Features: AcwNN1UA2ZsAnwfysTZzbA8UV49uA2HdRL_T-nWU0LvZa2hkvs6e5hWWxtpUVME
Message-ID: <CAC_iWjLFuWJApD0EZmgSWUG1c5F5vVoMGe8u0cNeB=xjGcEiVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: consider type of platform_get_rng_device()
 return value
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Heinrich,

On Thu, 20 Aug 2026 at 16:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The return value of platform_get_rng_device() is efi_status_t.
> It does not fit into an integer variable ret. Use variable status.
>
> We already write a debug message in platform_get_rng_device().
> We should not repeat ourselves.

I had a similar comment in patch#1. I am fine fixing this this way,
but shouldn't we also remove the second error message in
efi_rng_register()?

Thanks
/Ilias
>
> The RNG device was available when registering the protocol. When it is no
> longer available in GetRng(), this is a device error and not an unsupported
> algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
> return value of GetRng().
>
> Addresses-Coverity-ID: 532068 Overflowed constant
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_rng.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index 9c5a60ea963..6c1c5f0be60 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -105,7 +105,7 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
>                                   uint8_t *rng_value)
>  {
>         int ret;
> -       efi_status_t status = EFI_SUCCESS;
> +       efi_status_t status;
>         struct udevice *dev;
>         const efi_guid_t rng_raw_guid = EFI_RNG_ALGORITHM_RAW;
>
> @@ -125,12 +125,9 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
>                 }
>         }
>
> -       ret = platform_get_rng_device(&dev);
> -       if (ret != EFI_SUCCESS) {
> -               EFI_PRINT("Rng device not found\n");
> -               status = EFI_UNSUPPORTED;
> +       status = platform_get_rng_device(&dev);
> +       if (status != EFI_SUCCESS)
>                 goto back;
> -       }
>
>         ret = dm_rng_read(dev, rng_value, rng_value_length);
>         if (ret < 0) {
> --
> 2.53.0
>
