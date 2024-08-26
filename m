Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEFFC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 890BF889FC;
	Mon, 26 Aug 2024 13:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KtxVnlFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE5688A00; Mon, 26 Aug 2024 13:48:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80ED88418
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso36295315e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724672883; x=1725277683; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WblpC0RVF7mcuCXpdbaubaQcNOSckdSHccn0Kb0wGP4=;
 b=KtxVnlFvFGsxdQ0RHxtJJXn0WeoBB/S0n8vwZNpSDBDno1Q2MsdlfmsplGVwqL0i+x
 4qEPj/+tZwGpZoIAb76fM2hY1xlo1cIg9Bclry8diXNCDx3PM/7MxQUN+EK9Hz1X/f2b
 VVZB3aASuor+y/jDDV0BaVSb2VHdklnQYuyANO72jnv+L/ucL5tyF/Vcb43u+afa9M6u
 crLvNv8bFy0BpdwAaLsRvWxOpbtVLS8tAh7CnmOTpmT0Iw+Qlz4jj6X2GyqVAfoO52Pi
 PRe92Gz4pIMANLcs/hDy7xutJJEEI69P5roJBukTpgp/RqUdeCMBs6++J1weZHd/m0GQ
 TxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724672883; x=1725277683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WblpC0RVF7mcuCXpdbaubaQcNOSckdSHccn0Kb0wGP4=;
 b=Br9WQFhWGVO7rXYhwpgjfG/YF0aKCExzd44EcWxhJZuYgDkoCxDgT/ahzhztqYgo4K
 HgrXc1kpCqycFcz53JGcEMbaORu2F2Y0ZVJO2knkB+Ci5lk/v7r7Jd+D4Ocv+G4ww6ae
 wdi6sBJ2qi8h3ZYmjSsJCTms6XB8uEd+YWY/VBCKCxsfJ1LzTZ4sv89SQ1aIqV4oyI1N
 EmJa6z11AFZwqa9oBvM2Hq39OaLwNsBUPJ6I8w8LE089tK4ZZkKkEM2kwvgQof2ssP7X
 MjlUVbQQYRRCnD7w3eIdOBaCbV89rTyW8T2gkHYd0caeKOkAGSO1XyDzfo0BP+8gDr4k
 Nqnw==
X-Gm-Message-State: AOJu0YwnnGcziTsVWXW9Y1FrNCer2W8uuNzI0AziQZtFINeUxVAy+5SC
 Mo7K7vVR3cuHC4s1V6TRZCnNwuTeUhs0mmxcqFn+466kU0ys3SKZFpM5a7s9r6U=
X-Google-Smtp-Source: AGHT+IE9+o5n/WgyD6ANdqPTgbjQpEmvwhnhNeWau7XfSnhNIISJ941xbNNXZmGFefifbj/coFjuYQ==
X-Received: by 2002:a5d:6d06:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-373118e551emr6830529f8f.42.1724672883040; 
 Mon, 26 Aug 2024 04:48:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c?
 ([2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefc63c4sm185787845e9.29.2024.08.26.04.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 04:48:02 -0700 (PDT)
Message-ID: <92bcf9c6-d2df-4276-b35b-a457e8bddbac@linaro.org>
Date: Mon, 26 Aug 2024 13:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 34/37] configs: use syntax CONFIG_FOO=n in
 tools-only_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1cd8b6cde8ba55d6f78cc8ca4c4376bc5ce62294.1724419624.git.jerome.forissier@linaro.org>
 <20240823213030.GA2479150@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240823213030.GA2479150@bill-the-cat>
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



On 8/23/24 23:30, Tom Rini wrote:
> On Fri, Aug 23, 2024 at 03:48:38PM +0200, Jerome Forissier wrote:
> 
>> The tools-only defconfig causes troubles on MacOSX due to the default
>> C compiler being Clang (LLVM) rather than GCC and more specifically
>> due to [1]. Therefore replace "$ CONFIG_FOO is not set" with the
> 
> "# CONFIG_FOO" not "$ CONFIG_FOO".

Fixed in v10

> 
>> equivalent "CONFIG_FOO=n" using the following command:
>>
>>  $ sed -i -e 's/# \(CONFIG_[^ ]*\) is not set/\1=n/' \
>>        configs/tools-only_defconfig
>>
>> This fixes the tools_only_macOS CI job on GitHub [2].
>>
>> [1] https://github.com/llvm/llvm-project/issues/78778
>> [2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=9105&view=results
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>

Thanks!

-- 
Jerome
