Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076FEECE57A
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B928902F;
	Tue, 10 Sep 2024 14:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="M5NgfCWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F21C89044; Tue, 10 Sep 2024 14:37:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F42188F63
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1725971817; x=1726576617; i=frank-w@public-files.de;
 bh=BNSTeQDM0qnR/pDdPeN7d7lDRqylcWbFztOWaG0T3DM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=M5NgfCWn7mxUK1gXA+aZDwtdLJS2vZyRWbiyiQ4pTeAs4x2r2aprXltHKAJyWUXo
 B5PxAADu38CuNxRMojUW5g3Rd3U2D0V/tjqjfIRFKACmQk+6omyzb+Y0QllgnA+58
 U9SLbbJerZ+AHLxFc5su2OVzgQSErkzndys1HFP/7FyObznInGbesW4sRjzI5/wZW
 VwDSR7G43WZhZVTsdohNrh4X8DFNeY6pmKYnM8hd7UYaqHYgR72L6vIWeAtd8mIsI
 AGB4LX2Q/qZNTH6LycKH7oiFxNCukdNy1FlRtK1kD4+935ZNFDtmJU62EGSUIdHYh
 hTahE08Uq9r9wB6uXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.71.49]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1sAlPU1KYj-00g3yO; Tue, 10
 Sep 2024 14:36:57 +0200
Date: Tue, 10 Sep 2024 14:36:56 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, Sumit Garg <sumit.garg@linaro.org>
CC: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: OF_UPSTREAM vs. additional dtbs
User-Agent: K-9 Mail for Android
In-Reply-To: <62a7a500-0d56-49db-8e6f-b88fc4c84328@siemens.com>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
 <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
 <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
 <CAFA6WYM7n+cbFFrN8nH67pYCGo9ENn5Avv-2QOMA4U_ws+9ogw@mail.gmail.com>
 <62a7a500-0d56-49db-8e6f-b88fc4c84328@siemens.com>
Message-ID: <F8A56817-F488-4B94-8ED3-1A29EACAD137@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3WEloFVHM+REiLZtFaQmuRSmKN70JP7MjooF/sKy10fM66Rrf/T
 gZw4ZjOAjRPC57W3ltFjGGz5UIvo0E2sdSTbVBLMqxsqHQx+XQlCnhkDCOUt2NSMlHu7K+w
 LJCxMkB/RXfIMtM/Pfg7slqz99Q77TeEZb1R/9IhP+0F0FMVoN67qTkET5qX31+jtS2NGC6
 m4uY8Z8VisQ7ttVhagsEg==
UI-OutboundReport: notjunk:1;M01:P0:UuAx9dbIKKo=;JTv6Mz7djvhsX7fXY5sgJn67IeQ
 smS84BkulCwappD6bbcVS/U4BRYGikpfqAeDNFiImVNJuuDyzaWhPWP3iPVGVKmWvNt+eKxni
 7EglOj6zsOpHzWxfD0haX4uAYAF0gmofzSX3kEUDaWVxhlA1enAP8pzi7954SEha+uh+B4qb8
 EeFhVdcE5cRWu5K+/QQOj+nbjskmImORzgHdQR86mMl39CsS4nOvC0rp1hTWFMvCMu+ZV9yg/
 H40bxZcE1Bf79MDZv7gHZSpqbPT2gRM+jh/DtiHrv5+sc7Hqn+mDBvmxMsFpu1GJl2/4vxFg1
 k+mcNUmsZf6EDostexrIITJsCi3LqiNc26QiNW/SegcBmGhBW4BeYaZvem1+E/jDWSsynCvJ/
 l4hIk+0zCycMrlfP90FrXnq1RSElW/Eii2EMaxoZRupJ1gkY/0gDMuLfragToAcSGDTiUZ5Os
 xx+t6jXked6hpICjze/55bmw4QM8Sef0DKgmRt88TSrxYOJTgi8GRFiaqgcedESP/kAF5n6cQ
 kqgr2E+SWnvKT5A7zL7NXL8VNPigOYpQJ3FLGIdCV0RqfmVRHlQ6mBpl8U29AlltZgMN31h20
 Rvo3Nx89bLr7ghYBT87ukLwI5Igcv9vIHKJNkyIhb+VyvnQ7LEpjn/NZuY67LGYIitSOfuqx+
 NcUjh39jsdn9vgaIHvzZ9va9vZXdHpYppkEDpcH+5izgJnJoLag6cQ5ffgS4ZsuMh2YVoigOe
 85zeRXcnaOpsGoVvqZ5c2qKZehATJG+I4uwDlspNRxWbl7uAtP4a9tNjihbqNqGgcEDQaJPQ1
 9HlFFS5U83sWDhPbfrL+6pGg==
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 10=2E September 2024 14:08:07 MESZ schrieb Jan Kiszka <jan=2Ekiszka@siem=
ens=2Ecom>:
>On 10=2E09=2E24 08:38, Sumit Garg wrote:
>> Hi Jan,
>>=20
>> On Thu, 5 Sept 2024 at 12:08, Jan Kiszka <jan=2Ekiszka@siemens=2Ecom> w=
rote:
>>>
>>> On 04=2E09=2E24 19:29, Frank Wunderlich wrote:
>>>>
>>>>
>>>>> Gesendet: Mittwoch, 04=2E September 2024 um 19:16 Uhr
>>>>> Von: "Jan Kiszka" <jan=2Ekiszka@siemens=2Ecom>
>>>>> OK, our overlay sources are on their way into mainline, will only ta=
ke
>>>>> until 6=2E12-rc1 to get them here=2E
>>=20
>> Glad to hear that=2E
>>=20
>>>>> To accelerate the preparation, I ported
>>>>> that change to a local branch - just to find out that OF_UPSTREAM ha=
s no
>>>>> clue about DT overlays so far=2E And it is not just that there are n=
o
>>>>> build rules for them (that was quickly fixed)=2E It's also that ther=
e is
>>>>> no way to trigger their build for your u-boot proper=2E
>>>>>
>>>>> Are there plans for addressing this? I'm inclined to revive my patch
>>>>> that allows to augment dtb-y from the board's config=2Emk=2E Better =
suggestions?
>>>>
>>>> Hi
>>>>
>>>> i hang also on this part, in my case i build the dtbos for the vendor=
 and try to use fdtoverlay to merge base-dt with the defined overlays=2E
>>>>
>>>> see commits till July 11th
>>>>
>>>> https://github=2Ecom/frank-w/u-boot/commits/2024-07-bpi-ofupstream-al=
l/
>>>>
>>>> this fails because the target for fdtoverlays needs targets for the d=
tbos (have used the fdtoverlay target from linux)=2E=2E=2E
>>>> but i build then without dedicated target (while building the basedt)=
=2E
>>>>
>>>> maybe you can help solving the "small" problem in makefile=2E
>>>>
>>>
>>> This is close but not quite the same scenario because I only need "our=
"
>>> dtbos, and there is no need to create dtbs with them applied (they wil=
l
>>> be used during dt fixup in our case)=2E

Where do you apply the dtbos? In my case it is
necessary to build the dtb with overlay as we have
no way to detect which overlay needs to be
applied=2E

We have overlays for different mmc (sdmmc/emmc)
and spi (nand/ nor) settings which cannot be probed at runtime (or at leas=
t we have not found=20
a way to do this)=2E


Maybe someone can help getting ftdoverlay target working in uboot with the=
 dtbo list=2E

>>> What I've now done is this:
>>>
>>> diff --git a/dts/Kconfig b/dts/Kconfig
>>> index 569d4be338e=2E=2E7ea4fd5a79b 100644
>>> --- a/dts/Kconfig
>>> +++ b/dts/Kconfig
>>> @@ -226,11 +226,11 @@ config OF_LIST
>>>
>>>  config OF_OVERLAY_LIST
>>>         string "List of device tree overlays to include for DT control=
"
>>> -       depends on SPL_LOAD_FIT_APPLY_OVERLAY
>>>         help
>>>           This option specifies a list of device tree overlays to use =
for DT
>>>           control=2E This option can then be used by a FIT generator t=
o include
>>> -         the overlays in the FIT image=2E
>>> +         the overlays in the FIT image or by binman when assembling a=
n image
>>> +         that uses overlays during DT fixup=2E
>>>
>>>  choice
>>>         prompt "OF LIST compression"
>>> diff --git a/scripts/Makefile=2Edts b/scripts/Makefile=2Edts
>>> index 790f3c508f1=2E=2Edc181240a21 100644
>>> --- a/scripts/Makefile=2Edts
>>> +++ b/scripts/Makefile=2Edts
>>> @@ -1,6 +1,7 @@
>>>  # SPDX-License-Identifier: GPL-2=2E0+
>>>
>>>  dtb-y +=3D $(patsubst %,%=2Edtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TR=
EE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>> +dtb-y +=3D $(patsubst %,%=2Edtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)=
))
>>>
>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>>  ifeq ($(CONFIG_ARM64),y)
>>>
>>=20
>> Yeah that's all you need to build DT overlays from dts/upstream
>> subtree=2E Care to send a proper patch for this?
>>=20
>
>Can do if you already want this [1]=2E Our tree [2] where it is currently=
=20
>included still has to wait for upstream 6=2E12, possibly even 6=2E13 as w=
e=20
>need one more overlay now=2E
>
>>>
>>> I will also provide a patch to enhance the machinery in dts/upstream
>>> /Makefile=2E This apparently plays no role when building U-Boot, but i=
t
>>> would still be useful for validation purposes to have overlay support
>>> there=2E
>>=20
>> As you mentioned we don't use Makefile for U-Boot builds=2E So it's
>> better to directly send that patch for inclusion in the DT rebasing
>> tree=2E
>
>No, this is about our shadow Makefiles, see [3]=2E
>
>Jan
>
>[1] https://github=2Ecom/siemens/u-boot/commit/2be0393b1718990abf2feb0b13=
dbaf79629ce692
>[2] https://github=2Ecom/siemens/u-boot/commits/jan/iot2050
>[3] https://github=2Ecom/siemens/u-boot/commit/de3df1fed47d2075bb3f9ecccf=
aa93a368b58924
>


regards Frank
