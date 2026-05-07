Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26DCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 21:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CD284B9D;
	Thu,  7 May 2026 23:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GxFHKQpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6EA84BB2; Thu,  7 May 2026 23:11:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD5A84B8D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 23:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so251712066b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 14:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188266; cv=none;
 d=google.com; s=arc-20240605;
 b=LJob0xRTngaJvPzb8izR9DI3Gt+mtaibBKAULPZgeNGaHLH9EtywBrrHqI55558x0E
 bvLphJdwLd5GiIX8FVr5TUP3bYGCJE4ym6c44ePbWzg7QTxgJNv077y9bpBCrQR5RbwY
 +URdsnq2mzDi8JemvWM6C3f7IB3/TRBT5dBj3RdHTvR1ILzaSDuwVGxoD032nPwILgUw
 x/VhAR3y3NXZ2Y5ey3hX3rQSycYMxqlPoI9vBckB0rd8YA5dNREfLaXDY0RXneDqGg19
 h5IFjL6jivB3IvDD35V5fYgab8AJSVol2rjtKcmEEPpmqXrVS7UPdwp+S+j+4V8bBqpJ
 Ok4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tt+aofQ3mAD7O8fUNBWWfz3TiDtSdeBeRRwYxh7AsKo=;
 fh=fPveJrzbQrs6oFVA6yaNG+8HypoDU1mP0EUBNbE0+mQ=;
 b=YXUR+0ARqhT8kijmhA9BeXVeLcFevt5v6FZl/bN9HSJR8LGNTDcYICA+1dw69bg44f
 uGZQiDkvHf/NdIiBPjImMJlHTXhxFXbsTvZ446XMxyd0DTRZw7505pbqrkTo2oEMVxXP
 TZKwfAKal5jBFmMl6MUcT620vJaSz5Krfdb1kZcvfOeulz4pY1NX0+yeTiehIRkw2qWi
 I73SbSFze1bI/gVdBD1lauDiT4TkUSXjIss66NvzFREAvyMgNweYukotScH68/A+nA4t
 kWXX3+sf/2rzwqYRFrG7BoAKJJowitOvGY1LrHdknP2k69/sxZXNEr2cA+upQSM5d6YJ
 FyiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778188266; x=1778793066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tt+aofQ3mAD7O8fUNBWWfz3TiDtSdeBeRRwYxh7AsKo=;
 b=GxFHKQpZZb+kpfMTy6DXzrLzcmus3Ps+LtFe/zjmu0Hx3Kty5whFHb2yz6ousUXvXi
 i8KHqTgBjqNWBLWjBiugTngX43Xx8mlaz8wQgPbZcNs4Zd2buu52D8yjQ70HvqzmCuQ1
 YcUrh2ytD2R3YqrV30BkLJRNGOkxhRP5IDYZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778188266; x=1778793066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt+aofQ3mAD7O8fUNBWWfz3TiDtSdeBeRRwYxh7AsKo=;
 b=ZhHWBGtw3pjoGPEyzZs++4r9m9cZCgi7i9HCC+V5eUsxC43JHw4W89Fb8oXwEix3EV
 9Gtx2vUhg/SppkX+0cUo6B1e5SJLuVwmlynZ2564BwyX0PoOp7qbKlbV3owI4AUjFUik
 8XCEBxfh+f0TyvOFLqXMJiNLLXDVoX4J+E9PGAorE9v+r3fuHEN9g7dA0aMDh+aGEeDX
 H6c7KZZvy6Xgl0W+kYpX3v+g+QFqhI6DCG3xpRBxSJLqTx+CV12xfhFVCgTQ9blsztpl
 roqataTrkTDpKtB1LOKBQONzQtPBWkITb5eWr0Yfdl17T9tHtbPqdfouhrUmz7dO+R4g
 7wEw==
X-Gm-Message-State: AOJu0YyR0W3Dvr0f21vP6CAf3GbjSrSNM3Ul9yCNI84iXyMdxdZ2e1VQ
 H4AWIIj5FBn1vTe7UzXKf5uBbCnXj5BG9mFUoZKx36Kl2wKh/vGylg8mU2KrpbFnJQ7iueaOiy8
 7NxT8tr0bJwEP7vaRa1cl8JYdKwJAP6V6XwRxaIzy
X-Gm-Gg: AeBDievT7TzEov7TDMs/2LPy8WneaSHHZYeK3MV6rtBZQ6iW5eDZOlg5sq9xwYf4BH8
 fwcyASSO/pcxq32PpULyQOt9XeuoSTjBZbPQ0AIZ1O6kKuRbEHwsniUHGyPznfQpevcWbF4ftXY
 ak66wve5y22N5LWJAwjhvEWz3ivUPq0SQxAk9m4bdPcMI7Ki8UzZ5fwpuZS/R6mVJ5kLk9mAguo
 eWS9iGdat6EVGD669d5EloIY4K5TCAzf2DQkJONuM9knFrDhVKMQAnf6XeYvU2DexXV1KlOcpM0
 HfLVoZIceUs+saeO
X-Received: by 2002:a17:907:2d86:b0:b9d:7b9d:df02 with SMTP id
 a640c23a62f3a-bc85c88d95cmr246892066b.17.1778188266365; Thu, 07 May 2026
 14:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042530.2965678-2-ronan.dalton@alliedtelesis.co.nz>
In-Reply-To: <20260505042530.2965678-2-ronan.dalton@alliedtelesis.co.nz>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 15:10:54 -0600
X-Gm-Features: AVHnY4Lpz3bVLGrzfmmV2-vaCLC_-vuaEw3mWaAt2snhSh0_y0JjGLVIriQ_8yk
Message-ID: <CAFLszTjfh=Fbja4kmAyvqxk5Fc+yOEmZeCFbBO69HX5pXRhjrw@mail.gmail.com>
Subject: Re: [PATCH] rtc: ds1307: Handle oscillator stop flag set on ds1339
 chip
To: ronan.dalton@alliedtelesis.co.nz
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
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

On 2026-05-05T04:25:31, Ronan Dalton <ronan.dalton@alliedtelesis.co.nz> wrote:
> rtc: ds1307: Handle oscillator stop flag set on ds1339 chip
>
> Currently the oscillator stop flag (OSF) bit is never checked or cleared
> on the DS1339 RTC chip.
>
> On getting the time from the RTC, check if the OSF bit is set, log a
> warning, and clear the flag. This matches the behavior of the DS1337
> chip.
>
> Note that the date command always reads from the RTC even when
> setting or resetting the date, so the OSF flag is cleared in those cases
> as well.
>
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> drivers/rtc/ds1307.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
> @@ -116,9 +116,9 @@ static int ds1307_rtc_get(struct udevice *dev, struct rtc_time *tm)
> -     if (type == ds_1337 || type == ds_1340) {
> -             uint reg = (type == ds_1337) ? DS1337_STAT_REG_ADDR :
> -                                            DS1340_STAT_REG_ADDR;
> +     if (type == ds_1337 || type == ds_1339 || type == ds_1340) {
> +             uint reg = (type == ds_1340) ? DS1340_STAT_REG_ADDR :
> +                                            DS1337_STAT_REG_ADDR;

Reviewed-by: Simon Glass <sjg@chromium.org>
