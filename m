Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FBDD11141
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C92C88E41;
	Sun,  3 Nov 2024 16:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NmGnSZJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F8D8911B; Sun,  3 Nov 2024 16:56:57 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7A788E14
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BCCB63F181
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730649414;
 bh=wY6EYHvNN+jnar4nqbOL2QbGhl8bk3/P3t9dvwHo0ag=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=NmGnSZJWErAaZ8l8cbUJBUoEnLzB8r9PYTm5tMM9jKqvBSITrdSQyvG4N1LGglCum
 wce8DpTMQESm2SlRMX6UiC6jUrrzxQBoD609SgY16LrW63822gWea15k+lCod0k1g1
 xzfjgtxEMdi6hld1Uq5l7Kv7fb50R/OWK+wTVXPK4Pdfv2e/SsYg91C4fr9S4rq7zy
 M/1coc6w2b7lg4fZ+ddwXko/i0OlqoMNXIPV5/CYQAvO3xAaDrJ08JKv+Hkee6PN7C
 VwspkvQjy6V3qMdFUvifi/apmD6D81/Q8FuzyYgGxfrsJ5n3/8lwyF+3bzFKILTfnD
 z1R+kaZhOdLqw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d47fdbbd6so1893687f8f.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730649414; x=1731254214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wY6EYHvNN+jnar4nqbOL2QbGhl8bk3/P3t9dvwHo0ag=;
 b=Fw/HOy4vcp5uHoCwE7jYvtELwFvxWDTHflcG34ztiEGv13W4CgP9jNeN1S/ZYdi5cQ
 gydYDqFJRwrD4OqUdVH8u30OKF8+LF6sosP/uJ2GH+AN/IM93o8ICLCnuniCizhSN5Td
 1Hr7DoaolOUVj9q/L/kt7skXz5BJ13jCvROf0woUfj4Wr0eyhpWKaUHlBh6W4sZUDUOa
 YlfH9h/7uEq8N3U8cBY4DSrcS830Lj7SoaNtYtFsXW/wErFHeszfFzTXOWf7XqaWMCeS
 ZcXe6qVY5KWfwkDhswSjKsmnh6Yh157L9W/ne/NM+TSL9PHI0ocSdyxg1UcC3mg2AsiP
 Xdmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUgsvsZkVjh9AAjFh36YTaDbTS8JE5f1g48D5RDIf5Fy2oCnkUQpAFpZxD6X9oqa8KeTE+uME=@lists.denx.de
X-Gm-Message-State: AOJu0YxRk2jT53wpjw+GS7sywYP3wvjcTUglVl6tFSPP5s928jh5swH2
 pQjsYPc7vLnivXZ0BEbXZZBTjUtFqJh7ZBvXhGppbSGxKcUCxdrQn80BpdvTh+SqNmFr/Umd7tT
 9Uz4THfqWKGELdRFyVdOGxQbUWFYzaJAA5cz+3WuUvxJOZWJWAb0G3Sgyz2/bYpzuLa0=
X-Received: by 2002:a05:6000:1a8e:b0:368:37ac:3f95 with SMTP id
 ffacd0b85a97d-381be7d8f8bmr11032567f8f.31.1730649414145; 
 Sun, 03 Nov 2024 07:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5YbivgUbOXFJvUBBfiXoUvNQIinCc5yQNpYAB0+RMRLyBFdffNJveW/x3jsn2hZRx8/ohrA==
X-Received: by 2002:a05:6000:1a8e:b0:368:37ac:3f95 with SMTP id
 ffacd0b85a97d-381be7d8f8bmr11032353f8f.31.1730649404381; 
 Sun, 03 Nov 2024 07:56:44 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7becsm10867453f8f.14.2024.11.03.07.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 07:56:43 -0800 (PST)
Message-ID: <6414da69-8cb0-414c-8f6a-02f104559e4a@canonical.com>
Date: Sun, 3 Nov 2024 16:56:40 +0100
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103155001.GC3600562@bill-the-cat>
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

On 11/3/24 16:50, Tom Rini wrote:
> On Sun, Nov 03, 2024 at 04:45:41PM +0100, Heinrich Schuchardt wrote:
>> On 11/3/24 08:12, Heinrich Schuchardt wrote:
>>> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
>>> this in our CI because we never ran any of our C unit tests on 32-bit.
>>>
>>> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>    configs/qemu_arm_defconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>>> index d042aea49bb..cc4f4540fd5 100644
>>> --- a/configs/qemu_arm_defconfig
>>> +++ b/configs/qemu_arm_defconfig
>>> @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=y
>>>    CONFIG_USB_EHCI_HCD=y
>>>    CONFIG_USB_EHCI_PCI=y
>>>    CONFIG_TPM=y
>>> +CONFIG_UNIT_TEST=y
>>
>> Before merging this patch we also have to fix the lib_test_dynamic_uuid
>> which fails on 32-bit.
> 
> Is it the test, or is it the UUID changes? I didn't go so far as to
> revert the UUID changes when I hit this on Pi 3 32b, just poked Caleb on
> irc.
> 

While on 64-bit the expected GUID is generated (both on sandbox and 
qemu-riscv64_smode_defconfig), the generated GUID on 32-bit does not 
match the expected value. The generated GUID should be the same 
irrespective of the system.

Once we have fixed 32-bit little endian, we should start testing big endian.

Best regards

Heinrich
