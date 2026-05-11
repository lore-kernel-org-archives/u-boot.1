Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72955CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010E98394E;
	Mon, 11 May 2026 15:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ww6MtBZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC7483C51; Mon, 11 May 2026 15:45:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A73838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67929ff6dbfso6619487a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507109; x=1779111909; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrIaNFwI+Gyhig/6OhEawPiQ9kfXf2H0mtRjnj1RAWA=;
 b=ww6MtBZePCyXVLYW/Z6aQ324WuE1wCUEz8pSHSio+lkCkBd8JBhLgtNvqNTmxGvlnu
 D9fg+NVlbYVsjah8RBXL+61TfBOxIkCc5ow6kkB6GljF8tDv73aEhW1nr6oPApHe2MJm
 yC1cBEHzIQ5RSLe5Fdld21gz+Nm2rtrYsFrnb9jPau7MGedHKEJV4xnuAvQumWxvSdMF
 NseOG5akLNWqvEjtpVZ9sglHmEdaaV+VfbupfzNTOaOiCLH86lMg6rcl1oZNdm+avbrL
 1jMPwrNQXapSJXP4xykfCsow7z9+yMlfVq6WW1L1NBT+QK6G52DyHVOzdQurCqnEdpHG
 9Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507109; x=1779111909;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrIaNFwI+Gyhig/6OhEawPiQ9kfXf2H0mtRjnj1RAWA=;
 b=MiKYiMqWdo8A/SYW7GgHHf5SODfko62RoBdskxNXjpTaxDHdBtAAgyIVjCKHhBf4Jz
 FuYRx0HVzZPWJd1hmhNsKFqB39zXVcRmY7Onuw2qnxtf5d0LSMaqP+abFVDPI7vBaD7h
 0LOVOU/2YlSmFsR+vB+dz9CqTm+aSlasTTbR7ETCU1VqxrH2/331fIbc2M8GG6FkiMls
 +UW2o6QAD6hIOOZ5StHROC7kwcPUe6GUM4UgMgLrbXzHvVEfl0qYgz2hLZGltYfY0smj
 DwtrallKSX/oW1lwXgo3JWOd2M3EamD7QpDDnnOwlN7LZCuwigLdQbkqBCnoQIMQZevP
 U1ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BX09I3z4IsQDCngA0fQlXjtUdpdFma1rigG6UJuJsaJlNPAxVmtCeANEIllKVIuO0PmPPy4M=@lists.denx.de
X-Gm-Message-State: AOJu0YwHuLMtUGlk70zC+Fw/WrHBc4H10BhhxX6A9alKp4PCWFU/55P6
 64Y1dxtmnZwJNSfRkhpiIGqyHqqHMbClBKgvB+nkSOt2brVre9UX9BK3YRu1y9hJziY=
X-Gm-Gg: Acq92OHJZEo1g5duDJTXYF7lIaJYLe+Wx74nN99yn9J9UoztKT6YpLH+dURZD9bFRJN
 xvviqfqsY+jriX0644fboSe00LDBMOok2RYTZ16/uc6Pc4y97cduIEWjvCF/GLBvs1d38uYmIsf
 YFBkYiRqcJbwHYBZkW9OICRUKljmew524V81dyf24PsJJxk0H7m4xQap4ujT8UhioyUSz7+cgPm
 O4c3ai6zG1ZhuP4yY3sZBz7Goo1qQ2YpJuOww8jZ1ObQMn/KsYo2c7yklnIiqLcIkAcnAiLS7rx
 YgZNq5szLO35+16SQm2Ain/crFKpveVTu+c8i45ZNzkcGbSL+/HNDmuA7IQ3mQ+WyaY7NrOFoUN
 A9F8xwJrhY+aIl7CM+mzZu/oZdpKfSSm+ONvP3SJN7xdd4StE5qJlXXUq4t20ARnET1KixwcnOT
 b/vb46/bEgPEnuA/DimC/yZ/iXa019gwSQCj4bvnVTKf6G3SklPUI9t7LzpZzpjZt+2y5UxQ6aZ
 6WK
X-Received: by 2002:a50:ee0f:0:b0:677:75e5:a1b3 with SMTP id
 4fb4d7f45d1cf-67d643c0fa0mr8833633a12.18.1778507108402; 
 Mon, 11 May 2026 06:45:08 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b6a534sm3918915a12.9.2026.05.11.06.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 06:45:06 -0700 (PDT)
Message-ID: <ea04b9f6-7df3-456b-b830-0b8f1b98fa38@linaro.org>
Date: Mon, 11 May 2026 15:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] mach-snapdragon: Kconfig: changes / additions to
 support SPL
Content-Language: en-US
To: Michael Srba <Michael.Srba@seznam.cz>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-7-7d0e22aaaa8f@seznam.cz>
 <fc28d41d-957e-41b2-95ec-85b328dd611e@linaro.org>
 <4deeaed1-5744-42c1-a4d3-bdeaa13d012c@seznam.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <4deeaed1-5744-42c1-a4d3-bdeaa13d012c@seznam.cz>
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



On 11/05/2026 15:28, Michael Srba wrote:
> Hi,
> 
> On 5/11/26 15:05, Casey Connolly wrote:
>> Hi Michael,
>>
>> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>
>>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI
>>> in SPL.
>>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else
>>> will.)
>> I'm not sure if this was mentioned in a previous revision, but would it
>> be possible to introduce a SNAPDRAGON_SPL kconfig (mayyybe in the
>> mach-snapdragon kconfig?) to contain all the "if SPL" options and just
>> simplify the list here? It just feels wrong to have half the options in
>> the list be gated like this.
> That is more or less what I did originally, but it was strongly opposed.

Oh I see, it seems like that feedback didn't take into account that we
will end up with differing usecases for SPL. I'll check with Tom.

>>
>> It seems quite likely that we will end up with a few different SPL
>> variants for snapdragon:
>>
>> 1. Your implementation for older SoCs doing many things from scratch
>> 2. Qualcomms version for IoT more tightly integrated with TF-A
> Well, that should mostly boil down to whether u-boot provides PSCI
> or loads tf-a? Once someone REs all the stuff that qcom gets away with
> hiding in blobs.

Right, I don't really have my head around all the details so it's
possible we can keep things much more closely aligned, I'm just
imagining that with SPL things will be less flexible and much more
oriented for specific usecases, hence my kconfig suggestion above.

At least initially my gut feeling would be to have separate files
handling the SPL flow for your usecase and Qualcomms IoT usecase, both
for readability and to minimise the risk of changes to one breaking the
other. It will also make it easier to get them both upstream since
you're both working on this at the same time, eventually one will need
to apply on top of the other and I'd like to make that process as
seamless as possible.

>> 3. Another version I've seen where SPL is just used to chainload a full
>> U-Boot and provide an extra level of redundancy
>>
>> These will all have slightly different requirements and code paths so
>> being able to express this via kconfig seems like a good way to try and
>> keep things manageable.
>>
>>> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to
>>> fix up
>>> upstream dt to make usb work.
>>>
>>> Mirror u-boot proper selections like GPIO and pinctrl to ensure
>>> consistent
>>> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
>>> reasons.
>>>
>>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>   arch/arm/Kconfig                 | 33 +++++++++++++++++++++++++++++
>>> +++-
>>>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>>>   2 files changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index f624675eadf..8e818071df6 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
>>>       bool "Qualcomm Snapdragon SoCs"
>>>       select ARM64
>>>       select DM
>>> +    select DM_EVENT if USB_DWC3_GENERIC
>>>       select DM_GPIO
>>>       select DM_SERIAL
>>>       select DM_RESET
>>> @@ -1149,9 +1150,39 @@ config ARCH_SNAPDRAGON
>>>       select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>>>       select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>>       select SYSRESET
>>> -    select SYSRESET_PSCI
>>> +    select SYSRESET_PSCI if !SPL
>>>       select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>>       select MMU_PGPROT
>>> +    select SUPPORT_SPL
>>> +
>>> +    select OF_LIVE if USB_DWC3_GENERIC
>>> +    select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
>>> +    select ARMV8_SPL_EXCEPTION_VECTORS if SPL
>>> +    select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
>>> +    select SPL_DM if SPL
>>> +    select SPL_DM_GPIO if SPL
>>> +    select SPL_DM_PMIC if SPL
>>> +    select SPL_DM_USB_GADGET if SPL
>>> +    select SPL_ENV_SUPPORT if SPL
>>> +    select SPL_EVENT if SPL_USB_DWC3_GENERIC
>>> +    select SPL_GPIO if SPL
>>> +    select SPL_HAS_BSS_LINKER_SECTION if SPL
>>> +    select SPL_LIBCOMMON_SUPPORT if SPL
>>> +    select SPL_LIBDISK_SUPPORT if SPL
>>> +    select SPL_LIBGENERIC_SUPPORT if SPL
>>> +    select SPL_OF_CONTROL if SPL
>>> +    select SPL_PINCONF if SPL
>>> +    select SPL_PINCTRL if SPL
>>> +    select SPL_PINCTRL_FULL if SPL
>>> +    select SPL_PINCTRL_GENERIC if SPL
>>> +    select SPL_PINCONF_RECURSIVE if SPL
>>> +    select SPL_PINMUX if SPL
>>> +    select SPL_SPMI if SPL
>>> +    select SPL_SPMI_MSM if SPL
>>> +    select SPL_SPRINTF if SPL
>>> +    select SPL_STRTO if SPL
>>> +    select SPL_USB_GADGET if SPL
>>> +    imply SPL_MMC if SPL
>>>       imply OF_UPSTREAM
>>>       imply CMD_DM
>>>       imply DM_USB_GADGET
>>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-
>>> snapdragon/Kconfig
>>> index c195d478512..a2228e217af 100644
>>> --- a/arch/arm/mach-snapdragon/Kconfig
>>> +++ b/arch/arm/mach-snapdragon/Kconfig
>>> @@ -14,6 +14,9 @@ config SYS_VENDOR
>>>   config SYS_MALLOC_F_LEN
>>>       default 0x2000
>>>   +config SPL_SYS_MALLOC_F
>>> +    default y
>>> +
>>>   config SPL_SYS_MALLOC_F_LEN
>>>       default 0x2000
>>>   @@ -39,6 +42,13 @@ config SYS_CONFIG_NAME
>>>         Based on this option include/configs/
>>> <CONFIG_SYS_CONFIG_NAME>.h header
>>>         will be used for board configuration.
>>>   +config SPL_SHARES_INIT_SP_ADDR
>>> +    # override the default from common/spl/Kconfig
>>> +    default n
>>> +
>>> +config SPL_HAVE_INIT_STACK
>>> +    default y
>>> +
>>>   choice
>>>       prompt "Qualcomm boot0.h workaround"
>>>       optional
>>>
> 

-- 
// Casey (she/her)

