Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62678C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02F314063E;
	Tue, 22 Sep 2026 14:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tf7E4s7nDRIV; Tue, 22 Sep 2026 14:22:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3B1F840647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790086955;
	b=eOURgan3H4CSPvwYOh4nC1tjL1wJ/fq2JoMgJcKWjXp09RYzvGT86zDZAFJEs1kiuhg3
	 oGVZtxvZNjbX1m0AJYsNSHEBhyyieiF5vob0gfTaV0zv2p+QFXgb/d8h7/ztAy4HGAe8c
	 82NoVuOjcSdn0V3hO7UnLjkRy/+vYat/4t3jFwmOnmYVeH041Cx1jaMGJfYElJe7zVzsf
	 4ZTyE3NTLlnlKdcQ5lbVeiVXjHZFDxpLOuZ5bLOiTWfWcfMz5QmDJeuhfjJGw0gfrhDuH
	 0Jlq4g4Fmq8FRtkvi0U6c8wOQEhEQEpjlthd4pYDGvs6d4DuryAIeSEkFjDA2JAHJhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790086955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Aj++vKldO2WZZfl+2p2rvnzB5/Nww/U2EtTdwHoeUn0=;
	b=Pi8fHXKrxnR75WKmpjpHsaD5Z+vX1nhioCr/slbhPfUCjxOX0hBXoge6Uejt3WJWpOD7
	 Y9Lqi4mWvTT+i7wVWUv/oI0QXvjUJw71R54amO59s/ITh9OWPAQ0tg84GH7D18ZyzykGL
	 /Qqw8uOoTGOwCWRmd3MS9Yx77buWIdt7TCiuTJ/TZQad+tQKU05Uog1SO5qPS2rQijkHL
	 il4Yxa9VipzCmNN2yOzIX1gLNLWgKF9NDAH5SccwR2/c8UZHchiST+eiy685a9PZoR0Tf
	 d7ngF0iqh/eajuBJTMDMSH2FUxYUVs3Fw8ajOPpbXtoJRb/cOMRPlns9RrUT2X1BIlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790086955;
	bh=Aj++vKldO2WZZfl+2p2rvnzB5/Nww/U2EtTdwHoeUn0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dn5FZYjI1/+UnxB82mrdZd2+YPvLGL9e4ilRSjqWx4qpfKnH2Jw8yzhVQOfcRQrU8
	 k8ML66WLs7GG4kl3aB9dbywXSr9YMSTHul9NlyyU5gSqtRgtZnRkaS15Jl9YaLNpfe
	 lS0n5sqAFt4OJgQPxzWt8bWsSSY4ysn2gL2MApAoJzZSGkoVXFVSClvuviFKL9nI9n
	 n3/IY5bWM/deO5qa6ZX39oDAcz6OW9985vVlrdKaqtgE67JTujL0P2YKpW+0Q5BoGE
	 mvuV4kjYOVey10sEwH6PkNdjUFzcAGMzstrGR5PT3DzCxTHoJqFqyISA7mksgEmRvE
	 /NT7MpK9w+bgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B1F840647;
	Tue, 22 Sep 2026 14:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDCAC3A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF4DD80BC0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Kq1UTKfehwm for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9352C80A84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790086953;
 b=UdJZ+yMof/8p1pU4MAvTRiIZAJt02TxToklE1tSiD1Y6E7xKaGcGC1AS9yMBzJt7Q9Ot
 gjFKkAjKq3G7TU6OMUB9oFQAOzJdl78JwNobRGyfTzJvu+KmdyVn5NWtpC9ajMu75iB6M
 vNogt3TLP0QLg844SVatQcLnpQQPuMgyC0R4qms/0E0Aq+m5IbEiMQUbyJW1b4xGWsnaw
 kF1njT8FL08b4Ntjo2VO1JtNhN8Tq5WY8DvA4qBaCwRk3RNh7A7DP//J6V5COVssLb4NK
 Bbn3qrqE708UNzAEZDb2oKAXY16JmlEOTCqmYiCdDCnVTRwfuoXfta3yfwitVvE5jTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=Aj++vKldO2WZZfl+2p2rvnzB5/Nww/U2EtTdwHoeUn0=;
 b=Ph1ftooS8zHFjHu739PWx+RYnAxnFTik9n+5vIr/VB8bSRM7Q34Umb5c7LSlkq5LOQ13
 WSun2/85Cplypk1R9r7lzNGqzx+CUiVKpBAmo9WhF5YZVBUAsxy0LQAB3hM4mdrFC2nmP
 9VkGq26WNOO2go4pLcH1Zx50JBDa4zXVVrV1KC0oko+WoPtTuz9e1WvB8XAeeD0BZpAbv
 gmyaWscxpiztdn7dUjw+jdeSoSTKjz55By736DMHeJid+xCwrdjVS0DwjIyQPS0QqL10V
 Z1BV7mnqvtKJlKVzV8vG13qgccKOQxWN+eBwZloTHUeg/m/MRsJKwWFVzzvgd/XteSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U21EjwOT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U21EjwOT
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9352C80A84
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:22:31 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so676543e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790086950; x=1790691750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Aj++vKldO2WZZfl+2p2rvnzB5/Nww/U2EtTdwHoeUn0=;
 b=U21EjwOTqAdm3tKjqORjkrwaqYqpNuicYs//MEy7uZV2WS8hCAi8IABqw/8urY6GNH
 L0FthuK2vBvP/Vx76R5LBnc22YhlwIRfSdV9R5MMK6UJo1OoUs3eNowr+4kwL4irTyxV
 a7tlMykGf+cXCBhtJNUlbfPe1BqX5ki/LjM0Ze3lapJs/OpWBqP+wsxBkiYe51UP9sP8
 J84Jz4Sji08Cot92ZuZ7cU+fXYLYbmHVYNvGSaGoDN737gYwGWmslRNpfjrpxsiahFYy
 JojSPJI8srx/8RxfPErGpik0tTMBCNv935RGW94d2gd+kjop+TjERaEHz6MuVFkPC2I9
 CDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790086950; x=1790691750;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aj++vKldO2WZZfl+2p2rvnzB5/Nww/U2EtTdwHoeUn0=;
 b=auL2NoyNVR16/FWeAEl5xNOtVSibCcv365GR0h8q9RYgrcW0DL93Sf7aYagsVnHN8S
 doKRKOCi/l2RJ9js0sC4zD+AFGx9+tEUXFNv+S8AtLKNVZySNAKJ0aWXxtoGCy0BT6nF
 sPiUqnMqgc00rLgVo6mvyHwciR6MDSvDUbgGF2TneXwQxf5JRba6L9s63BtlylOYGO89
 beYxUOtqbL/T29K7JnU6xDuvd1a511x06iIWteYo2MjV1wTYJm/A6C7rWabUNvFUuRQa
 rNm8X12Ec7xAaELiNuPu/uh8I7DeFiz2bz856djObmesCYsTNV3fE3v9UWPYJMWrsAC2
 OtYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWWuLoHmvDxn6JDXjNaUiAUogQ8a3IwozBUVDUUp567CYrKZXkoD9KQDT3vgxlT6OfIsyGeyc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kZxHgb3v2FPVsq46K2hjpSLO9lqsraeI1Z1L9y7CsQy34MS+x9
 VqCI9iSS1apulWXRNewMLCjtcq/rInYYFpHYQ/KTdEwaVGQB8CIY2H6dbFvaamVfkiU=
X-Gm-Gg: AYBFou1ujiUFicsc4FsRZkj34wp6TCcLf0jKoa6HxB7zBB68azU50wEG8UP7Q5m4/8u
 pEuWM1QeSVHcqcrD0KIiuDLgKPTumMuFxx9A+mXZQWE5fP3EZxsuR2FAx7MwrHzuVnQ1hRdL+57
 qoDUujz3tCKm+Zi1NSVZXxwAZ0Mn1axPY3CMobaw6S7rsD2EN+rOP7I0Ys1VtmMmjpjamLhZ8hZ
 ZHTXoOFt/heKqNTBSOlg27gTa/3HQ1hn5ml1sU8CfL0i0BnJqX8TZPSejfCr5nnxxQi4dlnr2BT
 RcMBKImi9ILbKV/dQqIOgPkLWir26aOEZc0HxaabweDsYWsWRqvTHvEcA3BtbM5H3pC0rNK+2AY
 On22P9ZYMABvLxSPPlLpxUZqgEutbGw53+3fgNSRewL9DJ/sxfxeDB3NLH8K398zw6lt3IvWdSc
 BC740XoJ4serqrl8v0Idh1zztB/NuYOsbuzdYu6/YjX/AX47o3CKnYJOkQfslJJMdX4+cS6Bja6
 LkhABZa/w9g/DDFAfQ0weVmTZWNxM/NVJ3GGw==
X-Received: by 2002:a05:6512:4059:b0:5b3:f8b:b714 with SMTP id
 2adb3069b0e04-5b8d29354c5mr863335e87.21.1790086948260; 
 Tue, 22 Sep 2026 07:22:28 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ec5a.dip0.t-ipconnect.de. [91.41.236.90])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46ed943sm560964e87.80.2026.09.22.07.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 07:22:26 -0700 (PDT)
Message-ID: <d07524fc-cfc0-4092-a297-dcb70a5372ec@linaro.org>
Date: Tue, 22 Sep 2026 16:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: qcom_geni: gate late firmware loading behind
 Kconfig option
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, sumit.garg@kernel.org,
 trini@konsulko.com, nathbappai@gmail.com, quentin.schulz@cherry.de,
 jbx6244@gmail.com, anshuld@ti.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20260918094950.1186434-1-aswin.murugan@oss.qualcomm.com>
 <23e7a956-3e5a-4234-bc9d-299371cab798@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <23e7a956-3e5a-4234-bc9d-299371cab798@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 18/09/2026 14:16, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 9/18/26 11:49, Aswin Murugan wrote:
>> GENI QUP firmware loading is normally expected to be completed by a
>> previous boot stage and is not required in production U-Boot builds.
>> Add CONFIG_QCOM_GENI_FW_LOAD to make the late firmware loading path
>> optional and disable it by default.
>>
>> The option can be enabled for engineering and bring-up builds where
>> loading GENI firmware from U-Boot is required.
> 
> This feature is enabled by default on Linux, why would it be disabled
> by default on U-Boot ?

not only that it's required for a variety of upstream and production
usecases already.

I assume this change is motivated to improve speed, the patch should
really describe the motivation here since it's not a bug fix. A fast
path could totally be done here but it would have to be a bit smarter I
think.

Thanks,>
> Neil
> 
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   configs/qcom_defconfig   | 1 +
>>   drivers/misc/Kconfig     | 9 +++++++++
>>   drivers/misc/qcom_geni.c | 2 ++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index c52f619850d..9498583b97c 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -99,6 +99,7 @@ CONFIG_QCOM_HYP_SMMU=y
>>   CONFIG_MISC=y
>>   CONFIG_NVMEM=y
>>   CONFIG_QCOM_GENI=y
>> +# CONFIG_QCOM_GENI_FW_LOAD is not set
>>   CONFIG_I2C_EEPROM=y
>>   CONFIG_MMC_SDHCI=y
>>   CONFIG_MMC_SDHCI_ADMA=y
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 44415f24ae1..8320fbe28e0 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -93,6 +93,15 @@ config QCOM_GENI
>>         for providing a common interface for various peripherals like
>> UART, I2C, SPI,
>>         etc.
>>   +config QCOM_GENI_FW_LOAD
>> +    bool "Load Qualcomm GENI peripheral firmware at late init"
>> +    depends on QCOM_GENI
>> +    default y
>> +    help
>> +      Load firmware for GENI peripherals from the firmware partition
>> +      at late init. Disable if no GENI peripheral needs firmware
>> +      loading.
>> +
>>   config ROCKCHIP_EFUSE
>>       bool "Rockchip e-fuse support"
>>       depends on MISC
>> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
>> index a62ae6a2478..b5c2a511ae7 100644
>> --- a/drivers/misc/qcom_geni.c
>> +++ b/drivers/misc/qcom_geni.c
>> @@ -563,7 +563,9 @@ static int qcom_geni_fw_initialise(void)
>>       return 0;
>>   }
>>   +#if IS_ENABLED(CONFIG_QCOM_GENI_FW_LOAD)
>>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
>> +#endif
>>     static const struct udevice_id geni_ids[] = {
>>       { .compatible = "qcom,geni-se-qup" },
> 

-- 
// Casey (she/her)

