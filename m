Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC77D31769
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92AB88E74;
	Tue,  5 Nov 2024 18:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c3z6Eo8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 062F288ED9; Tue,  5 Nov 2024 18:50:28 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D25888E74
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so45408235e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730829025; x=1731433825; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+yqb9lk/7zsNvZCSBphDydiaRru8+fJhu5HFMZ6v9fQ=;
 b=c3z6Eo8JrcRxFSR7KfIysYp5vtS+hfcbM+7PB8hoYksJ6RYo5MRbmrCn1NJmqHL63t
 ax9TOMb8tF3oM+0kH312JtGUJeA/Jq2oIQd3iwtkt0HPWlL+z0X0+is0T5n7nj3OQzof
 ELplzbmQz7QxvZMp7VJ6dPd1VU+BRpzJjyZq1CQ+Q4l9bkNqnUaqh908QC4BvTinJJLI
 GyrowFv9sRFOID+Um1FawgqsWD4VROfxy4UZeWnQNNWMY2zzwPX5sFBTxhnvwlAILmmi
 lr+aWJnjjqdNqfUY/iAmL/lj1K4Pjp0gMzVcXAha0xrCkvwsXznDPk4aLxdcuVkP7jYc
 PPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730829025; x=1731433825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+yqb9lk/7zsNvZCSBphDydiaRru8+fJhu5HFMZ6v9fQ=;
 b=URXD8ylSsRTFSFvOljRMCVsSblRwY2hzqQ/X+WPyCjpmSz/rRDJCkhzq41bF2tKql9
 Yj/mD9GPWbiQ00A71fGwQFa+dsnXhbMIHTA1CpN7GKi0TABKLeHQ160QfQ8CtgYOBfIn
 AYSp/TTFGWs9dhBjDoA2W6OOvW/54951F8lDNDOMnAhGEXDOBx9BeFgT9L4IH8/GbkMl
 QWMuajHhIhOdaSXfnEbCP634/W61Ls5+IvlYQtvrlMRHCc7LBB1mxklMXcPPzs9Z/yox
 d2x+u3HoC4yYM8ehz9UuY+ga3ePXnDqBym+PcBglN7w2K8lzQ0XMYvIlg+CxjOuSR1nx
 MtpQ==
X-Gm-Message-State: AOJu0YwDd2QHWIHBRfix35rycgxVrp2DdopJIiXHkQpFJmLOTCP4moSs
 L2un4NXpvI8b2QTquX6Ip1lNBl4LziNRam+SZZ2oe5XIFfU6TqT9gvv6sa7CiGY=
X-Google-Smtp-Source: AGHT+IEwJ3IyBOhAPUAX+jS67ZuE7NU8dUiq4Ih2HQk2lHppe3iC5GNfz2SVqWgjHESoN5Bd2ugmhw==
X-Received: by 2002:a05:600c:4f56:b0:431:52c4:1069 with SMTP id
 5b1f17b1804b1-4319ac997c7mr333122255e9.8.1730829024832; 
 Tue, 05 Nov 2024 09:50:24 -0800 (PST)
Received: from [172.20.141.182] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd91093csm232576765e9.15.2024.11.05.09.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 09:50:24 -0800 (PST)
Message-ID: <7fc675b1-03fd-4a21-8897-893b36e4ef08@linaro.org>
Date: Tue, 5 Nov 2024 17:50:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wget bug report
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
 <f3b65417-d35d-49c7-95de-b1db7b283e11@linaro.org>
 <CAFLszTgh1QbrirTi_zG7upVHG7OqHxStRFFAVRCEsPqkQpAMmg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTgh1QbrirTi_zG7upVHG7OqHxStRFFAVRCEsPqkQpAMmg@mail.gmail.com>
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



On 11/5/24 15:12, Simon Glass wrote:
> Hi Jerome,
> 
> On Tue, 5 Nov 2024 at 05:12, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hello Simon,
>>
>> On 10/27/24 17:16, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> Just something I noticed earlier...when running 'ut lib' I see this
>>> failure on sandbox:
>>>
>>> test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
>>> ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)
>>
>> The reason is:
>>
>> $ make sandbox_defconfig
>> $ make -j$(nproc)
>> $ ./u-boot -c "ut lib"
>> [...]
>> Net:         eth_initialize() No ethernet found.
>>
>> I don't know how sandbox is supposed to instantiate ethernet devices?
> 
> If you try it before your changes you will see what it is supposed to
> do. There is a sandbox network device and it can be used to send and
> receive data within U-Boot itself, for testing purposes.

I tried it just before my changes but the result is the same.

$ git log --oneline -1 1ca0ddb643f
1ca0ddb643f Merge commit 'f3f86fd1fe0fb288356bff78f8a6fa2edf89e3fc' as 'lib/lwip/lwip'
$ git checkout 1ca0ddb643f^
HEAD is now at d5cab0d6adc Revert "Makefile: Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes
$ make sandbox_defconfig
$ make -j$(nproc)
#
# configuration written to .config
#
$ ./u-boot -c "ut lib"
[...]
Net:         eth_initialize() No ethernet found.
[...]
test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)


Can you give a commit SHA1 where net_test_wget() passes?

Thanks,
-- 
Jerome


>>
>>> Also, since it is testing a command and is in test/cmd it really
>>> should be in the 'cmd' test suite, not 'lib'.
>>
>> Agreed. I've posted a patch for that:
>> https://lore.kernel.org/u-boot/20241105120653.99438-1-jerome.forissier@linaro.org/T/#u
> 
> Thanks.
> 
> Regards,
> Simon
