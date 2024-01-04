Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503C7C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF4587967;
	Thu,  4 Jan 2024 13:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pt3uxU7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B0387852; Thu,  4 Jan 2024 08:05:10 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D763087823
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 08:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7cd5ab5d5bbso79553241.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704351906; x=1704956706; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dDTrIsByYt3jwrYFfF8jPL05pabRIXDszYCWYNaa4G0=;
 b=Pt3uxU7KWjN7Jn8imBK7u/IntXO3we5tpRW+mtndgWhjBV+zobqODrH08jPkoUZIZs
 vIm30G7rjGkCBdf4wabYAojjxZqv83n5VTNr/GoQRGKt3SnCvkWA9t+KZnS6PmBqQEY1
 Ajuujgz1sdvw7tJJOdQwZMHEG2OuqmuqilSgG6QCw7X546PTIeM7fzTCwWhxhfcJ3oqO
 3MsTBgvVzgZoEtfItfZYX5b6daW0yw7lnVrezsjeBneSLZvTEBg//oD56kZ5rnPfiEAG
 t7Rcclny98BPrkVCqIPyhsRm0waO4Ng51VYyDwf3Z2oCCTmdArJnodNAwi4iF269fD+m
 +qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704351906; x=1704956706;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDTrIsByYt3jwrYFfF8jPL05pabRIXDszYCWYNaa4G0=;
 b=KzJb8/4yRrprjN6TaMdvUuUykyR2oBJR6rjwxlmR9xPMIlbsEs3GEKxb/zn4fVVI3r
 PKIqLGZFNwtJ1Gt38Hs/V9o2VrstE0oYcoG4VDJP/9MEGj+1PnRmrJfZxzPX4D9jqaS5
 dwJp1AjSIlzapvcH+KgQlD0vNKwgNknEad2bFy+o6wOg1LhhBPDBC5FBT8jrY1retKqh
 M7QPnFy6TdrRjDJxIcIgSJfJX4EEK+IBPpoR2iffF+vvzSB9/oyI9Y8rSqIClFWz4oXc
 IfUndtsJrf2jGE+sydKFNbfzsiC3REy7pGYADeWI3v9oDBijt+p96z1OweDXe7XtQaxT
 cZLQ==
X-Gm-Message-State: AOJu0YyJZyRL2pokK1bORnCaZZds5fF/a/UugYTBfv1ouI7Jdt/UnVM6
 m73KHa/QM3JUSP6xNWl3egJlDbW/hEGazyuQI1OrrkZnz5g=
X-Google-Smtp-Source: AGHT+IG8j2J9lpDDpNuXVuwm01IUf973e3UTuVHCJ4Wzf9Af1UM57zjyxODU/AP0zOD5NcYAW84G11Aaf40j+xeLh2Y=
X-Received: by 2002:a05:6102:512a:b0:467:2737:4d52 with SMTP id
 bm42-20020a056102512a00b0046727374d52mr76693vsb.24.1704351904903; Wed, 03 Jan
 2024 23:05:04 -0800 (PST)
MIME-Version: 1.0
From: E Shattow <lucent@gmail.com>
Date: Wed, 3 Jan 2024 23:04:54 -0800
Message-ID: <CANV2PTOD+cY55ES5HDrSZuGjqee3fvfXKORWg8bJFT64mFdg8A@mail.gmail.com>
Subject: booti usage offset requirements for compressed kernel and initrd with
 dtb
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 04 Jan 2024 13:19:13 +0100
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

Hello,

There is data corruption when using booti on a JH7110 (riscv64) board to
load (over tftp or ymodem) a compressed kernel, compressed initrd, and
device tree blob, when the data are too close together (even though not
overlapping). In the adjustments I have tried it seems to be consistent but
not clear "why?" by how much for each adjustment is needed to observe the
failure versus success.

My question is simple enough, what are the intended offset requirements for
loading these data into memory for use with booti ?

For example:

setenv ip 192.168.2.216
setenv loadaddr 0x60000000  # default from Milk-V vendor for Mars CM product
setenv kernel_uncomp_size 24193024  # uncompressed size of
vmlinuz-5.15.0-gpu117 from file command information
setenv kernel_comp_addr_r $loadaddr
setenv kernel_addr_r 0x61712800  # $kernel_comp_addr_r + $kernel_uncomp_size
dhcp $kernel_addr_r
$ip:mars-cm_debian-desktop_sdk-boot/vmlinuz-5.15.0-gpu117
setenv kernel_comp_size 0x$filesize
setenv dtb_addr 0x62e25000  # $kernel_addr_r + $kernel_uncomp_size
dhcp $dtb_addr
$ip:mars-cm_debian-desktop_sdk-boot/dtbs/starfive/jh7110-visionfive-v2.dtb
setenv initrd_addr 0x62e31d7f  # $dtb_addr + 0x$filesize
dhcp $initrd_addr $ip:debian-installer-netboot/initrd.gz; setenv
initrd_size 0x$filesize
booti $kernel_addr_r $initrd_addr:$initrd_size $dtb_addr

Waiting for root device ...

(and nothing else, this is a failure)

If 0x62e31d7f is replaced by 0x62e31ec6 then the boot is successful and
dmesg from debian-installer shows the additional information:

 Freeing unused kernel image (initmem) memory: 2196K
 Run /init as init process
   with arguments:
     /init
   with environment:
     HOME=/
     TERM=linux


So in this the kernel boots and all works normally. Even if that address is
0x62e31ec5 one byte earlier it is a failure.

In other attempts I would change the ordering i.e. so the initrd is first
at $loadaddr and then kernel and DTB, or DTB and kernel. If I learned
anything it is that compressed initrd must be loaded to a span of memory at
least the size of its uncompressed length, and this is also true of the
compressed kernel vmlinuz even though booti documentation vaguely infers
that there is an area of memory specified for decompression - so a
compressed kernel needs two times its uncompressed size is that correct?
Also there's no hint anywhere if the device tree blob has special memory
constraints but if it is not starting on some 16byte aligned address at
least my superstition from observations in testing is that it is not
successful... and now, where it ends (in the above example) and initrd
begins seems arbitrary.

Sure I could pad things out, they tend to work that way, but I would like
to know "why?"

E Shattow  (kindly reply-all off-list I am not subscriber)
