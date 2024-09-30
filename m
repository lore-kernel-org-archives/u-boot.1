Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCC3CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCDD88B27;
	Mon, 30 Sep 2024 14:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iiDkPB2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26D888B55; Mon, 30 Sep 2024 14:00:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F4688A3C
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727697610; x=1728302410; i=xypron.glpk@gmx.de;
 bh=wkGZE69GMaObWoSJhv1n9owF+foBqIFLQNuwoR0pAgM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iiDkPB2r5dJoqN64kCW92gRpI0LJVGac0m9L3ZfAqgRyTBA6ng/beLRwZjP7TP1+
 nccqU3BCJ4/8cP56QvMi8/jQA/iCTfZP4Rsopj5UmY6WGyjJdoFo+No+ZXg9TlpQ+
 RYW+GgHTHd260MNE5+/q63KmtsmoMvfryEEjNUxjyNAGzzlzDNhHyIgGw9z6CpFfz
 QXfixNnGiVjZS3gBPSoOTHjpzXEXtr3/Q+gU9RN5IVbaIHQIB4CVCxd/GTM+bbubP
 0Y/pEhbhlS/VcPAoz7GHDr4Y36U1/DH6ixQZEfFCiife59oNgkvuPZBDKuSDaqtg8
 l3dsww0QCoqIEkjkSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1sFIY60Rk8-00fmd1; Mon, 30
 Sep 2024 14:00:10 +0200
Message-ID: <7ff9fb46-40c9-47dd-880b-5ecf898de68e@gmx.de>
Date: Mon, 30 Sep 2024 14:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-10-sjg@chromium.org>
 <CAC_iWj+-Y5XCs1byoGzxqkL2PQoaEHA9UUhwU7_v5i2omPvmtQ@mail.gmail.com>
 <CAFLszTjeNUJ88aCLVS1d6Ekki0ekv3zkOxpB2nGmp=tM0stLfA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjeNUJ88aCLVS1d6Ekki0ekv3zkOxpB2nGmp=tM0stLfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+zPSdjny3abp3Z9fVtOxEJJyXK+8UslPtKrBdUtfhhdEIiSWe7
 K5ENYDSYgnbo1f173UZWdu7tj3SbutT9xSOad8jiMrcDrIMHAZmMCp33tabOW7uXZNGBB9/
 anzyOwdt/goHwbcHqlwsSJ9ZQ8fnQKv+bv/50fPZkx7RUaBXfE/KWhDLFrZlRhdV/pPLJeX
 P60oTTfH7eJ5rMrzyO5/Q==
UI-OutboundReport: notjunk:1;M01:P0:PxphlvurJII=;qD7HQ0AOQrhGI7kFvLohFJ79Fbk
 c5EUD7MICiCs8TNZch5ldR8nrBfq1sHPE+1RCQqHAq0k7dcKQWrbhLrcZtoqBdIYYMAyRwCY6
 r/URnMQ86f33fetjr6Pw/Kfhh4mamtfrEJkpt3Rn8y5kHfEo1yPsRWiQE0evGA7q6xv7Vrn0/
 RLAo3LzPjY6r+NLoE+zWNlccrT0M8Pg9/lLGl3qcTb3qeJC4wl406Io4sKPdJntUDlgNtsAGU
 NFlSgu88f8LPfq2hwDJhVw/TbmGEUejac5/f0ZSN8WouxIK12upcYs9At2alVHbYOLifwpx2x
 CVs10nqB/j6j9u10px+0+PHr0QUBmbyxPNhS74KY4d8cmt5RlGH13QdicX1iXZdU6793s010F
 Px8g1UwHhNtzB1Ni0BtTpejLzlIE9b9GlTjc3N7wpezOKa0mt0NmY/OdeFwraN94/j1vH95oL
 ta0mjE2mKZfTZMcQ2l1v3cZZi9XBr0VtQVSZYNGs4nsr1mtEz/BUIkB8LfosyXc1T69l6C/yh
 gJJHZbQv2z/HEHde1nZXcRtUd1hnMU7fNg1DGQlssg1e1cpxGqPzTECImDsM24v473DhKNXI/
 CPR0hD9NuIaOQwkVRG54eO1J5aakrCSJWzELZbxl1EXLtegalbtxQFmOJO+6ohbliPOpiYCaM
 mDjRcMUxGdFSQEBJG+mgcHbBWtTX3YZQJJDpB0SW0YKd/JgN/LegBj72v4XtitGxikGxUYyjU
 UlPIBl4+UjpOvPVTWSAHqHtGb6MXsO3RVHM3QEez7lEZi2qJtUp9svpkb4Xk3YaL9+4H7Q+PD
 AGFbpO54n2lI52d+ERVQQacA==
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

On 27.09.24 18:50, Simon Glass wrote:
> Hi Ilias,
>
> On Fri, 27 Sept 2024 at 07:51, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Fri, 27 Sept 2024 at 01:04, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Add a simple app to use for testing. This is intended to do whatever i=
t
>>> needs to for testing purposes. For now it just prints a message and
>>> exits boot services.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   lib/efi_loader/Kconfig   | 10 ++++++
>>>   lib/efi_loader/Makefile  |  1 +
>>>   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++=
++
>>>   3 files changed, 79 insertions(+)
>>>   create mode 100644 lib/efi_loader/testapp.c
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 6f6fa8d629d..41083e7c137 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -564,6 +564,16 @@ config BOOTEFI_HELLO_COMPILE
>>>            No additional space will be required in the resulting U-Boo=
t binary
>>>            when this option is enabled.
>>>
>>> +config BOOTEFI_TESTAPP_COMPILE
>>> +       bool "Compile an EFI test app for testing"
>>> +       default y
>>> +       help
>>> +         This compiles an app designed for testing. It is packed into=
 an image
>>> +         by the test.py testing frame in the setup_efi_image() functi=
on.
>>> +
>>> +         No additional space will be required in the resulting U-Boot=
 binary
>>> +         when this option is enabled.
>>> +
>>>   endif
>>>
>>>   source "lib/efi/Kconfig"
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index 00d18966f9e..87131ab911d 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
>>>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>>>   apps-y +=3D dtbdump
>>>   endif
>>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>>>
>>>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>>>   obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
>>> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
>>> new file mode 100644
>>> index 00000000000..feb444c92e9
>>> --- /dev/null
>>> +++ b/lib/efi_loader/testapp.c
>>> @@ -0,0 +1,68 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Hello world EFI application
>>> + *
>>> + * Copyright 2024 Google LLC
>>> + * Written by Simon Glass <sjg@chromium.org>
>>> + *
>>> + * This test program is used to test the invocation of an EFI applica=
tion.
>>> + * It writes a few messages to the console and then exits boot servic=
es
>>> + */
>>> +
>>> +#include <efi_api.h>
>>> +
>>> +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROTOC=
OL_GUID;
>>> +
>>> +static struct efi_system_table *systable;
>>> +static struct efi_boot_services *boottime;
>>> +static struct efi_simple_text_output_protocol *con_out;
>>> +
>>> +/**
>>> + * efi_main() - entry point of the EFI application.
>>> + *
>>> + * @handle:    handle of the loaded image
>>> + * @systab:    system table
>>> + * Return:     status code
>>> + */
>>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
>>> +                            struct efi_system_table *systab)
>>> +{
>>> +       struct efi_loaded_image *loaded_image;
>>> +       efi_status_t ret;
>>> +       efi_uintn_t map_size;
>>> +       efi_uintn_t map_key;
>>> +       efi_uintn_t desc_size;
>>> +       u32 desc_version;
>>> +
>>> +       systable =3D systab;
>>> +       boottime =3D systable->boottime;
>>> +       con_out =3D systable->con_out;
>>> +
>>> +       /* Get the loaded image protocol */
>>> +       ret =3D boottime->open_protocol(handle, &loaded_image_guid,
>>> +                                     (void **)&loaded_image, NULL, NU=
LL,
>>> +                                     EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>>> +       if (ret !=3D EFI_SUCCESS) {
>>> +               con_out->output_string
>>> +                       (con_out, u"Cannot open loaded image protocol\=
r\n");
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* UEFI requires CR LF */
>>> +       con_out->output_string(con_out, u"U-Boot test app for EFI_LOAD=
ER\r\n");
>>> +
>>> +out:
>>> +       map_size =3D 0;
>>> +       ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &d=
esc_size,
>>> +                                      &desc_version);
>>> +       con_out->output_string(con_out, u"Exiting boot sevices\n");
>>> +
>>> +       /* exit boot services so that this part of U-Boot can be teste=
d */
>>> +       boottime->exit_boot_services(handle, map_key);
>>
>> What Heinrich keeps repeating here, is that after you call EBS, boot
>> services must not be called again.
>>
>>> +
>>> +       /* now exit for real */
>>> +       ret =3D boottime->exit(handle, ret, 0, NULL);
>>
>> IOW this is wrong. It might happen to work because not much has run
>> and the memory will still be there. But you certainly should not rely
>> on that
>
> Well, not much has run because it is running the test program. So we
> know it will be OK.
>
> One of the challenges we have is that we need to design things for
> testing, i.e. to make testing easy and practical. The call to exit()
> happily returns back to sandbox and all is well. It serves the purpose
> of the test, which is all the app is wanting to do.
>
> So I have to ask, what problem are you seeing?

We write tests to see if our firmware conforms to the UEFI
specification. This requires that our tests are conformant.

Please, call the ResetSystem() runtime service here.

I would prefer if you could at least consider suggestions.

Best regards

Heinrich

>
>>
>> Thanks
>>
>> /Ilias
>>> +
>>> +       /* We should never arrive here */
>>> +       return ret;
>>> +}
>>> --
>>> 2.43.0
>>>
>
> Regards,
> SImon

