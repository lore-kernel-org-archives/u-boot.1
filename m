Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B38EC8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157E282F83;
	Mon, 30 Jun 2025 20:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCNJhGsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2215C80B9B; Mon, 30 Jun 2025 17:52:34 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEDD800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23508d30142so28212065ad.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751298748; x=1751903548; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b97mMb5eEaDhJxUO5qUM1UY6v0whXKViJ7PXaG6YnqM=;
 b=fCNJhGsJXjyxCJqIdM9u280W2bJln491TLdEI+osO5X+B+3jeE5HSz1BkXStrPXrgU
 McuBdE4HVSXdW/RowLhdVKVyrTfDKpkgGTsZ2RDbwWek0mSnBF8n5rgQNdtoQp5KUcvN
 XXMP1Sx1Lk5Kbmg89nL3vWPpTLXV4/Qf09R0wdM+1rEE/RuVh1ZSd/h+fRLl+c4FclU5
 TSs1jyq9IPo/CzNRPuPUDPCsxPLo18Pdg9EBH3zqVz6xtI+DNP7WaD2zsX745aFtYid3
 Iv9Y6xXfQrRmlFK1dhJLhXvCKHOun10hRyOaVPzJjm/KGh4ra9vQcZu4SuYfCFts00re
 P5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751298748; x=1751903548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b97mMb5eEaDhJxUO5qUM1UY6v0whXKViJ7PXaG6YnqM=;
 b=qQY1KNIC+LoMQHiSsZpOLl0JwStbfMOEKoSntZAqG7QhevbfNKQ6psB0ID80RWjWpR
 K7q841C6ojn5lY6qEbYHOMlbDRkUe7Y39Jb7Ijey/63EdA9itHqHARYtnY1hjaP6TTCV
 JJT042vhbXaWRjBIMG95SdIX38EbTtHpnyNVKxJTzEIX5MnQBPVeVBXS2Bvkd7Ast6dV
 4ckDBa24E/KRxevn1Oiy3KjrM/Z1OOUygE2NQnCOZn/IgcAhe0jaJpj/aKfBrmOHgN4H
 Gx3M4mjHFUqXbsYR1e89HiPuZlW8EfXX70t4uxIb1r7nlrEC41c4DVcgbmEP89Soatb4
 zAEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9hjqK4F2TEeqrf2WK2qelfJ4dBnasLyZzlHlU72AocEcewdNXjceRnhKvpN8kk6n4tnq/TNI=@lists.denx.de
X-Gm-Message-State: AOJu0YwQwkYs7wd6k+6ASd13NeYo5tUO6mxsu7d8dIsBQ6WWlRT5aYzX
 q/nfD2JeKocEBxfpNEp0cEElCufKFyO6NakwkiFfYSb/hSCLbjTt45ta
X-Gm-Gg: ASbGncspFDSbNMPezSXKQFESgayXKlK4CglobbYL5ER/bGFnCteaY9p2tKyyWzH4NGp
 6lTCqEhG/JbjKq/k2xVqDSOHpaYRD6fYU8CvTp1mLre5Owo9uxUiUL05yAC36/u5DO8EJbtuHbU
 34hWNAIoq+S6jV5LuR7DyWSdtpKZsiuDOuUhoK/UCKRm1BGV2aixomolnMP9oZbQubxriLW4kmd
 U2x1IKstcCYR8YJ9VFIorhKSyc8I7Mr8xUcAjxXbIlScJbYr4yscyt3Y50Y1xMGPhx9yRSGrUpl
 VWBM2xKLKw5x+Yc18PQOSCykcaHkQSpfNP4wASvPjSeqpaQtKD3OWvQZ2R35TPSwAr/Gq9sMSpJ
 PvmF/VEPxgm6/R+M5K+3IZwyahg68HL8vDdcLMsNiO/ny/nI=
X-Google-Smtp-Source: AGHT+IGEkW1lFkgjdMHACutXNmUXc53eO9Hfc4ZF1Lv0vNsYJGaFkc44kx9gdriWTY99qWnkwhaZ5w==
X-Received: by 2002:a17:903:190d:b0:236:9402:a622 with SMTP id
 d9443c01a7336-23ac460595cmr214700875ad.34.1751298748301; 
 Mon, 30 Jun 2025 08:52:28 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bca5sm83095335ad.124.2025.06.30.08.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:52:27 -0700 (PDT)
Message-ID: <8b6d157a-76cc-418f-8f37-bc38776d1650@gmail.com>
Date: Mon, 30 Jun 2025 23:52:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v2, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: Marek Vasut <marek.vasut@mailbox.org>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 Vagrant Cascadian <vagrant@debian.org>
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250615131243.30770-1-lucienzx159@gmail.com>
 <995a016a-f873-440c-acb7-b18568003e41@mailbox.org>
 <24750b55-0d68-44c0-aed6-c69c7a40dafb@gmail.com>
 <7e7c7608-fd84-4826-9507-1b4e2089a5f4@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <7e7c7608-fd84-4826-9507-1b4e2089a5f4@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Jun 2025 20:53:16 +0200
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


Marek Vasut 於 2025/6/30 上午 06:49 寫道:
> On 6/29/25 6:10 PM, Lucien.Jheng wrote:
>
> Hi,
>
> I'm sorry for my abysmally slow response.
>
Thank you very much for your reply and sharing; I've learned a lot.
>>>> +config PHY_AIROHA_FW_IN_MMC
>>>> +    bool "Airoha firmware in MMC partition"
>>>> +    help
>>>> +      Airoha PHYs use firmware which can be loaded automatically
>>>> +      from storage directly attached to the PHY, and then loaded
>>>> +      via MDIO commands by the boot loader. The firmware is loaded
>>>> +      from a file specified by the PHY_AIROHA_FW_PART,
>>>> +      PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH 
>>>> options.
>>> I ran into the same firmware loading problem recently. I took a 
>>> different approach, have a look at [1] and specifically function 
>>> rcar_gen4_pcie_load_firmware() . This invokes U-Boot shell script , 
>>> which has to be defined by the user, and which loads the firmware by 
>>> whatever means necessary, from whatever storage or location . I 
>>> think that might be the generic approach to U-Boot firmware loading 
>>> . If the user needs to change the firmware loading location, they do 
>>> not need to rebuild the U-Boot itself, they simply update their 
>>> environment and the matching script. What do you think ?
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/ 
>>> patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/
>>
>> Hi Marek
>>
>> I've looked at the `rcar_gen4_pcie_load_firmware` API. As you 
>> mentioned, it allows users to set the storage and location from the 
>> U-Boot shell, meaning they don't need to recompile U-Boot.
>
> Yes, that's the goal there.
>
>> However, I recently checked out `FS_LOADER` and realized it's 
>> essentially the same approach as how I'm currently placing firmware 
>> on eMMC, just with a unified API(request_firmware_into_buf).
>>
>> I'm wondering if there's a future possibility to integrate U-Boot 
>> shell scripts into `FS_LOADER`?
>
> I think it would be ideal to have one unified firmware loading code, 
> so the answer to the "if" part of the question is "yes".
>
> I have yet to think about the "how" part. If you want to give it a 
> try, please do.
>
>> Also, given that the Kernel has a built-in firmware mechanism where 
>> files are compiled directly into the Kernel image, I'm curious if 
>> U-Boot might adopt a similar approach in the future. I'm also 
>> considering if `binman_sym` could be a viable alternative.
>
> I'm not a lawyer. My understanding of this firmware bundling is, that 
> this is a legal minefield which is better avoided, and also causes 
> redistribution problems with prebuilt U-boot binaries. You end up 
> bundling together GPL code (U-Boot) and non-GPL code (firmware blobs), 
> and the final license of the result is unclear to me.
>
> +CC Vagrant, since they have insight into this from Debian side.
>
>> For the short term, though, I'll go ahead and submit the EN8811H 
>> firmware loading method using the `rcar_gen4_pcie_load_firmware` 
>> approach. I'll then explore potential improvements later.
> Please wait a bit for input from the others. Also keep in mind, that 
> rcar_gen4_pcie_load_firmware() is non-generic interface specific to 
> that one driver, you would have to implement something similar in this 
> driver , with different variable names .
Okay, I'll wait a bit for feedback from others. Thanks!
