Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20506C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07B580B9C;
	Wed,  5 Feb 2025 14:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="dvp1uJQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42ED38081A; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8027580762
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7bUG3/Bmp/fFSNnIgksKi1UvCOg2UWiRyyJ6G+nBKXGkiHcYlfv+uqbCjFP7OlVZaqBOZB5BnPRLf/3HoBLH75199ik8fzIkOtdaOcq/Ax6vmgv+mEp92CXQmqZ1uNBBCVgDX+2HGrG2yi2WYqdNoEpTEGaP7t4l6sReImRXCoEhxzu3v3Q18yUaOZMW3sGkPsNpIjGOQi0e8MjRSsKvp67APF7+/R31RUBuW7jT6YCZ6/KCccB4qOR65EewEU9Ms9NIqIVnLchNk+VD7nH0ce6PG4cdB6weLJg9s5ETicJ0G6a2kDKd9HUOY/DKioyBfgKlqXxLJj4kdyVXq7HsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTrz2XGzVYK3Hpzvz/BgLGdIXz2kyZHZ8gc5VwQ9phM=;
 b=M+SX947ATiAP4rvlEDj65IkYSG9hVscN16vKMug8/AFaqS17PRghtr6Wfvu5QsVfPsm24IyBlpXqFApxlYW6K/U2ULsc4nnZg3O4k6aEDNikwDJ1fKPsWfYNBFoWHo6fV+4/PE3XhIgVzIYdd7tzJY1kZ1u5YmFyRQcP03GsPs8SS7IItT4V5F68S2WkO1Aw9zYEq64ILAaGxMt8GAbwyyL5UbeYl2BVoM2vjvRfjnRN2Oe2QRwdDt99KiBfqWQKEjUZ1DXpJRvCn/cjEF+kBF6VtktMds862tBxDsUaty9FTrr7qF7pbUtIanO7HBMbf4oTYddXwX4KbOCdEKV8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTrz2XGzVYK3Hpzvz/BgLGdIXz2kyZHZ8gc5VwQ9phM=;
 b=dvp1uJQXEnfk2LBrAuNMgSQUjLYr8JyaNthkSqItBigPN9fSmnQI/yCTrK7EJkozrU4ErNe95XOYOlJSE+/MAABDTU9vZu05GrittGT0BsG19Yqp6bMseUa4RehiFg78T5gztVJlUiQ8FU7QeRHps7CZT9Uuhc45LLOae0d3susTAbixF2nHk0tQsAMSYjZpbLj2zlrUHFICBrk3eaSo2nQvHz2+cK2wNah/0S9lKyXBIXyGQCa4xWEMLLit1eBnS5cyHvOoctvhQvlKGHSWEDMa8fMQL/C03pxI8Pq/L/rZ40asJnc2/TYeAHIWszAos/TEcRLeE+bGCdPx+0m/Zw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:45 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:45 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Matthias Brugger
 <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 03/20] arch: arm: mach-bcm283x: add pcie memory region
 to BCM2712 memmap
Thread-Topic: [RFC PATCH v1 03/20] arch: arm: mach-bcm283x: add pcie memory
 region to BCM2712 memmap
Thread-Index: AQHbd7bpNGKyKk2nz0GhDFVfccs8yA==
Date: Wed, 5 Feb 2025 10:15:42 +0000
Message-ID: <6aa35ee2b1ea651f44bcfeea2e6d1d24002729d5.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: cfe0c84a-6da4-47c0-0c86-08dd45ce0dac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mG9DX5cAzmAPkCtlVblBGMZMX2YDON54Mwi7AIZrtKqui/3FqD1SoXUSLj?=
 =?iso-8859-1?Q?rffOJ+CdDbbkRCGz2CXjnJeKcml7AbblQdbE1bb3pQyTc642ZOAYSl1GUG?=
 =?iso-8859-1?Q?AE2l4AuDmDQ4FuG9QvgqWNMI/+w71a3ZZF/G2aFBDBjmnE37QDtsQ9F+cF?=
 =?iso-8859-1?Q?9bZ5a2ZtPXEz9llGKLUriYOd5H2XGDI4NTq2tQ+Y9CqGdwd+1lzl9/CXnn?=
 =?iso-8859-1?Q?K9wU11O6rTTidMTCj8IuMIG48M1DRolizKoW/aTB9MHRT78sV4vAcqQWYN?=
 =?iso-8859-1?Q?oCQqfBYgYBqkZTNrFsLuuMClb9D/lkjqPGjYlp2a2hCOvkW9eaFVZZFocZ?=
 =?iso-8859-1?Q?YEruGl8/2zSD+0vel8/DyotNbIldR1KMG4jt/swIRrhcdLnlohkHbA16V0?=
 =?iso-8859-1?Q?PmYdi7JAoH+NvPjM9lv4HpezCKWB7kDiXmIlBC30Ja02OD9nJCexMc6rut?=
 =?iso-8859-1?Q?9RdRXJmZP6hhWTiw7mg4nj3eueYfVcKp0aJ9uJC0Geq7QIJlc++miE6+Ba?=
 =?iso-8859-1?Q?n7ytA8NgFZ635AekPe1fLre+pwj6IgZ+cP9iIQdNb9YSOvVKju/jvcJ3vO?=
 =?iso-8859-1?Q?YQ1SBC/g1LL3Tc+bfGWVdaonxXUKL6GtIOqXfIEdv+x3fXemWWEkHzCsgH?=
 =?iso-8859-1?Q?WZTOyjVBMNJcpXHcTo2sra7esAjgeFwQml+tGHqL1BNEJ64dA1LFN1tvLv?=
 =?iso-8859-1?Q?m4Bd0FXHxeDQFAfHnXr1IFp0yeMWv2i3YB4TatRZIHghjMK3qoSQxp94i0?=
 =?iso-8859-1?Q?CJveMvxxZOeKeTrjBjNcnEXvXBthBglHrgI2m/UaJ7HmAyZXlbNrZcu6Ib?=
 =?iso-8859-1?Q?xBDUhih7EHQC3898XZ3WIVjqkhaS1CpN2J8M9X6W9ySQyOtkCejhefEGw9?=
 =?iso-8859-1?Q?Z/AZew3nFZEhdAlzDjB5hBoSxBQ4KPK8Uq/6t4hGSef974SM8qgRX3UN/4?=
 =?iso-8859-1?Q?addwfuxK/FdTNySIyGqJ/oAet+RM8f4ZQqWyk5VBo7+Z0OkD8TGlLra02A?=
 =?iso-8859-1?Q?Ucnc46+AdHrkG8pcuuUdKzUQxPaGvAOzvIPWzDC6rMXxvUOX2+a6XTNiHS?=
 =?iso-8859-1?Q?0BB1j6/siLp+GP+NEPiR+RkQZpyrdFCUiYmlkKWW1bX3MvREsDtktqK9rM?=
 =?iso-8859-1?Q?GIIXlW1iTD3k5CiT4ollhYmaSIR9G1mDpCfOfmi+VCtO8oUuE2avTo1agP?=
 =?iso-8859-1?Q?rdnbbXdwrsC5DarA7pSwDn0YsE8xb5n6HZG3VJAn58HzLprkPQqvpzASNh?=
 =?iso-8859-1?Q?iEV8NpU1EpylLLiQ1x+Us8VhTI0kPUE5if7WwB1AIbE/V9TLP2vBuhOEHK?=
 =?iso-8859-1?Q?vHFMV8gOwNVdFJgvewxduVg8PGZ/EAmpjS6T+PSS2S8rdJadJwyYrGTnAI?=
 =?iso-8859-1?Q?D5b+7wXZ+Nz8mxaAUFIY3gT9HMf+k0Bgmm0aU/Y2UaZwi78oQk4diFIkJp?=
 =?iso-8859-1?Q?W0fp/krh5bMHxw+tETIG9jsg5whvrUhlzCsl3qJMfATSVMsETLu9GzLTO7?=
 =?iso-8859-1?Q?9edUUh7tSXsYPT878WmA+M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wANMcyHl2NKBHV2pUFZwqBGUPMaI94nALrhJ/E658eu3S5H/PcqXOo8D3y?=
 =?iso-8859-1?Q?evntnhti1eH4W6Ym1qt3+8z8+cNxz3Osq5dQDikuF0FLTpY/u4QELDkiSi?=
 =?iso-8859-1?Q?nexb9z/hbI7nAjMYf/0vFJKld/YElqQuKVFE6IWId/tLPXzUngFgvwP9Fq?=
 =?iso-8859-1?Q?eYBA68WiJgRYk6rhJLasqmC78ZhRfZQkipJdgpN5rhuHUJc3sZSoV1HiQU?=
 =?iso-8859-1?Q?KrKq/fPDr6Sk7rdPA7+csFluG6aQ1F1aDwaKPlwUwM4PzZgXuXAzcf0Cyb?=
 =?iso-8859-1?Q?yFbaUcoanJ/LF20zQNLmnRLa4ZqYMhKgan9OCZ0NFLFXbVEKaU4MM8Y3ud?=
 =?iso-8859-1?Q?VzTNDMgRE2fuI1tdjIJu5SI181wEA4Or+hVEktANVmtqUM5mkZTh/fqTAg?=
 =?iso-8859-1?Q?4wBQg/Crsmnn4jHyM+eMu1OH15Mv8PAk3zg73xvfOajG4Ex36qz4u/vhKv?=
 =?iso-8859-1?Q?CeNQy16J0ZSQUEYJsdhiHJTyCK+0OxxmUzfyZ9E9jF9tS8QvRuWsvFPlpQ?=
 =?iso-8859-1?Q?XEgblZu0GbC+5Cx4KGytaKolRfisdqLoVgasYc0wKSU/unwohDcsBqfXyt?=
 =?iso-8859-1?Q?khvtPriOjwI0HTB4Bgq51yE38C6uSu383ZEUiUeuMdVBG5JG4TUAR/zMRT?=
 =?iso-8859-1?Q?4Zimg4nHdTfPsAgIEilzpm3bdLeFr1UbaS0Tz8Vm77MPf2LEY0z+spPR8h?=
 =?iso-8859-1?Q?Y6g277VaZhk/XYYTLxN+GWbJMq45a7hWOXhbXaTBp4px71MUyQpuMWmqrp?=
 =?iso-8859-1?Q?VwenYbwzRsLK3tvc9j3XpiCjXj9itbF0PnYGKfvLqMZX1PvBzKSM/cerqw?=
 =?iso-8859-1?Q?gs1u7w49FAQVMN9aPAKPvrRzP6KM9nKTYvCk++7YmObCUzSlxHuJ7uSR7j?=
 =?iso-8859-1?Q?HJXR/Pr4gsID2w+84/ZyoGopJVoQJbzbw5XXcjaX79IrEsX8T0wtqRPuBz?=
 =?iso-8859-1?Q?gPlZdOM/0AUyc0zoFlVV0ffNtmsu9PEQHT6HJ6tugkk1iqn73iUp/pwxoE?=
 =?iso-8859-1?Q?msQ19HWbo5WMSi+TH8rB7WWPVa04GBIM5d5n2MC5Zy8FJjM1Hr3rBZl0aj?=
 =?iso-8859-1?Q?PFYiBUbzqS19Ce5NwpVm52F9+6sRTglK4ge+8E0gwpKDAR4frSXwURXMcZ?=
 =?iso-8859-1?Q?1UoY+8OqcfWkCLsxjUbHERL7QHkUq8Mb44BSjoAJ0G0WPttyJo3yrWT0EX?=
 =?iso-8859-1?Q?/v45DojEbz3ATAb8mtCmkhr2p5jBRkh74D3j9QmxWWIYoTXHQ+ceWXdWZe?=
 =?iso-8859-1?Q?loTbHmeyVhxhkqhKWwBYqIr2m4DGZm761l+ZGiyGcwg0XpphWqQKOwUERm?=
 =?iso-8859-1?Q?qf7VaH6GIVgV7h1cuR8qZ1Gpl0pNCdDCkllz7sx5j/eQ7uHsGNb9ZjMPG5?=
 =?iso-8859-1?Q?d7VXW/LCN210q2vZCfKp0TAoem62yR0eL1UgFFeKtjnLulXnWUbHk5DZCa?=
 =?iso-8859-1?Q?jslfcVxrsoO4CPmT7DyqNN5zEvugXmL45p6DAdtyIL2VT5nRy6+x4ACT1O?=
 =?iso-8859-1?Q?vn/Gkl9S6NNq/SsLaUlloYivo8f48DWKgdfgGoE0yzM+phci1NDvLC58Gr?=
 =?iso-8859-1?Q?y5MPTchQaTFz0Sbs7G/9r6zTGHdDa3K3dj6L4u/EWsI/8ywKJnfU4s4Dun?=
 =?iso-8859-1?Q?a4QjQsyAxb4BFOgGqLx+F7IlNx9IqtYnJbYxP4wgbAUa2P/Q0oLF95Gg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe0c84a-6da4-47c0-0c86-08dd45ce0dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:42.8587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8jmxDv3z7PoRaEc2guA2VRQHgVuJPYENzfOZQwQ1JcB2AcYlys6y2Ev0bPN9afbtFlsKIFH7T7INhHs3jKTkhTA+4bfBxQOnGAKxwbCAd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Update initial memory map for the BCM2712 board. Add PCIe memory
regions.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 arch/arm/mach-bcm283x/init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 016bc1eb41..284324c78d 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -19,7 +19,7 @@
 #ifdef CONFIG_ARM64
 #include <asm/armv8/mmu.h>
=20
-#define MEM_MAP_MAX_ENTRIES (4)
+#define MEM_MAP_MAX_ENTRIES (5)
=20
 static struct mm_region bcm283x_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
 	{
@@ -84,6 +84,14 @@ static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTR=
IES] =3D {
 		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Beginning of PCIe section */
+		.virt =3D 0x1f00000000UL,
+		.phys =3D 0x1f00000000UL,
+		.size =3D 0x0002000000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
 		/* SoC bus */
 		.virt =3D 0x107c000000UL,
--=20
2.34.1
