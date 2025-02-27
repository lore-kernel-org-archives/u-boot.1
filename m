Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3685C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34266812D8;
	Thu, 27 Feb 2025 18:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hsR3Az56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901FC81420; Thu, 27 Feb 2025 18:30:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC07812C0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso185686166b.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740677426; x=1741282226; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJTsaJIiHf1tKXLnoL+UYILvkUrYTE/rZIDUVCPYyXM=;
 b=hsR3Az562rk2gDhZQrMdBXZQBSemXRJD8z7EAUYW1mqqkTN8ddH1fPshQOO5kekZvm
 577BcI2ITCe044sHoDdwQ3lB/M/Dog9YvZLgKlT7lyN1/ejBFMXHyWjGn7MUHBb9C4rt
 wnBVMjKlqNUe1BdMCxXdDSYtbGF3/QV+CWTvV3z6mMzNptn2gpOCZ1DGrBcdTzVEI1dA
 hdHnF7sn/H6JI3XipK9iqNSaTGC7AgjYlUh0TMCvq+382Tr/m5HMcja6fPzQgf/r8xUt
 21A0Ng8WTb2X/PGYSkbc65OM4tiPItr3qsWTIrcyHzR45hhcmdkTAVpHiM4Jepe/NsPV
 0I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740677426; x=1741282226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJTsaJIiHf1tKXLnoL+UYILvkUrYTE/rZIDUVCPYyXM=;
 b=sShIcyAeUj6F+eMm2092POhdWbuPruqdZR4IptFnTrRQ7ZyDHM6okG6p0aomV6LfcW
 VLsY3IzHKGHzZ7KBP6tQi0jORP57or9s/9wJ/TtggFhC3DxWSkEEWk1kuOIlDhrPb5cv
 jNEYPTpykP8szPTn/dWZwSlWcKqfWfx9+dgmKdjvJMyXWszGakeI9NuddkqH19JY4yJC
 StxQ1jxKoJixKfJkYs0ztZ/SS6K8Eys6MfKHXNPmk3PhM1bGk5NyZM0ArJ6d3a2WzanV
 851Iv9ZQeCN9M6j7bpEIaLRm/FHqIHph+k+mbsZyXOC+/SuLwl4SrjvQRET0j3ShAX7c
 IXBg==
X-Gm-Message-State: AOJu0Yw5t609Uo18/RdjXgpFf6VyPlUXF8IpV7lLGg/uD19TdFP2eOCb
 lv3vXQC2k9nXb37Vu91J4NMo8/+vCoLlMvPP69VbaBrIPNX05KRkdmac4DOWn6A=
X-Gm-Gg: ASbGnctYep5jattX/J+yqJ/tY/vpQSoqCsjLzlUJDPsOkN2cYcOSGSjdA6YaMEZKw9/
 1jmChnlI3lsniArenfEhndENhZoMYqf60/SyAbIx1kfroQ7KhdaL+jMs5oMudfr94Ip9cDli6oq
 KpM58w13LSu34dHrQ/8lUEVtuujGlIoMz74kq2h5qTMO/eKpv8d8x697Da38I49QY6Qe5H6L1Bf
 K0NXaLvzyynvMxmzVKrC6VqCrA41ctOCfmX7IGw7yufhUD2TTOOpwaM5oU+Rd4p5BD9bCy6rVlC
 BewdI6gTQP+NryGdwKn0UDyuCNL4JBp97EwSZ6wiAygTmTUmMjY11tp+xl97WytJlzrndR9LcjI
 HzFeS3w==
X-Google-Smtp-Source: AGHT+IE1K2PGqaq4ZnVXywd2Gw0LZMcPkeDc5+KwwjRJvNehCp1uKMnwWkfyVQ+6R5ZdwmzZzU67ZA==
X-Received: by 2002:a17:907:3206:b0:abe:e981:f152 with SMTP id
 a640c23a62f3a-abf265a2a06mr27461266b.37.1740677426337; 
 Thu, 27 Feb 2025 09:30:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c101415sm154190066b.81.2025.02.27.09.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:30:26 -0800 (PST)
Message-ID: <570846c3-3401-497c-a949-4d4519cf6e5d@linaro.org>
Date: Thu, 27 Feb 2025 18:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] dm: usb: initialize and scan multiple buses
 simultaneously with uthread
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Guillaume La Roque <glaroque@baylibre.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <03a5c263b0449b397ca280d5d22bebf1d5496687.1740499185.git.jerome.forissier@linaro.org>
 <CAFLszTg2TXUzZS=ucjeSZaMWcXdhcChH-ABH+rkn8PYOQTVVUw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTg2TXUzZS=ucjeSZaMWcXdhcChH-ABH+rkn8PYOQTVVUw@mail.gmail.com>
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



On 2/27/25 17:25, Simon Glass wrote:
> Hi Jerome,
> 
> On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Use the uthread framework to initialize and scan USB buses in parallel
>> for better performance. The console output is slightly modified with a
>> final per-bus report of the number of devices found, common to UTHREAD
>> and !UTHREAD. The USB tests are updated accordingly.
>>
>> Tested on two platforms:
>>
>> 1. arm64 QEMU on a somewhat contrived example (4 USB buses, each with
>> one audio device, one keyboard, one mouse and one tablet)
>>
>>  $ make qemu_arm64_defconfig
>>  $ make -j$(nproc) CROSS_COMPILE="ccache aarch64-linux-gnu-"
>>  $ qemu-system-aarch64 -M virt -nographic -cpu max -bios u-boot.bin \
>>      $(for i in {1..4}; do echo -device qemu-xhci,id=xhci$i \
>>          -device\ usb-{audio,kbd,mouse,tablet},bus=xhci$i.0; \
>>      done)
>>
>> 2. i.MX93 EVK (imx93_11x11_evk_defconfig) with two USB hubs, each with
>> one webcam and one ethernet adapter, resulting in the following device
>> tree:
>>
>>  USB device tree:
>>    1  Hub (480 Mb/s, 0mA)
>>    |  u-boot EHCI Host Controller
>>    |
>>    +-2  Hub (480 Mb/s, 100mA)
>>      |  GenesysLogic USB2.1 Hub
>>      |
>>      +-3  Vendor specific (480 Mb/s, 350mA)
>>      |    Realtek USB 10/100/1000 LAN 001000001
>>      |
>>      +-4   (480 Mb/s, 500mA)
>>            HD Pro Webcam C920 8F7CD51F
>>
>>    1  Hub (480 Mb/s, 0mA)
>>    |  u-boot EHCI Host Controller
>>    |
>>    +-2  Hub (480 Mb/s, 100mA)
>>      |   USB 2.0 Hub
>>      |
>>      +-3  Vendor specific (480 Mb/s, 200mA)
>>      |    Realtek USB 10/100/1000 LAN 000001
>>      |
>>      +-4   (480 Mb/s, 500mA)
>>           Generic OnLan-CS30 201801010008
>>
>> Note that i.MX was tested on top of the downstream repository [1] since
>> USB doesn't work in the upstream master branch.
>>
>> [1] https://github.com/nxp-imx/uboot-imx/tree/lf-6.6.52-2.2.0
>>     commit 6c4545203d12 ("LF-13928 update key for capsule")
>>
>> The time spent in usb_init() ("usb start" command) is reported on
>> the console. Here are the results:
>>
>>         | CONFIG_UTHREAD=n | CONFIG_UTHREAD=y
>> --------+------------------+-----------------
>> QEMU    |          5628 ms |          2212 ms
>> i.MX93  |          4591 ms |          2441 ms
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/usb/host/usb-uclass.c | 92 ++++++++++++++++++++++++++++-------
>>  test/boot/bootdev.c           | 14 +++---
>>  test/boot/bootflow.c          |  2 +-
>>  3 files changed, 83 insertions(+), 25 deletions(-)
> 
> What happens to output produced by a thread? Does it get stored
> somewhere and written when the thread completes, or do the threads
> intermingle their output?

The latter. That is why I slightly reworked the USB initialization
output to print a status once the threads are done, and I also updated
the related tests as you can see in the patch. For instance the tests
were expecting:
"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found"
The "scanning bus usb@1 for devices..." part is printed by the threads,
therefore in any order. I decided to move the text
"Bus usb@1: 5 USB Device(s) found" to after the threads are complete,
iterating over the devices in a deterministic order.

> 
> I'm not sure if you saw my email about using a state machine for USB.
> If so, could you please point me to your reply?

I did, but I did not reply because I did not try. I have a feeling that
the change would be more intrusive than what I did, but above all I am
not doing the uthread thing to address only USB but as a general
technique to make things parallel without too much trouble (at least
that's my hope). So kind of a different goal.

Regards,
-- 
Jerome
