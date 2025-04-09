Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85EC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDDD836B2;
	Wed,  9 Apr 2025 16:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fxe6SLPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E2C82140; Wed,  9 Apr 2025 16:30:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13C082140
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso937236166b.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744208998; x=1744813798; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wjacCszumv5o9II0dYfYDlkC6ZCqsPU7mvapGNdJu7w=;
 b=fxe6SLPoN2UWOglFLV6E8LREIPDkBlQ5RTv7hXMIGi169bPl0Xrq2pDPPA0Mf2d9O2
 UizlLnmymt9LvhMmWdA+vqTQ/az24YeRaooljOtMer47xNB9UD00bwQEpmYWzbCwkxEZ
 1FpIGczZXwAg9fX0BV+CBLZ3XYsYIs/e4JEg7cqsZvwmR1445nB8K1fv3L/G6rb6mNdu
 BYM3kxyawIrgdzxrq/hveWH/uPlIczVyM9sZUh84X+jfmRGbkA+9h2ZKpRvDnOMPJ/m+
 0XrmhqnQKb9XMSCNltqP7rJHJJ3uSvHLTJy9wx2NU9z9YsJIu7MulDBBmoEiLhDxM302
 d//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744208998; x=1744813798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wjacCszumv5o9II0dYfYDlkC6ZCqsPU7mvapGNdJu7w=;
 b=miqFILFSxC7AyW/0Yn1asU6eYWMp+WAjTBpcgBAASkjZtZNiS62Mra/y3hVaFItdQo
 4I1p8CJsyCy15nzhwizoTJ3OJ3rUI1LfCd0+quIGbrrZbNx8FEdOayFpyq25BSuhYmAD
 UFXi9JpDeMZkUgD4qFcxh/7PrrCgY/K4izjsxdDJTlcTlXfl1M5+37FRVxUm26TXeocm
 xkjxY/V/VWld/XcGtkfhH2POk+21xiikE6hblSJnKPzowKz89jKAlDEROEBr7c63/8A0
 ByuogRgO3e+C9o/mpSoZ1st/tr3lkuzMXBhsE8i+x3G2fU+1BldT535gmnVy527csm7A
 1IZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrVhtRAS0LpteJcJF7ngH1gT+DyKonzp9r1M6NAbLn77BwUaII18T8cXHQON800xdMdfF92IY=@lists.denx.de
X-Gm-Message-State: AOJu0YymTLsQPCCBLLDmviU3QYytj3dHhXVfLplzHgFUg+T3VltThbVf
 1QWjuy0xGPUQjsTOSqep9fqBd404ofpchYV9UVFhmMmrwHyzjVdpRAvSDJBll/k=
X-Gm-Gg: ASbGncujr4Kp00nk3OWj/svwgvVMvY+pSFZ5jO9JFzkGZPYQ89Bj25V1YxvQIB/C0xz
 irrFpHz95ZIcUFxqikqxS9GCanMs3jVfqZqrfhwYM6PCu2u0+E2eJHu14uwKkyHR82BCzdAXgXo
 o71u4Ug7807L0CSyVtrt111C9gMaNJEZ4t8uzJBYAxgOldpGaJg6gN1RRMtEstl/sdhK3lVxsQ5
 abAOA1BqzRfG7OQEMcbESug+k5TqF6GoYXdV/yS2fNHJyd4D5vYKhzIz26BLnDKQZK2BBqUQ9vX
 iq/H9jJ6seKtmLoQv/IpUqwdHB38qQIUlSG4uCYeSDaV4wbzU0MW88VhcVTuLwR+FDeV5tC5ZRH
 yHIJ0BGVX9ghH8X02/AZgOy/6FxMN
X-Google-Smtp-Source: AGHT+IHU9tJiNfZDts3gaHrFeGza9w3SXJZmuyPnEmYMU73LFsV7X0Y8eLC+lAGqKjvlPaF2k4H3lA==
X-Received: by 2002:a17:907:960f:b0:ac3:cabc:1be7 with SMTP id
 a640c23a62f3a-aca9b72ee2bmr289654566b.48.1744208998075; 
 Wed, 09 Apr 2025 07:29:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79?
 ([2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ccd223sm105593666b.133.2025.04.09.07.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 07:29:57 -0700 (PDT)
Message-ID: <152978de-5a81-4512-a478-0ecf6a5ee5ac@linaro.org>
Date: Wed, 9 Apr 2025 16:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net-lwip: wget: add LMB and buffer checks
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20250409122007.2560668-1-jerome.forissier@linaro.org>
 <20250409122007.2560668-2-jerome.forissier@linaro.org>
 <7be98569-3565-4db5-aa3f-b6dd68ee8ac5@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <7be98569-3565-4db5-aa3f-b6dd68ee8ac5@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 4/9/25 16:17, Heinrich Schuchardt wrote:
> On 09.04.25 14:20, Jerome Forissier wrote:
>> Legacy NET wget invokes a store_block() function which performs buffer
>> validation (LMB, address wrapping). Do the same with NET_LWIP.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>>   net/lwip/wget.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 41 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index 14f27d42998..746c8164d66 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -6,6 +6,7 @@
>>   #include <display_options.h>
>>   #include <efi_loader.h>
>>   #include <image.h>
>> +#include <linux/kconfig.h>
>>   #include <lwip/apps/http_client.h>
>>   #include "lwip/altcp_tls.h"
>>   #include <lwip/timeouts.h>
>> @@ -201,11 +202,44 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>>       return 0;
>>   }
>>
> 
> Please, add Sphinx style descriptions to all functions.

OK
 
>> +static int store_block(struct wget_ctx *ctx, void *src, u16_t len)
>> +{
>> +    ulong store_addr = ctx->daddr;
>> +    uchar *ptr;
>> +
>> +    /* Avoid overflow */
>> +    if (wget_info->buffer_size && wget_info->buffer_size < ctx->size + len)
>> +        return -1;
>> +
>> +    if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
>> +        if (store_addr + len < store_addr ||
>> +            lmb_read_check(store_addr, len)) {
>> +            printf("\nwget error: ");
>> +            printf("trying to overwrite reserved memory...\n");
> 
> Output while an EFI application is consuming the HTTP protocol should be
> avoided as it is not compatible with the EFI console.

What does printf() do in this case (EFI application)? If it's just ignored
then I suppose it should be OK to have the printf() right where the error
occurs, no?

> If you want console output in the wget command, please, implement it
> there and not in a library function called by efi_net_do_request().

That will make the code slightly more complicated, although not much (some
additional status in struct wget_ctx).

Regards,
-- 
Jerome

> 
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    ptr = map_sysmem(store_addr, len);
>> +    memcpy(ptr, src, len);
>> +    unmap_sysmem(ptr);
>> +
>> +    ctx->daddr += len;
>> +    ctx->size += len;
>> +    if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>> +        printf("#");
> 
> ditto
> 
> Best regards
> 
> Heinrich
> 
>> +        ctx->prevsize = ctx->size;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>>                  err_t err)
>>   {
>>       struct wget_ctx *ctx = arg;
>>       struct pbuf *buf;
>> +    err_t ret;
>>
>>       if (!pbuf)
>>           return ERR_BUF;
>> @@ -214,18 +248,17 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>>           ctx->start_time = get_timer(0);
>>
>>       for (buf = pbuf; buf; buf = buf->next) {
>> -        memcpy((void *)ctx->daddr, buf->payload, buf->len);
>> -        ctx->daddr += buf->len;
>> -        ctx->size += buf->len;
>> -        if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>> -            printf("#");
>> -            ctx->prevsize = ctx->size;
>> +        if (store_block(ctx, buf->payload, buf->len) < 0) {
>> +            altcp_abort(pcb);
>> +            ret = ERR_BUF;
>> +            goto out;
>>           }
>>       }
>> -
>>       altcp_recved(pcb, pbuf->tot_len);
>> +    ret = ERR_OK;
>> +out:
>>       pbuf_free(pbuf);
>> -    return ERR_OK;
>> +    return ret;
>>   }
>>
>>   static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> 
