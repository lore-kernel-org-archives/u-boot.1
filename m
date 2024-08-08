Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F3FC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 21:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C1088B63;
	Thu,  8 Aug 2024 23:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Afp83Us0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A44F88AF6; Thu,  8 Aug 2024 23:17:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A38B88B09
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 23:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723151834; x=1723756634; i=xypron.glpk@gmx.de;
 bh=rAWKHtF8kSCKwS9nfe7YRU2u+eEjgwu6P1up+hu9e+Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Afp83Us0CdD2jydinQPXjJvfPBxSV0Qs2SWXQ8dxw7u+ZnScrXgkd/Ci4HrBYXOY
 24P0UkoOEEFg+6TCbj4mLOE9Kgr4eiF45SxrXhUWLKq6kARIYRra5b1S+Pw9PbU/7
 sdbyOEW9N03Ifw8zl0FCc4iFDwo+KkeEJ4JdrRDYSQvNIJSc8duswyh6rYsEmWqla
 BRpCEhNsdoEKFcDgjaqC0mQNwkkFNToyajtqo5q8L9yj8vKS0QZgqkW+zqlSkFrN2
 5JGbtF/WKi5Fo/60fYw3ezQlH7jJdj7Dwc4xkisKJZ/SGRi2PE6LmzfUrX/N0cIfR
 ++KB/LHcH9UgQV91fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1sru4I3L8l-00QGWG; Thu, 08
 Aug 2024 23:17:13 +0200
Message-ID: <b8409d9e-58d6-4b2e-b0df-9b77cdded67f@gmx.de>
Date: Thu, 8 Aug 2024 23:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/39] efi: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-37-sjg@chromium.org>
 <194083b4-07e1-4b3d-906b-6277d1d8cd0c@gmx.de>
 <CAFLszThmhENnEA6jc2q=FRoinv6t9bUWh_PcXTrxvaifJvqY6w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThmhENnEA6jc2q=FRoinv6t9bUWh_PcXTrxvaifJvqY6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5Zk+ukHG9yPcCkonqZM95jGmZqiIg8Dh4bZbtPvWQBHjflxHDH
 kUi9n1wrHO7JCsk7qIrWFTpk1FvEwoS735Pq3j2eIgV9aNOPHeuJrNaUOXJDrTzyKQHljbM
 DkhtQGT2QehiupANpPFfxfaESDAJIEBduK6xBJ/H6pm1E9y7BtBiCRAxYEfPk3qvnt5tHZz
 adICTfgsrE7g3+HQroHkw==
UI-OutboundReport: notjunk:1;M01:P0:QAqoSPPMIrc=;wLuUCbf4AMZ9R7SvQs8DCooZdpP
 ccft3PeDmv7MwlAxovfy6niQjml7hN4XdC1luE8GrTf13UV8AUDDKGI/Gr2LQuEb/XGhHxhop
 dvlstyGEj9uFD4ULMwrLskGQnE2wMsBNo+6JNCJDjjxcGXTVcX+GQ5qUZ/iMN3kHOXUnJLA9b
 1jgJ31idstBdz7nx3CHwydb0EbFG0Os8FB8iARHqzG0EMmuPr+iJIFPoLdeyHtuQSJ9b3bAVi
 Tyql40ctdy8HZ36cgBE+mX6WmP+X6d5O14OyH30Dv4kdh6mS5B/eKdorP5IEVl/UDaeb7VnYl
 C5TAXLdGT2cnyPVPVkfq8RMNAui28Gnwzvl0q+Erk81gDWTmqC2NwNLbVg4B1NloBXHoz8wqX
 SvOWjf1kKBaAm/MGPx5MwhNtLiaZUkgbnxMpSIA+Vtl6c5GCLJhf9bwh5BT96p/dr8iognhtk
 pKgisCzACWK0kbPEWSiU20qOC4y3+86jZq8WArNqC0iU6rzy3jP+1FOBGmNFx9buU4sFRffCq
 AQt+CHt6WlgXVtneQ2wJwaG4FmJamaYK56zcZ+YZCDIUDbNrDqMtN+260/E9SzrTytCmGa7wj
 ZJxeP4begRDBx3LBGg8pfIkJ6ESjHNxvbx8AwZeQonnhevT7lnVnCcA6GpKAEFMY14B+sn2vv
 i3JeI/iYFxrvnMMgiG78vqeVgsM2UKDrvEtrLzFUzl15QHg9lITTWqtSPoeAt/8yUKdF+MSS3
 rbQahTlIroaPKHFX4+17jI5WffaenB4fD5avFFHdJ56PybpG029vnYFhC68+YR2rdwL8i+8Ll
 eNpGDUUfizxz6kU8+3lnn+Pg==
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

On 07.08.24 16:36, Simon Glass wrote:
> Hi Heinrich,
>
> On Tue, 6 Aug 2024 at 19:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 06.08.24 14:58, Simon Glass wrote:
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
>>>    lib/efi_loader/Kconfig   | 10 ++++++
>>>    lib/efi_loader/Makefile  |  1 +
>>>    lib/efi_loader/testapp.c | 68 +++++++++++++++++++++++++++++++++++++=
+++
>>>    3 files changed, 79 insertions(+)
>>>    create mode 100644 lib/efi_loader/testapp.c
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index ab2c1c44364..4de05c6f2d6 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
>>>          No additional space will be required in the resulting U-Boot =
binary
>>>          when this option is enabled.
>>>
>>> +config BOOTEFI_TESTAPP_COMPILE
>>> +     bool "Compile an EFI test app for testing"
>>> +     default y
>>> +     help
>>> +       This compiles an app designed for testing. It is packed into a=
n image
>>> +       by the test.py testing frame in the setup_efi_image() function=
.
>>> +
>>> +       No additional space will be required in the resulting U-Boot b=
inary
>>> +       when this option is enabled.
>>> +
>>>    endif
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index 00d18966f9e..87131ab911d 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
>>>    ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>>>    apps-y +=3D dtbdump
>>>    endif
>>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>>>
>>>    obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>>>    obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
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
>>> + * @handle:  handle of the loaded image
>>> + * @systab:  system table
>>> + * Return:   status code
>>> + */
>>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
>>> +                          struct efi_system_table *systab)
>>> +{
>>> +     struct efi_loaded_image *loaded_image;
>>> +     efi_status_t ret;
>>> +     efi_uintn_t map_size;
>>> +     efi_uintn_t map_key;
>>> +     efi_uintn_t desc_size;
>>> +     u32 desc_version;
>>> +
>>> +     systable =3D systab;
>>> +     boottime =3D systable->boottime;
>>> +     con_out =3D systable->con_out;
>>> +
>>> +     /* Get the loaded image protocol */
>>> +     ret =3D boottime->open_protocol(handle, &loaded_image_guid,
>>> +                                   (void **)&loaded_image, NULL, NULL=
,
>>> +                                   EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>>> +     if (ret !=3D EFI_SUCCESS) {
>>> +             con_out->output_string
>>> +                     (con_out, u"Cannot open loaded image protocol\r\=
n");
>>> +             goto out;
>>> +     }
>>> +
>>> +     /* UEFI requires CR LF */
>>> +     con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER=
\r\n");
>>> +
>>> +out:
>>> +     map_size =3D 0;
>>> +     ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &des=
c_size,
>>> +                                    &desc_version);
>>> +     con_out->output_string(con_out, u"Exiting boot sevices\n");
>>> +
>>> +     /* exit boot services so that this part of U-Boot can be tested =
*/
>>> +     boottime->exit_boot_services(handle, map_key);
>>> +
>>> +     /* now exit for real */
>>> +     ret =3D boottime->exit(handle, ret, 0, NULL);
>>
>> Please, have a look at chapter 7.4.6,
>> "EFI_BOOT_SERVICES.ExitBootServices" of the UEFI specification.
>>
>> After ExitBootServices() you cannot return anywhere. Boot services are
>> not available anymore. You can only invoke the UEFI runtime services
>> which include ResetSystem().
>
> Yes, understood, but this is a test, so returning is needed so that
> the test can check the output is correct.
>

ExitBootServices() calls dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL).
You cannot print anything afterwards as all devices are gone.

But you can check if a reboot occurs. This is enough to verify that a
ResetSystem() call placed after ExitBootServices() was executed.

We already have

* lib/efi_selftest/efi_selftest_exitbootservices.c
* lib/efi_selftest/efi_selftest_variables_runtime.c
* lib/efi_selftest/efi_selftest_set_virtual_address_map.c

which test different aspects of ExitBootServices() on the sandbox.

There is no need to duplicate these.

Best regards

Heinrich

