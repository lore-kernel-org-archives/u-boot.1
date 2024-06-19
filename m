Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C47C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 16:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8563E882DC;
	Wed, 19 Jun 2024 18:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IWzw4Tt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800718839D; Wed, 19 Jun 2024 18:45:21 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B21881C6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 18:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so16022f8f.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718815519; x=1719420319; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hH3vmyGpISvb74os0z/j+RSPA1R0T6Z3D1f20pq9hcA=;
 b=IWzw4Tt3j1Ywx+XAeDe6EBT5LTpli0Lu4HYOjVZQmhISogV75/7q+SSvbX0RalmGG8
 YE9NrAgMdzqhiOqAlE1K+rU/cAzSbCCYXPgVG35/uDipWfDXZBQ8Zt0v4c92lWj19rWw
 aFChVnCOQeYJl/jymASZ+hCy02uv2TDI6sf7x7GxFcLmkpJWI9w/KT/GNSxEDGSIt+bP
 BQTg2DYeU+D0xxUN9e/gC0yAa5ruBWikXnK4EuMt79RGVPyP40EU9jA+RREK7iaTYdzI
 HmttDi9YxERA41yF3pZk8HDC0YcIyQryMYYhzXXdLnT3yRPt0d2qwBEgYLDqyP5nrwUe
 Kblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718815519; x=1719420319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hH3vmyGpISvb74os0z/j+RSPA1R0T6Z3D1f20pq9hcA=;
 b=Q41WMBVWYp1yYeLk7CxoCo3yl3JRb4eFL8P+exJh1RoXVI+R7clIgQHOBDjLnqo3Kf
 8Fa3Yzu0tXsP1czpZNGv99FBmItWjG2Hghmi6VIUAr4JceiTSyZ5/ZKl19HrBfBEv5+Q
 MjeIJkTCuwoRsMRt1wrTu6SSmE8VtFnOXZ8+5oZeUlloSSvD9nplAEeBHPFxDPmqoB83
 GLpEeKN0SSJVclBVVitWoU+sJjQ8SgDSlwFvbBQ4t/w+ECLk+OvuJ9cfNSs26Qki6P16
 gNUKsTrx/YPeLj/W87DOChm24rPAsGGPgAHqaNXHJ4/cIzEQ+wwR+QXmwr4+7G66kS8J
 irdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBc9IPLYh/bgnml5Ulf7zv+YEzlMzga583hEhLHZ0wIeBW9Vgv5KGDhij5GxGs1AHFQ997u3NkNkSluHqC0kpgPi0tNg==
X-Gm-Message-State: AOJu0Yy7lufRrFvqFN8/QNbkaVqFjdyHGhZVFx6nS6lRKcDHhQi6M1wo
 UpUQoEUh5fpxkgDCJcQEq6Sj7D5lIcI2FMTGkrIvfvmiIVZVK9vWQ/f8kPXfSCk=
X-Google-Smtp-Source: AGHT+IFW/eRUcaYWM0a97ZSaSoP/ks+qWIzC1P8nbCGubOXQHthoLeRd1vjcNbIcO/7QlTOkSJSumQ==
X-Received: by 2002:a5d:52ca:0:b0:35f:1e44:803b with SMTP id
 ffacd0b85a97d-3609eaa9782mr4901305f8f.35.1718815518662; 
 Wed, 19 Jun 2024 09:45:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9?
 ([2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-423b9b5711fsm142080065e9.42.2024.06.19.09.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 09:45:18 -0700 (PDT)
Message-ID: <af85bb6a-dd22-4af2-ac68-394044c54644@linaro.org>
Date: Wed, 19 Jun 2024 18:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <20240618202123.GW68077@bill-the-cat>
 <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
 <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
 <20240619150744.GA68077@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240619150744.GA68077@bill-the-cat>
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



On 6/19/24 17:07, Tom Rini wrote:
> On Wed, Jun 19, 2024 at 04:47:08PM +0200, Jerome Forissier wrote:
>>
>>
>> On 6/19/24 09:24, Ilias Apalodimas wrote:
>>> Hi Tom
>>>
>>> On Tue, 18 Jun 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:
>>>>
>>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>>> reasons for doing so are:
>>>>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>>>>> has some additional lwIP and Mbed TLS patches to do so. With that it
>>>>> becomes possible to fetch and launch a distro installer such as Debian
>>>>> etc. using a secure, authenticated connection directly from the U-Boot
>>>>> shell. Several use cases:
>>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>>> binary with a different one)
>>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>>> image as it is being downloaded
>>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>>> (this is becoming more and more common on the Internet these days)
>>>>> - Possibly benefit from additional features implemented in lwIP
>>>>> - Less code to maintain in U-Boot
>>>>
>>>> So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally):
>>>> ========================================== FAILURES ===========================================
>>>> ___________________________________ test_efi_helloworld_net ___________________________________
>>>> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>>>>     assert expected_text in output
>>>> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
>>>> ------------------------------------ Captured stdout call -------------------------------------
>>>> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
>>>> Using smsc95xx_eth device
>>>> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
>>>> Filename 'EFI/arm64/helloworld.efi'.
>>>> Load address: 0x200000
>>>> Loading:
>>>> Bytes transferred = 4528 (11b0 hex)
>>>> U-Boot> U-Boot> crc32 200000 $filesize
>>>> CRC32 for 00200000 ... 002011af ==> 2b466005
>>>> U-Boot> U-Boot> bootefi 200000
>>>> No UEFI binary known at 200000
>>>> U-Boot>
>>>> =================================== short test summary info ===================================
>>>> If I disable that test, it moves on to failing the same exact way for
>>>> grub. If I disable the grub test too. After that, oh, a bunch of other
>>>> tests get skipped because CMD_NET and similar aren't enabled now, and
>>>> the tests are wrong. I'll post that as another patch by itself. After
>>>> correcting for that, we're seemingly noticeably slower as I need to
>>>> increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
>>>> testing. We no longer have the estimated speed message, so I can't as
>>>> easily say how much slower it is. After increasing the timeout, the
>>>> kernel boot test does work.
>>>>
>>>> I can note that normally it takes ~18ms to get a dhcp reply, but with
>>>> lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
>>>> (which, not great) but if that has a similar level of slowdown, could
>>>> well explain it.
>>>>
>>>
>>> Thanks for taking the time. We'll run the pytests before v5. That
>>> being said, my wget tests were faster with lwIP last time I checked.
>>
>> The reason for the slower TFTP is the block size. lwIP supports only the
>> default (512 bytes), while the legacy stack supports the 'blksize' option
>> and sets CONFIG_TFTP_BLOCKSIZE=1468 by default.
> 
> Ouch. Can we ask if upstream is agreeable to making that configurable
> some way, and then we utilize that? I'm not looking forward to lots of
> performance hit reports.

I tried a quick & dirty hack to hardcode the blksize option in the lwIP
stack and I can confirm I get the same speed as with the legacy
implementation or even slightly better (legacy: 822 KB/s, hacked lwIP:
843 KB/s, upstream lwIP: 343 KB/s). That's on QEMU with py3tftp running on
my laptop as a TFTP server. I would probably get better results with a
good TFTP server and real hardware (RPi...) but at least this shows lwIP
can be on par with the U-Boot stack.

I can consider writing a better patch for lwIP and submitting it upstream.
 
> But please note that my dhcp request/reply is also taking 10x as long,
> and in v3 it wasn't working at all? I feel like there's possibly another
> issue lurking here.

This I need to investigate more on my RPi. I'll keep you posted. Thanks
again for testing.

-- 
Jerome
