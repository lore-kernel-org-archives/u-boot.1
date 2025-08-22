Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DDACA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 21:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2E380422;
	Fri, 22 Aug 2025 23:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="VQeaolNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA9582998; Fri, 22 Aug 2025 23:38:03 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957C68006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 23:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-435de764e08so1499748b6e.1
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755898679; x=1756503479; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzZDvf3UZfbe2iW7BvjwOUsVx5VDGHxQ33mZbVKGogg=;
 b=VQeaolNuf07IgyeLVJTeCN3G1xEbirMyxRI7U86KhcZwrhT5eGwIMFBObRxp/rYuzO
 hYA7iQuuZhKr8qwlFqwTMGlY2coblR22F+LdoWIkrcOhxVG6xoqmdltJ0PumWKlgD5hN
 ODcH7911vjUsve8Ni5vyAl1WimdTu4tg+N9waMsMHKO7osf1OGcxg2JRH+1ivJ7XiRw2
 bAK1mC8tOrSyzhn+hvmYv14UN8nooR/o5nnz/akhhWXxN1NYJn/7oKEK0zxKh8VB0Aqr
 tXEHe5YeS7Zq4yp5nWQjMJ5Vn573DhjhLouBz+JtINp2J738gE0wwAcMaIwo5gqhVH+N
 xpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755898679; x=1756503479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzZDvf3UZfbe2iW7BvjwOUsVx5VDGHxQ33mZbVKGogg=;
 b=DnOKPWFGLxgfjMAO89asG+qM9FzZ7iOkKKJCU6532LhIr2d17Kfrw0V5K+zNOl9oW/
 4hr4AV4q+QYOPF5mS282lLJZLh9HzBogdismefshq6eW3eDyDv5DLYWrOYcyj3rP3v++
 FOqIMlWByAfxlQdtw9lp3tEgNUyLVh01aIykgGr9eqLRoucaqoebcJ06wXoU6VR9Bfn+
 Tx2gf6BcH0bN2rnTHfnoQi1CoxsFBp+BE3flvzCUkbWoDNzgd5uD9er556BQPgGMJboY
 Qy9JYbQEOkPFkYWsLCbrLr8+sn9bji3OZQg9OoZLbMgMQe4RpcEK6B0+lAf5zNLw4/1v
 oUsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkqrGaJv3aOKMPUJdGop0fqQ9BAUcdow7ApKaw+G1AcmH7d0pXk+67w2AX6Y5U0D9yQ6qsVWk=@lists.denx.de
X-Gm-Message-State: AOJu0YwB8dNanmY9us5p2N0e9ZWYck/CUiLXUoW2y6B1QZhkGYH3u4El
 1hxrgqGEJGyyQTCUB9oBoNMJszf784JjM/DrXSnwcaK6CqFkflWsVBR6EdCMy6BXvS8b1hq37QF
 xltJyrKnlkBohzSrQ4qwNleE4XWVt0UhB6GGvPZzPaw==
X-Gm-Gg: ASbGncsH3Oe4/QBdcRf7FIbLbUc5BrnBfgdIXfA83BFyaNyq+wWDCS+SrGj6gr5Xtx/
 wIGhJ6c8mzi/ORnNksHWEFYMEywh9NZqYChNOmdfTlLxRXn7TvHw9Et4FJn7tiagDpZTwxpHYrZ
 v97C9cwoyFvX06IX0osoXjJFIUp/zoqFqS0UXe5BaxRK3WLVTuhGCVvWRQdyJRzbVugy5Ki2qsh
 HSn0ZY=
X-Google-Smtp-Source: AGHT+IFd3RPmyJan8iotbY3tpLOSi89nkhwhID3FgjDXrTNDGBPcJUNmjecxRRlexnTRgnV10POL3cdmi9PpvIubmyE=
X-Received: by 2002:a05:6808:1485:b0:433:ed9b:fcfd with SMTP id
 5614622812f47-437851bacf6mr1967495b6e.19.1755898679143; Fri, 22 Aug 2025
 14:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250721180205.2696763-1-tharvey@gateworks.com>
 <20250724034438.GH18395@nxa18884-linux.ap.freescale.net>
 <CAJ+vNU0bm6ZB3cZP6Az45sNsMZ3QZJEVj7C20yFygF_YSqa5bA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0bm6ZB3cZP6Az45sNsMZ3QZJEVj7C20yFygF_YSqa5bA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 22 Aug 2025 14:37:48 -0700
X-Gm-Features: Ac12FXxs8vwVw5OZPbe78Dd3HsliCLeUunZGET9dXY1nOSBE-n8BeJDbu3lbVHU
Message-ID: <CAJ+vNU1n_+Q70jYEtZ4Eii4qM_R6e+uVfHPKZD5KYHt_ZrX2cw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
To: Peng Fan <peng.fan@oss.nxp.com>, Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@oss.nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
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

On Mon, Jul 28, 2025 at 11:04=E2=80=AFAM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Wed, Jul 23, 2025 at 7:34=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> w=
rote:
> >
> > Hi Tim,
> >
> > On Mon, Jul 21, 2025 at 11:02:05AM -0700, Tim Harvey wrote:
> > >When the usb node is defined dr_mode=3D"otg" ehci_usb_phy_mode() is ca=
lled
> > >to determine the mode from status registers.
> > >
> > >The IMX95RM does not currently define the USBNC STATUS register but it=
 is
> > >assumed to be an omission as the first three registers are defined.
> > >It has been expirimentally verified that the USBNC_PHY_STATUS register
> > >at offset 0x23C bit4 (USBNC_PHYSTATUS_ID_DIG) reads 0 when USB_ID is G=
ND
> > >and 1 when floating.
> > >
> > >Use is_imx9() as this driver works for i.MX91, i.MX93 and i.MX95 and a=
ll
> > >of these determine the role based on the USBNC_PHY_STATUS register.
> >
> > Just a question, does your board use USB2.0 port for SDP? And any publi=
c
> > patches ready for that?
> >
>
> Hi Peng,
>
> Yes, I am using the USB2.0 interface for SDP. Aside from this patch
> the usb2 nodes need to be added to the dt (usbphynop, usb2, usbmisc
> which are already in kernel but not yet in uboot dts/upstream).
>
> However, unlike SDP on the USB3.0 interface which I was able to get
> working, I was getting stuck somewhere between the ATF and U-Boot
> proper on USB2.0. I can no longer boot software on my imx95_19x19_evk
> after the changes merged for B0 so I'm unable to test and compare
> notes at the moment.
>
> Best Regards,
>
> Tim
>
>

Hi Peng,

Just to follow-up here I have been able to get imx95 to boot via SDP
on imx95-19x19's USB2 with the following:
1. the patch in this thread
2. the env-is-nowhere patch from Jo=C3=A3o Paulo Gon=C3=A7alves:
https://www.mail-archive.com/u-boot@lists.denx.de/msg550594.html
3. adding the usb2/reg_usb_vbus/usbphynop to imx95-19x19-evk-u-boot.dtsi
4. the following changes to defconfig:
--- a/configs/imx95.config
+++ b/configs/imx95.config
@@ -129,6 +129,8 @@ CONFIG_DM_MDIO=3Dy
 CONFIG_MII=3Dy
 CONFIG_FSL_ENETC=3Dy
 CONFIG_PCIE_ECAM_GENERIC=3Dy
+CONFIG_SPL_PHY=3Dy
+CONFIG_SPL_NOP_PHY=3Dy
 CONFIG_PINCTRL=3Dy
 CONFIG_SPL_PINCTRL=3Dy
 CONFIG_PINCTRL_IMX_SCMI=3Dy
@@ -146,16 +148,17 @@ CONFIG_SPI=3Dy
 CONFIG_DM_SPI=3Dy
 CONFIG_NXP_FSPI=3Dy
 CONFIG_USB=3Dy
-CONFIG_SPL_DM_USB_GADGET=3Dy
+CONFIG_SPL_USB_HOST=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
-CONFIG_USB_DWC3=3Dy
-CONFIG_SPL_USB_DWC3_GENERIC=3Dy
 CONFIG_USB_GADGET=3Dy
 CONFIG_SPL_USB_GADGET=3Dy
 CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=3D0x1fc9
 CONFIG_USB_GADGET_PRODUCT_NUM=3D0x0152
+CONFIG_CI_UDC=3Dy
 CONFIG_SDP_LOADADDR=3D0x90400000
+CONFIG_USB_GADGET_DOWNLOAD=3Dy
+CONFIG_USB_FUNCTION_SDP=3Dy
 CONFIG_SPL_USB_SDP_SUPPORT=3Dy
 CONFIG_ULP_WATCHDOG=3Dy
 CONFIG_LZO=3Dy

Note that I had to disable DWC3 and I think that's because it uses dm
for gadget mode and CI_UDC does not support that and thus duplicates
functions.

This was needed to bring up a custom board that runs USB3 to a HUB and
USB2 to a Type-C connector.

Fabio,

I'm not sure if you were needing more reviews for this one or if you
were just waiting for a follow-up to Peng's question.

Best Regards,

Tim
