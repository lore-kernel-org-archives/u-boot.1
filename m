Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A9C5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 597FE8148F;
	Thu, 13 Aug 2026 20:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JggfAtg_PMZU; Thu, 13 Aug 2026 20:57:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94E4180E8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786654636;
	bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gkXrlXPdPYmwhFtk3+bhigq3gpVzPinOYvLfPo08Bm2MN3LfadAgSjfKBf2NyPiiv
	 hGF6uWrnG0NYgaQG3beJK1Eug7bFiPQEvqorYdJgDKDHOFopwTTWyesRLS90bKT28C
	 V7Ycfg+LuUcpHDa27CVjadgvu5VUrk009UiA23equRCf9KFhRlGK9XxMQIrK5XmRAq
	 58d5Z3gzXuDU/E9Kp+izm0GZdm64LIeG9W90DZasZRcgNz6ojJ7RPk7E9Dz33o2G22
	 H1l+UH4cH0UqXhg5YC2GRwKvofbGTBNzZmQ844kL/vpVkJR2Oqw+NEdqOBwXUH+ojT
	 JnMgZPW4Aeh1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E4180E8B;
	Thu, 13 Aug 2026 20:57:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2162B139A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0730D40CBF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29voD0c6U12t for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:57:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BE4940CA4
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BE4940CA4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BK5VA0sR
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE4940CA4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:14 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so5352466b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786654632; x=1787259432;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
 b=BK5VA0sRzuOv8z8lwRIPaz+1Vjt+Rnj2LKNAU+F4Y1y4FNKuKS2i+lOfacKvy3yaHh
 sMumoyshnsw8MjF9fbFJ4Ci9poGIgNtU57Kj4YxzWVrx/i3HnJJSw1p41+d4ZhA5gDyG
 qdVeyZH7LvMUOdBPwqo0pGS+nf63H7W7cqFNjwjTAHRCo4BvTGcFXKCrEAfCGe7oYZrE
 Mv7Yv7uAbV9MuOkNcrBjJWXeSblPbjjq8JWJXgP4r7+/wY4v49GEbA7l6oI5sEBgHUgj
 zfdHtAHPwEW2+T/CUyO0205JmdbZadSnJ41E/vgLFhqWIEKA2xKBguNqTcTmmldCUJb4
 qBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786654632; x=1787259432;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTJTOl9IMYMvRRA1rw1fJerTLBG9e4miZKBSZK9ARD0=;
 b=Nx5VomRS8suWQfu+1zIO7YJW0FtKi3Lq3gZsyxysFWrDgy8nNco/8n0vIswFxLTIju
 jvcV8cqKD5qOSHc4CZu8RZwnU+/k0M9UNbr+mN15v4CW2e4P9AlA9kuXoH3rQEYMxkbm
 +W5ZbDBtPb7PBQhxifiCoQ8sIohebakirAiNiFtLqrd/CXzLHj7xvyLzhU6vvj6+QJhD
 QJVZmdWVvDfrJVSBDcnkxCzS1XOeq9SmQS+XIY+XCrE+8ZFL/6Kl68UEZPxAH8veNhpB
 /l6cRZ2JCDGIt1veN8a4zEllk2psE1AMeF5ZwdvlgaDbC03PYSnbSJmwQnLVWcNqxqFX
 6+Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtsprgUBFeeZ+E9c6dHmwQwi36zqfpSrYY7nFVqxHTufgKYMQmkjkMQREwKawNRz+3nqtZVhw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzQfVQcaUXa7DXCGu9ke0aee6pv+kYROpA3eGli5Tii/PX+26E1
 MabEJzUwoESqm08Hr2zLIcwru9gj8LEfCvCv2lgPtynV/ekqMM0H7BHk
X-Gm-Gg: AR+sD12bmBynZflvAzi72SxUSg8EEN8cUZWX4QlNIpL7Kch7XCw4rSpsnSFQF5AZflq
 SaCRGacVvgdm25sT3aqHWE2RjkHWq79FAj3SrSGu6yRSiRwsW+CyIcgYLWF8SeA5n7fO9A63dNR
 TqUGHD5jDGD3r5kQIklocTHWiFNurqWErotsx2vdykPa2eoSIHJHBF1HJjOohQjQRaRZsVfPtjF
 dUOumZ1JFusFrAuI9bRIE7pOL/z+DjObn27S47gnF1+5ec1swByoPe8NgadqMz3kSdIUzWsGDKB
 u45kToIyHxssO1sNWYYAckpHuyBUYzcgdyx6cgC2kBGGQjtDmXs0phZ5csysL0g62wpfogsoZ6u
 piCwWUcLOl3MjIZ+3govoQCZLkgC2Fxat0byG41r498L7JBDz4bERZYgLkjGneqW7V31avh3ru3
 SJ+th8XZFzTBRxVcdoeiDtdtliO3pSh7dfdu39KOhG8Y+kgAccLiPPNmkGSFAVIGEsu49Hv4yiZ
 OIQ8C4BhIsEZcQo5hyNCz6kop8=
X-Received: by 2002:a17:907:849:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2129b328f3mr28514766b.1.1786654631843; 
 Thu, 13 Aug 2026 13:57:11 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21231f1903sm33687466b.0.2026.08.13.13.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 13:57:11 -0700 (PDT)
Message-ID: <b61ab14d-f19c-4f8c-a0b5-947b51562b71@gmail.com>
Date: Thu, 13 Aug 2026 22:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 2/6] rockchip: doc: add mask ROM mode text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add text that explains how to get into mask ROM mode.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V6:
BootROM/Mask ROM swap

Changed V5:
reword
---
 doc/board/rockchip/rockchip.rst | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..7c911662b840 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,27 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Mask ROM mode
+-------------
+
+Mask ROM mode is the fallback mode of the boot ROM,
+in which it listens for USB commands 0x471/0x472.
+
+Options to get your board into Mask ROM mode:
+
+* Hold the recovery button, depending on firmware support or wiring,
+  while booting the board.
+* Remove any SD cards, removable eMMC or removable UFS modules.
+* Erase any storage media containing boot firmware.
+
+Methods of last resort (USE AT YOUR OWN RISK):
+
+Short the following pins briefly while powering the board, so the boot ROM
+cannot locate any boot firmware and falls back into Mask ROM mode:
+
+* NAND: connect pin 8 and 9 of the NAND flash with a needle.
+* eMMC: connect the clock line to ground.
+
 Flashing
 --------
 
@@ -443,8 +464,8 @@ Note:
 3. Package the RK3066 image with U-Boot TPL/SPL on NAND
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
-If all other boot options fail then it enters into a BootROM mode on the USB OTG port.
+Unlike later SoC models the rk3066 boot ROM doesn't have SDMMC support.
+If all other boot options fail then it enters into a Mask ROM mode on the USB OTG port.
 This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
 SD Card
@@ -485,10 +506,10 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
 NAND
 """"
 
-Bring device in BootROM mode:
+Bring device in Mask ROM mode:
 
-If bricked and no BootROM mode shows up then connect pin 8 and 9 of the NAND flash
-with a needle while reconnecting to the USB OTG port to a PC.
+If bricked and no Mask ROM mode shows up then connect pin 8 and 9
+of the NAND flash briefly with a needle while powering the board.
 
 Show connected devices with:
 
-- 
2.39.5

