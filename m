Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA238C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 22:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10CED87C4D;
	Sun, 11 Feb 2024 23:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdN+rv3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5542D87C75; Sun, 11 Feb 2024 23:38:40 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4AB8785A
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 23:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d0cdbd67f0so37563041fa.3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707691117; x=1708295917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhulVvQUXZAZLR3OY4U+tSyuTI/HwpMRlUIHsTb6EKI=;
 b=UdN+rv3Z1gmON9iF3Kl7z29vMfCl0kQBR+k31Vl8KAVzNou4/3pTll3VuHNS40uybP
 ffwV4VfSX9Ke90LZ7cABaHYX5+0tO8kmobpi0JShKyuJZI3h8cmBu2UEe31xVmKDZ82K
 a52CvfripvycWz09zYP6XyuqT0vtZGWCCmuoymHA40fHGZ7yrnVzEGeMS3Yx2zq7FTTH
 6PB3L0oniVwRe5+pgUjhc07Kkf5FeStTfmqJ927qtU+aAx5viM6xNw83Tva+KG0q477L
 x4RTOCpQJZURBY55rRBE12tN/7Jf9Im5TYn4jWYtL08t24SVYtAldZQj3G/4gK17gw1w
 pdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707691117; x=1708295917;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhulVvQUXZAZLR3OY4U+tSyuTI/HwpMRlUIHsTb6EKI=;
 b=ael6deGowQNySGGeKeCAMu716PdPSa6qpkcKvWXu/gWTb+FFPRukW/EFm32N3yufZk
 Aw68yYLasl0fizxNxUr9sIwpPliv5VT8t7pvh/MSuUV75Uqc2KU7IvLg4Qjfhyxcci4w
 kYzv2TipNVVYQjsWnm8o3oSsXXCnFTmkno5c6G4HcwYD6lqfLRAk9wMeI41GD0pbhUGo
 3tccOQW1TnERZ+8N2jj5MLsgHoDbZTIWvrvjqEPsAK4DW8oNjlJ5p9wkfnkmsCYY1ruW
 2LR1La+BxY5GKXnWpi85DeIEIOT7le7kLgVbA04TQvtMa004eHmDwSakPTT/Djhzj3qm
 x4gw==
X-Gm-Message-State: AOJu0YzZguHUpl5WTxOXRWoOvuR+KzLnHiosyFlPCJN59CUiJ6pNm4n9
 ft7y1gXYwFUeQKTpzBz/MZcYlllJlWzdclh8w3KVIHLDS6/yAH9U
X-Google-Smtp-Source: AGHT+IGH1761AynMgT49Mhr7nWTfH68h7SFcf3vlgXUP0kGQYJyXSLT5rigk3KOd/IYA2Tkl1oJP6A==
X-Received: by 2002:a05:651c:19a1:b0:2d0:a3b3:e39e with SMTP id
 bx33-20020a05651c19a100b002d0a3b3e39emr4511346ljb.28.1707691116759; 
 Sun, 11 Feb 2024 14:38:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ1KuOxQrOTXya+70SEoIrmuMufvpWozxq4WQx1Ivdybnwe4ax/IXH3eN9m9UXqGSDA5fHzEZJz11q5c3LYo1Jc+dxGvdv0kzRf7CjX7Gv17VRCfjXIlFO/T/1e5SXO9Gg55Bzds4O1ysY0Ajhau1kg3sywQHQuZPLoq+mXRKRdjbOrPcuSTPq5cn0cGIqBi2ID7qc6+oXxoZIMwFq/Epz7hRe+BRtsp75lhrvpsJjCvzS+cdmJREgIqJkgTX72w4gH1856jdZenoW
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a2e90d1000000b002d0a8143f31sm1125050ljg.50.2024.02.11.14.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 14:38:36 -0800 (PST)
Date: Mon, 12 Feb 2024 01:38:36 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Arnav Singh <me@arnavion.dev>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH RFC] sunxi: pinephone: detect existed magnetometer and
 fixup dtb
Message-ID: <ZclMbBOOxav9yC-X@skv.local>
Mail-Followup-To: Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Arnav Singh <me@arnavion.dev>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>
References: <20240211092824.395155-1-andrej.skvortzov@gmail.com>
 <20240211131251.797abb61@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240211131251.797abb61@minigeek.lan>
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

Hi Andre,

thank you for the valuable feedback!

On 24-02-11 13:13, Andre Przywara wrote:
> On Sun, 11 Feb 2024 12:28:24 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> Hi Andrey,
> 
> thanks for taking care of this upstream!
> 
> > In newer 1.2 PinePhone board revisions LIS3MDL magnetometer was replaced by
> > AF8133J. They use the same PB1 pin in different modes.

> > 
> > AF8133J's driver isn't upstreamed yet, but it will be soon. Therefore this
> > is RFC patch. I'd like to know whether selected approach will be accepted
> > in u-boot before submiting coresponding dts changes to the Linux kernel.
> > Any feedback on this change would be very welcome.
> 
> So I think this is the right approach: Since the SPL has no use of this
> device, and it's a rather small DT change, we definitely want to do this
> in U-Boot proper. And I believe that U-Boot (proper) is indeed the best
> place to do those adjustments, since it's built for one board anyway,
> so anything board specific belongs into there (and not into TF-A or the
> SPL, which are more tailored to one *SoC*). Also we are not so size
> sensitive in proper.
> And I also like the fact that it's protected by a board specific
> definition, and even better that it's an already existing one.
> 
> Oh, and I am not really convinced this is the right approach here, but
> maybe have a look at doc/usage/cmd/extension.rst, for another related
> mechanism.

Thanks for the tip. I've looked at it after your suggestion and tried
to implement the same logic using extension command. Here are my
thoughts about that:

1. integrated magnetometer is part of the device and making it
extension with separate dtbo sounds a bit strange.

2. if I'd create dtbo for new AF8133J magnetometer, then I'd call it
like other dts files for the device:
'sun50i-a64-pinephone-1.2-af8133j.dtbo. This is 38 characters and 
currently overlay name is limited to 32 bytes. What do you think about
increasing overlay name?

3. extensions are not supported for extlinux boot flow at all. This is Debian
case, that I'm working with. And this is a major problem for me.

4. I've looked how EFI boot flow is made and I see that extensions are
not applied to fdtcontroladdr, only to loaded fdt to
fdt_addr_r. Extlinux uses fdtcontroladdr always.

5. When distribution supplies fdt with extlinux, when supplied fdt is
used and no extensions are applied to it. This is my case as well.

6. I can't apply extensions to fdtcontroladdr. When I've tried to
apply working extension to fdtcontroladdr, then I get a crash.
I have to copy fdt from fdtcontroladdr to fdt_addr_r
and then apply extension to fdt_addr_r and when it works. Maybe this
is something sunxi-specific.

Overall extensions seems like a nice feature for capes, extension boards for
pogo pins and so on. But I'm not sure, that it's the right choice in
this case.

> Some smaller comments below ...
> 
> > 
> >  board/sunxi/board.c         | 26 ++++++++++++++++++++++++++
> >  configs/pinephone_defconfig |  1 +
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > index 1305302060..a4bfa24400 100644
> > --- a/board/sunxi/board.c
> > +++ b/board/sunxi/board.c
> > @@ -15,6 +15,7 @@
> >  #include <dm.h>
> >  #include <env.h>
> >  #include <hang.h>
> > +#include <i2c.h>
> >  #include <image.h>
> >  #include <init.h>
> >  #include <log.h>
> > @@ -920,6 +921,28 @@ static void bluetooth_dt_fixup(void *blob)
> >  			   "local-bd-address", bdaddr, ETH_ALEN, 1);
> >  }
> >  
> > +#ifdef CONFIG_PINEPHONE_DT_SELECTION
> 
> Can you move that line into the function? That would for one avoid the
> protection in the caller below, and secondly make it easier to add
> other boards, if a need arises for them. The two #defines don't hurt or
> change the code, so just keep them outside.

> > +
> > +#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
> > +#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
> > +
> > +static	void board_dt_fixup(void *blob)
> > +{
> > +	struct udevice *bus, *dev;
> > +
> 
> (have the #ifdef here)

Ok, then I mark local variables with __maybe_unused and remove #ifdef
at board_dt_fixup call.

> 
> > +	if (!fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2"))
> 
> Please have curly braces around that.

I'll fix that in v2. 

> So I'd say please send the (disabled) DT node addition patch to the
> kernel MLs, then send this patch to U-Boot.

Do you mean patch with disabled AF8133J DT node? Right?
If so, then it was the plan.

1. upstream AF8133J driver to the Linux kernel (on-going)
2. find acceptable solution for u-boot to handle different
   magnetometers (on-going in this thread) 
3. upstream necessary dts changes to the Linux kernel
4. upstream previously discussed changes to u-boot.


> 
> Cheers,
> Andre
> 
> > +		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
> > +			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
> > +			fdt_set_status_by_compatible(
> > +				blob, "st,lis3mdl-magn",
> > +				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
> > +			fdt_set_status_by_compatible(
> > +				blob, "voltafield,af8133j",
> > +				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
> > +		}
> > +}
> > +#endif
> > +
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> >  	int __maybe_unused r;
> > @@ -934,6 +957,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >  
> >  	bluetooth_dt_fixup(blob);
> >  
> > +#ifdef CONFIG_PINEPHONE_DT_SELECTION
> > +	board_dt_fixup(blob);
> > +#endif

I'll remove #ifdef here to make code a bit cleaner. I've applied all
your suggestions and make it available here [1].

> >  #ifdef CONFIG_VIDEO_DT_SIMPLEFB
> >  	r = sunxi_simplefb_setup(blob);
> >  	if (r)
> > diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> > index eebc676901..457e7ee1e7 100644
> > --- a/configs/pinephone_defconfig
> > +++ b/configs/pinephone_defconfig
> > @@ -12,6 +12,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> >  CONFIG_PINEPHONE_DT_SELECTION=y
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> > +CONFIG_SYS_I2C_MVTWSI=y
> >  CONFIG_LED_STATUS=y
> >  CONFIG_LED_STATUS_GPIO=y
> >  CONFIG_LED_STATUS0=y
> 

1. https://github.com/AndreySV/u-boot/commit/84a9f1c14d1850c5559c5d888c814eee8886b04f

-- 
Best regards,
Andrey Skvortsov
