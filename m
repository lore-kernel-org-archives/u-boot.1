Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ACCC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB22C876A1;
	Fri, 22 Dec 2023 16:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4Ylmscr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F65871CF; Fri, 22 Dec 2023 16:38:08 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93FB876A1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e55f97606so2861633e87.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703259484; x=1703864284; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyRWQKXS7xOukJONXEVPNtf9D6+uL6Jr9lU0hx+jSDY=;
 b=U4Ylmscr2k9U13WSqKOWvcndyqO1kv+xJcvs3ErrqE25GLpZQ0ggm4LVT16dxKr7dK
 8Y79JPAfj37jo5tScNcEv0aotUlsSl20eZYeUpFO7HbGL5+0i1Cq0VMEDuQfotNX1yR1
 fFy2l7zaedWXNC1zcpEKM9WNedz6nA4XiCPNT5ZDin1WNFlcv0LypzAiJNXH5yxRlwnT
 xAAGKwklI0a1cjo/DQg9JByLACCveo4OelGgxC7AGsK8YpWmll6EY2oGNsIsMIW5VPR7
 ef1wuut5XmT4BxDdB7GVLpvVMNd2SASsu2l+5BovGDbOFtmX4F7gXNgrnBa9A9dCGXhN
 pi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259484; x=1703864284;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyRWQKXS7xOukJONXEVPNtf9D6+uL6Jr9lU0hx+jSDY=;
 b=XnsSgHGRiiLFTvvXyPhegJWG6xKj25kv12XeCtFa27xqjw0hGYOjtEmUGgdbR34FpO
 DYMqRB34HiJC/QRL+VncFEXiRnWkof7893KwDH4WS0TGTsOD7uhJ3udsgHPjx998XU5A
 HzZTqTsu1vU5ro0JdNeZfWpDnbjwKBEpSYId8HsYUk2gXbPUHc69XnzvbfUXi9Il55M9
 nsGJZHyhBRrnpu3oG9lp5OeVC/uISADHFzgYP95M4j5iSROkLl1zfwO1eyG8auY9caXl
 oIO46VkoP9Gnjx9DuMHl3KluoPdSEu90BaSpqRd03LEgLXwgEU4r+iUViXifyTPjfIgl
 68Zw==
X-Gm-Message-State: AOJu0YwbM/JpxzgBrvVLS0b3FdxEE7Wk5Qt/4cIX//CPJ2/FF77hBqGA
 tBwV9xPpLkuGzVOhDH6jGU4gR0EN5Eqzqqg6uNaVWLdcLsc=
X-Google-Smtp-Source: AGHT+IEjuh6hKL8xlmNU6GhKNEhnRqL9+RY0gjwfCT3Q1SEQzVewMKM+61SNPG/lUequ3IeMQZAu5g==
X-Received: by 2002:a05:6512:2190:b0:50e:683f:6a19 with SMTP id
 b16-20020a056512219000b0050e683f6a19mr809987lft.33.1703259484092; 
 Fri, 22 Dec 2023 07:38:04 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a1709066bcd00b00a2698693308sm2141506ejs.183.2023.12.22.07.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 07:38:03 -0800 (PST)
Message-ID: <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
Date: Fri, 22 Dec 2023 16:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
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

On 22/12/2023 14:43, Sumit Garg wrote:
> On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/12/2023 07:12, Sumit Garg wrote:
>>> Changes in v2:
>>> --------------
>>> - Patch #1: excluded gitab CI config check and added commit description.
>>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
>>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
>>> - Patch #5: s/U-boot/U-Boot/
>>> - Patch #6 and #7: Picked up review tags
>>>
>>> Prerequisite
>>> ------------
>>>
>>> This patch series requires devicetree-rebasing git repo to be added as a
>>> subtree to the main U-Boot repo via:
>>>
>>> $ git subtree add --prefix devicetree-rebasing \
>>>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>       v6.6-dts --squash
>>>
>>> Background
>>> ----------
>>>
>>> This effort started while I was reviewing patch series corresponding to
>>> Qcom platforms [1] which was about to import modified devicetree source
>>> files from Linux kernel. I suppose keeping devicetree files sync with
>>> Linux kernel without any DT bindings schema validation has been a pain
>>> for U-Boot SoC/platform maintainers. There has been past discussions
>>> about a single DT repo but that hasn't come up and Linux kernel remained
>>> the place where DT source files as well as bindings are placed and
>>> maintained.
>>
>> Thanks for doing this.
>>
>> I really suggest to store information that kernel DTS is directly
>> re-used, thus DTS backward and forward compatibility matters, also in
>> Linux kernel sources. The point is that sub-arch maintainers should be
>> aware of it. I don't think that as DT maintainers we can efficiently
>> keep an eye on it. Maybe create a subsystem profile and include it to
>> maintainer entries of such affected platforms?
>>
> 
> From U-Boot point of view, currently we have the config option:
> "CONFIG_OF_UPSTREAM=y" per platform which means directly re-use of
> kernel DTS. So U-Boot sub-arch maintainers should be aware of
> platforms which get converted to re-use kernel DTS.

I was speaking about kernel.

> 
> I suppose we have to relay information to kernel sub-arch maintainers
> who aren't the same as maintaining U-Boot counterparts. How about
> adding U-Boot ML to CC for whichever DT change gets submitted in the

And every other project? Just setup lei filters.

> kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> corresponding kernel DT changes works too if that's acceptable.

You just entirely ignored my proposal without addressing it... ok let it
be. No, CC-ing U-boot maintainers changes nothing because as I said, I
want kernel maintainers and contributors to be aware.

Best regards,
Krzysztof

