Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D2D44D4C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF27588CA2;
	Wed,  6 Nov 2024 12:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GlsXeKSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F01E88D51; Wed,  6 Nov 2024 12:03:49 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AEDF88A1C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d43a9bc03so4544368f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 03:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730891027; x=1731495827; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4zw+v3UIBBUdUqTe9cTakAlYvykTyn/HbAGCWVYQLc=;
 b=GlsXeKSwOjx4dIHLP8RaKdjOPiuLUCs5nqFh9YehskLwJleUdxTKbJgxSBEQoyl5eQ
 kZGwRU7L6ps1sNd0yNf6swGy19gVaslvRETe0dLZASwJ97+wkgKaiJ8/Gn+e8QE5ScgB
 FF3AQKLWpcdrRz7FUkRWSWHE8KEMoWlU10ygF0EDbxh8eYlM7DaIBA/S5wKNXAqKHz3O
 BSlXA2SeYyDFA+rgM8znPFBtNbqMXimx74hj90kO+644yAT1/fIBgE0s3tMK6DDPr4k0
 msznTshVPSas12DPZ40ZSnUJRZjShfgQ3BgpMfvDhZM7CEw8nfG8IYaIVaGW6cYndeeC
 8QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730891027; x=1731495827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4zw+v3UIBBUdUqTe9cTakAlYvykTyn/HbAGCWVYQLc=;
 b=MGFN5j5mOZx4HN/kNOv/DqPrpvZ8sXkCCvGw68JmtPpUjYGhnri/7Va0PDf4L5+tpR
 SNSQZFszR0Vqhfq3+O6khibDkeSsNAJoE/eRD5x8wX9u9uWXvHBfuz+PRoo6NueVn+b0
 d860sBSRG0GT2H4tdgq+ryxMYBER1tuE9JwhjvmCjO/2l4RTKstyuLSS0oty2Wr+VUhL
 xZ3Y/eihiqOJJI6psuyU0jiZCOkHc5k+/8yhA19TqK+cKuzQYIHAlulB69AoOauqLXav
 FMhu0Ymuav7PXNOg6uYdy5GwudiGjj7lnn1mxNZVbySsbdEGdTeXFohyKZ1Pd1DgURVw
 ssVQ==
X-Gm-Message-State: AOJu0YxxEMEHyCKWq8Mo8+weqMcfjT3qKj0O4HYMY7bUSD4jdz0IzTqJ
 BP5NZd5OGGk35jcY6fA+WOPbDAmbyYEuS8JiG8IIM3wSESFqeEREcEO+h5Y9xus=
X-Google-Smtp-Source: AGHT+IHcWfTvr1lRS1SVf2vjRYKeTkjgJATpDkNFuSfg8rxsKTbyL1cDOIBA6eo9QpMY6Poul59MIQ==
X-Received: by 2002:a05:6000:18a8:b0:37d:5046:571 with SMTP id
 ffacd0b85a97d-381c7a5e109mr16820155f8f.22.1730891026731; 
 Wed, 06 Nov 2024 03:03:46 -0800 (PST)
Received: from [172.20.141.182] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad6fsm18658474f8f.98.2024.11.06.03.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 03:03:46 -0800 (PST)
Message-ID: <c6a4f146-647d-4624-a59a-4a542d1c84c8@linaro.org>
Date: Wed, 6 Nov 2024 11:03:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wget bug report
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
 <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
 <CAFLszTgh1QbrirTi_zG7upVHG7OqHxStRFFAVRCEsPqkQpAMmg@mail.gmail.com>
 <7fc675b1-03fd-4a21-8897-893b36e4ef08@linaro.org>
 <c0fd90a7-86d4-4448-a6b7-d140d14061e0@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <c0fd90a7-86d4-4448-a6b7-d140d14061e0@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 11/6/24 00:03, Andrew Goodbody wrote:
> On 05/11/2024 17:50, Jerome Forissier wrote:
>>
>>
>> On 11/5/24 15:12, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> On Tue, 5 Nov 2024 at 05:12, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> Hello Simon,
>>>>
>>>> On 10/27/24 17:16, Simon Glass wrote:
>>>>> Hi Jerome,
>>>>>
>>>>> Just something I noticed earlier...when running 'ut lib' I see this
>>>>> failure on sandbox:
>>>>>
>>>>> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
>>>>> ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
>>>>
>>>> The reason is:
>>>>
>>>> $ make sandbox_defconfig
>>>> $ make -j$(nproc)
>>>> $ ./u-boot -c "ut lib"
>>>> [...]
>>>> Net:         eth_initialize() No ethernet found.
>>>>
>>>> I don't know how sandbox is supposed to instantiate ethernet devices?
>>>
>>> If you try it before your changes you will see what it is supposed to
>>> do. There is a sandbox network device and it can be used to send and
>>> receive data within U-Boot itself, for testing purposes.
>>
>> I tried it just before my changes but the result is the same.
>>
>> $ git log --oneline -1 1ca0ddb643f
>> 1ca0ddb643f Merge commit 'f3f86fd1fe0fb288356bff78f8a6fa2edf89e3fc' as 'lib/lwip/lwip'
>> $ git checkout 1ca0ddb643f^
>> HEAD is now at d5cab0d6adc Revert "Makefile: Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes
>> $ make sandbox_defconfig
>> $ make -j$(nproc)
>> #
>> # configuration written to .config
>> #
>> $ ./u-boot -c "ut lib"
>> [...]
>> Net:         eth_initialize() No ethernet found.
>> [...]
>> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
>>
>>
>> Can you give a commit SHA1 where net_test_wget() passes?
>>
>> Thanks,
> 
> Have you tried the -T parameter to the sandbox binary to load the test device tree?
> 
> $ ./u-boot -T -c "ut lib"
> 
> Works for me.

Works for me too. Simon, does that address your concerns?

Thanks,

-- 
Jerome

> 
> Andrew
