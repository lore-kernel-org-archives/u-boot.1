Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21CEE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774C88951B;
	Thu,  5 Dec 2024 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rohde-schwarz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FB9807F4; Thu,  5 Dec 2024 11:29:50 +0100 (CET)
Received: from mail02.rohde-schwarz.com (mail02.rohde-schwarz.com
 [80.246.32.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7858916E
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 11:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rohde-schwarz.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dominik.wernberger@rohde-schwarz.com
Received: from securemail-mu-h4.rohde-schwarz.com (10.0.19.146) by
 mail02.rohde-schwarz.com (172.21.64.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 5 Dec 2024 11:29:46 +0100
Subject: RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
MIME-Version: 1.0
Received: from GMU452.rsint.net ([10.0.225.105])
 by gmu812.rsint.net (Totemo SMTP Server) with SMTP ID 55;
 Thu, 5 Dec 2024 10:29:46 +0000 (GMT)
Received: from GMU505.rsint.net (10.0.225.37) by GMU452.rsint.net
 (10.0.225.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Dec
 2024 11:29:46 +0100
Received: from GMU503.rsint.net (10.0.225.35) by GMU505.rsint.net
 (10.0.225.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Dec
 2024 11:29:44 +0100
Received: from GMU503.rsint.net ([fe80::957e:76:e488:c60d]) by
 GMU503.rsint.net ([fe80::957e:76:e488:c60d%4]) with mapi id 15.02.1258.034;
 Thu, 5 Dec 2024 11:29:44 +0100
From: Dominik Wernberger <dominik.wernberger@rohde-schwarz.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "Simek, Michal" <michal.simek@amd.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "vigneshr@ti.com" <vigneshr@ti.com>
Thread-Index: AQHbRXsBTPOsIZkzX0+IzpDqBwarvrLUceCggAKkPICAAFTigA==
Date: Thu, 5 Dec 2024 10:29:44 +0000
Message-ID: <a28aea4246294415aa83ec8ebd21c697@rohde-schwarz.com>
References: <db4086b015cc48f2ad9d9bfe97b338d9@rohde-schwarz.com>
 <SA1PR12MB8697341C5E1388097FD7BEB198362@SA1PR12MB8697.namprd12.prod.outlook.com>
 <a76c728a613d48c9b7ba9d1b0059b013@rohde-schwarz.com>
 <SA1PR12MB86978FF17D7727A821B0381D98302@SA1PR12MB8697.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB86978FF17D7727A821B0381D98302@SA1PR12MB8697.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.9.40]
X-IQAV: YES
thread-topic: RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues
 /cr/
X-rus_sensitivity: 20
msip_labels: MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Enabled=true;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SetDate=2024-12-05T11:29:45Z;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Method=Privileged;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_Name=COMPANY RESTRICTED -
 BUSINESS USE;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_SiteId=74bddbd9-705c-456e-aabd-99beb719a2b2;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ActionId=6120cf0a-b2bc-438e-8b4b-106b503b180c;
 MSIP_Label_ae9ac9c2-fcd2-4d0b-8613-b7f540967ed5_ContentBits=1
X-GBS-PROC: IpRT1ZRqwE39V7vTte9LV5LerUM2DsmPSiWqplELFPLAQJuI8o7qiEl5I1biWj6JgGjoAXXNICzxaKU+84B2sRGFhJwFkAcg7FvFJ9nP6Qo3QpxlgLu4RMPJrno6zBKg
X-GBS-PROCJOB: 8pILBwVkttT+b4l8w187zLc6YwKw7k9gGkYPqVyNLuY5L88N+jCFUffCwETiRjuc
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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

Hi Venkatesh,

I applied your attached patch to v2025.01-rc3 (commit 3073246d1be682071d8b3=
d07d06c2484907aed60)
and confirm that your patch resolves my Flash erase issue. The following co=
mmands now work correctly.

sf probe
sf test 0 100000

Just for clarification, were you able to reproduce the original issue on yo=
ur side?

Thank you very much!

Best Regards

Dominik

From: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
Sent: Thursday, December 5, 2024 6:46 AM
To: Wernberger Dominik (1GS4) <dominik.wernberger@rohde-schwarz.com>
Cc: git (AMD-Xilinx) <git@amd.com>; jagan@amarulasolutions.com; Simek, Mich=
al <michal.simek@amd.com>; trini@konsulko.com; u-boot@lists.denx.de; vignes=
hr@ti.com
Subject: *EXT* RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issue=
s

Hi Dominik,
I have tried on the zc706 board and didn=E2=80=99t see any issues with the =
parallel configuration.
This is the upstream commit f96e5133184aac377b54bd61f8abf78710f2ee56 + patc=
h attached
Zynq> sf probe 0 0 0
SF: Detected n25q512ax3 with page size 512 Bytes, erase size 128 KiB, total=
 128 MiB
Verified with the below tests and didn=E2=80=99t see any issue.
Log:
U-Boot 2025.01-rc3-00046-gf96e5133184a-dirty (Dec 04 2024 - 19:50:42 +0530)

CPU:   Zynq 7z045
Silicon: v3.1
Model: Xilinx ZC706 board
DRAM:  ECC disabled 1 GiB
jedec_spi_nor flash@0: has no valid 'reg' property (0)
Core:  31 devices, 19 uclasses, devicetree: board
Flash: 0 Bytes
NAND:  0 MiB
MMC:   mmc@e0100000: 0
Loading Environment from nowhere... OK
In:    serial@e0001000
Out:   serial@e0001000
Err:   serial@e0001000
Net:
ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id

Warning: ethernet@e000b000 (eth0) using random MAC address - b6:69:a8:60:e2=
:de
eth0: ethernet@e000b000
Hit any key to stop autoboot:  0
Zynq> sf probe 0 0 0
SF: Detected n25q512ax3 with page size 512 Bytes, erase size 128 KiB, total=
 128 MiB
Zynq> time sf erase 0x0 0x2000000;mw.b 0x8000 aabbccdd 0x2000000;time sf wr=
ite 0x8000 0x0 0x2000000;mw.b 0x8008000 0x0 0x2000000;time sf read 0x800800=
0 0x0 0x2000000;cmp.b 0x8000 0x8008000 0x2000000
SF: 33554432 bytes @ 0x0 Erased: OK

time: 3 minutes, 37.604 seconds
device 0 offset 0x0, size 0x2000000
SF: 33554432 bytes @ 0x0 Written: OK

time: 47.074 seconds
device 0 offset 0x0, size 0x2000000
SF: 33554432 bytes @ 0x0 Read: OK

time: 5.411 seconds
Total of 33554432 byte(s) were the same
Zynq> time sf erase 0x0 0x4000000; mw.b 0x10000000 dd 0x4000000; time sf wr=
ite 0x10000000 0x0 0x4000000; mw.b 0x20000000 0x0 0x4000000; time sf read 0=
x20000000 0x0 0x4000000; cmp.b 0x10000000 0x20000000 0x4000000
SF: 67108864 bytes @ 0x0 Erased: OK

time: 6 minutes, 45.941 seconds
device 0 offset 0x0, size 0x4000000
SF: 67108864 bytes @ 0x0 Written: OK

time: 1 minutes, 34.443 seconds
device 0 offset 0x0, size 0x4000000
SF: 67108864 bytes @ 0x0 Read: OK

time: 10.821 seconds
Total of 67108864 byte(s) were the same
Zynq> time sf erase 0x0 0x8000000;mw.b 0x8000 aabbccdd 0x8000000;time sf wr=
ite 0x8000 0x0 0x8000000;mw.b 0x8008000 0x0 0x8000000;time sf read 0x800800=
0 0x0 0x8000000;cmp.b 0x8000 0x8008000 0x8000000
SF: 134217728 bytes @ 0x0 Erased: OK

time: 12 minutes, 50.601 seconds
device 0 whole chip
SF: 134217728 bytes @ 0x0 Written: OK

time: 3 minutes, 6.852 seconds
device 0 whole chip
SF: 134217728 bytes @ 0x0 Read: OK

time: 21.643 seconds
Total of 134217728 byte(s) were the same
Zynq>

Let me know if you have any questions.

Thanks
Venkatesh

From: Dominik Wernberger <dominik.wernberger@rohde-schwarz.com<mailto:domin=
ik.wernberger@rohde-schwarz.com>>
Sent: Tuesday, December 3, 2024 5:57 PM
To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com<mailto:venkatesh.abbara=
pu@amd.com>>
Cc: git (AMD-Xilinx) <git@amd.com<mailto:git@amd.com>>; jagan@amarulasoluti=
ons.com<mailto:jagan@amarulasolutions.com>; Simek, Michal <michal.simek@amd=
.com<mailto:michal.simek@amd.com>>; trini@konsulko.com<mailto:trini@konsulk=
o.com>; u-boot@lists.denx.de<mailto:u-boot@lists.denx.de>; vigneshr@ti.com<=
mailto:vigneshr@ti.com>
Subject: RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues

Hi Venkatesh,

Thanks for such a fast response.

Running =E2=80=98sf probe=E2=80=99 gives:
Flash: SF: Detected n25q256a with page size 512 Bytes, erase size 128 KiB, =
total 128 MiB

To be correct we use 2x MT25QL256ABA1EW9 [1, 2] which is basically the same=
 as the n25q256a reported by sf.
In defconfig I=E2=80=99ve specified CONFIG_ENV_SECT_SIZE=3D0x00040000 which=
 is divided by 2 in parallel memories
logic [3], resulting in the 128 KiB per Flash chip.

If you need any further information, please let me know.

[1] https://www.micron.com/products/storage/nor-flash/serial-nor/part-catal=
og/part-detail/mt25ql256aba1ew9-0sit
[2] https://xonstorage.blob.core.windows.net/pdf/micron_mt25ql256aba1ew90si=
t_apr22_xonlink.pdf
[3] https://lore.kernel.org/all/20240926045508.1492638-3-venkatesh.abbarapu=
@amd.com/

BR
Dominik

From: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com<mailto:venkatesh.abba=
rapu@amd.com>>
Sent: Tuesday, December 3, 2024 1:01 PM
To: Wernberger Dominik (1GS4) <dominik.wernberger@rohde-schwarz.com<mailto:=
dominik.wernberger@rohde-schwarz.com>>
Cc: git (AMD-Xilinx) <git@amd.com<mailto:git@amd.com>>; jagan@amarulasoluti=
ons.com<mailto:jagan@amarulasolutions.com>; Simek, Michal <michal.simek@amd=
.com<mailto:michal.simek@amd.com>>; trini@konsulko.com<mailto:trini@konsulk=
o.com>; u-boot@lists.denx.de<mailto:u-boot@lists.denx.de>; vigneshr@ti.com<=
mailto:vigneshr@ti.com>
Subject: *EXT* RE: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issue=
s

Hi Dominik,
Could you please let me know the details of the flash? I will check from my=
 side.

Thanks
Venkatesh
From: Dominik Wernberger <dominik.wernberger@rohde-schwarz.com<mailto:domin=
ik.wernberger@rohde-schwarz.com>>
Sent: Tuesday, December 3, 2024 5:21 PM
To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com<mailto:venkatesh.abbara=
pu@amd.com>>
Cc: git (AMD-Xilinx) <git@amd.com<mailto:git@amd.com>>; jagan@amarulasoluti=
ons.com<mailto:jagan@amarulasolutions.com>; Simek, Michal <michal.simek@amd=
.com<mailto:michal.simek@amd.com>>; trini@konsulko.com<mailto:trini@konsulk=
o.com>; u-boot@lists.denx.de<mailto:u-boot@lists.denx.de>; vigneshr@ti.com<=
mailto:vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix the qspi parallel memory issues

Hello Venkatesh,

Is there any news on the status of this patch? I'm working with a Zynq 7z02=
0 system where 2 Flashes
operate in parallel QSPI mode. This patch is essential for the correct Flas=
h erase in U-Boot v2025.01-rc3.

Without this patch Flash erase fails on every second multiple of Flash eras=
e section size (FESS). Failing
means that the Flash erase is not initiated or successful. I.e., the Flash =
section is not altered.

For example, lets assume a FESS with 0x20000 (128 kiB).

sf test 00000 20000 # Works
sf test 20000 20000 # Fails
sf test 40000 20000 # Works
sf test 60000 20000 # Fails
# ...

Note that executing

sf erase 20000 20000
SF: 131072 bytes @ 0x20000 Erased: OK

shows OK even though the Flash sector were not erased.

In case you have any new/rebased patches you want me to test, I would be ha=
ppy to do so. I'm looking
forward getting this patch into mainline U-Boot.

Best Regards,

Dominik


Content provided within this e-mail including any attachments, is for the u=
se of the intended recipients and may contain Rohde & Schwarz company restr=
icted information. Any unauthorized use, disclosure, or distribution of thi=
s communication in whole or in part is strictly prohibited. If you are not =
the intended recipient, please notify the sender by reply email or by telep=
hone and delete the communication in its entirety.


Content provided within this e-mail including any attachments, is for the u=
se of the intended recipients and may contain Rohde & Schwarz company restr=
icted information. Any unauthorized use, disclosure, or distribution of thi=
s communication in whole or in part is strictly prohibited. If you are not =
the intended recipient, please notify the sender by reply email or by telep=
hone and delete the communication in its entirety.



Content provided within this e-mail including any attachments, is for the u=
se of the intended recipients and may contain Rohde & Schwarz company restr=
icted information. Any unauthorized use, disclosure, or distribution of thi=
s communication in whole or in part is strictly prohibited. If you are not =
the intended recipient, please notify the sender by reply email or by telep=
hone and delete the communication in its entirety.
