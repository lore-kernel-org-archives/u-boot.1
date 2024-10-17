Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F7D37485
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 13:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8921188FF6;
	Thu, 17 Oct 2024 15:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s9TWll13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 904C888C9C; Thu, 17 Oct 2024 15:19:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DC488E81
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so126427166b.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729171162; x=1729775962; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcRuHdATt/+NdiDiBx0Aj3lJ0i1DSFIQZiPNoR/nq9Y=;
 b=s9TWll13oa4WWMdUS+qLaKbhLG+UqskAYqFcKtfwr57JyltEbYzbJX9KJNhLdC4fp9
 92mvhkp7Tk/N8TJ8bBS3J3yyaypcm96k1K0w9jVT4XeZd882YkrYjhRHwslrvFMbCXxz
 2KGZMrgSku33rZFXO8BGso1aSJevX+JE/X5AoWKdt+O0LqcCnbLlqfALaf6+xfmCQJxd
 2R2X8S5cugn97uIAUD0bVXtQfx7/fDJ6IgyQeFUIQv4NA17Vw2PCoV947NX223Bqr/jd
 yW4ymCogxo2W+tBjc66iPf2eMfmfMuVvvWgYbJw7sOjqk6RKwzMwyKxPJ82Dfcwasrnz
 hRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729171162; x=1729775962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcRuHdATt/+NdiDiBx0Aj3lJ0i1DSFIQZiPNoR/nq9Y=;
 b=wqZfK9VNRg8Ok/KuDTolmXc5oAgl2wmUQQN3deBeDE77NE5BLZj4U+plUpWl42Ians
 BvfpRlsLW2lSJp186SjSBk3hgeMRePabhCj0b6TPDQUk9vLKIfWaRhVFfiXgaCCqkEJR
 9S7eT1bu1JRcguk5A5xz9h3hDPlxT4nuXCyNkaADjp92rBvSn3uBuLbq//tre4W4DK4o
 gvT9yb7lQXxlsfGdQQYKyKlOY3Bygf6Bi7d8NeE4sVlorUWtlDyYg9HtucC3n4o3CsYw
 yY2YoTtlyZPUFMoXGd7Hmtd8UGRtdDayAbdFtOdapBl+VsfTiahDpbCfbgESWOE6o/H9
 GvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcvKa2kkTznLMI1Vjz+IXQQW/h22BOwLG8Tm3lrCAymWJkP+e9ieXUPUVEzFavdGTwWobPys=@lists.denx.de
X-Gm-Message-State: AOJu0YzdWc0i7okxSsShA/H1Omb7EiBDE5g3QW9SNQ0kK8WxefM2SBSY
 5a9BuDkTkFPcolA3YlPsX1Lu8Lcv3BCyP3dP74DaZfLLdRQHszD8dQ2G7fwLvSg=
X-Google-Smtp-Source: AGHT+IHNn65ZoaSKpil8bJwIJ5p9swdJGFkMw6MwTnuFmOHKcVE04jx5HkFrq644uD0JIUqW34QNSg==
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id
 a640c23a62f3a-a99e3cdc18bmr1760283566b.39.1729171161722; 
 Thu, 17 Oct 2024 06:19:21 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2989797fsm296946366b.196.2024.10.17.06.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 06:19:21 -0700 (PDT)
Message-ID: <7b0f3d88-f750-4a88-b67a-85412083f2be@linaro.org>
Date: Thu, 17 Oct 2024 15:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] qcom_defconfig: enable capsule update support
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
 <de283020-8286-4910-8b15-d0e86d60ed17@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <de283020-8286-4910-8b15-d0e86d60ed17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/10/2024 08:53, Neil Armstrong wrote:
> On 12/10/2024 15:57, Caleb Connolly wrote:
>> Enable all the necessary options for capsule updates to work, as well as
>> a few additional EFI features.
>>
>> Capsule updates themselves are only enabled for the RB3 Gen 2, since the
>> exact details on where to flash U-Boot (or how to handle multiple boot
>> methods) has not been finalised for other boards.
> 
> -----------------------/\ finalized

Finalised is the correct spelling in British English :P

Is there a rule about this? XD

Thanks for the review!
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   configs/qcm6490_defconfig | 6 ++++++
>>   configs/qcom_defconfig    | 8 +++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
>> index 5ddc5ab3ef8c..ba26924da161 100644
>> --- a/configs/qcm6490_defconfig
>> +++ b/configs/qcm6490_defconfig
>> @@ -18,4 +18,10 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>>   CONFIG_TEXT_BASE=0x9fc00000
>>   CONFIG_REMAKE_ELF=y
>>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>> +
>> +# Enable capsule updates
>> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>> +CONFIG_EFI_CAPSULE_ON_DISK=y
>> +CONFIG_EFI_IGNORE_OSINDICATIONS=y
>> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index e7ed03ff0f24..4c8ff0e84372 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -20,21 +20,24 @@ CONFIG_LOG_MAX_LEVEL=9
>>   CONFIG_LOG_DEFAULT_LEVEL=4
>>   # CONFIG_DISPLAY_CPUINFO is not set
>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>   CONFIG_CMD_BOOTMENU=y
>> +CONFIG_CMD_NVEDIT_EFI=y
>>   CONFIG_CMD_EEPROM=y
>>   CONFIG_SYS_I2C_EEPROM_BUS=2
>>   CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>>   CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>>   # CONFIG_CMD_BIND is not set
>>   CONFIG_CMD_CLK=y
>> +CONFIG_CMD_DFU=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_I2C=y
>>   CONFIG_CMD_MMC=y
>>   CONFIG_CMD_UFS=y
>>   CONFIG_CMD_USB=y
>>   CONFIG_CMD_CAT=y
>>   CONFIG_CMD_BMP=y
>> +CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_REGULATOR=y
>>   CONFIG_CMD_LOG=y
>>   CONFIG_OF_LIVE=y
>>   CONFIG_USE_DEFAULT_ENV_FILE=y
>> @@ -44,15 +47,18 @@ CONFIG_CLK=y
>>   CONFIG_CLK_QCOM_APQ8016=y
>>   CONFIG_CLK_QCOM_APQ8096=y
>>   CONFIG_CLK_QCOM_QCM2290=y
>>   CONFIG_CLK_QCOM_QCS404=y
>> -CONFIG_CLK_QCOM_SC7280=y
>>   CONFIG_CLK_QCOM_SDM845=y
>>   CONFIG_CLK_QCOM_SM6115=y
>>   CONFIG_CLK_QCOM_SM8150=y
>>   CONFIG_CLK_QCOM_SM8250=y
>>   CONFIG_CLK_QCOM_SM8550=y
>>   CONFIG_CLK_QCOM_SM8650=y
>> +CONFIG_CLK_QCOM_SC7280=y
>> +CONFIG_DFU_MMC=y
>> +CONFIG_DFU_SCSI=y
>> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>>   CONFIG_MSM_GPIO=y
>>   CONFIG_QCOM_PMIC_GPIO=y
>>   CONFIG_DM_I2C=y
>>   CONFIG_SYS_I2C_QUP=y
>>
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

-- 
// Caleb (they/them)

