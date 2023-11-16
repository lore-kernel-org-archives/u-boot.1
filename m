Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753EAC2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988F287045;
	Thu, 16 Nov 2023 02:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MR3XZ6sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C52787045; Thu, 16 Nov 2023 02:25:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01760862DA
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700097936; x=1700702736; i=xypron.glpk@gmx.de;
 bh=1ZpJzu/HqDk3U+zpCFB3et0BiZiwKifTcUXgKMRHnH8=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=MR3XZ6sByO38twpEosOIjuFP/xRlx6DQ5bFXhWKr9n39xriG5Ui+PPq8qTKdk8wX
 +PKS152ZGgkVn6YonfGGJw7GqrN09HIi24+tEgrI8NwnYUcetQAM6H2n54mlElO6i
 s4J8Qd44Kz7tj7hn1mX8JkrJsgTh3qsTqriXPWwo6BR6+6L9Y+WlJ223Bs7RUZ4zV
 lXKQjFsCQfNj81b8Jb/29+ICNa56lQSIH05IW4zA35S7zpnn6otzLyIp5zcWfRqMO
 J9xcJJU1dfxuIhBS3Tk353eUyOpYjf6MRFAY7YZCRfH1X2i4hsidGHN9kNthf/tNh
 Qd9EZqkW92iBEBTXIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1rDYpL1d2V-00CykW; Thu, 16
 Nov 2023 02:25:36 +0100
Message-ID: <59b43a5a-6fff-4185-a545-7ddd14ac3af9@gmx.de>
Date: Thu, 16 Nov 2023 02:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Shantur Rathore <i@shantur.com>,
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
In-Reply-To: <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dJ5FEBIHYTMYsHcpP3jngPWFre0w/ugTbBfFqwBYw/7t25imRZ6
 HeKddWD9h9cNF2rS18tg7PV9d3LcWSGrVQMI08EGDnR9ifheQsX9zuwZuk/nJ53nilMs2Jo
 uXxANP6GLHRojB+8Z2IfPm01qtubtvEvtz1xmtHLPl58e3K2yVcyVCRt97YOqK1x9a56jbh
 5vyoKfU1lJ2RgLYV1/TnA==
UI-OutboundReport: notjunk:1;M01:P0:dGwVXXmzV+E=;cdjQRlCkbnffogaT6+nDnxMzcrM
 K4Cu+47tDOn50VG+pv1gPDLlBIp209vhDQZQLDa6E9Y6h7Ck0MA/8SU37hk3j1c/b7StNAdby
 FPACERtT1tGOClIUMHYDdHxL/0WTJikgAxdCW0VnV7HdBNtlPouqzl4qSg/Xj7dW+LXIqahbD
 NFGzNI7AXArIyqUVsijSFOTOvweqm8UVfUVbZbYZqKsm2jhrZR8cUrqROkJcyFOE6FD2j02D/
 v4N1KTKyBq5cyUJmyS46ByEFPqXu1K0b5P5+9FG1cinC3Dg3vztgetT6TVjcU9sJs3qv1aW1o
 QeUHSSVhwW7VaBdaRgnvNYEvJcVuJMy2sWPwBFkYYW3DBFOXY27/PkuSCJ9Db/JIJ1qrlQtqs
 8SVPW0N6rhdu/L67gbVvCokZGS5XNZ2kk8GXUGCWYa6J6lAwPHUEOpIfZtFJqlVrH/f230xZ2
 WVVtmX5iaynMGWjIr/LGEUiPDdWTN64hvzkKTCjjAob22EKoBvidSd/m+0LCOaJPoV8qsiLWy
 7erWoFscjLYk7b/MLBG/nwzoPg/fbk9Rb1TllOfV51Ee4UJ7vJGvC0f974AyRx6n8jvXLx9c7
 GkWUe/gxxBmNeII0qp3KBI/Rhj+Bl7J3FD75LayOY6J/rsMKtWPGxBWuJNNJ8WqUK9HgF/xMs
 sqQv/S24+0/3n6wVJpkmYMp1Jt/7kbPHR23wh7QcQ7NIy+9+OLrtbAoVdcNgsiJMOcFJYsM/T
 6OBtsj7uqRQ+gK7wYQWhbTxuWLM5muG4eYqy9nHtxBb/Ymz1rUwAuvAQ9gPu5gPdNHyZ89ujv
 GxOdUqwDs9uRAITRdb7qchcZNtkwxzH13U4A43G2G7fgJOoQZ2r7nrsoVOxqN03gkqWtjrTyr
 4h3tTqXcyJZe7waklmAXxJzphi6FI9pQ00bBEn/fCYn3kaL/k09mScX7Bm81oHi+jFVyxn2I5
 qVCMEYiGX4ID1dV1alXv9qAghok=
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

On 11/15/23 23:46, Heinrich Schuchardt wrote:
>
>
> Am 15. November 2023 23:15:46 MEZ schrieb Simon Glass <sjg@chromium.org>=
:
>> Hi Shantur,
>>
>> On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur.com> wrote:
>>>
>>> Hi Simon,
>>>
>>> I have figured out the cause of the crash.
>>> It happens here -
>>> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
>>> while doing - free(bflow->buf)

Unfortunately the description of the field bflow->buf is deceptively wrong=
:

  @buf: Bootflow file contents (allocated)

The EFI bootflow never allocates this buffer but uses the address
$kernel_addr_r without allocation.

We must not call free on an address that we never allocated via malloc().

Doesn't this also explain the error you experienced before writing

[PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
https://lore.kernel.org/u-boot/CAHc5_t3v23k_Xbws5o-g9iQfoQ7fhpKScf89XDaaAg=
o+bu8tbQ@mail.gmail.com/T/#m992e20fb25fe0f2f0047e901a76e78628e59da7a

Best regards

Heinrich

>>>
>>> As I understand it,
>>> - Just before starting kernel EFI binary calls usb-uclass->usb_stop()
>>> - This starts removing all devices in my case ( 6x usb_hub, 2x
>>> partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
>>> - While removing bootdev, it ends up calling bootdev-uclass ->
>>> bootdev_pre_unbind -> bootdev_clear_bootflows which calls
>>> bootflow->bootflow_remove and bootflow_free
>>>
>>> I don't know why this buf cannot be freed, is it because the EFI
>>> binary in the buffer is still being used ( efi/boot/bootaa64.efi ) ?
>
> EFI binaries should never be started from memory allocated with malloc. =
efi_load_image() should be invoked which allocates EFI memory via efi_allo=
cate_pages(). The handle created has to be passed to efi_start_image().
>
>>> But commenting this line out fixes the crash and linux boots happily.
>>>
>>> Fixing this properly is above my pay grade as of now.
>>
>> Great, thank you! I will send a patch.
>
> Free() typically crashes in U-Boot when freeing the same memory twice.
>
> Best regards
>
> Heinrich
>
>
>
>>
>> Regards,
>> Simon
>>
>>>
>>> Kind regards,
>>> Shantur
>>>
>>> On Wed, Nov 15, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
>>>>
>>>> Hi Shantur,
>>>>
>>>> On Wed, 15 Nov 2023 at 08:23, Shantur Rathore <i@shantur.com> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>>>
>>>>>> Is this the blue port on top of the USB-C connector?
>>>>>>
>>>>> Yes, that's correct.
>>>>> For my drive I needed -
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.5123=
34-1-i@shantur.com/
>>>>>
>>>>>>
>>>>>> Which version of Armbian / download link?
>>>>>>
>>>>> https://redirect.armbian.com/rockpro64/Bookworm_current
>>>>>
>>>>>> Yes it is scanning first, before reading the efi app, etc.
>>>>>>
>>>>>> I have the same hardware so may be able to dig into this.
>>>>>
>>>>> Sorry, I meant to ask if anything specific to USB.
>>>>> I see it loads efi from the network or disk and calls bootefi with t=
he
>>>>> loaded address.
>>>>> I don't know deep boot / efi stuff, just trying to compare how it's
>>>>> loading efi differently than fatload in this case.
>>>>
>>>> There is nothing special about USB in boootstd, so far as I know.
>>>>
>>>> But until we figure out this bug, it is hard to be sure.
>>>>
>>>> Regards,
>>>> Simon

