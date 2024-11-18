Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3D4D60CF8
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1187A894BD;
	Tue, 19 Nov 2024 01:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="e7TdIuJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452D48937F; Tue, 19 Nov 2024 00:16:47 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03548894AD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 00:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBdhR/ASTuLjU4PtufDHuUkBmXPukZWzIHmtlIS7PTjaCaHk08/dG6GrbckK/0MvYmF5yRLvYLwlMyR0rG7AAYYDxPYfuD3cJb9LZY9XlG4NFWbQ9KBkxVK//ITq86xht9RXu55lXlcRXwSct1XBLxvBNLcfmTk4QouHYvjuwVb0cE/qcUAmFPIr7gexjc1+e12q1UA+78V18KGFButU5qG62MoECZ2ye6QfvpL4K7YqROmngWAQVZUz18hxlP39IKmWsplVS9D7XFoUS0snegDJcUXiz7NZxVXTKym7dq+4lQ8YK45FZD4VUqzDhmz6XKTk7iFrTTf1jHKSBuLP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ3xK+CCTfiO7DETvdOmBSunPrIa8WhrnTlvQGU331E=;
 b=GZdBvyX1eMu7mxW5brsnOTNQkqPa1a4xXegdzhNvM/BW9C+KcVabm6HCtyMZEeiTc9KseMaR8lwf8BwJS/9FtSqfobDV3YsOmZJc4A6/4Ftd5wEtN8jJAQelX+nu9l/TsuAbrk1q5r9MJnqyHK8weYvA9hAjTf+g6T4lNqHT8bPw0Mfj76QLhKTjxMvFgxvdSMK2JvBs6CNk3H7oZITCUgi+Z4OwSJZQ8RJDzjKzyYakqovNwO+L42BXPeRtrBiOWLGbET/DFa5SjVzBeIuwf80Dm0D5nibv92NqATLqktL1OawC0QSnS1Ym0EDoMHnphsFySPrm3PQ+Ui+NKdEa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ3xK+CCTfiO7DETvdOmBSunPrIa8WhrnTlvQGU331E=;
 b=e7TdIuJBDcLQSQ27hjo2DWgX+UuPedIWzioMxxyBJpP+f3mhUB+LQY2+l/EEh0Tb5ae5O5TSE6M5yAolwv/RmFsjN5fN2wD8BiPe8hGjq7LsoFGomW3/LGVfVUfa8sqEo9Q/cOHb+XmR0EFYwectH7gu2kGS+S6iQL/UOm8KTeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV8PR22MB5275.namprd22.prod.outlook.com (2603:10b6:408:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 23:16:36 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 23:16:36 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, w.egorov@phytec.de, t.remmet@phytec.de,
 sumit.garg@linaro.org, kever.yang@rock-chips.com, marex@denx.de,
 festevam@denx.de, jonas@kwiboo.se, Oliver.Gaskell@analog.com,
 aford173@gmail.com, prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, bb@ti.com, nm@ti.com, d.schultz@phytec.de,
 nmorrisson@phytec.com, francesco.dolcini@toradex.com, vishalm@ti.com,
 vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org, m-chawdhry@ti.com,
 j-humphreys@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH v2 0/2] Add phyCORE AM62Ax
Date: Mon, 18 Nov 2024 15:16:04 -0800
Message-Id: <20241118231606.3161665-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:408:ec::16) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV8PR22MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f33bac9-b4d4-4415-ae9c-08dd08270c9a
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0k6mC2CF9eMGa+FO/mSt3KJPUVg3i4odo7rTqLuTVHgGD3FcqehiT+h0Jz/?=
 =?us-ascii?Q?eFzK+TyVKUtbGkxxVBbp4FWn2A99vFmqSnLgxHk3uf3b0qXkJLytEf8Snq81?=
 =?us-ascii?Q?5Zxxh2n65Clrh2AOPPkwxnICejWlVRXtf1WJ8oqWtjPt3GmO2zKJKUiWec83?=
 =?us-ascii?Q?N9ZeiqCfPuVyln+ms0YJV7h5DbLWuKzrRvIQjZsBLHTo7FvOI1e/qoJyPizn?=
 =?us-ascii?Q?xi1GUecKShl90fEMMdE16a11IJbH5vo5E/TYGyb4GX3CzRN1mO/T5+i61CPd?=
 =?us-ascii?Q?lE0OzMFCGHFcXOhQYj2QyNvtWj9N3dddqmeFfTCJeXL5NMrL5lPg6lpS14kd?=
 =?us-ascii?Q?izBU9CAWnRIYqcDRcpCBoNlw1eCSwJuHB3XwqIMpLAKVksUqskHrhhbKVpq7?=
 =?us-ascii?Q?pbC5VO0yd9bM7qO8V3UxHiBWZWdj/VFg0XzqxN9Nq3LnGpSBlMQsR9I8qnYx?=
 =?us-ascii?Q?11fqLwVq+RCBj3I/mH5O8y6QUI8MUblF8PQL7yZiJ5h5Fy5Fbph74bDrM09Z?=
 =?us-ascii?Q?AMTo1T6CdMe+eacohewNeN0frEuw/vgFy/0gzUgZEu9Zt3YbeGPro73hnVSb?=
 =?us-ascii?Q?i9j7xToaTGOVzyF0vwSo6ny/a6sXI7TblSdFtXSV+8tUeJP/1eLQpN7OHxKK?=
 =?us-ascii?Q?SugOvYYC/zux6OiNO4NZnxrcpTkpX3dmF159jMwXmd7ixZyIDOl3p6rAyG4L?=
 =?us-ascii?Q?T6zJMp2bC7ZZEkNgg4PVQGqu+1soKCbe2wPpV/1t5QRykJhy7Dhdn0cDIUzB?=
 =?us-ascii?Q?mGncA/w+vCpAnKwnz8XJuVFL/07Vdr1d1qweohBwp3RSU2zDNhTXVMF6TgnY?=
 =?us-ascii?Q?F2DomqMsILVxYatty3nmG8wH0pISuzJe++qBAVKWHB3REYNFcZNd9C6YqReQ?=
 =?us-ascii?Q?l3A0lLQkf74wA8f+Ju5GvRf1/LFBsA6v+cP+ivZD+iDGyB55h4csIadBdYbP?=
 =?us-ascii?Q?QTsRajcvGWbfsJRVb7VSIl122ecosHRKW8MyXM6PcUQqFoqBv9h3hVE4KaJc?=
 =?us-ascii?Q?GCdUiGlwV+uuXMSc1FBdKY1AQpPbTCu01bxLQtwcj+PJ/xq1XRrGxcugTyYS?=
 =?us-ascii?Q?wmVi9mlncg87qYGhu+n4YZYQYZ7YfCRgm9lf+KoaK5ClUzK/h4eIYxflL6VV?=
 =?us-ascii?Q?89cmI5xQ7+Yjtr5900C1f3U8nsz+RqpRQt8n6Zlp74tmGzK/fjxjmzcAIn4J?=
 =?us-ascii?Q?hQaLGfCoOaOTNtZdwHrpE8VBAndA4ZPmNIOgeBxXJdkV9adioSbkXDbDWf4b?=
 =?us-ascii?Q?0q2P4ZyoNl0MrnwuhCXBZDBOJnePapvhI13u6EMIraf4amwraFFx5yIwQra/?=
 =?us-ascii?Q?w1jMFv2ccSsFGE7AHV0MmS80/RSbV8wEPXU5lUK4SWMG8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6I5xsNzP88yy7BjJYK8WwckV6gSIflI7cXJEyeVckhAxDSkQOc9etNjbHUyE?=
 =?us-ascii?Q?LticfnXxM/5bBBCQC/He8AKFqsTypLPqj2SM6LlfugJZYwaZ74FAe6LSVCoC?=
 =?us-ascii?Q?HIh9+TxMLjptaiPTWJRiHh1Cm1TRsf1R+Fi/SajMk3RL6B5k+KGnFO7qvE66?=
 =?us-ascii?Q?2C5RMCk0t29REowryQzxC87/oFxR0Q2RSzxgMwlgYjQcN5bIRnje8T9sEZzZ?=
 =?us-ascii?Q?jSDsqtpLcEWxgRUmelLpus4NzwXSoXvoMlWr4F73XFSLGl/aT702n/2oECVe?=
 =?us-ascii?Q?Zu9Hmn1WZlzcDe9Y8PkuJIDTy+qVCWKYqrrpK8XuPNaRCErpIHxHuQRPIYyn?=
 =?us-ascii?Q?dFidhApkEezlkNFwjDJwnETksadwUHGDXiyyJ4RkzRwLINCl2UGib+2sw8iP?=
 =?us-ascii?Q?10x5sUQV2jP0zrMjTwDXhJxmmM2i/Q7VaHfPIUOUcluUe5vCI9sKbonrhhKP?=
 =?us-ascii?Q?/E2GV2RX8PojVODqBeqswNtWCv+bYMi0padJ21j7QYEDwxyzexI2456bzbDo?=
 =?us-ascii?Q?IAYvcsz8sRC7Ogfops2azyjTHppbu9qk+bOgzOpJXISUz8VmrRCfExHxQIif?=
 =?us-ascii?Q?/9E4AIesvWrYB/IpoJIhBh8ivOkxiVnU2pMfEPz2u5GCRv905nUyU1J5r5fE?=
 =?us-ascii?Q?6VLhqycCzMmmWcZ4vIlUGVlUuB/kg1h8tvVzAwowWOM2ysX5jan2FTgPpJGd?=
 =?us-ascii?Q?pMOoWvyIcZ0P0kt9vFVXEpuT44LEW1LPr7ulKRIzFe7YPuvCa0t+917Tm/ec?=
 =?us-ascii?Q?BItpCYiH5MKTKHkIHL6Ad3+c0jfgzNrb7URGtnuCQLqT+h//4o/fqcxWgCJ6?=
 =?us-ascii?Q?DWXYeDOkUanVH2UgvPyn1vvqvsedtz1Vzveve3/ztsIkitEFi+GIrIp+vSCY?=
 =?us-ascii?Q?EYdfSV1SDJkhppqwfW2JsqLre7Z8STXWdponpE2NtWSYZOrkDmYp8CI7NuwD?=
 =?us-ascii?Q?aUStYJTUYyJ/mfrMvgHritpV7UuonAV9lLD7IlSbOieN3c65kngA/pVXFXsW?=
 =?us-ascii?Q?BsS+Foc2GaAbeh+EfE6Usg4jV539S5RVKs4AzhItAJLfRi33CdnV3xzr1kY7?=
 =?us-ascii?Q?9m/9zQcp8aO3URDdnxUUOz0PkzCjcIL3bdA/sYoFqA1zHS5v5reDgalVKjq3?=
 =?us-ascii?Q?l3khT1a2UKsnfCCQ+W1Df+VOHd5gdWoTTnQglSwBqDoGC+jne32CwiwvpHwz?=
 =?us-ascii?Q?TtQB0p5aKpFwiDndIygqQpS66NbwktoPQkKP7k9mhTB37wHpPzrdOtB6b3zX?=
 =?us-ascii?Q?A7/5D2kBchAxRpaXjjwtTGFiCaXv2q/iHqFXDLCMbJO2FuAa5NVsvEi2EXXM?=
 =?us-ascii?Q?q+zAIr+YMAOXlr+no/ufkYfat7l1bMbYFYenxFym5LETYIcJ1gTh56TF1lJi?=
 =?us-ascii?Q?mlhh0dNPZyqm/P7+lU4Vw7puss9HCIaHUhvDDYuL/3iDlaHAekLnqwJuwK9i?=
 =?us-ascii?Q?M5rl87QUQy/9ddhIwsFnt+6W8wx9wCfp9cPGFcjTRylFw63JKzyMH7cxCywA?=
 =?us-ascii?Q?u1btiiD9EtPIMxIa0D4wbYOVD9MTcnuiXkyNUwkidB9xDIb10gArTNxEFJwF?=
 =?us-ascii?Q?EkvqlbeMnO2dj7Ncju8eblYLsWOqnF4KjaTXS0Ns?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33bac9-b4d4-4415-ae9c-08dd08270c9a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 23:16:36.8077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF76HBl1dofvsMFrEAZjrPcKOT1aQP1g9uBQj44zGdIuhS4lLp1jXOdhvmC6cLcAJzyotUOdKbCcsVJ/gDQCMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5275
X-Mailman-Approved-At: Tue, 19 Nov 2024 01:22:52 +0100
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

This patch set adds the phyCORE AM62Ax board support and documenation to
u-boot.

The phyCORE-AM62Ax is a SoM (System on Module) featuring TI's AM62Ax SoC. It can
be used in combination with different carrier boards. This module can come
with different sizes and models for DDR, eMMC, SPI NOR Flash and various SoCs
from the AM62x family.

A development Kit, called phyBOARD-Lyra is used as a carrier board reference
design around the AM62x SoM.

This series depends on the following two patches:
- [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot device for non SPL
  https://lists.denx.de/pipermail/u-boot/2024-October/570156.html
- [PATCH] board: phytec: common: Introduce CONFIG_PHYTEC_K3_DDR_PATCH
  https://lists.denx.de/pipermail/u-boot/2024-November/571543.html

v2:
  - Dop DECLARE_GLOBAL_DATA_PTR from phycore-am62ax.c board file.
  - fix underline length in phyCORE-AM62Ax docs
  - explicitly define build steps in docs, replacing include
  - Verified make htmldocs is working.
  - picked up Reviewed-by

Garrett Giordano (2):
  board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
  doc: board: phytec: Add phyCORE-AM62ax

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |  454 +++
 .../dts/k3-am62a-phycore-som-ddr4-2gb.dtsi    | 2798 +++++++++++++++++
 .../k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi   |  252 ++
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts |  137 +
 arch/arm/mach-k3/am62ax/Kconfig               |   21 +
 board/phytec/phycore_am62ax/Kconfig           |   37 +
 board/phytec/phycore_am62ax/MAINTAINERS       |   14 +
 board/phytec/phycore_am62ax/Makefile          |    6 +
 board/phytec/phycore_am62ax/board-cfg.yaml    |   36 +
 board/phytec/phycore_am62ax/phycore-am62ax.c  |   64 +
 .../phytec/phycore_am62ax/phycore_am62ax.env  |   14 +
 board/phytec/phycore_am62ax/pm-cfg.yaml       |   12 +
 board/phytec/phycore_am62ax/rm-cfg.yaml       | 1047 ++++++
 board/phytec/phycore_am62ax/sec-cfg.yaml      |  379 +++
 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml  |  903 ++++++
 configs/phycore_am62ax_a53_defconfig          |  181 ++
 configs/phycore_am62ax_r5_defconfig           |  129 +
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am62ax.rst           |  183 ++
 doc/board/ti/k3.rst                           |    1 +
 include/configs/phycore_am62ax.h              |   15 +
 22 files changed, 6687 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
 create mode 100644 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 create mode 100644 board/phytec/phycore_am62ax/Kconfig
 create mode 100644 board/phytec/phycore_am62ax/MAINTAINERS
 create mode 100644 board/phytec/phycore_am62ax/Makefile
 create mode 100644 board/phytec/phycore_am62ax/board-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/phycore-am62ax.c
 create mode 100644 board/phytec/phycore_am62ax/phycore_am62ax.env
 create mode 100644 board/phytec/phycore_am62ax/pm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/rm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/sec-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
 create mode 100644 configs/phycore_am62ax_a53_defconfig
 create mode 100644 configs/phycore_am62ax_r5_defconfig
 create mode 100644 doc/board/phytec/phycore-am62ax.rst
 create mode 100644 include/configs/phycore_am62ax.h

--
2.25.1

