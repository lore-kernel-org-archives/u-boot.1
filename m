Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7BCC3ABCB
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 17:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0862D8295C;
	Fri,  9 May 2025 19:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z7QnccXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C12E82991; Fri,  9 May 2025 19:45:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E08B8283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 19:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so297569466b.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746812749; x=1747417549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4NBSCSTW6meVKl4Fzv1V6winQvwSQBMwpZ3Zvm4h6c8=;
 b=Z7QnccXb7FkLQkNY6xdAfKINCAWNOo134by9dOghb8P22EimVc7ZoHxWI9P0uTCEiy
 nsDxxqrFjmdzyAn4SDlhe3moWZ25AU1bQd8X5C6ib8l+8V9vlNsUJFbIzGwmWGG6er8S
 3UenIFdEjlnSwrJImjtQOAQD1PsqJw+iSV+O/12VMzHU9H+8F3KxbROiBoJKN0tgekCo
 AFZaecrlT1udRjg94LWFMUJCUjWNxT0OOuZh5FiZstj90xiiOVLk2Hr+m1IygkIRvgCk
 xqJPYBodCk98XJhcFu6UklUJ8FUManlsdnpKvRu8W7CXF4OgRdydBZAgdJC0ZJT4QrEq
 wA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746812749; x=1747417549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NBSCSTW6meVKl4Fzv1V6winQvwSQBMwpZ3Zvm4h6c8=;
 b=j3E9KpDRp6GWzGVNAyqMs14qhjFASm6iIfe1o1naVLB0DGDDfXgHWcAIgGvH5XUfxo
 yTyQFKDEuxri8Wh8UujABa1scOfGt9qr7PaKG5vfnGi4x/7vGUqIDLQIS5rfOpimtnCQ
 R8NVRteeyKCNKfyu17h3C0z2e9FOtT8LmBmb4x4U0+FIv75AiIccZNjM8Rlm+r3CiOuN
 2FkAEdc2F+IVar6F2I6dO0WZg1h5PSMabOZMejNmHR/lg0cyhsLLuJTsYshj7xzIOGuv
 YNCij1wkU7Y1JXOcJT8BgZ6rf/x09meI3RE9u+vPD+sFWmbS+FrcRnPJfabxVWduRVSJ
 2jSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH+/PBNm+DacpaObq+FAd1eqe4EwYAH8rWRrOk9glPeHz4/8dbrZF0WqETuYdsua93VTrOcLE=@lists.denx.de
X-Gm-Message-State: AOJu0YyfKeUvBMdUG4COJeH6YwBHTzR5GL9zcLKbApIL1XFBVFS18dK0
 C67PQWWjIKRTuqYTo1Bb/Xm1adkIdmlv3EdS7yN8+XHQDzTUJfeycp+QAc2dkJZBAEU3MVrzlY5
 bQjKLyAbHoFX0JvB82UbXP2aKARM=
X-Gm-Gg: ASbGncv6gftbOJ5MnIPRrsmvGtllB15Ywk3oRgz2jh/MSqL0reVpZZmJUg7iMQBBvqb
 RVHxcKCwQLnUHnPZdnKGcHLO638qp002ESpvl+hW3DRZVhN4TRUU+BG6HBXyOTYcH69jrXWvHA+
 5oCzaGdKeorNH/15EQbcY=
X-Google-Smtp-Source: AGHT+IFGwwTEiKPaNVX+Np1FMkX8vPYW7aoCUvKtpsrPNPfpLVFLsqXlJ4BmPRgjtJda44UcbSoef14Yaz1NbadyBrU=
X-Received: by 2002:a17:907:9801:b0:ace:dd27:7c68 with SMTP id
 a640c23a62f3a-ad2191697dcmr450227866b.46.1746812749346; Fri, 09 May 2025
 10:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
In-Reply-To: <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 23:15:30 +0530
X-Gm-Features: ATxdqUE9EOhFZAxlgmN7b1xq7kE6wu2BT2Dpcv2WjRIyONtSeVH1IBte9NdKUCQ
Message-ID: <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>, 
 "open list:P200" <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Neil, Anand,
>
> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> > On 09/05/2025 09:02, Anand Moon wrote:
> >> Add conditional compilation for the usb5744_i2c_init() function based
> >> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >>
> >>    CC      net/net-common.o
> >>    AR      net/built-in.o
> >>    LDS     u-boot.lds
> >>    LD      u-boot
> >> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> >> `usb5744_i2c_init':
> >> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> >> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> >> reference to `i2c_get_chip'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> >> undefined reference to `dm_i2c_write'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> >> undefined reference to `dm_i2c_write'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> >> undefined reference to `dm_i2c_write'
> >> Segmentation fault (core dumped)
> >> make: *** [Makefile:1824: u-boot] Error 139
> >> make: *** Deleting file 'u-boot'
> >>
> >> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> ---
> >>   common/usb_onboard_hub.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >> index 1242513c631..92e3f3a92c9 100644
> >> --- a/common/usb_onboard_hub.c
> >> +++ b/common/usb_onboard_hub.c
> >> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >>       int (*init)(struct udevice *dev);
> >>   };
> >> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>   static int usb5744_i2c_init(struct udevice *dev)
> >>   {
> >>       /*
> >> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >>       return 0;
> >>   }
> >> +#endif
> >>   int usb_onboard_hub_reset(struct udevice *dev)
> >>   {
> >> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >>   };
> >>   static const struct onboard_hub_data usb5744_data = {
> >> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>       .init = usb5744_i2c_init,
> >> +#endif
> >>       .power_on_delay_us = 1000,
> >>       .reset_us = 5,
> >>   };
> >
> > I think you should completely disable usb5744_data in this case
> >
>
> I would recommend to go the same route as the Linux kernel which has a
> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> the necessary dependencies.
>
On Linux kernel, it needs to parse the device node with i2c-bus.

> We probably should be careful and figure out which boards are actually
> using the usb5744 and add this symbol to their defconfig so they don't
> regress.
>
From my initial analysis configs/xilinx_zynqmp_kria_defconfig
which use CONFIG_USB_ONBOARD_HUB
I believe using DM_I2C to guard the code is the best approach.
it should be around .init() callback to guard this to work.

> Cheers,
> Quentin
Thanks
-Anand
