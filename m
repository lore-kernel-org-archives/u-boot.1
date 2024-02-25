Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A17EC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 13:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF52887DCC;
	Sun, 25 Feb 2024 14:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ntq3fWDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C3B87DD8; Sun, 25 Feb 2024 14:49:02 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057CD87D8F
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 14:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso3525438a12.1
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708868940; x=1709473740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TIiFcHoCjtg6YsaClIFiTXOJRw8j8A2VWUOh9Cuwrec=;
 b=Ntq3fWDaCfRQgKqMV1F0Q7YRiP0pbApWBp6OftdcwP2OOVcg5uyZXZbKsKB2IObWxC
 W0Wo6O8jDIyYGaMIly3nsst3/G3rPiDrCVEkamj6B/N9ZdnBg8WaD7/yyAE6UST3ytyy
 E7OGq9/2mKAU+3VPSt1p8n82XpovF4K6aF6dwiIoTHAiQJrNB6PP4LMrCuF8LG1d9hnj
 4k2X42E9fVy3giyyvu/gDaGRF8FS+ZAInOpZS2dOZqbC0aIBuJJWrLV+/d0srwxdnYJu
 yyeR7XDf8GY0SsH6349WUA4clpTEGq2/1MeWpdt39kpuneIx8sJhLNAF7lbvQKrZS4uM
 M4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708868940; x=1709473740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIiFcHoCjtg6YsaClIFiTXOJRw8j8A2VWUOh9Cuwrec=;
 b=Z4rQgIXrAYHo4p4Ltrmk3J3UsuInGpMMl5dFD0XbV8QTtPpq+KTwgPdgbNDC+8WHvq
 zJ8H+GyuyxUGNT8RplYmHwk11rIvZKH9ASi2nv9Cs/QS5EXGhVjA0Pu40Tihg0IlXbHv
 EXbLOCmNyhK/Gjv2H81YtHlAzJMxwjAIj+TVUoFAT2u2zOGockYQiWQhbRaTef0TKaEu
 1R1HWjHeRDbY26eWCQ9khBDlKxpXWN3wjVAg5tLFdKNbUZyqCRE+T97JRsDKm1WKI61k
 WpqjhoICnWkrE/GIdiK3LebVYGoc/Nyxwex/wL/sUNyjCxfS5rT3utQEyKNu2I5XjEWm
 XM0g==
X-Gm-Message-State: AOJu0YxtKOl7KsKU8JE8ZKvIwv1Efb5bSu1aHdZ/jbCZIsmvP5BbpSPC
 UahRRdluH93TCzMVp3G08h4uAJr/3YeNlWwBn/bR8Qnf93jaxeJiCad0itO3MkAZB28bwyrJwi8
 61ohYrEaDx86t+9EQ2v18pfuJeqA=
X-Google-Smtp-Source: AGHT+IGv2gV06R5zNyrBGdqnPCDtJ17HWl4sIzugaywCPSdbKPjs7b40MJhclY+cdHPwEd5D2e42yn7AICMQCfXaIkc=
X-Received: by 2002:aa7:c3d7:0:b0:565:7ede:c5c4 with SMTP id
 l23-20020aa7c3d7000000b005657edec5c4mr3249804edr.16.1708868940191; Sun, 25
 Feb 2024 05:49:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
In-Reply-To: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 25 Feb 2024 13:48:49 +0000
Message-ID: <CALeDE9Pfd0XC3m-LLscgjPqh2bmQh_bUydb02jHw9prvoLQpKg@mail.gmail.com>
Subject: Re: Raspberry Pi 3b Plus USB-Ethernet lan78xx_eth address not set
To: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
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

Hi,

> I have a Raspberry Pi 3B Plus which I want to integrate with U-boot
> (v2023.10) .
>
> I am using rpi_3_32b_defconfig to generate u-boot.bin. But while booting I
> am getting below error
>
> Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Net:   No ethernet found.
> starting USB...
> Bus usb@7e980000: USB DWC2
> scanning bus usb@7e980000 for devices...
> Error: lan78xx_eth address not set.
> 3 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Hit any key to stop autoboot:  0
>
> In the "bdinfo", "current eth" is not set

The ethernet address is set by the ethaddr variable, it can be viewed
by running printenv. That is then set to the ethernet0 alias in the
device tree.

> U-Boot> bdinfo
> boot_params = 0x00000100
> DRAM bank   = 0x00000000
> -> start    = 0x00000000
> -> size     = 0x3b400000
> flashstart  = 0x00000000
> flashsize   = 0x00000000
> flashoffset = 0x00000000
> baudrate    = 115200 bps
> relocaddr   = 0x3b360000
> reloc off   = 0x3b358000
> Build       = 32-bit
> current eth = unknown
> eth-1addr   = (not set)
> IP addr     = <NULL>
>
> I also enabled LAN75xx in menuconfig and re-compiled u-boot. But still the
> same error.

I believe the driver for the USB network interface on the 3B+ is the
USB_ETHER_LAN78XX driver,

> However on Raspberry Pi 3B, I don't see this error and "current eth" is set
> to "smsc95xx_eth" and "ethaddr" is also available.

Do you mean it's set at U-Boot stage or when you boot into Linux?

Peter
