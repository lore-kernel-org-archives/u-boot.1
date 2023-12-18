Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0286C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 20:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021B587463;
	Mon, 18 Dec 2023 21:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xgce/ke/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F708874CA; Mon, 18 Dec 2023 21:59:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C594587227
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 21:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702933155; x=1703537955; i=xypron.glpk@gmx.de;
 bh=f6bljqDfa/MJIUTluYSetDk1cWHqyRdHIVgo5nj6YeM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=Xgce/ke/vtE3uVBrdKMVhxAKnEw0E5aIX/MorS/s1RkiK3D/CqpHClbSG9Av/dl+
 aYzCdoZPUvaZsVtHv3OUTUXMedmNAxDsY5gKTOwmx9kb8pQydw3j8m0aB8Zmu9CEE
 4sKOBog5E7sCayIVOKFoHETkU+/WBXjNdTNKo9cCVXVB4zDxjyqRbjnju/7iAQzLo
 0k8wI2Ny4UItzM1D9hi5KHpglKlx8dzGbGLffzfS/GhYuwAbGxj8QyS5AVnVE5Fky
 7Ml56UopEn+qL7WWrzNJYkAUb6xt5d+E9pIN6Nhh47/s6rgAG+XxWNV6chDHzVffP
 kVaF1nnbbOWPPVcEXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1rVnF03yI8-00GbFB; Mon, 18
 Dec 2023 21:59:15 +0100
Date: Mon, 18 Dec 2023 21:59:13 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Abdellatif El Khlifi <Abdellatif.ElKhlifi@arm.com>, Drew.Reed@arm.com,
 u-boot@lists.denx.de, nd@arm.com
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1TsFCzTd2pD3j4SoAhnJWw1qz90DfEzsU6Y-4bSkEf7A@mail.gmail.com>
References: <20231214155346.GB295924@e130802.arm.com>
 <87ttok689d.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKYa1_GrU3XPKqbnOf6VJxx426qTfD1WcSMkmj982ECSw@mail.gmail.com>
 <CAPnjgZ1TsFCzTd2pD3j4SoAhnJWw1qz90DfEzsU6Y-4bSkEf7A@mail.gmail.com>
Message-ID: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q3J5tRwgbB1due2g54cTHVP+cwl0Ik3whqDEOVHv6Hx0tvonPYC
 DYs2G//H4WS9biCXgTXJ5r7cCbXyb+tBpswsoTAiznz1F8kJQUOt8cCxi8r8yA4VBZmhAgl
 6x+lDvy6iab338mJlyqlmjcLRAOwofw+A1EyxH7igFhxX16j6qakEQ6QjEAN7FjHu/458GA
 +dIFUseT5kPIbfvTwPg1g==
UI-OutboundReport: notjunk:1;M01:P0:QXRTRCFJCjc=;TrO2nG8AicT/4ua0pCsFljcDi4e
 kA3Mbl8zgM/DW4t0H/dpgplvB9+5UedW5K3QyRkjIceSUNRGqK9Tzz6GdADWoE74R9Ho0Zl5a
 EeYm7DPugV0EeLWang3dybUrVBsvYsIBo2vYjkcfGmW+AJPcdWoOhD3QbNb9FmikooIs6f4Sg
 6M8P5CBkqd15c54zZl58wa+/RN2s9PUMgTWEp0SPYl80qzIIgBTUKuXNbFHAWWsfZsqMcnZji
 N2LQWMCks3mh51F3DVIZX4VeHicse9LJkdTLVZHROHx5UeJ6PPQNL6gnaHEeatvPAsh52FNmz
 L5qdBZbvEPKZJIWyU0AXJ7kQu5TOfWCxrZu5iFeG3QqHQ0INJeDj8eFf8F4CKXqQEJ+mHDPN8
 xiBaqXgCqbWv8lrvWKpDdu207I7jIsN2xP7m0cqy7gR8O+7bTsFVoyh7iDhyj3m8x1hVskR3U
 W+FcHe3D8H4cXFiz0gIhHcL+mASjnI8eF1U8kojuhaWOUbYLiXtkB4qdt1N+83ZJL78V7Aq2T
 mlb+gZ1MSsZ/i2x99W7qJ1L1FeMnCb4R9lWQAD1LWj+NU2DgRJXnhmxsrEqT9sN3K7TMlyZjT
 xBmDT+K5zHHANNQy3o5rmjIqyWFsR+dhMf7QqXeN1l3Dp7zJ70OM6oczD8dsQUcDU2mSaHey1
 dsj0BoMzD95erLHxWdCCvCdqEQvKLPc08HvAKDQkasyZASojU8WZIjNxtGcsza3tY3KaxoLjr
 FJ9g9SVASMqmbNgTtQT++x3qiBVg4jKTZN+Ju8IVQroxrpli+T3e4+tutMe2bKmlBUM833qkZ
 b8pYUtZRimGnMAGbnNvx9YDtzl98mUe4KJlnN+uNogv9FP7exOxWi/ACSD0FJmMehKhCsR6tr
 wx6N2HE6Mw+HZdY/MlzIj5WbhF8fWMqSGEOz4TkvgHcPfMuFUTfTd9beKFoLZ+U77wXMLt7Vz
 YnZnN4fV3WZFSIwUAY0PaK69tsg=
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



Am 18=2E Dezember 2023 16:01:44 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi,
>
>On Thu, 14 Dec 2023 at 12:47, Ilias Apalodimas
><ilias=2Eapalodimas@linaro=2Eorg> wrote:
>>
>> Hi Mark, Abdellatif
>>
>> On Thu, 14 Dec 2023 at 18:47, Mark Kettenis <mark=2Ekettenis@xs4all=2En=
l> wrote:
>> >
>> > > Date: Thu, 14 Dec 2023 15:53:46 +0000
>> > > From: Abdellatif El Khlifi <abdellatif=2Eelkhlifi@arm=2Ecom>
>> >
>> > Hi Abdellatif,
>> >
>> > > Hi guys,
>> > >
>> > > I'd like to ask for advice regarding adding EFI RT support to the A=
rm's FF-A bus
>> > > in U-Boot=2E
>> > >
>> > > The objective is to enable the FF-A messaging APIs in EFI RT to be
>> > > used for comms with the secure world=2E This will help getting/sett=
ing
>> > > EFI variables through FF-A=2E
>> > >
>> > > The existing FF-A APIs in U-Boot call the DM APIs (which are not av=
ailable at RT)=2E
>> > >
>> > > Two possible solutions:
>> > >
>> > > 1/ having the entire U-Boot in RT space (as Simon stated in this di=
scussion[1])
>> >
>> > I don't think this is a terribly good idea=2E  With this approach ord=
ers
>> > of magnitude more code will be present in kernel address space one th=
e
>> > OS kernel is running and calling into the EFI runtime=2E  Including c=
ode
>> > that may access hardware devices that are now under OS control=2E  It
>> > will be nigh impossible to audit all that code and make sure that onl=
y
>> > a safe subset of it gets called=2E  So=2E=2E=2E
>>
>> +100
>> I think we should draw a line here=2E I mentioned it on another thread,
>> but I did a shot BoF in Plumbers discussing issues like this,
>> problems, and potential solutions [0] [1]=2E Since that talk patches fo=
r
>> the kernel that 'solve' the problem for RPMBs got pulled into
>> linux-next [2]=2E
>> The TL;DR of that talk is that if the kernel ends up being in control
>> of the hardware that stores the EFI variables, we need to find elegant
>> ways to teach the kernel how to store those directly=2E The EFI
>> requirement of an isolated flash is something that mostly came from
>> the x86 world and is not a reality on the majority of embedded boards=
=2E
>> I also think we should give up on Authenticated EFI variables in that
>> case=2E We get zero guarantees unless the medium has similar properties
>> to an RPMB=2E
>> If a vendor cares about proper UEFI secure boot he can implement
>> proper hardware=2E
>
>Just to copy in my thoughts as they are lost at this point:
>
>> We would need to publish a runtime interface with access to the driver
>> API=2E I did ask for this when the EFI runtime support was added, but i=
t
>> wasn't done=2E
>
>> It would be possible to create a new 'runtime' phase of U-Boot (RPL?),
>> separate from the others=2E That will be much easier once we get the XP=
L
>> stuff sorted out=2E, since adding new [hase would be fairly trivial  CP=
L
>> died as another contributor had a series which went in first=2E=2E=2Eth=
en I
>> never got back to it=2E
>
>> So for now having the entire U-Boot in runtime space seems reasonable t=
o me=2E
>
>> I'll also mention that it would be nice to have s new-style API
>> (replacing the old API U-Boot currently has) which uses more of a
>> module approach=2E E=2Eg=2E we could declare that uclass_first_device()=
 is
>> exported and can be called from outside U-Boot=2E
>
>>
>> >
>> > >
>> > > 2/ Create an RT variant for the FF-A APIs needed=2E
>> > >       These RT variant don't call the DM APIs
>> > >       (e=2Eg: ffa_mm_communicate_runtime, ffa_sync_send_receive_run=
time, =2E=2E=2E)
>> > >
>> > > What do you recommend please ?
>> >
>> > =2E=2E=2Ethis is what I would recommend=2E  Preferably in a way that =
refactors
>> > the code such that the low-level functionality is shared between the
>> > DM and non-DM APIs=2E
>>
>> Yes=2E The only thing you need to keep alive is the machinery to talk t=
o
>> the secure world=2E The bus, flash driver etc should all be running
>> isolated in there=2E In that case you can implement SetVariableRT as
>> described the the EFI spec=2E
>
>The current approach is pretty brittle, since it relies on putting
>some of the U-Boot code into a separate area=2E There is no good way to
>know which U-Boot code should be in that area, since we don't create a
>separate build=2E If a function calls one that has not been specially
>marked, or accesses data that is not in the area, then it will crash
>or hang=2E
>
>So, as I said, I think we need a new build, if we want to avoid all of
>U-Boot in there=2E Anything else is hard to maintain=2E

The EFI runtime is the most security exposed part of U-Boot=2E We should s=
trive to keep the attack surface small=2E No matter how we define the runti=
me (by section assignment as today or by a dedicated build) I would not wan=
t to have the driver model in the runtime=2E

The only drivers that are required by the EBBR are for resetting the syste=
m=2E ARM has PSCI as reset handler, RISC-V has SBI=2E These are invoked by =
simple ecalls=2E

Any runtime device drivers for variable storage should not be in the U-Boo=
t runtime but live in the secure world (e=2Eg=2E OP-TEE)=2E FF-A is the new=
  ARM protocol for talking to the secure world and hence fits into the pict=
ure=2E

@Abdellatif=20

Does an OP-TEE module for managing EFI variables via FF-A already exist? F=
or QEMU?

Best regards

Heinrich

>
>>
>> [=2E=2E=2E]
>>
>> [0] https://www=2Eyoutube=2Ecom/watch?v=3DUdQk0SCUAlA
>> [1] https://lpc=2Eevents/event/17/contributions/1653/attachments/1338/2=
682/Plumbers%20-%20EFI%20setvariable%20problems%20and%20solutions=2Epdf
>> [2] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/next/linux-next=
=2Egit/commit/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
>>
>
>Regards,
>Simon
