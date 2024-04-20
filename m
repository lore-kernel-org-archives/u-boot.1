Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219B1C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56511880F4;
	Sat, 20 Apr 2024 12:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9p+atwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C25881BC; Sat, 20 Apr 2024 12:56:57 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E60880F4
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 12:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4dab344ace5so758829e0c.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713610613; x=1714215413; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+LB0/rAUimCH5olywIOizrjY6eml0iOM368cqWb2mQ=;
 b=d9p+atwiNmbuRUe9jvKy+in1J4bWpgEsXiuX+rsABrZa542yVjsIfT3NmHsXpZvw0g
 /Wma1fmGWAFbyd/089QX9y/GDwRI6rx4m0LSjx79cFhXLjzGWWGJ4dOT7peKscmfLNdI
 GeFDZSboz0YoSo/w2uIJE+IbTKhxfZDr1arYKYIzkYUXnwF+wxF8p4L3VrIIeVGUuHfD
 Iddlw0czcEnTAHNnH1qR9E4aFaF5wQBu7vt7T1yesLyygMDKzL0lvkhceDuK/aUR4tz4
 7mnix32zEIP/DSrCzeFUQ9WsOXn6b8uRbCPbw8f8Dt0rkLUKtOCufdOuys9q8gGe+gra
 4x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713610613; x=1714215413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+LB0/rAUimCH5olywIOizrjY6eml0iOM368cqWb2mQ=;
 b=Xuc4i4XggUFjAINRSoKveKcpxIVsy8rYRKvTpYcGQaN3USkBp/sNO9bgOPd08MC3H2
 HOCU/ObkDneCZIZgd+LtLetYnyIiQDICXBDIXSXnnbNiUwxTxSV7BJ/DMPN1j+SFw2Zb
 fhiqCK8XYawA+73ZU9hO6UNkD7Wpn0fk8G0p70oVn5HkuRo13jvNnmeL9tiU8BYApZ2b
 wxGnASZsGncjWBlCjmDOmKuJUXeuTQprm5+LzwScY/vmaxoFru/Or2cYGo0bPhzVa2L9
 wQI6FV1PLSxfFSrSJ+YNGDvkNYmyz9yVFW6YN6MgJH1q8yVjPLbCM4zRQcdV2nEbbcdg
 l0eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYXkGMdKC/hAkFfJkMAZ/Wm4yJdNEA/7UzImzpHOJxg6zDuLOY2FrG9KPQJLXs+J48nWmw8xask9LpDRb46lxS/AuCw==
X-Gm-Message-State: AOJu0YxTf7WVx6lwdnGd0TjKe1XMqvGIgWCj8dq2eN4KNSiLEX2eXRiA
 XGkqQOangA+PjJs+YJm+uuJ47bPtmF5+B8uv6W7LefPFkG0LqpioLSJlUxqlluGmVqfCXg9KJ6j
 4/o9Stb/bhK6zB5y7FdCX/50frFo=
X-Google-Smtp-Source: AGHT+IEZ7Z8h16N4XWZUFWzpJDjFEgNBD9eGlWNB4F6703fEVl94xXBnq8bikuZtInlfyXd/oXB+Z/hgdPf9Am2dHvo=
X-Received: by 2002:a05:6122:222a:b0:4d3:3a8c:13ad with SMTP id
 bb42-20020a056122222a00b004d33a8c13admr5285300vkb.8.1713610613066; Sat, 20
 Apr 2024 03:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
 <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
 <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
 <f355e582-cb52-e4c5-538b-26bcf69f0a2c@gmail.com>
In-Reply-To: <f355e582-cb52-e4c5-538b-26bcf69f0a2c@gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 20 Apr 2024 03:56:41 -0700
Message-ID: <CANV2PTOzgyzYSbNRJXuvLnMDAT-mDL8o1tU7d72qTKQDMdt_Uw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: Bo Gan <ganboing@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 "rick@andestech.com" <rick@andestech.com>, 
 "ycliang@andestech.com" <ycliang@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 "duwe@suse.de" <duwe@suse.de>, "namcao@linutronix.de" <namcao@linutronix.de>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>,
 "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 19, 2024 at 5:51=E2=80=AFPM Bo Gan <ganboing@gmail.com> wrote:
>
...snip...
>
> If without the change (reverted), can you read/write the same SD media in=
 U-boot
> proper? (U-boot proper will switch BUS_ROOT to PLL2).

I tested again this change in commit e6b7aeef, before this change in
parent commit e6b7aeef~, af04f37a HEAD from today 19th Apr 2024 (which
due to not matching EEPROM product_id will be in the fall-through case
of board/starfive/visionfive2/spl.c), af04f37a with applied patchset
"board: starfive: add Milk-V Mars CM support" from 15th Apr 2024, and
af04f37a reverting changes from e6b7aeef also with applied patchset
"board: starfive: add Milk-V Mars CM support" from 15th Apr 2024.

In all builds is OpenSBI at commit d4d2582e HEAD from today 19 Apr 2024.

For each build tested per vendor Milk-V the Mars CM Lite (SD Card only
non-eMMC) has pinmux of GPIO22 instead of GPIO62:

-- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -233,7 +233,7 @@

        mmc0_pins: mmc0-pins {
                 mmc0-pins-rest {
-                       pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+                       pinmux =3D <GPIOMUX(22, GPOUT_SYS_SDIO0_RST,
                                              GPOEN_ENABLE, GPI_NONE)>;
                        bias-pull-up;
                        drive-strength =3D <12>;

U-Boot config is simply starfive_visionfive2_defconfig.

Results are as follows.

StarFive # mac
--------EEPROM INFO--------
Vendor : MILK-V
Product full SN: MARC-V10-2340-D004E000-000006DF
data version: 0x2
PCB revision: 0xc1
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:83:11
Ethernet MAC1 address: 6c:cf:39:00:83:12
--------EEPROM INFO--------

e6b7aeef: 2GB microSD (no speed class markings)
af04f37a: 2GB microSD (no speed class markings)
af04f37a with Mars CM patchset: 2GB microSD (no speed class markings)
StarFive # mmc rescan ; mmc info
unable to select a mode
unable to select a mode

e6b7aeef~: 2GB microSD (no speed class markings)
af04f37a revert e6b7aeef with Mars CM patchset: 2GB microSD (no speed
class markings)
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 1c
OEM: 5356
Name: USD
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 2.0
High Capacity: No
Capacity: 1.9 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

e6b7aeef: 8GB microSD Class 4
e6b7aeef~: 8GB microSD Class 4
af04f37a: 8GB microSD Class 4
af04f37a with Mars CM patchset: 8GB microSD Class 4
af04f37a revert e6b7aeef with Mars CM patchset: 8GB microSD Class 4
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 2
OEM: 544d
Name: SA08G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 7.4 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

e6b7aeef: 8GB microSD Class 10
e6b7aeef~: 8GB microSD Class 10
af04f37a: 8GB microSD Class 10
af04f37a with Mars CM patchset: 8GB microSD Class 10
af04f37a revert e6b7aeef with Mars CM patchset: 8GB microSD Class 10
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 74
OEM: 4a60
Name: USD
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 7.5 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

e6b7aeef: 32GB microSD Class 10 A1 U1 HC1
e6b7aeef~: 32GB microSD Class 10 A1 U1 HC1
af04f37a: 32GB microSD Class 10 A1 U1 HC1
af04f37a with Mars CM patchset: 32GB microSD Class 10 A1 U1 HC1
af04f37a revert e6b7aeef with Mars CM patchset: 32GB microSD Class 10 A1 U1=
 HC1
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 3
OEM: 5344
Name: SC32G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 29.7 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

e6b7aeef: 200GB microSD Class 10 A1 U1 XC1
e6b7aeef~: 200GB microSD Class 10 A1 U1 XC1
af04f37a: 200GB microSD Class 10 A1 U1 XC1
af04f37a with Mars CM patchset: 200GB microSD Class 10 A1 U1 XC1
af04f37a revert e6b7aeef with Mars CM patchset: 200GB microSD Class 10 A1 U=
1 XC1
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 3
OEM: 5344
Name: SC200
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 183.3 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

e6b7aeef: 256GB microSD Class U3 XC1
e6b7aeef~: 256GB microSD Class U3 XC1
af04f37a: 256GB microSD Class U3 XC1
af04f37a with Mars CM patchset: 256GB microSD Class U3 XC1
af04f37a revert e6b7aeef with Mars CM patchset: 256GB microSD Class U3 XC1
StarFive # mmc rescan ; mmc info
Device: mmc@16010000
Manufacturer ID: 1b
OEM: 534d
Name: GE4S5
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 238.8 GiB
Bus Width: 1-bit
Erase Group Size: 512 Bytes

> One potential problem I
> could think of is perhaps the SPL built is without SPL_PINCTRL_STARFIVE/J=
H7110
> or the u-boot dts is missing the pinctrl that properly sets drive-strengt=
h and
> other properties of the mmc0/1 pins. What dtb are you using? I tested thi=
s with
> visionfive2 and it's working fine. Can you share the tree/config you used=
 to
> built for Milk-V Mars CM Lite? I don't see the corresponding dts being ch=
ecked-
> in to u-boot tree, so it helps if you can share the code. Thanks!
>
> Bo

As described, this is upstream U-Boot. Does this 'mmc info' testing
help give some ideas to suggest?

-E
