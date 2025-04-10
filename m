Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82752C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 13:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EAE83C67;
	Thu, 10 Apr 2025 15:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NCLaOtVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8A583C72; Thu, 10 Apr 2025 15:00:28 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0AF83C39
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so6961355e9.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744290026; x=1744894826; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YAugLSnxnQ0gLVapp/auEWl67vFSbmA6Bee8cgAQInU=;
 b=NCLaOtVei/GeX3W3BDwG8bAYfIzdt77eMuC6Fw1COaYKdfDcxfn4jjOHDzt1lm1sLS
 2YbXsfuOEE8u6gCvKAEhXINFHubpCJhdOBWmXm+trAfNc8UD6Wm0cmzwCQg5Ga/citIm
 ozoZ4GC7Ys4bY+Ze2g+ioxl4SD0vpaYBEff+Wq2/1jgecBepaBz79oK94cICW1WVVwtg
 EU4AbGpEHJrLkMBEBzXWKLPge8gvbXx+njEIowPn4Hedc7hZGIougdgL3afoLEM+U34W
 52mnoeZbmpYXafmZJrUesRuaaDFD/D7J3MVvsoWIYV7vdOXbu7ZG8ShBdYMPqvKvS91V
 qUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744290026; x=1744894826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAugLSnxnQ0gLVapp/auEWl67vFSbmA6Bee8cgAQInU=;
 b=myuUefGAZ6jMHOvHmjigsXdhnJzQfzyx8DL64nG8qL9mU0JoVS+3lqF/9haWDsJnjV
 0dC/ehfQ96AQ2h3DWZiWrD/RLcapmAaXP99D5QnrlbGaaoXlXUeuwtL7Zwj8CjADhRW6
 02/CA/PRSAmJQAwtfjJwt0FnSaVjYt6nCoOd7fOCbNKF9XcbHA7ouEqzF9aPG69XVV1w
 9GmWFp5nqss2DQKELfyFriAk22ubcgzbYMlhl4NTppnRTegbIPNJPIa454szgcffRkvn
 HYxe5MZNOa6M7Vuuj9Av7X2WiLI0uGu9jyo4w3CrE6ubKmoRW44eUGEaSkZIWW1d57IK
 yT5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyn0ge2OEOmZXsHm91jO7l7vAM1pyBdBFB5Dk3nyvFsV/XHY9lR22bmVJAPWKd8vQwFiUjwl0=@lists.denx.de
X-Gm-Message-State: AOJu0YygoppnWHWW6ni/GbFuG1qbl+74QXzo6IRM7PdUVii16k8E+OOJ
 oUjhw/D+a45E3WOZlMAIkXy2i5u5g43kbSucZQTutooGbe4PtNsF371byTZQUDM=
X-Gm-Gg: ASbGncu6L7ckPEm3Elc2vmcG56w49CDSYN3BnFn7MmVS8c//W3lAT3RSa2CQ6ScrXWw
 d/3qPJk0HNPTipFxH1IMIveIHLdNIBecr/P10NIxvDdJmI3hSjG0rAoBx29UItlDUFwg/UMTVsp
 ailEfVHELfGg4Ue3tYZrtsJ8dHYIreS35vS9XeIBFlhTN7eY78Pcfn/teqIBjTz4gF6GHsbDoMO
 YQGugLYYfJZFlD4olxiOCo5hpbkERiiTTOtp7TogDL08/dYmgTS9pg1Hea8QHxtQ8zpN9j3lzCZ
 qAAp8JGeAg7eTn1onTLkLGX8zItKVhKAM91z0igjZFBqhw0GT/S4t//5l/SpPKUSP1t5
X-Google-Smtp-Source: AGHT+IGbPtr90DgCZcYGhn9XHDGp9+gdkV97Zf0oew2qjmtp4xgA8NfsJho/xunBRYzBDNM8hj+glQ==
X-Received: by 2002:a05:600c:4e46:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43f2d687689mr32130005e9.0.1744290026055; 
 Thu, 10 Apr 2025 06:00:26 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207aed49sm53367125e9.34.2025.04.10.06.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 06:00:24 -0700 (PDT)
Message-ID: <d807638b-c6ac-429f-b177-ce9427b504f6@linaro.org>
Date: Thu, 10 Apr 2025 15:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
 <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
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

Hi Simon,

On 4/10/25 13:27, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> OF_LIVE offers a variety of benefits, one of them being that the live
>> tree can be modified without caring about the underlying FDT. This is
>> particularly valuable for working around U-Boot limitations like lacking
>> USB superspeed support on Qualcomm platforms, no runtime OTG, or
>> peripherals like the sdcard being broken (and displaying potentially
>> worrying error messages).
>>
>> Add an event to signal when the live tree has been built so that we can
>> apply fixups to it directly before devices are bound.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   common/event.c  | 3 +++
>>   include/event.h | 9 +++++++++
>>   lib/of_live.c   | 3 +++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/common/event.c b/common/event.c
>> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
>> --- a/common/event.c
>> +++ b/common/event.c
>> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>>          "ft_fixup",
>>
>>          /* main loop events */
>>          "main_loop",
>> +
>> +       /* livetree has been built */
>> +       "of_live_init",
>>   };
>>
>>   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>>   #endif
>> diff --git a/include/event.h b/include/event.h
>> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
>> --- a/include/event.h
>> +++ b/include/event.h
>> @@ -152,8 +152,17 @@ enum event_t {
>>           * A non-zero return value causes the boot to fail.
>>           */
>>          EVT_MAIN_LOOP,
>>
>> +       /**
>> +        * @EVT_OF_LIVE_INIT:
>> +        * This event is triggered immediately after the live device tree has been
>> +        * built. This allows for machine specific fixups to be done to the live tree
>> +        * (like disabling known-unsupported devices) before DM init happens. This
>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
>> +        */
>> +       EVT_OF_LIVE_INIT,
>> +
>>          /**
>>           * @EVT_COUNT:
>>           * This constants holds the maximum event number + 1 and is used when
>>           * looping over all event classes.
>> diff --git a/lib/of_live.c b/lib/of_live.c
>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
>> --- a/lib/of_live.c
>> +++ b/lib/of_live.c
>> @@ -10,8 +10,9 @@
>>
>>   #define LOG_CATEGORY   LOGC_DT
>>
>>   #include <abuf.h>
>> +#include <event.h>
>>   #include <log.h>
>>   #include <linux/libfdt.h>
>>   #include <of_live.h>
>>   #include <malloc.h>
>> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>>                  return ret;
>>          }
>>          debug("%s: stop\n", __func__);
>>
>> +       event_notify_null(EVT_OF_LIVE_INIT);
>> +
> 
> This should go in initr_of_live() since the function you are dealing
> with here is supposed to just do the live build.

Well, we only every call this function from one place right now, but if 
it was called multiple times for some reason then I would want to be 
able to re-apply fixups to the new live tree.... I guess it should 
probably pass in *rootp to the event handler, let me rework that.>
> Same for the EFI_STUB thing which I just noticed, actually

what EFI_STUB thing?>
> Also please check for error
> 
> Otherwise this seems OK to me. I do wonder why we can't use
> EVT_FT_FIXUP though. Could you add mention of that to your comment in
> event.h?

Because FT_FIXUP is for fixing up the flat tree before starting the OS? 
these are obviously different things imo, im not sure how i could 
clarify this.>
>>          return ret;
>>   }
>>
>>   void of_live_free(struct device_node *root)
>>
>> --
>> 2.49.0
>>
> 
> Regards,
> Simon

-- 
Caleb (they/them)

