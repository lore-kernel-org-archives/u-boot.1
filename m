Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB9FCDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 01:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAE186F01;
	Wed, 18 Oct 2023 03:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3874586E14; Wed, 18 Oct 2023 03:22:33 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id C2C3986EE0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 03:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id 419DD24E050;
 Wed, 18 Oct 2023 09:22:26 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 09:22:26 +0800
Received: from [192.168.125.85] (183.27.98.194) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 09:22:25 +0800
Message-ID: <2313a5f6-30a2-46ed-923f-a6f8699452c6@starfivetech.com>
Date: Wed, 18 Oct 2023 09:22:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER
 event
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Bin Meng <bmeng.cn@gmail.com>
CC: <u-boot@lists.denx.de>
References: <20231017062016.51682-1-minda.chen@starfivetech.com>
 <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
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



On 2023/10/17 19:20, Marek Vasut wrote:
> On 10/17/23 08:20, Minda Chen wrote:
>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>> NULL. Checking the return value to avoid crash.
>>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>=20
> How did you trigger this error ? Is there a reproducer ? Details please=
 ...

While Scanning a lenovo usb2.0 udisk=EF=BC=8C not 100 % reproduce

This is log.

StarFive # usb reset
resetting USB...
Bus xhci_pci: Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
scanning bus xhci_pci for devices... WARN halted endpoint, queueing URB a=
nyway.
Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 020084=
01)
Unhandled exception: Load access fault
EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted

SP:  00000000f76f9a60 GP:  00000000f76fbdd0 TP:  0000000000000001
T0:  00000000f76fa168 T1:  00000000000000ff T2:  0000000000000016
S0:  00000000f7712fc0 S1:  00000000f76fb100 A0:  0000000000000000
A1:  0000000000000000 A2:  00000000f77145d0 A3:  00000000f7714590
A4:  0000000000000000 A5:  0000000000000020 A6:  000000000000000f
A7:  0000000000000100 S2:  0000000000000000 S3:  0000000000000000
S4:  00000000f7717050 S5:  00000000f7717050 S6:  0000000080000383
S7:  00000000f76f9dc0 S8:  00000000000000ff S9:  0000000000000001
S10: 00000000f76f9ba0 S11: 0000000000010c04 T3:  0000000000000010
T4:  0000000000000006 T5:  0000000000000080 T6:  00000000f76fa231

Code: 842a f0ef d75f 0593 0200 8522 f0ef ebdf (455c)=20


This is USB info and storage info=20

StarFive #=20
1: Hub,  USB Revision 3.0
 - U-Boot XHCI Host Controller=20
 - Class: Hub
 - PacketSize: 512  Configurations: 1
 - Vendor: 0x0000  Product 0x0000 Version 1.0
   Configuration: 1
   - Interfaces: 1 Self Powered 0mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 8 Interval 255ms

2: Hub,  USB Revision 2.10
 -  USB2.0 Hub=20
 - Class: Hub
 - PacketSize: 64  Configurations: 1
 - Vendor: 0x2109  Product 0x3431 Version 4.32
   Configuration: 1
   - Interfaces: 1 Self Powered Remote Wakeup 100mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 1
     - Class Hub
     - Endpoint 1 In Interrupt MaxPacket 1 Interval 12ms

3: Mass Storage,  USB Revision 2.0
 - Generic Mass Storage 31097778XB15113405
 - Class: (from Interface) Mass Storage
 - PacketSize: 64  Configurations: 1
 - Vendor: 0x17ef  Product 0x38ac Version 1.0
   Configuration: 1
   - Interfaces: 1 Bus Powered 200mA
     Interface: 0
     - Alternate Setting 0, Endpoints: 2
     - Class Mass Storage, Transp. SCSI, Bulk only
     - Endpoint 1 Out Bulk MaxPacket 512
     - Endpoint 2 In Bulk MaxPacket 512

StarFive # usb storage
  Device 0: Vendor:          Rev: 8.07 Prod: Lenovo SX1 64G =20
            Type: Removable Hard Disk
            Capacity: 60000.0 MB =3D 58.5 GB (122880000 x 512)
StarFive #=20
