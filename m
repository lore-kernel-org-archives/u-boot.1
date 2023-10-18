Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52620CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A5386C87;
	Wed, 18 Oct 2023 12:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B99086611; Wed, 18 Oct 2023 12:16:27 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
 by phobos.denx.de (Postfix) with ESMTP id 0013786C87
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 12:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by ex01.ufhost.com (Postfix) with ESMTP id 9D1FD24E30A;
 Wed, 18 Oct 2023 18:16:19 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 18:16:19 +0800
Received: from [192.168.125.85] (183.27.98.194) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 18:16:18 +0800
Message-ID: <c354d3df-189e-4506-8ccb-f07cf3ec56ab@starfivetech.com>
Date: Wed, 18 Oct 2023 18:16:18 +0800
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
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <775eb415-1dd3-4aed-b1c7-a6b118c3bad1@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
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



On 2023/10/18 18:11, Marek Vasut wrote:
> On 10/18/23 05:46, Minda Chen wrote:
>>
>>
>> On 2023/10/18 10:35, Marek Vasut wrote:
>>> On 10/18/23 03:22, Minda Chen wrote:
>>>>
>>>>
>>>> On 2023/10/17 19:20, Marek Vasut wrote:
>>>>> On 10/17/23 08:20, Minda Chen wrote:
>>>>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>>>>> NULL. Checking the return value to avoid crash.
>>>>>>
>>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>>
>>>>> How did you trigger this error ? Is there a reproducer ? Details pl=
ease ...
>>>>
>>>> While Scanning a lenovo usb2.0 udisk=EF=BC=8C not 100 % reproduce
>>>
>>> Can you include Linux
>>>
>>> lsusb -vvv
>>>
>>> output for this device and include that information in the commit mes=
sage ? (or the U-Boot info below, that works too, just please add it into=
 the commit message, it is important for future reference).
>>>
>> OK=EF=BC=8C I will add lsusb -vvv Linux udisk message and crash dump i=
nfo to commit message
>=20
> Thank you
>=20
>>>> This is log.
>>>>
>>>> StarFive # usb reset
>>>> resetting USB...
>>>> Bus xhci_pci: Register 5000420 NbrPorts 5
>>>> Starting the controller
>>>> USB XHCI 1.00
>>>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing =
URB anyway.
>>>> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 0=
2008401)
>>>> Unhandled exception: Load access fault
>>>> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
>>>> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted
>>>
>>> Where does the crash point to in code, can you disassemble the PC poi=
nter ? (or maybe you can use scripts/decodecode I think)
>>>
>> OK=EF=BC=8C I will add EPC pointer disassemble=C2=A0 to commit message
>=20
> This part probably doesn't need to be in the commit message. I'd like t=
o know where the crash occurred in the code.


000000004024a376 <abort_td>:
{
    4024a376:   7179                    addi    sp,sp,-48
    4024a378:   f406                    sd      ra,40(sp)
    4024a37a:   f022                    sd      s0,32(sp)
    4024a37c:   ec26                    sd      s1,24(sp)
    4024a37e:   e84a                    sd      s2,16(sp)
    4024a380:   e44e                    sd      s3,8(sp)
    4024a382:   e052                    sd      s4,0(sp)
    4024a384:   89ae                    mv      s3,a1
    4024a386:   84aa                    mv      s1,a0
        struct xhci_ctrl *ctrl =3D xhci_get_ctrl(udev);
    4024a388:   8c4fe0ef                jal     ra,4024844c <xhci_get_ctr=
l>
        struct xhci_ring *ring =3D  ctrl->devs[udev->slot_id]->eps[ep_ind=
ex].ring;
    4024a38c:   6785                    lui     a5,0x1
    4024a38e:   94be                    add     s1,s1,a5
    4024a390:   9444a603                lw      a2,-1724(s1)
    4024a394:   00198713                addi    a4,s3,1
    4024a398:   0712                    slli    a4,a4,0x4
    4024a39a:   02061793                slli    a5,a2,0x20
    4024a39e:   9381                    srli    a5,a5,0x20
    4024a3a0:   07c9                    addi    a5,a5,18
    4024a3a2:   078e                    slli    a5,a5,0x3
    4024a3a4:   97aa                    add     a5,a5,a0
    4024a3a6:   679c                    ld      a5,8(a5)
        xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_=
RING);
    4024a3a8:   2981                    sext.w  s3,s3
    4024a3aa:   86ce                    mv      a3,s3
        struct xhci_ring *ring =3D  ctrl->devs[udev->slot_id]->eps[ep_ind=
ex].ring;
    4024a3ac:   97ba                    add     a5,a5,a4
        xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_=
RING);
    4024a3ae:   4581                    li      a1,0
    4024a3b0:   473d                    li      a4,15
        struct xhci_ring *ring =3D  ctrl->devs[udev->slot_id]->eps[ep_ind=
ex].ring;
    4024a3b2:   0087ba03                ld      s4,8(a5) # 1008 <_start-0=
x401feff8>
        struct xhci_ctrl *ctrl =3D xhci_get_ctrl(udev);
    4024a3b6:   842a                    mv      s0,a0
        xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_=
RING);
    4024a3b8:   d75ff0ef                jal     ra,4024a12c <xhci_queue_c=
ommand>
        event =3D xhci_wait_for_event(ctrl, TRB_TRANSFER);
    4024a3bc:   02000593                li      a1,32
    4024a3c0:   8522                    mv      a0,s0
    4024a3c2:   ebdff0ef                jal     ra,4024a27e <xhci_wait_fo=
r_event>
        field =3D le32_to_cpu(event->trans_event.flags);
epc-> 4024a3c6:   455c                    lw      a5,12(a0)        =20
        BUG_ON(TRB_TO_SLOT_ID(field) !=3D udev->slot_id);
    4024a3c8:   9444a703                lw      a4,-1724(s1)
        field =3D le32_to_cpu(event->trans_event.flags);
    4024a3cc:   0007891b                sext.w  s2,a5

