Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E0DC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373D788873;
	Thu, 13 Jun 2024 22:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="l6UxaHud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED8E880E5; Thu, 13 Jun 2024 22:11:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E5788861
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718309483; x=1718914283; i=xypron.glpk@gmx.de;
 bh=AHTksP9X36IonzShG3CZ4qCet225PH8Z8Lc2NAYr9n0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=l6UxaHud7ve8RgKCY7qbG1vUmYLBiWw0Nj/Q8YAnl5DNsTa9XyLDl7qyHYCBwpGB
 PE53LInlA3+Wh/jMzXkx1UDs4VTtJxgufFJkQh6y/YR9YIi8GgJywD7TcgI5Rxt/m
 Muw5pa3OpZGReRRy7qsr6/9FZHAIyShoQKB5MFFcjSiw6dsKClqMDG8c+Cb/jQKDK
 /P6Lr1XeoWaYctdBQkeWNQLNJ80/LNXjr02CHbXg7M6ttK75U/rpo7/ARuXPfocxo
 eKybUIjxxHC3q0vKyyqSIwiD0XAUiSgiCaHaSsfLYoj4Jb4ev9gmqGsTeg7ar0uhT
 F08iIzYRwMxSIsh82w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1rtbnf3DQG-00JVcr; Thu, 13
 Jun 2024 22:11:23 +0200
Date: Thu, 13 Jun 2024 22:11:22 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_04/31=5D_lmb=3A_remove_local?=
 =?US-ASCII?Q?_instances_of_the_lmb_structure_variable?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTjMnxN-pNLxe=pamC=OQpKtPRAL0Xrr17x8Sn+oU+8gQA@mail.gmail.com>
References: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
 <20240613154206.GO68077@bill-the-cat>
 <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
 <1604c2a7-d72e-491f-806f-da29d14f0a17@gmx.de>
 <CAFLszTjMnxN-pNLxe=pamC=OQpKtPRAL0Xrr17x8Sn+oU+8gQA@mail.gmail.com>
Message-ID: <0397EEF3-D89D-45CC-BBA9-961DE973249E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B84Wv43LbXqm9lkh1LtxB9ezyC8snUTghB11n9sU493jT5dn8w0
 l1VAbRJcBsNUKwt2VW9Jh/fHljey+RhtcAWHwwPgepHozAkZhs5G30JgR6SWjilIVd7r6f5
 Y0U68HMBPuOyfyeXZJq5H3Y67QPQl+pKVJPpRAiGAiVeIi/LiSgR6azAd26ASDCL/Qhzez/
 MxJsk38SnEK+Rwmn8VXPw==
UI-OutboundReport: notjunk:1;M01:P0:NcmGt2V+n5Y=;4aJWgbn0Gg3/eeJsfNwx/jwxW53
 aTURR1c8VbRoBeMMjn90A7dZUMgKZnwBZQVpPoZOEiKvSHfoHaNaAbU9Ry05rMPiQCPxkjj1w
 hubUHXc51BjZKTT8E7pjHDbdGmOvS9Q2emXPOWrnmumVpQbjZ/LYy2rOuQ0EdgX4k9xcOTqGe
 TG8Gah6E8TonYmf/vm/70NlXeNmhzRCOqrBoZP1FiNF8JFkvIDyK3lMHKe+exi9OiUuze3U9Q
 7FVpCImWVQQZGgd2SD/2pRbtDqHrK5Q1JuApsCfpNoeSbSRBrSLwp6hYTe91s4y3PlTq8+yT6
 VtNSTgNmxfoYZ0zvnRSJL6jiQkMRUeVvS5tF+9xfyDR+fOJ+C0iWJSLFNypahwgWcl+lLOdVD
 ysO3VgPG4eIEJH/1sb3WD/fQdo7o8vWrMZr7OTjj1fx/IIAFVN5xgdT1nEVk3ZxxHAv2zfS2v
 KAIpEwFD8Z/G0ydpq57x9U/77jr81/0NdNQRAQOUd8VGrDQ4IDWXDLBnBKKafo1JtISVziL9E
 0E70iUFT2E77plTl+R9FI/UdfCg/xDgQPZi7Mnog/pzIgGDHwSrZJ5gB9SwvPQaUelApvO4Ws
 HsjpjypzQ8xygcQ+l6V06MrI/ZST7uaXKudjzZrMxDi1S1ZR6iQ5POIPtwU2rRvhsHSYLcy4L
 Rm8l0bUwVW5M85PAGdY+G/mp5eZPsAobWNZuP+GgGCFBW3yduUtmMvV4wkgmO+0QZ0TKqS5lb
 rthAjrjlyA3kMaY+FJreijRimMkLjxV+4xCN2pTcTSrBLvlR9DpTx1brG/VI/XrMDptRKpZhp
 QPxpJE1dt9UkKaGyvhFy7jGaoAXcEJgRKQLfX8ooTxknk=
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



Am 13=2E Juni 2024 21:05:58 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Heinrich,
>
>On Thu, 13 Jun 2024 at 11:32, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 13=2E06=2E24 18:59, Simon Glass wrote:
>> > Hi Tom,
>> >
>> > On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >>
>> >> On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
>> >>> Hi Tom,
>> >>>
>> >>> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko=2Ecom> wrote=
:
>> >>>>
>> >>>> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
>> >>>>> Hi Tom,
>> >>>>>
>> >>>>> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko=2Ecom> wro=
te:
>> >>>>>>
>> >>>>>> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
>> >>>>>>
>> >>>>>> [snip]
>> >>>>>>> Also IMO there is only really one LMB list today=2E We create i=
t at the
>> >>>>>>> start of bootm and then it is done when we boot=2E The file-loa=
ding
>> >>>>>>> stuff is what makes all this confusing=2E=2E=2Eand with bootstd=
 that is
>> >>>>>>> under control as well=2E
>> >>>>>>>
>> >>>>>>> At lot of this effort seems to be about dealing with random scr=
ipts
>> >>>>>>> which load things=2E We want to make sure we complain if someth=
ing
>> >>>>>>> overlaps=2E But we should be making the bootstd case work nicel=
y and
>> >>>>>>> doing things within that framework=2E Also EFI sort-of has its =
own
>> >>>>>>> thing, which it is very-much in control of=2E
>> >>>>>>>
>> >>>>>>> Overall I think this is a bit more subtle that just combining a=
llocators=2E
>> >>>>>>
>> >>>>>> I think this gets to the main misunderstanding=2E The problem is=
n't
>> >>>>>> handling bootstd, or EFI boot, or even assorted scripts=2E Those=
 are all
>> >>>>>> cases where things are otherwise (sufficiently) well-defined=2E =
The
>> >>>>>> problem is "security" and that a "carefully crafted payload" cou=
ld do
>> >>>>>> something malicious=2E That's why we have to do all of this stuf=
f sooner
>> >>>>>> rather than later in our boot process=2E
>> >>>>>
>> >>>>> That's the first I have heard of this, actually, but a bit more d=
etail
>> >>>>> would help=2E How does the payload get loaded? I'm just not sure =
about
>> >>>>> the overall goals=2E It seems that everyone else is already famil=
iar -
>> >>>>> can someone please take the time to point me to the details?
>> >>>>
>> >>>> Well, the short version I believe of the first CVE we got (and so
>> >>>> started abusing LMB) was along the lines of "load an image near wh=
ere
>> >>>> the U-Boot stack is, smash things for fun and exploits"=2E
>> >>>
>> >>> OK=2E I am surprised that LMB does not catch that=2E It is supposed=
 to add
>> >>> the stack and various other things right at the start before loadin=
g
>> >>> any file=2E So even if it clears the LMB each time, it should not b=
e
>> >>> able to do that=2E Having said this, the code may be buggy as I don=
't
>> >>> think we have tests for U-Boot's overall functional behaviour in th=
ese
>> >>> situations=2E
>> >>
>> >> Right, LMB does catch the example I gave (because we made all of the
>> >> load from storage/network functions init an lmb and we always make s=
ure
>> >> a new lmb gets U-Boot stack/etc)=2E The next thing we didn't catch w=
as
>> >> "what if EFI does the loading?" and we've kludged around that, and i=
n
>> >> turn had some of the thorny questions=2E Some of that is what I thin=
k
>> >> you're asking about in this part of the thread, to which the answer =
is
>> >> "EFI spec says you need to place X in memory", so we just need to
>> >> reserve it when it's asked for, so that something else can't come al=
ong
>> >> and smash it maliciously=2E
>> >
>> > OK I see=2E Of course it isn't just EFI that has this issue=2E I beli=
eve
>> > the answer (for small blocks) is to use malloc(), which I think we do
>> > with a few exceptions which Ilias pointed out=2E For things like the =
TPM
>> > log and ACPI tables we should probably use a bloblist, as we do on
>> > x86=2E For large things (like loading a kernel) we should use LMB=2E =
I've
>> > been thinking about how best to tie this to boot, as opposed to rando=
m
>> > allocations in U-Boot itself, which would lead to fragmentation and
>> > strange behaviour=2E I think bootstd is a great place to have a
>> > persistent LMB=2E It can be attached to bootstd_priv=2E
>> >
>> > My hope is that EFI is just another boot method, where
>> > already-allocating things are presented to the OS=2E Apart from the
>> > Ilias exceptions, I believe this is how it works today=2E
>> >
>> > Where I think this heads in the wrong direction is using
>> > EFI-allocation functions before we are booting an EFI image=2E EFI ha=
s
>> > no concept of what is 'in empty space' so it leads to the lmb
>> > conflict, the subject of this discussion=2E
>>
>> EFI binaries can return to the command line interface=2E
>> EFI binaries may be drivers that stay resident and run in the backgroun=
d
>> after returning to the command line interface=2E They might for instanc=
e
>> provide block devices=2E
>
>Hmm you mentioned that before but I'm still not quite understanding=2E
>Do you mean that the EFI app returns back to U-Boot, leaving the

There are 3 types of of EFI binaries:

* apps
* boot time drivers
* run time drivers


>driver active? If so, how does U-Boot use the driver? I'm just not
>familiar with how such a construct could work in a single-threaded
>U-Boot=2E

We already have code for EFI block devices=2E See lib/efi_driver/

When U-Boot reads from such a block device it may end up in an EFI driver =
that for instance uses U-Boots network drivers exposed as EFI simple networ=
k protocol to read from an NVMEoF or iSCSI server=2E

>
>>
>> Device-paths must be created from EFI pool memory as they may be freed
>> via FreePool() according to the EFI specification=2E And these we creat=
e
>> whenever a block-device is probed=2E
>
>The implementation of pool memory rounds up to pages and uses that=2E It
>might be more efficient to use malloc()/free() instead, given that we
>mark the malloc() space as reserved when we call the EFI app=2E

We have requirements on which EFI allocations may reside in the same page=
=2E See the ARM chapter in the UEFI specification=2E

Best regards

Heinrich

>
>>
>> We should not make any assumptions that conflict with the UEFI
>> specification=2E
>
>Indeed=2E
>
>>
>> In our initial discussion with Ilias one idea was to merge LMB and EFI
>> memory management=2E This merged system would have to consider the
>> requirements of the UEFI specifications like a finer grained memory typ=
e
>> system and page boundaries=2E
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > This is all quite subtle and probably worthy of a VC discussion=2E
>> >
>> >>
>> >> But that also raised the more general problem, and why we need a
>> >> persistent reservation list, of allowing boards/SoCs to say they wan=
t to
>> >> reserve a block of memory for whatever, and have that obeyed, for re=
al=2E
>> >> For example, the mach-apple logic of "just pick some memory location=
s to
>> >> use for kernel/dtb/initrd" isn't really as safe as it should be sinc=
e
>> >> those reservations aren't really seen anywhere once the function
>> >> returns, it's just setting some environment variables=2E
>> >
>> > Yes, that part of it I understand=2E Somehow I either didn't see or
>> > forgot that board_late_init() code=2E With the script-based boot it
>> > makes some sort of sense, but with bootstd we should have allocation
>> > of addresses dealt with there=2E I have held off on retiring
>> > kernel_addr_r etc=2E as the scripts are still in use=2E But perhaps i=
t
>> > would be a good time to convert bootstd to use lmb instead?
>> >
>> > Regards,
>> > Simon
>>
