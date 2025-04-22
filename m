Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01FC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 05:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D52F810F4;
	Tue, 22 Apr 2025 07:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k31qK/7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B3E81273; Tue, 22 Apr 2025 07:11:24 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C78810EB
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 07:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtkDWZeCBaioq0T2eKSOm0dPRdcrtyvCCjljKX2R+igfyQBx+d2Q+sITW4ZTwGQ+EbQflFSSMJCEKQfhWvSkUOpjlB0wJzyuWkmhoNfzPBEjCkNBPJZuIAb8NjluK0IIBEnxdb5JjzHUL/Feq2W9QfP7AC4qhJ2SmuFTUYDJgvUZmd5kU/SEoo7lpE8XUqLPQZNOm8q6BI3LuWWX0Q5q08zJLJCwzSMNHHfJiw3w5GFlnf4cqOVU8Uz8cR/ZtcSfmxQqOk0sHHLaN9STWVBgUpATLkjBNi41vEQAVPjbWBWvhXBi1n4ddEht7FGTb7sCqXcIO7zeshH8nxGPok3g1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNiuYXNAIIZRWInkwF9XRe1b+81sS4Bx8iSQruCnxxA=;
 b=tNHSxb/S4hnkN+QLFWMXWanOTk5G0dFNd5zxKi46/OxbZ2/Ig4fXpk6AgT4CaqbERwYyHACZB4/oNBimtnN7H7Za2vt6KxQ3fPWO96Cbyx/h1uookKVqsxWDC6P2MfxE/dxd+ylg46T0/6ebn7KMzj70Gn+XTys1/sVwgiLWqAUVIKSSKOXPCebgHPxzb1j6xST+OsF7hJE7i7fFYqZOdm4KkYKTI6tcl9ptQx+f1uxIGUic3cB2QpnFesoumSFZbDI3elLrpt/y8hNkse+yhmtVFMbdOh5Dm0gxpdBvPdCoSI1TpUUz0aKCQvmqPGdmZ2EWVGbeJWOXjx34pvNksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNiuYXNAIIZRWInkwF9XRe1b+81sS4Bx8iSQruCnxxA=;
 b=k31qK/7Z4aMbEFb9MhTQy57KW/Y6Q9EFLAedtTfs9QZLC6tIW550OFBbzSzgfZ2Qh/0KNdugASk01lLUBHt+eGblXoqccmIw76d+j6r2yqzFzJP2MTIb+OPhGmVrzRTCx2+c1dQ5TDuT6l6zT750qMVKisTqN65Vfm4BtrD8vIfCMlQcgaer68L6zOMVBMVSVeFnQ80PTFJqX0T+Fzvdxkj84QG5Rt8Du6FqifMyP5n3dZQf0/92b8pSBZ3tmrORVs8CGr6WdZ9CH/UIPj3cNecTgXwi/z7a9EeOOG5QoBiUy92Vr+fPAxnSxh5O0hIvhGVfk5NUFJHVydnHWAht4w==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN5PR03MB8078.namprd03.prod.outlook.com (2603:10b6:408:2ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 05:11:16 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 05:11:16 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Ravulapalli, Naresh Kumar"
 <naresh.kumar.ravulapalli@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250422
Thread-Topic: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250422
Thread-Index: AduzPar8Um1UYP57Sxaq5MD1T3Dydw==
Date: Tue, 22 Apr 2025 05:11:16 +0000
Message-ID: <LV8PR03MB81371BBB1BF844425EB2DDC0A7BB2@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BN5PR03MB8078:EE_
x-ms-office365-filtering-correlation-id: 8acf7017-4a98-4506-1bc3-08dd815c1c02
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Dpj2aiSNt7V/gCIWJGkQEgC0l8qoJby6jw/m7YAZdInRUjDWiYw+UPIFPM75?=
 =?us-ascii?Q?l0iQxA6VGSpjGBgaGZ/gNnnrFUyIxN9ktUKKTwe7z1qXbNaFoI7kav2sVpXy?=
 =?us-ascii?Q?STJL0ouKxVa8LW9NlIsy0enNjfUflS+i5ZuJfhxMcHLVt+3RaRDc23H7Dbvx?=
 =?us-ascii?Q?8p1dNoiMY2aPlPW69/EaAgQh5PRyqjLjHiIDdgqB6t3spkdaepT97Ds7rpIS?=
 =?us-ascii?Q?OWoBn/E+53IOhqFvWNcKNyWLh8Kxd+ZwG74Kv7uXQ3MJibRwWvmy3GFGre3P?=
 =?us-ascii?Q?p6KZN4OL2omh/9fdsWGzgVfUNSYyBFDZj/LKYe8xcvyGGE4kDATWVxu1TYOz?=
 =?us-ascii?Q?vDmp3ATYTYsZYz953ubFsO/cqRNdEKor5DgFYSuVSVJlrI7NweMeouj43oi4?=
 =?us-ascii?Q?fku5Ps+loWQM+2+4nYb19w6qOT664gEBKtItLwlmjBFyaU3fpO8Gn7XQW6c0?=
 =?us-ascii?Q?p/ynhrgn8hPe7rW9yhgJ17uEYzmi9vSNCLpDrtbVllKXNc0LYmrsoz6K7XcJ?=
 =?us-ascii?Q?NojtbtRyUGXj5jHSsDznMvO17vxQkpyGJUpOhTyAQyBe1y3b1ixw1BYDQvQY?=
 =?us-ascii?Q?qfgBwRLgEm9ZxDSfZM83+KnwmrtgAzxW5BP82duB/BSW4FJnj397LRKSkpnn?=
 =?us-ascii?Q?hqN0yaUWiHT36mNZQ2MDNZq91VCaGiGqcJENu9let3i0ULKuDwsmWaUFhUkE?=
 =?us-ascii?Q?cmllfaQ7beZtrnEj3GTbAGKWQtYMZDPfx5eT4V06X1wx5fu5aZbdHQo8U978?=
 =?us-ascii?Q?zGTZiwlFAECSN3ERDgF1jo88H4M8VytdSY0p0mwENnKQX/GeKG508aS2eBTJ?=
 =?us-ascii?Q?gMd488DubeRboxQGWjT8B0O812O/0njRx2ZqWOOiaNHluSovZ7HpRLnAtgkg?=
 =?us-ascii?Q?aKmZ1Q4ACuq6gOi8GQ1KSx2dnkI43NsjUoSlp58i2W1cD/JSsW6aW8eBiUzf?=
 =?us-ascii?Q?IcOeGm0QRO/1wFbU3VyOQmkBapq1+g56QHQa3NmMdRzbqxzKGvN9RtacmoZh?=
 =?us-ascii?Q?Xli77ui+K1+8kRdCcN7jsAnFXk6t/ebpvdWs+DQYkQY2c8mNopfJjE985vd4?=
 =?us-ascii?Q?hXEMW7ESr2k/JMP0B5raD8A/S5r9kn1DXWgVotNJYcvpOfGs2GexB9JhFRF/?=
 =?us-ascii?Q?snRZtdnD6Yf5ePUMUQR2QzCkwGWZ2JJybNCVpQ4cB2sw28vej826SnHn6AHZ?=
 =?us-ascii?Q?vbq+qNKpaUWiIdgezQmUYiw/fDC1ANOknYATiXlAaLqWOkmzHhd8wh/PYTMK?=
 =?us-ascii?Q?PrOyh3bFy5E8Kgx/BywHu1rtbI8l+OP4NKAFKTmr0oVq2vEY/z8POqIsx0Ts?=
 =?us-ascii?Q?vFaa+KdhcEiDUHZtPeppUOii8p/YBsjKGdLyRx53ntc36EFr6KpsMr05mtFF?=
 =?us-ascii?Q?Kmk4JI79QFQlyofI0+0Az+g7UcAwNT7u8PrXSdWHaK3SNpl9ciDm435ilUG/?=
 =?us-ascii?Q?wmIW7b1S9wg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FLYCmujdFfgmrD1L7QSlnxAWcTFfN8wDyD3xEFaQnNU343pfBMojsR/LmDdx?=
 =?us-ascii?Q?QfwaRwApcDtHTKHrxVeoYj+dEoztP3zHRkoNH1v6CBl87aeHgYsW/l9HbfBJ?=
 =?us-ascii?Q?Mngu4M+w8aEtSPluyOFIIm3e8AoyB2mMnxtwnoG2w50BjJMIH9tG50hrGTbh?=
 =?us-ascii?Q?GGGoOEPp2yXfK2qKkAxGRq1YlzdRgXcb9axQhASfAsWOSSf7tmfH0WX+Fknh?=
 =?us-ascii?Q?XHWzIisZqUdCMnJrXbJ/uMC79XHb6g9D6tdym9CvmSzPF3SQVWWyC9AUH81X?=
 =?us-ascii?Q?l8dlXSstLvvNmdq3QcxqD4u7oCMppJV1sEZbrlMrH8akp/OnUrZDsa7y/QBC?=
 =?us-ascii?Q?ADbWa0yUdAToq8hMHK2rr8Dr1Mcme7k41jz24MCkD0I+uUaZdFieWa+WeMmk?=
 =?us-ascii?Q?KXwFf9YSNpCTnv7nf0PfthKerTY7xxSrEXC2/tWkogVLc2J0ayyU5lOG3A3J?=
 =?us-ascii?Q?HID45K/Sl5Cbes4bnXvV3ZxG/rTy082xHs8HpcbRnT0CsfvMjT0wx57FpgpC?=
 =?us-ascii?Q?LQMYMfTm8AjUmRiqTHDkBbtQrQS52kE9hYOq0+T9ko8lmSUddSJNdDsfjluX?=
 =?us-ascii?Q?aR7amvSTGSf9V8845dwNFqxpg6m2mdMCOWSYlJXO8dw7ryNcr54g/FyQrv2V?=
 =?us-ascii?Q?RQ11q6r9O9JY1FU9WKoq4af+iajMmPOvOvl9TMJ4UuC2I3YgvircUZuEQxMA?=
 =?us-ascii?Q?6caJvQVhV8eaMJ1Zd47srLET2qnsuOT1hExpNs6IdeUQ6lQEimxq1cn9cDT0?=
 =?us-ascii?Q?288IODQ3h8wVOPwZl92mcmmaJzjv3PaG7cMzo8n0wg2DVwhVhWPPsBu+qVcJ?=
 =?us-ascii?Q?Le/dgTx82vKTvukqvWB6AqcPv2de/mhbqiuSFWlWxzDdYD3XtzLqhcpfjkwZ?=
 =?us-ascii?Q?7r4gxqlXvMZmXOsbxrw+syOecUI/XMNq1Bx4W2059QhHJTtiYBQrkv6C3usT?=
 =?us-ascii?Q?yHKgz4pkzQShQW1EAjbIJbSn7/NVzcJB3xk8uTHEMgtP8xOLZboK9QcxPG5+?=
 =?us-ascii?Q?ajnUgWIorrsp9BDfLONN7Um0F5wVv0Gjtiuc8b+szZAUbz3gmOqG79PytE5u?=
 =?us-ascii?Q?/qZK7TtaKGG1PxM4jEpV+hgT1B+eHlsLtoBaWmf/17ZOHAcI2Bc1uCfmNtBL?=
 =?us-ascii?Q?+Yld7JTw1BpAW9XdDjc/RrEcdEoX1ZrwPFWhsPmjkpCLjxd5PAJrEp4LSYHg?=
 =?us-ascii?Q?msv1px0Xiko0zV1Sa2Sy19CFNMr0q3U6gVOLpn5cnzSJLW7iBdKRu61y5otH?=
 =?us-ascii?Q?F1/JpV3NdHOnqiI4OuV6iEjHwJMEq3DKpSguiJMH/zicX2quOTsvQZEFdqH4?=
 =?us-ascii?Q?nNYTPLxbZCNVsL/QMlqP1DgS8nBs8/GaqqlIU9UfUtIZNme/Z8y9cIKa4n1Y?=
 =?us-ascii?Q?caTICQi8abvyjG5Vd/J+Hlb5XurtsSQ+NiTiTx4pKX5v6zqL/uKNsMZyuvgj?=
 =?us-ascii?Q?XxLpjdg5LHdWskESmZtbVf4AU/YmZZzTS96fsdutcTaMrt76FNzEsZubJUvz?=
 =?us-ascii?Q?Pl7Ev03A3ShqWnAu+LhOnAVU6LHrTs9+pFi/BIHku1STtpBZMyeZ0aE6ZyWi?=
 =?us-ascii?Q?GPi4gbTDtgqf3+ewWnj/0W7vALX85kOACsWri54A?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf7017-4a98-4506-1bc3-08dd815c1c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 05:11:16.3237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7ugZrnanBWw9xz2LBY04VINYH23cu7NUdgise6R3W2DAmIZtNvdg9hXZVzOZunuJgOrAUePSUCvM6viBUxJ6waJkDPK9ZVsTXvSLKF+lcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8078
Content-Type: text/plain; charset="us-ascii"
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

Dear Tom,

This pull request contains updates for the SoCFPGA platform, targeting the =
2025.07 release cycle. Highlights include enhancements to Agilex5 support, =
improvements in DDR error handling, and bridge reset handling for SoC64 dev=
ices.

Key updates:

Agilex5 platform enhancements:


  *   New MMU region mappings and memory layout updates using LMB_ARCH_MEM_=
MAP.


  *   Fixes for bloblist configuration, kernel FIT image generation, and VA=
B flow enablement.


  *   GPIO pin control added for SDIO selection.


  *   Marvell PHY driver enabled in defconfig.

Agilex5 / SoC64 DDR subsystem:


  *   Added ECC debug improvements for IOSSM.


  *   Introduced LPDDR inline ECC support.


  *   Resolved size calculation overflow in memory driver.

SoC64 improvements:


  *   Enhanced mailbox communication with the SDM to reflect various boot s=
tage transitions.


  *   Implemented F2S bridge reset support and updated related reset manage=
r registers.


  *   Expanded SoC64 CPU info reporting.

General maintenance:


  *   Additional peripherals released from reset for Arria10.


  *   Cleanup of legacy or incorrect Kconfig implications.




This patch set has been tested on Agilex 5 devkit.



Passing all pipeline tests at SoCFPGA U-boot custodian https://source.denx.=
de/u-boot/custodians/u-boot-socfpga/-/pipelines/25867<https://source.denx.d=
e/u-boot/custodians/u-boot-socfpga/-/pipelines/24816> .

Thanks.

Best regards,
Tien Fong

The following changes since commit cde0050618968aae335dfbc930641656d51ff5d0=
:

  Merge tag 'u-boot-at91-2025.07-b' of https://source.denx.de/u-boot/custod=
ians/u-boot-at91 (2025-04-21 08:24:54 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot-s=
ocfpga-next-20250422

for you to fetch changes up to 0415429935d7e19595d2997ee08415d0d8052d4d:

  ddr: altera: iossm: Enhance debug information for ECC errors (2025-04-22 =
11:47:41 +0800)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (7):
      arm: socfpga: mailbox: Notify SDM on HPS code execution stages
      arm: socfpga: soc64: Update reset manager registers for F2S bridge
      arm: socfpga: soc64: Enable F2S bridge reset support
      arm: socfpga: spl: Notify SDM on FSBL execution
      configs: agilex5: Enable Marvell PHY driver
      arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as output
      arm: socfpga: soc64: Update SoC64 CPU info

Naresh Kumar Ravulapalli (4):
      drivers: ddr: altera: Fix integer overflow during size calculation
      reset: socfpga: release more A10 peripherals out of reset
      arch: arm: dts: Enable kernel itb file generation for Agilex5 SoCFPGA
      configs: Enable VAB flow for Agilex5 SoCFPGA boards

Tingting Meng (6):
      configs: agilex5: Restore fixed bloblist
      arm: socfpga: agilex5: Add MMU mapping region
      arm: socfpga: socfpga_soc64: Enable LMB_ARCH_MEM_MAP
      arm: dts: agilex5: Update CCU configuration
      ddr: altera: agilex5: LPDDRs in-line ECC support
      ddr: altera: iossm: Enhance debug information for ECC errors

Tom Rini (1):
      ARM: socfpga: Drop incorrect imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PART=
ITION*

MAINTAINERS                                              |   1 +
arch/arm/Kconfig                                         |   3 +-
arch/arm/dts/socfpga_agilex5-u-boot.dtsi                 |  17 ++++-
arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi           |  26 ++++---
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi               |   5 ++
arch/arm/mach-socfpga/Makefile                           |   2 +
arch/arm/mach-socfpga/board.c                            |  13 ++++
arch/arm/mach-socfpga/include/mach/base_addr_soc64.h     |   1 +
arch/arm/mach-socfpga/include/mach/mailbox_s10.h         |   4 ++
arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h |  18 ++++-
arch/arm/mach-socfpga/mailbox_s10.c                      |  12 ++++
arch/arm/mach-socfpga/misc_soc64.c                       |   4 +-
arch/arm/mach-socfpga/mmu-arm64_s10.c                    |  14 ++++
arch/arm/mach-socfpga/reset_manager_s10.c                | 236 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++----------
arch/arm/mach-socfpga/spl_agilex.c                       |   6 +-
arch/arm/mach-socfpga/spl_agilex5.c                      |   6 +-
arch/arm/mach-socfpga/spl_n5x.c                          |   6 +-
arch/arm/mach-socfpga/spl_s10.c                          |   6 +-
configs/socfpga_agilex5_defconfig                        |   6 ++
configs/socfpga_agilex5_vab_defconfig                    |   3 +
drivers/ddr/altera/iossm_mailbox.c                       | 225 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++-------
drivers/ddr/altera/iossm_mailbox.h                       |  11 ++-
drivers/ddr/altera/sdram_agilex5.c                       |  19 ++---
drivers/ddr/altera/sdram_soc64.c                         |  54 +++++++++---=
--
drivers/reset/reset-socfpga.c                            |   3 +
include/linux/intel-smc.h                                |  15 ++--
26 files changed, 594 insertions(+), 122 deletions(-)
create mode 100644 configs/socfpga_agilex5_vab_defconfig
