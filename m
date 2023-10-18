Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF98CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E7A86F67;
	Wed, 18 Oct 2023 12:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626539;
	bh=ASzy4WfGkm7iXQQ1Sc39x4EL95ApLJMU5TSJHyIg7L4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AR5boF/99Td0dC2CIcgHrTXtyYtQAtdeH3//yS/eBPKRqi6mh4XrLXdTZbaOKJ8x8
	 0hobFnvt2kK9XhzW0xnvphSHyd0ARMzij2dTUx2VIK+sfKKY2nTSYWz+ziZKwAqR2B
	 PtvqAyqVeOMCpKrQ3pz5djSPIse4Reb7kiXu1nxcmFwttKWAp+C4IZmKdfuaZsA6c/
	 tTuQpS+zjVWF8Pkn4jMbtPv15+TfHRbwvEXih6O7GcQMX7ZmWONS5IydAe+rWRNYiC
	 JvXEOiVJ6UJA7wEhq8g53OofJJh6rZkTvivyQxjlTUHJJ+2bQbxXf3FSzV4D1cvBIq
	 GeqgrpG6hunAQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 63C5386A3C;
 Wed, 18 Oct 2023 12:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626538;
 bh=ASzy4WfGkm7iXQQ1Sc39x4EL95ApLJMU5TSJHyIg7L4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=s8sbHjTFhE1IOejGxV/eJVgVXFj2Jm5UQLPZ45eWUlPrMofgUXuePTg3chhnGE+48
 fwqhWrg0mAE4BRCafTUoJCi6OpXtXnVja/+1M6eFxHc0vPkhs/ytSTIb88jwoMeVl7
 AOTFrM9k2pBdmowZd3E9qS9sXVTIWmCzMQBflfAqFXKW3074q/NmZ+/sifOCPjc4mv
 vNuX9Nm9S3GQIG9Kw2vMQRvruHOwZhIX5pyNIyNExxFwTFdRiXQhR+gWM2In1ncAML
 XEmk6i0ZhF6/jXDjhOaAPFm04D0WZVHJaeRsMUJyyl3Utbt+4R+j4/jGbgMJpXbtbP
 sED7CrYhCg+QA==
Message-ID: <fe08dab2-2c98-4ad9-9842-12051f89e8df@denx.de>
Date: Wed, 18 Oct 2023 12:55:37 +0200
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
 <775eb415-1dd3-4aed-b1c7-a6b118c3bad1@denx.de>
 <c354d3df-189e-4506-8ccb-f07cf3ec56ab@starfivetech.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c354d3df-189e-4506-8ccb-f07cf3ec56ab@starfivetech.com>
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

On 10/18/23 12:16, Minda Chen wrote:
> 
> 
> On 2023/10/18 18:11, Marek Vasut wrote:
>> On 10/18/23 05:46, Minda Chen wrote:
>>>
>>>
>>> On 2023/10/18 10:35, Marek Vasut wrote:
>>>> On 10/18/23 03:22, Minda Chen wrote:
>>>>>
>>>>>
>>>>> On 2023/10/17 19:20, Marek Vasut wrote:
>>>>>> On 10/17/23 08:20, Minda Chen wrote:
>>>>>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>>>>>> NULL. Checking the return value to avoid crash.
>>>>>>>
>>>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>>>
>>>>>> How did you trigger this error ? Is there a reproducer ? Details please ...
>>>>>
>>>>> While Scanning a lenovo usb2.0 udisk， not 100 % reproduce
>>>>
>>>> Can you include Linux
>>>>
>>>> lsusb -vvv
>>>>
>>>> output for this device and include that information in the commit message ? (or the U-Boot info below, that works too, just please add it into the commit message, it is important for future reference).
>>>>
>>> OK， I will add lsusb -vvv Linux udisk message and crash dump info to commit message
>>
>> Thank you
>>
>>>>> This is log.
>>>>>
>>>>> StarFive # usb reset
>>>>> resetting USB...
>>>>> Bus xhci_pci: Register 5000420 NbrPorts 5
>>>>> Starting the controller
>>>>> USB XHCI 1.00
>>>>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing URB anyway.
>>>>> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 02008401)
>>>>> Unhandled exception: Load access fault
>>>>> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
>>>>> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted
>>>>
>>>> Where does the crash point to in code, can you disassemble the PC pointer ? (or maybe you can use scripts/decodecode I think)
>>>>
>>> OK， I will add EPC pointer disassemble  to commit message
>>
>> This part probably doesn't need to be in the commit message. I'd like to know where the crash occurred in the code.
> 
> 
> 000000004024a376 <abort_td>:
> {
>      4024a376:   7179                    addi    sp,sp,-48
>      4024a378:   f406                    sd      ra,40(sp)
>      4024a37a:   f022                    sd      s0,32(sp)
>      4024a37c:   ec26                    sd      s1,24(sp)
>      4024a37e:   e84a                    sd      s2,16(sp)
>      4024a380:   e44e                    sd      s3,8(sp)
>      4024a382:   e052                    sd      s4,0(sp)
>      4024a384:   89ae                    mv      s3,a1
>      4024a386:   84aa                    mv      s1,a0
>          struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
>      4024a388:   8c4fe0ef                jal     ra,4024844c <xhci_get_ctrl>
>          struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>      4024a38c:   6785                    lui     a5,0x1
>      4024a38e:   94be                    add     s1,s1,a5
>      4024a390:   9444a603                lw      a2,-1724(s1)
>      4024a394:   00198713                addi    a4,s3,1
>      4024a398:   0712                    slli    a4,a4,0x4
>      4024a39a:   02061793                slli    a5,a2,0x20
>      4024a39e:   9381                    srli    a5,a5,0x20
>      4024a3a0:   07c9                    addi    a5,a5,18
>      4024a3a2:   078e                    slli    a5,a5,0x3
>      4024a3a4:   97aa                    add     a5,a5,a0
>      4024a3a6:   679c                    ld      a5,8(a5)
>          xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>      4024a3a8:   2981                    sext.w  s3,s3
>      4024a3aa:   86ce                    mv      a3,s3
>          struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>      4024a3ac:   97ba                    add     a5,a5,a4
>          xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>      4024a3ae:   4581                    li      a1,0
>      4024a3b0:   473d                    li      a4,15
>          struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>      4024a3b2:   0087ba03                ld      s4,8(a5) # 1008 <_start-0x401feff8>
>          struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
>      4024a3b6:   842a                    mv      s0,a0
>          xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>      4024a3b8:   d75ff0ef                jal     ra,4024a12c <xhci_queue_command>
>          event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
>      4024a3bc:   02000593                li      a1,32
>      4024a3c0:   8522                    mv      a0,s0
>      4024a3c2:   ebdff0ef                jal     ra,4024a27e <xhci_wait_for_event>
>          field = le32_to_cpu(event->trans_event.flags);
> epc-> 4024a3c6:   455c                    lw      a5,12(a0)

So the fault occurs when reading the controller register(s), do I 
understand it right ?

Could it be the problem is rather some clock, which are turned off after 
a fault ?
