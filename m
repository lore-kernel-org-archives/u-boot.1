Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BC7C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F67C87B7C;
	Fri, 23 Feb 2024 21:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZKuf20E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D28879BB; Fri, 23 Feb 2024 17:59:46 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D01B8781D
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 17:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso8635215ad.3
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708707574; x=1709312374; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VbSShFruXtTbP3+JjVE+5u2ud6HZApIpPSswB3yapoE=;
 b=LZKuf20EPKGSmy80oiPZbkgryqNuJ5UHm/mBxWEyqhlvNlnX+QKwEONFT4Wr5s8yFk
 Cjuhqq34+vGYPTBPO4Q1cXxcXhpnbSBuejLx6ay3sTClj2I9i1uumZB3MUk5ZhmqxDnf
 Eu073k0va8VypayRjeQ2R5hb353cHMpw+LrDO0ghlJMs+l5Jbnntqp2TcSn1G1PCHU2v
 ag7pL5l33YLBQeMReSByAlUfLpZAlb0zjMmSLfpDU/gi+MegUMiL1Sx7MBNajEB1XGZH
 4IYgpzvM4VNhL6/EpF42GiATaqQvKcxZSh+fFuF7OSY1Y+8zCmuwqi9pU9ObReA2Xnb0
 30hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707574; x=1709312374;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbSShFruXtTbP3+JjVE+5u2ud6HZApIpPSswB3yapoE=;
 b=b7B7Jhycg4p3lAF89dCdHgOlSTIfSHHU+2pBkPlNk8vklmF7GNrloqubaZuk1AOZzz
 ThX08YMHQ+dmSiOdmB66Wzhk04SxmVtB+GtTmpmVwLAWpZq0fCG5GlA/TV5518QeGgOD
 nhncSNDnKURnyVZw72u2KlsnYehURzRqOTQ2OwSOqAi43lg3Df8hhZ14KlDCE7eT56aL
 6Davqfakk38LuyU6Ac709lDZG3IvaZdhAG1uZGHBgaM0Mssu+gL9kq/1nP6OVFijLKbD
 Rhw3aTsuF/sBEEfDBGDgqcpwfkwhFGfxtnfVyWvWcjnwx3v9wZYShiaF2r2V4Os2n1LK
 o7fA==
X-Gm-Message-State: AOJu0YzfHcY5u0MLVykLZgRy4q60F4lpw58CHTF+tOnmHZuYby2XYh65
 4dbbtBp6SYvUDeqCp8ODim3bKajF+rKHQSOs7GkdnyqP82UvOyVbqtxYyeLgU+AVwipoVGTPFNJ
 VcpKxnB0vL2oLfzlKHLbUa2t7uTO5Uu4r
X-Google-Smtp-Source: AGHT+IEQ9wsX+f/x0KJDLr0DQwGo+jwy1x0V6VPoq3ljzfpUicbCtt62RQpWFZ5hrLb+i2/8bGcu3ZDSve0oeMT4vdc=
X-Received: by 2002:a17:902:d385:b0:1dc:2755:16e4 with SMTP id
 e5-20020a170902d38500b001dc275516e4mr312012pld.22.1708707574517; Fri, 23 Feb
 2024 08:59:34 -0800 (PST)
MIME-Version: 1.0
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Fri, 23 Feb 2024 17:59:23 +0100
Message-ID: <CAHseuWAmUbWJtmH8TNtr6_P3ibd6+1yT2kKticNdbfLdMViLqA@mail.gmail.com>
Subject: Raspberry Pi 3b Plus USB-Ethernet lan78xx_eth address not set
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

I have a Raspberry Pi 3B Plus which I want to integrate with U-boot
(v2023.10) .

I am using rpi_3_32b_defconfig to generate u-boot.bin. But while booting I
am getting below error

Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Net:   No ethernet found.
starting USB...
Bus usb@7e980000: USB DWC2
scanning bus usb@7e980000 for devices...
Error: lan78xx_eth address not set.
3 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Hit any key to stop autoboot:  0

In the "bdinfo", "current eth" is not set

U-Boot> bdinfo
boot_params = 0x00000100
DRAM bank   = 0x00000000
-> start    = 0x00000000
-> size     = 0x3b400000
flashstart  = 0x00000000
flashsize   = 0x00000000
flashoffset = 0x00000000
baudrate    = 115200 bps
relocaddr   = 0x3b360000
reloc off   = 0x3b358000
Build       = 32-bit
current eth = unknown
eth-1addr   = (not set)
IP addr     = <NULL>

I also enabled LAN75xx in menuconfig and re-compiled u-boot. But still the
same error.

However on Raspberry Pi 3B, I don't see this error and "current eth" is set
to "smsc95xx_eth" and "ethaddr" is also available.

Can anyone please let me know the issue with Raspberry Pi 3b plus?

Thanks in advance.
