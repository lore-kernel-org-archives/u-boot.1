Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECAFCCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B45F83AA4;
	Thu,  6 Nov 2025 00:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SIU/kEwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D08083B0D; Thu,  6 Nov 2025 00:56:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6229383A26
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AA3D840005
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762386990;
 bh=zjTepgYJF6u/f8/lxJ/t0gLJ1MFBjvfJexVSyU6wL9c=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SIU/kEwKbvKoC8SLxn2yjm0lwaw1pfKHXFCxjA1P3hkom3s3Cr6evZSq7OCSckLM5
 hJvBHuPGcstMSHcYcM2zP4ViVVTQ/2PChwPdBMLonA5MQe/U7Lx72O83Iqr4kuGB7J
 UDtsLU8xcOPfR0l2hiAHy2W9XZAMf5qr1B3z9Z9k2zF37edrf838uHaC5l47wGvybU
 WJzX4H+wyY0iKxEsTb/XWXjzVRQ42WXEyhze5wSVljrNV8eRW2RCRxNV/XWmuNIWKW
 NB47vlIsTdnBTlYsCf36M18B1xhGKYNqNHdhWBdJBfKNxjbVsQZ1aRguhFvxpueuJQ
 4v9IqoHBiYxzFk06MDN6UgAHXJH1qYWzkngCUSjEkV0IOQo5N/LDySEeIUk4GVCOgS
 vWiqvOvCY0XM08iCqtene9d7pX9+7wwCCBNGSHRRbcxgnYAsF1FZeuhr0Vq5PKd+t8
 ivMCgZKJ7vQCMd5OqD4WsDL7WL31TTLvBryeMhZsDg6UEr/aREAR/vnIZBkuGKJzF9
 4AvnUDVyvyLz/IZHZ4Gzo61mqqKyR3zMj+iLbL4HvqYxW9HlQyoRs+n9HtkfBhFvEJ
 N8fS++uD6a6AOQT5sSq13vbcURU4eXYW9cEMXDYjkvWY6lytu2RhkBwDSkLPJFkyNy
 mQJ3rkMk97t3JRi1MkQV6dC0=
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5944d7dbf84so66567e87.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 15:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762386989; x=1762991789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zjTepgYJF6u/f8/lxJ/t0gLJ1MFBjvfJexVSyU6wL9c=;
 b=Z2iXV1kQl0+PmbdFM0XRXP0DqqLKJQpK4S2U0nm6WXra4OFH0oQi3eWCdFUZkwaArJ
 N9gI755JgcIZ1ENaqbrG8C2PU4JjZCxT6yz9p7qYA0OS8NWp50EnkL1VuexzUSBGkmXM
 yXZ+OqYLRlTFNu7/1+3lmEseqpc0Lh/tzM3yCW2ScC/sRBAIleODgZGIX0iSioIRj8GV
 gkjM+gOkdxI+5QRD/z5AuEibNoWGVQoL2NwQnFeBgsG7si53lcdZSAZjhXAtljylA1C6
 O/dNT6ieDiB9ST/tstsXtYj8D+2UgLWQTl1pL7QqIROdeK8kD7dfOaCNI8iwBHyw6oGt
 wp+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXicsEpJq3NrvhYCQ9JwBKAgQyl3Dc466nI8BhdPpRdHYIYqL25rjbBAuArE8EKyMTWqLC1kyc=@lists.denx.de
X-Gm-Message-State: AOJu0YxjVHwMbBudnd0A6cYJ84JH5VxVZbXTLyItOBpP7O7hh5unWJOk
 8AXPeQxkmrgbJx4cEjgt2VuC1u6MVJJiJ+kwkaQcvdlU3sJ1WER0JH8d2vg6EW62v4RVQ8JtdOG
 Z93DkhYsJixxz646+MFd1PWoa47+4RxJPCyyw5ynkBaK6paEGlFLcCfgRZWMuDma4TuW1TtM=
X-Gm-Gg: ASbGncvGkMZ/yf/tMgq6+W8GDaTSPrUASL+uHFJQL6SXwJNRfQW/Ng39Eamy1Pbx68l
 q+91gLcYbSCooCp+cRkM7J3bw1XPGKHvEfzBWooYuegCvl1CG71DyomnAFwaPzyUNrk0VTPsZwg
 3GKEwhG5N4rfTZqWrq9r6T+jkynVaAAH3AKdaoU32EuD3uRnoBfZOWrJD8ruU7UwB8/HLbpENi5
 TDGkPUzBvqnS4pkh/wh4WtzR8XWDUXPBaK2sKMqUm6H7LXwh18DAREoTJsx67U0Eh9Q1OJEQ7tp
 kfAfU0NjitI5yQvzgWspooCn91PO81Qkdk1/F5loKF4zM8+iH+V/fxf2T9s2c0b5mH5OekQEr/N
 +d44loh+3f3UdgVvVAB43PWfa6/uxOEHHZugFUbcUjbgS
X-Received: by 2002:a05:6512:108a:b0:594:2b8e:d6bf with SMTP id
 2adb3069b0e04-59449325de9mr439232e87.12.1762386989593; 
 Wed, 05 Nov 2025 15:56:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiWcCxsKpe7rJTKxibomDTJWDDQFMCm0XFIYvBEIRFs7Sn5jyujMD5V1Tt+uPr+dOsclOjbw==
X-Received: by 2002:a05:6512:108a:b0:594:2b8e:d6bf with SMTP id
 2adb3069b0e04-59449325de9mr439227e87.12.1762386989185; 
 Wed, 05 Nov 2025 15:56:29 -0800 (PST)
Received: from [172.26.194.12] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5944a0b7718sm216415e87.55.2025.11.05.15.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 15:56:27 -0800 (PST)
Message-ID: <daec7873-a150-4538-b6a2-96142ff9c311@canonical.com>
Date: Thu, 6 Nov 2025 00:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
 <CAEUhbmVCkjyPOyYtbABqEQZYeGV5QLwMUkO9xP4obFne7PryQQ@mail.gmail.com>
 <219a1f79-8ae3-4724-bf37-a7c5902aa9fc@canonical.com>
 <20251105231028.GW6688@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105231028.GW6688@bill-the-cat>
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

On 11/6/25 00:10, Tom Rini wrote:
> On Thu, Nov 06, 2025 at 12:07:27AM +0100, Heinrich Schuchardt wrote:
>> On 11/3/25 12:07, Bin Meng wrote:
>>> On Sat, Nov 1, 2025 at 3:59 AM Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> For testing ACPI on QEMU we need a defconfig that supports acpi command
>>>> test.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    configs/qemu-riscv64_smode_acpi_defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>
>> For some tests to pass we need to increase CONFIG_CONSOLE_RECORD_OUT_SIZE.
>>
>> The sandbox uses CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000.
> 
> It's worth seeing if we should set a much larger default too, given how
> infrequently it's set:
> $ ./tools/qconfig.py -f CONFIG_CONSOLE_RECORD_OUT_SIZE
> 10 matches
> corstone1000 sandbox64 sandbox64_lwip sandbox sandbox_flattree sandbox_nocmdline sandbox_noinst sandbox_spl sandbox_vpl voyager_spl
> 

corstone1000_defconfig and voyager_spl_defconfig seem to be the only 
boards relying on the current default value. All other boards explicitly 
set higher values.

voyager_spl_defconfig is really odd: Why should 
CONFIG_CONSOLE_RECORD_OUT_SIZE_F=0x2000 be larger than 
CONFIG_CONSOLE_RECORD_OUT_SIZE=0x400?

Best regards

Heinrich

