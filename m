Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF13C83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 01:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89C8803DF;
	Fri,  4 Jul 2025 03:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Y18WrcOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F45E81D5D; Fri,  4 Jul 2025 03:06:55 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CEFC801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 03:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73a9c5ccfcdso312215a34.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1751591211; x=1752196011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9k5du2qwjkk4sVIhwauI74UKta4wTepn026lCYxF1Q=;
 b=Y18WrcOta1pGdNWbyq0GiF1tzubH9CMHiLAOIWmPVz6fbpCLEgk7P/q49As7znhgVl
 TSZ5lKb8ipcUeR64730+ocf+Sc1oo9pPAkQpN8fpaiWIwfKdK6eDNrlJNjZgr/lC2IH8
 EPl78iQ+CqXvY7b9ITpIC5OlYeRzLSByl+AWj4O+tOFbB6w7EabTozzguuvM77N9iFT9
 GcucCIu573j3SOhG37X6/YcqhybSQDQ/ajmCqMCSEQLivpYpiODB8JT1G2c1CCCIEo4e
 IaMliUWuMCCYBeizT1qTzHJoyv+LNdo9JYf4Kql+3kh97GCKsU5LfQu6sOLa1NiLq/Do
 6Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751591211; x=1752196011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9k5du2qwjkk4sVIhwauI74UKta4wTepn026lCYxF1Q=;
 b=d6T6L+S7MqHutT+lqRA/Ak2huPJXrj+U1OHZ06UnlKQ8GmGYjjn0OjxwxTxDcPuTve
 DjL2Kb+7JKcUcodR6TTZXJh/1nOqbkoMOsS5B/m4JPWihY7wbZMe5m8xhP9R/+lJtLJG
 JPvYiaq+7WhC2dtSTBWe1MML9Zf+nNw/1jUdYCQP9ZWbWbqd6wI4uMA5+KfzigZw9WFQ
 2hxhprzPZklhKA/dFaQ8nreaQh9m9LC7iYEV27Gx9oj+/LRfipqD2yyUtgGWAJr5tcfb
 dFLltS0YCNV0F8/1Ut4YX5NRRJPY8Q2sbR+BzbOaMxa/6rF9BYV8nMXzbcITSG3Y8sYh
 klZw==
X-Gm-Message-State: AOJu0YzIsfJhhOmQowkGuytrVc1lCMs6+ZqBL1JTtHwCFiM/T3G/klDN
 5efEq0BkNgoQ92KH66RzNGHhnGAxcqV2LHNF+Y6S/Wn4bnrnC1NE/BB5S7NkNAWUoGmLJkXnd5g
 gLWcqXCIk4BFZUay7GmJjtImxIABo3BAL1UfDUrR1CUkGMzWq6tEnZsKcTA==
X-Gm-Gg: ASbGncuN10QcwXx5VeGrRJ0hVdzyOCUwhOEvdtuZHGCB4LI72X47dCFEwYoRgD9O6cd
 4B5xdkUcqRHPfANQWyl1KmPlaMv1HuTULSoT9hzvg6MqejOBtgi1m5SDk62yk68qDCesxXvMd6Z
 e4snz615DgYWa1SjOsGfcu7X9Gg+byfhGL2aQJE8Ye+KM=
X-Google-Smtp-Source: AGHT+IEx3TXzs+l2Imn3gpAdRjWmPFHTKuKgyDz7/THgxVKviMAi1dr6/8NICC+gWYyUKNKMSiEnHBO4H7k/0nILT/A=
X-Received: by 2002:a05:6830:b90:b0:739:fe21:42ba with SMTP id
 46e09a7af769-73ca1311522mr862264a34.22.1751591210765; Thu, 03 Jul 2025
 18:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
 <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU0-wUW=j0N3RYVMsjhdpjxoU-GA8uVD_MAawYdj=X2N9Q@mail.gmail.com>
 <PAXPR04MB96444DFCEED12C6DF8B1A382E240A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAJ+vNU057avBycyUgdmFG1+8qDA5RD+a09S7V5Ag5zJFuuTMiQ@mail.gmail.com>
 <PAXPR04MB964438C58F1ED6B4F14936EFE243A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB964438C58F1ED6B4F14936EFE243A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 3 Jul 2025 18:06:39 -0700
X-Gm-Features: Ac12FXxMVsT0JsTM3BDkeGYQookXcsLCkybpNK7H1tSS-iXcFTEGCcHcGjZnfmI
Message-ID: <CAJ+vNU32v34ZtUqDwLvndv3gKTeWOsfqLXHR7NPOGMuH1x9qEg@mail.gmail.com>
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

On Thu, Jul 3, 2025 at 4:24=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> Hi Tim,
>
> I do not know the reason for the problems you met and will try to enable =
imx95 SDP recently. USB 2.0 can also be used.
>

Hi Alice,

I eventually got SDP working on i.MX95 USB3 DWC3. It turns out I did
need to put the TCA block into system configuration mode otherwise the
USB PHY would not link which was my issue. I'll submit a patch that
enables initial i.MX95 support for phy-imx8mq-usb.c next week. It at
least gets the USB3 controller working in device mode, but host mode
will present difficulties as we will need a way to communicate with a
TCPM to configure the XBar for a Type-C connector orientation.
Additionally for the imx95-evk we would need a PTN5110P driver to be
able to enable VBUS and determine the Type-C plug orientation.

I was also able to verify i.MX95 USB2 EHCI in host mode as well as
gadget mode (by setting its dr_mode to peripheral and adding support
for role determination which I sent a patch for) and everything worked
fine there yet when booting over SDP I still am hanging after the ATF
BL31 prints after loading U-Boot proper via SDP for some reason.

Best Regards,

Tim

> Best Regards,
> Alice Guo
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=883=E6=97=A5=
 9:16
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: u-boot <u-boot@lists.denx.de>; Fabio Estevam <feste=
vam@gmail.com>
> > =E4=B8=BB=E9=A2=98: Re: imx95 SDP support?
> >
> > On Tue, Jul 1, 2025 at 8:42=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.n=
xp.com> wrote:
> > >
> > > Hi Tim,
> > >
> > > i.MX95 BOOTROM is on M33 so that cannot call boot ROM API.
> > >
> >
> > Hi Alice,
> >
> > This makes sense - I forgot that the BOOTROM for the imx95 is on the M3=
3.
> >
> > > The difference between imx8mm BOOTROM and imx8mp/mn BOOTROMv2 is
> > that
> > > BOOTROMv2 can call ROM API to load and imx8mm BOOTROM has no such
> > > function. No need to add USB support to imx8mp and imx8mn SPL.
> > >
> > > When you add USB support to i.MX95 SPL, have you increased the size o=
f
> > > i.MX95 SPL? i.MX95 SDP uses USB3 which driver is in drivers/usb/dwc3/=
.
> > > Configure USB to gadget. The USB phy driver uses
> > > drivers/phy/phy-imx8mq-usb.c. i.MX95 has tca mux so that it is needed=
 to add
> > code in the USB phy driver.
> >
> > When I add USB, SPL_USB_GADGET, and SPL_USB_DWC3_GENERIC the build
> > fails:
> > aarch64-linux-ld.bfd: u-boot-spl section `.data_save' will not fit in r=
egion `.sram'
> > aarch64-linux-ld.bfd: region `.sram' overflowed by 8936 bytes
> > make[2]: *** [scripts/Makefile.xpl:542: spl/u-boot-spl] Error 1
> > make[1]: *** [/home/tharvey/catalina/uboot/Makefile:2127:
> > spl/u-boot-spl] Error 2
> > make: *** [Makefile:186: sub-make] Error 2
> >
> > There's no default SPL_SIZE_LIMIT set so the size here would be a linke=
r config
> > somewhere.
> >
> > I can disable MMC support to shrink things down enough however.
> >
> > I see the TCA configuration you are referring to in Linux [1] but that'=
s all about
> > USB 3.0 pairs and SDP just requires USB 2.0 so I doubt that's needed. R=
egardless
> > I've attempted to implement it in case that's an issue.
> >
> > If allow PHY_IMX8MQ_USB to be built for IMX95 I can get to the followin=
g with
> > some debugging added:
> > Normal Boot
> > spl_boot_device
> > get_boot_device
> > get_boot_device boot_type=3D14 boot_instance=3D3 get_boot_device
> > BT_DEV_TYPE_USB boot_dev=3D17 spl_board_boot_device 17
> > spl_board_boot_device USB_BOOT (usb3.0: J8 Type-C USB) Trying to boot f=
rom
> > USB SDP dwc3_glue_probe usb@4c010010 dwc3_generic_peripheral_probe
> > usb@4c100000 dwc3_generic_probe usb@4c100000 imx8mq_usb_phy_probe
> > phy@4c1f0040 tca_blk_init 0x4c1fc000 spl_sdp_load_image calling
> > board_usb_init spl_sdp_load_image calling g_dnl_clear_detach
> > spl_sdp_load_image calling g_dnl_register
> > sdp_add: cdev: 93203dd0 gadget: 932002b0 gadget->ep0: 93200dc0
> > spl_sdp_load_image calling sdp_init
> > SDP: initialize...
> > dwc3_gadget_interrupt link change
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > dwc3_gadget_interrupt erratic error
> > ^^^ it spins here without ever getting out of the init phase
> >
> > Any idea what might be missing here?
> >
> > For the board I'm working on I really want to get SDP working on the
> > USB2 interface which on the imx95-19x19-evk routes to the Type-A connec=
tor so
> > I've done the following:
> > - add usb2 nodes to imx95.dtsi and imx95-19x19-evk.dtsi
> > - add imx95 support to ehci-mx6 ehci_usb_phy_mode() (I'm assuming the
> > USBNC_PHY_STATUS register is the same as the IMX8MM although its missin=
g
> > from the IMX95 RM)
> > - enable SPL_USB_GADGET, SPL_USB_SDP_SUPPORT, USB_EHCI_MX7, CI_UDC,
> > SPL_NOP_PHY, SDP_LOADADDR
> > - work around the fact that get_boot_device returns QSPI_BOOT when boot=
ed
> > from the USB2
> >
> > This gets me a bit further than the USB3 controller path:
> > Normal Boot
> > spl_boot_device
> > get_boot_device
> > get_boot_device boot_type=3D14 boot_instance=3D1 get_boot_device
> > BT_DEV_TYPE_USB boot_dev=3D15 spl_board_boot_device 15
> > spl_board_boot_device (usb2.0: J7 Type-A USB) Trying to boot from USB S=
DP
> > udc_device_get_by_index index=3D0 drivers/usb/gadget/ci_udc.c
> > usb_gadget_register_driver ehci_usb_of_to_plat usb@4c200000
> > ehci_usb_probe usb@4c200000 ehci_usb_probe usb@4c200000 ret=3D0
> > usb_gadget_register_driver usb_setup_ehci_gadget ret=3D0
> > sdp_add: cdev: 93200790 gadget: 2049b928 gadget->ep0: 2049b9c8
> > SDP: initialize...
> > sdp_set_alt: intf: 0 alt: 0
> > sdp_start_ep: ep:2049ba30 req:93200ad0
> > sdp_start_ep: ep:2049ba98 req:93200bd0
> > w_value: 0x0000 len: 0x0000
> > req_type: 0x20 ctrl->bRequest: 0x0a sdp->state: 0
> > w_value: 0x2200 len: 0x004c
> > req_type: 0x00 ctrl->bRequest: 0x06 sdp->state: 0 sdp_init complete
> > SDP: handle requests...
> > ^^^ at this point SPL SDP enumerates on the host and I use 'uuu flash.b=
in' again
> > to load U-Boot proper
> > sdp_rx_command_complete: command: 0404, addr: 00000000, cnt: 931840
> > Downloading file of size 931840 to 0x90400000... done Report 3: HAB sec=
urity
> > ep1in-bulk complete --> 0, 5/5 Report 4: Status ep1in-bulk complete -->=
 0, 65/65
> > sdp_rx_command_complete: command: 0b0b, addr: 00000000, cnt: 0 Report 3=
:
> > HAB security ep1in-bulk complete --> 0, 5/5 Jumping to header at 0x9040=
0000
> > Header Tag is not an IMX image Found header at 0x90400000
> > sdp_load_read: sector 0, count 400, buf 93202b90
> > sdp_load_read: sector 2000, count 8800, buf ff000000
> > sdp_load_read: sector a800, count d9000, buf 90200000
> > NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
> > NOTICE:  BL31: Built : 16:06:15, Dec 27 2024 ^^^ hangs here at the end =
of the
> > ATF
> >
> > Any ideas what this one could be?
> >
> > Best Regards,
> >
> > Tim
> >
> > >
> > > Best Regards,
> > > Alice Guo
> > >
> > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=882=E6=
=97=A5 3:50
> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com=
>
> > > > =E6=8A=84=E9=80=81: u-boot <u-boot@lists.denx.de>; Fabio Estevam
> > > > <festevam@gmail.com>
> > > > =E4=B8=BB=E9=A2=98: Re: imx95 SDP support?
> > > >
> > > > On Tue, Jul 1, 2025 at 6:07=E2=80=AFAM Alice Guo (OSS) <alice.guo@o=
ss.nxp.com>
> > wrote:
> > > > >
> > > > > Hi Tim,
> > > > >
> > > > > i.MX95 needs to enable USB gadget in SPL to load the U-Boot
> > > > > proper. It cannot
> > > > use boot ROM API.
> > > > >
> > > >
> > > > Hi Alice,
> > > >
> > > > This is unfortunate - is the ROM API not going to be usable for the
> > > > imx95 or is support code simply not written yet? I don't really
> > > > understand the difference for example between the imx8mm BOOTROM
> > and
> > > > the imx8mp/mn
> > > > BOOTROMv2 where BOOTROMv2 can use the for SDP which greatly reduces
> > > > the SPL footprint.
> > > >
> > > > Have you been able to configure U-Boot SPL for imx95 SDP? I am
> > > > overflowing .sram codespace when I try to add 'either' support for
> > > > the
> > > > USB2.0 controller or the USB3.0 controller.
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
> > > >
> > > >
> > > > > Best Regards,
> > > > > Alice Guo
> > > > >
> > > > > > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > > > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > > > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=881=
=E6=97=A5 8:07
> > > > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: u-boot <u-boot@lists.denx.de>; Ali=
ce Guo (OSS)
> > > > > > <alice.guo@oss.nxp.com>; Fabio Estevam <festevam@gmail.com>
> > > > > > =E4=B8=BB=E9=A2=98: imx95 SDP support?
> > > > > >
> > > > > > Hi Alice,
> > > > > >
> > > > > > I'm wondering if you have any notes regarding U-Boot SPL SDP
> > > > > > support for the imx95?
> > > > > >
> > > > > > The SPL boots over SDP just fine but I'm interested in getting
> > > > > > to the next step where the SPL provides SDP support to load U-B=
oot
> > propper.
> > > > > > I'm not clear if the imx95 uses a similar bootrom to as the imx=
8
> > > > > > and
> > > > > > imx93 or if this is done over scmi.
> > > > > >
> > > > > > Best Regards,
> > > > > >
> > > > > > Tim
