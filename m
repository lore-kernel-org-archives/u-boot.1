Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BE8CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7024084671;
	Mon, 25 May 2026 04:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UC7FujVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D792F847AF; Mon, 25 May 2026 04:41:21 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19488405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm/k5L4N3H75QErkF8QW0LWJBVJbfdFTCiX28LrKwWbOJAx8iKSHE0avsfZqm7BXGspaNsnHZtbBcEzQF9rnhkjKYBp6roz1wSq6k5UT+/3PsFx7PFCSr8BikZ/fAuUQmpPtak0nIvbIwSLbIS6r9nh+WcMQGVVV/8Bih4EP7yZazSkOAGRYfrY1fQ9azXUPUDP6Iq3wG3JaPJ9omRimDCd72n8zfFvuMwKQ67AeZl6YrZYbz0c9TfIijMWmrTCXN1lCMEJ2fQQp5ZuDbjmr1YXJPgeN5KWu5JowTB5OjLcuUTEN4q3nXUQUDS/XQr66+I2m40QJ1gF6Yvmhf87RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtRCcESD315TBvfiz8W9KXJWMgfnjwPW4Dd9sOJkcbY=;
 b=oRG8oxfWWPEYdDuHGTKRuVbFLzEhGBnbGx82zXwfL5IwF8um7zo4iQ1GzStpq/LHcMcEpXn6YkfKbQQCILJZCRcxycs8I4SWJfGO0qkvDoSO9Eq0c2tLceNMBczfBuF7Lic3G1N69Gbl1DbIZklQOVkElkna+b0sS3FVmI53ApNscnhnzzBMNbJopRwL0duZQe5bGljdrkURT7BQlxHxQMDvMO6n2fKzOkjTb1Th6B054GWVJDkhOvpDIR8BQlxi4Q2DA1vG9pV4YgKa265uuz/f01oeBLBoBajMn7aarfbzz33+meF0zFAwkus/ICjUzT/4Lot4Qnn092fmugG07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtRCcESD315TBvfiz8W9KXJWMgfnjwPW4Dd9sOJkcbY=;
 b=UC7FujVf+ikbwskDfjbjScbYEKPSspWLHuu5+iMYITpW3mbDOYJtiBujhzaA0qA0LGHmtCXAscoQ0kNHuRtcqNIb1aOqdwHzYPetjhgAXEn4HSe/aIYhnO3BE3jlYbl/1A+NxDH8PxHO8c7YvGGPzj0jsFy6Vppeki4xwATFrfCsgSDxqEBm+OjICqexwml5e0JiMg9+HRLro73MZM3sPFOZAupVYCowFzGCGHzHo4UKsKuou/1pyY9QfSHMlebETrC9dLd62xUwFt7ulrGZcnpX7mowvf/6EDoIRg/0SyKLEy9EGdQP3Fca8WKPWtEtXGU7VvOhYKfmVTO2/FxsDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 25 May
 2026 02:41:18 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:41:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:58:02 +0800
Subject: [PATCH 1/2] mmc: xenon_sdhci: Use livetree API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-mmc-v1-1-018e94f1c87a@nxp.com>
References: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
In-Reply-To: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Hiago De Franco <hfranco@baylibre.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f0b7f6-d284-4421-8c36-08deba0718f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: l+V8aB5A/4vKXFNyvDfsZarUkOI7bf666IYCeNR68eeDuhrIyPr6l3lImEkbEmYPysS2ItDZ3X7cEWZi3/QKqehgILniGeHmOl5n8lNKJL5IxCRPEvAKB57q6XLzyPDUs6fZsB7pOv0cXoIBSNFw/NiCEBkjBe8Yuf0sFY6kPJysdOtixF45ljYHOu+DBQpbjj6Yzxv+/XmHgKiQ2r5UQePzFgUiZXcwF/eMUVpDnheh8/9Lz49YUfVU0nuLo1lvsl1bbZ5HE4oeW8FCTgG8NDpjyzKAWIMSeRdAiLikVMrqLRrAQg13F36rljej0GUPI6I5kG0gJCPcp3dqmTAHa4Vuk+GLNw1K5BxRj6toXVGMaW65OxST8pcEChsp9S9j7nfOveSLznex4Dca/TrQJ8YH/6FdQZl0GR5aysCfFQoYWwz4A88AA+dRrObTTzdoXs5RF26boGlr7RH4W2bf/LRWEY65l97DdLRMiEVx+U/YaWTqWZmX6s3YBqAr9ff84O4xO151KfXMRMfXE8EoVPzI1C+InrZr2bePm1Fa6vZfxVucAB6R56CfbgoIdVNpO+hKmqxLSVYomu62VxOpEjbW6ysNnZLDm1v5/86ReRnUNjf5YPSlXc7Seu3wzbuno6BXzFv2bmfVqgcamqijXc4yVmP6zucXAXczElKATsEVVVdTT3jS4/KMrSqUy/mQl8iPllgzhV4BpfciYfqS4FWlEbJfPqkU33WGMAshcc3sxmsYlOnWR/1j+H2mZQez
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHF4cHh5c2c5MFhxSFBFQVRIYkdBRmFlcW0xT1NRbURyRVVabE9kVGZ2SG1G?=
 =?utf-8?B?dWNUaENKL0pFUGxvUUdUeU01ci9INFVleGpqWklBZENRYVl6S1dlNkN3VWpU?=
 =?utf-8?B?UW1id0dGc1hIdGVBTnBlT2lTRmFzVjdyMEQ4TzVSY2VEeXpMZ3NNeDl6S2Nx?=
 =?utf-8?B?TWtwQXVCd3dHRUQxUjdRRmIrZnA5U3BFcjZNL1pJRHhQalFQUFBSWTdUKzRm?=
 =?utf-8?B?UC9hVmt2OTJKNGNEN2NjQ0tRSmRQQzcrMm5NdXcvQmE2dXdqWWQ4OGZDVUcy?=
 =?utf-8?B?M2Fha09DYVFoN3JPZUd3eFdjYWVRQ05XN25IdTdiY0FPemF2MEJsTXBVT1JS?=
 =?utf-8?B?bDVWYnZJNU1EV2hGd2Y5QmRKWDFZd2xVVDJFRFM2QUJQbDBRSTVoaVNqYjZn?=
 =?utf-8?B?NnVMditlU1JMak5qTGdjTlkrMm9NT0IrSjRIa1Bic2l3Tkc1SklXMnNOMmRT?=
 =?utf-8?B?NExUVlZLcWNXYlYwL3c4cFpXM2lNM01CWkNiVi9KR3VYWE9qQVZaVFpVcGhC?=
 =?utf-8?B?L3plNXVDQ09iMDA1S3M5MllrdnRkK0x2QzJ1bG01WStHS2ZZYnQrbW5oK3dQ?=
 =?utf-8?B?cUtlTWdJS2Z0cTd3YUhIR3p5MC9mUzNIR3I4cjBibmpmRmFESWFvUkxjV0Rv?=
 =?utf-8?B?djc2RExHSWVPNkpZYWFnTVBuUXk4RFFYekRwTE5nOFBBNTA2R0x5dXRLejIw?=
 =?utf-8?B?ODBlUUJHQSsxbTZQZU1BWHpGNUR0UEdYRUEzRldVa08yeTVNL2kzcE9lOE1R?=
 =?utf-8?B?c3VqVGdaN2tSWnB4Sm5wWlBSTS91U05mblR2UlhhU3RkVGpQcjJUV1JGOFow?=
 =?utf-8?B?cnc4VHBXa2NtSTVzNVRGTXM4WG5vMlZ4TnhEb2FLUHZWMEhFYXJlbUt2MVlw?=
 =?utf-8?B?RFlvN2ZDZjA3N0dTNEZOKzRsdkNBZHNWM3NCV2IrYUZFYVRmR2hQUm80L1dU?=
 =?utf-8?B?VHhKa3VjaUZKOGY2R0s5NkpvSW1EbCtYLzFoV1ozb0ZnWk9EZEhwNUNRaEI4?=
 =?utf-8?B?YSt2dklMTG1EUHQ1QXp3QWNRV0MzOFZGN2xJR2xETG9mQ0tLTHdDMjlGekRj?=
 =?utf-8?B?NEtQMVZBVUtqQ0NyYllRaW1ZcmdIVGhXdjI2SGluRm5OalM3Tk5HN0VIMmdH?=
 =?utf-8?B?cHQyREJEUmtWWFcrdEhUWEx6elYzYS8xK28zdk9lS2hoWUx1QmFKbEc3WjN2?=
 =?utf-8?B?QmRTdTVSK1l5QjhGZTdDWEFlbmdlQVd0dWZYUG1lQkZRNWxydTFZRHFOb2lH?=
 =?utf-8?B?NE44VU8xRy9VbHhuQ3cxQW85YlpqRFkrRitNaWlFUHlkRDRNdmg3VVhFeSsr?=
 =?utf-8?B?TXRxTG4yeHFKUEdibVdFRVNCbVZrd1orRTEwMllXa2Fzdkh0SEhtdEx3SUZr?=
 =?utf-8?B?Mk1XZTZwdytMMEIzbzcrY3VXWXVrMTBMWVp3NUFaMUN6RjB6K003WTdmeWRB?=
 =?utf-8?B?azNha1pZcW45QzdlR2N5dDhHbW5kQlJsUHpBZEZuRjV6WEhJOHcvaEREVHND?=
 =?utf-8?B?eVNOSUpkaG5vS0lIREdUWW1FbGJBQVc0ZXV2OEdFZS8wNllka0h2M3RXcUFq?=
 =?utf-8?B?bnpEemtxSUh0b3JCZGpLY2dXY0ozZUJHTGhWS3kwTHBnbUdNSWhGZ0lFM0p4?=
 =?utf-8?B?M3VXdUNKSlJhbnZkOWhEZExLOVpJMTRMZGF3eE5GWVBIMVhScXhnUHUzWE9S?=
 =?utf-8?B?dUphbVphY1IvSWZVaVVENVN4WGZoaXFKNlRsTGg2M2ZPT0FUMjNIc1RlTHpj?=
 =?utf-8?B?SHpST0dxUkc0TzF6bkJRdm4rbFlhOUFjTkh3cjFKb0s4VmtnMHdKem9WSm5K?=
 =?utf-8?B?WGRIbHd1UHYvWkxXUHVSN1EwV0hRMUx4SG40ZkxvT05FM1d6WHNNUFg5N2pB?=
 =?utf-8?B?anFCN09ieG1lSWJDdHVkYm1HUW9sZmpJc0kxNGtPN04zc2liWm53TjhES1RU?=
 =?utf-8?B?QXNhODRWaGNiYWFjbm1PWmphRXZxVS91N1lvb3BsNEdxZkROL0JGT3RJYWdq?=
 =?utf-8?B?U1RYKzB2WEhSTUgxeTM1SkxwUHVmV3V2K0FlRDJlRlRSQ1RVMy9FbFNSWmFI?=
 =?utf-8?B?NEIya1ZZTDVnZ3FaaEhwZGtGTVRDWUJqeWEvbnozNGR1UjQ5aVJUdUErTkpV?=
 =?utf-8?B?djg3NWx3dHJhZXZ0VjRxdHdJekpNc2x1VkdEMGdjNllqbUFtWmtPOFRiUFRV?=
 =?utf-8?B?b0NwUkt3R1A4cVRHOGxYeThRRzFjLys2dmd1WlZSSnFPbjVZdTh4aHBiS0N2?=
 =?utf-8?B?NlhQdnh3dWhyN2h3SWpNdjBBY3JCZTFjSjlGcUFSeW4rNks0UFNjbGY1bU9z?=
 =?utf-8?B?c0pHbzdPR3haTGlVc3pUM3Y5QnFwMmE3T0M4KzJ0UXB6M0Q1RjlrUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f0b7f6-d284-4421-8c36-08deba0718f6
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:41:18.0418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaNgGQBbMXj3n6dQY7JoMg2g9C48C0oO064O4jeABfy141ZsiBXEfmwXh/z5wavWxtj9hAx5PXjWorC4tCgBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
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

From: Peng Fan <peng.fan@nxp.com>

Use livetree API which supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/xenon_sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/xenon_sdhci.c b/drivers/mmc/xenon_sdhci.c
index 0e4902fab77..6aa73792f96 100644
--- a/drivers/mmc/xenon_sdhci.c
+++ b/drivers/mmc/xenon_sdhci.c
@@ -537,10 +537,9 @@ static int xenon_sdhci_of_to_plat(struct udevice *dev)
 	host->ioaddr = dev_read_addr_ptr(dev);
 
 	if (device_is_compatible(dev, "marvell,armada-3700-sdhci"))
-		priv->pad_ctrl_reg = devfdt_get_addr_index_ptr(dev, 1);
+		priv->pad_ctrl_reg = dev_read_addr_index_ptr(dev, 1);
 
-	name = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "marvell,pad-type",
-			   NULL);
+	name = ofnode_get_property(dev_ofnode(dev), "marvell,pad-type", NULL);
 	if (name) {
 		if (0 == strncmp(name, "sd", 2)) {
 			priv->pad_type = SOC_PAD_SD;

-- 
2.51.0

