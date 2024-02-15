Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1BCC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 11:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400A987DFD;
	Thu, 15 Feb 2024 12:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LjShAQtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C05787DB9; Thu, 15 Feb 2024 12:13:37 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704A887D80
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh011@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59a1a03d067so146822eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707995611; x=1708600411; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ng3uWNCo9Kbv3QSW4Gforo1ppu+17fiuw/AU0cPWlJg=;
 b=LjShAQtfRY5/BAinTh8STU6zGseOQrcvSpIT3I+8sT57fTylfInbAMRtOs0FE0QjTq
 iOipf13AJGXQ0YsQkAAm6qWdkg7D+FqNESp0V4f2dD+JB6KKvCB42zsze7cqo1F50S1K
 JpuiWnJLqvl8Vi+hwI0BcunfXR8/qrg8MhD6v6quL4IWwGmcA6QzFSZrjSMQDs74ldcl
 Pw+HMllRwvT0O3Ia5lEmhynG3qUcIUzLsH8GbOxdWKJN3fpKWl4iWzTCBqH63jrcMj67
 MEe1vxFq5eD39F38FYvSvEuwX3qj3jmRpYTDPHJMCh7hruRDj7MZY/Hz1ufsAH+vpCx1
 9ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707995611; x=1708600411;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ng3uWNCo9Kbv3QSW4Gforo1ppu+17fiuw/AU0cPWlJg=;
 b=s4oSYELmb0UYFNUwUGPXxNHdk9EY4RcD9iytF7DfkToDVMFwVJ18/jBNUMaJD1cjS0
 ZunVXsU9Xw6npoMnk3ZQyTh+m9bMSw9FyUeYTw9WYXKLQWtRNX/1zD1ACqZOcH6t8GVP
 UKrp8z32xlr2y7n87MATj967z5owVgBWDd2g8e+xcgQnCZ2hC6YEIW8TramiKhuIU0Ci
 Pomh7J/MMaQiPNzPvUHuu2K1q4KYmtdhUbWblumQfjRGNXlQbj1hQbHNDdZQExj4zhiG
 b7EYX37ARrv4AGWVWJASwg1FqhHGd8lmFrS4yMN+gI7pNzKCHZFcANbkDR0wdEE9pNXE
 DE7A==
X-Gm-Message-State: AOJu0YyidBaoMQ1phY9Z5X53i9wr9/wV1X1urU6f5rMygSO7N9YyBQ35
 VcNu44NaHNKNWUbwQRUUchUM5krKPb1oxWOdCcLoi/GQuQJzVoAYUfjCtGWO/lpRaQfiVzIjUSa
 kydMjg8gokLh5LIeE/oIWbKzHz+OkSz895NLYQg==
X-Google-Smtp-Source: AGHT+IHxnRK3a5FVnLoA1no6B4dr65cESmNewZqheFQV5wXHjuPVZ7/O7whKwRclg+EY36yQl0ZbzhlZXu+Kazf/gk4=
X-Received: by 2002:a4a:6245:0:b0:59d:c3a:d6a0 with SMTP id
 y5-20020a4a6245000000b0059d0c3ad6a0mr1441657oog.4.1707995610536; Thu, 15 Feb
 2024 03:13:30 -0800 (PST)
MIME-Version: 1.0
From: Sourabh Hegde <hrsourabh011@gmail.com>
Date: Thu, 15 Feb 2024 12:13:20 +0100
Message-ID: <CADYjeSv5HOLwAVyg69woJ-CaapynJcx=ZJEByDFqrpVhGH1SVg@mail.gmail.com>
Subject: How to load raw disk image in u-boot?
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 15 Feb 2024 12:30:49 +0100
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

I am working on the secure boot for raspberry pi topic as described here
https://github.com/raspberrypi/usbboot/tree/master?tab=readme-ov-file#secure-boot---image-creation
The
boot.img file contains u-boot.bin, config.txt, boot.scr, Image, DTB and
other raspberry pi necessary files.
But when I try to integrate this with u-boot, the boot.img is not being
parsed and I see below errors

libfdt fdt_check_header(): FDT_ERR_BADMAGIC
No EFI system partition
BootOrder not defined
EFI boot manager: Cannot load any image

I tried to manually load it using:
fatload mmc 0:1 ${kernel_addr_r} boot.img

this works but, booty is not able to run it
booti ${kernel_addr_r} - ${fdt_addr}

Bad Linux ARM64 Image magic!

I believe first we need to uncompress the raw disk image and then load it.
However with unzip it is not possible to do it.
unzip ${kernel_addr_r} 0x83000000
Error: Bad gzipped data

So, how can we load the raw disk image in U-boot?
