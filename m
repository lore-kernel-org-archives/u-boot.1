Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB15C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 16:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A6480194;
	Wed, 30 Jul 2025 18:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=race-technology.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=race-technology.com header.i=@race-technology.com header.b="R2IR4I4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F8A803CC; Wed, 30 Jul 2025 17:20:01 +0200 (CEST)
Received: from server.race-technology.com (mail.race-technology.com
 [178.32.229.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A728091A
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=race-technology.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew@race-technology.com
DKIM-Filter: OpenDKIM Filter v2.11.0 server.race-technology.com E135770CAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=race-technology.com;
 s=default; t=1753888798;
 bh=gGL61bMx9ZXD+Aw8SfSzDRYpSdN6VATeISzqQYuL7Ac=;
 h=From:To:Subject:Date:From;
 b=R2IR4I4jfUm2g93MKgGBudbvN692sBx2QuwUZPC2565roptTsiK8pcqQg/hr9hdDO
 2TvEEpbP+o1PJK4biVYL51D5M3nt+DP8Y3+3J1vEyq7JaESzM5Oc/G9q7yS8PlA3jp
 HKJ0rV3H10zhlImUoSGisx0ThWoZLUweeDhmVkqTOdVnbyLt69KHS+5mAWO+DNgVxP
 Q5UhMRxk5MralQYOSOcrJwL1DEqRv6kjI7RvXPZziKKDuIrHsS7ab38U5vZRlZ8Vo/
 5VE3jAOMjJd3CGte823e/I3O+J8LSxsqaEx5j/OAojEo5wqLmqGs9TJoNHBqh7M0sO
 MGnVw5PbSt4mg==
From: <andrew@race-technology.com>
To: <u-boot@lists.denx.de>
Subject: RPI CM5 has 130s delay on boot
Date: Wed, 30 Jul 2025 16:19:55 +0100
Message-ID: <013401dc0165$67e6b5d0$37b42170$@race-technology.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwBZWcDJjretYJuSWGJPS7qI3opXg==
Content-Language: en-gb
X-Mailman-Approved-At: Wed, 30 Jul 2025 18:42:01 +0200
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello all,

 

I'm feeling a bit out my depth and hoping someone can help me. We've been
using uboot on the RPI CM4 with great success, it's been perfect.

 

We are migrating some projects to the RPI CM5 but have hit a roadblock. The
boot process regularly (but not always) gets stuck for exactly 130s, as
shown here:

 

[ 3.403341] Waiting for root device /dev/mmcblk0p2...
[ 3.403453] usb 1-1.7: Product: WS170120
[ 3.403454] usb 1-1.7: Manufacturer: WaveShare
[ 3.403455] usb 1-1.7: SerialNumber: 220211
[ 3.429612] input: WaveShare WS170120 Touchscreen as
/devices/platform/axi/1000480000.usb/usb1/1-1/1-1.7/1-1.7:1.0/0003:0EEF:0005
.0001/input/input0
[ 3.443253] hid-generic 0003:0EEF:0005.0001: input,hiddev96,hidraw0: USB HID
v1.11 Device [WaveShare WS170120] on usb-1000480000.usb-1.7/input0
[ 134.202779] mmc0: Command Queue Engine enabled, 16 tags
[ 134.208450] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[ 134.215432] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
[ 134.221178] mmcblk0: p1 p2 p3 p4 < p5 p6 >
[ 134.226023] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
[ 134.230952] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB

 

After searching, this appears to be the same issue as reported here:

 

https://lore.kernel.org/u-boot/421019670.5226453.1745000686387@mail.yahoo.co
m/

 

but I cannot see any solution. Can anyone assist please?

 

KR, Andrew

 

 

