Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FE5CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D6B83448;
	Mon, 22 Sep 2025 16:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGQkn65i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EA083211; Mon, 22 Sep 2025 00:59:20 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D541C82B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 00:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f32d99a97so358855b3a.1
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758495556; x=1759100356; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aN1cKNZ/ROP1/IbzszO5mIbx8jqpKcySNVES0DxnWlc=;
 b=aGQkn65i6A83mMSuA0R6gZUH+g6ckqR/XotawKJN4QEfw+NYw+/Z9HaZdeLNF2eyqh
 xNd2Fx1pYoqSe00yVuXg9+Fsk/zNjNySKlAK6Opj1XbS4p263KkADmCnfO2/leap7DYi
 mTQDrO8VUx5OIJIrhoSgHTN290Bx9HIXce66v9n9dBaSDMhTbbhDnZimKjcG7uQ/6QYQ
 p/Yso0TM/PPcv3VyczUq4DHcn3jKCr+sfOVhabYV/jSdOkwZ1H+mtwu4tTN1VglF2J3m
 kGPa1BvVtVK0ZvK9dV+FwAOZxZqHJfXoUl9jBst6Il9ybaICzXypTMafHRHwprs/uJry
 WMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758495556; x=1759100356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aN1cKNZ/ROP1/IbzszO5mIbx8jqpKcySNVES0DxnWlc=;
 b=VV3pr1i7/16wAv3lBOJVorPis2xmYKxK0CYmSKlJ83bBuQA4Ev2w4Scc86aQN9+t8J
 pVy4Wn3GJ1+rD7rzeIMD1F9HwGadWitwZ9eO0pwBHwgYmMAxoiDHz0QRRTxBI+E6u46y
 uxnyoJhxiY+WzFPsIgcH5GCkrpYN8TAoItR6wU38KdOYGOqGBHSZ0OZpjzTEpUGgtdyf
 VZHBDHC3044+HIPXio6+7LSIs157yIpkpjW9eniVECIoXOaOW7CLamwl6wk0xoFhOZoq
 KUDO/NplMAnwRxTNxUONz5dJIAt1aIFYfedtFbh8AYIstyFP1ehk4U+h00GCcH4eAbfa
 ZvVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+lX60B7QP73AvW4GFZjLk8RV58acEmIpZOjsu6IktKcNjYss1vW0y1QcDQV5SJ/UqcPbAi4=@lists.denx.de
X-Gm-Message-State: AOJu0YzHZVeYzsEicGexqsnfka0z34nh9WVolzPJrj3yaHDqQa8OWx/z
 z5gJTmlyNPUv3fuUnGqAj9kxtqoBOBLNdo98RJK/P9v/w6kLwGpDjwvATKqxSw==
X-Gm-Gg: ASbGncsbu6Liz6HSEwqUvBQ6s2yhij3HS91FAWAcCJ3RD9XoP+fy5+CFVFDiIcCy2Kb
 vmqQS0PKFFOamYvPV9FN9E/4wLyzZp5XeDT9PkC8gLRyS3LJFZ66m6Yakk+6DToeDavrhNGvNVc
 6aY/lW6QSTf6F/Wj1qFuCT1Ee6ZG4HoFrRdpnMNn/sQfTpHT7Ao2rMiKAxxvYWIcYzauttk/92H
 smQXB1ZrDNagxpc4p3EwngP4mkriMvhEUJw1H6dW5hFD688dqGCh98fG0On95DoRcJeNLJyu9iA
 Xfj675SfCAEBJYpgAGTGoftHkD12Dl5zHQPnWbU9hZo32KrG1/S8cx/fS717eD3H4LrzoiZuTC6
 MWUdAeuGa4PpABUjLcl1phmsP0XdYOt7e7tRwFJQ7yOkBK+FvjYmYS7QWIaIF5m4E7Ez6Pkz/Wu
 X95Rxl/tA=
X-Google-Smtp-Source: AGHT+IHJdShWV0XS9qInhKZwrZgfTjhr+UDW1TGzm0aMHyPrwpebuWPlYYD25t9LaR8JCIqn/s9Ruw==
X-Received: by 2002:a05:6a00:997:b0:772:3aa4:226e with SMTP id
 d2e1a72fcca58-77e4e4c834dmr12531429b3a.19.1758495556183; 
 Sun, 21 Sep 2025 15:59:16 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77eee36c2b2sm7058068b3a.78.2025.09.21.15.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Sep 2025 15:59:15 -0700 (PDT)
Message-ID: <443410c2-c5c8-4ed4-8b69-a4318b62550e@gmail.com>
Date: Mon, 22 Sep 2025 06:59:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] [U-Boot, v4, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: Marek Vasut <marek.vasut@mailbox.org>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250914044115.18391-1-lucienzx159@gmail.com>
 <464e0429-ac06-49fc-831d-b9e86946446d@mailbox.org>
 <0924393d-c87b-4a6a-8590-3ab49d039dfa@gmail.com>
 <8429f5cd-2c8e-4e2d-a661-a7f6d6ddf215@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <8429f5cd-2c8e-4e2d-a661-a7f6d6ddf215@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Sep 2025 16:40:04 +0200
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

Hi Marek

Marek Vasut 於 2025/9/22 上午 06:40 寫道:
> On 9/15/25 4:35 PM, Lucien.Jheng wrote:
>
> Hi,
>
> sorry for the late reply.
>
>>>> +__weak int en8811h_read_fw(void **addr)
>>>
>>> Does this still have to be a __weak function, now that it uses 
>>> generic fw loader ?
>>>
>>>> +{
>>>> +    void *buffer;
>>>> +    int ret;
>>>> +
>>>> +    if (!IS_ENABLED(CONFIG_FS_LOADER))
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
>>>> +    if (!buffer) {
>>>> +        printf("Failed to allocate memory for firmware\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    ret = request_firmware_into_buf_via_script(&buffer,
>>>
>>> I think 'buffer' without the & should be used here.
>>
>> Regarding buffer,
>>
>> I've reviewed the function definition for 
>> request_firmware_into_buf_via_script.
>> The first parameter is void **buf, which is a pointer to a pointer.
>>
>> I think passing &buffer is the correct way to call this function.
>>
>> If we were to pass just buffer (a void *), the function would receive 
>> a copy of the pointer's value, and any memory allocation inside the 
>> function would not be reflected in our original buffer variable.
>>
>> Please let me know if my understanding is incorrect, as I want to 
>> ensure I'm using the function as intended.
> I was confused by the current request_firmware_into_buf_via_script() 
> interface.
>
> In the current design, passing pointer to pointer into 
> request_firmware_into_buf_via_script() is not necessary, because the 
> request_firmware_into_buf_via_script() function internally does 
> memcpy() into the 'buf' buffer, and for that to work, pointer to 
> pointer is not necessary, plain pointer to buffer would do just fine.
>
> I think this current interface which does memcpy() is actually better 
> than the one I originally suggested which would use memdup(), so let's 
> keep it.
>
> I now sent an update patch to remove the pointer to pointer:
>
> [PATCH] misc: fs_loader: Use buffer pointer in 
> request_firmware_into_buf_via_script()
>
> That should be all I hope.

Thank you for sharing.

After your patch commit, I will update the driver again.

