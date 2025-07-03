Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC40C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 01:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30FE81FEE;
	Thu,  3 Jul 2025 03:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="fgvKqz4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC9E8206E; Thu,  3 Jul 2025 03:16:14 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091B280E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 03:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-610d86b3da9so1852167eaf.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 18:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1751505371; x=1752110171; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6/bhxstWVdkSJ8zKTVPqyxOb8OqrJnlTjyS9890iyU=;
 b=fgvKqz4/g47yEfIHWVOZDijiKnCZIe8kuHiR2szQoSYpGJjoND2g02k3ofTv7D2VuJ
 wp+81UWM8+UO+VRZ+uG5etg8/gyx7fP7EjMlyVIUJ8o2z3JSPle1z0jndwhrAlkynpY/
 NlRMNo44gCO7b7QCIzjDo33ascdsH3qJTOwhVLqI5cZBzO9KHhyhFsPFqc7YcLhCqSHL
 e0KvfVjxsFeacI8J2avM7ujYhqVSpVZIvM4b/19bsrBkTOWXaV7VO0igzwT4wfODAuvM
 xysOVinRMpiWHU4IADxGXqaN65FEU3CkLKZJcUZB2PFNsq5Xe7vflS0VFCewPk5xke+f
 +vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751505371; x=1752110171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6/bhxstWVdkSJ8zKTVPqyxOb8OqrJnlTjyS9890iyU=;
 b=WK4R9NC4PyqqUhLS5u8hMFj4tzlQRJl1Q/ec5TtvNXRQEGJLIqBTk40Hfv/Y3PSPew
 8sN1Fr6lQ/vzJjM6ob4NJi87mKGQwOFOvOfAbxN9vykJSzE1v6RyVgcN+3uy3xOqsYxm
 iF/aEwpVI8gGnWWjrh9jrdUjeNCBlxEF8lm1e46oX9NZjY3H1Hm9CqloHg1mFd8IJGii
 2vPBH6XD4KDbbYh/LjVfhg6vFJcwxkevWyxQ8jFeyBYdRp03rL1svOcTyGGNGr69EwMC
 3wcjJJBQd0KfQvyDmp8MwEOb35luAzDeOCKACBhPqvpWf+QotIbHzgIB+AqONfYb20HK
 4+GA==
X-Gm-Message-State: AOJu0YxB9IShBBrN9u2hANgDz629+joXFFxnE9fFQi7F4xO/xr2JbjBn
 tkmYmC/jE9Ij+RVYxZ4ipYQdr2HAj/eAf6SKwlOpEz4CSGuMz+5h8HLRI/OKGLYhK2Y3gJ6Hgg8
 CQy3JMg3avHFtNnsFxcj4scBEpyOLzsxvzQj+u3dASwgLOdvNyNli8BpucQ==
X-Gm-Gg: ASbGncvyQ2gMEQVB2BrquFxOvdew2VHJoqmDqIxYy2/l7hgGEQ29JEA5BvonweDBIke
 HExsCG+k7jR00nkEj9REHKb7nRQqUJJtH1VaImIkrn0HRKHItvlQgfjuzGRvnqj2Xo4uuJs7av3
 nbVvt31SBmGOb99sofSJZQQV0yIeGPaEyH1pa67sBW3+o=
X-Google-Smtp-Source: AGHT+IF/StgdraP5R6/aLSdMnW80Ba2/elQBqYMiORspeK8m1htXn7LiSLua6svlTsogfV9RI8MBRFNIftzhqfryXok=
X-Received: by 2002:a05:6820:1994:b0:611:9a4d:fc44 with SMTP id
 006d021491bc7-61201244fcfmr3615067eaf.3.1751505370632; Wed, 02 Jul 2025
 18:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
 <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU0-wUW=j0N3RYVMsjhdpjxoU-GA8uVD_MAawYdj=X2N9Q@mail.gmail.com>
 <PAXPR04MB96444DFCEED12C6DF8B1A382E240A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB96444DFCEED12C6DF8B1A382E240A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 2 Jul 2025 18:15:59 -0700
X-Gm-Features: Ac12FXybFj55lREbRUQIS_Prnq0v-ZfptmPP6PaxBHL6-z7OTJkvsbgDjJNojRY
Message-ID: <CAJ+vNU057avBycyUgdmFG1+8qDA5RD+a09S7V5Ag5zJFuuTMiQ@mail.gmail.com>
Subject: Re: imx95 SDP support?
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 1, 2025 at 8:42=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> Hi Tim,
>
> i.MX95 BOOTROM is on M33 so that cannot call boot ROM API.
>

Hi Alice,

This makes sense - I forgot that the BOOTROM for the imx95 is on the M33.

> The difference between imx8mm BOOTROM and imx8mp/mn BOOTROMv2 is that BOO=
TROMv2
> can call ROM API to load and imx8mm BOOTROM has no such function. No need=
 to add USB
> support to imx8mp and imx8mn SPL.
>
> When you add USB support to i.MX95 SPL, have you increased the size of i.=
MX95 SPL? i.MX95 SDP
> uses USB3 which driver is in drivers/usb/dwc3/. Configure USB to gadget. =
The USB phy driver uses
> drivers/phy/phy-imx8mq-usb.c. i.MX95 has tca mux so that it is needed to =
add code in the USB phy
> driver.

When I add USB, SPL_USB_GADGET, and SPL_USB_DWC3_GENERIC the build fails:
aarch64-linux-ld.bfd: u-boot-spl section `.data_save' will not fit in
region `.sram'
aarch64-linux-ld.bfd: region `.sram' overflowed by 8936 bytes
make[2]: *** [scripts/Makefile.xpl:542: spl/u-boot-spl] Error 1
make[1]: *** [/home/tharvey/catalina/uboot/Makefile:2127:
spl/u-boot-spl] Error 2
make: *** [Makefile:186: sub-make] Error 2

There's no default SPL_SIZE_LIMIT set so the size here would be a
linker config somewhere.

I can disable MMC support to shrink things down enough however.

I see the TCA configuration you are referring to in Linux [1] but
that's all about USB 3.0 pairs and SDP just requires USB 2.0 so I
doubt that's needed. Regardless I've attempted to implement it in case
that's an issue.

If allow PHY_IMX8MQ_USB to be built for IMX95 I can get to the
following with some debugging added:
Normal Boot
spl_boot_device
get_boot_device
get_boot_device boot_type=3D14 boot_instance=3D3
get_boot_device BT_DEV_TYPE_USB boot_dev=3D17
spl_board_boot_device 17
spl_board_boot_device USB_BOOT (usb3.0: J8 Type-C USB)
Trying to boot from USB SDP
dwc3_glue_probe usb@4c010010
dwc3_generic_peripheral_probe usb@4c100000
dwc3_generic_probe usb@4c100000
imx8mq_usb_phy_probe phy@4c1f0040
tca_blk_init 0x4c1fc000
spl_sdp_load_image calling board_usb_init
spl_sdp_load_image calling g_dnl_clear_detach
spl_sdp_load_image calling g_dnl_register
sdp_add: cdev: 93203dd0 gadget: 932002b0 gadget->ep0: 93200dc0
spl_sdp_load_image calling sdp_init
SDP: initialize...
dwc3_gadget_interrupt link change
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
dwc3_gadget_interrupt erratic error
^^^ it spins here without ever getting out of the init phase

Any idea what might be missing here?

For the board I'm working on I really want to get SDP working on the
USB2 interface which on the imx95-19x19-evk routes to the Type-A
connector so I've done the following:
- add usb2 nodes to imx95.dtsi and imx95-19x19-evk.dtsi
- add imx95 support to ehci-mx6 ehci_usb_phy_mode() (I'm assuming the
USBNC_PHY_STATUS register is the same as the IMX8MM although its
missing from the IMX95 RM)
- enable SPL_USB_GADGET, SPL_USB_SDP_SUPPORT, USB_EHCI_MX7, CI_UDC,
SPL_NOP_PHY, SDP_LOADADDR
- work around the fact that get_boot_device returns QSPI_BOOT when
booted from the USB2

This gets me a bit further than the USB3 controller path:
Normal Boot
spl_boot_device
get_boot_device
get_boot_device boot_type=3D14 boot_instance=3D1
get_boot_device BT_DEV_TYPE_USB boot_dev=3D15
spl_board_boot_device 15
spl_board_boot_device (usb2.0: J7 Type-A USB)
Trying to boot from USB SDP
udc_device_get_by_index index=3D0
drivers/usb/gadget/ci_udc.c usb_gadget_register_driver
ehci_usb_of_to_plat usb@4c200000
ehci_usb_probe usb@4c200000
ehci_usb_probe usb@4c200000 ret=3D0
usb_gadget_register_driver usb_setup_ehci_gadget ret=3D0
sdp_add: cdev: 93200790 gadget: 2049b928 gadget->ep0: 2049b9c8
SDP: initialize...
sdp_set_alt: intf: 0 alt: 0
sdp_start_ep: ep:2049ba30 req:93200ad0
sdp_start_ep: ep:2049ba98 req:93200bd0
w_value: 0x0000 len: 0x0000
req_type: 0x20 ctrl->bRequest: 0x0a sdp->state: 0
w_value: 0x2200 len: 0x004c
req_type: 0x00 ctrl->bRequest: 0x06 sdp->state: 0
sdp_init complete
SDP: handle requests...
^^^ at this point SPL SDP enumerates on the host and I use 'uuu
flash.bin' again to load U-Boot proper
sdp_rx_command_complete: command: 0404, addr: 00000000, cnt: 931840
Downloading file of size 931840 to 0x90400000... done
Report 3: HAB security
ep1in-bulk complete --> 0, 5/5
Report 4: Status
ep1in-bulk complete --> 0, 65/65
sdp_rx_command_complete: command: 0b0b, addr: 00000000, cnt: 0
Report 3: HAB security
ep1in-bulk complete --> 0, 5/5
Jumping to header at 0x90400000
Header Tag is not an IMX image
Found header at 0x90400000
sdp_load_read: sector 0, count 400, buf 93202b90
sdp_load_read: sector 2000, count 8800, buf ff000000
sdp_load_read: sector a800, count d9000, buf 90200000
NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
NOTICE:  BL31: Built : 16:06:15, Dec 27 2024
^^^ hangs here at the end of the ATF

Any ideas what this one could be?

Best Regards,

Tim

>
> Best Regards,
> Alice Guo
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=882=E6=97=A5=
 3:50
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: u-boot <u-boot@lists.denx.de>; Fabio Estevam <feste=
vam@gmail.com>
> > =E4=B8=BB=E9=A2=98: Re: imx95 SDP support?
> >
> > On Tue, Jul 1, 2025 at 6:07=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.n=
xp.com> wrote:
> > >
> > > Hi Tim,
> > >
> > > i.MX95 needs to enable USB gadget in SPL to load the U-Boot proper. I=
t cannot
> > use boot ROM API.
> > >
> >
> > Hi Alice,
> >
> > This is unfortunate - is the ROM API not going to be usable for the
> > imx95 or is support code simply not written yet? I don't really underst=
and the
> > difference for example between the imx8mm BOOTROM and the imx8mp/mn
> > BOOTROMv2 where BOOTROMv2 can use the for SDP which greatly reduces the
> > SPL footprint.
> >
> > Have you been able to configure U-Boot SPL for imx95 SDP? I am
> > overflowing .sram codespace when I try to add 'either' support for the
> > USB2.0 controller or the USB3.0 controller.
> >
> > Best Regards,
> >
> > Tim
> >
> >
> > > Best Regards,
> > > Alice Guo
> > >
> > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=881=E6=
=97=A5 8:07
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: u-boot <u-boot@lists.denx.de>; Alice G=
uo (OSS)
> > > > <alice.guo@oss.nxp.com>; Fabio Estevam <festevam@gmail.com>
> > > > =E4=B8=BB=E9=A2=98: imx95 SDP support?
> > > >
> > > > Hi Alice,
> > > >
> > > > I'm wondering if you have any notes regarding U-Boot SPL SDP suppor=
t
> > > > for the imx95?
> > > >
> > > > The SPL boots over SDP just fine but I'm interested in getting to
> > > > the next step where the SPL provides SDP support to load U-Boot pro=
pper.
> > > > I'm not clear if the imx95 uses a similar bootrom to as the imx8 an=
d
> > > > imx93 or if this is done over scmi.
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
