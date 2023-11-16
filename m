Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5453C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CD38704F;
	Thu, 16 Nov 2023 03:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PNs9TUOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAF686F85; Thu, 16 Nov 2023 03:36:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17AE18745A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700102190; x=1700706990; i=xypron.glpk@gmx.de;
 bh=ezgiZWc8OzkVQv1ngUoxF7UwWq7tkeCWFQuETlztO6s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=PNs9TUOI3QDlOc2P9qNqszXs7RM6M1RfyHMmaWW1n0HiCH0eDdHOf6OpFFbrqvUy
 IaLYk2t2G71PcA1rP2/wrsfnOn5198BOdtS5aLolnBIWC56gETCHM8F1RDUb2Tcl9
 ngXPol0TzwQjKNZeox4M/NxmODnOOquP2ZCerYFAOaUciDqFvmj9qmzInQFv7X3DG
 Y1dtIFMEEMDOqYHOzfyStAVRrwBhbqfQCvH9fGQGxwhOiOMjd9s+IjB3lcTl7wD4x
 f+6IQ5ZQ+Oxax0xzm0YiK7i1hnQuzJSubzXbCcAdllpmlP++DdrBwVmpxUjyJRETK
 9vlTXb8EqhP2uHJVfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1qsJJ131Mv-00XNMK; Thu, 16
 Nov 2023 03:36:30 +0100
Message-ID: <eb73b6b9-118e-48dd-bf12-e26ff7600cbc@gmx.de>
Date: Thu, 16 Nov 2023 03:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
 <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
 <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
 <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
 <CAPnjgZ2P=85dys80aXA4Hss9f=wq9YR+KrNSw5bk+n=W7RFj8w@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2P=85dys80aXA4Hss9f=wq9YR+KrNSw5bk+n=W7RFj8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbrLULMWdnudu8Zem2A1YC+is24AHFMViZICDSwO+fTpoBGUxbI
 ONCFbrlxTY/t+P6VRn/dnSRCmbIXA+0Ucs08SWsVMcpIV8MTEMUcAGxn5XgvgEeYxHbPboO
 eB43uz394iruR3+Tf5wGqSaLXMuBbo3/LpxVi9gLrpq3jbk8phjkrotzxQ8FZvZVtijAYdJ
 ugAAlZAYUneqHORMxlHPg==
UI-OutboundReport: notjunk:1;M01:P0:0c/jqSGjEbM=;79xbf5fyJZvpPQ4QJj3MYVPVq3y
 tIYXpSJ1rmzG5M2A9igxIZMI5AcM1xVOowOazFADbLBm2E4WFOKK+Ovu5coQ8Q3WUuv30P4td
 Iy+XMF8TVyo0QcchEW3/Y6o7IJw++Gvuc3mg3xXOW8/9Ikl4m4n38TlMhAUs9DtDGuBIV2PhP
 KxDHLGTxaszJF0K7CA+ltgql1kcER1AVy3p8C6xfW8Zg48jeciTNtb+0a+vERSvlxoX71a8Eo
 hTJTXv/j7BCEwG0uIdqQpmUwdS/d0FBvTFUeAuCEFcyg6Or+MXedkdPQIsKBFTE5b0xtOL3rA
 I2vZDxlitUeEmt0FFw20dsfubIq0jUhzBoNIikFyUIacZ4dsSSEaOY8oCpurfNycc0oRudtiL
 540HC2H3+zAYs+FullctZx8IqoJTF6Zbo/+xOlVjs9MP49i88Cqc6COlpX1146F2CcNGTrA00
 zx90lZuDPOfuGgXdLBsz2vtFYGhVo1rcbonuCXsIVhTgWh9ssSWHTIeSlEqgN+YNeDUsrwrad
 rD1GBWo2n5BoTuxooKgf3i9vCabzeKBVmkCJJ0cvD+LwCLwqdBbRd+X+jc1UEeHU3HY/3kNXt
 09PI5v2qiFUBomIzbWQSWIl8jRHdXtOzNcOpdlT4frFPBXABSPHk2adJqciT3rmWC9KMGtFyb
 pCALbP+OEcWoGBCHQ3mY/t5DUknTng3hmRZPKmLKssr4HwW75s5ivCtcleZ8Iqqj0N85Qpx8y
 Ho1IOdBH8OUDRIP1ymd28/PhVLRUWWBAxY7sddBeVQw8VJqRo8zj643cUs/p9WCtFYqIBF0wz
 3bdOignjK3maLJRMC+gs4tZI50XJdWbWLXJa/2Dzlgio7xlx3m8+NaGRS5lxT2q3fAvGLICce
 Z6Qs2mdhMLBUgTy+jGxZ0K7CjFwyMiDDkkgF20uFYATl9dQ7GHsnyq+Q9rKgQ6IMTaxq/NvbP
 t9puzCbZCHSzO/rZWwYcNjwx/Co=
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

On 11/16/23 02:39, Simon Glass wrote:
> Hi Heinrich,
>
> On Wed, 15 Nov 2023 at 15:47, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>>
>>
>> Am 15. November 2023 23:15:46 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
>>> Hi Shantur,
>>>
>>> On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur.com> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> I have figured out the cause of the crash.
>>>> It happens here -
>>>> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
>>>> while doing - free(bflow->buf)
>>>>
>>>> As I understand it,
>>>> - Just before starting kernel EFI binary calls usb-uclass->usb_stop()
>>>> - This starts removing all devices in my case ( 6x usb_hub, 2x
>>>> partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
>>>> - While removing bootdev, it ends up calling bootdev-uclass ->
>>>> bootdev_pre_unbind -> bootdev_clear_bootflows which calls
>>>> bootflow->bootflow_remove and bootflow_free
>>>>
>>>> I don't know why this buf cannot be freed, is it because the EFI
>>>> binary in the buffer is still being used ( efi/boot/bootaa64.efi ) ?
>>
>> EFI binaries should never be started from memory allocated with malloc.=
 efi_load_image() should be invoked which allocates EFI memory via efi_all=
ocate_pages(). The handle created has to be passed to efi_start_image().
>
> This is a mess at present, as you are probably aware. EFI has hack to
> look at loaded images and try to patch up its tables.

The UEFI implementation has to follow the specification.

>
> With bootstd we will be able to do this properly.
>
> But note that memory allocation in U-Boot is done via malloc() and
> lmb. We don't call efi_allocate_pages() except in the EFI code.

lmb as used today does not keep track of allocations. It creates a
memory map on the fly which is discarded after usage.

It would be great to unify lmb and the EFI page based allocation. Next
we need to properly allocate memory for loading files and require
freeing the memory before loading a second file into the same location.

The memory available in malloc() is much too small (default 4 MiB) to
handle large files like kernels. malloc() does not keep track of
different memory types that we need in the EFI case.

Best regards

Heinrich

>
>>
>>>> But commenting this line out fixes the crash and linux boots happily.
>>>>
>>>> Fixing this properly is above my pay grade as of now.
>>>
>>> Great, thank you! I will send a patch.
>>
>> Free() typically crashes in U-Boot when freeing the same memory twice.
>
> Indeed. In this case it was not even allocated.
>
> Regards,
> Simon

