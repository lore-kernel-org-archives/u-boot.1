Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9E8D37E3D
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8ECD8063E;
	Wed, 14 Jan 2026 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="foSa0mby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EA7808AF; Wed, 14 Jan 2026 15:56:07 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD1C80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so55810115e9.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768402564; x=1769007364; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jTWV1cgTdNVRIeVGTtsUh6meTEr2PYs6eCBtLwcjnM=;
 b=foSa0mbyjgcBp40FD9NbYexqqkcT9SkP6ZixCX7D+Upd+99WqU8VkBGiDJ/0lFawGF
 ZnoRK6yczpsxxRXVc7gUpFqKvK+Nvzh2W6SZ+zFOK5N383NSmCBHsqi6TZ2VWDlux8a5
 1MbJohSW2rCg0Lze/ZwHOZ1eFGNg0LxJaoWfP4OX9OFSie0Xt9Yn5PHHNuPq9Waw0XkB
 FAShR/Ygv4nJg3troahB7v0uoz2ms/XjFwOC5a2K/7u9g9b+bpIRnT64gwAQjYP2a++J
 M3W7EhJQW+5MKTclUhczcGoYdOhEZ/WEX3+tPeJbk6VD7I4le1MDDi2tiLjxB4czJhoT
 ho8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768402564; x=1769007364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/jTWV1cgTdNVRIeVGTtsUh6meTEr2PYs6eCBtLwcjnM=;
 b=WI0RPiQVczfG4h3zFb9Un/9Qwf8iyD4EovFtc6Ly9pDsMlUyEqaPZ51j3iLPfYtMXZ
 V3DOCguU5Wiw7rl1m84YIYOA7mUEwSqhWDwglj8BcpOAzOsOIsdVY02knCeYTYdeWGQy
 0NSXyzlMo5EbPrMEP8/lHkohKDh+OIL1AOcPrgkwo3uq4C/CBQi+AGRP1n1bAcAanSjW
 XKzcLzlKtH72GJvr8XZRAR0Hf9z21bv+EXjbRWK8xsjapYRDrDC1KZsD1jJ+um5juokr
 Xe0VxoWHicON8eWdx/DW6cpuoRa2SSWHtOVlvJRupQkTY0Uy1zersO9j6cOnMjT2ijmN
 IyTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUdCWJxMpGia7m/lw/QJXa7dbz3oQ7LVy9aypjL6jg3jPOwx9deNztCZQnyHTLEm4SDTFsiiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxKADT/PqKi1xMRDsVtkTJTgxigE+5rkQdqih01Mb43IlwCkCTK
 pO0KmL8QdbnKvz3VxKH7uL6WAd2Lta0E8IX9XU1u5353hsVhJATCFh6Doe1mtzA01Mg=
X-Gm-Gg: AY/fxX7yAD9d++3Dpl0S7fjfK8DRE2VhOQDaDhRFwT8b9nDMtwnaqkJ4txEMZzgewC5
 pMWtnZEe0cvWkKGuhiGUf539xc182BTWSLvfoY4GYRsv8Qlp9OFBluoUCBoQyW28bECVjrPw/Dh
 UeEMfmxWUt42IU0H+iItBNDEITSLPjU6QZTQS3BoRMBsfu84rPUlZ0O3sxb4UCSaI+7u8mzs2ba
 fvqx5Y2E34WJEnxVdZ30+Dh5eMK1hVeJWXtOtXj1O6Tp0eSuqnOViYN9BTRAcgopC0PPEctMeS/
 VU+bnF44fmYJ0AwBtGjW413N98YE+bilOdGunLhngloe92DSn9OQv8eHJadr5IKkAvwFYq4DJH+
 zIJAEGpQu7pQiyvqd5Xw9rACBKAHaDyWwMQ1IjbMjVl0OdRwIFtTO6ZDK1SV0Lv8YitoYKqCIyc
 U3Yme4WR9DxN4Bxi2kLoeje0RbomIvMCWbfgYKM4ZyT7xD5eG4rSw=
X-Received: by 2002:a05:600c:6090:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47ee33757f4mr38385735e9.26.1768402564454; 
 Wed, 14 Jan 2026 06:56:04 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee57a2613sm31156355e9.6.2026.01.14.06.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:56:03 -0800 (PST)
Message-ID: <c4cccc8f-639e-4806-992a-2e7c950c2c7b@linaro.org>
Date: Wed, 14 Jan 2026 15:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 neil.armstrong@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <20251229114312.668068-2-sumit.garg@kernel.org>
 <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
 <aWDgNIR4jcNcUZ6W@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aWDgNIR4jcNcUZ6W@sumit-xelite>
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



On 09/01/2026 12:02, Sumit Garg wrote:
> On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
>>
>>
>> On 29/12/2025 12:43, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
>>> platforms. RB3Gen2 being the first one and more to come. U-Boot in
>>> corresponding boot flow is packaged as a position independent executable.
>>>
>>> So, lets add a generic U-Boot defconfig for Qcom platforms to support
>>> TF-A/OP-TEE based TrustZone stack. Build command:
>>>
>>> $ make qcom_tfa_optee_defconfig
>>> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
>>
>> This would be better suited as a config fragment rather than a new
>> defconfig imo.
> 
> That's fine with me to add it as a config fragment.
> 
>>
>> But more importantly, enabling OPTEE support in U-Boot doesn't imply
>> that it will be used, just that it's supported.
> 
> There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
> secure EFI variables based on OP-TEE secure storage. Have a look here [1].
> 
> And sure there will be more such use-cases like fTPM, KASLR etc. can be
> supported based on OP-TEE.

I was referring literally to the fact that CONFIG_OPTEE being enabled
doesn't imply that OP-TEE is running, it's faulty logic to assume that's
the case and add nodes to the DT.

I just checked and there is an SMC call that tells you the UUID for the
trusted OS, referred to as OPTEE_SMC_CALL_GET_OS_UUID in U-Boot and
OPTEE_ABI_CALL_GET_OS_UUID in OP-TEE. Presumably this identifies OP-TEE
specifically.

My suggestion would be to make this SMC call if CONFIG_OPTEE is enabled
in qcom_psci_fixup(), compare the UUID and add the node if it matches.

> 
> [1] lib/efi_loader/efi_variable_tee.c
> 
>>
>> So I think the more appropriate patch here would be to just enable
>> OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
>> affected).
> 
> The OP-TEE driver in U-Boot itself is probed based on DT and it's not
> only specific to Qcom platforms but every other platform using OP-TEE.
> 
>>
>> Considering the other patch is based on this assumption that if OP-TEE
>> support is enabled then the board must be using it, a different approach
>> is definitely needed.
> 
> Yeah that's true even with TF-A boot flow, there is possibility to boot
> without OP-TEE as well. However, TF-A generally doesn't provide a
> generic option to detect whether OP-TEE is running or not.
> 
>>
>> When I was looking into this last year I remember discussing this same
>> issue from the Linux side, there is a good argument to be made that
>> OP-TEE support in Linux shouldn't be based on the devicetree -
>> particularly in the Qualcomm case where whether or not OP-TEE is used is
>> a simple software change, nothing to do with hardware.
> 
> Sadly it's true for every other silicon vendor too. But OP-TEE support
> based on DT has become an ABI unless migration for OP-TEE support based
> on FF-A comes into picture.
> 
>>
>> So in general I'm not particularly keen on this approach, I think it
>> /might/ be acceptable for U-Boot to have some fixup code to add the
>> OP-TEE node if OP-TEE is in use with the idea of phasing that out in
>> favour of runtime detection in the OS itself. I'd also expect that fixup
>> code to go in the generic U-Boot DT fixup code that runs before we jump
>> to the OS (like the EFI DT fixup function).
> 
> The EFI DT fixup code is already there based on U-Boot DT. Have a look
> here:
> 
> boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);
> 
> In general on Arm platforms there isn't any SMC bus to detect
> dynamically if there is support for OP-TEE or not. That's why
> platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
> similar to how we have the SCM DT node for Qcom platforms.
> 
> FF-A bus tries to solve that problem to unify that approach for future
> platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
> driver too.
> 
> Anyhow, this is the sanest way I can come up with to enable OP-TEE
> support in a general way for all the Qcom platforms. This is aligned
> with how OP-TEE support is detected for other silicon vendors too.
> 
> -Sumit
> 
>>
>> Kind regards,
>>
>>>
>>> For more information refer here:
>>> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>  configs/qcom_tfa_optee_defconfig | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>  create mode 100644 configs/qcom_tfa_optee_defconfig
>>>
>>> diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
>>> new file mode 100644
>>> index 00000000000..c398521770f
>>> --- /dev/null
>>> +++ b/configs/qcom_tfa_optee_defconfig
>>> @@ -0,0 +1,7 @@
>>> +# Configuration for building a generic U-Boot image
>>> +# with support for TF-A/OP-TEE based Arm TrustZone stack.
>>> +
>>> +#include "qcom_defconfig"
>>> +
>>> +CONFIG_TEE=y
>>> +CONFIG_OPTEE=y
>>
>> -- 
>> // Casey (she/her)
>>

-- 
// Casey (she/her)

