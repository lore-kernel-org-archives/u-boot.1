Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F5C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 15:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528BC80E9A;
	Fri, 14 Jun 2024 17:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QEdNmqtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A2087E96; Fri, 14 Jun 2024 17:36:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6591D801BA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 17:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718379378; x=1718984178; i=xypron.glpk@gmx.de;
 bh=u2O70ndDJ2ctkMNZslpMFoQsOmTHiefUsAps3ylZAxU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QEdNmqtLpK8Mc+m/+VjbHFlEFNtAdiSrQOPKrSbu67Xei6M1dblFYzFTLY8BCqCX
 2ITQbeExiOG1PFk2B+kPc8FwwsSzd09RARSKCKMPhsiiYgdnf7cJ3u+PA3kvT+c7a
 ojizOOG3d8Uaxb/T99j7hRMsYphiIc1S6lecsO9ATizn0X2d8SR0AA7DaaMi7Vzti
 0/UVFAz5XxSN/F3k9tgcC1HMmo5aO2ZrtJsB2ua1GXPnBG0fXmT8rqeTCXdvJkw/N
 P5/BP3sv1dMUEmcg7L2HgyvfEnFfNVN5JL0aZNgd2yo/Vflaf6kimgenzLpIR/wHK
 dHDoliFFfBsPyron6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1seVD11YYL-00x8VP; Fri, 14
 Jun 2024 17:36:18 +0200
Message-ID: <251427a8-06b8-4443-adc9-04fc5287e3f6@gmx.de>
Date: Fri, 14 Jun 2024 17:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2024.07-rc4 issues on VisionFive v2
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
References: <20240614-condense-hastiness-8163da268f60@wendy>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240614-condense-hastiness-8163da268f60@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N37ehnTuMR6LICdEODarV/n4WChOKOk2kqR+wvMbQTaQBKb3+5F
 K8x1l0wJZqBztZqFJJyUY5ftH1Uyfurwa7Vg7XPOMYSL2wOd2sY66RJ4EDY3XQSbg25LZ05
 QHk3hLMp5XI2uUFDhpNTXl4Hk0Qm6TjXuR6QGW3XRUTXkFrMOI55nxW+e/jOuHACcO12d1t
 ON68QT4taFzG2Znl5HGpw==
UI-OutboundReport: notjunk:1;M01:P0:/Fh4E3W2jtQ=;3TQjy5Xlz7DZjP7rd7fkXZs37b2
 Do/YSOhqnuCs+7MGcsL4R3tAhhrHC6WT1y3RyKC9dAePgX/zHa6DdkixdCw50d5fiYvipTC2G
 GA/M5yD750hRW6eGG1xMBvXtIdTghd4KG6r7+jucFysXYlTPnbnDzMZ9Otz3rVAXMHYp1nrr6
 fZ5hsCdPR1xyyNmhZwWlNNpVjh9D0iR4hQniY5tOMbHDjMj0C20WzHn6cGxacMgdc1xRv379r
 Zo+HnJTfYs2yEP5A1ikXhFx9U2DUWTgyzVrdfDrATUjOz4hg7m/pvY9j7AT5pqVTsPY+Fg0Wu
 adN2TK5dQjjinygImE2Y5YgZeYOjzuku7RKK7VXEAd6wZqFnbTPNNi9GOWEBnVjrfYeHmp1sb
 B0nDYHiZMkQD0SD3FoZEBwupJXDWEFuy/cRnbPqBWRfm0ZVj9O79EopPzs/6tXdkFCELy1Sux
 x/3BjVGKqkzwlL6OF2r0E+HGiM8rM/hJfJzPZX8JeJ46DIRfoeSocnkc2NSY0AIj9hYTFxSS8
 JVvmf9phIAhJqpV8EvlwzyEN++M2cWuVqFplJS7sT0p+wj/GHrQGlW47KRaA049QyYCOZ6eig
 A+TL8XaT4vqM1A7Om3D4RLvA3egk2bt95cTqhyPXVBsbaV3WkcBG5wU8KZtTHxoO9dWcGHNdb
 eGudprPgO5fN3Sw72JsCfKvyXUmqhnWIbXE7P/6Vc2eMPkEGverQHmCRrjNhiSDGEZkUmUnxa
 m2dFhD4iEv7UFIaghDWSaxd+/4dmyN2WNe8l9mZrofNfdJJ3g91HGOQSeZFKUVWBg2VCjMt8L
 /e6ECIF1SBafT158hIFmbSkyG/aXB4v88zvUVCwcWPjT8=
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

On 14.06.24 13:14, Conor Dooley wrote:
> Hey,
>
> After going from Vendor SPL/OpenSBI/U-Boot to OpenSBI v1.4++ plus
> v2024.07-rc4 SPL/U-Boot I ran into a boot loop problem relating to
> PCI:
> 	U-Boot 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
>
> 	CPU:   sifive,u74-mc
> 	Model: StarFive VisionFive 2 v1.2A
> 	DRAM:  4 GiB
> 	Core:  136 devices, 26 uclasses, devicetree: board
> 	WDT:   Not starting watchdog@13070000
> 	MMC:   mmc@16010000: 0, mmc@16020000: 1
> 	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page s=
ize 256 Bytes, erase size 4 KiB, total 16 MiB
> 	OK
> 	StarFive EEPROM format v2
>
> 	--------EEPROM INFO--------
> 	Vendor : StarFive Technology Co., Ltd.
> 	Product full SN: VF7110A1-2249-D004E000-00000540
> 	data version: 0x2
> 	PCB revision: 0xa1
> 	BOM revision: A
> 	Ethernet MAC0 address: 6c:cf:39:00:17:95
> 	Ethernet MAC1 address: 6c:cf:39:00:17:96
> 	--------EEPROM INFO--------
>
> 	starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> 	starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> 	In:    serial@10000000
> 	Out:   serial@10000000
> 	Err:   serial@10000000
> 	Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> 	starting USB...
> 	Bus xhci_pci: Register 5000420 NbrPorts 5
> 	Starting the controller
> 	USB XHCI 1.00
> 	scanning bus xhci_pci for devices...
> 	U-Boot SPL 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
> 	DDR version: dc2e84f0.
> 	Trying to boot from SPI
>
> This only appeared after I refreshed the environment by running.
> `env default -a -f; env save`. Before that things worked "fine", I
> suppose because nothing actually touched PCI. I've just disabled
> PCI for now and things are working once more. I've not attempted
> to bisect/debug this, cos that's not the fastest process while
> running U-Boot out of flash.

You could boot from SD-card to read the SPI flash and checksum it.

>
> In case it is relevant, the board I have is one of the "super early
> bird" ones.
>
> Cheers,
> Conor.

I am not able to reproduce this on my v1.2A board. (1.2B according to
silk screen).

starting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... 2 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found

StarFive # usb tree
USB device tree:
   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 100mA)
         USB2.0 Hub

StarFive # pci
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1556     0x1111     Bridge device           0x04
01.00.00   0x1106     0x3483     Serial bus controller   0x03
02.00.00   0x1556     0x1111     Bridge device           0x04
03.00.00   0x15b7     0x5009     Mass storage controller 0x08

I tested both with and without NVMe drive while booting from SD-card.

Best regards

Heinrich
