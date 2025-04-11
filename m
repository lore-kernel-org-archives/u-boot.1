Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F0FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950A7841CC;
	Fri, 11 Apr 2025 18:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZLx1D3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA3B8406A; Fri, 11 Apr 2025 16:08:30 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80C084003
 for <U-Boot@lists.denx.de>; Fri, 11 Apr 2025 16:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonas.licht@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70565ccf3bcso581417b3.0
 for <U-Boot@lists.denx.de>; Fri, 11 Apr 2025 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744380506; x=1744985306; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=voDRx+XwReGnVDwW+uZ9KNHTP00WugP9MfAxy/BUzS4=;
 b=EZLx1D3GztQiHiMJ/b1lQTK73XtGI8abPwAGkxGUM798B8EdI+UEHcVlIir1i9Nj8h
 Fwo+Tdqq8KCgPjscz9bg1QcGrz8r8+FHzRInxlV/NpOb8sB4xRx0g9oh6JXQ67i5Fddi
 RblRbGuZcWWy1NGEzgpt9CsoDmBWuYGkGZchY0QHl+rjnuojX9Jac6XWdFyAdEolohht
 zNQCee57pPIDfPRrOHoqh3qJ4ti+09AbVzROpTn7QhEfvrwgH4Ql5Nf1AHfNp/v/VoAI
 GCNC+d6M5bFkgMS0EHyZB5vCDwg32GNwQiODjm/AymtOFPZMgn6KsL3gQwnoq8gLAUKV
 94tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380506; x=1744985306;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=voDRx+XwReGnVDwW+uZ9KNHTP00WugP9MfAxy/BUzS4=;
 b=FkEoprxE8k+enwU3gBXyIfAvJ08JBZZLT8q26SXpCJU+QmWisBgKoLTizhsr01TjFH
 e7mWRTWw8gb8gHnWGG/SKRkJRAmPW1Qf0nWl/y7xmJb2KRjjMmnDePHmFaSBdfYhlu8g
 G11UmFj6egvX8oRunsdnaINzHGzWi239FOd7hBE2QefLpcvYS3ecwtEgOsshMGSWYSWW
 DtBubw9ttFxH0DTXB5LfaSZzUJUX1Sb15muQ72L5NjcBt9X8XBRTbuheXBoE+bIg2N45
 BuAlXHJ4pJBGXvs4bG7GK3VClUpXEF7C7OMjx/Dd9LCyOO7F+UMX0cCvzjKKF79LwYHA
 pzww==
X-Gm-Message-State: AOJu0Yz3otlnBl6AC6JczKMXJxmNLPEw3NEqH6TNOCVcmAPYVMNJHTm9
 KR1lqYQykcwgPfMsIs8cb2k9Vi35lA+yDXoc8duQ55Xebdg/MXMGnOpn1ituYXwpM3qHhyHqPN6
 F0RaryPDQwtI0VS8sEAu3bQUun1G9FqUl
X-Gm-Gg: ASbGncsohSG3A7LIKkzhIUqwrNhB8810D0yUaYCQ6rwvUHb5KWNyeJrS3q+FXonHj52
 Ddbo3AC4vsSxv7Be9ed/c0Umf3rhRdSDaeBUY08L0WJojC5ZvT7oEnM8s+lhnxLYAkroms/DvPf
 +wlXOc5PzeBefBd2seGgY6hs22
X-Google-Smtp-Source: AGHT+IGeF+UUuF78XQdwxDVuumGmBojXqdnrs07oBuuiuqjJvJtCoxtFSzTl0LNUNZpV0TEKeIaB5PSCDPY2ncvupXE=
X-Received: by 2002:a05:690c:7084:b0:6fe:c040:8eda with SMTP id
 00721157ae682-70559980e88mr49467967b3.4.1744380506338; Fri, 11 Apr 2025
 07:08:26 -0700 (PDT)
MIME-Version: 1.0
From: Jonas Licht <jonas.licht@gmail.com>
Date: Fri, 11 Apr 2025 16:08:15 +0200
X-Gm-Features: ATxdqUHtVp6WMpB35_BsXE37zFgaExGla73UlISiP-35r9hQHvszN97kCsARs-g
Message-ID: <CACoKKUtEY3+DWQXJn--MpORpNYtNA13ewd34X4LSQ0yW9m-fEQ@mail.gmail.com>
Subject: Issues with AMD Genoa/Bergamo PCIe Bridge
To: U-Boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 11 Apr 2025 18:50:42 +0200
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

I do have the issue that my u-boot is not finding my sata hard disk.
I'm using a supermicro H13SSW server with an efi payload64, with the defconfig +
CONFIG_DM_PCI_COMPAT=y
CONFIG_PCI_REGION_MULTI_ENTRY=y
CONFIG_PCI_ARID=y
CONFIG_PCIE_ECAM_GENERIC=y

It looks like while probing the pci bus, u-boot don't see the sata controller.
The pci tree in linux is show as the following:
lspci -t
-+-[0000:00]-+-00.0
 |           +-00.2
 |           +-00.3
 |           +-01.0
 |           +-02.0
 |           +-03.0
 |           +-03.1-[01-02]--
 |           +-03.2-[03-04]--
 |           +-03.3-[05-06]--
 |           +-03.4-[07-08]--
 |           +-04.0
 |           +-05.0
 |           +-07.0
 |           +-07.1-[09]--+-00.0
 |           |            +-00.1
 |           |            +-00.4
 |           |            \-00.5
 |           +-07.2-[0a]--+-00.0
 |           |            \-00.1
 |           +-14.0
 |           +-14.3
 |           +-18.0
 |           +-18.1
 |           +-18.2
 |           +-18.3
 |           +-18.4
 |           +-18.5
 |           +-18.6
 |           \-18.7
 +-[0000:40]-+-00.0
 |           +-00.2
 |           +-00.3
 |           +-01.0
 |           +-01.1-[41]--+-00.0
 |           |            \-00.1
 |           +-02.0
 |           +-03.0
 |           +-04.0
 |           +-05.0
 |           +-07.0
 |           \-07.1-[42]--+-00.0
 |                        \-00.1
 +-[0000:80]-+-00.0
 |           +-00.2
 |           +-00.3
 |           +-01.0
 |           +-01.1-[81]--+-00.0
 |           |            \-00.1
 |           +-02.0
 |           +-03.0
 |           +-03.1-[82-83]--
 |           +-03.2-[84-85]--
 |           +-03.3-[86-87]--
 |           +-03.4-[88-89]--
 |           +-04.0
 |           +-05.0
 |           +-07.0
 |           \-07.1-[8a]--+-00.0
 |                        \-00.1
 \-[0000:c0]-+-00.0
             +-00.2
             +-00.3
             +-01.0
             +-02.0
             +-03.0
             +-03.1-[c1-c2]--
             +-03.2-[c3-c4]--
             +-03.3-[c5-c6]--
             +-03.4-[c7-c8]--
             +-04.0
             +-05.0
             +-05.1-[c9]----00.0
             +-05.3-[ca-cb]----00.0-[cb]----00.0
             +-07.0
             +-07.1-[cc]--+-00.0
             |            +-00.1
             |            \-00.4
             \-07.2-[cd]--+-00.0
                          \-00.1

And the SATA controllers are under addresses:
lspci | grep SATA
0a:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 91)
0a:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 91)
cd:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 91)
cd:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 91)

In u-boot running the command pci, only gives me this:
pci *
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1022     0x14a4     Bridge device           0x00
00.00.02   0x1022     0x149e     Base system peripheral  0x06
00.00.03   0x1022     0x14a6     Base system peripheral  0x07
00.01.00   0x1022     0x149f     Bridge device           0x00
00.02.00   0x1022     0x149f     Bridge device           0x00
00.03.00   0x1022     0x149f     Bridge device           0x00
00.03.01   0x1022     0x14a5     Bridge device           0x04
00.03.02   0x1022     0x14a5     Bridge device           0x04
00.03.03   0x1022     0x14a5     Bridge device           0x04
00.03.04   0x1022     0x14a5     Bridge device           0x04
00.04.00   0x1022     0x149f     Bridge device           0x00
00.05.00   0x1022     0x149f     Bridge device           0x00
00.07.00   0x1022     0x149f     Bridge device           0x00
00.07.01   0x1022     0x14a7     Bridge device           0x04
00.07.02   0x1022     0x14a7     Bridge device           0x04
00.14.00   0x1022     0x790b     Serial bus controller   0x05
00.14.03   0x1022     0x790e     Bridge device           0x01
00.18.00   0x1022     0x14ad     Bridge device           0x00
00.18.01   0x1022     0x14ae     Bridge device           0x00
00.18.02   0x1022     0x14af     Bridge device           0x00
00.18.03   0x1022     0x14b0     Bridge device           0x00
00.18.04   0x1022     0x14b1     Bridge device           0x00
00.18.05   0x1022     0x14b2     Bridge device           0x00
00.18.06   0x1022     0x14b3     Bridge device           0x00
00.18.07   0x1022     0x14b4     Bridge device           0x00

After I enabled some logging, I can see u-boot is scanning a Bus
behind 00.07.02 but don't found any devices:
pci_uclass_pre_probe, bus=-1/pci_0:7.2, parent=pci
rivers/pci/pci-uclass.c:1150-pci_uclass_post_probe()
pci_uclass_post_probe: probing bus 6
drivers/pci/pci-uclass.c:887-pci_bind_bus_devices()
pci_bus_read_config: ret=0, vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0,
vendor=65535pci_bus_read_config: ret=0, vendor=65535

Does anybody have an idea what I'm doing wrong or what I can do to get
the other pci devices?

Thanks in advance,
Jonas
