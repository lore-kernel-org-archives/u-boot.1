Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F508C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8DF87448;
	Tue, 21 Nov 2023 23:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="BJ3DALh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FED86FB5; Tue, 21 Nov 2023 23:54:22 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4E786784
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bdfbd69bd5so200869a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700607258; x=1701212058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G+je84Uaiwvhb31hJZeJRZkrGXeGYUmRw0tLpAS7Qp0=;
 b=BJ3DALh3rtubaT5xRYIvFDT3OB5Nvtooh4hPTr23xhufy0CTwHaSMKthcSdku9TR/P
 1pxX4wbnWDmeFEVILT37uxoJYfIUNRvuE3szqVGvsaRdvhpQQERuhXNr1oMV10qXguqh
 oocBrVF3AxLflGKzo1rG7RwTrPeOHhD/ytQ+OQZ6jS7KJB/lAa1GJO7bd0t06DOjFaBY
 zBK+c8CFCxhC8OXpMRNg7VmjdsGB+PqL1KKKyCYcoxBi8LZ2GN6mzW3SP13+grcP1Y61
 Mk9CmaJhbRGqXLXxYYW4+pO28+o1vc9k0sGbGyqV7BhbrRl4maLhokwpz5oU4YqrXQn5
 FIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700607258; x=1701212058;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+je84Uaiwvhb31hJZeJRZkrGXeGYUmRw0tLpAS7Qp0=;
 b=c+wwMpCxpm5wpwQLvl755F7dpwsHSYmwPqt6SJJUW0ipT2+DwNQYx64BqyxwYT2UUU
 5N9BPpJgOd0VvnHkfJ7e+iVAgmvWOWiuWIeNL63C0bLodbMoK8UNlqpbFIzdQGVmKHbS
 FU3sW7u63fQh6unJE65Wqw7I0l/OmQVIOjVhqtYU86RVQe6GkAplbf6ETcfX0vyK+bhA
 06Nf92ur4wz5rM8p4sls19kJjgxicwfHl9PPGHCI1CRmqEEtT6fRY0L6e9v6LgPY1YTL
 m6FegyvXplcbtNNtiUwRZwJlqTfztGRHhKIU41WRnFhJVoHdbzwJlowhqZgrxH7v0P5w
 DiSQ==
X-Gm-Message-State: AOJu0Yymo29d46yDrMgP7tLvvgAZDuuig5PVutfCU7sab+LnPgP+pLDt
 xv/0qen3uBGOuLczf/mpn4LUpK3NTpeEPUBVQRqFtGtknHaMEX4SN3ilvg==
X-Google-Smtp-Source: AGHT+IGENAdOecjamChEtuiKjlTTa3HTSVoAh//2+fxgh9Bfa7Xd2rB46tG4zUl0S1MVvC3yrhnHHmwL6IRS0wGPdig=
X-Received: by 2002:a17:90b:1646:b0:268:808:8e82 with SMTP id
 il6-20020a17090b164600b0026808088e82mr1041521pjb.1.1700607258279; Tue, 21 Nov
 2023 14:54:18 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Tue, 21 Nov 2023 23:54:07 +0100
Message-ID: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
Subject: [PATCH v2 0/3] rpi5: initial support
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, mbrugger@suse.com, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Nov 2023 23:57:42 +0100
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

These patches bring initial boot support for RPI5. Without it the
latest master fails with the message:
> DRAM:  mbox: Timeout waiting for response
> bcm2835: Could not query ARM memory size

With those patches and rpi_arm64_defconfig (with disabled
CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
serial). FDT comes from firmware (EEPROM).

> U-Boot 2024.01-rc3-00003
>
> DRAM:  1016 MiB (effective 8 GiB)
> mbox: Header response code invalid
> bcm2835: Could not query board revision
> FDT model : Raspberry Pi 5 Model B Rev 1.0
> Core:  14 devices, 7 uclasses, devicetree: board
> MMC:
> Loading Environment from FAT... ** Bad device specification mmc 0 **
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Net:   No ethernet found.
> starting USB...
> No working controllers found
> Hit any key to stop autoboot:  0
> No working controllers found
> No ethernet found.
> No ethernet found.
> U-Boot>

These patches are based on v2024.01-rc3 and tested with RPI5 8GB.

Known issues:
* CONFIG_VIDEO_BCM2835 doesn't work.
* MBOX get board revision (0x10002) doesn't work (the response status
is 0x8000_0001). Looks like a number of tags doesn't work anymore
(board/serial/MAC) but could be fetched from FW FDT.

v2:
  explicitly set .data section for rpi_bcm283x_mbox_addr due to relocation issue
  update memory map with VPU range
  add a patch to get human readable model from FW FDT

Dmitry Malkin (3):
  rpi5: add initial memory map for bcm2712
  rpi5: add alternative way to get MBOX address via FDT node
  rpi5: get_board is no longer works. Print model name from FW FDT

 arch/arm/mach-bcm283x/include/mach/base.h |  1 +
 arch/arm/mach-bcm283x/include/mach/mbox.h |  4 +--
 arch/arm/mach-bcm283x/init.c              | 40 ++++++++++++++++++++++-
 board/raspberrypi/rpi/rpi.c               |  6 ++++
 4 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.40.1
