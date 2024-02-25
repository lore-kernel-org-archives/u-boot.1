Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED365C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 05:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BF987D98;
	Sun, 25 Feb 2024 06:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+nVLZ2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FE787D8C; Sun, 25 Feb 2024 06:50:13 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8D687D8C
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 06:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e48153c13aso968197a34.3
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 21:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708840209; x=1709445009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOLQCu2UQWDqJDGARFYqJ3+MVB6xSIgL48cF3w1PycM=;
 b=j+nVLZ2RQWPLd3vkjFYTjKcHVt597zKFb52uG4Lo/DrlRIcqfKiLTFniorB1bPmWzn
 LSA80dVstZN5rteZo98MM+W7C/ZTzdjQ/ryupKVdOPLE5IiqJx2CAql8IApuKju/t1ws
 P3yKjc646y5T1i3kYbQZCXew+0CQ7U+RQwOtqy7H08jSk7FYjQkvqHj+wukQghMF0ZSF
 36+BRWDCFuiA+qav7ZmSCKtFBEPsndo5zsu+wk5kKGmExWZKgdMVFq/jwMO18VkTtqs8
 uva0j38OAhdEvyukrmlxU2KeIzVxEmfFehxPia/SUdUzbjhInvgLnFWJt6/0Elpd6lb4
 kJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708840209; x=1709445009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOLQCu2UQWDqJDGARFYqJ3+MVB6xSIgL48cF3w1PycM=;
 b=u2M2twO9kEt+dZYmfjomI6dT+oIrTMbjmCMBw8isu8OyIx+cmdvcufVSRxp5BqEai/
 Dzyd8ZX4P/dH5taoFHS8v2zpCOi1tH0zzZKSafrcI3of6/MRrbYFI7kklt+fYc97zOzr
 n7qCwtEGcggtZR5LF9yDCSwdGURTltBwdCSPJaceb6zYUxGDqkhv8AgBKbcD/k2L8/v2
 H631B6ICD1keLEOWEzEfuzp2zuCklROmffzr1JweQthjZppbpkLFlAwyZgNCvGPpWWLw
 ak7eQSN27xHpl7wTZa8GOe1fEGQwHN2fKbjvi2NJEnN1XZ8XUtT2AklO7IrMfOIu5rrt
 6gdA==
X-Gm-Message-State: AOJu0YygJ2nfPXpOpBACBkRgnWRZh0BZjGyipSozLDyp/+FvWDt3V8Jr
 r5r+eouS31yibqyvtV0svdDmKBHCbB6TK92Sgm9zyl50Rb2haiTtUoPxS1Uu9IVf850BZxT4NBj
 rDNr3MfMNvN5ByDffcsIJQhaEe1I=
X-Google-Smtp-Source: AGHT+IEdQ1VLQPZIgv9lJsxJY9SQODXP798oG31iigA/OzhalnkRl/YD7/Duk1i3aRXXmWM8LguStffqpTO7i5hnktI=
X-Received: by 2002:a05:6830:1393:b0:6e2:e627:333c with SMTP id
 d19-20020a056830139300b006e2e627333cmr4766701otq.23.1708840209333; Sat, 24
 Feb 2024 21:50:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
In-Reply-To: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 25 Feb 2024 11:19:53 +0530
Message-ID: <CANAwSgR-Bd0ck-LkYb9QcNigP3Ht61RxYds5=YFyX58pdeusCw@mail.gmail.com>
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

On Sat, 24 Feb 2024 at 01:56, Sourabh Hegde Ramu
<hrsourabh1107@gmail.com> wrote:
>
> Hello,
>
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
>
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
>
> However on Raspberry Pi 3B, I don't see this error and "current eth" is set
> to "smsc95xx_eth" and "ethaddr" is also available.
>
> Can anyone please let me know the issue with Raspberry Pi 3b plus?
>
> Thanks in advance.

Can you set the MAC address in boot environment?

# setenv ethaddr 00:14:05:42:03:BB
# saveenv

It should update the mac address for LAN75xx
printenv should display the mac address

Thanks
-Anand
