Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6076BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 13:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5C6874F2;
	Mon,  4 Dec 2023 14:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MaXv4i7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613A8874F2; Mon,  4 Dec 2023 14:33:45 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23A98755D
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 14:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33338c67d20so1903385f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701696822; x=1702301622; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIGo5a0sR9F7ONWHbTjzG7+9DRdaTkgK9vt7Vj877zo=;
 b=MaXv4i7vaaq95g64BivL7QXrwg0fo8yd7MXryusBsJNOSYGfKhcT/7kjlwylFuh2Mp
 3VvR0KM6PnN3CQOtKAIsw+Vw/R4XMxI/AoWGi1nKleiC0vI70Ik9odb63qZo+2kmb3bz
 Dc9hBciv9YPDH3uN9es+zM0PivBm1HtEvi+IkiWPYvlblGN931Yimn5FqNYxdJZ4eMhS
 GEAIH6kK4KKBR0qtG1P+7Fhmc0wmGeEnjeomPjCTNjqAb7HPAW2j6IIkAoE8tVZ4xhop
 Cljew07Hi4SjNNMfNGpBkGh7rym+EynmTZoW+M4/5f8N2Li6T4VCAu5wcAEs28Q6YFVb
 7nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701696822; x=1702301622;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIGo5a0sR9F7ONWHbTjzG7+9DRdaTkgK9vt7Vj877zo=;
 b=SnGpnACBnwVbZkf/dQQvH9McnXy2ZvM/fMQt48Wq2Csww45B9yCMpFr69iN7SOW0dL
 nbf9ZXupOHVUe558RuyE54Yn3GBL0QhYZpV+/QXHAKYvHSuXSLvuHD4E3hJfXMBhqUuD
 qiJri4sYKVcY1xMNgJs+Fy7zDFcsg5f6ZGFq/SUYymUzJU6bMxFyPyua63sOcMqISAdU
 kbRHqp5zo/yZZ1qU2bqI24tEF2wEDbqagHLF4+czgHUDhaG5TWgaxWOOLmdP+fOP+9yb
 UIHJifci0ULmecorf9Rc09jUMDTlEcPI+m45kAQYlnp44nxYN9AESv/kJtgohWw5TzR3
 Zgfw==
X-Gm-Message-State: AOJu0YxRp5SYYIsiHVvc7B6hMU+xXGBbOmuZSL0XMq2/D2ZjdcvAvEZ7
 sJ+2q96sBVynJgMcJ5ZuduHfNA==
X-Google-Smtp-Source: AGHT+IEyo42zjVDH5EdWYM0omu7jdOnYMBSNfP0KHq6whV4FvK3J863ygRTjkAwLwVkQOTAWP2XFiA==
X-Received: by 2002:a5d:4649:0:b0:333:2fd2:68bc with SMTP id
 j9-20020a5d4649000000b003332fd268bcmr2527416wrs.79.1701696822295; 
 Mon, 04 Dec 2023 05:33:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
 by smtp.gmail.com with ESMTPSA id
 c1-20020adfa301000000b003333a216682sm6597527wrb.97.2023.12.04.05.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 05:33:41 -0800 (PST)
Message-ID: <a47b92c3-3546-48b3-9abc-c1e2822e410b@linaro.org>
Date: Mon, 4 Dec 2023 14:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 conor+dt@kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 neil.armstrong@linaro.org, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <20231204110025.GA27965@aspen.lan>
 <CAFA6WYPYfKU9hHh5CCbgcb6FEDX7ivGO=tGv4N2dAX6_gAGuUw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFA6WYPYfKU9hHh5CCbgcb6FEDX7ivGO=tGv4N2dAX6_gAGuUw@mail.gmail.com>
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

On 04/12/2023 14:24, Sumit Garg wrote:
> On Mon, 4 Dec 2023 at 16:30, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>>
>> On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:
>>> + Linux kernel DT bindings maintainers, EBBR ML
>>>
>>> On Thu, 30 Nov 2023 at 20:05, Tom Rini <trini@konsulko.com> wrote:
>>>> On Thu, Nov 30, 2023 at 01:02:25PM +0530, Sumit Garg wrote:
>>>>> On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>>> I've been thinking about and hacking on this for the last week or so,
>>>>>>> sorry for the delayed reply here.
>>>>>>>
>>>>>>> The value is in preventing any of the existing bindings from regressing,
>>>>>
>>>>> That is actually best addressed in Linux by checking the DTS against
>>>>> yaml DT bindings. We don't have that testing available in u-boot and
>>>>> only depend on careful reviews.
>>>>
>>>> I would absolutely love for someone to make another attempt at updating
>>>> our kbuild infrastucture so that we can run the validation targets.
>>>>
>>>
>>> Given that EBBR requires [1] the platform (firmware/bootloader) and
>>> not OS to supply the devicetree, it becomes evident that
>>> firmware/bootloaders import DTS from Linux kernel (where it is
>>> maintained).
>>>
>>> But currently u-boot doesn't have a proper way to validate those DTS
>>> against DT bindings (maintained in Linux kernel). Although there are
>>> Devicetree schema tools available here [2], there isn't a versioned
>>> release package of DT bindings which one should use to validate DTS
>>> files.
>>
>> The kernel is regularly released in multiple forms (including git
>> tags and tarball). Why isn't the kernel itself sufficient to be a
>> versioned release of the DT bindings directory?
>>
> 
> The Linux kernel may come in various forms (upstream vs stable vs
> vendor). It's difficult to decide from where the DT bindings should
> come from. Should they come from upstream or should they come from the
> kernel which is actually booted onto a particular device?
> 
> IOW, as of now which kernel version should u-boot pick up for DT
> validation checks?

The same version as in case of release from separate DT bindings repo.

> 
> If we can have a separate release cadence for DT bindings then the
> platform (firmware/bootloader) can attest the DTB against that. Later
> one should be able to boot any kernel with the DTB provided by
> platform.

Separate releases of DT bindings change nothing here - you are going to
ask the same question: "which release shall I take"?

So the answer could be the same for both: take latest mainline kernel
release.

You really don't need separate repo just to know which release to take.

Best regards,
Krzysztof

