Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB3DC2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 945CF87045;
	Thu, 16 Nov 2023 02:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jrSdfTOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4E08729D; Thu, 16 Nov 2023 02:29:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65D8864E7
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700098173; x=1700702973; i=xypron.glpk@gmx.de;
 bh=LXBF6pFcN93gOaqxFSGvmQnRuZPeaQ8x2YgcPxEzkWg=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=jrSdfTOo+tuSMvgAXyBe0zzAQ1E2f86jBMO+MkojuMpFr4saJuLHWlESn2Bzow5W
 buzxCNyAnh0uQfiD5hLcHAe3MC4k2DVwWwil2lyRzqgx9A9M6go0JUY+NZ8ZE3ZLU
 T6TwogR2l43eshQRuJPjmxPWJDWc+p0yrF2WjxCfp2BBS2rgfDiBxuJFjH5J2ujYH
 ADJ8iHSzEN3s5vfhk5QTuC05s6eNozSXcd7KGaeCZyeXRL1Mipxt823d5hkR+Bn9W
 0n9t/fZJbEoepwYkQo9so9mj3uKrynZwz4HeS/dfKOtzxntZVm3/j6ianpGAZ235L
 rYkgo9jaQ7xFCPVbrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1rZCAj3XLR-00hJjB; Thu, 16
 Nov 2023 02:29:32 +0100
Message-ID: <487c3e73-ce21-4e45-9cf3-44314e78fd1f@gmx.de>
Date: Thu, 16 Nov 2023 02:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
In-Reply-To: <58076384-d164-4d7a-bc1f-c78574b481b5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fvw9VRS+4SUa2SFaO540/8ZfQ/Qvrm0ferfGTKwqsrMUrX31vDJ
 6QD+gqPj83tHNMZrneXOIyJR5+tH+I55u3oOJO7dYs6skNGGLDjY9XhdmlGPhbuJBAesvRX
 jGryDYu50d0SMrf5Z3MHLcWOtkYF3483ggRiGn6/DHuUv56qNLlW7tmtO6kRIhw2FnwF7tm
 b7m/156WDv0KnF2tsJg1w==
UI-OutboundReport: notjunk:1;M01:P0:wAUQyTvWZtI=;vFRpQhM/QQBLygj8gKlSAEIRd6N
 GzWu/iJu6lxsTksaCNhmpbOua27NYvK6TJ6SWidY92Z/G7BF2z2ZWRzZQo9Ssd33bNGIJYw7l
 tT15CN7i5F6AaIu4uUNHAIbrOekbFFaIo/CbdG5n/OA55xvPikMkoAfya3pNDDjh3CNN2Ulyp
 mmIymvAL7r2IATbZgrAlzPqdlr9cvRDVc0CnINZu8HqveHKsODMBOtxCr7Y+PXBaVXLnd6JEU
 vi4ZufZUWpZybMktiwccMgTdEeky5AgFdLgd+9BGRety4HKK5SA/+spTWFipfcfEKj6ShtiFY
 ScLMtmZZR1XX5zIlUHKgzRXox0rSe0d5UmMjR1hVYfjKipBBUwdueD61kESwVZYjWulF6XoSA
 1doJGKhMQoRnpHGPZGTIDF0D/2veY2Wq9ALjdKwyQ+VT0sUFFQ5KjZwEygAdVCadt45J0KvLR
 MuNlobykF1CNO0iYViLDKuwShG+eQUawv+dqN2nH+zk2EI8i1BNA49I/Wforw2mSv/bE7fLVQ
 nEBLQRxii4EWJEW/gkymu9CZbwECJdDR90UnipWi6Ivbimc2MEZD1iEgkHOlxaNC516/p/KWq
 dvXw7NcHa9CMlatcmfxgHoHdGRPTZzB1GM8byJFcStvWG6yMpcKtQRuyKMvj1daq6O6QwYPlq
 XOLdio6LNG81p3sbsKjMdEfbgoQCnW21znMwJcrjLWzdhvAjecBaQ27kM5vdiUoUr648hopHW
 C5RZZboOi/qQUGg+1Clz7KJ2v+GS2SCM5pRedoykRDYZhtQced+ct9anyxexkk1RFSzYrOmjS
 tVu+j+NOXv0VIOu4Q5ZMGI2+uExGVTO+zhMwCbahdu1ap/KhP9aaCsfFr/FBxr00xMKa7RYnp
 2OAZfzbrLnO3bTAH4Yn/3serFrRRV0Sei+AYB4tykIYqGC2SRQbGuJ9sYfhaXZdKDDPpPaDtg
 mqzmRet2bh+InozUYcnzjyHdFOg=
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

On 11/15/23 17:23, Heinrich Schuchardt wrote:
> On 11/15/23 16:50, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de>
>> wrote:
>>>
>>>
>>>
>>> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass
>>> <sjg@chromium.org>:
>>>> Hi Heinrich,
>>>>
>>>> On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt
>>>> <xypron.glpk@gmx.de> wrote:
>>>>>
>>>>>
>>>>>
>>>>> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass
>>>>> <sjg@chromium.org>:
>>>>>> When a USB device is unbound, it causes any bootflows attached to
>>>>>> it to
>>>>>> be removed, via a call to bootdev_clear_bootflows() from
>>>>>> bootdev_pre_unbind(). This obviously makes it impossible to boot th=
e
>>>>>> bootflow.
>>>>>>
>>>>>> However, when booting a bootflow that relies on USB, usb_stop() is
>>>>>> called, which unbinds the device. For EFI, this happens in
>>>>>> efi_exit_boot_services() which means that the bootflow disappears
>>>>>> before it is finished with.
>>>>>
>>>>> After ExitBootServices() no driver of U-Boot can be used as the
>>>>> operating system is in charge.
>>>>>
>>>>> Any bootflow inside U-Boot is terminated by definition when
>>>>> reaching ExitBootServices.
>>>>>
>>>>>>
>>>>>> There is no need to unbind all the USB devices just to quiesce them=
.
>>>>>> Add a new usb_pause() call which removes them but leaves them bound=
.
>>>>>
>>>>> As U-Boot must not access any device after ExitBootServices() it is
>>>>> unclear to me what you want to achieve.
>>>>
>>>> I can't remember exactly what is needed from the bootflow, but
>>>> something is. Perhaps the kernel, or the cmdline, or fdt? It would
>>>> have been better if I had mentioned this explicitly,=C2=A0 But then t=
his
>>>> patch has been sitting around for ages...
>>>>
>>>> In any case, the intent of exit-boot-services is not to free all the
>>>> memory used, since some of it may have been used to hold data that th=
e
>>>> app continues to use.
>>>
>>> The EFI application reads the memory map and receives an ID which it
>>> passes to ExitBootServiced() after this point any memory not marked
>>> as EFI runtime can be used by the EFI app. This includes the memory
>>> that harbors the U-Boot USB drivers. Therefore no drivers can be used
>>> here.
>>>
>>> Starting the EFI app via StartImage() must=C2=A0 terminate any running
>>> U-Boot "boot flow".
>>>
>>> After ExitBootServices() the EFI application cannot return to U-Boot
>>> except for SetVirtualAdressMspsetting which relocates the EFI runtime.
>>>
>>> Bootflows and U-Boot drivers have no meaning after ExitBootServices().
>>>
>>>
>>>
>>>>
>>>> Also there is U-Boot code between when the devices are unbound and
>>>> when U-Boot actually exits back to the app.
>>>>
>>>> This hang was 100% repeatable on brya (an x86 Chromebook) and it took
>>>> quite a while to find.
>>>
>>> We need a better understanding of the problem that you experience to
>>> find an adequate solution. Why does removing all devices lead to
>>> hanging the system?
>>
>> Are you able to test this? With your better knowledge of EFI you might
>> be able to figure out something else that is going on. But in my case
>> it causes some memory to be freed (perhaps the memory holding the EFI
>> app?), which is then overwritten by something else being malloc()'d,
>
> The memory for the EFI app is not assigned via malloc(). It is allocated
> by AllocatedPages().
>
> Reading "some memory freed" does not give me confidence that the problem
> is sufficiently analyzed.
>
>> so the boot hangs. It is hard to see what is going on after the app
>> starts.
>>
>> This patch was sent almost two months ago and fixes a real bug. The
>> first few versions attracted no comment now it is being blocked
>> because you don't understand how it fixes anything.
>
> Do you understand why unbinding the devices causes the problem?
>
>>
>> I can get the hardware up again and try this but it will take a while.
>
> Digging a bit deeper seems to be the right approach.

Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
https://lore.kernel.org/u-boot/CAHc5_t1H39YV=3DHSSa7TCEdzRctAX+zibkx1vsuwE=
W-raOL9TcA@mail.gmail.com/

points to a probable root cause:

https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
free(bflow->buf)

In the EFI boot bflow->buf points to $kernel_addr_r which never was
allocated and therefore must not be freed.

Best regards

Heinrich

>
>>
>> Even without the hang, this still fixes a bug. We should be using
>> device_remove() to quiesce devices. There is no need to unbind them.
>
> Is this what the patch does?
>
>>
>> BTW another patch that suffered a similar fate was [1]. I just applied
>> it based on a review from Bin.
>
> Please, ping Ilias and me if you don't get the feedback that you deserve=
.
>
> Best regards
>
> Heinrich
>
>>
>> [..]
>>
>> Regards,
>> Simon
>>
>> [1]
>> https://patchwork.ozlabs.org/project/uboot/patch/20231001191444.v3.1.I9=
f7f373d00947c704aeae0088dfedd8df07fab60@changeid/
>

