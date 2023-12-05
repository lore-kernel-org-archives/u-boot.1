Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC9BC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A3E87880;
	Tue,  5 Dec 2023 11:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rdydy9LE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F14587885; Tue,  5 Dec 2023 11:09:36 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC0687880
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c09dfa03cso24163865e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 02:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701770971; x=1702375771; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gJwCF/mZk93NvOqET8JGBbOGyuvOGAUnKwYnX6c1hg=;
 b=Rdydy9LEKEncFu/4kHHIXANkP/zPYor4dlolO1jx304KUOCyxI0rIPSd3O2R1dBqyr
 84QF5SdhUhySrG68RzcWejyW7nC1LVwaSl0c5g21PBVJhEtCPgJbriUn3FX2Vj0dOV1r
 FRJZokl21d61VG/NODJz8ffSPpgnSSjV4pSo/eNPfftMRNT6rLETRDRvoEnqeD2owO4W
 OQ44gwFz8ayfd9K1XZ4AwT/PW9ds7eQZrctVyvoEVAZ0SB1BHVeBZSdZT84F1iT1nu87
 Iq4IbPh+IWDGt6qqDFS0haSITCrfn6AnPMhluQmBEMX4UucdyCZo0ujSrUfv5VqYigOT
 2LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701770971; x=1702375771;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gJwCF/mZk93NvOqET8JGBbOGyuvOGAUnKwYnX6c1hg=;
 b=a4W0dl02zCmqF8Vs+8EmfM9aIw60F1hbcdY2Uu5WwIG+DDYDYatQJwHQSZWgPYjg9+
 sWsMU9HR2s2Ba4X83cU0v/Pay2EI+/G1xhk5M5caJdVrJRBTecUOJQDcDYI3PW943xW9
 9wPZSOlU+Iigil/RcpVyZpnK+BdJIU98ccG9i54+JyXGQLu3WI/tLfMgsE5izcN8pvN+
 V24z9q4BocTJfpKG9Wj3Aagni/qDWuDcWQfB2Mto20d4nIkIj8j44zr0XI3DGqB0kFr7
 Svyu6Y9aYRkwMho2h3S44rnN1gdL1lqTVW80e+TvUSr/PCfoUH/fsX8iVs2wQXOKbwp1
 72Dw==
X-Gm-Message-State: AOJu0YwasWxeyy/IQW4YiFyDOUVZERMQvdFHPkj16tVW0MoZBum14me+
 m0qXqvJ0AHu5aEkvnpY3sJdvJQ==
X-Google-Smtp-Source: AGHT+IGKmIdX0+KzLsZ3HhMy+XCQX+Wl1mVWPEHXEkELcYI45fhijq80CDVDi58qbj7eZWZNItOsYg==
X-Received: by 2002:a05:600c:4f8e:b0:40b:5e1e:cf1 with SMTP id
 n14-20020a05600c4f8e00b0040b5e1e0cf1mr320252wmq.44.1701770971169; 
 Tue, 05 Dec 2023 02:09:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b004063c9f68f2sm18161367wmo.26.2023.12.05.02.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 02:09:30 -0800 (PST)
Message-ID: <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
Date: Tue, 5 Dec 2023 11:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot-custodians@lists.denx.de
Cc: Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>,
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
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
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

On 05/12/2023 10:45, Sumit Garg wrote:
> + U-boot custodians list
> 
> On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/12/2023 08:13, Sumit Garg wrote:
>>>>> @DT bindings maintainers,
>>>>>
>>>>> Given the ease of maintenance of DT bindings within Linux kernel
>>>>> source tree, I don't have a specific objection there. But can we ease
>>>>> DTS testing for firmware/bootloader projects by providing a versioned
>>>>> release package for DT bindings? Or if someone else has a better idea
>>>>> here please feel free to chime in.
>>>>
>>>> This doesn't work for you?:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
>>>
>>> Thanks, this is certainly a good step which I wasn't aware of. Further
>>> simplification can be done to decouple devicetree source files from DT
>>> bindings.
>>
>> Why?
> 
> I suppose you are already aware that Linux DTS files are a subset of
> what could be supported by devicetree schemas. There can be
> firmware/bootloader specific properties (one example being [1]) which
> Linux kernel can simply ignore. Will you be willing to add all of
> those DT properties to Linux DTS files and maintain them?

We already added them and we already maintain them. DTS describes the
hardware, not the OS-subset of the hardware.

> 
> However, DT bindings are something which should be common, the
> hardware description of a device should be universal. IMO, splitting

Both DT bindings and DTS should be common. I don't see the difference.

> DT bindings alone would ease the compliance process for u-boot drivers
> in quite similar manner to Linux drivers.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/bootph.yaml
> 
>>
>>> AFAIK, DT bindings should be forwards and backwards
>>> compatible.
>>
>> The same with DTS.
>>
>>> So if you pick up DTS or DTB from any project tree
>>> (upstream kernel or stable kernel or u-boot) then DT schema validation
>>> would ensure that corresponding DTS or DTB doesn't regress the DT
>>> bindings.
>>
>> And why is this argument to decouple DTS from bindings?
>>
> 
> See above.

It's not really explained there. You can pick up DTS from any project
and validate it against the repo Rob mentioned or against kernel.
Whether DTS is in that repo or not, does not matter for your validation.

> 
>>>
>>> Ideally, it should be more user/CI friendly if DT bindings can be
>>> easily installed alongside devicetree schema tools [1].
>>>
>>> [1] https://github.com/devicetree-org/dt-schema
>>
>> Does it mean you will work on this?
> 
> I am happy to collaboratively work with DT bindings maintainers and
> the u-boot community once we can reach a consensus on the above.
> Basically the main motive here is to validate DTS files present in the
> u-boot tree and be able to reliably pass them to whichever Linux
> kernel version you are trying to boot. IOW, make Linux distros to
> reliably boot with devicetree supplied by u-boot.

So the answer is "no" on the proposal you mentioned before. Sure, maybe
someone will pick it up.

Best regards,
Krzysztof

