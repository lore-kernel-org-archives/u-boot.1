Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D89D6A228
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF5688CF1;
	Thu, 14 Nov 2024 19:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSqVt7TX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDDF89651; Thu, 14 Nov 2024 19:55:26 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1767B88CEC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so16700911fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731610523; x=1732215323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zfQ1gvHwMpoqXUlhdrbCeWrmMDGgnfiGxNnumjJpeQ4=;
 b=KSqVt7TXZgQq9zoa2l5LF975sLGYnhc+wCx0qfg8/XBI7e02EEjWM8q3g+rrdyNgdK
 XK29lAwjgo1hhVgKYQCgYs1O6s06ULWumapuY4TSlLlW8leL5wdmWl9oQhmjcmXIv+tK
 y/q1zjTuMOGha8lIputo7KM34sT4h0YMeHY28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610523; x=1732215323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfQ1gvHwMpoqXUlhdrbCeWrmMDGgnfiGxNnumjJpeQ4=;
 b=FQmD1cRYuPTKkNQCmUwwiFHrbPhvxMJNyWEFu3zp6TXVFkfHFlI2um5STTaI2fbBEZ
 u7Towvp2H5y3HgdLmZENOncmWkRkTkD2Ca+C76pzxif3PGDYa7FP7LsDMLP0GKZEChyI
 Wt/UEzsonNNCtWjdzsw4bWuNFJ1AcxYm/6lOImsdE6pqdxm1IuLlve4Hvrt+pD4BhFqp
 ITjR6lFi/5CPpHwZTf4SLhXEfTkK+px67QPv2JeKf3YaYeqB9ANTXxZh4XL9kcLPWY5r
 4gw9x/O4n70UNYanph2QK4pUgqcRSeVk/5OxNdRqbsrHU7EAJjlE8XEj5zy+wiT3tfEx
 VbEQ==
X-Gm-Message-State: AOJu0YybZxLz3Kul5GHMXObqcoartT/8j9jhcXB8yGgre0FpYJYLToT5
 hUqZL27V3jg0pnLi4GJUq+CBV1y2Mbs2fUbtUpXcuIqQyar+nVbC8zd/RO2gVaGPJpXT5pbp5pe
 9XZbVT0FZX4B+Irk0HVCUlQFFhWig7dKrrtPH
X-Google-Smtp-Source: AGHT+IGnOo4wHjGE2yxICZvkZaB3WzzwX5223lFqV1dJ13TpgXxh5uoRm6PExjPe5dmHblZptTqnNUbp0xy8UNK+ZfQ=
X-Received: by 2002:a05:651c:991:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2ff606686f2mr1980561fa.21.1731610523183; Thu, 14 Nov 2024
 10:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20241113195519.49150-1-heinrich.schuchardt@canonical.com>
 <CAFLszThV5a16Q2BqxNn6jX=EavRf--gWESs-4riz_paqgzo9dQ@mail.gmail.com>
 <CAM=mAOkGAfg585Aw7To-egOf3w6bUX4WZMU10F3GN6L9_GN1ig@mail.gmail.com>
In-Reply-To: <CAM=mAOkGAfg585Aw7To-egOf3w6bUX4WZMU10F3GN6L9_GN1ig@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Nov 2024 11:55:11 -0700
Message-ID: <CAFLszTjqjB09m04v25Xb7CN8h7CYJjq4tcgqXnjVW7LAxqag1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: run bootdev_hunt() to find ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 02:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Do., 14. Nov. 2024, 04:54:
>>
>> Hi Heinrich,
>>
>> On Wed, 13 Nov 2024 at 12:55, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > Some hard devices need specific routines to scan for block devices,
>> > e.g. NVMe (nvme scan), SCSI (scsi start).
>> >
>> > Invoke bootdev_hunt() to find all block devices.
>> >
>> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > ---
>> >  lib/efi_loader/efi_setup.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> > index aa59bc7779d..8e0ff16f3eb 100644
>> > --- a/lib/efi_loader/efi_setup.c
>> > +++ b/lib/efi_loader/efi_setup.c
>> > @@ -7,6 +7,7 @@
>> >
>> >  #define LOG_CATEGORY LOGC_EFI
>> >
>> > +#include <bootdev.h>
>> >  #include <efi_loader.h>
>> >  #include <efi_variable.h>
>> >  #include <log.h>
>> > @@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
>> >          * Probe block devices to find the ESP.
>> >          * efi_disks_register() must be called before efi_init_variables().
>> >          */
>> > +       if (CONFIG_IS_ENABLED(BOOTSTD)) {
>> > +               int r;
>> > +
>> > +               r = bootdev_hunt(NULL, 0);
>> > +               if (r)
>> > +                       log_debug("No boot device available\n");
>> > +       }
>> >         ret = efi_disks_register();
>> >         if (ret != EFI_SUCCESS)
>> >                 goto out;
>> > --
>> > 2.45.2
>> >
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Can we do this later, e.g. when we need to boot? What specifically
>> needs to scan for block devices? Perhaps a better question is: when is
>> the ESP needed? It would be nice to have that info in the commit
>> message.
>
>
> The setup routine is only entered if running EFI code like efidebug, eficonfig, bothmeth_efi. So this change does not impact users booting via the legacy entry point of Linux
>
> The ESP holds file ubootefi.var. We need the contents of the file before reading or updating any EFI variable.
>
> We further need all block devices to be known in eficonfig, efidebug, bootmeth_efi.
>

OK got it.

>>
>> I wonder if we could/should delete efi_disks_register() now?
>
>
> Does bootdev_hunter probe all block devices? Or could there be any that are only bound but not probed?
>
> I do not see a BOOTDEV_HUNTER for host, pvblock, and blkmap. Is this an oversight?

Yes, or at least no one did it.

Regards,
SImon
