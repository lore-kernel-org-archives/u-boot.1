Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C619C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 13:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABFA87869;
	Thu, 21 Dec 2023 14:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="KOxGWwkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC3487869; Thu, 21 Dec 2023 14:51:52 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E728785B
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 14:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3368d1c7b23so222103f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1703166709; x=1703771509; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+Z+9Je7557FtgUcYN0h6L08KrKsuNyWC9pJ39lYuaA=;
 b=KOxGWwkMik1nPd4FnvduG02BBBJItb4bC8mojg14xNZOuqf61ilJA9JADQI6h7nPt3
 p4GNuei7jtfCD2sEJgzDWmio3sdRzGFV0vM+jPbmbGQtdeAQQznzFS+m9AQTZx9oad9r
 b1JgONsIexj+cbIrvL11Owa5yjb7iQCF0N2y7Y+exAIQ14VUZXU+CDcayb6JKpJVM/0V
 7Mx4xGllC+kTNtwK/GgoJ/OuIp8wsnxu55DixxDk8WCbYvSpIuqsN8B6K8EiVrq2clQQ
 ZsmkskNgU3TU4sT4FGrsUBPBtUJqpWwM5Fa9s/xlt5kPL8hBnSNNBU1WhFh5fMxIKfg0
 PovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703166709; x=1703771509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+Z+9Je7557FtgUcYN0h6L08KrKsuNyWC9pJ39lYuaA=;
 b=S6hvZbi7QEIZJUb12ODcjreXAccwabQWMPhBU/YuKws1kcoCMZEqIsxyJDJzjkgGTV
 XmjTr7/UcsSOimQEPopId9Ru+vAh3e1QkYJOZd3p5ekaOsCiKy8ke0MHkmRg74pZOry4
 4CsiCOU6CHrpplIahtocbmVpA+VZaV8JIH45OKL58fJs7qOeiw4kT15FPoHTdZolohlh
 fnDE4UZ3XQpGJw1k0QhmdDKnyZGMk+b2DwwH/2e8NWpAc86Yk/BN8cCyDjPq5eT+3o3c
 +J9gn5wlvpzcNOPLbVJikG1OODeMC90IYNgY8aA5IFtk3/rq12gxGjgLSbNDtvaRpcQM
 y/tw==
X-Gm-Message-State: AOJu0YzWpfX+IbMZ9riV33GsafJNO8jqT2YG3kqqNPf6bl9E+8Net3jN
 F1LyjNmKcSHQyRcv3xnZoBacuQ==
X-Google-Smtp-Source: AGHT+IFMb8eOle4ifziMatQjxpfcm76dKSRX6U1jHIiajYtcH6m1rM/YKmn/3qUtaL+PuvzBa2yDRg==
X-Received: by 2002:adf:a459:0:b0:336:18f6:aee with SMTP id
 e25-20020adfa459000000b0033618f60aeemr759207wra.48.1703166709518; 
 Thu, 21 Dec 2023 05:51:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:8400:17a8:8ea:59af:d317:9dff?
 ([2a02:810d:8400:17a8:8ea:59af:d317:9dff])
 by smtp.gmail.com with ESMTPSA id
 r16-20020adfe690000000b0033676f9e4cbsm2099387wrm.36.2023.12.21.05.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 05:51:49 -0800 (PST)
Message-ID: <2dfd1dc9-e745-459c-ae21-e3f5a4e4559c@suse.com>
Date: Thu, 21 Dec 2023 14:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] rpi5: initial support
Content-Language: en-US, ca-ES, es-ES
To: Stefan Agner <stefan@agner.ch>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <1cfe50401b3c4fe72064b9bd611e2347@agner.ch>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <1cfe50401b3c4fe72064b9bd611e2347@agner.ch>
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



On 21/12/2023 14:42, Stefan Agner wrote:
> Hi Ivan,
> 
> On 2023-12-18 22:03, Ivan T. Ivanov wrote:
>> Hi,
>>
>> These patches are adding basic support for RPi5.
>> They are based on v2 series from Dmitry Malkin[1].
>>
>> With them I am able to _start_ current openSUSE
>> Tumbleweed without modification. They are still
>> a lot of things to be added to the upstream Linux
>> before it runs flawlessly on this device, but at
>> least in U-Booot SD controller used for uSD card
>> and Frameboffer and HDMI0 devices are working fine
>> now. It seems that PCIe controller is working fine
>> too, but I have not tested it too much.
> 
> Thank you very much for this work!
> 
>>
>> Serial console and reset are also functional.
> 
> I've applied the patchset to v2024.01-rc5 and built the
> rpi_arm64_defconfig target. I added enable_uart=1 and kernel=u-boot.bin
> to config.txt. While I see a brief U-Boot logo on HDMI, I haven't gotten
> anything on the serial console on pin 8/10 of the Raspberry Pi pin
> header. Is there anything specific needed to get the console going?
> 

Welcome to the club! :)

The RPi5 uses a rather non-standard port for debug console:
https://www.raspberrypi.com/documentation/computers/raspberry-pi-5.html#uart-connector

Up to now I wasn't able to get serial console on the normal pins 8/10.

Regards
Matthias

> --
> Stefan
> 
>>
>> Hopefully this will help others add missing pieces
>> more easily.
>>
>> Happy hacking!
>>
>> Regards,
>> Ivan
>>
>> [1] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/
>>
>> Dmitry Malkin (2):
>>    rpi5: add initial memory map for bcm2712
>>    rpi5: Use devicetree as alternative way to read IO base addresses
>>
>> Ivan T. Ivanov (5):
>>    rpi5: Use devicetree to retrieve board revision
>>    bcm2835: brcm,bcm2708-fb device is using r5g6b5 format
>>    mmc: bcmstb: Add support for bcm2712 SD controller
>>    configs: rpi_arm64: enable SDHCI BCMSTB driver
>>    pci: pcie-brcmstb: Add bcm2712 PCIe controller support
>>
>>   arch/arm/mach-bcm283x/include/mach/base.h  |   5 +-
>>   arch/arm/mach-bcm283x/include/mach/mbox.h  |   3 +-
>>   arch/arm/mach-bcm283x/include/mach/sdhci.h |   3 +-
>>   arch/arm/mach-bcm283x/include/mach/timer.h |   3 +-
>>   arch/arm/mach-bcm283x/include/mach/wdog.h  |   3 +-
>>   arch/arm/mach-bcm283x/init.c               |  81 ++++++++--
>>   board/raspberrypi/rpi/rpi.c                |  22 ++-
>>   configs/rpi_arm64_defconfig                |   1 +
>>   drivers/mmc/bcmstb_sdhci.c                 | 173 ++++++++++++++++++++-
>>   drivers/pci/pcie_brcmstb.c                 |  23 ++-
>>   drivers/video/bcm2835.c                    |  10 +-
>>   11 files changed, 296 insertions(+), 31 deletions(-)
