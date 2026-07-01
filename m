Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72D3C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F3A84B96;
	Wed,  1 Jul 2026 13:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cOjsZsVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F055184B9D; Wed,  1 Jul 2026 13:05:30 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE82884AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664a09bc459so628593d50.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782903927; cv=none;
 d=google.com; s=arc-20260327;
 b=mGj4GZi/GVFnsK2lO95bnFmiPnoGaf4K4FlguTu+VHml+Cka2IU5TBD4g7wDgfDDMa
 NF42eY4LFMmcUgcOiX5ifp0VVi5RGYJg5unVeOrTuLPfayjU26oNkBLbOgF1tDYAVfRO
 3FK6gLEcJJ49nko+uCKzyAvwbz1wuwRZSUK2fISpI70MHXrr8teTggFC3qVfiDin1Hlk
 GIjVNh5hZSyU7lGA1IA1S57iOS9bcJDz/uVJSXffEQ8eViaEl4aFnMkOZxxo9NcuyQXo
 rOhleluy4opLXYjhcr5t5B4QYe23G0tvXIF8eL7pXuwn9kySILxKliiwiqyxK7S39Tu+
 5+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=axUw56n8TmL929HY32G8f1/MpX0JaxtmYVGqfjcg9IA=;
 fh=dNvPoW+6meLzYkXuqNxSiOVew3EdCu7K9bk/KboZGnc=;
 b=nKLcEzptbc6mZHsNCr41Rq559I4jTKNTf7+KAKRxiNhiiF70XLKJbnmpuX2soszEFX
 IBhNbVs47cuWK2d2oI88VqkECNZ53LVh6vf6QbKl9VXVVHt1Iguk27T7QrUoQDptNgMn
 EhwUG9FKh8zrLhDad8az7+xrL/TlxHz0D2f6PFv38YTd4p7pxD7ybnGiZM3GX/7teFUJ
 zRmV343tymMSO30g/MaIHlVlgS3zL6PIS+ZtOKK9SZW+i1aIoHLR8wOLu2EEUTBxDJe9
 HkUkZa+6t71jv39Q8eUr6z/5Zxeu04mtDDKkmqVnS9YjWCAqUcU/7UaGUKJKZvZBgI5p
 roIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782903927; x=1783508727; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axUw56n8TmL929HY32G8f1/MpX0JaxtmYVGqfjcg9IA=;
 b=cOjsZsVKeaHJVoab90kj/n9jNE/v7zF/UZQNER3rfqNR+SbCXFOun9VgpQO9TU6N8I
 veN7MymqJmN0313HqoofFvs7NGcgIjudDujk+kBRHK2gudUSoL9bsEVxrJmaOav3zlqP
 p66fD0wHYKlzbHfxMKKm0ZzOb2URSWXOugOdS8iarVQ+BIZdLYNt86HKTC2GJdEONfau
 zDmqOJOdFaafdBxLBe0aheIBgm/r1N2dbmHZrU1J4uJlJ+9ajgE20gQLLqnrMl65fno3
 zaQ0FEW1LPMkofx66Kmvov3LJReokRA+tBV3PqQ/Ui9mQp3VPS4Wi76s4LWtD3iA58dC
 4+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782903927; x=1783508727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axUw56n8TmL929HY32G8f1/MpX0JaxtmYVGqfjcg9IA=;
 b=WONEMJm762Edy7Uv8wRbO2T+M8ZDwmX21EnlqNrPbAssinXj4JNIs/N7Q5SGWG6SIP
 av4F4a5dWN6oARvJxwgsOUM91H2OYrESvDnlXhgIvFGuihXSvIAGsPYUm1w40fsbGRX8
 ek025WtYZIjK6d8oeJsZXEnS6q4tucIxXiXkEgLyz5zZ2YeasVRcsvzjUUfHNYgdUS0e
 1ug9iUb3NlDBz6iXNJ3lOjw9n3YEqY7at6BJAXB0YWf4tyhcC2hk2BQ3Ek7O6Qg05RNs
 Fn0fi4/k9cX03WZsyrcYIKbpmkWMpcZkKtEIhMV3i0gGDZQf/t/iCiFJPE4r6tRYbtRA
 uwLw==
X-Gm-Message-State: AOJu0Yxe4q0TC78+mzXbPySWbmBUrOkA6kfVJLS+t7B87QAbhDh5msBJ
 31lb3UkVaJ6ntg6hBc//IsNKy1JGwiVJRW6hFINk3EJt6fkM+lnKjBcEIv0JwEJwkdydK7yC/1+
 /n5Pqn73adb6vKVJzme8DxEGiyWwG0/Ms87XE9Ti3CD4BOHNHQS4W1t4=
X-Gm-Gg: AfdE7clFk3VTW+A0sMJSb81LmUpsR+iz2t1cF4zgepCPxDEmSE/gW4FuL4vZG4p1/VG
 TyedQdyciElXxv4zdU30ciNSFM1LBxSH5PI6R27FUaTAbcuC7cWJHE/wFn71iIGOgTumV8WDkdb
 OFqK/ntJYeTZS3AznLVialsJkztVw7szGDimLyIIF86pDx05zWt2mO4XRpObqIVDHZY+CnsZW27
 LqlH4bt9rMK0MWRaGz3uvyD3+WyS9vbC+fv+/pua2vTrwp6lkbroBimRgOpNceAvdQ6tmOLZu6h
 z3tTY//fYncSxnHIqVvEEm/g2unnztmu8dD/bWfIX2mEtTxjB0QEsegJHKQC4XZVxJqBMy/8W3+
 16WHO3D5GKXOP5j92wam66uGF5CjSCnn4H8i3RMT0wzpdY0jbLwVkMH4gPIh29++kOzLXolb1Aq
 9Q+MxFz07AaqzXwIobEcN91S4bt2WaG8QD6uWP6Kl+j1EqI1zP1MbAo/e51zGtILErrbo6SJCa9
 0cwajzifP7pBr1pJ/f4AC62ZR//9VssmoDY1KuqrQ78TPNinuN++ANptQGr/Fot71atAWTDRjfh
 wbKU067mWMNyuUQaTCDSNl8/a04TRByQg3jOmmS7kfPBoGcKLB6RN7AJu5PUVefVi8ZgejQ=
X-Received: by 2002:a05:690e:1206:b0:664:ae6b:b496 with SMTP id
 956f58d0204a3-66521dc4ebemr1077637d50.75.1782903927570; Wed, 01 Jul 2026
 04:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629080241.36311-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260629080241.36311-4-ludwig.nussel@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 14:04:51 +0300
X-Gm-Features: AVVi8Cch48XkcyHMdKWkODmuY18FrnzLSPT5gaTjLn-jqguJrGm74ebtWZIRKSY
Message-ID: <CAC_iWj+e-MMWR3=O9i1ML3bjezPvbrwTr180WqGVeeZD+XsPfQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Fix tcg2_measurement_init call
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ludwig,

On Mon, 29 Jun 2026 at 11:02, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> Needed to fix the previous, forward ported patch

So we can't run u-boot properly with EFI before this gets in? This
needs to be folded with the appropriate changes. Each commit must be
bisectable and working if possible.

Thanks
/Ilias
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_tcg2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 1da0bc37fa1..5935cb2ac8c 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -870,13 +870,10 @@ static efi_status_t efi_init_event_log(void)
>          * vendor_info_size is currently set to 0, we need to change the length
>          * and allocate the flexible array member if this changes
>          */
> -       struct udevice *dev;
> +       struct udevice *dev = NULL;
>         efi_status_t ret;
>         int rc;
>
> -       if (tcg2_platform_get_tpm2(&dev))
> -               return EFI_DEVICE_ERROR;
> -
>         ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
>                                 CONFIG_TPM2_EVENT_LOG_SIZE,
>                                 (void **)&event_log.log);
> @@ -904,7 +901,7 @@ static efi_status_t efi_init_event_log(void)
>          * platforms can use different ways to do so.
>          */
>         event_log.log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
> -       rc = tcg2_measurement_init(dev, &event_log, false);
> +       rc = tcg2_measurement_init(&dev, &event_log);
>         if (rc) {
>                 ret = (rc == -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : EFI_DEVICE_ERROR;
>                 goto free_pool;
> --
> 2.43.0
>
