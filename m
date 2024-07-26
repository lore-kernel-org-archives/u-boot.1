Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EDFC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E04F787D2F;
	Fri, 26 Jul 2024 14:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v4InJgcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41EB88395; Fri, 26 Jul 2024 14:27:09 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22D1878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso2412409a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721996827; x=1722601627; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3rh43re9agqea4p/tGpVqb+OYv6VeY8749DTZ4jHoI=;
 b=v4InJgcx9pag46glzUz/mI/FRrrNMwPr993gztybzkOjqyOrPUDh4uWLiOXEH5ybmY
 0EcOovIe9zCdrAq9W0b16FtgaoGxEcLp7crQ32vo4FmYF0G5pHlPLnPKDAzerfoHf7nD
 bgBJl9L/tWDP5P+mXihf2Yx5Yw+GvLDzVmUiQir6YK7vJzncrIR5APKehva2ESv9rDwK
 zT4++ox1N5eJDIMWbBWo0j6ZgKsogBkynZxWNFSVCWHNMQhC/9Nk9b4zJqsNyp0yDy0s
 icUt6Ul9Rq3D/nkS4ezFGYjeeGMO4k19DmLjDlztFSZaUJZIHYrRuVkf0J/fUoDJxz5W
 6V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721996827; x=1722601627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3rh43re9agqea4p/tGpVqb+OYv6VeY8749DTZ4jHoI=;
 b=pUh6VzNyWowZjknvHI7MK/AtdhstUv98y0YkDcuY/tQ3A8HaGkRBPdXMwyyvz3urst
 dFM3pTEzbjmx9E/IM4AVF8NoCg3MxvIxwiQKnbAI3GtTVdPAngN9U0UUaD8T6NGuvY4m
 6BBL76A/uKDcmeFy04MqR+qFEd72OxQN0qbtGOQzy4Q42Fug/mUBM2c936TFaq5ODgM2
 1RgtxrI7EPN9bKYgzbDNPwo15RZDdu5wYviW8xDO3Liw5919EKGBfeiwBiIRYHmMSRXT
 ueXL1Cr7eZflpk03gasKVwC1Bzb7yELaUPpSxSYJGGLTjBAAo9nErymClR65MN45wcHZ
 45kA==
X-Gm-Message-State: AOJu0YwWcerQJ94Sdo1ujIrV8+Plb7mVO/mslhGhJdIXCBkEKDaGsEao
 9bfS9y/KENACcWTBESoKz3QzMtcKHxz/PXyCfxJiGLhnruB3Xvb/wYPKc6zE7nKZVXWcxICjsOV
 6nhYQTWmEz1M=
X-Google-Smtp-Source: AGHT+IHbG+Da1Oau6n9BVQPISE/bErTpQ9vk8cWDSB/8g3HePDrJb+icK6BkSYFWtv7Qsv63m3KqYw==
X-Received: by 2002:a05:6402:5246:b0:5a4:6dec:cd3c with SMTP id
 4fb4d7f45d1cf-5ac2c5a67f1mr3594401a12.37.1721996826762; 
 Fri, 26 Jul 2024 05:27:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb7c0fsm1876465a12.62.2024.07.26.05.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:27:06 -0700 (PDT)
Message-ID: <eeaa2258-83f3-47da-a8ad-c666457e1f08@linaro.org>
Date: Fri, 26 Jul 2024 14:27:05 +0200
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
 <5d3859cb-f1c5-4f43-9223-ba1ce021937f@linaro.org>
 <20240725162531.GX989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725162531.GX989285@bill-the-cat>
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



On 7/25/24 18:25, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 06:10:48PM +0200, Jerome Forissier wrote:
>>
>>
>> On 7/25/24 17:58, Tom Rini wrote:
>>> On Thu, Jul 25, 2024 at 02:57:37PM +0200, Jerome Forissier wrote:
>>>
>>>> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
>>>> selects NET_LWIP instead of NET. This config has all the supported net
>>>> commands enabled.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> ---
>>>>  configs/qemu_arm64_lwip_defconfig | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>>>>
>>>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
>>>> new file mode 100644
>>>> index 00000000000..1afef04d7a0
>>>> --- /dev/null
>>>> +++ b/configs/qemu_arm64_lwip_defconfig
>>>> @@ -0,0 +1,5 @@
>>>> +#include <configs/qemu_arm64_defconfig>
>>>> +CONFIG_NET_LWIP=y
>>>> +CONFIG_CMD_DNS=y
>>>> +CONFIG_CMD_WGET=y
>>>> +CONFIG_EFI_HTTP_BOOT=y
>>>
>>> This doesn't work,
>>
>> How so? I've used "make qemu_arm64_lwip_defconfig" hundreds of time to build for
>> arm64 QEMU :o
> 
> Yes, but buildman (and CI) are in a chicken-and-egg situation without a
> few more details in the new defconfig, sadly.

With:

$ cat configs/qemu_arm64_lwip_defconfig
#include <configs/qemu_arm64_defconfig>

CONFIG_ARM=y
CONFIG_ARCH_QEMU=y

CONFIG_NET_LWIP=y
CONFIG_CMD_DNS=y
CONFIG_CMD_WGET=y
CONFIG_EFI_HTTP_BOOT=y

...I get:

$ make qemu_arm64_lwip_defconfig
generated_defconfig:71:warning: override: reassigning to symbol ARM
generated_defconfig:71:warning: override: ARM changes choice state
generated_defconfig:72:warning: override: reassigning to symbol ARCH_QEMU
generated_defconfig:72:warning: override: ARCH_QEMU changes choice state
#
# configuration written to .config
#

It is OK?

-- 
Jerome
