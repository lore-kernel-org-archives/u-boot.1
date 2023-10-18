Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA6CDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 02:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA7486EDD;
	Wed, 18 Oct 2023 04:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697596525;
	bh=Hx3Eywvn1F+d6WQaalFrrZ7/5zMtCScrWUtgbFG9BLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EeNztFSC8DEYDUsFhGKGinfkUNGdugfVlrdn0PBD93F8fXFidsoMdVbPqf5yeHg92
	 wglU0nXDg7TFwvHKMSp001Kg6VPb5c0i9mXWci7A8zxI0d8LY7WZJ9o08Mtih2Hhwp
	 0oShpImFfDnAk1fO9VCpjsRSRr8ZwloSy2Wx3nt9bLp0H6huCg3fytdtruICGCnbS/
	 T7y0Hx6bhuxUqJvlwNKriBt8/1IGFoezi89ttjXowy6HbC/VNcwfdRSQ9AQqhcpUD2
	 HMM5sRBehpE0A0KYMum8WC7VpTGy9Ud2E+YyRZt7+EQs5udm2mDE4etP3VvRWqlwzy
	 pDCHFecmaFpZw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5CF3886D48;
 Wed, 18 Oct 2023 04:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697596523;
 bh=Hx3Eywvn1F+d6WQaalFrrZ7/5zMtCScrWUtgbFG9BLE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V/opjQEZGgX0k5QSMoHakcsShJrrV/6h6lgWV1ymeFIiYRMNqgQPgRo9BBJpGX6m+
 RdFiOewRl7wQR5jMUPGwj6q4Q0c6Ko1qOMTTzaD5Wn6cm2s69Ay4dTS9o72g//3Mn5
 L3WUnejGA3xcuc77I1wTrGoyPgZmkUh/29TV6J0fTEh/tkJ6jRRUz3Vx223cpQV+VK
 OSUC9Wjn/n2jW4UXn4CZC6jUkcgyaLAKRGMzjC60ZxsxQva94f1gTzagglmErUSdad
 uzjC31fMakPrAIHRKBYhiOxfNYfvHdxM70AQpP3udOzCG8+/b6T/fOsyOKBH1FzPoM
 X7zxIieOMFMHg==
Message-ID: <55da21fd-2a9b-4b48-a0bb-d8f07ad362ea@denx.de>
Date: Wed, 18 Oct 2023 04:35:22 +0200
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2313a5f6-30a2-46ed-923f-a6f8699452c6@starfivetech.com>
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

On 10/18/23 03:22, Minda Chen wrote:
> 
> 
> On 2023/10/17 19:20, Marek Vasut wrote:
>> On 10/17/23 08:20, Minda Chen wrote:
>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>> NULL. Checking the return value to avoid crash.
>>>
>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>
>> How did you trigger this error ? Is there a reproducer ? Details please ...
> 
> While Scanning a lenovo usb2.0 udisk， not 100 % reproduce

Can you include Linux

lsusb -vvv

output for this device and include that information in the commit 
message ? (or the U-Boot info below, that works too, just please add it 
into the commit message, it is important for future reference).

> This is log.
> 
> StarFive # usb reset
> resetting USB...
> Bus xhci_pci: Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> scanning bus xhci_pci for devices... WARN halted endpoint, queueing URB anyway.
> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 02008401)
> Unhandled exception: Load access fault
> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted

Where does the crash point to in code, can you disassemble the PC 
pointer ? (or maybe you can use scripts/decodecode I think)

> SP:  00000000f76f9a60 GP:  00000000f76fbdd0 TP:  0000000000000001
> T0:  00000000f76fa168 T1:  00000000000000ff T2:  0000000000000016
> S0:  00000000f7712fc0 S1:  00000000f76fb100 A0:  0000000000000000
> A1:  0000000000000000 A2:  00000000f77145d0 A3:  00000000f7714590
> A4:  0000000000000000 A5:  0000000000000020 A6:  000000000000000f
> A7:  0000000000000100 S2:  0000000000000000 S3:  0000000000000000
> S4:  00000000f7717050 S5:  00000000f7717050 S6:  0000000080000383
> S7:  00000000f76f9dc0 S8:  00000000000000ff S9:  0000000000000001
> S10: 00000000f76f9ba0 S11: 0000000000010c04 T3:  0000000000000010
> T4:  0000000000000006 T5:  0000000000000080 T6:  00000000f76fa231

[...]

> 3: Mass Storage,  USB Revision 2.0
>   - Generic Mass Storage 31097778XB15113405
>   - Class: (from Interface) Mass Storage
>   - PacketSize: 64  Configurations: 1
>   - Vendor: 0x17ef  Product 0x38ac Version 1.0
>     Configuration: 1
>     - Interfaces: 1 Bus Powered 200mA
>       Interface: 0
>       - Alternate Setting 0, Endpoints: 2
>       - Class Mass Storage, Transp. SCSI, Bulk only
>       - Endpoint 1 Out Bulk MaxPacket 512
>       - Endpoint 2 In Bulk MaxPacket 512
> 
> StarFive # usb storage
>    Device 0: Vendor:          Rev: 8.07 Prod: Lenovo SX1 64G
>              Type: Removable Hard Disk
>              Capacity: 60000.0 MB = 58.5 GB (122880000 x 512)

[...]
