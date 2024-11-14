Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6070D41C3A
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 04:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D06895B4;
	Thu, 14 Nov 2024 05:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQdpH7tS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DE8895B7; Thu, 14 Nov 2024 05:42:31 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D10389587
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 05:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa3a79d4d59so5280266b.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731559349; x=1732164149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wSg/PAp9AVeyaonloU4LD91CCKq0MPSLngfn7h8nUT8=;
 b=GQdpH7tS/LTECnuOdqSXNtnBMeW+OMJvenxg5NdHo9em+BsczfIFMBg44cykQs/rVQ
 QQdlPN6O3UgzqRZlahzcS4dOIhe8ueORI1qtO7pwkUeKCarSuT2SpqqmUvEgnQ2HYV8L
 LdN2u9iuUUdeNeCMiqY4pJrbOua54ZfiZEYzQkgtCTp+C5xSwgAZio7kym/a3vKhRlfu
 +Epp3vCFG0lIoNnI/cFdw/OuyIzANZwRwBv7FTtjpBbwkxfl1SP6U0o7+3PkSRBPYfpf
 ptYaYK1eoXRiHSLg/aI0W+f4bkFXObkIK0W4bNcJ2BNXx1EujVnMcZTZpnkK5y4YUylG
 oIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731559349; x=1732164149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSg/PAp9AVeyaonloU4LD91CCKq0MPSLngfn7h8nUT8=;
 b=Rj/UcN6+mw/zE1YnJb7gTqBut8tI8+lDFYAG05EFlrxUomKSGTJpgGnx1mOJJluKxo
 34e82brTE7/RAGnc9rPjO3y3XppNjiGNnXq+qFMeC/135jB8D9QYo5tHb6RFMwNKm6qQ
 2KhgzjoWQR2G7kG28XzPTHGP6Iy00VJCFxPh6p0h3BCk4bIB1uORfkxod2mqvX+iLIWk
 Ew296/LiXcJT3gSMppm2evEmjOgB3OO9ItwfbxdECMs2krhHejJLHL4PY3A0CR12ObPr
 T1Fcq7wAAXZFhUS12JENnycBWhbm302XCtQ14bU8Hf4jrQDdSppy4h3T0scBBH6K5Y+p
 /cOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOfSmmjjB3nGxn6LwbFNwglhFVRnrsyLL1CPT/zwvnRvt//y3Sa8GSV/5DdFfNTMSF3QKiXFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzWsauJ79+thwShf+2Don4non2zo5a8O11aTk0CuxbI5HRcMX11
 evlZD1mJpvUmYC/NegwGhQRlEyyhMuFGmh6RH8yViSz5W+zRBEFXMHaSV6/lTliZFFG08JPnvkc
 NM4IFt182gpKWPo5MjxTmuMSL3zU=
X-Google-Smtp-Source: AGHT+IEPRf7jrQZjb+kvp9B2T9dhizzLFeZMhSYqzBe1XSj0BDR0tquhBSuzUIunKT6ZFg6BMpQohTtAVP+/bhPQhAk=
X-Received: by 2002:a17:907:1c11:b0:a9e:82d2:3168 with SMTP id
 a640c23a62f3a-a9eefff1525mr2084086966b.46.1731559348412; Wed, 13 Nov 2024
 20:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 14 Nov 2024 10:12:12 +0530
Message-ID: <CANAwSgSDjcDU-BUm7fNGC+GzaCTVVitL_jG6t0QQR0kM70Mfyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi Hal,

On Mon, 11 Nov 2024 at 07:53, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
> All the JH7110 based boards can use the DT from upstreaming linux kernel.
> The v1.3b board device tree is set as the default device tree. Support
> CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
> EEPROM information.
>

I am encountering an issue with my Milk-V CM. I am unable to use the
SD card with the CM4 IO board.
The onboard SPI switch does not support a boot configuration switch,
so the default boot is set to eMMC.

Please suggest a method to flash an image onto the eMMC on the CM board.

I have tried the instructions to update the firmware using
[1] https://milkv.io/docs/mars/compute-module/boot

Thank you so much for your help.

Thanks
-Anand

--------EEPROM INFO--------
Vendor : MILK-V
Product full SN: MARC-V10-2340-D004E016-00000812
data version: 0x2
PCB revision: 0xc1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:85:6b
Ethernet MAC1 address: 6c:cf:39:00:85:6c
--------EEPROM INFO--------

starfive_7110_pcie pcie@940000000: Starfive PCIe bus probed.
starfive_7110_pcie pcie@9c0000000: Starfive PCIe bus probed.
In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   Could not fetch index
Could not fetch index
eqos_probe_resources() failed: -22
Could not fetch index
eqos_probe_resources() failed: -22
eth1: ethernet@16040000
starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... Resetting EP 0...
3 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
Working FDT set to ff725a10
Hit any key to stop autoboot:  0
StarFive # mmc info
Device: mmc@16010000
Manufacturer ID: 15
OEM: 0
Name: AJTD4R
Bus Speed: 45333334
Mode: MMC High Speed (52MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 14.6 GiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 14.6 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected
StarFive # mmc rescan
StarFive # mmc rescan
StarFive #
StarFive # mmc part
## Unknown partition table type 0
