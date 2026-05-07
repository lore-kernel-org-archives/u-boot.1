Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B834BCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3452484B5D;
	Thu,  7 May 2026 19:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dTsW+WLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8036484B8D; Thu,  7 May 2026 19:19:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB61084AA5
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 19:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 886333FBFD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778174370;
 bh=7weuHFtfMPuPdadZWkiERxhhzIMl+ZLheG84xPYjL6Y=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=dTsW+WLzhfY4qXJaJWhow7ImI9SZrlaHUL0Jf4+LRbidw1FlhqmHgxOoIq3ck5c/N
 trXGSS6DgS9L88qZw3+OzDOD+RBCtj5Ys5kXinEeelq2s5ZUV0oUJ2i7+Q5BWH2K4s
 RfeZFrXJ0Rhvwm7L6MxOIRtLNqAB3YFFq88IxhEJjRg9bTr7iQXGDFh8uKXvWIpZ1Z
 fVIPNGpPbUZtRKo4niY6Ecq8oZN8xthAP+pgzDA3TTIaQaVLGJH17dHHA73f1BHZfh
 LU7IawoBYm0NporBbziC8yyoq/zg2P9Vdq9XTY6O3TQZpUnc2hD2eDQi/CFSyJqHR5
 niLn2U/wsVecPtj7gwSn56oFcL90Q3U6a7CHP487ORpj7FlFbMGmGc3unOXKfKlnII
 fF0YMbIWSGoiWmod6SHJ9PJfZkGWbsaq9+nCJhXaPs6d5uXlLMA+c4mbwR0YeAZmoK
 XickcBx0A7sbtxYIqzSS5pB3RT802tz0kn6czlJwu6/iUWJ2zsd8GyVkcz5lSe8/pg
 D1Es5sCKfh+grufbJfZtzd+SMEMwU8jZveQQgDACX4nDLnHrG8uumjNBg8Yee8aYt+
 zG8N2L6LktMjq4jek8ELERgd7otFYwqx9oOwISl4Mtp3Xnv0dQbmq1DewVnHhif4WD
 HHab00XosgpqqNU1a9Ze0ANo=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-441243ba35fso1051402f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 10:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778174370; x=1778779170;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7weuHFtfMPuPdadZWkiERxhhzIMl+ZLheG84xPYjL6Y=;
 b=QiyT3RtKujb/+WCqTwK/ZBlcqPJRKDfV/G60nzoLDqpzi4yMJs6fPVbFrbua7zyma7
 S46DGUALBPGl11N1rIJmg/T9D/NHdlw/QTJp3u3Or5LOehiRe8hzNJTpB0X+XZh7U5Wq
 upPKSFtnxgrPCytdIsdkpVLMDzhb8BYdLhLfOWbG4b+pWYMsU4vPTLpIWF4TydYzw9LD
 NMZqt11+1kRkbCD0h+bg33jg9AmTctoD7d7J7utkhiq0iMebuiEsdyR2/51TYOl0Y4g6
 Xdah5s8HZmba3MnTYjF1s11T1uJ4BHg4T1gMjGIfshrNtDFI95Yief7oIxPrLUlKNbif
 E5oQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EkrjFvwvXflXd8AMKp31vKLt759qA+gsn+SEDQRAYJjn8IJBpRFHf1HcJ9yB3quckNmxR59I=@lists.denx.de
X-Gm-Message-State: AOJu0YzzUTIxxqUBny1NGO/yyB2dlXkt77K525ql4SEgSksBcyGz230a
 ZV9r8httaF/f7j0xuM6sYpu3M4LQ2bz7qOH0F1k9fB2EUjCiAcXWoclyqBWwpCEWKwss+8R2Ru/
 KFO5GHB/EqeCI3eECjHmDkKeaUH5O0ymVf4U8meGgkhFTM35qj2+FnC9+ffCJta7+ZmQJIHk=
X-Gm-Gg: AeBDieurDMYlJyItJSIhmvim5BW1r/uUDRvLtza96mlLyumKxq38llmD0KebhVW2ITm
 /qC1/awATtLFzl+/d+3YJCP/1p2UFFePolk1zribLcVjZEHtnEpD28qRdrLqo5M8Uyu+vDjqonX
 ZGwSxiIjfffq3HqrGHK1oUM1KY5fnLm5nCtqqLAT7+hFJW+477CDgUjjq3hw5Te/b4OoB8c6W5B
 CGzz2TpXvSAfolxmrtsuucVQ/t51botmWGoaB7Z4PP1CZ9HFaLKgwRJsO+I972lpqfvxG36CN8G
 sSY0IkKxbTCJ6YjhsoxpoAaepdonXFHRLhkKxkO1nfUlBsLijf6yrT+o5REAwUF10l7Ga09v8XJ
 W+Kp+Ts368dPwC72J3EgGR9+9e7kgyc2f6gwquMoYz3kYAR2nZWzB7c3hAwsu8RHQ4IJoP0UPfA
 ==
X-Received: by 2002:a05:6000:4381:b0:441:1fa5:4577 with SMTP id
 ffacd0b85a97d-4515ce1c5b9mr14568230f8f.26.1778174370079; 
 Thu, 07 May 2026 10:19:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4381:b0:441:1fa5:4577 with SMTP id
 ffacd0b85a97d-4515ce1c5b9mr14568177f8f.26.1778174369512; 
 Thu, 07 May 2026 10:19:29 -0700 (PDT)
Received: from [10.51.4.10] ([149.11.192.252])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454128207cfsm613753f8f.1.2026.05.07.10.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:19:28 -0700 (PDT)
Message-ID: <bbbf0d5d-c98f-4be2-96b1-8d087668ddf6@canonical.com>
Date: Thu, 7 May 2026 19:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] doc: usage: cmd: reset: specify when the -edl option is
 available
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260428-doc-sysreset-qcom-v1-1-964df4ee79f9@cherry.de>
 <ba82cf35-1ee2-4407-8d25-9569577c7a47@canonical.com>
 <bef4841c-a4c7-4e6b-96cf-d8fae4abf986@cherry.de>
Content-Language: en-US
In-Reply-To: <bef4841c-a4c7-4e6b-96cf-d8fae4abf986@cherry.de>
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

On 5/7/26 16:17, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 5/1/26 11:18 AM, Heinrich Schuchardt wrote:
>> On 4/28/26 12:26, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
>>> so let's make that explicit in the boot cmd documentation.
>>>
>>> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command 
>>> documentation")
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   doc/usage/cmd/reset.rst | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
>>> index 366b17eea16..54767fea241 100644
>>> --- a/doc/usage/cmd/reset.rst
>>> +++ b/doc/usage/cmd/reset.rst
>>> @@ -23,7 +23,8 @@ DDR and peripherals, on some boards also resets 
>>> external PMIC.
>>>       Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
>>>   -edl
>>
>> All available arguments need to be specified in the synopsis section.
>>
>> The parameters -w and -edl are exclusive as both only work if they are 
>> the first argument. So maybe:
>>
>>      reset [-w|-edl]
>>
> 
> I'll follow the same syntax as in U_BOOT_CMD and have a separate line 
> for -edl.


Please, follow the synopsis syntax of Linux man-pages for our documentation.


> 
>>
>>> -    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
>>> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms 
>>> and only
>>> +    when CONFIG_SYSRESET_QCOM_PSCI=y.
>>
>> This information is incomplete. Without 
>> CONFIG_SYSRESET_CMD_RESET_ARGS=y the -edl argument will not be parsed. 
>> A configuration section to this document might be helpful.
>>
> 
> We should probably not make the -edl option available if this isn't set 
> either then, no?

Yes, Kconfig may have to be fixed.

> 
>> Should we mention that a "PSCI SYSTEM_RESET2 not supported\n" message 
>> is shown if the platform is not supported?
>>
> 
> I would be wary of documenting strings that may change. However, we can 
> say that the command will fail if the device doesn't support it.

ok

> 
>> Where will a user learn how he can use the emergency download mode? 
>> Can we add a link here? Unfortunately the EDL information seems to be 
>> dispersed over multiple documents in the U-Boot documentation:
>>
>> doc/board/qualcomm/dragonwing.rst
>> doc/board/qualcomm/iq8.rst
>> doc/board/qualcomm/rdp.rst
>>
>> Do we need a document doc/board/quallcomm/edl.rst?
>>
> 
> That would be a question for Varadarajan or Casey, I have never done 
> anything with Qualcomm devices.

Let's see what they come up with.

Best regards

Heinrich

> 
> Cheers,
> Quentin

