Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94275C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 10:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195A087D57;
	Fri, 24 May 2024 12:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PAQqXzJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4102187DC7; Fri, 24 May 2024 12:09:37 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B15D87D43
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 12:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso1850221f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716545375; x=1717150175; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9aq4lGuoC0k0t4HAidVBkFpplGpoGbaJE2dVNIMtEdM=;
 b=PAQqXzJZiLjqoAEL+tAYYi90LjUWOK0K8ohQk0YK5h7kfs4EsEZcyzvUaN0blJs9++
 4j4JyWA2x9Bnv6sRgnINPpyN+bzgz2FC1E4OUCscK0vbt92CbDwhNmphbDLoFWNTO0Bl
 +8oBcs/lMaty8jn+H7LJKPQVDaFMKm0fwZhRR6iXxh7qkWPspfmWk7hsnWzXA+iP0tYb
 2imtqnhOlMnghtJJhgJ5bgBK/g8wZB/33U+zHmh2BkKXJmf7WKLZ/TL6QX07LG88LLpP
 9t5fSLqD6yNKvRtoXjk+2FNJ+uLnmMJIFUnLKcx0Mx5jy/kU1Ah1ZpeEPGaOnj0+Kkir
 eQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716545375; x=1717150175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9aq4lGuoC0k0t4HAidVBkFpplGpoGbaJE2dVNIMtEdM=;
 b=YYVyVyVG8xkuWGakSQN12i5rPRg4+aV6Xz3GmxObh5TTFqzp3Mr3Z9CneG0pdSNs/h
 D5vvghqb9qrDmqQIbNQ2vMXv0112/eCUt12xtri/EOFWVVKnHRjiP6RnNnJsLAu9+xGt
 giku9In1mPztao7BeOaf7kTOWdo1jv6lKrw2LVuSTv9V7ybpq1FjhkcsTTaAU1A1aLoj
 NUKW0ehjGj0IRalmxO4lO9kAea4PRUEjSjJfAHducOPcm7rgYeWQBWIHgmOTMIsGjZiK
 Ojkx+/SDbCiM5IYKUYOmkyXplL0GOuAhB+2oJDDGQJajVoLuJVHL3yeFPwN92omBSCAO
 ctUQ==
X-Gm-Message-State: AOJu0YzvtKLpt8GGruw/aHX9R2IwIeHjEEbyO67Arj+t1pBQvuhCvNXe
 iiPw+VCH+Zh+H6vls4S9OrwZSj/PGmem0JIbYoSAfu8WSx+rTGE5ABi8motLTeA=
X-Google-Smtp-Source: AGHT+IHEAqeJPM4ARuFWGkZCo6qcjMldaWczugg1wEidgMy+EvUwvUx19OzMIjl9T9zWn6tBQGJwwg==
X-Received: by 2002:a5d:5609:0:b0:355:6d5:aa35 with SMTP id
 ffacd0b85a97d-35526c6b533mr1169679f8f.18.1716545374762; 
 Fri, 24 May 2024 03:09:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c?
 ([2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf03acsm1241021f8f.103.2024.05.24.03.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 03:09:34 -0700 (PDT)
Message-ID: <0684e59c-523b-4b6f-9ed2-138122c8c127@linaro.org>
Date: Fri, 24 May 2024 12:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
 <20240523150246.GO2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240523150246.GO2568172@bill-the-cat>
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



On 5/23/24 17:02, Tom Rini wrote:
> On Wed, May 22, 2024 at 06:00:12PM +0200, Jerome Forissier wrote:
> 
>> Add qemu_arm64_lwip_defconfig which was created from
>> qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  configs/qemu_arm64_lwip_defconfig | 70 +++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>>
>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
>> new file mode 100644
>> index 0000000000..c8dadbce37
>> --- /dev/null
>> +++ b/configs/qemu_arm64_lwip_defconfig
>> @@ -0,0 +1,70 @@
>> +CONFIG_ARM=y
>> +CONFIG_POSITION_INDEPENDENT=y
>> +CONFIG_ARCH_QEMU=y
> 
> Setting aside that I would like lwip to default to y, at least in the
> first few iterations (so that testing is easier),

I could certainly do this. By creating a new defconfig, my goal was to
minimize the impacts on existing use cases.

> this should be using
> the #include method rather than duplicating the whole config.

I've done that for v2. Let me know if you still prefer I change
qemu_arm64_defconfig instead.

Thanks,
-- 
Jerome
