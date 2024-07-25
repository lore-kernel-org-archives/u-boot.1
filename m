Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B27C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084BE879AF;
	Thu, 25 Jul 2024 18:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QFHSomUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A7287C7E; Thu, 25 Jul 2024 18:10:56 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD35587876
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7044c085338so15403a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721923852; x=1722528652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gcb2avpyO6xYqPZM1PBxXk4HYqEwjSAIHC8v3bxIc14=;
 b=QFHSomUciIqrDwPsOLHLA4QJxRjJdtS4e/RzhkOFEMuG5c85Txeu4xOdoxzBbIUdI8
 fcGurrU8qLq/ZmWK1GChK5hJMT1LLyNJ98Hzi1JjyDEtFBwEKnLUuSe8IzgQOwlMgJNw
 CTl4VKvAt9JdiWw6Jop/XZU/vWuFzJNyzLrUQOIQbSd2j263C02w66uHAmadyFnZz/7l
 OyfXEQNEMYxz+ao7udH9MYfdRq1/C7eQh3DFpB0XSbFj3X4WquFMJSfeGqhsFhz2gT4g
 MmVgj63Wgcj1NX+Jj/gWWa3R/s8YppRSNxhgm4M7xcYYo0AI0m6EiWS7PmyRlht5fAaW
 J3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721923852; x=1722528652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gcb2avpyO6xYqPZM1PBxXk4HYqEwjSAIHC8v3bxIc14=;
 b=dP3QEretELDCu1ouGS4apn0Q7mDVnHd5LLzEOY8leqUfAncht+Iz8vMOqA5CGSTHQk
 CZEfjomqFOnfxA16knWV9oGSKttCXnboc9W+8m8PaeBn0QBWxUk1qsUMYzU8aiVsIc6q
 d3YXoXGOFrRVEEXIQAC+hbl44m4TrkVta9eiRZjtjANQBtKRolAy4H+awO6QsbA8IaIq
 hJJVCHuPI3H3JXmwdyip37XNYKbd55XQlV1aoVe5dwN2R2LLfoop1Fx1cIruA6bbChsC
 tVZIeadHlWbV2sUSEnPWkFUKhWRETlhOG6fHZERblhZMUhofbcyOG/Bkn0Q4CPFjTylV
 T6WQ==
X-Gm-Message-State: AOJu0YwhUQOyvpe57zcjHk4kOy81FD2oZdi0rEM+OxmONZ8y0/UWLX7F
 l87BZ2jnNli/E3o1GYgN3lTHC1Qzb3xNxOjJUrWDK1lu/bIEGRsiw3qvr1S4454=
X-Google-Smtp-Source: AGHT+IGq2O5GVTnX8r+zBEHl62KN5f7a/r0+qWdgjua7EtOfu+2K2Bx3NRJ0nXynjjbrGqeAOoeUxw==
X-Received: by 2002:a05:6830:611b:b0:703:6a3e:d3ca with SMTP id
 46e09a7af769-709324c4446mr2913654a34.26.1721923852347; 
 Thu, 25 Jul 2024 09:10:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093078f877sm346397a34.75.2024.07.25.09.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 09:10:51 -0700 (PDT)
Message-ID: <5d3859cb-f1c5-4f43-9223-ba1ce021937f@linaro.org>
Date: Thu, 25 Jul 2024 18:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/20] configs: add qemu_arm64_lwip_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
 <20240725155806.GV989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725155806.GV989285@bill-the-cat>
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



On 7/25/24 17:58, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 02:57:37PM +0200, Jerome Forissier wrote:
> 
>> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
>> selects NET_LWIP instead of NET. This config has all the supported net
>> commands enabled.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  configs/qemu_arm64_lwip_defconfig | 5 +++++
>>  1 file changed, 5 insertions(+)
>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>>
>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
>> new file mode 100644
>> index 00000000000..1afef04d7a0
>> --- /dev/null
>> +++ b/configs/qemu_arm64_lwip_defconfig
>> @@ -0,0 +1,5 @@
>> +#include <configs/qemu_arm64_defconfig>
>> +CONFIG_NET_LWIP=y
>> +CONFIG_CMD_DNS=y
>> +CONFIG_CMD_WGET=y
>> +CONFIG_EFI_HTTP_BOOT=y
> 
> This doesn't work,

How so? I've used "make qemu_arm64_lwip_defconfig" hundreds of time to build for
arm64 QEMU :o

> you need:
> 
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index 1afef04d7a04..d3d8ef16e668 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -1,4 +1,8 @@
>  #include <configs/qemu_arm64_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_QEMU=y

Those are both set to =y in my .config after "make qemu_arm64_lwip_defconfig"

> +
>  CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_WGET=y
> 

Thanks,
-- 
Jerome
