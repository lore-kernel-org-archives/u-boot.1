Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C2CEB2CD
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 11:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABC8D8415D;
	Sat, 15 Nov 2025 12:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsaiWNZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79638416F; Sat, 15 Nov 2025 12:25:20 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C8A84158
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 12:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e41b6469f5so1249931fac.2
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763205917; x=1763810717; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OtPz+I/DMCWMb6DgKmHiR93nQfT0kYrQ2b0JkUQrXI8=;
 b=LsaiWNZ8HfXKx5zAzRZ3RUtM+QIBPNO8r9zgVujscISVcL8rmzemKLP1FwkSwd71eh
 5OWaBCNOtubt2XPWI2XrgKlIFTDvZqRz3OpQcQinYb5oLN4VJ8lmKB528V/0gJf/oIjU
 JjKPaAC4qoVqU+HArPYeOIteXk0oK5+gVjgye7ir49gQ0KVGTcRureb78aKG9DyFrGYq
 JOhT8bRJzbUKi/hm7aVanGLfi7/4GmaQnNwNNAZ5B3NVEFOlynnbai0gQFGJM44kqN/H
 M377UTMT0H+WXmClxKv0XoDe1FbB5I6uyaQxGjyx2d9bs4oGLSN8PFW9z55hBqswZZFU
 8tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763205917; x=1763810717;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OtPz+I/DMCWMb6DgKmHiR93nQfT0kYrQ2b0JkUQrXI8=;
 b=IowAlFZOgxKijJ5WjhVpfpSMc5lDW91ij/dSBJNGYLvYYSgD4mqtBtdIQOKWBkSjgA
 1s4Pqwrh6v24fImL0CvkMxBkRZwovR2qVgIbEmFprJn1UDghVhEaAKkhs0o8loX6zwbL
 aR0Cbk0oK+FbuJ/FS7kVm2UQLPkVxIZSp4d2mgcYntDbAnvxcAKU3AZ4kPtUO4pLO7R+
 NSvP7bYpJOZXR+jtrPGtwH/SHfDSQNrc28JOFX2oM0XzEhJqk+NCJWfd/YF4i7Ixtfq4
 OJxv1n2KJ/1RbC2QS6DxE2/0ewT4snlMj3mOOK6oBQqVKM2CmM9I7uOAdPPPKZBrjvet
 Rb0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlBuF1dTzmUuK5jy/fv/+vPhlCetUOkNkQlzKp9NF8ppiJYkI7Spk7mjXMByTK5/J8Xxji1Ug=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2Pfiq37uhdit8QgWhR71HaGKN61r0g346lCeWU2XPRxiqB+Pm
 UYEws3bijNsIKFmLOJem1z8yI4g7wzz16re5lPVBbaiFP8Wjvd0BTcvT9O+AYx0s9RR15iCBCVv
 OEyw1yFgY+ctHCYYmcxUTHBnowAwlmmWa/8AQbjE=
X-Gm-Gg: ASbGncsc48adcVDAm0TxpTaKP8Ol5V6A8Vtxfifdg2j8mfPToPSV4xREepjtLdqLGge
 9BVL9YIqCeP1grvItJn8Wka9PABuVEoIKQGhecMEFDkNdq74nv7aPGyJvkIBMS84He5JRBJS4Jn
 BiGnJYf7OYIdnbyNFLfpqnVr8BFQ4TcCmpLRmgCYs3wKEfPuABrY05ENpraIsBz5DaDQCzB4K/U
 2msbdy0Pltd/bb2nfZfQQ41IgA5gc6VM8PlFV9zb6SRT7EgXexDpe+oD8mQ44Us/ufQUUjqtFqZ
 siN8ygY=
X-Google-Smtp-Source: AGHT+IGQvVh9UoOEHlWJU9SvjkynEdksvaXndGWCrb8NYpzFDWt1sULsot7RUHmRJ8L5RRECEebPPBumYzIY6DBXXiM=
X-Received: by 2002:a05:6871:878f:b0:3e8:9837:dae7 with SMTP id
 586e51a60fabf-3e89837e3e1mr329925fac.51.1763205917372; Sat, 15 Nov 2025
 03:25:17 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SBxZ2-A9=akV3z4dNdzqUtq_Sq8pq7WvzVDtVub50cabg@mail.gmail.com>
In-Reply-To: <CAN7C2SBxZ2-A9=akV3z4dNdzqUtq_Sq8pq7WvzVDtVub50cabg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 15 Nov 2025 19:25:05 +0800
X-Gm-Features: AWmQ_bnBGSob0r9GSJ44g6L8bzPe1_mrfkmH5vU65RxbEA8l_q11R_v5gLLJA1c
Message-ID: <CAN7C2SCwonGW4uC7oqqWY85XBfA0iuJoCJ7oY3bzm1cfxmSOHQ@mail.gmail.com>
Subject: Re: [DEBUG] U-Boot SDRAM Calibration breaks and unstable
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> a) reset
> b) clock manager

Short investigation and test shown that the watchdog is the
root cause. (Not proved by code review just test run proposed)

This is not 100% sure but what is observed from the board boot via
terminal repetitively stop at SDRAM calibration.

Doing a cross-check from Altera SoCFPGA trunk shows a Kconfig
different.

After modified the Kconfig and select WDT and required driver.
The SDRAM calibration fail no longer triggered.
Power cycling and soft reset shows no issue.

Patch will be applied to fix this issue.

```
U-Boot 2026.01-rc2-00033-gbee3c63434db-dirty (Nov 15 2025 - 19:17:31 +0800)

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
```

Brian
