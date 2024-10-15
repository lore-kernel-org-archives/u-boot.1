Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767E1D20698
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 03:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478E588BD2;
	Wed, 16 Oct 2024 05:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rpxpfddh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3961D87CF8; Tue, 15 Oct 2024 23:02:18 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A4380AE6
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wulfgarfr+ubdlist@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0cee600aso348757866b.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729026135; x=1729630935; darn=lists.denx.de;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nZqkJPCjS53MlRsYbOUrraZ4FBgoKpFB4FTPunZihU=;
 b=RpxpfddhYUd6jxNcEYTnmqA7GHA+5Vly+RL458aEBel7BasROjUv/vynIw87sZxMtj
 ItOQjLTNXL3l0RnfjwDvn+pTSjXFSDQLL3tUILGmpwR1pm7QzSJlYnZ9V/Ci1bSxIB4u
 kTbexkyX1imjP5yTGMd9AR0Xhz/aNjtGHN22Gwuj4en2IxjiwG8GrpbCGPBj8DNzzYR2
 MbBTc2YVqNW8KedEkYZLyNcvNE2tMyxAkijs1GrxLKLbU4x9mbIrLeNfzJfCKcKTzzz1
 CEPuX17i2rODVUuVHFV166oqfd2n908MFNL24Mp9bzAkAfEz2zjtLwl4ZmwLFKTcZeH0
 Xamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729026135; x=1729630935;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:to:from:date:sender:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+nZqkJPCjS53MlRsYbOUrraZ4FBgoKpFB4FTPunZihU=;
 b=AN0ISFjXetuqw7KPUfzKUPX18/GR2q+BgEOxAWZdHemjq6YM43jK2cKc0WZHK2/quW
 Jq9cOdepa/A80CHdA/KUxwvWOiAAvMJUfE5/ndNEj/Zuq3ywh8O34gHNyHTEIJV/RDya
 ZrRIbjxlJ/WDVjP2S/E1PxHKYGZkRXyRrb1LsOjPT2qD3/E/v8RG/dpcfrMB9+TEccaH
 zB0ICE0ryrA3o+344IK6ZVZvv0xTOiMZ9bcckoMtzAIz/oiZce0n/HvY7BOgVviism3E
 FsooEnhHhZoyNPfA8lyqKqGWMaaw58s6qp5Kn3JfU0cbSvkSXv1HsZ3unvWaJyz/GMOh
 wXxw==
X-Gm-Message-State: AOJu0Yzuyeey8Rf287pLV2C36ht5QX9WhFn66N2rmZ3I0gE5dmEjCZtX
 XNIXs+LtfvRsArtthf2sImTCoxTZ6aEiOPYQ/tkN0a8+UDc4YxwGXVT5Zg==
X-Google-Smtp-Source: AGHT+IEUNtp6HNBGnQT+2XIrEcnbmb4+QBSh+CgzMFutO3y40OTBjB1Sy1jq63DB8eTzl8PA2pxpGg==
X-Received: by 2002:a17:906:dc92:b0:a9a:90c:8bc with SMTP id
 a640c23a62f3a-a9a090c0a28mr721917066b.12.1729026134826; 
 Tue, 15 Oct 2024 14:02:14 -0700 (PDT)
Received: from ryzendeb.home.arpa (ip-193-121-108-99.dsl.scarlet.be.
 [193.121.108.99]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a298446c3sm107423966b.169.2024.10.15.14.02.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 14:02:14 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:02:07 +0200
From: wulfgarfr+ubdlist@gmail.com
To: u-boot@lists.denx.de
Subject: Assistance required - U-boot not working on Radxa Rock
Message-ID: <Zw7YT/AO8HsbTf3X@ryzendeb.home.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 05:43:56 +0200
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

A little time ago I acquired a Radxa Rock (RK3188 SoC).
While it is an aging board, it is still quite capable and yet low-power.

However, the board I have is coming with a very old Linaro version on
the built-in flash.
Radxa does not really provide any recent builds, and the way the flash
is setup it can't easily be upgraded to a newer kernel or distribution.
The SD images provided on their website suffer the same problem.

The SBC is supported according to
https://docs.u-boot.org/en/stable/board/rockchip/rockchip.html#rockchip-boards

So I set out to build the latest U-boot release. And it build just fine.
But when written to SD card, the board just boots to flash instead.
It is capable of booting directly from SD (prioritized over flash boot),
as tested with an old Radxa SD image that I downloaded.

Apparently the built U-boot 2024.10 as written to SD is not recognized at
all by the board.

I would really appreciate any suggestions how to start troubleshooting,
or how to adapt the build.

Regards, Wolf


[1] U-boot SDcard build setup:
$ export CROSS_COMPILE=arm-linux-gnueabihf-
$ make rock_defconfig
$ make CROSS_COMPILE=arm-linux-gnueabihf-
$ export SDCARD=/dev/mmcblk0
$ sudo dd if=/dev/zero of=$SDCARD bs=1M count=1
$ sudo dd if=u-boot-rockchip.bin of=SDCARD seek=64

[2] Boot log with inserted U-boot 2024.10 SD card:
$ picocom /dev/ttyUSB0 -b 115200 -e w q
��� @� B�DDR Version 1.04 20130517
In
DDR3
300MHz
Bus Width=32 Col=10 Bank=8 Row=15 CS=2 Die Bus-Width=16 Size=2048MB
Memory OK
OUT
BUILD=====2
SdmmcInit=0 0
FwPartOffset=0 , 0
No.1 FLASH ID:2c 64 44 4b a9 0
OK! 226110
unsigned!
SecureBootEn = 0 0
Boot ver: 2013-12-02#2.08
start_linux=====230997
 3431345 Starting kernel...@0x60408000

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.36+ (build@radxa-x1) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #10 SMP PREEMPT Sat Aug 23 16:11:52 CST 2014
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
...

