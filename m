Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D044C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 14:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2BB884DC;
	Sat, 20 Jul 2024 16:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g5ATUgwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084318851B; Sat, 20 Jul 2024 16:44:41 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD70F882BE
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 16:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b7aed340daso11829666d6.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721486678; x=1722091478; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/zUWNS9Rl5vcG83tv2HmcM1s5pNJP6XD7lOU9NlmCAw=;
 b=g5ATUgwYDHd7AMbF4IZn3fM2ERfrUd4NGg0g7y3giJuwHSSDGtEhaPtsToKCreCyc1
 DznVhts5NwiFuqQUX/9qQZrAmYbAFAHiT+i0WqwIN6csuANp2gUu92a4c41mP3/lxRqI
 GQuF+hRTfLPbqGUu318/rIDuxv3xsGoRR7W0rJ1Rbx40J9Bxg1ptDTBBGzp/W2wcRMR5
 jAGo1nBxk9aE9qDPqlKe/c+twleXb1/CZVu7iy/wX6/BQRa0pyNkmMKAiIVbEAwGuSGi
 wXyP8UmiYOfj94pL/lMtbUu5tqE0a6u+Sf2fmfzgvBiwFuZrQGHfIjywXytg2i2+0ScN
 bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721486678; x=1722091478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zUWNS9Rl5vcG83tv2HmcM1s5pNJP6XD7lOU9NlmCAw=;
 b=sly6BCyRV0ml1Ya9ZS8b470pJZ33q1wsc+rAD2cI4o58H8bn91cmhhKulGowz+MD4T
 mBuqrlie8B4ovoPP5lGZNELsX+2jL2CqAgBMDqWfhYHzQai7jjJOlx1kjRvvO/PmuCmM
 C51rcFWhYT1hBr6spfVg3N7MVrdpNiHgDLX1+VxB1Xfj1dNn/wdSsD+JZ89kT/MNdjkk
 nuzow6UkwK1v5E6vmRd6yLRw1KPJlUlT5vgkyHwklUJgNmTYKLl2ILsdMjL0MlxXL2ip
 Xe0wGdAaHCaeqR048WT/s8iONel3J7fv5XeDUXqlTxB57K77i2nU0Jc7N/TCDg7oQQXC
 L7Gw==
X-Gm-Message-State: AOJu0Yx+S276NZRDNjJM5pPuHLKrb/1J4uvD0Wpa1KbUAOdvlTY3xHdD
 QUy/qxiD3n9Jik/5HgJnS0rWZAQzLcOXBB7BgCeOH5K2IMsVNLdT
X-Google-Smtp-Source: AGHT+IFw2Er6ebN+VsA196csuGCQluEvmcHnaECIwoqV6tlNv4oOpi/uuBYNh3qUVs/6J+gqAO3hYA==
X-Received: by 2002:ad4:5fce:0:b0:6b5:ec27:886a with SMTP id
 6a1803df08f44-6b96106e4afmr26468076d6.4.1721486677560; 
 Sat, 20 Jul 2024 07:44:37 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7acb04d74sm17656576d6.131.2024.07.20.07.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 07:44:36 -0700 (PDT)
Message-ID: <c968d99b-8a64-6afd-5824-844ad19e0d5a@gmail.com>
Date: Sat, 20 Jul 2024 10:44:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 15/21] spl: Plumb in the Universal Payload handoff
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, Lean Sheng Tan
 <sheng.tan@9elements.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-16-sjg@chromium.org>
 <325e6cc7-8210-8e95-0267-10d84192a406@gmail.com>
 <CAFLszTgqzN2CwcOj3iR+mspxHD7mjLejaDPPx2Ext=RY8LS1=g@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAFLszTgqzN2CwcOj3iR+mspxHD7mjLejaDPPx2Ext=RY8LS1=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/20/24 08:36, Simon Glass wrote:
> Hi Sean,
> 
> On Thu, 18 Jul 2024 at 14:54, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 7/13/24 03:00, Simon Glass wrote:
>>> Specify the FIT and include information about each loaded image, as
>>> required by the UPL handoff.
>>>
>>> Write the UPL handoff into the bloblist before jumping to the next phase.
>>>
>>> Control this using a runtime flag to avoid conflicting with other
>>> handoff mechanisms.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Hang when something goes wrong, to avoid a broken boot
>>> - Add a runtime flag to enable UPL
>>>
>>>    common/spl/spl.c                  |  8 ++++++++
>>>    common/spl/spl_fit.c              | 22 ++++++++++++++++++++++
>>>    include/asm-generic/global_data.h |  4 ++++
>>>    3 files changed, 34 insertions(+)
>>>
>>> diff --git a/common/spl/spl.c b/common/spl/spl.c
>>> index 7794ddccade..d6a364de6ee 100644
>>> --- a/common/spl/spl.c
>>> +++ b/common/spl/spl.c
>>> @@ -810,6 +810,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>>                        printf(SPL_TPL_PROMPT
>>>                               "SPL hand-off write failed (err=%d)\n", ret);
>>>        }
>>> +     if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
>>> +             ret = spl_write_upl_handoff(&spl_image);
>>> +             if (ret) {
>>> +                     printf(SPL_TPL_PROMPT
>>> +                            "UPL hand-off write failed (err=%d)\n", ret);
>>> +                     hang();
>>> +             }
>>> +     }
>>>        if (CONFIG_IS_ENABLED(BLOBLIST)) {
>>>                ret = bloblist_finish();
>>>                if (ret)
>>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>>> index 2a097f4464c..b288f675ae3 100644
>>> --- a/common/spl/spl_fit.c
>>> +++ b/common/spl/spl_fit.c
>>> @@ -12,6 +12,7 @@
>>>    #include <memalign.h>
>>>    #include <mapmem.h>
>>>    #include <spl.h>
>>> +#include <upl.h>
>>>    #include <sysinfo.h>
>>>    #include <asm/global_data.h>
>>>    #include <asm/io.h>
>>> @@ -645,6 +646,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
>>>                printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
>>>                return ret;
>>>        }
>>> +     upl_add_image(node, fpga_image.load_addr, fpga_image.size,
>>> +                   fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));
>>
>> Does load_addr even make sense for FPGAs?
> 
> Well the images do get loaded into RAM at a particular address.

No they don't. I mean, technically yes, but it's just an intermediate step
before being programmed into the FPGA. Much like how executable boot images
may be loaded to an intermediate address before being copied to their final
location. And the load_addr is set to 0 a few lines above.

But don't bother special-casing this if you do the next part.

>>
>> And I noticed that you always call this after load_simple_fit/fit_image_load.
>> Could we call upl_add_image in those functions instead?
> 
> Yes, although it means compiling upl.h for the host. Perhaps it isn't
> that bad though and it avoids repeating code.

I would prefer that to help ensure that future programmers don't forget it.

>>
>>>        return spl_fit_upload_fpga(ctx, node, &fpga_image);
>>>    }
>>> @@ -768,6 +771,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>>        if (ret)
>>>                return ret;
>>>
>>> +     upl_add_image(node, spl_image->load_addr, spl_image->size,
>>> +                   fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
>>> +
>>>        /*
>>>         * For backward compatibility, we treat the first node that is
>>>         * as a U-Boot image, if no OS-type has been declared.
>>> @@ -811,6 +817,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>>                               __func__, index, ret);
>>>                        return ret;
>>>                }
>>> +             upl_add_image(node, image_info.load_addr, image_info.size,
>>> +                           fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
>>>
>>>                if (spl_fit_image_is_fpga(ctx.fit, node))
>>>                        spl_fit_upload_fpga(&ctx, node, &image_info);
>>> @@ -847,6 +855,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>>>                spl_image->entry_point = spl_image->load_addr;
>>>
>>>        spl_image->flags |= SPL_FIT_FOUND;
>>> +     upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
>>> +                      spl_image->entry_point);
>>
>> I think this should be virt_to_phys, since we aren't really mapping it.
> 
> We want to pass the address, which (for sandbox) has to be able to be
> mapped back to a pointer. Everywhere else in sandbox this is how we
> handle that...

This is really a nit. But I thought that map_to_sysmem implied a pairing with
unmap. But I guess that's map_physmem.

--Sean
