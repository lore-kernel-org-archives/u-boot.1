Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1714DCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 02:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4514A870A5;
	Thu, 19 Oct 2023 04:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8833870A5; Thu, 19 Oct 2023 04:46:45 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
 by phobos.denx.de (Postfix) with ESMTP id 2C423870A4
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 04:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
 by ex01.ufhost.com (Postfix) with ESMTP id E0A4724E083;
 Thu, 19 Oct 2023 10:46:38 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Oct
 2023 10:46:38 +0800
Received: from [192.168.125.85] (183.27.99.123) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 19 Oct
 2023 10:46:38 +0800
Message-ID: <1097ab74-8d8e-4f09-b932-14ab6b564cee@starfivetech.com>
Date: Thu, 19 Oct 2023 10:46:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER
 event
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Bin Meng <bmeng.cn@gmail.com>
CC: <u-boot@lists.denx.de>
References: <20231017062016.51682-1-minda.chen@starfivetech.com>
 <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
 <2313a5f6-30a2-46ed-923f-a6f8699452c6@starfivetech.com>
 <55da21fd-2a9b-4b48-a0bb-d8f07ad362ea@denx.de>
 <2a9821ea-68aa-4997-8779-b2e374627a0e@starfivetech.com>
 <775eb415-1dd3-4aed-b1c7-a6b118c3bad1@denx.de>
 <c354d3df-189e-4506-8ccb-f07cf3ec56ab@starfivetech.com>
 <fe08dab2-2c98-4ad9-9842-12051f89e8df@denx.de>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <fe08dab2-2c98-4ad9-9842-12051f89e8df@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.99.123]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
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



On 2023/10/18 18:55, Marek Vasut wrote:
> On 10/18/23 12:16, Minda Chen wrote:
>>
>>
>> On 2023/10/18 18:11, Marek Vasut wrote:
>>> On 10/18/23 05:46, Minda Chen wrote:
>>>>
>>>>
>>>> On 2023/10/18 10:35, Marek Vasut wrote:
>>>>> On 10/18/23 03:22, Minda Chen wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/10/17 19:20, Marek Vasut wrote:
>>>>>>> On 10/17/23 08:20, Minda Chen wrote:
>>>>>>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>>>>>>> NULL. Checking the return value to avoid crash.
>>>>>>>>
>>>>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>>>>
>>>>>>> How did you trigger this error ? Is there a reproducer ? Details =
please ...
>>>>>>
>>>>>> While Scanning a lenovo usb2.0 udisk=EF=BC=8C not 100 % reproduce
>>>>>
>>>>> Can you include Linux
>>>>>
>>>>> lsusb -vvv
>>>>>
>>>>> output for this device and include that information in the commit m=
essage ? (or the U-Boot info below, that works too, just please add it in=
to the commit message, it is important for future reference).
>>>>>
>>>> OK=EF=BC=8C I will add lsusb -vvv Linux udisk message and crash dump=
 info to commit message
>>>
>>> Thank you
>>>
>>>>>> This is log.
>>>>>>
>>>>>> StarFive # usb reset
>>>>>> resetting USB...
>>>>>> Bus xhci_pci: Register 5000420 NbrPorts 5
>>>>>> Starting the controller
>>>>>> USB XHCI 1.00
>>>>>> scanning bus xhci_pci for devices... WARN halted endpoint, queuein=
g URB anyway.
>>>>>> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000=
 02008401)
>>>>>> Unhandled exception: Load access fault
>>>>>> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
>>>>>> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted
>>>>>
>>>>> Where does the crash point to in code, can you disassemble the PC p=
ointer ? (or maybe you can use scripts/decodecode I think)
>>>>>
>>>> OK=EF=BC=8C I will add EPC pointer disassemble=C2=A0 to commit messa=
ge
>>>
>>> This part probably doesn't need to be in the commit message. I'd like=
 to know where the crash occurred in the code.
>>
>>
>> 000000004024a376 <abort_td>:
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a376:=C2=A0=C2=A0 7179=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 sp,sp,-48
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a378:=C2=A0=C2=A0 f406=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra,40(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a37a:=C2=A0=C2=A0 f022=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0,32(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a37c:=C2=A0=C2=A0 ec26=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s1,24(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a37e:=C2=A0=C2=A0 e84a=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s2,16(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a380:=C2=A0=C2=A0 e44e=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s3,8(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a382:=C2=A0=C2=A0 e052=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s4,0(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a384:=C2=A0=C2=A0 89ae=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s3,a1
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a386:=C2=A0=C2=A0 84aa=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s1,a0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_ctrl *ctr=
l =3D xhci_get_ctrl(udev);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a388:=C2=A0=C2=A0 8c4fe0ef=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 jal=C2=A0=C2=A0=C2=A0=C2=A0 ra,4024844c <xhci_get_ctrl>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_ring *rin=
g =3D=C2=A0 ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a38c:=C2=A0=C2=A0 6785=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 lui=C2=A0=C2=A0=C2=A0=C2=A0 a5,0x1
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a38e:=C2=A0=C2=A0 94be=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 s1,s1,a5
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a390:=C2=A0=C2=A0 9444a603=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 lw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a2,-1724(s1)
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a394:=C2=A0=C2=A0 00198713=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 addi=C2=A0=C2=A0=C2=A0 a4,s3,1
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a398:=C2=A0=C2=A0 0712=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 slli=C2=A0=C2=A0=C2=A0 a4,a4,0x4
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a39a:=C2=A0=C2=A0 02061793=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 slli=C2=A0=C2=A0=C2=A0 a5,a2,0x20
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a39e:=C2=A0=C2=A0 9381=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 srli=C2=A0=C2=A0=C2=A0 a5,a5,0x20
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3a0:=C2=A0=C2=A0 07c9=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 a5,a5,18
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3a2:=C2=A0=C2=A0 078e=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 slli=C2=A0=C2=A0=C2=A0 a5,a5,0x3
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3a4:=C2=A0=C2=A0 97aa=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 a5,a5,a0
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3a6:=C2=A0=C2=A0 679c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a5,8(a5)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci_queue_command(ct=
rl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3a8:=C2=A0=C2=A0 2981=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sext.w=C2=A0 s3,s3
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3aa:=C2=A0=C2=A0 86ce=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a3,s3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_ring *rin=
g =3D=C2=A0 ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3ac:=C2=A0=C2=A0 97ba=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 a5,a5,a4
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci_queue_command(ct=
rl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3ae:=C2=A0=C2=A0 4581=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a1,0
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3b0:=C2=A0=C2=A0 473d=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a4,15
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_ring *rin=
g =3D=C2=A0 ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3b2:=C2=A0=C2=A0 0087ba03=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s4,8(a5) # 1008 <_start-0x401feff8>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xhci_ctrl *ctr=
l =3D xhci_get_ctrl(udev);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3b6:=C2=A0=C2=A0 842a=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0,a0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xhci_queue_command(ct=
rl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3b8:=C2=A0=C2=A0 d75ff0ef=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 jal=C2=A0=C2=A0=C2=A0=C2=A0 ra,4024a12c <xhci_queue_command>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event =3D xhci_wait_f=
or_event(ctrl, TRB_TRANSFER);
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3bc:=C2=A0=C2=A0 02000593=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a1,32
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3c0:=C2=A0=C2=A0 8522=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0,s0
>> =C2=A0=C2=A0=C2=A0=C2=A0 4024a3c2:=C2=A0=C2=A0 ebdff0ef=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 jal=C2=A0=C2=A0=C2=A0=C2=A0 ra,4024a27e <xhci_wait_for_event>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field =3D le32_to_cpu=
(event->trans_event.flags);
>> epc-> 4024a3c6:=C2=A0=C2=A0 455c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 lw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a5,12(a0)
>=20
> So the fault occurs when reading the controller register(s), do I under=
stand it right ?
>=20
I think it is right. Actually this error occur in error path, control tx =
transfer TRB_TRANSFER error occur and jump to error path.
sending TRB_TRANSFER again. =20
> Could it be the problem is rather some clock, which are turned off afte=
r a fault ?
I think not. Just this udisk can reproduce this issue.
