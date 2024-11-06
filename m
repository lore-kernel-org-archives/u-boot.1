Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83195D40D08
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 00:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F7A88E69;
	Wed,  6 Nov 2024 01:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q1lbfm2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AA7A88EBB; Wed,  6 Nov 2024 01:04:00 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F7088DFE
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 01:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso776018566b.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 16:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730851438; x=1731456238; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/cl6jlZeADieBvEThVxMqpvGqALgz3KZXN1O9UPkyUo=;
 b=Q1lbfm2VP84WBNAVdRgSaCmD4p7BXAVVEGhg80cuFu68nY90gK3PeTBFZeLR/72Im7
 7bF9+NyETi6AxPo/foeV0Uhqx+xN9H4+TZdy5w2bJXxLNVXDGiBw6ojD7R5r12HWtnsS
 WASMxAEDciawnaAsbPwvXa66Bzrm07v7SD/w2Zb1F7SxSW1NTdWVCMAyU7F9JDkCh+Ry
 WfF8S9mrfU5LsEo3UdGuK8IhO9BTAG8OpoL0+gypzU5+H08aNBr1rLR9+O46OfSjndDS
 ZABGU2Crgmfgxu5T5hpZ1NowWvSntvPTdcynltz3+rLj+xJ90HUGWkFLb24pgn6G/Cuw
 RbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730851438; x=1731456238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/cl6jlZeADieBvEThVxMqpvGqALgz3KZXN1O9UPkyUo=;
 b=nBRJkk3cSLdhJrqdkMjvXrpZPb03P96AXdUHAYnXJufcjh1TQv72IgqMyey38t/8xY
 ibhaGqgzM5XugoNjrR4LMYIaNsRS6BFskr8NgvasLnL8jzq/3hvffTqy84+hnpqAPIOz
 /8P1AS4+WEn0SosxPWKzzvL/55iQoyAl7swR6zWr+qjL9C6pGBmbVbUn//lMmmcZ6ieL
 CZ56PuF71wNb0HE2Gz4USPalK9TzsHKMiB+I9N1YHG9FF1s4D7HLgI0A3m/z1OihVjOI
 tgAhNWuZD8CE6Hci+l/ApNSzq53icqb6IofR1Nv7CgHkZ5LILhSYimbd0Hn9IbDFJX3d
 o2aw==
X-Gm-Message-State: AOJu0YzTKzuJUfi9hLqHb1b1BLe5tHaNwuyld7Zy0YOjgj4eBjYlSP7f
 0G83GyIfr5ZchUTjMXVAKPJvjyzRxctNcpL1QGlieKkScHw8OMtMbQh3FLYmj9U=
X-Google-Smtp-Source: AGHT+IEAzkxBity8hPxcyoA+DTuibX3+StL2pCp7vO/6aseqy4+YJxBwnJ2f8HqjZ7RLFdA73SJ8yw==
X-Received: by 2002:a17:907:94d0:b0:a99:f3fb:f88e with SMTP id
 a640c23a62f3a-a9e50b57493mr1772498166b.41.1730851437695; 
 Tue, 05 Nov 2024 16:03:57 -0800 (PST)
Received: from [172.20.143.185] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16d59casm196101666b.49.2024.11.05.16.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 16:03:57 -0800 (PST)
Message-ID: <c0fd90a7-86d4-4448-a6b7-d140d14061e0@linaro.org>
Date: Wed, 6 Nov 2024 00:03:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wget bug report
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
 <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
 <CAFLszTgh1QbrirTi_zG7upVHG7OqHxStRFFAVRCEsPqkQpAMmg@mail.gmail.com>
 <7fc675b1-03fd-4a21-8897-893b36e4ef08@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <7fc675b1-03fd-4a21-8897-893b36e4ef08@linaro.org>
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

On 05/11/2024 17:50, Jerome Forissier wrote:
> 
> 
> On 11/5/24 15:12, Simon Glass wrote:
>> Hi Jerome,
>>
>> On Tue, 5 Nov 2024 at 05:12, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Hello Simon,
>>>
>>> On 10/27/24 17:16, Simon Glass wrote:
>>>> Hi Jerome,
>>>>
>>>> Just something I noticed earlier...when running 'ut lib' I see this
>>>> failure on sandbox:
>>>>
>>>> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
>>>> ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
>>>
>>> The reason is:
>>>
>>> $ make sandbox_defconfig
>>> $ make -j$(nproc)
>>> $ ./u-boot -c "ut lib"
>>> [...]
>>> Net:         eth_initialize() No ethernet found.
>>>
>>> I don't know how sandbox is supposed to instantiate ethernet devices?
>>
>> If you try it before your changes you will see what it is supposed to
>> do. There is a sandbox network device and it can be used to send and
>> receive data within U-Boot itself, for testing purposes.
> 
> I tried it just before my changes but the result is the same.
> 
> $ git log --oneline -1 1ca0ddb643f
> 1ca0ddb643f Merge commit 'f3f86fd1fe0fb288356bff78f8a6fa2edf89e3fc' as 'lib/lwip/lwip'
> $ git checkout 1ca0ddb643f^
> HEAD is now at d5cab0d6adc Revert "Makefile: Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes
> $ make sandbox_defconfig
> $ make -j$(nproc)
> #
> # configuration written to .config
> #
> $ ./u-boot -c "ut lib"
> [...]
> Net:         eth_initialize() No ethernet found.
> [...]
> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
> 
> 
> Can you give a commit SHA1 where net_test_wget() passes?
> 
> Thanks,

Have you tried the -T parameter to the sandbox binary to load the test 
device tree?

$ ./u-boot -T -c "ut lib"

Works for me.

Andrew
