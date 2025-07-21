Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B6DC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 08:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3570E82D06;
	Mon, 21 Jul 2025 10:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uKbObHh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B46C8309E; Mon, 21 Jul 2025 10:11:55 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B6682C87
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 10:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-455b002833bso14675625e9.0
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753085512; x=1753690312; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+K5YTVYMeiivErsKg7FwfbhfHUQCeS7jEpgBCF0BYwY=;
 b=uKbObHh5wrOD7xg6Ih9gIX4p+zv+aE9c1L0C82QS7l+NAE4ZsSrAzyb2/GL0dDUPv7
 1bYhrG93LtvENSuRkTWontL4fdg6SKpkX378BRlZl2UK+FpzaDSNyY6Rw5ZC8wF91fKH
 2p0XsTcwRwPvr6YkRtKkpuXSWae31/z1zeRpKe0ysizWVA05sAMdjlRRQoeLwptA1F7S
 PcZGjFUA2oyB8dbythy2hzPxx97a21nWvcC39nFgQ01HJlB9qcsVR9Tcwsu45S+5s6MU
 Nqnv7K5deGgS2Vxz1xWSWIRCq12yyjIRA8E0+2U+uXtAu6VG6whNy65BwgJTvHx+APaX
 QtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753085512; x=1753690312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+K5YTVYMeiivErsKg7FwfbhfHUQCeS7jEpgBCF0BYwY=;
 b=Zk0oBqZHQlg2pIWYMtHyhssS+QUTeE85JfLMAWsKHjh3lVMK0VQvB9fxkjYd3w9ezX
 jmE0QPJ7NbAqx0TjvCaYXmFk8MwLVhUu90X0GCUUT9mnSY46/gQihTdpkLuQijssuB2X
 rFW7SIzugytN+8kRAX6pJoppnu+AazZljc1E1Q0agNDM+Pj1kVujl15+IaBVe/mbaQsf
 RY0b0idLyAdTZT7lzBnia9MDDEgMehSiivA4HdUnZax0+y7FL1Ri31Q5ZD59QSHNbngZ
 7XjvDXcMGHW3XN7af0brnLTeoMu7tEyeQDi4adYFTkrQFpnqJHTC2Fc+gZWQYPUERfOd
 eahQ==
X-Gm-Message-State: AOJu0Yw/KjeP4YhpOQWUSEUHNnoO68m5WkcYFSQZi5eNNte3Zs0Z4A4m
 /1W9FJh1IjjSjmvvRI9q7IZgW8KFXWLiTuStLcwOE7ku6vAPRas/6E1XTiqkMlygIxo=
X-Gm-Gg: ASbGncv0Tf6XeE2Qh1PkCZ10vhEbgn/bWOCR3e1+SLfbTz7shuseiB+nqGu09DyzTGQ
 tlTokuImbDs8/XrB02dA41bmKRBdikky0fDi4012gx6myjdE/JflH55oEQOIkUlFsdB2tq8ZsZk
 NOtSEdxY3uYy8qGrxwz0a0GaPc1FpbPhkPt+Mm/yod8KBsuZrQ3aeu1LLa7KwaABka4C0VI/iwL
 o8OSF1kA0+n+2xKWl76psdJgGhCPUTryb/F9nCTj3ibvoYDvtjB9ODGR4jA+KhPiqnpZACx2+hO
 7FUCGvsQ8jIwtli3VG1+E0Mh7bwS0Rs2j3173uLhBwvBMjMV9Z+DkRvT3+G3Fvhq1Wh2UbDc5Wi
 mmVenyO9WztWREp+pwtTwbMtdVxv6O79xhE9LsCdBQc3NVFrvPqkNHkt/glbtrBJHi/wPF/+GU4
 VXGNxjC5ILqBY=
X-Google-Smtp-Source: AGHT+IHbXUs+2H2e6r/vZ3PtPHHnKGn73MpsgjtnSfdWBBm6der4WvteXCrUeYREQwuAilZgO6ru6w==
X-Received: by 2002:a05:600c:4f91:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-4562e23b6a5mr197983385e9.14.1753085512065; 
 Mon, 21 Jul 2025 01:11:52 -0700 (PDT)
Received: from [192.168.0.59]
 (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b74f9c0sm93979965e9.28.2025.07.21.01.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:11:51 -0700 (PDT)
Message-ID: <0f5fa291-fe9b-41d6-8672-550f41b35dfc@linaro.org>
Date: Mon, 21 Jul 2025 11:11:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: atmel_qspi: fix race condition in transfer
 completion check
To: Ramin Moussavi <lordrasmus@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
References: <20250713160826.108821-1-lordrasmus@gmail.com>
 <0c6dc75a-1252-4236-a322-61def9b17775@linaro.org>
 <CAJxQxNDMFGc1NJBEJ-uOUp6f=1NmRBWXT2FY1rJsQocrhZsRiw@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAJxQxNDMFGc1NJBEJ-uOUp6f=1NmRBWXT2FY1rJsQocrhZsRiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 7/20/25 14:48, Ramin Moussavi wrote:
> Hello Eugen
> 
> here is the updated patch

Please do not attach the patch to the email. Just create the patch using
git format-patch -v 2 and then use git send-email to send the patch.

We will review it after you send it like that.

Thanks

> 
> Am Mo., 14. Juli 2025 um 22:33 Uhr schrieb Eugen Hristev <
> eugen.hristev@linaro.org>:
> 
>> Hello Ramin,
>>
>> Thank you for your patch.
>>
>> Can you please change the subject to have "spi: atmel_qspi: ..."
>>
>> On 7/13/25 19:08, Ramin Moussavi wrote:
>>> In atmel_qspi_transfer(), the status register is polled with:
>>>
>>>   imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
>>>   return readl_poll_timeout(aq->regs + QSPI_SR, sr,
>>>                             (sr & imr) == imr,
>>>                             ATMEL_QSPI_TIMEOUT);
>>>
>>> However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
>>> and will then be cleared by the read. If that happens, the condition
>>> "(sr & imr) == imr" can never be true, and the function times out.
>>>
>>> This race condition is avoided in at91bootstrap by accumulating the
>>> status bits across reads until both bits have been observed:
>>>
>>>   /* Poll INSTruction End and Chip Select Rise flags. */
>>>   imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
>>>   sr = 0;
>>>   do {
>>>     udelay(1);
>>>     sr |= qspi_readl(qspi, QSPI_SR) & imr;
>>>   } while ((--timeout) && (sr != imr));
>>>
>>> Update U-Boot's atmel_qspi_transfer() to use the same pattern,
>>> ensuring that both flags are observed even if they are not set
>>> simultaneously.
>>>
>>> Signed-off-by: Ramin Seyed-Mousavi <lordrasmus@gmail.com>
>>> ---
>>>  drivers/spi/atmel-quadspi.c | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>>> index 8aa7a83aef4..fba32876f8f 100644
>>> --- a/drivers/spi/atmel-quadspi.c
>>> +++ b/drivers/spi/atmel-quadspi.c
>>> @@ -616,6 +616,8 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
>>>                              const struct spi_mem_op *op, u32 offset)
>>>  {
>>>       u32 sr, imr;
>>> +     uint32_t val = 0;
>>> +     unsigned long timeout;
>>>
>>>       /* Skip to the final steps if there is no data */
>>>       if (op->data.nbytes) {
>>> @@ -636,8 +638,19 @@ static int atmel_qspi_transfer(struct atmel_qspi
>> *aq,
>>>
>>>       /* Poll INSTruction End and Chip Select Rise flags. */
>>>       imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
>>> -     return readl_poll_timeout(aq->regs + QSPI_SR, sr, (sr & imr) ==
>> imr,
>>> -                               ATMEL_QSPI_TIMEOUT);
>>> +
>>> +     timeout = timer_get_us() + ATMEL_QSPI_TIMEOUT;
>>> +     while(1){
>>
>> There is a missing space, can you please run checkpatch tool and fix the
>> warnings given ?
>>
>>> +             val |= readl( aq->regs + QSPI_SR ) & imr;
>>> +             if( ( val & imr ) == imr ){
>>
>> Remove unnecessary brackets please, also spacing is odd
>>
>>> +                     return 0;
>>> +             }
>>> +
>>> +             if ( time_after(timer_get_us(), timeout)) {
>> Same here
>>> +                     return -ETIMEDOUT;
>>> +             }
>>> +     }
>>> +
>>>  }
>>>
>>>  static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
>>
>>
>> Eugen
>>
> 

