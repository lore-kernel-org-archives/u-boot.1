Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F4D3E2A0
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 18:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2998909F;
	Mon, 28 Oct 2024 19:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bMtBJ1ZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31AA890B3; Mon, 28 Oct 2024 19:43:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07AE88B9F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730141006; x=1730745806; i=xypron.glpk@gmx.de;
 bh=CcHOsODUsIC/STbMEnKgwX9BlTXaBY1EdFXnmjHepnE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bMtBJ1ZC30OCL7NRFcu9vf1wzVSMcEdyxWUftb+qiNhAagc7sihyS/WXw4slga9l
 MB9dLv3jx1rY6NjFj7lUB1rpMKbj+hrYnIaIKQHsdzjcjaHw1HqyArz2b8RiIju/9
 ay0ioiKuJD+NAFcyDaoyS3K5hx0XeV1cAgakX2Q540QJ5BOlS0oJDM44ADr1WFea+
 1F/WCJhiaPs9J7iTzoP0D/0kXdpLEM70zYskgHa82puWxHsTJj2hRPe/4vJEcKVGc
 JrejCGs7QGV9T5bYwP1XHs2n0FuntvSvxNjdvE+uBGCDuJap0YF+VaShAPMgicTPr
 jyjnTFMLI4Kss6aucA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1u4v2D3ZQW-017J36; Mon, 28
 Oct 2024 19:43:25 +0100
Message-ID: <adacb624-28a8-41a0-a22b-19d2b9d3a5b1@gmx.de>
Date: Mon, 28 Oct 2024 19:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rWx8cniaxAOG18+M/zo6makDqvaJbq7nkOeLFmUQW3qbWDnlMpL
 1QNmnJuKP9jdWSX+gvLEpoNFq49euY+rYZ8juUl99zTpFd7Me6EjS+sKnqKwtSHM9rz+IQ/
 QAEPVHzhjmdIi3plIAU1O9nBX2HuHOAqQox0qsUwtu2uIdqJkghHMUB0I1HU/snAFy3owp7
 l1lL+tv/E0+9kAcroDjxQ==
UI-OutboundReport: notjunk:1;M01:P0:Rj0TulVhB6k=;PRCTABGrMoUcn7ZsxQ23MwfZi37
 GpIjN0deWVmvxlik9GmryxSi/7ESXnNcw3ml2to5ELu29ZnMh+VV/Hgk5G93Bb/o8IALdf7mi
 At1durlF26vxU3qyBz+j2N7VbDorlP3Fjp/6d/zEtxRcl2UBahfhPSBOYE43XVHCZC++AhnZc
 hOmUvEEalyB8Qxus185j+6GCaT+JTw6f8b83zdTI+Zev5KAKK+mQRcszcYU3mZAuO012H4LTR
 OqB2Qmr8AVasSEbxkzRF2hAy6koBurexdzwFXMfFUqlq/mAa3aTJFhw2EdDWzXkLmHWCEN57d
 L0Ez4ipRTPUKBYg25STj/UDKLd7DUAKJH1Zn9IDNm29tUpmYjse0HxrXRPT0Gqjie1EsZl3O+
 d81Bgd0wN3wR5ukce9VKU6+yXZH/H7zh4hU6JIWIC3KSRJFCQp7O1ZU8Hi7I34E2c5ng8+Exu
 zSvh4TIOooDY323LZRDTmtP5akgNrggp0qh22O4EoqSHtVZJPTnud5Bz3SDK570SGYDDB/ZTD
 UKAaetYsIJDKUj0KwBAHoVNHUlknKx9JP6MHsnIpZBZcD2ywS0l6P5uQ1zthqRw+39pKImS8I
 rbfU7TQCpVtDipEI/9QqEH7KD+mXgNaId4KfniHMB858STfQMk7SiFvihZH55EzNDAJtd5Ent
 SuxPNZMlBoefv3qTQnC7sQgonLCuRRd8UO0xWRteAE+9WWOKVyUK4b5VA8qK0UEF7yHbKUiJa
 x08WcS7vChdgX1cCPg7NVaJCu703mmdGQiDOLGrPqMBUeBBY9FeUSnmhpWwxC3+JAUBXbSKN6
 +KdPkNFWlvQBDrhiNWvNRVBw==
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

On 10/28/24 18:00, Simon Glass wrote:
> Hi Heinrich,
>
> On Mon, 28 Oct 2024 at 07:11, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>  >
>  > On 10/22/24 14:00, Simon Glass wrote:
>  > > Add a simple app to use for testing. This is intended to do whateve=
r it
>  > > needs to for testing purposes. For now it just prints a message and
>  > > exits boot services.
>  > >
>  > > There was a considerable amount of discussion about whether it is O=
K to
>  > > call exit-boot-services and then return to U-Boot. This is not norm=
ally
>  > > done in a real application, since exit-boot-services is used to
>  > > completely disconnect from U-Boot. However, since this is a test, w=
e
>  > > need to check the results of running the app, so returning is
> necessary.
>  > > It works correctly and it provides a nice model of how to test the =
EFI
>  > > code in a simple way.
>  > >
>  > > Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.o=
rg>>
>  > > ---
>  > >
>  > > (no changes since v7)
>  > >
>  > > Changes in v7:
>  > > - Update commit message
>  > >
>  > >=C2=A0 =C2=A0lib/efi_loader/Kconfig=C2=A0 =C2=A0| 10 ++++++
>  > >=C2=A0 =C2=A0lib/efi_loader/Makefile=C2=A0 |=C2=A0 1 +
>  > >=C2=A0 =C2=A0lib/efi_loader/testapp.c | 68 +++++++++++++++++++++++++=
++++++++++
> +++++
>  > >=C2=A0 =C2=A03 files changed, 79 insertions(+)
>  > >=C2=A0 =C2=A0create mode 100644 lib/efi_loader/testapp.c
>  > >
>  > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>  > > index 69b2c9360d8..6ced29da719 100644
>  > > --- a/lib/efi_loader/Kconfig
>  > > +++ b/lib/efi_loader/Kconfig
>  > > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No additional space will be requir=
ed in the resulting U-
> Boot binary
>  > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0when this option is enabled.
>  > >
>  > > +config BOOTEFI_TESTAPP_COMPILE
>  > > +=C2=A0 =C2=A0 =C2=A0bool "Compile an EFI test app for testing"
>  > > +=C2=A0 =C2=A0 =C2=A0default y
>  > > +=C2=A0 =C2=A0 =C2=A0help
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0This compiles an app designed for testi=
ng. It is packed
> into an image
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0by the test.py testing frame in the set=
up_efi_image() function.
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0No additional space will be required in=
 the resulting U-
> Boot binary
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0when this option is enabled.
>  > > +
>  > >=C2=A0 =C2=A0endif
>  > >
>  > >=C2=A0 =C2=A0source "lib/efi/Kconfig"
>  > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>  > > index 00d18966f9e..87131ab911d 100644
>  > > --- a/lib/efi_loader/Makefile
>  > > +++ b/lib/efi_loader/Makefile
>  > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrdd=
ump
>  > >=C2=A0 =C2=A0ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  > >=C2=A0 =C2=A0apps-y +=3D dtbdump
>  > >=C2=A0 =C2=A0endif
>  > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>  > >
>  > >=C2=A0 =C2=A0obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>  > >=C2=A0 =C2=A0obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
>  > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
>  > > new file mode 100644
>  > > index 00000000000..feb444c92e9
>  > > --- /dev/null
>  > > +++ b/lib/efi_loader/testapp.c
>  > > @@ -0,0 +1,68 @@
>  > > +// SPDX-License-Identifier: GPL-2.0+
>  >
>  > This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
>  >
>  > > +/*
>  > > + * Hello world EFI application
>  > > + *
>  > > + * Copyright 2024 Google LLC
>  > > + * Written by Simon Glass <sjg@chromium.org <mailto:sjg@chromium.o=
rg>>
>  > > + *
>  > > + * This test program is used to test the invocation of an EFI
> application.
>  > > + * It writes a few messages to the console and then exits boot
> services
>  > > + */
>  > > +
>  > > +#include <efi_api.h>
>  > > +
>  > > +static const efi_guid_t loaded_image_guid =3D
> EFI_LOADED_IMAGE_PROTOCOL_GUID;
>  > > +
>  > > +static struct efi_system_table *systable;
>  > > +static struct efi_boot_services *boottime;
>  > > +static struct efi_simple_text_output_protocol *con_out;
>  > > +
>  > > +/**
>  > > + * efi_main() - entry point of the EFI application.
>  > > + *
>  > > + * @handle:=C2=A0 handle of the loaded image
>  > > + * @systab:=C2=A0 system table
>  > > + * Return:=C2=A0 =C2=A0status code
>  > > + */
>  > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct efi_system_table *systab)
>  > > +{
>  > > +=C2=A0 =C2=A0 =C2=A0struct efi_loaded_image *loaded_image;
>  > > +=C2=A0 =C2=A0 =C2=A0efi_status_t ret;
>  > > +=C2=A0 =C2=A0 =C2=A0efi_uintn_t map_size;
>  > > +=C2=A0 =C2=A0 =C2=A0efi_uintn_t map_key;
>  > > +=C2=A0 =C2=A0 =C2=A0efi_uintn_t desc_size;
>  > > +=C2=A0 =C2=A0 =C2=A0u32 desc_version;
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0systable =3D systab;
>  > > +=C2=A0 =C2=A0 =C2=A0boottime =3D systable->boottime;
>  > > +=C2=A0 =C2=A0 =C2=A0con_out =3D systable->con_out;
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0/* Get the loaded image protocol */
>  > > +=C2=A0 =C2=A0 =C2=A0ret =3D boottime->open_protocol(handle, &loade=
d_image_guid,
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void **)&loade=
d_image, NULL, NULL,
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EFI_OPEN_PROTOC=
OL_GET_PROTOCOL);
>  > > +=C2=A0 =C2=A0 =C2=A0if (ret !=3D EFI_SUCCESS) {
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0con_out->output_st=
ring
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(con_out, u"Cannot open loaded image
> protocol\r\n");
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
>  > > +=C2=A0 =C2=A0 =C2=A0}
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0/* UEFI requires CR LF */
>  > > +=C2=A0 =C2=A0 =C2=A0con_out->output_string(con_out, u"U-Boot test =
app for
> EFI_LOADER\r\n");
>  > > +
>  > > +out:
>  > > +=C2=A0 =C2=A0 =C2=A0map_size =3D 0;
>  > > +=C2=A0 =C2=A0 =C2=A0ret =3D boottime->get_memory_map(&map_size, NU=
LL, &map_key,
> &desc_size,
>  > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &desc_version)=
;
>  > > +=C2=A0 =C2=A0 =C2=A0con_out->output_string(con_out, u"Exiting boot=
 sevices\n");
>  >
>  > %s/sevices/services/g
>  >
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0/* exit boot services so that this part of U-B=
oot can be
> tested */
>  > > +=C2=A0 =C2=A0 =C2=A0boottime->exit_boot_services(handle, map_key);
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0/* now exit for real */
>  > > +=C2=A0 =C2=A0 =C2=A0ret =3D boottime->exit(handle, ret, 0, NULL);
>  >
>  > As written before boot services are not available after
>  > ExitBootServices(). Please, call the ResetSystem() service.
>
> I already explained this. If I call reset then U-Boot exits and the
> console output cannot be checked by the C test. If I tell sandbox's
> reset-driver to ignore the reset request, then it also doesn't come back
> to the test.
>
>  >
>  >
>  > > +
>  > > +=C2=A0 =C2=A0 =C2=A0/* We should never arrive here */
>  > > +=C2=A0 =C2=A0 =C2=A0return ret;
>  >
>  > After ExitBootServices() you must not return.
>  >
>  > You can just do an endless loop if ResetSystem() fails:
>  >
>  > for (;;);
>
> No, because I need to check the output of the app. Please can you try to
> run this test so you can see what it is doing?

The Python framework lets you check the output whether you are rebooting
or not.

The test seems not to build on anything but sandbox. We should be able
to test the boot methods on QEMU systems.

In efi_exit_boot_services() we

* call dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL)
* call bootm_disable_interrupts()
* call board_quiesce_devices()
* disable all EFI timers
* disable EFI notification

What do you expect U-Boot to do after all of this? You cannot reasonably
do any follow on test without rebooting.

EDK II does the following in ExitBootServices():

   //
   // Clear the non-runtime values of the EFI System Table
   //
   gDxeCoreST->BootServices        =3D NULL;
   gDxeCoreST->ConIn               =3D NULL;
   gDxeCoreST->ConsoleInHandle     =3D NULL;
   gDxeCoreST->ConOut              =3D NULL;
   gDxeCoreST->ConsoleOutHandle    =3D NULL;
   gDxeCoreST->StdErr              =3D NULL;
   gDxeCoreST->StandardErrorHandle =3D NULL;

As said ExitBootServices is the point of no-return.

Please, write a compliant test that runs on all UEFI architectures. Then
we can review it further.

Best regards

Heinrich
