Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D6ECD6E46
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C59C846F2;
	Tue, 26 May 2026 09:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AB0ieRnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB7258469F; Tue, 26 May 2026 09:53:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC33F803C6
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS1hOFTBlIWXcYvARpmm5RJkwzKhDYUuwEn7oSx0KkdTNX8jh36c1/pUCVi7JHjBmP14zLxEMmdLH+KIovE4ZRs4YGGfNGv5OfhiVjFZnRC5duooe8hb1XrGcGKAHcezHmHFMyR1tuL8pYF6a08eB1mE3RDydY7/B/DdT2b6SKO5v9hXk6DxAWUxZAe1r3Nf0YpdsCURRqPHKBvzCQ4GRCE9i16XhTLg/RJln1PykGqnyDpW16fMZCbOSPlTlbrcI2ylfBG00aUXtaYbdGbofwXcQKBI1ejy8YSij0wFcspIXtflQqY2vSOWLFqTj9GgAD+mmUA0H1TJtXI8YkEs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkoE6gJtJKuIcoRbIpyqAjKia0fpySaZTfFMRHurGCM=;
 b=H9gLy3FFubKwBwFmbSIBjcNeNZDXS+Gb1Q+EgukUsjiGABQO3LgFZQ+K1mqMRXQPHky3kTTRjrrwtx3zAc/rpyvNXwKp9mdl9nRx7S3pCk6Kfm7zLdsBLvbUoHs9b/3meNF/z2KRXSAdn/zH072Zy3sJSjDEIaPlxhlIaW8sKO/M+7dlHxzC6YSKKRYGFNiPkX4/BBbzUfkPZdvSB9Cud/186s4TI0zpKCgr38cQkoH0aUBn/LFVL03U6U8M6MyMcMEgzTB2//1myxAIE2scCwPcThD0TZ6AVUs5kvtEnat90PYXSGfPBnteClP48Q1gP+8fA2Vz+BANo7o2CtH8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkoE6gJtJKuIcoRbIpyqAjKia0fpySaZTfFMRHurGCM=;
 b=AB0ieRnJhRkl4GwOx75DKyj62PzqssBwzDBWifIolRoem/mLom/+tcFzFHeSQ5mggbBNDoimYbM8MafpXejs0xLTmHr41SXulIxKzbCF9/o+PLoCRlZvKDYotu7LOX66O0vfAPcJUodFdFc0oHp4SqyqYjECg7mbW+MoZsIf3x1eKY4+49orFrbg2NJbaTR0vIRTwHQH6EitOc1665Wj5Y2Pqvnx8Krkev2h1eKL+fixEEuJvGmrHUcf/9s78zMzANs0krs5e9Qgc72inBDVIRCxug6HGvTMpCC8UWcefP9dOLi+S2kR1lIkGpvJTi/vHmoPN16mvAKejgRS4Ar59w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8988.eurprd04.prod.outlook.com (2603:10a6:20b:40b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 26 May
 2026 07:53:12 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/6] usb: Migrate drivers to use dev/ofnode APIs
Date: Tue, 26 May 2026 17:09:56 +0800
Message-Id: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRjFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3ZTUsrSUEt3S4iRdi0RD80QjYwvj5BQzJaCGgqLUtMwKsGHRsbW
 1AJ04VLZcAAAA
X-Change-ID: 20260526-devfdt-usb-8a17a2383cd6
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8bc283-ee8b-4bd1-4dd7-08debafbd60c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: jV4AtTqLgIQIN62/4ye7gER0SCweRyh2ZemHNbJFMBOtFememVPGRiNit/3hHLHxWV+fbh86L+hQDbx/CUYDfGttuC++9nBGwfMdgS0H+/sp18LWEwDHEzpn20Qh48lphQr6GSMtOnmYt7o7wEe6EAZ4bHRNM2JyUbzjHDzqVrJtJtIiyqxGF49paKCf/mVvYSHsUtUjN5pp+GiQ0FQJVveyKcDMKCwDnSkwBTd8hk67xLMlMptzQZ/wZs9O072Y3B/fzTUSVL5s6X4mkwyLv8ZBhwceol/htK5uzIZljzFwNlcV2roTXLIFut0uO1bsRcAbp8Oambiaw/JqXYuw7bR1iVk7PADJKzZprjzV8Rz/ZwX4XBd35uOkXbdEQWlIB5lJUhkSM+hfd8dZ7/Wu9GVeY2H4TYQp4hR7eyK8xISyKfDH6GTny39YgJAafW8Wo2Fpb4WvcnEk4LxuOZbxY+a5TAB+K1IwXMyZextbMZu9erHSOw4YIFesyXd8Tt1ByV0wEqFkrhg+nvsUJDBovsSU/WtGfwT3CLw57b1Q+ulI29JhAy9uc0sRjrkBpIdpbEQ4XRA97VsphyhES1PdI2jmwvfYTT1KCgBJdOPoKNkxYHCyZsfFQRgWlqCSIW17JVuG8r/pjUfzzv0kLjeC7CG1lgHoO8p9GfYTroeWUI45vCM41fV904eUbx0PCb8oMaZ6eCjS/FETaSmGXZKH4iitZlKSamh+pnhnOSbFPwRgyRQbEc6QCWcOKz2RGdHX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtJTjdkRE5LbWk3eFJleFFHbXJaeE9DdC9VMnZBc2txQUxVN0JOcmMzQVRM?=
 =?utf-8?B?aDNUV1h6OVRRU2JOcm5scWtoVUF2QlBpZnRuU1dIaUdmeFNlV3lldXo5by92?=
 =?utf-8?B?RktFYmE2cVFybnVMcWpVSlJEcitLcTBIcWwyalZvVUN6a01pNStpUmNZcXFH?=
 =?utf-8?B?TTQ5VW1zNS9lVjZxSUNrM1F1QlYwdXpJN3R1MEFjL3Jrb2ZUelY3ZnRqdmV3?=
 =?utf-8?B?bzNRSExRL2pUWGdpY0pqZzkwaVJzSldWSkRTVzdtK1YwZ3VxMUVBMEFNc3pm?=
 =?utf-8?B?bklOU1J2ZTQ4emhNVko0Z01Sa0c4MU9QSC8vL25xNGxJYjNrNHFsNWZGUEg0?=
 =?utf-8?B?VUdhbnNOZW1wRncxTXg0djhtQjFEOTVTb2tZY1ZxREttejZiVXdHYWp2Sjkx?=
 =?utf-8?B?TkRMbG1weG9DMWZwV0JWK0RlMjdzRXBHNW1sVGpCdTVyQ2lhOWFGUzlxWTcy?=
 =?utf-8?B?U1kwNTQ3NVFxSEJnZDNHMzlsUGo3bGt3MEpJWWUyQjdRdTk5Rk5ra0s0WStB?=
 =?utf-8?B?eVZ0NVU5cmdQTmQzTHlwSThsNXBvenR5NkNvWmhmVkNkcHBrelY5Um91WDZF?=
 =?utf-8?B?ejRidXlCNnZEV1dsZkZ3b1cxOElnTWdSYjNWazhWTnU0Wm1DUUZYNmxNZ2o0?=
 =?utf-8?B?cXpIVXhFeEJ3VkRPbjVMTlh4RmtMNWYvTXlzc1ZSbk5XV1NDRVpyYWtpVlJM?=
 =?utf-8?B?R3dPNkNXU2R5SXNXMmQ0RE9IZkxhZ0ROcnQrdW9oOUREMG1rTVdGQXlqck44?=
 =?utf-8?B?OEFYZ1pnT1hPK1E3K0lXcTBwU2l5ZlNhVWkreWdmd3RPei9QN2picVU1UzY3?=
 =?utf-8?B?NEQraXFrSmxXSVJZQ0dUSUpFQU9OL0dhL2N4ZlNRZXBSNlV2MHlKV3lWZEdx?=
 =?utf-8?B?WmxjZFlNcElOOU1wMTN1RHlPQ2JXYlRhbk9YOW5YclhJWklCOUw4UUl3UHRt?=
 =?utf-8?B?My9XbGh2MXNPeDZwMTJ1YmJxZGMyanZpL0ZWbzVWZ1ZVc1BMRDAxOUFQRW1m?=
 =?utf-8?B?T0JHcGxnSmFpU3BoTnZBNHJXU2dpT2NLeFBtd3lqbmRraXBpbG9Cc1VSSWhM?=
 =?utf-8?B?Rm9UUEpGUkJLbVBzSFBiczJZRGpwbzdhOGlBZlJNWHVNd2QrWXBnaXI0RWh2?=
 =?utf-8?B?YVFCTkRHZG9zMEY3T3RpdUxkOWJSRE8yWkR5eDVVTm5VSzdXRmZUUFNNa1N4?=
 =?utf-8?B?L1BTT3o1c1FRZnFvWDE5WlkrMTNzWXNLMzRpOFdmd0FTbVlZcWpBT3lJcVRs?=
 =?utf-8?B?SzNUTGJ1NGIwMEJWb0dhNCtncEllUDg0ZktpSG00Z2dTOHI3bmdlL1hjSHZn?=
 =?utf-8?B?b3B4czV2c0diU0ltYWdsbU9CMDR5SXN4K0dTRUZESE0xY0l1K3dDQkZ6Ni9L?=
 =?utf-8?B?LzNiTDlIWW5OTExXUy9NdlY4SW56UGNmWTZZdE44ZmNXWlpkNkFuUFd2TmhQ?=
 =?utf-8?B?NG00VmFueTZrdUpZakdNTmxXU1N3MkFIOUVvVXBxdFhEOU1nUXI5YXU1cmpJ?=
 =?utf-8?B?bFF0WHBMWmpqRmtXeCtKUEZjVVF3NVR5MDkwTVJnQkNjNExxZjNpcEwrckRn?=
 =?utf-8?B?WWdZdlhCRTdZRW0zWmpkbWhaS0lrQW5IQWJHQUl4RmpKV0srM0JyajNtamZD?=
 =?utf-8?B?bmFtSTFmZ2Z2M1JNK2phQkRzQ2JzeGJrMHVMTEM0QzloZktKRFRFYnEwWDNS?=
 =?utf-8?B?ZEJVZEtKZFNhTFFBTzB2RVZzTGp0aFB4eS9rb0N0QWVRRkZzOEFOY3hvQmwz?=
 =?utf-8?B?Y2lkcjJETkxrQ1JlQ1lqZG9Xa3NRR2Y2eHl6Z1hmNlNRMHM1RzhNMnEvSHJk?=
 =?utf-8?B?ajNLdDhsLzFmNXZWTHlwcHpHTCs4M0p1WmtBUkxwakprdGdiZWx3VFJMQkdL?=
 =?utf-8?B?a1RMTDdTbE1Pd3owRERTMG16VlM4WGR0alphTkJOaTZXV1FNdmhwWjNEWUpT?=
 =?utf-8?B?akFjYnUvTWFuVEhwUFljSDJaYkVqSmdyZGF1dmxVVkUvR0ZWc2NWV1ZmTWtn?=
 =?utf-8?B?MTQ2M0tjRWJ6Yko4MW9KRWZyT09vUDltT0dObUNHMEVQV0Y3blZHSXhvS0Uw?=
 =?utf-8?B?TUU0MWZyRTVJemQ1aHJXWXlsWVFJM1RGUDFSNWJSTXdQNmRuNW5udXZQV1M3?=
 =?utf-8?B?OG5vMldTQWhPMm9aclZuajVFMllPbjZzNWYvdGdpYjhjMmRYNTQwUWllNUoz?=
 =?utf-8?B?Ulp1V2VzOVVVZDhRVlFpU0VxRVpRbVRUSnZWWlhMTDZsbGE1dUx4YzdPNlFz?=
 =?utf-8?B?ckRXeU9QM2lmK1Nydko5VVVCRWFaeHFjeDlxdG45UHVHUWE3ZkJLU2tLOFNY?=
 =?utf-8?B?bEtVeVMvR01EdzRFKytwa0U5bTB0RFI0bGRvYXhjNzlCNjEvTGtmQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8bc283-ee8b-4bd1-4dd7-08debafbd60c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:12.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmY4BVVOORMros0m/tcGqmcLpfJF1IgVJXliviYkjONns1LIXUuv2mzgFaXGgltDsNdlOhaz0Y9Lc9tQEwc93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8988
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

Convert several USB drivers to use the dev_* and ofnode_* APIs and
removes dependency on fdt/devfdt helpers.

The motivation is to:
  - Eliminate direct usage of gd->fdt_blob and fdtdec_* interfaces
  - Avoid devfdt_* helpers in favor of backend-agnostic APIs
  - Ensure compatibility with both live device tree and flat DT

Summary:
  - Clean up unused legacy variables
  - Convert MUSB driver to use dev_* and ofnode_* APIs
  - Improve phandle parsing with proper validation
  - Replace devfdt_remap_addr_* with dev_remap_addr_* in MTK and MTU3
  - Replace devfdt_get_addr_* with dev_read_addr_* in MVEBU

Not have the boards to test mainly regarding the musb changes,
just best practice for the migration.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (6):
      usb: musb-new: Drop unused variables
      usb: musb-new: Use ofnode and dev APIs
      usb: musb-new: Update phandle handling
      usb: host: xhci: Use dev_remap_addr_name()
      usb: mtu3: Use dev_remap_addr_name()
      usb: xhci: mvebu: Use dev_read_addr_index()

 drivers/usb/host/xhci-mtk.c    |  4 ++--
 drivers/usb/host/xhci-mvebu.c  |  2 +-
 drivers/usb/mtu3/mtu3_plat.c   |  4 ++--
 drivers/usb/musb-new/ti-musb.c | 45 +++++++++++++++++++++---------------------
 4 files changed, 27 insertions(+), 28 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-usb-8a17a2383cd6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

