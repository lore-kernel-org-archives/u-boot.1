Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245F0C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 14:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1618A88041;
	Tue,  5 Mar 2024 15:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UF1RggD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785FD88065; Tue,  5 Mar 2024 15:15:29 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D5887BCB
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 15:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e4c676f0aso434968f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 06:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709648127; x=1710252927; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/1o9OQ+MHfHvh523m3TNH7AVUW1OlpgmeSClKd6Vv4=;
 b=UF1RggD57ILsDrRcHGT341jAbkUJQ7ZUfzeVLcgdyNu5SiaLPLuLD+OXcywvBMqXyw
 W4sFA8P31UUmDfFIkharKHFa9P1laAR2/eCFQEuml3G+O72ExctZ2MIFDJoA7x+oFQkb
 Ba64uyLCgzzeMTn2Xp4oy/XCnnDWvOz5FbLL7EYs7aLbD4SGD65ArHq7SoiiJJ+C0H5L
 6FPwl1qszXR6l8MyLPkmWWHXGiQyUnn46eJg+9KG6PFSr/6kw1ENfcoRlADaz+RukZoK
 qATcLxcB33nZyccrWX5zGAK/pM0cVt81KQFclpg8rQ3i2cJbFoszrH4ou043+Dl5zMOR
 rwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709648127; x=1710252927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/1o9OQ+MHfHvh523m3TNH7AVUW1OlpgmeSClKd6Vv4=;
 b=PJ+7aiL3qidCtFY1TQhqgG4t/7JKSGuM9Cfjz/XhZlYiG1gYRFWOihONHGlZQEbM0I
 /529lqoOvSoNXhonaTC3sWxbLhCrdNC/beOLdDW+gLWIIvmu1YKxr0W7yYbUxuE/auCT
 PamE7JvKAZWaYw+9ecJVypy+Z2oxH0oR0pNs0UIRhphA4+XrrKRnsBclWAZ5nTe4Um0O
 qM+xBF26U7++06rWIIfs1zQLtrlZFn5d4l4aw25ouYYvCTScMyzicVrPmmZ68mTQXRKm
 cfYgPVa2vNHfvl0Ty8uWPnjO6W1xMcSA40gZlxkGOAtmIIArsDu/N3MxKDOxPE/atEqy
 3AXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+f1/j1uzHAA2Pt33D2A/QudqTT9XnQG/62Zy9Uy0KBBSTqgiwQQdoi43pm6cSg9Ltf6NT9MeWguJPmUZYFGVct3OzA==
X-Gm-Message-State: AOJu0YyYnJaB4yXl23JgDMs/QOcHDbDWLjamMWnQcXHWnJh7XLbkpzpr
 UL1LK1DJQA5smaxvaaG7okghziRQ8Xcm/HqVE/X5UF5Ye/S5R16Ni/N+bPr1aec=
X-Google-Smtp-Source: AGHT+IGnfDmS9eJn82HjMl0MAiHSJ/N6yF/xwJ9trCTy2gP9pvfNzEyUwNtUeE+Ph4eJcvDnWozQEg==
X-Received: by 2002:a05:6000:882:b0:33d:4f6d:de84 with SMTP id
 cs2-20020a056000088200b0033d4f6dde84mr8709530wrb.6.1709648126784; 
 Tue, 05 Mar 2024 06:15:26 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y10-20020adff14a000000b0033e1be7f3d8sm12734341wro.70.2024.03.05.06.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 06:15:26 -0800 (PST)
Message-ID: <f0cf0576-bf5d-48f4-98ff-adf553d71657@linaro.org>
Date: Tue, 5 Mar 2024 14:15:25 +0000
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
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYNHkU2xp+6_+K0JoOpVrAP3ryS2zs+Q2L6Wb+TTVL+mWg@mail.gmail.com>
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

[trimmed CC list a bit as this is getting offtopic for the original thread]

On 05/03/2024 13:14, Sumit Garg wrote:
> On Tue, 5 Mar 2024 at 18:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 05/03/2024 12:35, Sumit Garg wrote:
>>> Hi Caleb,
>>>
>>> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
>>>> all the devicetree files for a given vendor to be compiled. This is
>>>> useful for Qualcomm in particular as most boards are supported by a
>>>> single U-Boot build just provided with a different DT.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>  dts/Kconfig          | 24 ++++++++++++++++++++++++
>>>>  scripts/Makefile.dts | 17 ++++++++++++++++-
>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/dts/Kconfig b/dts/Kconfig
>>>> index b9b6367154ef..67d9dc489856 100644
>>>> --- a/dts/Kconfig
>>>> +++ b/dts/Kconfig
>>>> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>>>>           However, newer boards whose devicetree source files haven't landed in
>>>>           the dts/upstream subtree, they can override this option to have the
>>>>           DT build from existing U-Boot tree location instead.
>>>>
>>>> +config OF_UPSTREAM_BUILD_VENDOR
>>>> +       bool "Build all devicetree files for a particular vendor"
>>>> +       depends on OF_UPSTREAM
>>>> +       help
>>>> +         Enable building all devicetree files for a particular vendor. This
>>>
>>> Do we really want to build all the DTBs even if many of those aren't
>>> supported by U-Boot at all? I would have rather added Makefile targets
>>> for boards which really supports a single defconfig eg.
>>> qcom_defconfig.
>>
>> Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
>> targets that ought to be able to run U-Boot to some extent
> 
> Have you tested U-Boot on all of them? IMO, it would be good to make
> people aware about supported boards via listing their DTs at least.

Well the "ideal" goal is that every SoC in upstream is supported. All of
the changes I've introduced so far work towards that end, so this is
just another step in that direction. Obviously it's a lofty one, but I
see no reason to intentionally make things harder for ourselves by
gatekeeping what DTB files we build.

I have additional features planned that help here, and plenty more
ideas... But I can confirm that most of the phones (which are pretty
much identical to the reference boards) do indeed "just work" provided
the SoC is supported.

It makes sense to use board/qualcomm/<soc-codename>/MAINTAINERS for this
imo, there we can reference the specific dts files so device maintainers
can be CC'd if there are relevant changes when deviceree-rebasing is
updated.

I would like to update the Qualcomm docs to describe the general
approach here and help guide new contributors. But (as is hopefully
obvious by this email) I'm still very much learning as I go. What do you
think?
> 
>>
>> $ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
>>         | wc -l
>> 51
>>
> 
> qcom_defconfig currently only supports sdm845 and qcs404.
> 
>> What do you mean by a "makefile target"? Like copying
>> arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
>> would be keeping it in sync, and introducing additional busywork when
>> porting.
> 
> See following diff:
> 
> diff --git a/dts/upstream/src/arm64/Makefile b/dts/upstream/src/arm64/Makefile
> index 9a8f6aa35846..ecc15021cb08 100644
> --- a/dts/upstream/src/arm64/Makefile
> +++ b/dts/upstream/src/arm64/Makefile
> @@ -2,6 +2,10 @@
> 
>  include $(srctree)/scripts/Makefile.dts
> 
> +dtb-$(CONFIG_ARCH_SNAPDRAGON) += qcom/sdm845-db845c.dtb \
> +       qcom/sdm845-samsung-starqltechn.dtb \
> +       qcom/qcs404-evb-4000.dtb
> +
>  targets += $(dtb-y)
> 
>>
>> We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
>> compile them all on my machine, but that's only once. With incremental
>> builds this becomes largely irrelevant.
> 
> Maybe someone cares about build time too but that's not my primary
> concern. We shouldn't be giving the false impression that all the DTs
> present in the vendor directory are supported by U-Boot.
> 
> -Sumit

-- 
// Caleb (they/them)
