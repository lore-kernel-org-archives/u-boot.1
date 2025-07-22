Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA8C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 01:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A419831A4;
	Tue, 22 Jul 2025 03:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hf5CprCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82D3837E4; Tue, 22 Jul 2025 03:16:55 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61151831A4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 03:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roy.walker777@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-236470b2dceso39832035ad.0
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753147011; x=1753751811; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S3W8/x4wgLFjGVTAd+gEWijNraVANZlGcBE7neuLrKw=;
 b=hf5CprCgsI62+mFruSn++JLqitoyYy5Q4672A1s9bdq4iVX6wtJmfSsy3hRySQnxMd
 TUpIPmzknA/U/qPIw4teo2Ieu9f/Enh7EkOqfb++UPkAxqtLp4qfEAOz2sMTIZqTNDkq
 /TdbYoGeJgBpT2siHOe44WA5r6hT4sDbuqbmwNFkmUCn55Pp/KzWOFfikzVhu7NXZVcl
 G7OcPta/h76RqLmqgVNmq6RH83ju9I7QMwlLHUwlolFTSmG7+yMMYZ0/cFxVj2TNuwK/
 iX437TtacT95MqykRsobJMDZtqaVweU/XBFwkrpoReQ5rfvbO+ZtgH+o9kIaOIFe8+Ee
 CGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753147011; x=1753751811;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S3W8/x4wgLFjGVTAd+gEWijNraVANZlGcBE7neuLrKw=;
 b=ZauMigAoCEznZPPhsZm4Vs4IUq+FBn52gORfKoBOcks6c/E4hZvymHcq3B0ynNt4Ho
 4yXqi19n0PpKAh9RtbWF7pjsXVneddIZMUL5UfW2cD0H3kdIq88oMO1uIR2Ng+xceSc2
 KrtkMkQkA7jiSwcBx+wpgBEwiNDf8bVSx5a4/z8/7aQoskLCv/ihVur/PePLrWNSjL6y
 iAZSJZBfn1DmoIOtzrbtpK66iah8exUDywSCBS5fPSfSbsYWQrDKIFkgXfpJPpVadPRe
 FW75R5WeQCdmoQwtMgWcG37iV3nR1PnSyX7kgnVtItEcdf0lsybAyc+iFZyPlnphPktN
 rWSA==
X-Gm-Message-State: AOJu0YyAt7018Dvlo/DSA76CBFIEnZATfiAjI6Rx+Y2eunA0uQqd9GO5
 rNKToa1QTfB851Zoc5Dfjw9vHSJnpvH0Y8vqL2rIdCChsPfC9sl7lHcQ5Zkvsv7Z0wXdfidGfU5
 HRQ2uc2ylkTxm0T2VKBW5fx+HfhbIKdWwN8TR
X-Gm-Gg: ASbGncv4aEND5O6phPQyVrP8lyM1QSYMRHz1dgbkBvGzI3/oHjnv4dySQwWwDg37GYa
 W9s1wAW9SFUnDwarr06Cqao2cgkykLwAxfnC0KqysD49fhLtz+F+81q72dq8drVd5LwvwXWhvs1
 BAWjVVKZU9PCJm4N3Oauv5Lb0mZqtsXHhjRYBXHLTCeJbCuvb+hAR3wXj+RCo87n1VkC15l72HF
 Q12j6Q=
X-Google-Smtp-Source: AGHT+IEWXDfjwlf5ehc12aB5/mc9JoXyYFHwSRHxHq2HgrAOPR+qnEnGaO9cGfkrGwtSeRV2mrX2vFWVz9JbT1p5OD4=
X-Received: by 2002:a17:902:ce85:b0:23c:8f15:3d46 with SMTP id
 d9443c01a7336-23e25750d9emr278265585ad.37.1753147011486; Mon, 21 Jul 2025
 18:16:51 -0700 (PDT)
MIME-Version: 1.0
From: Roy Walker <roy.walker777@gmail.com>
Date: Mon, 21 Jul 2025 20:16:36 -0500
X-Gm-Features: Ac12FXyGkLgvuKXbRNa5CaNNCoolaNepZKBAiqrjSc481co4ELocgMBbH5f3Uws
Message-ID: <CAD-tQfUmsy=YN5gKSx1+RX_3GRgd-RbeqC3z2db3VXZvFvNeKg@mail.gmail.com>
Subject: Mediatek build help
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 22 Jul 2025 03:58:03 +0200
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

I was trying to get Openwrt support working on a TP-Link Festa F61 access
point and wrote the image to the wrong off-set.  Didn't realize until I
restarted and was getting this on boot:

U-Boot SPL 2018.09 (Jun 23 2023 - 11:14:20 +0800)
Trying to boot from NOR
Error: LZMA uncompression error: 1
Trying to boot from UART

Failed to load U-Boot image!
Entering emergency mode.
Please transmit a valid U-Boot image through this serial console.
The U-Boot image will be booted up directly, and not be written to flash.
Accepted mode is Ymoden-1K.
I built a new u-boot image from source for the mt7621, but can't get past
this:

Starting ymodem transfer. Press Ctrl+C to cancel.
Transferring u-boot-mt7621.bin...
100% 257 KB 8 KB/sec 00:00:31 1 Errors

(SOH)/258(STX)/0(CAN) packets, 5 retries
Loaded 263882 bytes

MT7621 stage1 code Dec 16 2019 17:45:55 (ASIC)

CPU=500000000 HZ BUS=166666666 HZ

Change MPLL source from XTAL to CR...
do MEMPLL setting..
MEMPLL Config : 0x11000000
3PLL mode + External loopback
=== XTAL-40Mhz === DDR-1200Mhz ===

Any help would be greatly appreciated.

TIA
