Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD3ED339AE
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 18:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5F6885F5;
	Mon, 28 Oct 2024 19:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KnmdUu5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD656890CE; Mon, 28 Oct 2024 19:07:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B800980245
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730138828; x=1730743628; i=xypron.glpk@gmx.de;
 bh=1DpYCKH2jYrnujulxbV9C1rF6yvwUYzXu4b/MFqF6Ag=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KnmdUu5TDdLobmi/8OKwfiD34eSGd5e/tj+O3oWMpPh6ZeRTq5Sy0B18KPzlY6W9
 DxcuozWOtOdFNZNinduEjWEums8d9G5mIL4TjoN6ipnYa05U/EF6Cn8rGVCpQXEmr
 7HABqp9WQONbvHenB3IPuH4JZzxeG91K6AAioc/pcowEbRLh1TZvyYDpkfKi7tYgK
 lJHfY5suAD30lT1CiLWd+SXWpcWRY7KbslO1G02dcDgz5Hml9h/dUKijvhej4Obzw
 BKI4DL01qyDw4vL3Q8H8D+cfmPQkmNUeie8qcffITTGgMP+UwIBJ1UqipDXu5t/K2
 40y6VZ7OwDIJcdEzsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1tVIT33xZK-00Wkwy; Mon, 28
 Oct 2024 19:07:08 +0100
Message-ID: <5688b032-a35a-4c76-8f7b-68216e8ee7a8@gmx.de>
Date: Mon, 28 Oct 2024 19:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <20241028151738.GO4959@bill-the-cat>
 <aff49443-ab1d-44a9-ad61-64dfa6114e37@gmx.de>
 <20241028165210.GQ4959@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241028165210.GQ4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+wAzspM6+eUGA4VhCDMYvXmAerAjgZlxtx3FtHIGbHAVpSBRWh
 L5k9NJhAzPbBnNO6Xmq4NOpBx0bT14MovFBH7KW8CsHUMGM28YV7u/GTRWuIcFAcAGcRUnu
 PJ9YwZEw1rqVz1FDLkwAO6H701ajQCg0aDdLYHmPr5h+WRgXPRrSzQg4QdPrLfJRqGCxyoX
 mpmLnyN08jhowptYP3PeQ==
UI-OutboundReport: notjunk:1;M01:P0:A9AQBUx0CgY=;S0q3TF6/OvY9jxSUyI/92pM0gt8
 R30XVvFZQinLI7vmRaVWxkeqk6E23DSN1qA+D9GWowGsd4Fo/zaXc8wmr/uRpl1nS0oqmCe+Y
 ixRZr21bkTEviEIQMhmS3JZJZKsWniTEwGyur25whsKXtQl8HVrLrcA3UpSCpHFeCQe8v65WD
 NaTeIjqOxrDtxSnMkZ7rZUOvUb5VO+wOVbD4XBNYsXkRSPeXfDeY7AKrZCV/5V2T1ZA+L/+09
 u3i3gpxzb30rkYd4fy2p8KtrS+g9eH9dgujflmm3bsTkNOyA/0zlxst9ZaOjUB4O7IDDlMzj8
 /HYS4utt0Elxt+6MEGgbUlQOs7WYU+U18q0St/0W9JF73bLvuw//kh5yUuaui/4PKQruM42FX
 cL3PDK13R4CkjZAFVCAesye5jGRMIZgQtBEgCCPB5gyOQAOLX+MrlsBs4Pv1ckGg/ayscS84o
 9vxDISCF8mDQWI5KrfRSUcDLOQCV8zGPTLIjN3RSnJv4yJATayaR1lMq+QqQfBh2Rdm4osLTv
 v8RKYZo4k1WQHDTe7sYxjW4HBXgQIE+pqy2/3oSwM27GHPh7RjNmkOqc0sE18kTJkgVpjTjxL
 Bl9m0t1cp5iKn/c742/SATZO6hJkheRT2GQSA5eJU1NKYTwyQCqbMJV3IaP+gAMNZW+H3SKyv
 8+Dvkqn6alYFILFwPpXCdRCDt6hG9p7dD1y0hmbMFIy3s6HUDIUq+lpmivB5odFbopns7usSM
 g8XLTIuTYTIE0zPFHsthXVYImsYMx8/gmmaPFU7MeATKswHUisBXBljq14iYlGNwJDQAMilXu
 TYeUnJscsAJjI/Zakg07mDWA==
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

On 10/28/24 17:52, Tom Rini wrote:
> On Mon, Oct 28, 2024 at 05:47:08PM +0100, Heinrich Schuchardt wrote:
>> On 10/28/24 16:17, Tom Rini wrote:
>>> On Mon, Oct 28, 2024 at 06:59:10AM +0100, Heinrich Schuchardt wrote:
>>>> On 10/22/24 14:00, Simon Glass wrote:
>>>>> Add a simple app to use for testing. This is intended to do whatever=
 it
>>>>> needs to for testing purposes. For now it just prints a message and
>>>>> exits boot services.
>>>>>
>>>>> There was a considerable amount of discussion about whether it is OK=
 to
>>>>> call exit-boot-services and then return to U-Boot. This is not norma=
lly
>>>>> done in a real application, since exit-boot-services is used to
>>>>> completely disconnect from U-Boot. However, since this is a test, we
>>>>> need to check the results of running the app, so returning is necess=
ary.
>>>>> It works correctly and it provides a nice model of how to test the E=
FI
>>>>> code in a simple way.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>> (no changes since v7)
>>>>>
>>>>> Changes in v7:
>>>>> - Update commit message
>>>>>
>>>>>     lib/efi_loader/Kconfig   | 10 ++++++
>>>>>     lib/efi_loader/Makefile  |  1 +
>>>>>     lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++=
++++++
>>>>>     3 files changed, 79 insertions(+)
>>>>>     create mode 100644 lib/efi_loader/testapp.c
>>>>>
>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>> index 69b2c9360d8..6ced29da719 100644
>>>>> --- a/lib/efi_loader/Kconfig
>>>>> +++ b/lib/efi_loader/Kconfig
>>>>> @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
>>>>>     	  No additional space will be required in the resulting U-Boot =
binary
>>>>>     	  when this option is enabled.
>>>>>
>>>>> +config BOOTEFI_TESTAPP_COMPILE
>>>>> +	bool "Compile an EFI test app for testing"
>>>>> +	default y
>>>>> +	help
>>>>> +	  This compiles an app designed for testing. It is packed into an =
image
>>>>> +	  by the test.py testing frame in the setup_efi_image() function.
>>>>> +
>>>>> +	  No additional space will be required in the resulting U-Boot bin=
ary
>>>>> +	  when this option is enabled.
>>>>> +
>>>>>     endif
>>>>>
>>>>>     source "lib/efi/Kconfig"
>>>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>>>> index 00d18966f9e..87131ab911d 100644
>>>>> --- a/lib/efi_loader/Makefile
>>>>> +++ b/lib/efi_loader/Makefile
>>>>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddu=
mp
>>>>>     ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>>>>>     apps-y +=3D dtbdump
>>>>>     endif
>>>>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>>>>>
>>>>>     obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>>>>>     obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
>>>>> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
>>>>> new file mode 100644
>>>>> index 00000000000..feb444c92e9
>>>>> --- /dev/null
>>>>> +++ b/lib/efi_loader/testapp.c
>>>>> @@ -0,0 +1,68 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>
>>>> This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
>>>
>>> We should switch to the proper one here, but there are numerous exampl=
es
>>> of this today.
>>>
>>>>> +/*
>>>>> + * Hello world EFI application
>>>>> + *
>>>>> + * Copyright 2024 Google LLC
>>>>> + * Written by Simon Glass <sjg@chromium.org>
>>>>> + *
>>>>> + * This test program is used to test the invocation of an EFI appli=
cation.
>>>>> + * It writes a few messages to the console and then exits boot serv=
ices
>>>>> + */
>>>>> +
>>>>> +#include <efi_api.h>
>>>>> +
>>>>> +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROT=
OCOL_GUID;
>>>>> +
>>>>> +static struct efi_system_table *systable;
>>>>> +static struct efi_boot_services *boottime;
>>>>> +static struct efi_simple_text_output_protocol *con_out;
>>>>> +
>>>>> +/**
>>>>> + * efi_main() - entry point of the EFI application.
>>>>> + *
>>>>> + * @handle:	handle of the loaded image
>>>>> + * @systab:	system table
>>>>> + * Return:	status code
>>>>> + */
>>>>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
>>>>> +			     struct efi_system_table *systab)
>>>>> +{
>>>>> +	struct efi_loaded_image *loaded_image;
>>>>> +	efi_status_t ret;
>>>>> +	efi_uintn_t map_size;
>>>>> +	efi_uintn_t map_key;
>>>>> +	efi_uintn_t desc_size;
>>>>> +	u32 desc_version;
>>>>> +
>>>>> +	systable =3D systab;
>>>>> +	boottime =3D systable->boottime;
>>>>> +	con_out =3D systable->con_out;
>>>>> +
>>>>> +	/* Get the loaded image protocol */
>>>>> +	ret =3D boottime->open_protocol(handle, &loaded_image_guid,
>>>>> +				      (void **)&loaded_image, NULL, NULL,
>>>>> +				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>>>>> +	if (ret !=3D EFI_SUCCESS) {
>>>>> +		con_out->output_string
>>>>> +			(con_out, u"Cannot open loaded image protocol\r\n");
>>>>> +		goto out;
>>>>> +	}
>>>>> +
>>>>> +	/* UEFI requires CR LF */
>>>>> +	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r=
\n");
>>>>> +
>>>>> +out:
>>>>> +	map_size =3D 0;
>>>>> +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc_=
size,
>>>>> +				       &desc_version);
>>>>> +	con_out->output_string(con_out, u"Exiting boot sevices\n");
>>>>
>>>> %s/sevices/services/g
>>>>
>>>>> +
>>>>> +	/* exit boot services so that this part of U-Boot can be tested */
>>>>> +	boottime->exit_boot_services(handle, map_key);
>>>>> +
>>>>> +	/* now exit for real */
>>>>> +	ret =3D boottime->exit(handle, ret, 0, NULL);
>>>>
>>>> As written before boot services are not available after
>>>> ExitBootServices(). Please, call the ResetSystem() service.
>>>
>>> Right, but the point is to not do that and instead test what happens. =
I
>>> think Ilias had said we need to make some big loud print on console th=
at
>>> you must reset the system for it to be usable afterwards, would that
>>> be enough?
>>>
>>
>> There is no point in testing what happens as this call is not allowable=
.
>>
>> Do we really need to zero out the bootservices table for people who do
>> not read the spec to find out the hard way?
>
> Then perhaps this is a case where "test causes U-Boot to reset, check
> for that as the result" is what the test needs to do, as it's not an
> arbitrary reset?
>

Yes, we should check that a reset occurs after ResetSystem(). Currently
we are only testing that the EFI watchdog resets the system in
test_efi_selftest_watchdog_reboot().

As on all non-sandbox systems all devices are removed at
ExitBootServices() this is the only way forward to write a test that
works on all UEFI supporting U-Boot systems.

Best regards

Heinrich
