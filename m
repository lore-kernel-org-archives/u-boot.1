Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B949C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 23:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287BB8752B;
	Tue, 16 Jan 2024 00:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="goHirXjL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FE9870D2; Mon, 15 Jan 2024 22:32:57 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0237086F80
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 22:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bremenpl@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e7ddd999bso10086315e87.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 13:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705354374; x=1705959174; darn=lists.denx.de;
 h=mime-version:user-agent:reply-to:message-id:date:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=12FPk+z0kefYozINQ1yJWBWnko45P/Uog2msb1B8FCQ=;
 b=goHirXjL7MbCcqOdwFGicUaE560gBKcjNJYhMU5t+dbBaEKkiL3qziXBVGAKuuvZjW
 CZg0T3T4FeIJVLLi6MnZVYFCZ22qbjtlmHGMvUNn+O8LGpEChdtvDe4TavyujP6a92Nb
 IAcRlzGrYPEK8BRmCCDuqkaSxA7cnsK5x1LpOOiFuhO6clI2Ja/LzaJYDBCABkGKip6x
 Q6ummOfcUNW6Rbbv8CdbAhthDBk38RytG8pqZwnLDzYALgikSjiGvqs1/nJMYhgeVecG
 pcVtqb5LaObriLUsexBoC3I10xeTl92AGUdwwiIPt04WhiDpyRHavKLR2OdkiWz526/A
 Q66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705354374; x=1705959174;
 h=mime-version:user-agent:reply-to:message-id:date:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12FPk+z0kefYozINQ1yJWBWnko45P/Uog2msb1B8FCQ=;
 b=bYu3C2OLCGbNMVeJVpfGVveSZoKAubd3S9j9ns5jY+54pnbv/DvfEXa3jr7ix9399P
 wHMwcmOYfogI0NiqMD2Ee9798/8ctSZVxUXFQHfaUivsX2XpA4ldV8cJ0bSyTYoi+1sY
 NbBkr4ZD+SElOdTnZSJZKnr7KLz/wZqDc9uLQirmQwLq5rQozXjXRkBo/iYDIyTTu0ab
 snXSvI6ME96/wT0DYiO41f9O7x7U7/5HZ+XQFmg5UWFPeUmgVaAfPw3OTxVg6UN5IMxF
 OUSVhXyAAqs4n2DVZanGHZ2t+oUSWek3+DaVV9nT0O7YJvyd2GdPBS5m+tds26YxWTFA
 1aoA==
X-Gm-Message-State: AOJu0Yw8VKYfMFKWdCOrH+zY6vACRVOALti7ePRMx/ZAp8TiOG8e4uZZ
 0zZEgWMsRbhgI1PWvmfW9ODkfS2dcDc=
X-Google-Smtp-Source: AGHT+IHSgF9yv2uyMpWw0Q3eHftdH6qjztGBKjN7BSMZiAzRycLZIZjuC9sKUW2gG7Bx3G8NpaUmGQ==
X-Received: by 2002:a05:6512:6c9:b0:50b:e08a:4d00 with SMTP id
 u9-20020a05651206c900b0050be08a4d00mr3468074lff.84.1705354373858; 
 Mon, 15 Jan 2024 13:32:53 -0800 (PST)
Received: from [192.168.7.17] (eqi70.neoplus.adsl.tpnet.pl. [83.20.76.70])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a19a407000000b0050ec7956b1fsm1562694lfc.29.2024.01.15.13.32.52
 for <u-boot@lists.denx.de>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jan 2024 13:32:53 -0800 (PST)
From: =?utf-8?q?=c5=81ukasz=20Przenios=c5=82o?= <bremenpl@gmail.com>
To: u-boot@lists.denx.de
Subject: extlinux.conf file and fdtoverlay_addr_r (U-Boot 2022.01)
Date: Mon, 15 Jan 2024 21:32:50 +0000
Message-Id: <em7a81d5ed-72ab-439b-a815-abbe38155f77@dfc65187.com>
User-Agent: eM_Client/9.2.2157.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 16 Jan 2024 00:00:51 +0100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Reply-To: =?utf-8?q?=c5=81ukasz=20Przenios=c5=82o?= <bremenpl@gmail.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

I am trying to load a custom device tree overlay file in the=20
extlinux/extlinux.conf file (using Yocto [Kirkstone branch] and=20
beaglebone yocto machine). At boot time u-boot complains:

Invalid fdtoverlay_addr_r for loading overlays
Full uboot output till that point:

U-Boot 2022.01 (Jan 10 2022 - 18:46:34 +0000)

CPU  : AM335X-GP rev 2.1
Model: TI AM335x BeagleBone Black
DRAM:  512 MiB
WDT:   Started wdt@44e35000 with servicing (60s timeout)
NAND:  0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1... <=
ethaddr> not set. Validating first E-fuse MAC
Net:   eth2: ethernet@4a100000, eth3: usb_ether
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found /extlinux/extlinux.conf
Retrieving file: /extlinux/extlinux.conf
1:      Yocto
Retrieving file: /zImage
append: root=3DPARTUUID=3D18e99beb-02 rootwait console=3DttyS0,115200
Retrieving file: /am335x-bonegreen.dtb
Invalid fdtoverlay_addr_r for loading overlays
Kernel image @ 0x82000000 [ 0x000000 - 0x77b738 ]
## Flattened Device Tree blob at 88000000
    Booting using the fdt blob at 0x88000000
    Loading Device Tree to 8ffed000, end 8ffff9dc ... OK
Where, how and to what value can I set this variable, so it is possible=20
to load the dtbo file? I have found some references here:=20
https://docs.u-boot.org/en/latest/develop/bootstd.html , but still=20
cannot figure out how to configure this variable for the u-boot to see=20
it.

PS: I think that when I used U-Boot 2023.04 I have not experienced this=20
issue. If this would be the case, I can always update the built u-boot=20
version. I am however trying to understand what is going on exactly.

I would appreciate all help!

--
=C5=81ukasz Przenios=C5=82o
