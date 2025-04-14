Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E410C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 12:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D858B820F8;
	Mon, 14 Apr 2025 14:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tiWX12mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4AE82102; Mon, 14 Apr 2025 14:33:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5488209C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 14:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so35743285e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744634010; x=1745238810; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vqZkSLgZnG6CjBtLDjFrZb5WTHNTpVWoqGi0U1OpT6E=;
 b=tiWX12mk/BW232Sz6X+FUm9unpb11RyK0bn7xjS9n/qnJE2nT+T27BRO7bPxF8NzKY
 ZkjU2kGzC3TVw5NtIN9ViAC0n7eWJ7ig/5vZi8Z3GP3phIihVC6xzDAZi8BzofaVptdQ
 lVwg4TDl78k9VKE5pRpjPN8hJWSGFAD6BC6nJAWmS5LflR0XV5qAi8wxTJ8T15h7y4T8
 fYSS4bL0h9N0r7Ez6NiaYfuApyANaYTgzPPMFVbd2TGxwIqqSCSHMj12+pK9Vho19aFv
 kPd0qbtzbt9kTjbMm/wzB9ZG5plJqjqxQghag8GUGAx2tLbYyh7zMJuCOQKNi0qiPDy8
 qeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744634010; x=1745238810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqZkSLgZnG6CjBtLDjFrZb5WTHNTpVWoqGi0U1OpT6E=;
 b=Y/Dxq2Dm35ULnPJyTg2a2Y1bEgEFH6upPUJJ7CC0peLN5DxQLz2wbKCOPc1HUokgbz
 nJpoJNx6ZNqBR2SObCVFEvZiYxGCCuKegEEMe9o7fDA0hTO+e8zTm5Ud+FG6cXc1xG4Y
 zDCBOAdAEoq+F/Y2wNYUREOlhJjYhttYS2dxIlguVtSXwoJWH13l9Mgh5038wzmDRWMX
 udmo8i00nzVU7/CaG6KAA/gVG5eRQ9igc23ZrKf9OCnRiyNd9JCfIX4LWQcjqiYGCmtf
 XdKTIrs4srl57UZ/S3QgbA19xivuyrk9VGEiq1dj6rfyRfS/shOccwfg+YibVnpi4AMs
 ldrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJlZ1fbQCvacUR44lqdtQ3K+t+gSaFcATCLU7kNa66pnXE+uirm9IBvfEx9X0sof9YM++3hw4=@lists.denx.de
X-Gm-Message-State: AOJu0YyLj1EZ75wJELKvJ2EuaVR1QBchEyChPqkJbF9MqyZFQYU772aI
 C/Ja/Urr5+hp+JQXnwnUEnGMSA38h3tZAnHGv8Zz08utq6QAz/K2yW+Ooc0vjVQ=
X-Gm-Gg: ASbGnctEsi/jQcqki3lopG9/pFnAYvMTz/uNc/c2Fpy25mXY/7oWQ/esYuOzav/ulSJ
 L5Wnl4WAMuAMhfPSIpWZbyvAqsdFs8E3OYluzjuSwWLXrBG1kpqAFKXsJofNYEjtHeczryz0VaY
 y+FBFkmPMOhWffnSSMvIb1deEKodv7oi4xb4l4dw+5qGfvDrbA5WvNaw9iXNZEh6FQGcoXhxcyp
 ZUxfJIbO0AXL1Z5ldJCt8ErxMBMhpaTCSbNWCtCVg4Apcubu2bW1sujtJ/O7VLuvuN5a6apNsqe
 n+A7faU13h/Y9qTOo7DoAwj7a1ydkSwU/AS/kmuqAKdItUUNmAMgpxLXSGZ6cwP8/wgDDrA=
X-Google-Smtp-Source: AGHT+IHpqfgcOHtvV/oOlZgkhXaoxUIkLZqnMOeABktaGNidpz8MiCt1A0rBdPBK/vzdNQtEJRDXOQ==
X-Received: by 2002:a05:600c:5249:b0:43d:7588:6687 with SMTP id
 5b1f17b1804b1-43f3a93f621mr98065275e9.12.1744634009919; 
 Mon, 14 Apr 2025 05:33:29 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B76.versanet.de. [94.134.59.118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c7a68sm173808715e9.19.2025.04.14.05.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 05:33:28 -0700 (PDT)
Message-ID: <e8a45df8-d71e-4e2f-8b4b-440684438c06@linaro.org>
Date: Mon, 14 Apr 2025 14:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] event: signal when livetree has been built
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
 <CAFLszTg9d97fFaosbCfQqCyBHivfn00S01_0wK9mB3RXZ7VbRA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTg9d97fFaosbCfQqCyBHivfn00S01_0wK9mB3RXZ7VbRA@mail.gmail.com>
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

On 4/11/25 20:27, Simon Glass wrote:
> Hi Caleb,
> 
> On Fri, 11 Apr 2025 at 06:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
>>   common/event.c  |  3 +++
>>   include/event.h | 18 ++++++++++++++++++
>>   lib/of_live.c   | 11 +++++++++++
>>   3 files changed, 32 insertions(+)
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
>> index 75141a192a48b0931667632f41be8ff4d6139f7c..1d267f1d10547642d381fa287ab4981a2bf03543 100644
>> --- a/include/event.h
>> +++ b/include/event.h
>> @@ -152,8 +152,17 @@ enum event_t {
>>           * A non-zero return value causes the boot to fail.
>>           */
>>          EVT_MAIN_LOOP,
>>
>> +       /**
>> +        * @EVT_OF_LIVE_BUILT:
>> +        * This event is triggered immediately after the live device tree has been
>> +        * built. This allows for machine specific fixups to be done to the live tree
>> +        * (like disabling known-unsupported devices) before it is used. This
>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> 
> Add a bit more detail, e.g.: before it is used by U-Boot
> post-relocation. This means it is possible to affect the devices bound
> by driver model.

I think this is really implied and made obvious by context clues. IF 
there comes a time where we build the live tree more than once (e.g. to 
build it as part of the DT_FIXUP_PROTOCOL for some reason) then the 
extra info you propose adding would no longer be correct, where the 
current wording would remain correct.

> 
> You should also note that the flattree is inactive when livetree is
> used and any changes may eventually be passed onto the OS, if it
> doesn't have its own devicetree. This is the point we were discussing
> on the other thread.

This information is totally irrelevant though, and there is no broad 
agreement with your proposed changes. The livetree API is also set up so 
that one could build multiple livetrees (for whatever reason), this 
event is modelled to reflect that (where you can see in my v1 patches 
that the event assumed you would only ever build the global tree).

> 
>> +        */
>> +       EVT_OF_LIVE_BUILT,
>> +
>>          /**
>>           * @EVT_COUNT:
>>           * This constants holds the maximum event number + 1 and is used when
>>           * looping over all event classes.
>> @@ -202,8 +211,17 @@ union event_data {
>>          struct event_ft_fixup {
>>                  oftree tree;
>>                  struct bootm_headers *images;
>>          } ft_fixup;
>> +
>> +       /**
>> +        * struct event_of_live_built - livetree has been built
>> +        *
>> +        * @root: The root node of the live device tree
>> +        */
>> +       struct event_of_live_built {
>> +               struct device_node *root;
>> +       } of_live_built;
>>   };
>>
>>   /**
>>    * struct event - an event that can be sent and received
>> diff --git a/lib/of_live.c b/lib/of_live.c
>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..c1620616513c2e32448b4a6d156a9162d97c76b7 100644
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
>> @@ -320,8 +321,9 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes)
>>
>>   int of_live_build(const void *fdt_blob, struct device_node **rootp)
>>   {
>>          int ret;
>> +       union event_data evt;
>>
>>          debug("%s: start\n", __func__);
>>          ret = unflatten_device_tree(fdt_blob, rootp);
>>          if (ret) {
>> @@ -334,8 +336,17 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>>                  return ret;
>>          }
>>          debug("%s: stop\n", __func__);
>>
>> +       if (CONFIG_IS_ENABLED(EVENT)) {
>> +               evt.of_live_built.root = *rootp;
>> +               ret = event_notify(EVT_OF_LIVE_BUILT, &evt, sizeof(evt));
>> +               if (ret) {
>> +                       log_debug("Failed to notify livetree build event: err=%d\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
> 
> This should move to the caller of this function. We should also have a

Why move it to the caller? Then every caller would need to signal the 
event and we'd pointlessly duplicate code. The event signals that /a/ 
livetree has been built. Today this only happens once and we make the 
assumption that this livetree is to be used by U-Boot and only U-Boot.

Should this assumption become incorrect in the future, it would be 
trivial to introduce a variable to the event_data that describes what 
the livetree is and/or where it will be used so that anyone catching the 
event can decide what to do.

Since we don't yet know any other usecases, it would be overzealous to 
try and capture this information since we just don't know what's important.

> sandbox test for this feature, e.g. catch the event and add a
> node/prop and check in a test in test-fdt.c (or similar) that it is
> present.

What would this test other than that the event is sent? We already have 
tests for the event framework...

> 
> I'm not sure if you need to update test_event_dump.py but since CI
> presumably passes, I guess not.>
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

