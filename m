Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDCAC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 22:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9151188AF9;
	Wed,  7 Aug 2024 00:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XrNNWg+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1481688B15; Wed,  7 Aug 2024 00:29:08 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85AA889E1
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 00:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f1870c355cso12554861fa.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722983342; x=1723588142; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XvnCNhpj2xYC6lsQUadjPRKGQvZ5FpVDVrhipdfyAHc=;
 b=XrNNWg+H4GY0gNuXkGfzH0pT8GB7M3M1WFs8RyDGi++rpAFBkBvBcUgOAvgqQ4qaPQ
 hOjhkqd2G4SjZ5K1sTuh1AAb79T9iGlN3OeE/oftl/opAUz45TV2x4TOC6j3eoDAOS2p
 1397w7A7v1L2f2wCrL5pdHqrx/vZFikOv23VonNHU6qpSQZTfhE+Y1bRiMNBj6mNMos+
 IsW9iBbb+bC0soWzYJsWSnB7/XaQ9bOfq/c2EDX5ObVWkhVhjVxbhxSLWwRccrR0ChTs
 n7k/yPYGbO+tJcbASRTMDn73k55gqe/eZPDylqzCtlgTtKKOqkx/izfEfKYkLHri9AUH
 tNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722983342; x=1723588142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XvnCNhpj2xYC6lsQUadjPRKGQvZ5FpVDVrhipdfyAHc=;
 b=HW63g2fIpXlv12no1OdpE7RuJzjjZFzUmpGWSPiDDCi+BT37Go0Eg8UUkU6Ej+VVOX
 syHXTPXh2coXCkPhw7EO80+cYPskSjisHZQmp8c/CJg9m9TuAhhqUi7Wuw2SXWnH2UhH
 bS2mTO7s/vg8p1dgtKDbD8RK4ofDoqa7n9H30XXnt8oJWKeGzkv12qplK9rErTxj39Qt
 tUqQsrj/wwBPcMqWjPGkMH4mtmTNjc8xzlixVrE+dixk7LtkGKwBL+tgvtc0HNG1qN6o
 +yT9dFHsTEAMpkhxLRhvqf9AAonXG5rLIzOqVFvMN9X4L0e5lW7SFWWJfPLZcujbH5jx
 BQaA==
X-Gm-Message-State: AOJu0Yyp6i1lBEAuC8/YOtoUrEt21aFefF2cdp07qAwA7EVHsPZeoskN
 j6j8coEPfvEfip8Gp4O+913eUY3EpreOQLRgeHy0CnuJiFQd3EOg32+i+03xias=
X-Google-Smtp-Source: AGHT+IFYZnF7I4U58MwN2Mx2r+XSF7O86Nm2CcM1feP1IMhGwMPJqyWAE2y1YL0hsSU1kUsiRwGiew==
X-Received: by 2002:a05:6512:308c:b0:52c:86de:cb61 with SMTP id
 2adb3069b0e04-530bb366700mr11667111e87.10.1722983342082; 
 Tue, 06 Aug 2024 15:29:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3c20:d905:6027:2354?
 ([2a01:e0a:3cb:7bb0:3c20:d905:6027:2354])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c801sm579615966b.59.2024.08.06.15.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 15:29:01 -0700 (PDT)
Message-ID: <2dca5cab-b96c-4661-944c-3aeb63d707ca@linaro.org>
Date: Wed, 7 Aug 2024 00:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
 <adf03f1c-cdde-4d4f-8078-59a4bf58b10d@linaro.org>
 <20240805182022.GB267004@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240805182022.GB267004@bill-the-cat>
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



On 8/5/24 20:20, Tom Rini wrote:
> On Mon, Aug 05, 2024 at 08:18:09PM +0200, Jerome Forissier wrote:
>>
>>
>> On 8/2/24 20:32, Tom Rini wrote:
>>> On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
>>>
>>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>>> stack [2] [3] as an alternative to the current implementation in net/,
>>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>>> reasons for doing so are:
>>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>>> so. With that it becomes possible to fetch and launch a distro installer
>>>> such as Debian etc. using a secure, authenticated connection directly
>>>> from the U-Boot shell. Several use cases:
>>>>   * Authentication: prevent MITM attack (third party replacing the
>>>> binary with a different one)
>>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>>> image as it is being downloaded
>>>>   * Allow connection to servers that do not support plain HTTP anymore
>>>> (this is becoming more and more common on the Internet these days)
>>>> - Possibly benefit from additional features implemented in lwIP
>>>> - Less code to maintain in U-Boot
>>>>
>>>> Prior to applying this series, the lwIP stack needs to be added as a
>>>> Git subtree with the following command:
>>>>
>>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>>
>>> On Pi 3 I'm again / still seeing:
>>> ========================================== FAILURES ===========================================
>>> ___________________________________ test_efi_helloworld_net ___________________________________
>>> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>>>     assert expected_text in output
>>> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
>>> ------------------------------------ Captured stdout call -------------------------------------
>>> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
>>> Using smsc95xx_eth device
>>> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
>>> Filename 'EFI/arm64/helloworld.efi'.
>>> Load address: 0x200000
>>> Loading: #
>>>          883.8 KiB/s
>>> done
>>> Bytes transferred = 4528 (11b0 hex)
>>> U-Boot> U-Boot> crc32 200000 $filesize
>>> crc32 for 00200000 ... 002011af ==> 2b466005
>>> U-Boot> U-Boot> bootefi 200000
>>> No UEFI binary known at 200000
>>> U-Boot>
>>> =================================== short test summary info ===================================
>>>
>>> On a configuration that works fine with the legacy network stack.
>>>
>>
>> That was caused by a missing call to efi_set_bootdev() in tftp_loop()
>> (net/lwip/tftp.c). Fixed in v8.
> 
> Thanks.
> 
>> I also fixed a similar issue with wget (net/lwip/wget.c) but I
>> noticed that the NET version of wget has the same issue:
>>
>> U-Boot> wget 200000 192.168.0.30:helloworld.efi
>> Waiting for Ethernet connection... done.
>> HTTP/1.0 200 OK
>> Packets received 13, Transfer Successful
>> Bytes transferred = 12720 (31b0 hex)
>> U-Boot> bootefi 200000
>> No UEFI binary known at 200000
>> U-Boot>
>>
>> Should I also fix it in the same way? Or did I miss something? How
>> are you supposed to boot an EFI image downloaded via wget?
> 
> A lack of tests for wget + EFI is how we got here, so thanks for finding
> the bug. For the sake of cleaner tests, can you please fix the legacy
> one as well, and add a test similar to the tftp one, but for wget?
> 

wget test added to v8.

Thanks,
-- 
Jerome
