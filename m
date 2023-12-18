Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9A4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7538715C;
	Mon, 18 Dec 2023 23:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOpCaZI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68F3870AB; Mon, 18 Dec 2023 23:13:57 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E00871CC
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a233828ab91so261141466b.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702937635; x=1703542435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b3pE3xgJ4Ga43NcB8fmFEHrOzN3+P+p5+/e02oaAboc=;
 b=WOpCaZI5LWouJkXv1KaNKbA3yc+UG6NDB4qg8/E3mYI8JdzjilcGMHmiqa/KmfJcHl
 AanAUBwBV2gM1gSuzq81hp3gTJ9esUXv7uup/m9ImfSIxSQvqffVIroG1ugP3hsGrZEU
 ciJgymYdrY26ytJI85fqUpJRJfOmxLEZqaJDbXjA5axRYelWHDp1R/4CTcpGLBKP68ZA
 zZRtdb7rjmw4S8J9gWKpCs/SLcZnrNP5Vk7OkF2A68pDVRRHLcHUohaGoECG+6w2pMMj
 MGnKHD7gFklBx2TksKvUiqVRgahRDUp3W2yUJM1Sij4Z6b2+9ek07zRcyYL9M8fsBseF
 Gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702937635; x=1703542435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3pE3xgJ4Ga43NcB8fmFEHrOzN3+P+p5+/e02oaAboc=;
 b=TpHKh0VZmHMPesWQZMimfiYYDIwArE6WdKac0X8/8Lef+3Cf1Sh+WOQGuaIVA3LGgN
 z0Ysm2gT2MprApuET144qw41l9fpEJQboseVD8/ZI+R5X14svpum+zupot1NZ/7JLiOP
 TEogi2W8yaztvD5Z7H86c/ccyTQ8Ln4RrlOzdgDL/fkkRrSd96Bn97iwU2hGbJMR4E4I
 FQBKG8gKJqmsPz2IgFi1oazVTdIjmMT9Fzs7R2BtXLdIT+SWJFAHBX/qQy3VPDyWiv01
 tTXJYuYybl2SCn5g2PhtmLRVZZqErPYxtAkEiNrFRjX4QOLSuPjAOqwLmqbg6vv/sPbh
 J/yQ==
X-Gm-Message-State: AOJu0YyoDGmW7D/FmzHVPBkALnNfyWTNTnpPryI4RXgbIcdfijwSLAHI
 aSlsyb2yFaUegUqGDlznLNM=
X-Google-Smtp-Source: AGHT+IEzAgc0r4/Eycn/fmBbjmEeiAm2EBAahpSSLJ/wbqBmmehAvWVE9DTA5PhXrRJziFX5yn22qQ==
X-Received: by 2002:a17:906:1043:b0:a23:6d24:94cd with SMTP id
 j3-20020a170906104300b00a236d2494cdmr417718ejj.14.1702937634859; 
 Mon, 18 Dec 2023 14:13:54 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.googlemail.com with ESMTPSA id
 i14-20020a170906a28e00b00a2332116b3esm2965234ejz.152.2023.12.18.14.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 14:13:54 -0800 (PST)
Message-ID: <5cc586e2-c510-42c0-a451-73a8a129a30f@gmail.com>
Date: Mon, 18 Dec 2023 23:13:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot environment
 variables layout
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Michael Walle <michael@walle.cc>,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, u-boot@lists.denx.de
References: <20231218133722.16150-1-zajec5@gmail.com>
 <170291091219.3792434.8389294947030479112.robh@kernel.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <170291091219.3792434.8389294947030479112.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18.12.2023 15:48, Rob Herring wrote:
> 
> On Mon, 18 Dec 2023 14:37:19 +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot env data is a way of storing firmware variables. It's a format
>> that can be used of top of various storage devices. Its binding should
>> be an NVMEM layout instead of a standalone device.
>>
>> This patch adds layout binding which allows using it on top of MTD NVMEM
>> device as well as any other. At the same time it deprecates the old
>> combined binding.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
>>   2 files changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition@40000: 'ethaddr', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition-u-boot-env: 'ethaddr' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#

I checked my binding independently using using dt_binding_check and
missed that. I'm not aware of any way of limiting possibility of
applying binding to specific cases (like "nvmem-layout" node) so I
guess I'll just have to avoid duplicated "u-boot,env" compatible
string.


> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231218133722.16150-1-zajec5@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

