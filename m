Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44A1C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 08:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC30487D16;
	Thu,  8 Feb 2024 09:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OXK+x+hK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAF287D16; Thu,  8 Feb 2024 09:27:33 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCA5877D0
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 09:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc745927098so168785276.3
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 00:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707380848; x=1707985648; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RMnHPM8sCpAlGKvRY2Qbz/ArUpX5xkJx79yASSfKjBI=;
 b=OXK+x+hKDS/i5RJCxz/g1yCOrPyv+Q3DnywNbtWJdKSSbgWxyhgHevdajrpI2RPI3s
 SW8E4zWab+vq1YP2NH4sHfD7flIYb3kF+m1ZaVDRlOKjj3zL7H4GdFz3dY+oa6UbzE5l
 +9EZQInyAtKSMG6gjp8C3HNoh6DF5S8kzsNvOgvXfL4GyP79U8/FlusPvZdkaM+KU0gf
 e72B065iIUhCdUBrJA1bQiXZ/LP3kVRZRh6/D62KaoDLW+gYf9SpZtpEbvoQZ81WtSND
 Ta/BqZOakM1QkIkGq7Ts5/BTBwbEe5778ZKdPr1boomgh6R6SBVTOQMbPt9VEVe1R/3S
 d7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707380848; x=1707985648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RMnHPM8sCpAlGKvRY2Qbz/ArUpX5xkJx79yASSfKjBI=;
 b=N9hTMprDS+i9lAxCODckS5HuBWHBtIsuwyG2Dxfq95hEsoaOtgOgTNtTcPrV+qDpq2
 vmTe7DLOcZtM7VRENVjWNb4h1vbtTlkL52t4U9t2QI6IHTF+9ZDXB3uwY+A3vW3hk6zC
 uqAnZWA+f+11TIXpJJ5Re9dXd+/5qoJuulYzlCfySSqc1XwvK2z2YGh0zumNYhNwW0Ut
 X3iQ4a652613NrXUA6K/j5YUrEYaUN38GcUMy4opgXWnpQz6qcbTXzXJafJWacr15Bcg
 Ko9sNdN34Pn42qT+C4QDA3c/SX+pS1XIdz1XN7aM3MvupKddXrsVeUc+koGtmE0aJtat
 y3vQ==
X-Gm-Message-State: AOJu0YxgPHCeZYKxjK2SmEpcBCepHQHGZ+VUYTuAJ91PPtlLJaalUYHy
 P/fuaBJfJA5E1xuwyoIxuXBfZCtIz9QoPHfqy372cKQsfK2MjI8k9lUiixCA20Vg/X0Bc1WmZLC
 0FJYNNInGgR8ulhGyRUwtvdYYWWSblZiBR/i3tg==
X-Google-Smtp-Source: AGHT+IHcuakGUrAF4YBiKxUzn7qcdm0epVrg4DhyQAgfaEvEIyZ96qc/1LlwR2CK3nA3L9I1a5z0lkQWWmE1EyiLmDA=
X-Received: by 2002:a25:fc18:0:b0:dbd:4883:44ce with SMTP id
 v24-20020a25fc18000000b00dbd488344cemr7096862ybd.32.1707380848399; Thu, 08
 Feb 2024 00:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
 <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
 <CACRpkdaiYgmzjsX8SPMFOFo=iK19s2y8Uuaysc+46Ba7D1PFBg@mail.gmail.com>
 <CAD5A3Csm_sx4TBHQaADSMFgSqoF=aBZD2jm4_cmzNaonZJqAoQ@mail.gmail.com>
In-Reply-To: <CAD5A3Csm_sx4TBHQaADSMFgSqoF=aBZD2jm4_cmzNaonZJqAoQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 09:27:16 +0100
Message-ID: <CACRpkdbhM6-JoWN6CbLpx_z+vzyx4hBdxqzB=iQ0G9MPa4r5+w@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Ole Orhagen <ole.orhagen@northern.tech>
Cc: Kristian Amlie <kristian.amlie@northern.tech>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Feb 5, 2024 at 9:18=E2=80=AFAM Ole Orhagen <ole.orhagen@northern.te=
ch>
wrote:

>
> But I will try to dust it off and test it again.
>>
>
> Did you get any results from the tests?
>


Yes!

It works fine both before and after the patch. Latest log from
the actual hardware:

Cmd> usb_on
Enabling debug USB...

(here I copy over the binary to the internal SD-card which is
presented over USB mass storage)

Cmd> reboot

Powering up system...
Daughterboard fitted to site 1.

Switching on ATXPSU...
ATX3V3: ON
VIOset: 1.8V
MBtemp: 29 degC

Configuring motherboard (rev D, var A)...
IOFPGA  config: PASSED
MUXFPGA config: PASSED
OSC CLK config: PASSED
Programming image \SOFTWARE\boot-a9.bin
Erasing Flash image boot.bin
...
Erasing Flash
...
Writing Flash
.....
Updating eeprom with image boot.bin
Image: boot.bin UPDATED from \SOFTWARE\boot-a9.bin

Testing SMC devices (FPGA build 8)...
SRAM 32MB test: PASSED
VRAM  8MB test: PASSED
LAN9118   test: PASSED
USB & OTG test: PASSED
KMI1/KMI2 test: PASSED
MMC & SD  test: PASSED
DVI image test: PASSED
AACI AC97 test: PASSED
CF card   test: PASSED
UART port test: PASSED
MAC addrs test: PASSED

Reading Site 1 Board File \SITE1\HBI0191B\board.txt
DB1 JTAG configuration complete.
Setting DB1 OSCCLKS...
DB1.0 DCC 0 SPI configuration complete.

Writing SCC 0x40610000 with 0xBB8A802A
Writing SCC 0x40610001 with 0x00001F09
Writing SCC 0x40610002 with 0x00000000
DB1.0 DCC 0 SCC configuration complete.

DB SMB clock enabled.
Waiting for SITE1 CB_READY...
Testing SMB clock...
Configuring MUXFPGA for DB1.
Setting DVI mode for XGA.
Releasing Daughterboard resets.
Switching MCC log to UART1.

ARM Versatile Express Boot Monitor
Version:    V5.2.1
Build Date: Apr  4 2013
Daughterboard Site 1: V2P-CA9 Cortex A9
Daughterboard Site 2: Not Used
Running boot script from flash - BOOTSCRIPT


U-Boot 2024.04-rc1-00101-g0101a2ffe125 (Feb 08 2024 - 09:21:31 +0100)

DRAM:  512 MiB (effective 1 GiB)
WARNING: Caches not enabled
Core:  22 devices, 11 uclasses, devicetree: embed
Flash: 128 MiB
MMC:   mmci@5000: 0
Loading Environment from Flash... OK
In:    uart@9000
Out:   uart@9000
Err:   uart@9000
Net:   eth0: ethernet@3,02000000
Hit any key to stop autoboot:  0
smc911x: detected LAN9118 controller
smc911x: phy initialized
smc911x: MAC 00:02:f7:00:3c:9d
Using ethernet@3,02000000 device
TFTP from server 192.168.1.140; our IP address is 192.168.1.35
Filename 'zImage'.
Load address: 0x62000000
Loading: smc911x: MAC 00:02:f7:00:3c:9d

Yours,
Linus Walleij
