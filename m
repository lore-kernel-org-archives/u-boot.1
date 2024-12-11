Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CD3E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 17:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE24803B7;
	Wed, 11 Dec 2024 18:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hXrvz4ez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1896B803B9; Wed, 11 Dec 2024 18:26:17 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32E6803A9
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 18:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so221945466b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733937974; x=1734542774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQXsqJfHNtIZ2Cg7T2LJSh86OHWNQZLe4Ku6dt3Ok0Y=;
 b=hXrvz4ezkKG7FzCb5hREKz265hhXleh/+Jq++S03BhR1vvrCLTTS+jN2fjX5hwKhJ2
 QdRFfXN3JtuyK4JWNcVFMEKaC9EBQXIKPRwvxZucPnfsnZd2KEtZb2YT4YohMa9FUh/k
 vKUHE8A85c5XpUjReJn7zF1JONOZGWLF1YISQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733937974; x=1734542774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQXsqJfHNtIZ2Cg7T2LJSh86OHWNQZLe4Ku6dt3Ok0Y=;
 b=BE/YIAcGFLAsOOOh4Ma//Vf/TqshCv2yyEHlY5+U5aWAAvIAuqZFccaetU8RT3Szle
 NIjWOjmZD4Z6bGMvE8tU9k9d+PTnPEQ3NFYba5NwMsE06Rpjuq8kqWIDQ2Q0XY1+onU2
 HYysZ5BSadHDITYzuw8B7xOQ3BfMYpG5p8rfb0NCxMKWeSfMfnB39STIYePkZ+KfhKB8
 aPYVDFYnpOxj0RSvSRJBzOz7fDF3ZzinJ1YZ+e3mEhtat0f/rF8uF8W75rKqSRq1N3fu
 R0j3G1VvCDQ6kvMaMTKQc8nKYaOk8Wk/hnl+7OicelcoWgRZDw6C2+RZIAF59/cRZAmO
 xv4g==
X-Gm-Message-State: AOJu0Yx8LFmBJ9GyfBxYfl6l6VgWNvKfxFSoo9bjVYQDUXrRn56EyqzN
 YB31Ovws0WpSQqk6VYzEB86/+ooaMEv3kZnUaQvGyZSgho9F7cIZz4irVJjmdmW0Tfhdo0X2p31
 WTG9CwTF3FGwaMvlNt2Ta9dHl0d5e1WnvxTZz
X-Gm-Gg: ASbGnctqLAdb2pLh9a3CVLoO8c6acRsvai5uR4pYbnjuK3mVfMl3XQdjLr6Yz5KCORc
 C5GFLj6ORe3LIpZFWmJOX6FU5O6AqOy2I+QeY
X-Google-Smtp-Source: AGHT+IEj9H3gJBZN8KJtvPdXXD4xZ/EF4UhFhvvLLjKbQ9FeCybGGlQCCwgijvW/5uG5GH4YMGIaJXOU3V2FEMqcIgg=
X-Received: by 2002:a17:906:23e1:b0:aa6:7e6b:4984 with SMTP id
 a640c23a62f3a-aa6c1ce756amr69945866b.42.1733937974051; Wed, 11 Dec 2024
 09:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-3-sjg@chromium.org>
 <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
In-Reply-To: <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 10:26:02 -0700
Message-ID: <CAFLszTiCQ9kPCkZ7wrMGv3ENwB59KBp87vzq1qNQYEO-bdrVbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>
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

Hi Peter,

On Wed, 11 Dec 2024 at 09:27, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
>>
>> Set this option so that all boot images stay within the bottom 512MB of
>> memory. This should allow us to drop the fdt_high and initrd_high
>> options.
>
>
> How does this work for a device with < 256Mb of RAM? There's a number of the original RPi series that have 256Mb of RAM and that equates to less than that due to reservations for the vendor firmware.

Looking at boot_relocate_fdt(), this is just a maximum, and lmb is
used to allocate the FDT / cmdline. So this patch shouldn't affect
that.

But the later patch to move the ramdisk up will cause problems. Based
on the comment, a 256MB (I assume you mean) device can have as little
as 64MB of RAM available to the ARM core, which is not enough to load
a ramdisk from the new start-address of about 90MB.

I found an old rpi1 which I could hook up to my lab, perhaps. Could
you point me to a distro-image that boots OK on that, ideally with
only 64MB available?

>
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> ---
>>
>> Changes in v3:
>> - Add to the existing comment block
>>
>> Changes in v2:
>> - Add new patch to set bootm_size
>>
>>  board/raspberrypi/rpi/rpi.env | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
>> index 30228285edd..a327fccc77f 100644
>> --- a/board/raspberrypi/rpi/rpi.env
>> +++ b/board/raspberrypi/rpi/rpi.env
>> @@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
>>   * Even with the smallest possible CPU-GPU memory split of the CPU getting
>>   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>>   * large initrds before they start colliding with U-Boot.
>> + *
>> + * Limit bootm_size to 512MB so that all boot images stay within the bottom
>> + * 512MB of memory
>>   */
>> +bootm_size=0x20000000
>> +
>>  #ifdef CONFIG_ARM64
>>  fdt_high=ffffffffffffffff
>>  initrd_high=ffffffffffffffff
>> --
>> 2.34.1
>>
