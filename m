Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C080CFD360
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 23:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A390083F01;
	Tue, 25 Nov 2025 00:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxMkg3Pw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E689D83F15; Tue, 25 Nov 2025 00:12:51 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3E983E4C
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 00:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3199095a34.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764025965; x=1764630765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KZTbp2GrVPX5rS91UNOJhnm+Pyr+Gj5+PNtgaE5YqSM=;
 b=bxMkg3PwMjBXkGk+rp8QxHuHBmrwt8ojutvHix5kyOM/dLBmP7S8opNbR39jGNyMyn
 +pEbR89epEeW/+R4dl5YMvmcBlpqVuN/6k8ylcuwCm3xZPoJTKv+/BF0bHrPwfvcnPM4
 NzXGigJalB84dk3RpSebAhhwowmOuwzWvGO9n0rTbJ7ttC9dE1q/C2LJCf7+W6an8fcA
 3GSahQl8eMq4SZo4t0WlYqlE7CeOLKLldpBfL2ultvdIK8MQRUY6UxzUFa7S328uXk+m
 iyqkV4/DVtp19ZT4zkOm7FwiO88e7MTaVua6PVorXA6TJQxdXMbT9KJdGdB/W4omN61A
 xemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764025965; x=1764630765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZTbp2GrVPX5rS91UNOJhnm+Pyr+Gj5+PNtgaE5YqSM=;
 b=G+bl+pzQZLWzIHyAlPaHqrnbafpqOOEoIkSkzdEfy4Y2D9hrQy3xO3wamkIkQ49tid
 PfSFozF5f1oKW7iX8b8DnMfZ5GrJ+0AAaUN8oxhBkehtRyTbPZIzUipie1oK+L/jcOaO
 Ku9eLR7xSYgR9Aw9xl1gM2Bius2AwFGBWCKypGojxwEjI+xJ9bne6o6sE6GaJ0NFYQoV
 G64H6DpTuMeDepXeKe8e19EV5bdA67lA4DKRyeDWY+WdTAznNj9C0nPBl+5N0oVVxDxa
 Tp1nWzhuVHbEN1zBfZv22F6phmoQSovQ1LgsO6EARGlq17Xj/7BxnoD4MkE6+LFHG3rw
 0bMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLJQ+i7QC/CvZcZgPDatwvyLMJJ4pIzXtHqswue331JEIbol5X6raHY/K42r4yddwjkd2StWg=@lists.denx.de
X-Gm-Message-State: AOJu0YxnUCGpXq042aZ7jpQtZJ5VRJcZUXRypCkorau7tJ2s1HmQCxIA
 MTaAqime76x8LxGAzXW/KxTNvpW/14k6dY0U88/4Aw6AEV1rKt81Vn0vsIj0J3E6WiTsG9uhKt5
 +40Ae3DWq/yBbp0UKLHQVuZAPdSJ2icg=
X-Gm-Gg: ASbGncsWf1/ME6TBRah146BzTYAoaXpa+BhZY3hpK0KWPlQtdHXn1ZgmfRC+YENvTQ1
 jpOQww/QTinYG3j58DDLwemVcMepUMEqViug4nQgbjLgl+asaIEk80VIlveR8zkLQsaVNT0huBH
 E4RtiElQe6gPRQnVGRjNGPEBD5hj92izFh5ZQsPemBrngKkDDz81n7BbW7LpykrWHFp/AtMcY9f
 acTJ0IxgrvhtAB1fRkphUVr/aB0DrJkXIoGS/AOyu32gNV8XqsynKDTehufHymO6Pv0xi/EzAjP
 xabNxLE=
X-Google-Smtp-Source: AGHT+IE3PhWx1EuhXZEvB0RZfR3hXc1SG60cMqIqV1ZxpywMAIkl5XL5TMx3W0AcutDFAwzr7d8xN+gQYz+jgwcxOyc=
X-Received: by 2002:a05:6830:2b13:b0:7c7:61e0:a4ee with SMTP id
 46e09a7af769-7c798be508dmr7307168a34.11.1764025965004; Mon, 24 Nov 2025
 15:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
In-Reply-To: <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 07:12:33 +0800
X-Gm-Features: AWmQ_bmeRb0UUNo0DU4pOpdfBpWhaUAo1_SUBB2rXY1F1Jnr_cJXExRohI22LXM
Message-ID: <CAN7C2SA3-_wqVdYrpX=g73HBiP5hOPgKVXOOKy57vXsLp-X66A@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Looking into socfpga_cyclone5_defconfig it seems that SPL_WATCHDOG is
> enabled but no driver is. Can you tell us which (failing) defconfig
> you're using (and if it supports multiple boards, which one) so we can
> check assumptions without going back and forth with you?

Fresh build is repeatable on that calibration failure.
I have done what I can, so if there are any issues feel free to point them out.

Brian

Logs as follow:

* WDT disable DT enable fails.

* WDT enable DT enable pass.
  Warm and cold reset pass.

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:01:29 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd394
l4wd1-wdt_ccvr: 0x00000000
SDRAM calibration failed.
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01a3204c
l4wd1-wdt_ccvr: 0x00000000
### ERROR ### Please RESET the board ###

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:01:29 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd2c3
l4wd1-wdt_ccvr: 0x00000000
SDRAM calibration failed.
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01a31e7d
l4wd1-wdt_ccvr: 0x00000000
### ERROR ### Please RESET the board ###

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:01:29 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd2ef
l4wd1-wdt_ccvr: 0x00000000
SDRAM calibration failed.
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01a31ef2
l4wd1-wdt_ccvr: 0x00000000
### ERROR ### Please RESET the board ###

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:01:29 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd2ac
l4wd1-wdt_ccvr: 0x00000000
SDRAM calibration failed.
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01a31eee
l4wd1-wdt_ccvr: 0x00000000
### ERROR ### Please RESET the board ###

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:01:29 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd318
l4wd1-wdt_ccvr: 0x00000000
SDRAM calibration failed.
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01a31ee0
l4wd1-wdt_ccvr: 0x00000000
### ERROR ### Please RESET the board ###

U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:08:42 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd155
l4wd1-wdt_ccvr: 0x00000000
Trying to boot from MMC1


U-Boot 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:08:42 +0800)

CPU:   Altera SoCFPGA Platform
FPGA:  Altera Cyclone V, SE/A5 or SX/C5 or ST/D5, version 0x0
BOOT:  SD/MMC Internal Transceiver (3.0V)
DRAM:  2 GiB
Core:  33 devices, 18 uclasses, devicetree: separate
WDT:   Started watchdog@ffd02000 with servicing every 1000ms (10s timeout)
MMC:   dwmmc0@ff704000: 0
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial
Out:   serial
Err:   serial
Model: Altera SOCFPGA Cyclone V SoC Development Kit
Net:   eth0: ethernet@ff702000
Hit any key to stop autoboot: 2
U-Boot SPL 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:08:42 +0800)
l4wd0-wdt_cr: 0x00000001
l4wd1-wdt_cr: 0x00000000
l4wd0-wdt_ccvr: 0x01efd0ff
l4wd1-wdt_ccvr: 0x00000000
Trying to boot from MMC1


U-Boot 2026.01-rc3-00013-gc3a95cc3c6cd-dirty (Nov 25 2025 - 07:08:42 +0800)

CPU:   Altera SoCFPGA Platform
FPGA:  Altera Cyclone V, SE/A5 or SX/C5 or ST/D5, version 0x0
BOOT:  SD/MMC Internal Transceiver (3.0V)
DRAM:  2 GiB
Core:  33 devices, 18 uclasses, devicetree: separate
WDT:   Started watchdog@ffd02000 with servicing every 1000ms (10s timeout)
MMC:   dwmmc0@ff704000: 0
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial
Out:   serial
Err:   serial
Model: Altera SOCFPGA Cyclone V SoC Development Kit
Net:   eth0: ethernet@ff702000
Hit any key to stop autoboot:  3
