Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD56C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 20:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7913587EEF;
	Thu, 21 Mar 2024 21:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y8k5zLBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B891F87EEF; Thu, 21 Mar 2024 21:20:12 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BC0D87F33
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4146562a839so9823955e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711052408; x=1711657208; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwXsoNO/zuoSfzLvdrcsnTVGZVncarnvOnOQZHnr7XM=;
 b=y8k5zLBnkhGY2xkSciSjfYA+K3jWiPXhAV4hfaLeZnEJkB3TJplxSyfOzj1QEy8H07
 4NfGDYi5qyhHaymjUbdO3NpdF88i2ug87Q7FfNeCO+OVpXlCejGeV41VQVfrE35rFEKC
 9c68QNpPc8hJLJF6yjftWttPfoDYJJsofOUYkQijBvt9eq4mIe+ztejCbQ8lE9BiXzfz
 qBIjfERAUvGaf2t9IPh7oQhXloEJzYLqHs1hzb2DVGMivSANziJxgfrSEuKwWxuO3Dtf
 jZ9WYw/s6KxzhFBQ12Qq+b45bpdroYr+LSD8UKjbjDPk/8U9koPtL8FRK7QqsAZPB6sf
 cMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711052408; x=1711657208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwXsoNO/zuoSfzLvdrcsnTVGZVncarnvOnOQZHnr7XM=;
 b=u+KGbEWCBZz0aoF/ZGvNs1/kT/ZWV+kXOJGA0hDF0k0p+LvldA8lu0jsALS8kRMOPo
 qhlCFX5GBVO2qGfiUrdrUVKNnlUPOxCyeiIENI0AoJN5PuQzlQRD/jdU+BYp9+sf+EYb
 OJvl9nJiSOwN4GupC4Z1g8bnEBUhbhlFwFbal/XHZGgZCAYC9F+oIyjNFoPynU1vPKsa
 bFE+eJTFDYtp0F04lUygU9w3NG70QyKgQB5TUOmSZgPPptHkmiblWNX3c1s47CSooKBr
 0krPYLU1ComYjnyKtgwdo7D/B0AaRYAlj0hGkGdtp8MVDEeEX5Muv3PR9W2/GqXydlYA
 UCvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEQTofQMIvkSy8yFeRQEmLN52ZMsUOAv1maedKms7PpKq1gjaTD6LDXlvtvcxmipN1zR3YHyG6LOK3zaKRIcR3poLAnw==
X-Gm-Message-State: AOJu0Yxynb92XoX3ScaVgQpDKEE5JTAmaK4g4km+M20HR0QdEKKpvlL+
 ekOc5uPKomoVfHDOVllhQO4Wx44g+bvwfIbfV4nAk+ieXRdD3mYE6VM/GhdiJ8c=
X-Google-Smtp-Source: AGHT+IGhAjkaIbetxpu/ik2Vnfp7N01KYroFxEE+OXivoRhN8HBxB/AhR/zOvfKqcRfcKMPcinBI4g==
X-Received: by 2002:adf:f548:0:b0:33d:3abb:6db4 with SMTP id
 j8-20020adff548000000b0033d3abb6db4mr134035wrp.69.1711052408380; 
 Thu, 21 Mar 2024 13:20:08 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 ay4-20020a5d6f04000000b0033e48db23bdsm386072wrb.100.2024.03.21.13.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 13:20:07 -0700 (PDT)
Message-ID: <bb2c8cfd-5116-430d-bcf9-ba416ea333cc@linaro.org>
Date: Thu, 21 Mar 2024 20:20:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
 <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
 <CAFA6WYNHkU2xp+6_+K0JoOpVrAP3ryS2zs+Q2L6Wb+TTVL+mWg@mail.gmail.com>
 <f0cf0576-bf5d-48f4-98ff-adf553d71657@linaro.org>
 <CAFA6WYMaf_vvCHdi-QGmicq4R0ejOcMPU1D63WU+Znh4+maSTA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYMaf_vvCHdi-QGmicq4R0ejOcMPU1D63WU+Znh4+maSTA@mail.gmail.com>
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

Hi Sumit,

On 06/03/2024 11:50, Sumit Garg wrote:
> On Tue, 5 Mar 2024 at 19:45, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> [trimmed CC list a bit as this is getting offtopic for the original thread]
>>
>> On 05/03/2024 13:14, Sumit Garg wrote:
>>> On Tue, 5 Mar 2024 at 18:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 05/03/2024 12:35, Sumit Garg wrote:
>>>>> Hi Caleb,
>>>>>
>>>>> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
>>>>>> all the devicetree files for a given vendor to be compiled. This is
>>>>>> useful for Qualcomm in particular as most boards are supported by a
>>>>>> single U-Boot build just provided with a different DT.
>>>>>>
>>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>> ---
>>>>>>  dts/Kconfig          | 24 ++++++++++++++++++++++++
>>>>>>  scripts/Makefile.dts | 17 ++++++++++++++++-
>>>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/dts/Kconfig b/dts/Kconfig
>>>>>> index b9b6367154ef..67d9dc489856 100644
>>>>>> --- a/dts/Kconfig
>>>>>> +++ b/dts/Kconfig
>>>>>> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>>>>>>           However, newer boards whose devicetree source files haven't landed in
>>>>>>           the dts/upstream subtree, they can override this option to have the
>>>>>>           DT build from existing U-Boot tree location instead.
>>>>>>
>>>>>> +config OF_UPSTREAM_BUILD_VENDOR
>>>>>> +       bool "Build all devicetree files for a particular vendor"
>>>>>> +       depends on OF_UPSTREAM
>>>>>> +       help
>>>>>> +         Enable building all devicetree files for a particular vendor. This
>>>>>
>>>>> Do we really want to build all the DTBs even if many of those aren't
>>>>> supported by U-Boot at all? I would have rather added Makefile targets
>>>>> for boards which really supports a single defconfig eg.
>>>>> qcom_defconfig.
>>>>
>>>> Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
>>>> targets that ought to be able to run U-Boot to some extent
>>>
>>> Have you tested U-Boot on all of them? IMO, it would be good to make
>>> people aware about supported boards via listing their DTs at least.
>>
>> Well the "ideal" goal is that every SoC in upstream is supported. All of
>> the changes I've introduced so far work towards that end, so this is
>> just another step in that direction. Obviously it's a lofty one, but I
>> see no reason to intentionally make things harder for ourselves by
>> gatekeeping what DTB files we build.
>>
>> I have additional features planned that help here, and plenty more
>> ideas... But I can confirm that most of the phones (which are pretty
>> much identical to the reference boards) do indeed "just work" provided
>> the SoC is supported.
>>
>> It makes sense to use board/qualcomm/<soc-codename>/MAINTAINERS for this
>> imo, there we can reference the specific dts files so device maintainers
>> can be CC'd if there are relevant changes when deviceree-rebasing is
>> updated.
>>
>> I would like to update the Qualcomm docs to describe the general
>> approach here and help guide new contributors. But (as is hopefully
>> obvious by this email) I'm still very much learning as I go. What do you
>> think?
> 
> I am still not convinced that we should be building all the DTBs if
> all of them aren't supported. The docs are there to help people about
> what they have built rather than the opposite being what you have
> built isn't currently supported.
> 
> However, I will let others chime in too. Maybe I am missing something.

Hi Sumit,

I guess nobody else has very strong opinions on this... I've thought on
it some more and I definitely get your concern about not having a
specific list of supported devices.

However, I think the potential for a device to be supported without
having to send any patches to U-Boot (just upstream the DTS!) is pretty
awesome... Would it be a suitable middleground to maintain a list of
supported Qualcomm devices (and features) in the documentation?

Kind regards,
> 
> -Sumit
> 
>>>
>>>>
>>>> $ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
>>>>         | wc -l
>>>> 51
>>>>
>>>
>>> qcom_defconfig currently only supports sdm845 and qcs404.
>>>
>>>> What do you mean by a "makefile target"? Like copying
>>>> arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
>>>> would be keeping it in sync, and introducing additional busywork when
>>>> porting.
>>>
>>> See following diff:
>>>
>>> diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
>>> index 9a8f6aa35846..ecc15021cb08 100644
>>> --- a/dts/upstream/src/arm64/Makefile
>>> +++ b/dts/upstream/src/arm64/Makefile
>>> @@ -2,6 +2,10 @@
>>>
>>>  include $(srctree)/scripts/Makefile.dts
>>>
>>> +dtb-$(CONFIG_ARCH_SNAPDRAGON) += qcom/sdm845-db845c.dtb \
>>> +       qcom/sdm845-samsung-starqltechn.dtb \
>>> +       qcom/qcs404-evb-4000.dtb
>>> +
>>>  targets += $(dtb-y)
>>>
>>>>
>>>> We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
>>>> compile them all on my machine, but that's only once. With incremental
>>>> builds this becomes largely irrelevant.
>>>
>>> Maybe someone cares about build time too but that's not my primary
>>> concern. We shouldn't be giving the false impression that all the DTs
>>> present in the vendor directory are supported by U-Boot.
>>>
>>> -Sumit
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
