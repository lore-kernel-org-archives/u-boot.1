Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20890C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 14:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D4E8840F;
	Wed, 19 Jun 2024 16:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LmVH1SoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574448844C; Wed, 19 Jun 2024 16:47:12 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4520F87F19
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4217d808034so58797125e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718808430; x=1719413230; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L80bBHfsUg/SVDKM3md6DMk906H5BF1/2DUbFlCJb8w=;
 b=LmVH1SoTcxTwchZ2SOZkLroSJba00zlz922LGrr8BSPNu8q55Adkd8uAwaHxSEt+fW
 7JHWW0kDYq6CVqN7EnkqPEPu8sRtK5M50x79LeZ5Jlxk1twiLKfva7v51ZKb1B4fhgVn
 wtuMkKNSVGGHOrzAHZsK64Wk8LKzB0ltujIbK4C0SzOjPzNK4FWj24oYc21vjArQkrTQ
 aUobcVdujCiLwod6z8NdvCPnNb8hm+T2g1YJRwK0R962CwwC+5CpuJEwras+7gokrgT6
 YsOaEqGHaYvMCqOUAIf/Eoe8+R6f+TCXG0IBw4tpe8rkqEZx3vSKqX1vWUjmvFMh4hL0
 A4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718808430; x=1719413230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L80bBHfsUg/SVDKM3md6DMk906H5BF1/2DUbFlCJb8w=;
 b=TAVvvgiQYBhUHrc/AI5PTMvDXdBtIuJk/LVRsfR3JlPmXO8gaxC8Qc5K71AwCfxukW
 OIPV3OEvI2O75poNhBu0Kv4aqmkYL9ey8wk+aryek2vH7V8lFUP0N8Vt4VxbxBc+YFmT
 ZyoO1HD4caMol/ZLDKrAbw/PLQvbkPXUzSAPl7jTfZ8EpZqvalD2gFb+MnFc4G3seaAn
 dAlgRJxRBDQWQKlMVDjhMhYwmi+C5tJ2D+hqBbkaCbmlDyjbUYzeqPwqLvw6UtxlRvHv
 aRBUSB78GsYpWnneWqcllE9jjhIvjjdodiZmVix6/LdXDUxad4xHvWfMIIZhiH+wrwT0
 ljyQ==
X-Gm-Message-State: AOJu0YxlXGBizMsqdyBAJo5dF0M1mk5K/DLTEniA9CpZIdMspUNSJXAi
 B2yyojmz3sujixlW0fI9fpkQSWfZL6MP+VFWzLfHrcr/pPnybfq9CmrZYgC4bSS5SNRPoiOKuMH
 sewN4Lg==
X-Google-Smtp-Source: AGHT+IHk+1qou7qiTrQH1WPvctnwtv94Jv9aB8HCq7w/YYiQlAkBoAyPDPNdgfDZRyeCHeCa11E+Cw==
X-Received: by 2002:a05:6000:d90:b0:360:7f96:decc with SMTP id
 ffacd0b85a97d-36319a85a84mr2077451f8f.62.1718808429663; 
 Wed, 19 Jun 2024 07:47:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9?
 ([2a01:e0a:3cb:7bb0:b7e0:cc1c:dce0:48f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36387d9b812sm2005381f8f.26.2024.06.19.07.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 07:47:09 -0700 (PDT)
Message-ID: <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
Date: Wed, 19 Jun 2024 16:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <20240618202123.GW68077@bill-the-cat>
 <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
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



On 6/19/24 09:24, Ilias Apalodimas wrote:
> Hi Tom
> 
> On Tue, 18 Jun 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:
>>
>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>> stack [2] [3] as an alternative to the current implementation in net/,
>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>> reasons for doing so are:
>>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>>> has some additional lwIP and Mbed TLS patches to do so. With that it
>>> becomes possible to fetch and launch a distro installer such as Debian
>>> etc. using a secure, authenticated connection directly from the U-Boot
>>> shell. Several use cases:
>>>   * Authentication: prevent MITM attack (third party replacing the
>>> binary with a different one)
>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>> image as it is being downloaded
>>>   * Allow connection to servers that do not support plain HTTP anymore
>>> (this is becoming more and more common on the Internet these days)
>>> - Possibly benefit from additional features implemented in lwIP
>>> - Less code to maintain in U-Boot
>>
>> So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally):
>> ========================================== FAILURES ===========================================
>> ___________________________________ test_efi_helloworld_net ___________________________________
>> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>>     assert expected_text in output
>> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
>> ------------------------------------ Captured stdout call -------------------------------------
>> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
>> Using smsc95xx_eth device
>> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
>> Filename 'EFI/arm64/helloworld.efi'.
>> Load address: 0x200000
>> Loading:
>> Bytes transferred = 4528 (11b0 hex)
>> U-Boot> U-Boot> crc32 200000 $filesize
>> CRC32 for 00200000 ... 002011af ==> 2b466005
>> U-Boot> U-Boot> bootefi 200000
>> No UEFI binary known at 200000
>> U-Boot>
>> =================================== short test summary info ===================================
>> If I disable that test, it moves on to failing the same exact way for
>> grub. If I disable the grub test too. After that, oh, a bunch of other
>> tests get skipped because CMD_NET and similar aren't enabled now, and
>> the tests are wrong. I'll post that as another patch by itself. After
>> correcting for that, we're seemingly noticeably slower as I need to
>> increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
>> testing. We no longer have the estimated speed message, so I can't as
>> easily say how much slower it is. After increasing the timeout, the
>> kernel boot test does work.
>>
>> I can note that normally it takes ~18ms to get a dhcp reply, but with
>> lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
>> (which, not great) but if that has a similar level of slowdown, could
>> well explain it.
>>
> 
> Thanks for taking the time. We'll run the pytests before v5. That
> being said, my wget tests were faster with lwIP last time I checked.

The reason for the slower TFTP is the block size. lwIP supports only the
default (512 bytes), while the legacy stack supports the 'blksize' option
and sets CONFIG_TFTP_BLOCKSIZE=1468 by default.

-- 
Jerome
