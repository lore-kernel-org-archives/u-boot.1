Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC2C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 22:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECEC8747E;
	Wed, 22 Nov 2023 23:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXo7faRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CBA87616; Wed, 22 Nov 2023 23:39:46 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D11870BC
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 23:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso393038a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700692783; x=1701297583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OmY0KXOJNlnOMQSUqnIEnrmUZ8cJ3MDK6KmIKyC05eo=;
 b=QXo7faRQvRjZrXauha9qRw7tNlwM2eZ6mf2lqdHd4W/GM5fzIdqoYH5L6hBs60JnWn
 wWQKFH4EjMa+CG+DvUjfCh969DVJXnXg7cgJiEY5qR+DMOQm9Erg93BmuXVyXd39Tn+W
 /d+5Kx4p95cT7wXYLJAiTbUABOd5kE39CnGE5l8QwATKmtI5SUI+YWHioxyqsnQOGIp0
 CdJP07aVGVUeyMNriZa+i5bpkumu+11eJ69izSJelj/WXEaOlzAUsxn+ourIV/KPorRi
 raDOuQrYybvW8eEFAKGLIQF0qpvgy45tTxcITOzhn88N8kZcd+xHoR8+INAWTcOWQX+M
 Jong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700692783; x=1701297583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OmY0KXOJNlnOMQSUqnIEnrmUZ8cJ3MDK6KmIKyC05eo=;
 b=c2LcZUQDoUoIas8wXNs423D5IFXrbr6OPcc5gCQF+2VAzQiVu4uKpLTYIwDfAWYr2X
 uxgc7XgaCgMhsCHcYdJZ3ywc/mzwVAcAO7sJWLB+9qQb48gt9JBSuwwPo0Ak0majphAc
 9qTB7gORa25c5HDPAluZUQ+GMDUJeyiD87bQ67u5ppDNs83kQNVO2KCjntgZ5QoIfw1Z
 6AcnhutG8RJW8H/8at9o2dM2H8Iq5CJr49w12QhG4Xoe8xYr+hsOlhoJmlU9TVlGyZ/Y
 wF98cTMIvPoriOgVLcVBbTnZLhCTk0uuWlXErDU4ztVDInAHmZNM9L3A83E9zGZl1u+u
 m1mg==
X-Gm-Message-State: AOJu0Yz7mWdH5qe4JTq4/Xxa2xWkzVwJh7skMZfNoPdRlSe3OEq4Q1ml
 Jw+8Bto8JHYd13zn5xi85YPAEojG2l++O6cGY7Pfp/p1UNQ=
X-Google-Smtp-Source: AGHT+IFHbJkbEfSQaVxHAFS4dJs6ajap6L/daU6oSkucc3+8YaoOi8V+XAMH7QBZsjLKFp7TKvey5gOTtmarJl7QhDY=
X-Received: by 2002:a50:ee08:0:b0:53e:3b8f:8ce1 with SMTP id
 g8-20020a50ee08000000b0053e3b8f8ce1mr2844988eds.23.1700692783230; Wed, 22 Nov
 2023 14:39:43 -0800 (PST)
MIME-Version: 1.0
References: <535b9d87-242f-402f-9d8e-febdf1fc0709@gmail.com>
In-Reply-To: <535b9d87-242f-402f-9d8e-febdf1fc0709@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Nov 2023 22:39:32 +0000
Message-ID: <CALeDE9N2s+WttAQr1Dk4up3Gg32KpGd=6Q6eST0Am_7i3-2FUg@mail.gmail.com>
Subject: Re: add orangepi zero3 to u-boot
To: Stephen Graf <stephen.graf@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Stephen,

> I have been able to build a working (tested on my orangepi zero3 1G)
> u-boot for the orangepi zero3 with the following defconfig. Would it be
> possible to add this config to the working boards.  I would test it
> again with an official build. The dtb/dts is in linux 6.6 and in u-boot.
>
> The H618 processor is software compatible with the H616 and the zero3
> board is very similar to the zero2 with the exception of DDR3 replaced
> with LPDDR4 and the Realtek phy with Motorcomm.

You've sent a variantion on this email twice today. The usual process
for sending support upstream is via a git commit with appropriate
pieces. I suggest having a look at the means of git
commit/format-patch/send-email.

Other than just a config file, you'll also need to add the upstream
(from Linux) dts file. The OrangePi Zero2 commit [1] would be a good
example to base you patch on.

Peter

[1] https://source.denx.de/u-boot/u-boot/-/commit/38be6b838780e8ad0ee80e716752c8843cd87e05

> CONFIG_ARM=y
> CONFIG_ARCH_SUNXI=y
> CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
> CONFIG_SPL=y
> CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
> CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
> CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
> CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
> CONFIG_DRAM_SUN50I_H616_TPR0=0x0
> CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
> CONFIG_DRAM_SUN50I_H616_TPR10=0x402f0663
> CONFIG_DRAM_SUN50I_H616_TPR11=0x24242323
> CONFIG_DRAM_SUN50I_H616_TPR12=0x0e0e0e0e
> CONFIG_MACH_SUN50I_H616=y
> CONFIG_SUNXI_DRAM_H616_LPDDR4=y
> CONFIG_DRAM_CLK=792
> CONFIG_R_I2C_ENABLE=y
> CONFIG_SPL_SPI_SUNXI=y
> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> CONFIG_SPL_I2C=y
> CONFIG_SPL_SYS_I2C_LEGACY=y
> CONFIG_SYS_I2C_MVTWSI=y
> CONFIG_SYS_I2C_SLAVE=0x7f
> CONFIG_SYS_I2C_SPEED=400000
> CONFIG_SPI_FLASH_MACRONIX=y
> CONFIG_PHY_MOTORCOMM=y
> CONFIG_SUN8I_EMAC=y
> CONFIG_SPI=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_MUSB_GADGET=y
> CONFIG_AXP313_POWER=y
> CONFIG_AXP_DCDC3_VOLT=1100
> CONFIG_CMD_BOOTZ=y
>
