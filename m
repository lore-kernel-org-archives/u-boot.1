Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BAECCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D3083849;
	Thu, 30 Oct 2025 17:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FkMQ9FcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C2983887; Thu, 30 Oct 2025 17:51:15 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB292836D3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429b9b6ce96so612874f8f.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761843073; x=1762447873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNUYhA5brT1R8/LQSMco33CeUq/Gwg/14smAW7GKyrg=;
 b=FkMQ9FcGLFbib0KOIA7tCSU6nnMVUW2VpGoVAsr/z1oSjAe4oPDBaIs5QvLaJDEbgb
 FXQl7sCWHJ2xNLg45R6u8FRcYfd5O749lTA1Gy8YZrGddhK/2a+t7rkn/aVPlwq65UJa
 +1/g0sSHPZICezGrW/NaFqYQo4/+0uo01ppT4jQk1ZZ2xf+Mgfl9t5GpqlA4A5nTaR4u
 dYiLuPXen7c7Ti50+1I42vkZGtzFk9SaE4a3elMhpPYEm2bLpTVFLYTIj/o1yuUHb794
 FxcYksK9unTzCZKe3IDXQNwLkOvAAS8jCcxmOAk3xwSSM3z6waQc8+DsCLK3747Zbsse
 W8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843073; x=1762447873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNUYhA5brT1R8/LQSMco33CeUq/Gwg/14smAW7GKyrg=;
 b=oLY8kp+8I/4Uc4US/eQK4vkXhWEh+WARvHKqBPabZ2D/whfCEPJx13Cg457jKJcuR4
 9arukF3DyDGe8wqgw9olW8ovLTWChZsPMv7oK0QBF773uVWF7ceds07tFkOBrUtBh0Nf
 bB9WMHzJqkaQ7EpI6Mi4ep4kcP0Il3edFmecSnxMAIX0PZeOIue2DfM+5+REr+izj7aw
 rrMjMot2kGf1Dd/rAZWTTjo4H9Dq76uq8pcU1/Vk0GwUpu6bvXmEdSSKgRQn/0cDMznO
 omMTs47GLaTCBh34+iexDsiHTvXYAxtd5rzXDvZZc1OeBHQDf5cyop16l+7B1fVvaqhz
 tJDg==
X-Gm-Message-State: AOJu0YwDkSGUFcS/8Zuc7wYf5V/JGo07K61Kei8lH8yOdsQb4OHA8qyV
 U001NX1YHBRw8cmEF34ZBkZO+Pugrv7a1Q2EQ+bDukqqA92J2pg2k6fyg3jLODKYDK7zoW8ILXi
 T+mVm
X-Gm-Gg: ASbGncto1pJauuy5k5F55o6IyFG29z1//3hD4/qHec4Ux00NjL9k1Acc5SPEbcohaiD
 j34YeTIeeYOZWSIJSa36mrljrLcrJWRF0kZZz62/th+WCIIPcqBJDkmZ5R8vGU7VEvPtPX9cFoM
 aj5MTg8CJ8yEFrkBmxRIEJKldtmQ8meGhXjsj+o3tD0JP1e7rBSb8VtvcCvL70Mcy+KWKJKbYe5
 cKNCt0I6AgV3lOQWYdFoajXu3NYRCCfL23qw9GkzsKEjqC3U+4OI/9o3MXtrrb1D4h8HRG/fQnX
 d7b7/kg2wJ6ykaul5ApfvEz9EQPR5G73eb/PzJeTPhBhTyHxUuPlyarnTWHQ27JxM+1Wph2Ifvv
 QB7kM8ZuurZ1a3pmKkduF9iHcrW88n422feo+xqu9Cu1jMnrvToTVt8uqAFkucxbp/RS0MIy3N9
 JChAskIw9ZB651Yrn55WAQVuo1eA3DPn7dV+vdua5CJ0qyG6SVBsBajiOgRhtKgLk=
X-Google-Smtp-Source: AGHT+IHPcV819eIR3D77XhsK7Ab/nuOVjJD/uTRdUDNXnMBhCy/RskgH8HG3PLBvLhR2KwA9AFniRg==
X-Received: by 2002:a05:6000:2305:b0:428:3f70:4b2 with SMTP id
 ffacd0b85a97d-429bd6e4457mr195032f8f.63.1761843073246; 
 Thu, 30 Oct 2025 09:51:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:ec33:cd66:338:ecc7?
 ([2a0a:ef40:fed:4601:ec33:cd66:338:ecc7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429b6bc5907sm5009109f8f.13.2025.10.30.09.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:51:12 -0700 (PDT)
Message-ID: <9a2a8995-e877-41ff-be40-0f83fadf91c8@linaro.org>
Date: Thu, 30 Oct 2025 16:51:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
 <176167434712.2025892.9174636336405377074.b4-ty@konsulko.com>
 <20251028192633.GH6688@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251028192633.GH6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 28/10/2025 19:26, Tom Rini wrote:
> On Tue, Oct 28, 2025 at 11:59:07AM -0600, Tom Rini wrote:
>> On Thu, 03 Jul 2025 15:40:46 +0100, Andrew Goodbody wrote:
>>
>>> In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
>>> done with the value that this calculates which is obviously not the
>>> intention of the code. This is confirmed by the code around where this
>>> function is called.
>>> Instead return the value from ERR_PTR.
>>>
>>> This issue found by Smatch.
>>>
>>> [...]
>>
>> Applied to u-boot/master, thanks!
>>
>> [1/1] clk: Return value calculated by ERR_PTR
>>        commit: 644b4650ee57c429bede77f44752cc867dac0e00
> 
> Unfortunately I missed that this caused CI failures until too late:

Oh dear, I am sorry about that. This is proving to be tricky to resolve 
as the test was relying on the broken behaviour but I am working on it. 
But in the meantime I will post a patch that fixes a couple of debug 
statements which were shown to be a problem during my debugging.

Andrew

> __________________________ test_ut[ut_dm_dm_test_clk] __________________________
> test/py/tests/test_ut.py:591: in test_ut
>      assert output.endswith('failures: 0')
> E   assert False
> E    +  where False = <built-in method endswith of str object at 0xfffede8fec30>('failures: 0')
> E    +    where <built-in method endswith of str object at 0xfffede8fec30> = "Test: clk: clk.c\r\r\ntest/dm/clk.c:92, dm_test_clk(): 321 == sandbox_clk_test_get_rate(dev_test, SANDBOX_CLK_TEST_ID...clk' failed 2 times\r\r\nTests run: 1, 12 ms, average: 12 ms, failures: 2\r\r\nexit not allowed from main input shell.".endswith
> ----------------------------- Captured stdout call -----------------------------
> => ut dm dm_test_clk
> Test: clk: clk.c
> test/dm/clk.c:92, dm_test_clk(): 321 == sandbox_clk_test_get_rate(dev_test, SANDBOX_CLK_TEST_ID_DEVM1): Expected 0x141 (321), got 0x0 (0)
> Test: clk: clk.c (flat tree)
> test/dm/clk.c:92, dm_test_clk(): 321 == sandbox_clk_test_get_rate(dev_test, SANDBOX_CLK_TEST_ID_DEVM1): Expected 0x141 (321), got 0x0 (0)
> Test 'clk' failed 2 times
> Tests run: 1, 12 ms, average: 12 ms, failures: 2
> exit not allowed from main input shell.
> =>
> _______________________ test_ut[ut_dm_dm_test_clk_base] ________________________
> test/py/tests/test_ut.py:591: in test_ut
>      assert output.endswith('failures: 0')
> E   assert False
> E    +  where False = <built-in method endswith of str object at 0xaaab788cbea0>('failures: 0')
> E    +    where <built-in method endswith of str object at 0xaaab788cbea0> = 'Test: clk_base: clk.c\r\r\ntest/dm/clk.c:44, dm_test_clk_base(): 0 == uclass_get_device_by_name(UCLASS_MISC, "clk-tes...base\' failed 2 times\r\r\nTests run: 1, 3 ms, average: 3 ms, failures: 2\r\r\nexit not allowed from main input shell.'.endswith
> ---------------------------- Captured stdout setup -----------------------------
> /u-boot
> Bloblist at 100 not found (err=-2)
> U-Boot 2026.01-rc1-00013-gf12ca3e2b81b (Oct 28 2025 - 18:45:26 +0000)
> Reset Status: WARM Reset Status: COLD
> Model: sandbox
> DRAM:  256 MiB
> using memory 0x1988c000-0x1f88e000 for malloc()
> Core:  266 devices, 94 uclasses, devicetree: board
> WDT:   Not starting wdt-gpio-toggle
> WDT:   Not starting wdt-gpio-level
> WDT:   Not starting wdt@0
> NAND:  4100 MiB
> MMC:   mmc2: 2 (SD), mmc1: 1 (SD), mmc0: 0 (SD)
> Loading Environment from nowhere... OK
> In:    serial,cros-ec-keyb,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Model: sandbox
> Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6: eth@10004000, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0, eth7: lan1
> Hit any key to stop autoboot:  0
> =>
> ----------------------------- Captured stdout call -----------------------------
> => ut dm dm_test_clk_base
> Test: clk_base: clk.c
> test/dm/clk.c:44, dm_test_clk_base(): 0 == uclass_get_device_by_name(UCLASS_MISC, "clk-test4", &dev): Expected 0x0 (0), got 0xfffffffe (-2)
> Test: clk_base: clk.c (flat tree)
> test/dm/clk.c:44, dm_test_clk_base(): 0 == uclass_get_device_by_name(UCLASS_MISC, "clk-test4", &dev): Expected 0x0 (0), got 0xfffffffe (-2)
> Test 'clk_base' failed 2 times
> Tests run: 1, 3 ms, average: 3 ms, failures: 2
> exit not allowed from main input shell.
> =>
> 
> So I will be pushing a revert in a moment.
> 

