Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B7CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9520B86C87;
	Wed, 18 Oct 2023 12:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697623912;
	bh=7T6WVKzuD2Xxm8YV/3vM601O58LNswR5cZTXpG0joR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q59iRCDxD14DQeBHcpL2wowjP2SctJFklphszAQ1R7XLs4eQss1ai2tnuojOnEvWe
	 6Kz7z6QuD+1cfVP+ZZSOLNuMN1bg40NOyG5/v6W7TSDskH2S8RX2dBv7trELKoigFt
	 9GzstK3kCQPL7UUkBF7wsSdRrHSE3nl3RRTcgeb5bxBT3sGNGALce0lJxJFreRUy88
	 UvFjnDlXa/l38x2JTuHIcYVLaZOvxPeX1GdfxqLDeTqGuVZTyRXUWcqdg+FfN4kt/A
	 njjGffhjyIOMR+TMrl9s/01zWmdUEKW9neZXduh6VmjjyFe2VG6LENSBMKW2vSG05c
	 DOYt+dRzOOV5A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3AFA386611;
 Wed, 18 Oct 2023 12:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697623911;
 bh=7T6WVKzuD2Xxm8YV/3vM601O58LNswR5cZTXpG0joR8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=anHkfT9AZa80L52325o/JUwXe1QaJd0vEb0+OZv7PgDBC1J/DRclagky026pHlZBA
 u89f9MbF2RF94HTgnL0WN0GBzDfaiNTbQmfSJufgNshSv9s/8kd23LrtaVcIEXhVwZ
 qo5rW5mMExbXuNEr8+ON0yHCgSJagRRpdVUjKfwb0WBIBZLqHgeR3YzywWqFWGPzxg
 PMT1gekcezIdlfmX8lS2m1QlE72Rogmz4tud0vD6CsHDNunZDBFFUBI6Aq++G42moF
 FbO0fZOa9BMNi/w/F6EwnN21IVEIppwLLFlx9WwkenU0ZaUssooifreJvfsGCFzDD8
 BTNqbOOfv40OQ==
Message-ID: <775eb415-1dd3-4aed-b1c7-a6b118c3bad1@denx.de>
Date: Wed, 18 Oct 2023 12:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER
 event
Content-Language: en-US
To: Minda Chen <minda.chen@starfivetech.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de
References: <20231017062016.51682-1-minda.chen@starfivetech.com>
 <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
 <2313a5f6-30a2-46ed-923f-a6f8699452c6@starfivetech.com>
 <55da21fd-2a9b-4b48-a0bb-d8f07ad362ea@denx.de>
 <2a9821ea-68aa-4997-8779-b2e374627a0e@starfivetech.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2a9821ea-68aa-4997-8779-b2e374627a0e@starfivetech.com>
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

On 10/18/23 05:46, Minda Chen wrote:
> 
> 
> On 2023/10/18 10:35, Marek Vasut wrote:
>> On 10/18/23 03:22, Minda Chen wrote:
>>>
>>>
>>> On 2023/10/17 19:20, Marek Vasut wrote:
>>>> On 10/17/23 08:20, Minda Chen wrote:
>>>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>>>> NULL. Checking the return value to avoid crash.
>>>>>
>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>
>>>> How did you trigger this error ? Is there a reproducer ? Details please ...
>>>
>>> While Scanning a lenovo usb2.0 udisk， not 100 % reproduce
>>
>> Can you include Linux
>>
>> lsusb -vvv
>>
>> output for this device and include that information in the commit message ? (or the U-Boot info below, that works too, just please add it into the commit message, it is important for future reference).
>>
> OK， I will add lsusb -vvv Linux udisk message and crash dump info to commit message

Thank you

>>> This is log.
>>>
>>> StarFive # usb reset
>>> resetting USB...
>>> Bus xhci_pci: Register 5000420 NbrPorts 5
>>> Starting the controller
>>> USB XHCI 1.00
>>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing URB anyway.
>>> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 02008401)
>>> Unhandled exception: Load access fault
>>> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
>>> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted
>>
>> Where does the crash point to in code, can you disassemble the PC pointer ? (or maybe you can use scripts/decodecode I think)
>>
> OK， I will add EPC pointer disassemble  to commit message

This part probably doesn't need to be in the commit message. I'd like to 
know where the crash occurred in the code.
