Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03114EEB584
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 10:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667CE88F53;
	Thu, 12 Sep 2024 12:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ekmw1Y2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C10C88F54; Thu, 12 Sep 2024 12:15:58 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1130388F4E
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 12:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so6174085e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726136155; x=1726740955;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iYZ8NJRvRggdh4HlvjvHMKF5Pknq4Tw5HtCQTjgwkzs=;
 b=Ekmw1Y2X3jj3BhQisuvg5bsFoQS/YuvWnfCN0SI380pAbppj2n+znrf1YVlAadYeGb
 tVKeR3gG+E3xglPfq4gnd6oGdPW6Ok1yYd5MlQ/LS1YlXKGCGGkmQlagwOY7lmmZ56hV
 qNCxlSbuvaIH1OtaWRAVzDuZOthqgUv7HpEAh/9FG7cOZhuxdQFTkZWGmcQeaplZLMof
 MwlZFgKvcHYzRzzqHiD9mvWEyLRKx2tjoyBh00iXMF/mJpqMoOCgTercZsOrAvt5m4Jc
 eSx25NQhIWdrAu1q+WjhjlKzn71dwP3qrmpDg4Mw8WCrCVOkBP7h6M9CYavX1JLOFm+f
 aBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726136155; x=1726740955;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iYZ8NJRvRggdh4HlvjvHMKF5Pknq4Tw5HtCQTjgwkzs=;
 b=N5+O6AgfFqbtvvpQa/nC5mZuQ/pdbykA/2HzcYDkePSHYo2lFuvcABrLu5CJhnJffz
 gcyyecWQcrTjaAr0fEdFMWT6j7jvFJ+mBcgW5DL57/RABFcK3DEvA9dR2Wjd+Vi3rSPr
 bxjbQRxCW9OTOlXQ9tRiik4TXghZ4ONQ+HstPlVgq3kL8ETt7Dx26ixOOC466hu6+CP4
 08lGCSx/1UQdcBMCUODRTqLpyP9c3gUUdyilBL6alNacMVZbuE5EXNjThsjeeBXFV/dc
 FZsfR5+mnlFqiWjUvduAtULxx/XmAV2NmgpUkQbnukspRDg6tW1NmfZDppIVNdII4dtz
 P88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6+dzJQgc8dp+fy7IKOYNfXRU+zaWi4oLEclXPhTUJKbWgU9ZNLSZYA1wnfribrhto8iJvudE=@lists.denx.de
X-Gm-Message-State: AOJu0YzdfvZe5kCeqz7EHVn/dDiggJObUfpIJ8K4w5bGZJloGnCaWQOj
 q2IgPXTkydVogniAkRWBRi+d3kHNzA5WtdN9Vx/8aNCUZySuTyvIstW5PbO/fRI=
X-Google-Smtp-Source: AGHT+IFGk8EH3GMltC2FdWlLQ6PYtT8SY7vErlvsrxguDv6eaZbMJGI3ZlFNy8RPbqmqOacn5zMoPA==
X-Received: by 2002:a05:600c:4fd6:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-42cdb509e19mr16947955e9.2.1726136154729; 
 Thu, 12 Sep 2024 03:15:54 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc01a8ee7sm89274675e9.0.2024.09.12.03.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 03:15:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: android: Add U-Boot version to cmdline
In-Reply-To: <CAFLszTiKCbnqFv_nX4eH3n01LaHHwJstXLEpA3G6UXC7spZMxA@mail.gmail.com>
References: <20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com>
 <CAFLszTiKCbnqFv_nX4eH3n01LaHHwJstXLEpA3G6UXC7spZMxA@mail.gmail.com>
Date: Thu, 12 Sep 2024 12:15:52 +0200
Message-ID: <877cbhkwiv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for your review.

On mer., sept. 11, 2024 at 18:59, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Wed, 4 Sept 2024 at 03:38, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> When booting into Android fastbootd (a subset of recovery), the default
>> UI shows the bootloader version in the screen [1].
>> This is done via the ro.bootloader property which should come from the
>> bootloader.
>>
>> Provide the U-Boot version via a kernel commandline argument so that
>> fastbootd can show it properly on the screen.
>>
>> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>  boot/bootmeth_android.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> index 6e8d3e615db0..2fb82a5073de 100644
>> --- a/boot/bootmeth_android.c
>> +++ b/boot/bootmeth_android.c
>> @@ -22,6 +22,7 @@
>>  #include <malloc.h>
>>  #include <mapmem.h>
>>  #include <part.h>
>> +#include <version.h>
>>  #include "bootmeth_android.h"
>>
>>  #define BCB_FIELD_COMMAND_SZ 32
>> @@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
>>         return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
>>  }
>>
>> +static int configure_bootloader_version(struct bootflow *bflow)
>> +{
>> +       return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
>> +                                       PLAIN_VERSION, false);
>> +}
>> +
>>  static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>>  {
>>         struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
>> @@ -267,6 +274,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>>         /* Ignoring return code: setting serial number is not mandatory for booting */
>>         configure_serialno(bflow);
>>
>> +       configure_bootloader_version(bflow);
>
> Error check? If for some reason you want to ignore the error, please
> add a comment here.

I indeed want to ignore the error. We don't want to block the boot if
for some reason we cannot set the U-Boot version in the kernel
commandline.

I will rework the above comment to be more generic about this.

Thanks.
Mattijs

>
>> +
>>         if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
>>                 ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
>>                                                "1", false);
>>
>> ---
>> base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
>> change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf
>>
>> Best regards,
>> --
>> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>
> REgards,
> Simon
