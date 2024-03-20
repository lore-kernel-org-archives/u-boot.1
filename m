Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3510DC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7EC87FCC;
	Wed, 20 Mar 2024 13:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dK/qLmMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F120E87FE8; Wed, 20 Mar 2024 13:33:37 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07BB87F87
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4141156f245so22234885e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710938015; x=1711542815; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6k1Vfyrn9oZJHqhIDDP07nXMyMai+/n0vjuHQiOZeOA=;
 b=dK/qLmMi/XmfazbEwe9MXShwemMKlPHL4ncas7E4lPqcAUOrBcLwV8EHHIrEhTxx1x
 fNgo7qQS1jsDNL4Bi6od1PRL7QYWT+id7AnYnZEi+XwzYuTTgxeAfH0st61QpM+MYUeL
 cSGIGS3tcnSV/BC5HcOhyMH276iCP7Wh/1gWNuEEvnaPza4tGNVi5tboE2+9yoG9ViLy
 4bEKHTxmCsWWg6G8Jov/WIoqfKfMsdc0rs1UVrZFq8t53vV2v5Vb2OxqjZtYrv2EnsyB
 AXSNaOXPAtm1DDVWrB6/1GDyXOI4uI+c9JPnyc3Q6GhKCqLACUspelaDTziYeXTzANBN
 hVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938015; x=1711542815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6k1Vfyrn9oZJHqhIDDP07nXMyMai+/n0vjuHQiOZeOA=;
 b=OaNMoZ5pefBf6iL0XKEmveI0QhDG7zDMH7ivRHIpgV4TnvVm32qOM+veDMKE00CchV
 peSnfCgaPpV98OQoKuCYXYpcZmrT/2Ou8Kir7QnOper8M2FeqioDRUIf57ykboFEFUt0
 x1JEqvN+/yhx0EvhwLWOFlY2lKVyBub1CYIppNcwWwSKPWgUaS+SeWkpqfxegfN/EugD
 3SWvq56GWnhnMKm20MOdxiJPxzBO1bYINO121xjCK3CFcRQRylNEh6sYCaORPED2QnZE
 KlYuySUDpM2eG1I8SafCj/+zrlqV2jRrDLqzljHXmEo60ICV1QI6RbAOmkpgLClg6Cpn
 l3aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNcLR1f6/Afxw8XMiuyMlT+8nmD+K0QiWNdN1lU3ieZB+69cbr63MEPpTblAk9w7OaMZuMUs6NUo1wKW74ULClGy4TZQ==
X-Gm-Message-State: AOJu0YzCRpX+9ozvJYbEdWtqQ/UZudrObcT65YmCL1G1Yitwma7KgzG9
 wkRRDABCUEY+Yt+9ElG+zPjleYQGnKdM7vsDGUrc8NyOpJQuBMh85kIYyLHZgCA=
X-Google-Smtp-Source: AGHT+IFVqhbgyX+TfVJfF90uOEVcGV24+NIN5hZMfhJRm4Xzy6zdBa5XFQOaqV3FYZ1YZe76stm0jQ==
X-Received: by 2002:a05:600c:331e:b0:414:a99:7aa2 with SMTP id
 q30-20020a05600c331e00b004140a997aa2mr8012836wmp.4.1710938015342; 
 Wed, 20 Mar 2024 05:33:35 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b00414612a43a9sm2088356wmq.28.2024.03.20.05.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 05:33:34 -0700 (PDT)
Message-ID: <1bdbe86d-abe7-4e14-947f-245cf9661f08@linaro.org>
Date: Wed, 20 Mar 2024 12:33:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] dts: sdm845-db845c: add u-boot fixups
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
 <CAFA6WYN3MZ0Rh-XEEggc4OUk2wUQngT3EJDcHQb0-n7jxfMd9g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYN3MZ0Rh-XEEggc4OUk2wUQngT3EJDcHQb0-n7jxfMd9g@mail.gmail.com>
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



On 19/03/2024 13:55, Sumit Garg wrote:
> On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
>> This is incorrectly modelled in Linux where only the PCIe dependency is
>> expressed.
> 
> Can we send a fix for the Linux kernel DTS to correctly model it? We
> can then later get rid of this modification once that is accepted.

I spoke to Bjorn about this and apparently the correct way to model this
will be to have a usb-connector node with a vbus-supply property. There
is some work underway in Linux to support this kind of thing already.

In the mean time he suggested to just make the regulator always-on, so I
sent a patch to do that [1]. I actually hit this issue when booting from
USB as the PCIe drivers aren't available in the initramfs, so USB never
turns on, and the always-on hack fixes that.

In the mean time, we'll still need this vbus-supply reference as U-Boot
doesn't automatically probe regulators.
> 
> -Sumit
> 
>> Add a U-Boot specific dtsi snippet so that this supply will
>> get enabled when initialising USB.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/dts/sdm845-db845c-u-boot.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..3c83e21251c4
>> --- /dev/null
>> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* This GPIO must be turned on to enable the 5v VBUS
>> + * supply on the USB port.
>> + */
>> +&usb_2_dwc3 {
>> +       vbus-supply = <&pcie0_3p3v_dual>;
>> +};
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
