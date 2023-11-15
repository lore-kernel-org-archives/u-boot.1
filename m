Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60F2C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 16:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD29871DF;
	Wed, 15 Nov 2023 17:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rAyWY+gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4219E8718B; Wed, 15 Nov 2023 17:24:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BB5871DF
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700065452; x=1700670252; i=xypron.glpk@gmx.de;
 bh=MhF/qhTxOQUITlNhXbC48lu0fp+ghBpFccK9lSLhtRo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=rAyWY+gqHKNQNdDDuMs10nyoaANK42YjNrw34BbZok4W+QBOUgEwK8H6y+e7LYYt
 WGghG3nayfi56jOBy7r9qy6MJsC8p9OyRRs8+/Y12qI+PoXieuWQc0r8bEF1LdjTi
 fCuhdPz1m5/nCfi3J4oFmQ3lR/JfTiq91ZREhBdaEQtTs+7wmPFA4y519Xq3Tfwr4
 yzf7yVmd9mrVJHRZkic7AmOUPklgJoJkCWxIXrxN1BjKFPFwKW5GMbeNoivF9aDKC
 OfgqTrkEillmzkFwGCHLSdvNO27Lm+soxsHybIbOa639CZeC2WmdUlvqeZIv0I+Sm
 St7b3iWTIvKlWd15CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1rjT7e2KpW-00pMCN; Wed, 15
 Nov 2023 17:24:12 +0100
Message-ID: <58076384-d164-4d7a-bc1f-c78574b481b5@gmx.de>
Date: Wed, 15 Nov 2023 17:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
 <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
 <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fqMub22C2cS+3lWuqr3PJ2z0oP2ERr9RkcbbjmrSuBKZHyq+HO7
 lAxTwnFIool1Fa6wvyUSbVW0lLgSjNg0MOrVDaXTXyLDNyNit61fvLHqG7TtnL3Jam/U6Ci
 DU+NGBa3qoNtdNDOGNtZ9GIitejYFPMhc+f/m5n36+T8n6FsY/nEV3IlmMKrI1JiIUuwEZ4
 GH/Gz6a/MilRBJsAnLhrA==
UI-OutboundReport: notjunk:1;M01:P0:eMWaIVFnjOc=;/jpB3iZCatgHg5a9jfVdN34HTO2
 D8oZlIj5f/FQtRFR96i9ov1eBRFU5P0dw0ge1T+8KGfj5kRMAe0pqcI/Hguw5X2FAwzoJsNlc
 uVwzu/Miv0oGYGoWFDzhYU5yMoSscAyQ/tLzrJctiiC7DBwgT8QM2f7omcf0qiG8rncpqLmie
 2+cby8NCiM7UI1LINzYbpfd+LN0JToOvngK79EttW6gfzFVBCikmSSer718Raw+BMoskfJ3tl
 xQ8c7PqVNMpD1nLODoXVGe0cf+tRXbW/rijJ5AFqfZ/RZwAkEoilZOxDE8F9OZB48P/+wde2X
 0IamkMqHP77nlD90X9EKbf3ICeGIORkSCuZD8mURXFUShK4ZP8/n8Po36p+KPqNJz0GPKQjna
 sMVaQHytxjUbh2gf3pkCRd8+wPEVrKYRp89locoGPL8PSbjrxr7pRd8xgG9H8kJKYnvIMDjbJ
 UTIduuWBfXCwFzVILncz9rJL99v2n4TGDIDGNVRVEWh55/FpCcrDisxri6tDh4GU8j553bei+
 bmtmeLz9ETcYl/SpupMGg2ZF6MeGcn6jQISn0npG61IB664n/vpVNHbNoL2h3Re0g8Hm6/CWG
 TBJJlNE7o5YJaKaVYuBdlPh3JVrvnWLN+o4tBe3RZFaNjUlMX6c/+lFjjcaOe4Hm7dPmAs8Ow
 ersNqrjZmdaSmeGDREP8iPvxt8griRy6ITqsPpcX4l4Mt2rn356o3rPweQThHaSbvfetkwDI/
 8BrAV/w+TY7G6bvU47vsSRtLIXdIlgJWuaw1xVhI2oIZ0zAbhugLzM4vuBvkxj4EK5J1qWeKH
 XNz61rAF3d5VkcMtqnmVVzUEIy/GVq3Uv7jtGowKy/ZlDOQb4TMORqFQvQ3cD2jC7v8Ag9WnL
 gi+1wYgC7AUp+IryYynidS7PNrhxEP1Kay6TEGjJLQUVhWSU+v85Il1OAvSKneMjuiBCNR5MV
 yYAnMBfKgPVaO5q2jZ4SXJEF0GA=
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

On 11/15/23 16:50, Simon Glass wrote:
> Hi Heinrich,
>
> On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>>
>>
>> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
>>> Hi Heinrich,
>>>
>>> On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>>>>
>>>>
>>>>
>>>> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass <sjg@chromium.o=
rg>:
>>>>> When a USB device is unbound, it causes any bootflows attached to it=
 to
>>>>> be removed, via a call to bootdev_clear_bootflows() from
>>>>> bootdev_pre_unbind(). This obviously makes it impossible to boot the
>>>>> bootflow.
>>>>>
>>>>> However, when booting a bootflow that relies on USB, usb_stop() is
>>>>> called, which unbinds the device. For EFI, this happens in
>>>>> efi_exit_boot_services() which means that the bootflow disappears
>>>>> before it is finished with.
>>>>
>>>> After ExitBootServices() no driver of U-Boot can be used as the opera=
ting system is in charge.
>>>>
>>>> Any bootflow inside U-Boot is terminated by definition when reaching =
ExitBootServices.
>>>>
>>>>>
>>>>> There is no need to unbind all the USB devices just to quiesce them.
>>>>> Add a new usb_pause() call which removes them but leaves them bound.
>>>>
>>>> As U-Boot must not access any device after ExitBootServices() it is u=
nclear to me what you want to achieve.
>>>
>>> I can't remember exactly what is needed from the bootflow, but
>>> something is. Perhaps the kernel, or the cmdline, or fdt? It would
>>> have been better if I had mentioned this explicitly,  But then this
>>> patch has been sitting around for ages...
>>>
>>> In any case, the intent of exit-boot-services is not to free all the
>>> memory used, since some of it may have been used to hold data that the
>>> app continues to use.
>>
>> The EFI application reads the memory map and receives an ID which it pa=
sses to ExitBootServiced() after this point any memory not marked as EFI r=
untime can be used by the EFI app. This includes the memory that harbors t=
he U-Boot USB drivers. Therefore no drivers can be used here.
>>
>> Starting the EFI app via StartImage() must  terminate any running U-Boo=
t "boot flow".
>>
>> After ExitBootServices() the EFI application cannot return to U-Boot ex=
cept for SetVirtualAdressMspsetting which relocates the EFI runtime.
>>
>> Bootflows and U-Boot drivers have no meaning after ExitBootServices().
>>
>>
>>
>>>
>>> Also there is U-Boot code between when the devices are unbound and
>>> when U-Boot actually exits back to the app.
>>>
>>> This hang was 100% repeatable on brya (an x86 Chromebook) and it took
>>> quite a while to find.
>>
>> We need a better understanding of the problem that you experience to fi=
nd an adequate solution. Why does removing all devices lead to hanging the=
 system?
>
> Are you able to test this? With your better knowledge of EFI you might
> be able to figure out something else that is going on. But in my case
> it causes some memory to be freed (perhaps the memory holding the EFI
> app?), which is then overwritten by something else being malloc()'d,

The memory for the EFI app is not assigned via malloc(). It is allocated
by AllocatedPages().

Reading "some memory freed" does not give me confidence that the problem
is sufficiently analyzed.

> so the boot hangs. It is hard to see what is going on after the app
> starts.
>
> This patch was sent almost two months ago and fixes a real bug. The
> first few versions attracted no comment now it is being blocked
> because you don't understand how it fixes anything.

Do you understand why unbinding the devices causes the problem?

>
> I can get the hardware up again and try this but it will take a while.

Digging a bit deeper seems to be the right approach.

>
> Even without the hang, this still fixes a bug. We should be using
> device_remove() to quiesce devices. There is no need to unbind them.

Is this what the patch does?

>
> BTW another patch that suffered a similar fate was [1]. I just applied
> it based on a review from Bin.

Please, ping Ilias and me if you don't get the feedback that you deserve.

Best regards

Heinrich

>
> [..]
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20231001191444.v3.1=
.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid/

