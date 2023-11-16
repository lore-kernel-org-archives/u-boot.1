Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1C4C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B488724E;
	Thu, 16 Nov 2023 03:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fhXhzPzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2075C87447; Thu, 16 Nov 2023 03:01:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE1D87128
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700100083; x=1700704883; i=xypron.glpk@gmx.de;
 bh=5qdKyHgYEDkYJr6WOSYuC+M1qqR1VA8mLZqLZK+MDyQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fhXhzPzWrhNJ5So/LAdzNE4vnBpQQEdTHgHyC2EYQq9XVWNFJ6d4czB4mPccodJO
 LyqNH87dt8OrRnCAxyaRiEKtuzCFOzz81inqOlehXs9EpABUQ39lJ2I+5eyuMEPdy
 AGuyRJtBMN0DbY7ES/iUQRXptjmi57a/JCL3UVviD7o3elYDIS9cUBjlokqMqG28L
 EkMSTXbif2XJIOO46hil1M8LqRo+m0paTMb/eNj/gxEZWBWbhgY/hTnPQnijFo+qh
 bICqn36n5bm7lOt/g4gxeP1UPpOXnwVERyagqzGPPAoKgzq6CwwEp5CgZ4fwg1tcd
 5smaz710pCepQIZZRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1qjqCu36xH-00P66d; Thu, 16
 Nov 2023 03:01:23 +0100
Message-ID: <f3b89670-8e6b-428a-b391-a1d70b2af30f@gmx.de>
Date: Thu, 16 Nov 2023 03:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>, Shantur Rathore <i@shantur.com>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
 <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
 <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
 <58076384-d164-4d7a-bc1f-c78574b481b5@gmx.de>
 <487c3e73-ce21-4e45-9cf3-44314e78fd1f@gmx.de>
 <CAPnjgZ1-DBbt7caZRwvEWO+OcCZtJ821ZkVr--NPZGg1wE1R=Q@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ1-DBbt7caZRwvEWO+OcCZtJ821ZkVr--NPZGg1wE1R=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Unv36x/4BFCETXXvzHhmOsXSAPfdBC1TUkedgk2QiwJ+Y1VHXpN
 4oEq0Z4s2sKJDHjjbrw5DmbHBtkD1QiXpRTehkHq4eej4/KHSLyCMfIMAIUEsgFPHCs3c+/
 DrhkBUfD2cUrTTCUjXf6qTze9WitGlqdxbr3UksAYnB2wvyO2vT352oY2rVfbzBSQxPzMrC
 nB+iJx8UBavU47l4+HE4w==
UI-OutboundReport: notjunk:1;M01:P0:u6JqCnQsiHM=;hAiJDGt5Bk2faLTpa+1lwRa2Yc6
 SAjz2h9fbWBkBzQQYuhbnzXgEHIY9OnngMeDxuduADobC7DlsxKsMyGLHb5JTvyMUAj8N2AEy
 geqVRGz2XMFhMNhaY+aFVrPIoCuqdkn64cP0xCBDezd2kNSSqZy66KTIpbiN7r2guR/CxFRk0
 yAhMktbkqNOC0CSE3/7IMHnn7p4WWUh/inr4Byn+VGKFk8bDXVFN5+zFzmeAPR/yrYum20FtP
 B53enSc2AWg4Snm1ZH0oRIBmeIPqKupjCv22rSZa0Q2V3zx/nZ8YpdbCHmzVczys+mS3frvJE
 k2iTH0CeTe8387JU1gM/IjN3aOZgJuZOaBxDL+5wcbfiC5YsNMBaRWzKEpEjVJmwkmc6uDXMU
 f9JEGsK964gY+9PGsDBdbUzWMkPKmH7j/vQ89/vwLXs6U9rKkR1JJtTQL+TvJm9AXDQ7ztn65
 rcls8wI+SP1kaVRlAReSzvH0wSlkjK0kR1OAfq0CuDPnSiLoQki4yknMEDeR0N879TNrPGT0E
 EW26ItepBNMZuNV5l+awBQ3TZrymJ1V0n8o5NNKzs8qznDWZfyBIV3p3M8rOcjrfr0X40w+Q9
 0buEQ8RGzJVSTMadpHq5e9iD7iaIIiROXaluvyOJEPFnLxLNpzFGkWItUxVU1t5qM7kMOvv22
 udO7fIhfGDUpFU0WecguN1gcF2UzAJNwQuuCuD6dCUph/C7V5RdaaBd74PIXi9zNuHkoJZF1W
 PebnkqKWy5bVud7JGg95rfPhZS+qF9aSxOchxBAwX+K5eqkXB5AQ1v63qJ7+NzjfjXABO/9J7
 kaOGkLLv2BDguTBYx39kvBF2teDf+crdqYcfg8IG27KlKC6cav32CLT3ao8qymPjYUezErpY2
 Ny+CMEFW6QKf9z0UnQ7b7i9DDQv0kHGfMc8meScYQUcLWJ4L6ahex3GzNqt2NA3ECj300ue1R
 N9tF/foa8uAhk0cbrmXHSTgy5nM=
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

On 11/16/23 02:42, Simon Glass wrote:
> Hi Heinrich,
>
> On Wed, 15 Nov 2023 at 18:34, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 11/15/23 17:23, Heinrich Schuchardt wrote:
>>> On 11/15/23 16:50, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de=
>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass
>>>>> <sjg@chromium.org>:
>>>>>> Hi Heinrich,
>>>>>>
>>>>>> On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt
>>>>>> <xypron.glpk@gmx.de> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass
>>>>>>> <sjg@chromium.org>:
>>>>>>>> When a USB device is unbound, it causes any bootflows attached to
>>>>>>>> it to
>>>>>>>> be removed, via a call to bootdev_clear_bootflows() from
>>>>>>>> bootdev_pre_unbind(). This obviously makes it impossible to boot =
the
>>>>>>>> bootflow.
>>>>>>>>
>>>>>>>> However, when booting a bootflow that relies on USB, usb_stop() i=
s
>>>>>>>> called, which unbinds the device. For EFI, this happens in
>>>>>>>> efi_exit_boot_services() which means that the bootflow disappears
>>>>>>>> before it is finished with.
>>>>>>>
>>>>>>> After ExitBootServices() no driver of U-Boot can be used as the
>>>>>>> operating system is in charge.
>>>>>>>
>>>>>>> Any bootflow inside U-Boot is terminated by definition when
>>>>>>> reaching ExitBootServices.
>>>>>>>
>>>>>>>>
>>>>>>>> There is no need to unbind all the USB devices just to quiesce th=
em.
>>>>>>>> Add a new usb_pause() call which removes them but leaves them bou=
nd.
>>>>>>>
>>>>>>> As U-Boot must not access any device after ExitBootServices() it i=
s
>>>>>>> unclear to me what you want to achieve.
>>>>>>
>>>>>> I can't remember exactly what is needed from the bootflow, but
>>>>>> something is. Perhaps the kernel, or the cmdline, or fdt? It would
>>>>>> have been better if I had mentioned this explicitly,  But then this
>>>>>> patch has been sitting around for ages...
>>>>>>
>>>>>> In any case, the intent of exit-boot-services is not to free all th=
e
>>>>>> memory used, since some of it may have been used to hold data that =
the
>>>>>> app continues to use.
>>>>>
>>>>> The EFI application reads the memory map and receives an ID which it
>>>>> passes to ExitBootServiced() after this point any memory not marked
>>>>> as EFI runtime can be used by the EFI app. This includes the memory
>>>>> that harbors the U-Boot USB drivers. Therefore no drivers can be use=
d
>>>>> here.
>>>>>
>>>>> Starting the EFI app via StartImage() must  terminate any running
>>>>> U-Boot "boot flow".
>>>>>
>>>>> After ExitBootServices() the EFI application cannot return to U-Boot
>>>>> except for SetVirtualAdressMspsetting which relocates the EFI runtim=
e.
>>>>>
>>>>> Bootflows and U-Boot drivers have no meaning after ExitBootServices(=
).
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Also there is U-Boot code between when the devices are unbound and
>>>>>> when U-Boot actually exits back to the app.
>>>>>>
>>>>>> This hang was 100% repeatable on brya (an x86 Chromebook) and it to=
ok
>>>>>> quite a while to find.
>>>>>
>>>>> We need a better understanding of the problem that you experience to
>>>>> find an adequate solution. Why does removing all devices lead to
>>>>> hanging the system?
>>>>
>>>> Are you able to test this? With your better knowledge of EFI you migh=
t
>>>> be able to figure out something else that is going on. But in my case
>>>> it causes some memory to be freed (perhaps the memory holding the EFI
>>>> app?), which is then overwritten by something else being malloc()'d,
>>>
>>> The memory for the EFI app is not assigned via malloc(). It is allocat=
ed
>>> by AllocatedPages().
>>>
>>> Reading "some memory freed" does not give me confidence that the probl=
em
>>> is sufficiently analyzed.
>>>
>>>> so the boot hangs. It is hard to see what is going on after the app
>>>> starts.
>>>>
>>>> This patch was sent almost two months ago and fixes a real bug. The
>>>> first few versions attracted no comment now it is being blocked
>>>> because you don't understand how it fixes anything.
>>>
>>> Do you understand why unbinding the devices causes the problem?
>>>
>>>>
>>>> I can get the hardware up again and try this but it will take a while=
.
>>>
>>> Digging a bit deeper seems to be the right approach.
>>
>> Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
>> https://lore.kernel.org/u-boot/CAHc5_t1H39YV=3DHSSa7TCEdzRctAX+zibkx1vs=
uwEW-raOL9TcA@mail.gmail.com/
>>
>> points to a probable root cause:
>>
>> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
>> free(bflow->buf)
>>
>> In the EFI boot bflow->buf points to $kernel_addr_r which never was
>> allocated and therefore must not be freed.
>
> Yes, this is the root cause of the crash.
>
> However, this patch should still be applied. I can update the commit
> message if you like.
>
> Freeing the FDT and kernel before booting them is just not safe,
> whether EFI or anything else. Freed memory is not guaranteed to hang
> around for any length of time. For example, with truetype fonts,
> malloc() is called during any console output and will likely corrupt
> the images just as they are being booted.

Please, observe that malloc() and efi_allocate_pages() use completely
separate parts of the memory.

When reaching ExitBootServices() the memory used by the EFI binary
(relocated in efi_load_pe()) and for the configuration table with the
device-tree have been allocated by efi_allocate_pages(). These addresses
cannot neither allocated by malloc() nor freed with free().

Best regards

Heinrich

>
> We should leave the devices bound when booting.
>
> Regards,
> Simon

