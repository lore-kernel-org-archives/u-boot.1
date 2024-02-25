Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86278C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 14:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA46587DDE;
	Sun, 25 Feb 2024 15:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VuKeHH40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA5887DE1; Sun, 25 Feb 2024 15:02:32 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A412087DD8
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 15:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so1270515ad.1
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708869748; x=1709474548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pbfQE7JXh2SD/Ly/PT+mcEWmz6l6wssQPuwkzbSOR94=;
 b=VuKeHH40B1PQpB8IK4A3Ruf/eWrnAW5lCUFBEDFPTfdob++z16zz6UR9CXEBfEUx0U
 41PjiFNaqeAGT+uLOxqcPT62XC6fy2np04NLbcYma3Z6BCE3XzQG0jH/nv1eQUAMa030
 4jCJTxZ+AQt9PJKKJJgZUlVz4CE6OJ+B4tkCASd9CyxVRcgrfJp8thaLbuvKs0jrQFa2
 SCSm8u5nVGqzqz8H6FoJiOlm5NMnNMePFaUKwGH5FB4En1blmKEPnSYpZjM8Z+QsoKpY
 5JkEaICXwM/74cqPhzDZRe+3hZgJXP4PplFw+Zgy+e+qYiTp7NZZnSh7FGR9pT/nGSwY
 hG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708869748; x=1709474548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbfQE7JXh2SD/Ly/PT+mcEWmz6l6wssQPuwkzbSOR94=;
 b=jqIL4nmPqjAhA26M1vV1M6L5DdgrFKxyV9NcpHQBAhf1G4mIaP61XCWmKzlB8wqIFQ
 H9VvAEnoD+5QZdDjDnjCVb99Tp1sHfqgSvE37pHfqPgqQqBRh+ljjEGs1t47VmX+O6Wg
 1xlkOg3P4sjD7Gq+umoizquEx8BW7GQJETOTysT1kWkDl9+gQJLz2XUrk7hWBHMigPIv
 OHU40JTLdIp3cwQnfzTZZhqHtGOJLqrrIlsA6ZusN3NL2nQs4VT9411cIGxgaIrQPlm/
 Evrh9wlGrE7FpQxqsOwer0zsoS6stdbP9J48nyOVjVPpcOyav/mwuygLHCXaRj5R3l8t
 aqoA==
X-Gm-Message-State: AOJu0Yx7jX7BM/uXk9fuWod+2ynWDAq8uGSNLbIQZ9dTdpEmT3/wpD+p
 q+8LfhYZkMeYar81ceRMaiJIlfAseYX2/AHNmeuuAjGXaKRQ7Y35g94WDfVPCJvKK3z3oUW0Ckd
 3xfOk8UoLpin9B/zGqSXSEFfydC4=
X-Google-Smtp-Source: AGHT+IEUA6rkX/R6lBx1S/IFw0+/H2hbe3CWCJ7T0haMQwFxE9RN2ND0QeI/XC/rZ5e8vTsLoUOOQghnSFfpdh7wHTE=
X-Received: by 2002:a17:903:41d1:b0:1dc:90b3:eee with SMTP id
 u17-20020a17090341d100b001dc90b30eeemr2095638ple.22.1708869747807; Sun, 25
 Feb 2024 06:02:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
 <CALeDE9Pfd0XC3m-LLscgjPqh2bmQh_bUydb02jHw9prvoLQpKg@mail.gmail.com>
In-Reply-To: <CALeDE9Pfd0XC3m-LLscgjPqh2bmQh_bUydb02jHw9prvoLQpKg@mail.gmail.com>
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Sun, 25 Feb 2024 15:02:17 +0100
Message-ID: <CAHseuWDiW5E_Sq9kGjRf4e+tMkS9Ui65Hu842Rzg+2aAP9=9kA@mail.gmail.com>
Subject: Re: Raspberry Pi 3b Plus USB-Ethernet lan78xx_eth address not set
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Peter,

USB_ETHER_LAN78XX is already enabled in the defconfig for Pi 3b plus. But
the eth_get_ethaddr is returning null
https://github.com/u-boot/u-boot/blob/1a66a7768af7e8106c2cd93a19f4013877fb85ae/include/net.h#L199

Do you know why this is not handled?


On Sun, Feb 25, 2024, 14:49 Peter Robinson <pbrobinson@gmail.com> wrote:

> Hi,
>
> > I have a Raspberry Pi 3B Plus which I want to integrate with U-boot
> > (v2023.10) .
> >
> > I am using rpi_3_32b_defconfig to generate u-boot.bin. But while booting
> I
> > am getting below error
> >
> > Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Net:   No ethernet found.
> > starting USB...
> > Bus usb@7e980000: USB DWC2
> > scanning bus usb@7e980000 for devices...
> > Error: lan78xx_eth address not set.
> > 3 USB Device(s) found
> >        scanning usb for storage devices... 0 Storage Device(s) found
> > Hit any key to stop autoboot:  0
> >
> > In the "bdinfo", "current eth" is not set
>
> The ethernet address is set by the ethaddr variable, it can be viewed
> by running printenv. That is then set to the ethernet0 alias in the
> device tree.
>
> > U-Boot> bdinfo
> > boot_params = 0x00000100
> > DRAM bank   = 0x00000000
> > -> start    = 0x00000000
> > -> size     = 0x3b400000
> > flashstart  = 0x00000000
> > flashsize   = 0x00000000
> > flashoffset = 0x00000000
> > baudrate    = 115200 bps
> > relocaddr   = 0x3b360000
> > reloc off   = 0x3b358000
> > Build       = 32-bit
> > current eth = unknown
> > eth-1addr   = (not set)
> > IP addr     = <NULL>
> >
> > I also enabled LAN75xx in menuconfig and re-compiled u-boot. But still
> the
> > same error.
>
> I believe the driver for the USB network interface on the 3B+ is the
> USB_ETHER_LAN78XX driver,
>
> > However on Raspberry Pi 3B, I don't see this error and "current eth" is
> set
> > to "smsc95xx_eth" and "ethaddr" is also available.
>
> Do you mean it's set at U-Boot stage or when you boot into Linux?
>
> Peter
>
>
