Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F0DD11183
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEE588E41;
	Sun,  3 Nov 2024 18:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LADK0U2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FDE88C53; Sun,  3 Nov 2024 18:30:25 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F6F88EAF
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A9BF3F2A8
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730655021;
 bh=QAz7atp1mb56lXYI8KS8/SPr/eYana9ua++NWEK6sT8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=LADK0U2J6PPq7HulU5hk5XEvWA/ulalozAZ71DufUvAuIp7/OeWZIp/fJWw0q9tNB
 xLQCWZl/DiwhAJjCMz41jnSgQkJ0kuQJThHxkjacmV2InYqNU52wHeKBR7zn+WzlyS
 SdPD4mDsa9NmGWnVhRDT84xhI6MhzmwOhkBGMJytOKvzb/lmQub4KwpLx0CeS9C5hw
 vRkTe/5AzPZeZsXv8n7HjQboB6HR4sKzDgUsoDAuOdCeKSUBpoqoIxvMH5lIL1RiTx
 C4O8gOraEvL6iFvDSZeDpQKdJtGvpX0rSNOHchd2B1gw79WmhCKVegsC4lI+a9gi88
 Nw+hA0HiowezQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43164f21063so20954465e9.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 09:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730655021; x=1731259821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAz7atp1mb56lXYI8KS8/SPr/eYana9ua++NWEK6sT8=;
 b=aiWXAI8wNNS0jg45adVZ9Wmyz7dliUeuktv+jQfHkqZoz5jiRfBceMV+Bp+u8ARlXS
 aIGzdq40bqk+Tz29u7INd+O8og6aclMxIQa21NZFXLvBRuhsszYSZ7kmVsBUftK/4D2w
 oinImEx8jwB2/48CLU0JwbLe5ZbQTwzGUO8b244RSLxYVSJhDxNEJh8valbCaE+iKGrr
 7bpjv29Inxj1MBeigbBhqQFUUzGhl/CKLDpgB0gNvG5cDWzXsE6JwOJgYoJA6ZhIIRIk
 ZB7gKXQc3Gwj8eVdCZYQDtRNggEqk6i6g1CZBQdR/h+S6UzO9m0g32T1NdUBBF0eLaa8
 O/ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3LRBkZ0Xj5V45MadGpUOhG3NYS0wMpE3N8c4h6F+//xpMTZrw2Vd5yTwf8GwCmJEzoU5eCqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwZDWxqIKZTzKwn8UxxN0id3Hrzg/rYq7antG8WNCnpF1iM79Os
 xNh5XxDueU1OcDO8VTwD8IrOnorM4HTac7jQlI0mvBEE9CPkQlDRel8/yu88JgCymN1SxlTSgkH
 Y/zIaTJ/Q9SBbKESgXgVPtb54fSyqfHTCk1z+3yxuuTXK5PsnAHEsSmH7AOhzH7xPrhg=
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-431bb8a01dfmr159555165e9.0.1730655020913; 
 Sun, 03 Nov 2024 09:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnO9ihi4KVveKhkSCkVMXSUnXlYYOybcWb1J6SUs+YpNWtVu23LDE8XZzBs+6q+dnKsjhKMw==
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-431bb8a01dfmr159554915e9.0.1730655020306; 
 Sun, 03 Nov 2024 09:30:20 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abdasm11187654f8f.97.2024.11.03.09.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 09:30:19 -0800 (PST)
Message-ID: <535a2657-7cc3-4a7c-a976-c5113b059b8c@canonical.com>
Date: Sun, 3 Nov 2024 18:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: enable UNIT_TEST on qemu_arm_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
 <ae7eadd9-175f-4903-b272-71bf9c862e3f@canonical.com>
 <20241103155001.GC3600562@bill-the-cat>
 <6414da69-8cb0-414c-8f6a-02f104559e4a@canonical.com>
 <20241103161239.GD3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103161239.GD3600562@bill-the-cat>
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

On 11/3/24 17:12, Tom Rini wrote:
> On Sun, Nov 03, 2024 at 04:56:40PM +0100, Heinrich Schuchardt wrote:
>> On 11/3/24 16:50, Tom Rini wrote:
>>> On Sun, Nov 03, 2024 at 04:45:41PM +0100, Heinrich Schuchardt wrote:
>>>> On 11/3/24 08:12, Heinrich Schuchardt wrote:
>>>>> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
>>>>> this in our CI because we never ran any of our C unit tests on 32-bit.
>>>>>
>>>>> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>>     configs/qemu_arm_defconfig | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>>>>> index d042aea49bb..cc4f4540fd5 100644
>>>>> --- a/configs/qemu_arm_defconfig
>>>>> +++ b/configs/qemu_arm_defconfig
>>>>> @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=y
>>>>>     CONFIG_USB_EHCI_HCD=y
>>>>>     CONFIG_USB_EHCI_PCI=y
>>>>>     CONFIG_TPM=y
>>>>> +CONFIG_UNIT_TEST=y
>>>>
>>>> Before merging this patch we also have to fix the lib_test_dynamic_uuid
>>>> which fails on 32-bit.
>>>
>>> Is it the test, or is it the UUID changes? I didn't go so far as to
>>> revert the UUID changes when I hit this on Pi 3 32b, just poked Caleb on
>>> irc.
>>>
>>
>> While on 64-bit the expected GUID is generated (both on sandbox and
>> qemu-riscv64_smode_defconfig), the generated GUID on 32-bit does not match
>> the expected value. The generated GUID should be the same irrespective of
>> the system.
>>
>> Once we have fixed 32-bit little endian, we should start testing big endian.
> 
> Right. What I mean is, did this work prior to Caleb's UUID series that
> was merged with:
> commit 35394e1ea77ba0ad971d9115bd965a2403c0e031
> Merge: 9eb0d731d800 7de51622a2cf
> Author: Tom Rini <trini@konsulko.com>
> Date:   Fri Sep 13 08:20:25 2024 -0600
> 
>      Merge tag 'efi-next-20241024' of https://source.denx.de/u-boot/custodians/u-boot-efi into n
> ext
> 
> Or has it always been wrong? To me, Patrick's report implies that it used to work.
> 

The functionality and the failing test were added by the series.

Best regards

Heinrich
