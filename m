Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA2FCCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 07:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBAB83655;
	Fri, 17 Oct 2025 09:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tHyTWlE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A55083710; Fri, 17 Oct 2025 09:12:25 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48EE83631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 09:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AFEC3F72D
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760685142;
 bh=Vc7PHHXr0+qy7WEa2gG3uSfvUnZhTBG/Js6NtsCW/nI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tHyTWlE9TQwYqQLS24kZ1VUvaoRrGwldExQYsEHAFdrHwcbp3GnESE5cWEhL7swiy
 2abt6mt66xfggmNpp0zeOiJqa2xBAgT1uFjAZt4YftVJMmD96ljlSDT0MMCOOhes26
 SOFZ4KeU5+k4Dg0ejo9rBoSctyAzpP1TA8RilONCdFRplCZooU9Sb4cbcnKFemk+SC
 BCtJujFvKmcH9CF0qCBfe8JG71cu3iAVTWQoePlxUZZzAzm0aJ4DJkFtyzMTcnNcXd
 IeZV3zQYnzqyoaxCEA2+vGRmgCOOfPcztKEW7QfYIPE6/cMZKB7qhLJVz5FKYKFbqW
 XuhwAROyySVmRdijtD6ADzkyUFCeEuHQVxUU8PdCOZ3y4uWZA9aHbchCFs0hagKqwa
 ur3vFQBwPzN6KtfKxTq4kUi4My7cAbffL79Q1jaSab5viNE/udh5DY/IPZYG5CPPr5
 KNYSnJ1Kfqi67zlg20r5I8SXLsxrT8TL+x9MN9Xl0Cs7qoMC7eGeLfc3jwCZwW6BJL
 NoioXincOEb2D42d7inBgxNUAhe0Zit0K5D7Zj+89dck3IJethmQgEcve0f4wikNC2
 hUzNPrKUX9ESgaDNl3pwPhiv5yMjB34201pHhNhpQ9wmK6Zn1v1HE1VjOvJglpOilp
 Si1qg9+8v2u1MoE5EOi0pXdE=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so29334115e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 00:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760685142; x=1761289942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc7PHHXr0+qy7WEa2gG3uSfvUnZhTBG/Js6NtsCW/nI=;
 b=LdVHxKP4xk0ygaFKxAhL3iLMvatxV/MPjqtXAs/eBDIryo7BzmkVpsEs7vn7axV77b
 FPPiMRqAw9STbczO2O98+TQxPoiZpVpSnREx0LEMNyiCd+4U9UixuANEn09LbG2hEP2t
 F3Cjn8ZXZWZqZ+6YBpvynAc2Bb1RA/xSuJyVSIs8RfPxFzDFPLg9UzwPQZiOmdjxTWQK
 TfNLtxFts2UX9X2JZVcMs+HxJxiQvAQegbHCYYMcsXnSvlo3rxyeeiX65kJ8jny3V+1M
 +vfQHXN8oBH6Ag9ZmczuJIwhOzi3je/dSUa8PWbvpt4GUEf7VCwD4g/AuHOvyy+cht8A
 3DwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwjjyA+1RRSDgy+mTfnJm0VdePtVmUVz9b0/2Wzpuc9EEn5t8v8ZJdqu2Sf+rEb06DfARlAZI=@lists.denx.de
X-Gm-Message-State: AOJu0YyAil7Y/rA2tsv488ZsnBH91lCKhZ8Y7hwKTAkj0xN3ChvPz0mg
 d7XaEheQj4aOJQMF/4amhXYN9X2uFt1VDNwA6+fo526GnfBLO94Z/CARFAH/zkoluSWqi140M9C
 7Qrs77NT1T9RepeEPWB74Ctxe1ytHiGARG+Mam+haLejd36a9AgeXrMU90xcNfyDKUh5xByI=
X-Gm-Gg: ASbGncvomVgxhtHi4mJwenURNxcn6pR8RU/zdFYxp62naJKL5EOLIacchqbDKkdtdp2
 osnzZKVSGc1pS96ikUl92RTs3PVcHmXmqKu1WMPoKujxmNSqTc//rFRlt/s5zoMoxLTxOLUL3Pc
 rhqho15UuBXcbqea+5ZpCC8tBYfI0VxVfHizgthXapP38ADdceXk2G7ppvXwgTIJmDy04et2DI7
 zfVNkc2jtdhoanDHYMB9Kk+iF1WHG5R4xkQZAVr5KD3S9MnqbBrKcYBYoXscIYT+L4fA0MubNBe
 MB9Wf1TcH3cBocLV+ZDrFFo2iDO0hrtwB1chQUQdgsrs+d6jKStkvfJAusk1/geKX9s/WZ2EGf9
 qccHCSnKsu9MwPPwfE19sjwm4QeP5sxTAoL74CxW6gawPM/Ooh+zSHLQ/YYwqBP2ISkdb+RLL
X-Received: by 2002:a05:600c:3104:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-471178a5c6emr17857795e9.18.1760685141671; 
 Fri, 17 Oct 2025 00:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbRBKSkT4pwimecBdVszRARMynDrjCINAy1+cbW2OqxXiiPNYSvDQVtffb3kD34qAKESRRXA==
X-Received: by 2002:a05:600c:3104:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-471178a5c6emr17857565e9.18.1760685141162; 
 Fri, 17 Oct 2025 00:12:21 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144238easm67463405e9.4.2025.10.17.00.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 00:12:20 -0700 (PDT)
Message-ID: <1d44df95-a7fc-4217-9f22-788c70fe38bc@canonical.com>
Date: Fri, 17 Oct 2025 09:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
To: Yao Zi <ziyao@disroot.org>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, E Shattow <e@freeshell.de>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
 <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com> <aPGc12v2H5sCZNMi@pie>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aPGc12v2H5sCZNMi@pie>
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

On 10/17/25 03:33, Yao Zi wrote:
> On Thu, Oct 16, 2025 at 07:04:48PM +0200, Heinrich Schuchardt wrote:
>> On 10/16/25 18:58, Heinrich Schuchardt wrote:
>>> Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
>>> synchronization in start.S") changed the hart synchronization in start.S.
>>> It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
>>> use. If the macro evaluates to true the old behavior is maintained.
>>>
>>> The macro evaluates to false for SPL builds which was unintended. Use
>>> IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
>>>
>>> This fixes a boot failure on StarFive JH7110 based boards.
>>>
>>> Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
>>> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

e6646b35f410 ("Revert "riscv: Add a Zalrsc-only alternative for 
synchronization in start.S"") has been merged this night. Hence the 
current patch is superseded.

ibex-ast2700_defconfig for which the original patch was developed does 
not build w/ or w/o the revert ("undefined reference to `__ashldi3'") on 
Ubuntu 25.10 using GCC 15.2.

>>> ---
> 
> Hi Heinrich,
> 
> Thanks for sending the patch!
> 
>>
>> Hello Yao,
>>
>> It would be worthwhile to understand why your new method does not work on
>> the StarFive VisionFive 2. I only addressed the Kconfig issue. But I suspect
>> there is something broken in the alternative pass.
> 
> A possible reason is that, on JH7110 not all the cores support LR/SC
> instructions: the S7 small core always raises access exception for it
> since the implementation of LR/SC requires data cache to present, while
> S7 doesn't have one.

@Hal, @Minda
does the S7 core enter U-Boot SPL at all?

Best regards

Heinrich

> 
> This is documented in SiFive U74-MC Core Complex Manual,
> 
>> Load-reserved (LR) and store-conditional (SC) instructions are special
>> atomic instructions that are only supported in data cacheable regions.
>> As the S7 core does not have a data cache, the LR and SC instructions
>> will always generate a precise access exception.[1]
> 
> As S7 also takes part in the initial HART lottery, usage of LR/SC
> instructions might just crash its boot process with exception.
> 
> However I could only confirm the idea days later when I have access to
> a JH7110 board. Since earlier Tom has merged the patch[2] that reverts
> the problematic commit, do you think it's better to wait for me to
> confirm the cause and write v3 of the patch, instead of fixing it up
> now? I'll carry your Co-developed-by tag in v3 if you're okay with this.
> 
>> Best regards
>>
>> Heinrich
> 
> Best regards,
> Yao Zi
> 
> [1]: https://starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
> (Chapter 3.6, Atomic Memory Operations)
> [2]: https://lore.kernel.org/u-boot/176063629917.212270.1145034876136991424.b4-ty@konsulko.com/

