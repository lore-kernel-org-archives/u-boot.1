Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0A4C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5589F84B36;
	Mon, 13 Jul 2026 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gvIpZ8Y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF9784B37; Mon, 13 Jul 2026 15:05:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AC784B27
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso6886654a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947933; cv=none;
 d=google.com; s=arc-20260327;
 b=raZNCbtsw3HO0gkL35rATDSYzbXMBp3QbOShA9N4hQKRQr3AaUHTtxeYy1A2lF9CVe
 D3a7vnXeI2On+3n4PK1d6aW0g96T8N0+6Ftccv20hcuuaEY9t5AzkJQkrSrtMTspYXOZ
 D1EeyNk5nj4/Tjps/Kyt20nBtBN6WZlYXsWNyyeAqMZwMCmFqnuT/UAb1bEbsEgiYWYD
 lOuPzL0JoD6y4Zt6bzNGESff4Z5TuAKkaaakD13hy46ll0RWD4BkBS5L1a0TFBOULO3C
 btRB+3eLjYu8DwRPVaYxMbNeiJKIRhJk3TlI8yCTGKMkv8RG0rxo8Pq+6jZBEy6Kpv5J
 IUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YiQ12Yug04pba5Mop5CEwNNh9ApNjYzvH0aavncabqM=;
 fh=32kzDl8v7B2a6k1MiUCsFsFAAtWnsn+kjnuW06IcrcQ=;
 b=mTHRoKRXR+Gaq4XgiVL5QxIvWHPpXPlb08pMwpzZLCGMnCmM+rSVv6AxcIvHdKhAvN
 giaqQBnvQ38ESu9eNanDo5cYLkRjh03T4WHRr16dr+A5FGISJKEgqhd5SpPRmv7UCUFB
 Dz2HKviM2z1amGutj5Egwv5ieY9JFrV2yPJKPHAPXLLzVJZ3Nuv9F0yxsnycaaLfpeTi
 TPuWCizaTJW1CUicZNTlwQw1A6JWak6QYhvaPD0P8+hDeDnug65RzELuqXxaGys6dSnS
 YLOmaPGsB+E8IalYXY1UO8j5JM4VpVaYmAapb7xKCq9Wa/8GcA/ZZQt4jftqpnwsmK8U
 j+8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947933; x=1784552733; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YiQ12Yug04pba5Mop5CEwNNh9ApNjYzvH0aavncabqM=;
 b=gvIpZ8Y537u7m5+uSbpS7V+cHFW0tyzum05WxvbEBgJBSQX2ITqqdh9k0tsh6Mbzsw
 FS+CuwsbCyAWJXVE8QPvUlbT5XHaL9S53h1KhqUkgXWFpYMomAQh5ip8sRO9abXWQTI+
 yzgopg6VX5/xP2BD7oBfBQsPeIIj+C+fvFHNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947933; x=1784552733;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YiQ12Yug04pba5Mop5CEwNNh9ApNjYzvH0aavncabqM=;
 b=ZTyMLcV2wlSGsJaohZuX+sjcWqE43xaRcavlwr6xTexj6db2R11fWH+yeQ0MRDP0Um
 tdaCdT/zMKx/ID1kJ28H8FDxtDDL2OExEWgMEshyby/vdz3UmraYcLxHoK3+jrsgU4dM
 NqbxDjafN9L/dvk34GoonzJsI0G9PvhwfNM9Z04tYiFx8uVipOVwnsdxTyG/KsknPSL1
 3/tBpMEPlZJMoJM8XDu0EckZd/MrySduGf+pCZKVMIM2Si1oACyCIoHkNG8H7zxiJO+d
 OsFbQx7yPh3hDpbmZyofbLKpDh/rBEpDn8cEfU++DKhaiNb9VsN+fwNUr/J7FUQ90Ho9
 AaOQ==
X-Gm-Message-State: AOJu0YzICSMBPNhfaBgL2yhH4juqQn/ua+brOs7KZD/jU1c+FviXTRbG
 eZUGnsO9z1TtD7Lm5m8lygNe00zqRSyHgD2GlIpCQ0NBwm95TtSqIZeDhfR080XBxOnpGzlVG3J
 DHI/kfJbG6yj+dzd5zlEM2qgSFinKiZSbgo9fAaFt
X-Gm-Gg: AfdE7cnlQjHNASgaqdOpZcjTFLCkxSIt+4YhbdLAfk5uEPNUM+PMgTN48FdDrSLOIwg
 MP4EDHeWSeWTER34TgGzoeGzwwXET2Xc6EIrmIm4FnRVINRmI+pH8qFHHLPIa6/rYzyUUCWRl5q
 4d7RB29xtnHI4YgWzUzFuT1W9xWmt6zXFBz/8SyHworROGCHfLR/nwtuXB2Q3nuyk9W6CdSoJ/z
 MfiNgdYohYgA8B0U+fkTbkcOduQt7bM0huw//xQZqWR4aJqvAsk1yI29x5zxiHLIuRKOLM=
X-Received: by 2002:a05:6402:5293:b0:698:1504:bb1e with SMTP id
 4fb4d7f45d1cf-69c5f12ca48mr3589355a12.29.1783947933150; Mon, 13 Jul 2026
 06:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629080241.36311-4-ludwig.nussel@siemens.com>
In-Reply-To: <20260629080241.36311-4-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:05:20 -0600
X-Gm-Features: AUfX_mwo-a4wPaZKB776ZeSAbAZz3CKBz4zONcvV-5mAWy6SQu2HlnHK7gASKkM
Message-ID: <CAFLszTgr1dMqJDv65symUEXvD9dLJ9rJDW+L6xMrYxPbcxW18A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Fix tcg2_measurement_init call
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Tom Rini <trini@konsulko.com>,
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

On 2026-06-29T08:00:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> Fix tcg2_measurement_init call
>
> Needed to fix the previous, forward ported patch
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> lib/efi_loader/efi_tcg2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

As Ilias says, please squash this into patch 5. Landing the broken
call in one patch and fixing it in the next breaks bisect, and after
the squash the commit message can go away entirely.

> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> @@ -870,13 +870,10 @@ static efi_status_t efi_init_event_log(void)
>        * vendor_info_size is currently set to 0, we need to change the length
>        * and allocate the flexible array member if this changes
>        */
> -     struct udevice *dev;
> +     struct udevice *dev = NULL;
>       efi_status_t ret;
>       int rc;
>
> -     if (tcg2_platform_get_tpm2(&dev))
> -             return EFI_DEVICE_ERROR;
> -

Dropping the tcg2_platform_get_tpm2() call changes behaviour:
previously efi_init_event_log() returned EFI_DEVICE_ERROR up front if
no TPM device was present, now it falls through and calls
efi_allocate_pool() first, only failing later inside
tcg2_measurement_init(). So we allocate (and free) the event log
buffer even with no TPM. Please either restore the early check or
mention in the squashed commit message why the new ordering is
intentional.

Regards,
Simon
