Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C945C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 09:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DBB81F0B;
	Fri, 25 Apr 2025 11:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GOLgNPCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1850A81F0D; Fri, 25 Apr 2025 11:34:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8706481E72
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04DC13F13F
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745573665;
 bh=gEeHZ9Efk3Y6bIxqTUU2KgpSCcAKy9TPYLGWYLbsHV8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GOLgNPCART6c6Nzfipm0l8c0iLd5Vegjs89FCGp3jO+5qvX3YjH0+200g9os3n6kk
 ys9U7NgC/jlQbsnLqnwjog499lZt3DwOaogupoKjL6E1zilAposHPhAj6Ohh50htax
 4YHCkW1GUENHVAf0d5wzxUu88KPOXWU4ml4t3+5K54EBd7E1Lh467wq/G2VAqacHDb
 p46CrPbhjw/Pg5Eq7TqXT6zw4+CNLnyJ8PLvaaZZVqCnugbtX5UjMae0Wsj3xMJimf
 /bQPU7S9KR+PkKN+FnRHcDhuOGHXP1QFC5wRU/5FXYWXWjc2a632grgg+PLJCW1mIW
 6e3Nvjc32vBxg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so10168525e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745573664; x=1746178464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEeHZ9Efk3Y6bIxqTUU2KgpSCcAKy9TPYLGWYLbsHV8=;
 b=nSnvPoTuIipQGX2cFE7KlKPYlYSSB/wodpYuXybXm1FTFo8WHDQrO2vPairllm4O5v
 Nq/a/M0oIo4O+J6VB/0RE92Dz8cdQOjewUPDdAFxI8cKzx8jbn1AltNoOIpTzMpWhD9+
 1dnvuJ4qfnpQOI8dE+9QFdbliVQQpn34b51qY8R4vCW6+slxPR0Z6r3XtC8HK3MEdlPy
 veKG/fYlTS7GpyvzsPgxQMSUdJbCINnBWV2ZVw/xIJUC0vLQvjsIv4+n8YGAn/jkOJYP
 Az6PV0KMYU4EwaPvCjJTO/le7hwyi5rlP8KwddD1FFtIiPUbxL/lS8PhNkZNGGkrJBYY
 MF0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVbO6KB9SAHmP9sQTaXHGZPE1XFW6l6GFGX0vuV2JHB46vP9fHPx3cdDmXcoa5o3URruqUkck=@lists.denx.de
X-Gm-Message-State: AOJu0YxJAP6KmNlR721ITOjOdB+DwNkgMAQIcDfEgHR48gRicXol8ObM
 uDxYzNDYqzsQdhycjsJNjiCefLP6cXef3pOZJwQIS7ZkfJ5AlvpBzNC9rNuro60IvHxq60yWnfF
 i//sneEPcrf6EBR5+fhDn2rhqM3fMU0Umt0ExVD66jvKPtzt4iQEecJDjeGpPtLUYEp0=
X-Gm-Gg: ASbGncvaYJKXCZAXRbSfGf/OhL4GG5S5Ukk95vOgbAwNpQ+sgBfrZ4/rNL7yPWG9dUv
 iZStDEyCPs4j+1u0HcUNpV+CLUMkk7qRfgZFzsar64blohg/hSPASZPPIhUiBu6gMCRGwPhpASW
 PPPZTSbzslynKFS7nBG26etMMK40TnEEmaEQhqKhEsu5PyOFdfP5mjeht06ykuHwO1VVM04+gCP
 fLHuGWsFnRVzNYm6gJnNh0PCEexT5xYg+kEY10hnkba6QWhfR0KXPxLYLmiuZqjG49wp9h8jA34
 g5g+2c22omrxjQi+R1Ejn5S8h5hDItVCj49bn9RdrUCK7DOo2+9KbwAbG7xTSqV7W9FfxpVXSD4
 =
X-Received: by 2002:a05:6000:400e:b0:399:71d4:b8 with SMTP id
 ffacd0b85a97d-3a074e1dc8emr1082998f8f.23.1745573664018; 
 Fri, 25 Apr 2025 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUwDCM6EihfgzDlh9tAG8LBC3xer3EJr40+Xpo2c5npo9bgLeLLIMGFlsjHyvmG8HRqTtLQ==
X-Received: by 2002:a05:6000:400e:b0:399:71d4:b8 with SMTP id
 ffacd0b85a97d-3a074e1dc8emr1082973f8f.23.1745573663568; 
 Fri, 25 Apr 2025 02:34:23 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:c4b:4d27:cbb1:25f8:4ee2?
 ([2a02:3035:6e0:c4b:4d27:cbb1:25f8:4ee2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46538sm1795147f8f.64.2025.04.25.02.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:34:22 -0700 (PDT)
Message-ID: <ee1dc76c-1084-492d-8f88-fb0a2d96504c@canonical.com>
Date: Fri, 25 Apr 2025 11:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] doc: add DeepComputing FML13V01 documentation
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: dmoo_dv@protonmail.com, hal.feng@starfivetech.com, mbrugger@suse.com,
 minda.chen@starfivetech.com, patrice.chotard@foss.st.com,
 rick@andestech.com, schwab@suse.de, sjg@chromium.org, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, ycliang@andestech.com,
 e@freeshell.de
References: <e5e68920-cfa4-48f0-ba3a-301cf30c5eef@freeshell.de>
 <AM7P189MB1009AB369E6C8918ECE69FFBE3842@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <AM7P189MB1009AB369E6C8918ECE69FFBE3842@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
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

On 25.04.25 09:38, Maud Spierings wrote:
> On 4/24/25 13:26, E Shattow wrote:
>> Overall I think this patch is acceptable as-is and I'll be willing to
>> make a later series with my suggestions; it's documentation so it is
>> never really completed, I think, and I spend an hour or two editing then
>> decide that what I want to do is its own other series. None of the what
>> I'd like to suggest here should delay a PR for this series.
>>
>> On 4/24/25 05:13, Heinrich Schuchardt wrote:
>>> Describe building U-Boot for the board and booting.
>>>
>>> Carve out common information for JH7110 boards into an include.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
> 
> [...]
> 
>>> +Booting from SD-Card
>>> +--------------------
>>> +
>>> +The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) 
>>> from the
>>> +partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You 
>>> are free
>>> +to choose any partition number.
>>> +
>>> +With the default configuration U-Boot SPL loads the U-Boot FIT image
>>> +(u-boot.itb) from partition 2 
>>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>>> +When formatting it is recommended to use GUID
>>> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>>> +
>>> +Booting from eMMC
>>> +-----------------
>>> +
>>> +The device boot ROM tries to load U-Boot SPL (u-boot- 
>>> spl.bin.normal.out) from
>>> +sector 0 of the eMMC's main hardware partition. But this conflicts 
>>> with GPT
>>> +partitioning. Fortunately eMMC can alternatively load U-Boot SPL 
>>> from a backup
>>> +position.
>>> +
>>> +For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048 
>>> (position
>>> +0x100000) write the following bytes to the eMMC device after GPT 
>>> partitioning:
>>> +
>>> +======= ========================
>>> +Address Bytes
>>> +======= ========================
>>> +0x0000  40 02 00 00  00 00 10 00
>>> +0x0290  40 02 00 00  00 00 10 00
>>> +======= ========================
>>> +
>>> +With the default configuration U-Boot SPL loads the U-Boot FIT image
>>> +(u-boot.itb) from partition 2 
>>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>>> +When formatting it is recommended to use GUID
>>> +BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>>> +
>>> +Booting from UART
>>> +-----------------
>>> +
>>> +The boot ROM supports the X-modem protocol to upload
>>> +spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
>>> +u-boot.itb via the Y-modem protocol.
>>> +
>>> +Due to restrictions of the boot ROM not all X-modem implementations are
>>> +compatible. The package tio (https://github.com/tio/tio) has been 
>>> found to be
>>> +usable.
>>
>> JH7110 Boot User Guide says "Since document release 1.2, boot from SD
>> Card or eMMC is no longer recommended. But to maintain the code
>> structure, the following SD/eMMC boot address allocations are modified
>> as "reserved". Be aware of this change when designing your device based
>> on JH7110." [1]
>>
>> 1:https://doc-en.rvspace.org/VisionFive2/Developer_Guide/ 
>> JH7110_Boot_UG.pdf
>>
>> So this is important we preserve documentation how SD-card and eMMC Boot
>> source modes can be prepared that are since dropped from official
>> documentation. Yet on my patch for bootph-pre-ram device-tree hints to
>> LKML there is Hal (StarFive) and some other people that want this
>> functionality of SD-card and eMMC boot to remain working in U-Boot even
>> though it's recommended against and dropped from official StarFive
>> documentation.
> 
> Can confirm that I would like this functionality to stay, as I've used 
> it a couple of times already on the fml13v01 board specifically to test 
> firmware before flashing it to spi flash.

The functionality is in the Boot ROM. So unless somebody changes the 
lithography mask it won't change.

> 
> I believe it is actually the default boot mode selected by deepcomputing 
> on new boards, but don't quote me on that.

The fml13v01 comes without installed eMMC. My board came with U-Boot on 
SPI flash.

> 
> I have only confirmed the sd card to work though, since my eMMC is my 
> main drive and is already full of efi/bootfs/rootfs.
> 
> I should try that uart booting at some point, I already use tio. Would 
> love to see a more detailed how to on it. I guess set to uart, then 
> ctrl+t x and then just send the spl, then ctrl+t x to send the FIT?

Ctrl+t x to send u-boot-spl.bin.normal.out.
Ctrl+t y to send u-boot.itb. We use Y-Modem at that stage.

https://docs.u-boot.org/en/v2025.01/board/starfive/milk-v_mars_cm.html
had this well described.

We can add in more detail again after this series.

Best regards

Heinrich

> 
> Kind regards,
> Maud
> 
>> I don't know, which is it? This appears to be an academic exercise to
>> make those deprecated boot modes working. It certainly belongs in
>> jh7110_common.rst as something interesting the hardware may be capable
>> of, but not as the recommended standard operating procedure.
>>
>> @ Hal can you describe what the JH7110 boot code is doing for SD-card
>> and eMMC Boot modes? What magic numbers and logic is this process? If
>> you want these boot modes to be functional then please help with the
>> documentation here that is now deleted from StarFive officially.
>>
>> With that,
>>
>> Reviewed-by: E Shattow <e@freeshell.de>

