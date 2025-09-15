Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C7CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 18:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664738344E;
	Mon, 15 Sep 2025 20:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5MqICsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0995830CA; Mon, 15 Sep 2025 16:36:07 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F33380B9B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 16:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77619f3f41aso2217909b3a.2
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757946964; x=1758551764; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2AHWVKz8fFtq+qlhjLcEFVbgUNnAKRbsog5SIDVmsY=;
 b=H5MqICsMLSeOox8UYQUA+DUtllIHnSnqCHomyoebJ2qoXKL1OqsFwpJiKO/qtQz9PM
 wQQ974+RTWfGsx8n4okkBtJFUZOiDNMiJVgoG5oM1UmUBgbuHStiWXXEPf+2HCHgV3rv
 cgKOVZZ5v3E02WtoVrNiyB0Dxp36lq33lbDawOPBMdssFgcWUuPA7nKw0BIlBoQooofr
 4xdjlXqiHhP/VNHbrobemn4Zd3/V67ceA+zduPPZK0IK318GJ/Fzg4pDzPINkxWLGlF4
 75HtDs4VBTrlnyWCkNrzMjvjjNUd2QFiFsWuRzWoirIm2MRVDmvqUbfMehikBT5opt98
 snFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757946964; x=1758551764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2AHWVKz8fFtq+qlhjLcEFVbgUNnAKRbsog5SIDVmsY=;
 b=QL+pcalD4aib/GffU5XpA4ecNe1YjEIXxR20QHEn4j8Yx+6g/tL8PM6O+Mfj2/zeTX
 4GFFGE10tlzKt1R6GHCIRrkJEh+L79xt1vV07z7SJvwviYZDxUd0m25ffLRWHj8990BM
 O8LHYY24kKG2cEfUKn1rUuI4+Aityu9OxnQQpjeOWtuoZvf0f/5WGf5DONnzNbbnG0DS
 mqfDLxNQSAPxI3nJP4/hsMqa47M4Q5gnnG7sq6xxyJNEugGm/pgpH7MU7t4PG3Apcjgg
 wC7YSJ3Ja4Tbb5MD4r4wdPovhJ7SgidnVh3RQQUDcNl5+XHFyBR9uF2W1qErwpB5RP2O
 c9MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXIUBtuQaALaS2DNKOqSLnmciUUwqc0aq/3cCBBeUCg+d6wbxPJwRTDhXGvEtAfAKJZWR4ckk=@lists.denx.de
X-Gm-Message-State: AOJu0YyRzSFmD7etwOM05MwgjWilkyq6dQQqLGQuzLeVMVNQuZXyxwVr
 2R3JLw5HC47nYyCYq9TzwG9g7+90M1UBoKL2gq025PPAMyDt7817iG6M
X-Gm-Gg: ASbGnctjhbammHI+/WQ56WkKSsmPLE5I7N1h9avyam3iBjF3jzXxbxPCHErtErlAXZ5
 XbwLqu20r58WUbLpkGZ7FJSzbBel07Vhf5TwwSbxZnKvNonT2hqaM4JFTq+sf/yVapaRzGDW9jy
 ymG7j6SSrIkMTxXKAyItlnKRKqdZvkfEF2P5KgHRC4E6dvQ9anQdg5034cnDSCuTRZ32jH5e09R
 4nP2ldunNEw3Aw58+meGbXhH+zN80yU30hxUb40X277m0bU4Iv1x4jkAn3l9TDiManco7Y58NdY
 STJuxHeMEV30Xlm4TK/B0uh1LWI2dt+Unn6U82SakP+U9o/xE4RDUSGCu439af/3n+CAEXAJJem
 4Z1WhbCLIOKLGHjlOXxDUQyQM45L80roidYIZGMkEGdj5ekA2i0OmPjnFSoDnX0qdQes1H3nj52
 DCWbOgMILQky4fs3y+/A==
X-Google-Smtp-Source: AGHT+IFdKITA09i1tD7golgTOJ8cBf1XkdJsm9fJffQUP4iV4V0ymE5XDsWViDT0/jd4qtat33luFg==
X-Received: by 2002:a05:6a20:734d:b0:250:997d:409d with SMTP id
 adf61e73a8af0-2602cf1126dmr16988311637.60.1757946963346; 
 Mon, 15 Sep 2025 07:36:03 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607b17c78sm13635042b3a.50.2025.09.15.07.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 07:36:02 -0700 (PDT)
Message-ID: <0924393d-c87b-4a6a-8590-3ab49d039dfa@gmail.com>
Date: Mon, 15 Sep 2025 22:35:56 +0800
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
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <464e0429-ac06-49fc-831d-b9e86946446d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Sep 2025 20:52:46 +0200
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

Hi Marek

Thank you for reviewing my patch.

Marek Vasut 於 2025/9/15 上午 01:49 寫道:
> On 9/14/25 6:41 AM, Lucien.Jheng wrote:
>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
>> 100/1000/2500 Mbps with auto negotiation only.
>>
>> The driver uses two firmware files, for which updated versions are 
>> added to
>> linux-firmware already.
>>
>> Locating the AIROHA FW within the filesystem at the designated partition
>> and path will trigger its automatic loading and writing to the PHY 
>> via MDIO.
>> If need board specific loading override,
>> please override the en8811h_read_fw function on board or architecture 
>> level.
>>
>> Linux upstream AIROHA EN8811H driver commit:
>> 71e79430117d56c409c5ea485a263bc0d8083390
>>
>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>> I have modified the relevant process to align with the U-Boot boot 
>> sequence.
>> and have validated this on Banana Pi BPI-R3 Mini.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>> ---
>> Change in PATCH v4:
>> air_en8811.c:
>>   * Create the airoha folder
>
> directory
>
>> to store all future airoha phy drivers.
>>   * Use `request_firmware_into_buf_via_script` for firmware loading.
>
>
> [...]
>
>> +++ b/drivers/net/phy/airoha/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig PHY_AIROHA
>> +    bool "Airoha Ethernet PHYs support"
>> +
>> +config PHY_AIROHA_EN8811
>> +    bool "Airoha Ethernet EN8811H support"
>> +    depends on PHY_AIROHA
>> +        select FS_LOADER
>
> It seems tabs/spaces are mixed here, please fix.
>
>> +    help
>> +      AIROHA EN8811H supported.
>
> [...]
>
>> +#define EN8811H_MD32_DM_SIZE    0x4000
>> +#define EN8811H_MD32_DSP_SIZE    0x20000
>> +
>> + #define EN8811H_FW_CTRL_1        0x0f0018
>> + #define EN8811H_FW_CTRL_1_START    0x0
>> + #define EN8811H_FW_CTRL_1_FINISH    0x1
>> + #define EN8811H_FW_CTRL_2        0x800000
>> + #define EN8811H_FW_CTRL_2_LOADING    BIT(11)
>
> Same here, avoid leading space.
>
> [...]
>
>> +__weak int en8811h_read_fw(void **addr)
>
> Does this still have to be a __weak function, now that it uses generic 
> fw loader ?
>
>> +{
>> +    void *buffer;
>> +    int ret;
>> +
>> +    if (!IS_ENABLED(CONFIG_FS_LOADER))
>> +        return -EOPNOTSUPP;
>> +
>> +    buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
>> +    if (!buffer) {
>> +        printf("Failed to allocate memory for firmware\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    ret = request_firmware_into_buf_via_script(&buffer,
>
> I think 'buffer' without the & should be used here.

Regarding buffer,

I've reviewed the function definition for 
request_firmware_into_buf_via_script.
The first parameter is void **buf, which is a pointer to a pointer.

I think passing &buffer is the correct way to call this function.

If we were to pass just buffer (a void *), the function would receive a 
copy of the pointer's value, and any memory allocation inside the 
function would not be reflected in our original buffer variable.

Please let me know if my understanding is incorrect, as I want to ensure 
I'm using the function as intended.

>
>> + EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE,
>> +                           "en8811h_load_firmware");
> [...]


