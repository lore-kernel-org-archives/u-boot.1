Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B54CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE65086E40;
	Wed, 18 Oct 2023 05:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052BA86F15; Wed, 18 Oct 2023 05:47:02 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id 3B12686F21
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id C87747F98;
 Wed, 18 Oct 2023 11:46:55 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 11:46:56 +0800
Received: from [192.168.125.85] (172.16.6.8) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 11:46:54 +0800
Message-ID: <2a9821ea-68aa-4997-8779-b2e374627a0e@starfivetech.com>
Date: Wed, 18 Oct 2023 11:46:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER
 event
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Bin Meng <bmeng.cn@gmail.com>
CC: <u-boot@lists.denx.de>
References: <20231017062016.51682-1-minda.chen@starfivetech.com>
 <aa649c6d-5992-492a-bd39-d1f4389e773f@denx.de>
 <2313a5f6-30a2-46ed-923f-a6f8699452c6@starfivetech.com>
 <55da21fd-2a9b-4b48-a0bb-d8f07ad362ea@denx.de>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <55da21fd-2a9b-4b48-a0bb-d8f07ad362ea@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [172.16.6.8]
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX171.cuchost.com
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



On 2023/10/18 10:35, Marek Vasut wrote:
> On 10/18/23 03:22, Minda Chen wrote:
>>
>>
>> On 2023/10/17 19:20, Marek Vasut wrote:
>>> On 10/17/23 08:20, Minda Chen wrote:
>>>> xhci_wait_for_event() waiting TRB_TRANSFER event may return
>>>> NULL. Checking the return value to avoid crash.
>>>>
>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>
>>> How did you trigger this error ? Is there a reproducer ? Details plea=
se ...
>>
>> While Scanning a lenovo usb2.0 udisk=EF=BC=8C not 100 % reproduce
>=20
> Can you include Linux
>=20
> lsusb -vvv
>=20
> output for this device and include that information in the commit messa=
ge ? (or the U-Boot info below, that works too, just please add it into t=
he commit message, it is important for future reference).
>=20
OK=EF=BC=8C I will add lsusb -vvv Linux udisk message and crash dump info=
 to commit message
>> This is log.
>>
>> StarFive # usb reset
>> resetting USB...
>> Bus xhci_pci: Register 5000420 NbrPorts 5
>> Starting the controller
>> USB XHCI 1.00
>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing UR=
B anyway.
>> Unexpected XHCI event TRB, skipping... (f77141f0 00000000 13000000 020=
08401)
>> Unhandled exception: Load access fault
>> EPC: 00000000f7f563c6 RA: 00000000f7f563c6 TVAL: 000000000000000c
>> EPC: 000000004024a3c6 RA: 000000004024a3c6 reloc adjusted
>=20
> Where does the crash point to in code, can you disassemble the PC point=
er ? (or maybe you can use scripts/decodecode I think)
>=20
OK=EF=BC=8C I will add EPC pointer disassemble  to commit message
>> SP:=C2=A0 00000000f76f9a60 GP:=C2=A0 00000000f76fbdd0 TP:=C2=A0 000000=
0000000001
>> T0:=C2=A0 00000000f76fa168 T1:=C2=A0 00000000000000ff T2:=C2=A0 000000=
0000000016
>> S0:=C2=A0 00000000f7712fc0 S1:=C2=A0 00000000f76fb100 A0:=C2=A0 000000=
0000000000
>> A1:=C2=A0 0000000000000000 A2:=C2=A0 00000000f77145d0 A3:=C2=A0 000000=
00f7714590
>> A4:=C2=A0 0000000000000000 A5:=C2=A0 0000000000000020 A6:=C2=A0 000000=
000000000f
>> A7:=C2=A0 0000000000000100 S2:=C2=A0 0000000000000000 S3:=C2=A0 000000=
0000000000
>> S4:=C2=A0 00000000f7717050 S5:=C2=A0 00000000f7717050 S6:=C2=A0 000000=
0080000383
>> S7:=C2=A0 00000000f76f9dc0 S8:=C2=A0 00000000000000ff S9:=C2=A0 000000=
0000000001
>> S10: 00000000f76f9ba0 S11: 0000000000010c04 T3:=C2=A0 0000000000000010
>> T4:=C2=A0 0000000000000006 T5:=C2=A0 0000000000000080 T6:=C2=A0 000000=
00f76fa231
>=20
> [...]
>=20
>> 3: Mass Storage,=C2=A0 USB Revision 2.0
>> =C2=A0 - Generic Mass Storage 31097778XB15113405
>> =C2=A0 - Class: (from Interface) Mass Storage
>> =C2=A0 - PacketSize: 64=C2=A0 Configurations: 1
>> =C2=A0 - Vendor: 0x17ef=C2=A0 Product 0x38ac Version 1.0
>> =C2=A0=C2=A0=C2=A0 Configuration: 1
>> =C2=A0=C2=A0=C2=A0 - Interfaces: 1 Bus Powered 200mA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Interface: 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Alternate Setting 0, Endpoints: 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Class Mass Storage, Transp. SCSI, Bul=
k only
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Endpoint 1 Out Bulk MaxPacket 512
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Endpoint 2 In Bulk MaxPacket 512
>>
>> StarFive # usb storage
>> =C2=A0=C2=A0 Device 0: Vendor:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Rev: 8.07 Prod: Lenovo SX1 64G
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Type: Removable Hard Disk
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Capacity: 60000.0 MB =3D 58.5 GB (122880000 x 512)
>=20
> [...]
