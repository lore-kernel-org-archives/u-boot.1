Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD01CD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7625D839A8;
	Thu, 28 May 2026 08:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="stFhDV45";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A0E8341A; Thu, 28 May 2026 08:43:39 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C87F803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDSvXaH6bdIcm01i0SWeKf69jM3Juw8xEBxgD9RK3LYFiZ9G/kttSpGMtIKiTKukoqDPPjAZ+g3om/YeyncrzPbBvDaKCSkR35Y+jSCdc2kxkg8Pj/NG4LcJygSti0Tw+oEol2WlVmaV9bwAbvy3zruufZDFnGFBndINSMTltshI1zxvFJWmptCRYbkSvgicJCfwJEaFWKNtp2uDu8CvyMW13P2SDUHbxmry/PV42FG0b7gnNue/zPgBexDNcxrTPAqS5cPYInMw5x5B7hKsckZaFMBgNynV9P2QMSDJUCiGiDE2wUpu9Qcx+s472USQmfGmkfi5FRAJTSQKUA9JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouT7EwXJe74uS1eJok+PnvBBoVU2KcdojxVOiiS4+XA=;
 b=h7XUY1S1KNQEAcM38mLYnXykS4gUhI+m+WCJZEychTW4U7ArepqViLU7V0/Y3snF7NAs1b5mezTccfpN5AMW3iccY3wOFayatD/hnTuPnUqVMeklkF3OTNDAd8UkV56UkOCExZs3cI1maO5nhtkq9mTBUNINrUjgk4DY/zsq2HVmnssIr5C8D2j0eFxa+a+NWjGCpkJ4eFbbEVyCl6/PrKRQOsdfgUdOl+sWP868on+D2SvMhmR0CoGmQT4xO2E5ZFb8K66jcLlYnkDyeKnmISrCmhu6nGkP4PLLV8p+1FCL5jStkIQ/lzI/bJMMr0h5iX/X1J3S9ZCHK6uAOAKt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouT7EwXJe74uS1eJok+PnvBBoVU2KcdojxVOiiS4+XA=;
 b=stFhDV45U0p2t2qEf6iICx8n0orwFBLdR2pGtS9wOCMUHnaadkwTaVyJ4T/Pvko6Kz3qXwXlPrux26kadYMvw/xFvAPLhCRtqE95v+XA8eoNjTjO/buMXjeupXVWgpza0Xc81/eBJkWtHSBi8qJRtH9i+PX5efF1GhZAza+xNKN//4IalBatJgdqGshYPVZHY/28QDRoKfMqGIcrQXeUWx/51Vy60JctCyZtLDDCjs4DJWcwo/roKJhZsnZoqnh01TkCx2V+daUYRavQCPq02g2ltp3tmAoC442aAfnW8M4TNl1nZ2Efiew1eHo/QZ+MWaHqf8RyBJvfBrcgnz7FcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI1PR04MB6880.eurprd04.prod.outlook.com (2603:10a6:803:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:34 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] net: Use dev APIs
Date: Thu, 28 May 2026 16:00:18 +0800
Message-Id: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABL2F2oC/23MQQ7CIBCF4as0s3YMRSnWlfcwXRQYLAuhAUJqG
 u4udu3yf8n7dkgUHSW4dztEKi654FvwUwd6mf2L0JnWwBkfmOADGirWZPSUcWaWpNBG2usI7bB
 Gsm47sOfUenEph/g57NL/1r9M6ZGhoosYpboJJejht/WswxumWusX55p8eaIAAAA=
X-Change-ID: 20260526-devfdt-net-a0fe75cd7f49
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI1PR04MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf7c392-f7e4-44b1-71eb-08debc84700f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E1zKCBxTE+bKJ3VvCAjjxfB3Zx1BT+W/eQVL5guegTPR1BLZrhCR+uP97+nMMtYyggRi/9ub3SKDxIgdZemqzhVwsOH8QtPg+Pgx0LEbw9V9DImw8MyBzhEgEuwoI+XG1YrPgHRmTtW8WwH0vehayAA/C591fFA6mphIFtREu7i/t5F4ijzYlheXtOBdfqvl7uLVStzSicH6v7QxfCahoBMYvEXKfLMbHNpY71FjCivbb3XD9Ps8kiMzwMC4fFL0/jKiaX+kKKuuA4h0mqedsLUDXGPYD/rkznkWUs6P9AInv8JYp7C0/3kwQsUj2JmvO+ur+ee5T3Tk5Rv4/BCrLeDaXQFRVa9C0u9iUH6tLZv2ewcBqtU8K4DHKQc4UeShGIKw//7ZVL73lqyVb0zIxA5m1am6hZfyaT2Vu3DaTE3ITNNDF6t27ea4nlzNmtpZfnOTl9U56gN2RF8qouoFJQjG3qPzttyfjd0TbypmGHwnKmC5sSiZCafD27lmOFIYQ9Pqec0MIqJ5MoYxcmdcJGIvlbeLqHoEWCDeZCq3Xu5jCQTXLyvT092eMXh1E1mWaLhZPM2JAKhwFRwWPxT3Wb7SDi94E/cyrvLeoZ97yKxL94VPzQsfd4CjatKX6ypWGlsXAsKHYWWJCRjQ0Iac01ggXFd5sv2bwcDh5YFnpAM79yWUp5qmwsJy1Yl4zpMR5OyYyxhQ/qeeRTqMq0SVYE1MEa9F3tXNbdNooN5IAISjAMVPVquSd5yGIZ8F7fGH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm8yZnM0ZWlWRXZ3bUhJNVB5cGc1OTkxQktvWXV6OVJNdnRFNnZNalBka2Nz?=
 =?utf-8?B?QzZrRHRhYjhHZy8rbFVLREs5ZmM2YndPZ3EwVGI5bFJudlVab2dCUkVKSjJj?=
 =?utf-8?B?SnFLL0FWMFNIZldCMHFOTmNvQVhkSExMNEQ1bVFFdjJuR2lsbDRGYXNMT2Mx?=
 =?utf-8?B?WVQvbjZpTTBxazRublJQZlF4dkFlSW5uVVREY25hNXp4WGVJQ2F6c1BwM3Bj?=
 =?utf-8?B?eU1PSzl3VXEySlYveGVFYTE1aHl6OXBlSmRURE11S0tuNXVwMXJMeDVYNDdS?=
 =?utf-8?B?NGlWcys3NzlNUWljZm1RT3dHVUsvQXNwUHNqMmdxTklIS0txWTdSdmYxS0c4?=
 =?utf-8?B?d2I2WHBicUdIaDVLdDVNdTB2c1Y2eTllWHI2cHprUzFCU2ZqblhndCtsemNO?=
 =?utf-8?B?NGw3ZXV1UGFLaDUrQlBJSDVrZ3dYRm1TOEQxdW5OeldSOVZxL0VxbzErZHNz?=
 =?utf-8?B?WWd3T1hIMkEyMGZlWFQ3NDg5OElaQ3ZLZ2orS1lYMWlPNFZBeEt1OFVTMFNX?=
 =?utf-8?B?ZzhNMDVjZmNlNWRyUVltQ1phV1FidC81SHpvdE5Zdi91L0dVWitDRmR5TVBs?=
 =?utf-8?B?MHRzOFBxWHhNcWVRL3RBM3pEbDFqUW4wdHlNZm5DbkZnNlNhc1dua3B6WkNG?=
 =?utf-8?B?SnQxWnJCWTZJR25pQlBEZGo1ckgra3NrYU1xS3hGb3NrdXRLSk1RMFhXNlVX?=
 =?utf-8?B?a3ExSGUvUnM3cVN5Ty82aXNubExlWVZzcGRsd2k4QnpuT2xBa1BxVnpHaXIv?=
 =?utf-8?B?WUZ0MUJMbU0weld3dklSYlRlcTRrMUNPNll0TFlSUzlzUGhsZC9vOXI5UFkv?=
 =?utf-8?B?UVI0VnZxRW1EV3JRUW1tLzJCeFRnV25KbzEwRVN6NmFKb2tLcVhjS3doUlpV?=
 =?utf-8?B?OG1scTN6OVdxUC83SVgzd3hIbGlGUGRXTUpWVklGSjR2WjN6ZTFpeWgxeWxM?=
 =?utf-8?B?QXo5WTRHNXBUV0liM3RZODhjMDZUdWZRWlZSTjJPTFF5TEx6M04ydmhoSTdM?=
 =?utf-8?B?QlovTjVJS1U0ak1YK1R3akI2dk95eDh4dGMrL04vLzFOSFhmSk01ZnNnS3pZ?=
 =?utf-8?B?UFhCbk9KeWFZVzdEcGxLWE9KaVFTTUxjWE9GWUNrMUNGS3IvWU51QjVZbkFz?=
 =?utf-8?B?NGZFZlBKWjZ6UGhzWFljTGdKKzA5Y2xIMTF4Y3ZnU0ppUndLZXFLMmRmZjA1?=
 =?utf-8?B?OG03UVVKZGlkYm51SGFtNzYwY2o1T241ZEhkUnFvbnVBbmdiRE85RzJjNnBI?=
 =?utf-8?B?bjRIdnBJS0ZYU1o3ZzZkZVJOWjRCRFloSUhsVTVaSXFpWHBBSW5jNGl4N2tn?=
 =?utf-8?B?TkJEajg0eWV6d3M0dzJXS2FtazJvV1VreXhNcUhhQ3lzU0lRN3k0cXpERE1D?=
 =?utf-8?B?WHAvSWlqeWkyUkxFdWl5ZVJkczR3bWJMME13ejYxNnJIZmg4UXB6NnorYWNJ?=
 =?utf-8?B?SmVvMkNjaWJiVnNqazlGcW5XcFYyaXVWSWtNQ0Y5bWlqOG93R0dSUldOdlM3?=
 =?utf-8?B?YW1lclA4RnJYVGUwTFIvWVMwbFk2bDNnYVNkSU1zUFI2L3V4bXczdTJlNVFL?=
 =?utf-8?B?eSs4elREUGhQaGFSdHJFNS9Wcno0bjdkc0JNbERNSkJ3Y0hiSzZzb2pFMEd5?=
 =?utf-8?B?LzZ4dC9IM0NpYkR1L1Y1ZDY2bHR2eERqdVk1bkNyN0prWW1UaDBoeEtOcVJU?=
 =?utf-8?B?bGp5UzZYak5zZUdxMWVaeWtXTW1EcXVnb2ZDelI0WTFsK1Z5WjEzenJSWmIx?=
 =?utf-8?B?VjY5VVVkSXRzWlJDcjI0SXhCdjZpMy9UbW5DT2pSSDFDUURTdUk2Z2xKRlhL?=
 =?utf-8?B?SjNpWm91QjlhY1lpcG91djY0UFpVUGdqanRhT3Ntdkx4QWZJTTNjbG9NU0dr?=
 =?utf-8?B?bXBLTzJwZ3FGUEgxWS9xQy9PbFYrTjg4WFVuQUh3SU9IK0xyK2ZSQUIxcXlS?=
 =?utf-8?B?NWg5VHpzcmN2NGg0RWt1cStnQzZkUVpTOGc5RktNUEUxMll3Z3VHRk5jVFZj?=
 =?utf-8?B?VDA0bmxBYUxzZlgzYThZSk9SdHd0OFlLdWhHQloyM1NJUC9yeEpXMS9Vc3BY?=
 =?utf-8?B?alFvcWhDOW8vMXJ3YWVMa1d3OEw3aFhNSExXV0NZWW9yZUFHb1ljSUNvV2Zy?=
 =?utf-8?B?TUVLU0R2ZWtXT01KWHJOZjRDbURmUFBvUjV3U0o3ZkJ4dVp2a2hrcTFrK3hq?=
 =?utf-8?B?cmQ0U2J3YmJ5eWRtQVFmRzFyTytPS1FrWSt2M3A2QnZkbEUwTHo2aWRkdFZL?=
 =?utf-8?B?UnJQR0NUTVNvTU55OU1NYng1WlNZL1ZOUjF3TStjYjlvck00TkpHeklUeHNa?=
 =?utf-8?B?NVhienBqVVg3NUx0bTh0STVZczlvRjJFRVpIQ2hBSCtyZHFMeFlzdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf7c392-f7e4-44b1-71eb-08debc84700f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:33.6340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbsvASxb96B7feqSTcPUbBjgGJ9ho4BMM5iwEcEzP1e3+3+1cyb2pZsHVWodpm66ocZYljAT2Fqh7QdG01hipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6880
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

This series converts several Ethernet drivers to use the generic
device model APIs for device tree access, replacing devfdt_* and
fdtdec/fdt_* interfaces.

The goal is to improve compatibility with both live device tree
and flat device tree backends, and to reduce direct dependencies
on low-level FDT helpers.

Patches 1–5 perform straightforward replacements:
  - devfdt_get_addr() → dev_read_addr()
  - devfdt_get_addr_index() → dev_read_addr_index()
  - devfdt_get_addr_index_ptr() → dev_read_addr_index_ptr()
  - map_physmem(devfdt_get_addr()) → dev_remap_addr()

These changes are mechanical and introduce no functional change.

Patch 6 converts the mvpp2 driver from legacy fdtdec/fdt_* APIs
to ofnode-based interfaces. This removes dependencies on
gd->fdt_blob and updates phandle parsing, subnode iteration,
property access, and device lookup.

No intended functional changes.

I not have the platforms to test, just best practice for this work.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b from Simon
- In patch 6:
  - drop unused variables,
  - drop error return code which not follows "No functional changes".
    This patchset is mainly for API updating, not indended to do 
    functional change.
- Link to v1: https://lore.kernel.org/r/20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com

---
Peng Fan (6):
      net: ethoc: Use dev_read_addr_index()
      net: qe: dm_qe_uec: Use dev_read_addr()
      net: calxedaxgmac: Use dev_read_addr()
      net: dc2114x: Use dev_remap_addr()
      net: mvpp2: Use dev_read_addr_index_ptr()
      net: mvpp2: convert FDT access to ofnode API

 drivers/net/calxedaxgmac.c |  2 +-
 drivers/net/dc2114x.c      |  2 +-
 drivers/net/ethoc.c        |  2 +-
 drivers/net/mvpp2.c        | 56 +++++++++++++++++++++-------------------------
 drivers/net/qe/dm_qe_uec.c |  2 +-
 5 files changed, 29 insertions(+), 35 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-net-a0fe75cd7f49

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

