Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D022CE7716A
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 00:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E108005B;
	Mon, 16 Dec 2024 01:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EWO1oh7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D16A80092; Mon, 16 Dec 2024 01:27:36 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4015080050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 01:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso578848166b.2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734308854; x=1734913654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5bOStmhSW1R511/xUhLJwMi9+jX6YBaklld82AgvjYI=;
 b=EWO1oh7Qv/GbHXNonWXftjRP8G3aJi3nqTPio904f5CBFj6ndTnvSaisaBK85fxVjo
 KvoGGI/eVQXdHsRq53BzOQ6CBRyVr8NWqvpvhme4xKSwDu6Lgp7qgMmi3AVQsisrgnkA
 hkMsYLQnxW0f9swl+B/5NY07gOINPuQB/g0l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734308854; x=1734913654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bOStmhSW1R511/xUhLJwMi9+jX6YBaklld82AgvjYI=;
 b=i6xfZm97JI5NsNzWJwho9lSMxjgiRqVwYY3XnE0dGswq2OgfC0yn80kj5ier9UgIIy
 YmDLUc7Z711xwqqh3QQh6VzvxpkpgYYLdzEJqEQCKjicHC6IPWgJB6U6CJnp8J/vdTWC
 gpt3izkKcjI5gy53wtipWgN2jwb5ZZW8HfDpGuG6+ZHyOAV7/YBZT5eUjSuw3kA5ab2S
 s9qAUEDc6dP9f6hbyI2CGMX9EoLRIoFzB6CFPjT4busbhojrFacQqD/sy3nJqsDFg/I3
 N1mctkjfdw/Y3gOyUtrZVCMhSx+NF+gAJJZGkvBM3TV7/r+uTlc7TKac23HiTZRT2aqx
 i3CQ==
X-Gm-Message-State: AOJu0YwPynb7u89RgsqhhpStH7xdIS5usSnC6I+0b66zZVjmMuPyDuZp
 owU3mxSRrPo7e1GXA/9EoP9a5lW+XkeRbgzghpPC41zz0Jawqu/2lQt4cwRepsFT3I6McFnMNXS
 rdZ7pO7nMSIcaT7Nm7HVFbYEq8YNqCVHGaVg+
X-Gm-Gg: ASbGnctG3+a7/vmOHY+DfUetBbjCAw3/UZP9ULViJ3CdkStuG7J6JHZs6l13SEDwJFA
 bROpiGV+oPB0TVHTSpFkQqEE2rJkDl1XqvV2sO7C+Qxvdt2EXh5d8rbqFRMaqmWnMNAQCZw8=
X-Google-Smtp-Source: AGHT+IH/V5u3jyaHErICKHuvxBMtyeIM1uamC0JB+QQ+e7B/LsoTMDeq4FEIOWG0JOLGNPEpD/64pZTzfs5JPEb6lg4=
X-Received: by 2002:a17:907:7818:b0:aa6:558b:fcc3 with SMTP id
 a640c23a62f3a-aab778c1674mr997086966b.4.1734308853605; Sun, 15 Dec 2024
 16:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-6-sjg@chromium.org>
 <CALeDE9M_Bgaxom1Ac3Uomu=Mnd+mvKeGNAsHxn63kve8qfwzUg@mail.gmail.com>
In-Reply-To: <CALeDE9M_Bgaxom1Ac3Uomu=Mnd+mvKeGNAsHxn63kve8qfwzUg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 17:27:22 -0700
Message-ID: <CAFLszTitLSCc71TUV8fB0dzWFQwRxO8mVwhwao6ornPGc3AamQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] rpi: Use the U-Boot control FDT for fdt_addr
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>, Francois Berder <fberder@outlook.fr>, 
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Wed, 11 Dec 2024 at 09:36, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
>>
>> The fdt_addr variable is used in extlinux as a fallback devicetree if
>> none is provided by the boot command.
>
>
> And what about where extlinux isn't used?
>
>>
>> The existing mechanism uses the devicetree provided to U-Boot, but in
>> its original, unrelocated position. For the rpi_4 I am using, this is
>> at 2b35ef00 which is not a convenient place in memory, if the ramdisk
>> is large.
>>
>> U-Boot already deals with this sort of problem by relocating the FDT
>> to a safe address.
>>
>> So use the control-FDT address instead.
>
>
> Please re-word the above, it doesn't make sense to me, "the rpi_4 I am using" .... what about the other millions of RPis out there?
>
>>
>> Remove the existing comment, which is confusing, since the FDT is not
>> actually passed unmodified to the kernel: U-Boot adds various things
>> using its FDT-fixup mechanism.
>
>
> Don't remove it, re-word it so it's up to date.
>
>>
>> Note that board_get_usable_ram_top() reduces the RAM top for boards with
>> less RAM. This behaviour is left unchanged as there is no other
>> mechanism for U-Boot to handle this.
>
>
> The below looks irrelevant to the patch at hand, it looks like it should be in the cover letter.

Do you have any comments on the code in this series?

>
>>
>> In version 2, it incorporates some changes to fdt_addr, etc. suggested
>> by Tom, as well as adding myself as a maintainer.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Drop patch to allow expanding the devicetree during relocation
>>
>>  board/raspberrypi/rpi/rpi.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>> index 9122f33d88d..8f6ab1b1b9b 100644
>> --- a/board/raspberrypi/rpi/rpi.c
>> +++ b/board/raspberrypi/rpi/rpi.c
>> @@ -3,6 +3,8 @@
>>   * (C) Copyright 2012-2016 Stephen Warren
>>   */
>>
>> +#define LOG_CATEGORY   LOGC_BOARD
>> +
>>  #include <config.h>
>>  #include <dm.h>
>>  #include <env.h>
>> @@ -325,19 +327,10 @@ static void set_fdtfile(void)
>>         env_set("fdtfile", fdtfile);
>>  }
>>
>> -/*
>> - * If the firmware provided a valid FDT at boot time, let's expose it in
>> - * ${fdt_addr} so it may be passed unmodified to the kernel.
>> - */
>> +/* Allow U-Boot to use its control FDT with extlinux if one is not provided */
>>  static void set_fdt_addr(void)
>>  {
>> -       if (env_get("fdt_addr"))
>> -               return;
>> -
>> -       if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
>> -               return;
>> -
>> -       env_set_hex("fdt_addr", fw_dtb_pointer);
>> +       env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
>>  }
>>
>>  /*
>> @@ -572,7 +565,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>  {
>>         int node;
>>
>> -       update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
>> +       if (blob == gd->fdt_blob)
>> +               log_debug("Same FDT: nothing to do\n");
>> +       else
>> +               update_fdt_from_fw(blob, (void *)gd->fdt_blob);
>>
>>         node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
>>         if (node < 0)
>> --
>> 2.34.1
>>

Regards,
Simon
