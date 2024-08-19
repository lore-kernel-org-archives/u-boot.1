Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59CC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED6988CC5;
	Mon, 19 Aug 2024 15:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="baqOuhvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FA388356; Mon, 19 Aug 2024 09:15:56 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB01788113
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 09:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=crausaz.romain@gmail.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39d2256ee95so17029285ab.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724051752; x=1724656552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h+HBo0Lo8GjeCjRvqc2U59MeRe1eprTDubIsw/9ONUE=;
 b=baqOuhvRPP4/0t6ISzNzaDcycTD55LEA4lb6pRRMeBpBoIt7oP1FgIIYzB80+MmmVT
 AZhQtyhFLbdW59kU5+ULlmkhOgdEBpa8LIqxsRqV+OeMvZJe5aRo23IIBqzhXA2K1VyI
 YZ7AHl6OnWsoI5zwM6pDUUAA6QytyksyEOkuvaOBGi0zBAMB6Rv+scLoN3rm1nHLdynS
 EQa5GACnE1uY0dq1nVdOIp4h7/Nbyt3r/HbnYEZtQYbCUfJ5U3l4YFUaDt2bAWI0/tAv
 062JvbUye5Y1TNWuegqnNaeVE8/fzNczFJdYpDDKCZ9qD7InWQe77VAFtvytvRhFF4Wz
 pJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724051752; x=1724656552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h+HBo0Lo8GjeCjRvqc2U59MeRe1eprTDubIsw/9ONUE=;
 b=FHtkPmeWCGGIW+eGFdoa0GnFkOQwErydaRh8lD/pKKehyd9DLHsRFbyeYsb+3a/tn/
 ZswN3twHFJP1WUZ9fQTI96HgySeHicVU+ouUl7XD7patR2xQJx4nL2zgU5zXc7LUYUyk
 y6j+YF9cBOtsaKyIrMGAOBYphIDy/xjvaFJQxLZUuKhH2yu5m8eYmFH6VQbvoTI0H3zS
 1Knv/dvlxNhrXtKDJeSN1Eenl5sJIqJhjMCKWy/bnsk1y85cPiYfx64g171GCPfhTBg9
 vDGXISWCnPMOOLg5SlvopNOLFZGPskbvB4z/JJeupJWJH4wdH2R+7SN8UTogDvaYnE0S
 /9Nw==
X-Gm-Message-State: AOJu0YyCyF0/RtxucibdXqy3T9v/AzQK6rmQ7XGk5lvsSkkql2wXYFHJ
 hDBspK3yvM30JkgkkVN7cC+Nuv21aGJnHJaD0FJukh+7mmyY9V2vM083pwexOg1if2+xVbYOjMG
 kr88b3p/TmJkijupLxHepvBjGbGLZeWdl
X-Google-Smtp-Source: AGHT+IEPIVdanIigWfygTi+s8hO9ouI/NVwvrJyd1BN1GVR1hYcug0Roy7REhEboaPXU7+mTO/LGLNVeUmzT2oXa4H4=
X-Received: by 2002:a05:6e02:152b:b0:396:c825:4db6 with SMTP id
 e9e14a558f8ab-39d26d64999mr131705755ab.26.1724051752522; Mon, 19 Aug 2024
 00:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=OP5Kb_YMmcn6Zjj3feSPX506zXt7dSb8w_vUaMsSsxWYgzw@mail.gmail.com>
 <CAFLszTjHCbekGwJBvfw70iejhM6XeQ9kYc8+sHsdAfTyCq7DXw@mail.gmail.com>
In-Reply-To: <CAFLszTjHCbekGwJBvfw70iejhM6XeQ9kYc8+sHsdAfTyCq7DXw@mail.gmail.com>
From: Romain Crausaz <crausaz.romain@gmail.com>
Date: Mon, 19 Aug 2024 09:15:41 +0200
Message-ID: <CAB=OP5KesR5creSZ4C20v0dn3kmH_ZRRtj=L8uiK7K0dzV6hbw@mail.gmail.com>
Subject: Re: RPI CM4 - I2C BUS and Device Tree
To: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 19 Aug 2024 15:54:55 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon, Hi Peter,

First of all, thanks a lot for your answers.

1. When I enable the i2c bus in the config.txt (which is parsed by the rpi
first stage bootloader), the overlay put this as compatible:"brcm,bcm2835".
I checked in the source of U-Boot and the driver is not available.
2. One solution could be to use the i2c-gpio driver instead of the default
i2c controller. U-Boot has this driver.
3. Since the device tree passed by the rpi bootloader is stored in the
variable fw_dtb_pointer (see the lowlevel_init.S) would I be able to do the
following:
    3.1 remove the automatic selection for the device tree passed by the
rpi bootload
    3.2 system starts and use the default device tree where the i2c bus is
defined with i2c-gpio, access the device I need and store the information
needed
    3.3 get the device tree address from fw_dtb_pointer, set fdt address
fdt addr with the new device tree and then start the kernel

I have another question, what triggers the DM to check for the device (with
dm tree command there is a X under the column probed). Because here we
could have a really simple device tree with the minimum configuration for
just the i2c and load it from U-Boot, perform the action needed and then
boot the kernel by passing the device tree provided by the first stage
bootloder.

Regards
Romain



Le sam. 17 ao=C3=BBt 2024 =C3=A0 17:57, Simon Glass <sjg@chromium.org> a =
=C3=A9crit :

> +Peter Robinson
> +Matthias Brugger
>
> Hi Romain,
>
> On Sat, 17 Aug 2024 at 07:01, Romain Crausaz <crausaz.romain@gmail.com>
> wrote:
> >
> > Hi all,
> >
> >
> >
> > I am currently facing an issue with U-Boot and a raspberry pi CM4. Here
> is
> > the setup:
> >
> >
> >
> > 1. Yocto Scarthgap
> >
> > 2. U-Boot 2024.01
> >
> > 3. rpi_arm64_defconfig
> >
> >
> >
> > I am trying to access the i2c bus from U-Boot. I have been trying to
> modify
> > the device tree which is referenced as
> > =E2=80=9CCONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b=E2=80=9D=E2=80=
=9D in the defconfig without
> > success. I can remove everything, set all nodes to disabled and I see n=
o
> > change in U-Boot (I am using dm commands to check the status of the
> > peripherals).
> >
> >
> >
> > It seems that with the rpi, U-Boot will only configure itself against t=
he
> > device tree passed by the bootloader of RPI. Could someone confirm this=
 ?
>
> Yes. It isn't quite obvious, but this is a clue:
>
> Core:  211 devices, 16 uclasses, devicetree: board
>
> 'board' means that the board can do whatever it wants.
>
> >
> >
> >
> > Is there a way to configure / modify U-Boot to use its own devicetree a=
nd
> > simply pass the device tree generated by the rpi bootloader to the
> kernel ?
> >
> >
> >
> > Because the second issue is that the i2c driver defined in the device
> tree
> > passed to u-boot is not available in u-boot.
> >
> >
> >
> > Thanks for your help
>
> Since OF_HAS_PRIOR_STAGE is a hidden option, you cannot disable it in
> the defconfig. The only way I know of is to comment out the 'imply
> OF_HAS_PRIOR_STAGE' in ARCH_BCM283X in arch/arm/Kconfig
>
> For me, that stops the rpi_4 booting, so perhaps the devicetree is
> out-of-date or ft_board_setup() is doing something strange, or
> something else. The in-tree devicetree may have got out-of-date, so
> perhaps use the Linux one.
>
> Regards,
> Simon
>
