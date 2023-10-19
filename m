Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F4CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 03:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273878714C;
	Thu, 19 Oct 2023 05:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697685772;
	bh=Hm0m+WFNjrgaCUZ5JIo+q9NjvqQZ3zeoGFElLz0skn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rbf+KKjHTVYpe5pR+r3isATHNdntZp9CFJd8nbRrAa1D4Tq+LJ7advaMrWjqtGJio
	 si+e27oKiMa8BALu+HSCibqALYl/mCsBAKpgnSU+qrbrAQlu6091M/f8Vcdx//uys+
	 eox8Yx21+o4fUxjx2Bcl+8lG0m+M96libWASUNqOyin43JhjsYRFNN/hkkMbSlJoc9
	 o6hpdz+rnQSrz8UbkYljMgisAIF6+zdwajsJJGpTLdcL/d46eVoqQk+93eP6H+FAT3
	 5nYHC8kCjf/kEsLbMNljTfp/d6Um+MZdNM6IDaPUJxnVW9KPkpBGZwYEGdFGq2kWLr
	 kHJmYemwdYMuw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 84C0D87129;
 Thu, 19 Oct 2023 05:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697685770;
 bh=Hm0m+WFNjrgaCUZ5JIo+q9NjvqQZ3zeoGFElLz0skn4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dn/EwryG5V3ZKvxgWTTDJNOhDjEIajXs+Qs2dnD1WIzuglLmYZhjlACIjwuocY5Xc
 id0WxL1BEc5YsqwrmGPH1ro1ZW/EGU4TepbvjeiIQ5OCoJFES5EfluP2V6fXJWLk0m
 aslYA06lZ24f8Ckbofr/tr+bWMbTzXEVvBD7qSwtRvfQk2uZ/wJH+fMB58GYcuhj7V
 lE4dpLQYum6Eob9Ny8JsyUXINGesoB9QGWKbK2l0jsKysF2PiOezICPjonRV4TGzzh
 5CuJ5eD1YsJ0fgcV6IPDSsSx91Nlmn7kd5PSJnki2ZuVQ1FKN+Ig0Cf43KXgYLryhD
 UKAxtVVA0/arg==
Message-ID: <c8e2ed3a-f9ea-4e7e-963e-7d706056dfb8@denx.de>
Date: Thu, 19 Oct 2023 05:22:49 +0200
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
 <fe08dab2-2c98-4ad9-9842-12051f89e8df@denx.de>
 <1097ab74-8d8e-4f09-b932-14ab6b564cee@starfivetech.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1097ab74-8d8e-4f09-b932-14ab6b564cee@starfivetech.com>
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

On 10/19/23 04:46, Minda Chen wrote:

[...]

>>> 000000004024a376 <abort_td>:
>>> {
>>>       4024a376:   7179                    addi    sp,sp,-48
>>>       4024a378:   f406                    sd      ra,40(sp)
>>>       4024a37a:   f022                    sd      s0,32(sp)
>>>       4024a37c:   ec26                    sd      s1,24(sp)
>>>       4024a37e:   e84a                    sd      s2,16(sp)
>>>       4024a380:   e44e                    sd      s3,8(sp)
>>>       4024a382:   e052                    sd      s4,0(sp)
>>>       4024a384:   89ae                    mv      s3,a1
>>>       4024a386:   84aa                    mv      s1,a0
>>>           struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
>>>       4024a388:   8c4fe0ef                jal     ra,4024844c <xhci_get_ctrl>
>>>           struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>>>       4024a38c:   6785                    lui     a5,0x1
>>>       4024a38e:   94be                    add     s1,s1,a5
>>>       4024a390:   9444a603                lw      a2,-1724(s1)
>>>       4024a394:   00198713                addi    a4,s3,1
>>>       4024a398:   0712                    slli    a4,a4,0x4
>>>       4024a39a:   02061793                slli    a5,a2,0x20
>>>       4024a39e:   9381                    srli    a5,a5,0x20
>>>       4024a3a0:   07c9                    addi    a5,a5,18
>>>       4024a3a2:   078e                    slli    a5,a5,0x3
>>>       4024a3a4:   97aa                    add     a5,a5,a0
>>>       4024a3a6:   679c                    ld      a5,8(a5)
>>>           xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>>>       4024a3a8:   2981                    sext.w  s3,s3
>>>       4024a3aa:   86ce                    mv      a3,s3
>>>           struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>>>       4024a3ac:   97ba                    add     a5,a5,a4
>>>           xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>>>       4024a3ae:   4581                    li      a1,0
>>>       4024a3b0:   473d                    li      a4,15
>>>           struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
>>>       4024a3b2:   0087ba03                ld      s4,8(a5) # 1008 <_start-0x401feff8>
>>>           struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
>>>       4024a3b6:   842a                    mv      s0,a0
>>>           xhci_queue_command(ctrl, NULL, udev->slot_id, ep_index, TRB_STOP_RING);
>>>       4024a3b8:   d75ff0ef                jal     ra,4024a12c <xhci_queue_command>
>>>           event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
>>>       4024a3bc:   02000593                li      a1,32
>>>       4024a3c0:   8522                    mv      a0,s0
>>>       4024a3c2:   ebdff0ef                jal     ra,4024a27e <xhci_wait_for_event>
>>>           field = le32_to_cpu(event->trans_event.flags);
>>> epc-> 4024a3c6:   455c                    lw      a5,12(a0)
>>
>> So the fault occurs when reading the controller register(s), do I understand it right ?
>>
> I think it is right. Actually this error occur in error path, control tx transfer TRB_TRANSFER error occur and jump to error path.
> sending TRB_TRANSFER again.
>> Could it be the problem is rather some clock, which are turned off after a fault ?
> I think not. Just this udisk can reproduce this issue.

Can you take a closer look into this ? Is there maybe some hardware 
debug tool which can clarify what is going on better ?

It seems weird that controller register access would trigger this kind 
of bus fault (it is a bus fault, right ?)
