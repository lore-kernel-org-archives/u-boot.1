Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15923C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D002088124;
	Thu, 28 Mar 2024 00:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U09fmX3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75A387D2E; Thu, 28 Mar 2024 00:53:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C66B8801A
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSVdCEwWl/UAaY8Bg679c+5wZpgZZ8aBeLfawKa58MX3dIkP1GyWBawmy+o7ykYn90hAMFE1+tAKZgqjSiMneIr9pM7KCeVbSUh3R9aVx1ieWGRpmB/16LCsY0owcXfKLaIVAPwzYKiow/wvBBo36tJ8FHoFvREOWQHYWoFsrW2BmSOEGT1bdF9SLI6BQq+4XcTEOMlCUMKOTGyw0k5AVFnvX2bc98rgipTlzCtXc0jiH+ZtVeUcCPBq2zyAMh+x33EVpomApPyoKhft8J8OOToVlAi5seRI22jAfRVJDa6C8v6L2JgsBIQKT+N7m2jO4VeB6zb8rb26Hsc51HnOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=QdPclFNHqbBOMq2ueGer7MUbjLOeSr9jSYkKAoyeTlIebdXgcJD/9AmbPRr7fEALSkIbXLNKpKAMY4GyyM+M3BowF3XUdfVG0n3xYo2rggdUOsV/FvpZ1blCWi7A7SzeWNEtzcJSS/08mDklYnWdKYSEMiD5vIapBo51T0l0dnwbkDXgnMSFlcKN4y0oKboSVbJOA0PhyfMLDasa1m8XxNiQcrvMF/HaREZvTVl9YPTfY0N48yIFEAQKxNwpH93gxTHPzqUmvfhcbsisoA/QOpI+GqfwL8CFVz2tXsJGCSISg+rkdn2swZzs0E2ez3vgHQKF7lRbcgPTXMJIYjkllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=U09fmX3BPqk1iBwFYKL5S3bhNWAs3CPG+yKQqkVvEkOGFV0jkiBQU3ajSTfykvrv0mjJgYxgvthddRdjvr5mrQe+G5cAvywcOxdZBxSkkYbCCW1r3A2FnWf73GqBRGbxIaR7rVUiXGqzsXPgF6VG+dRSo1jAyYAqb4pthmIRumw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:52:59 +0800
Subject: [PATCH v3 2/6] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-2-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7532ad-2b6e-4f65-87d5-08dc4eb9192f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8MSXGTncIucsAQxuMASCzUSv1CjRvIP5xdUIlqhzjEBmS5OeOCy1503qbUvUx8e8kN8++3Kk4OFmZqVPzfbyE9Rh/L8zqhIY5Wu0/Y74Pq2z8XUEFW2kunZbGV/E9uI5RW3QDmF8J5zFehdWTpwglkTWqczkc7Z59Ox+Mr+1MP65XmFcNQ2hbqLe/P6ZNMb98mnIoTeRqVL+Ws7fARyF0eb8iiKhxPqY6PMYjdBzfoUaoZ8ZKpl1waT6kbkbXn9Qce/TfH0zM2IXjMT4VdXvqfTAbkRXIlHp5xZiGGBR1CiEnnk++E7k9R1DrgcDjx1MgZ8UlCgEVKLLH9VnxsZKDjy3zkBTgOVZ1jzR611pyq2WwR6+NdKezLUVubrCVDU3itjLqu1BrAs5xfQymtWyqxvsLvUJ/KUNV9b9ESubd48Occ29iRIbeHSJwCFPV6XT0nG4FgmrHa68alk7exeox8JMKGpbFMNygkpgQbPC7cN4eBL8mrClj2bAo5mkbIi1pPYg7VANkUZ+n+hCJeJ+1fx1yfO4moT7R4zwyTzUusKAl2HHFhrbS3r+O/ZLp/Z9AlBaXvVcHYZ2OBaDvI83xJ02IC5QheSpJ8fUR+rVia5Efho49VP2cPsgSmDqp1Rl7dQh1qn4F39nDzRVinIi7MCr89fAIbZXmiobUnnHBsHuzNnoK2WSJPq81n6WqzRASITIs7jt5XaP0sepYHwEiH3l8/BwIK2FJnRBiq9Pc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdRUTAyTkkycWRuRnZuSVF4L0dmbkRPQ0JZUGRMT0xOUE42bngzaXVBSmxE?=
 =?utf-8?B?c3hNVUxEOVVlcE5FRHVjN2o1TmtSSlRWZnBHaUpiSnNHQ3p5S0RQYW50Zm5W?=
 =?utf-8?B?VUVpaWxzRXYycW5NcVQzOUpuQlNmeUIrRVljM0xuUit3OVcyQ1VXMGd1MDMx?=
 =?utf-8?B?eTliTEt6OWlOalRkVHc4d2RmSlpXZ0ZvbkROaVhKWldienlFTndWQ2N5OGtX?=
 =?utf-8?B?TVIrTVlFV0tjOFlLNnBxOFFpa2dPN0tBMlJReVZKTkJZUVJMdlluZnVHM1Fv?=
 =?utf-8?B?WkZKWFcyL2E5d0YxOGwza0JWSjlYc3JuMzBDWUFRVFhGMjFyUFp2SzN6VVkw?=
 =?utf-8?B?eEpHbWEzSDlKeUpwS0hUaVlJaGFqOFB5K2kzYmtqajVteGtwd05ZSXcrbkp3?=
 =?utf-8?B?Zk9sS3I3TzB1R1M4UVdZbDJpVjhHSldQNmdCellaNllveVRUYzB4cnZXakU4?=
 =?utf-8?B?cnBCbzVnKzYvQnROaDV0dE1KYUVPbkNVTUl5aHRYODFoV0lvenRZNFVXaElP?=
 =?utf-8?B?eWVyeWUzR2xhVFVyNllTSjkxMGVoV05TaldGRjFPaUUzQTZKRTBNTWQ1ejZx?=
 =?utf-8?B?QXB1eEd0TTcwWHFTajNtOWh4TmYwMWRWR1d3dVl2cStadUdMcFBYUS96NGFZ?=
 =?utf-8?B?Smd3UVFrQWEyK1BHRGhla0Ric21LZThVN2RZL0JwU1Q4VVR0empsSkNhYWRG?=
 =?utf-8?B?eVNvQ29GZnBwcXlhR3N0bGwwcVByMnBETWk3cEhsd2IxWU1NNzN5WWtBVlZN?=
 =?utf-8?B?M2VHSmFUUjdCZktnWExNNFg0eEcvOEJZeHJCS2N4V3FRaW4wT0s4S0JTM0lj?=
 =?utf-8?B?Zm5ETkZOanFFWE1ZSlhSU1o2V2VaNXE1azNEZFRESjdIN0ZoUG5KQTlBYU9n?=
 =?utf-8?B?Rms3aGRhZDludUw1cXUwWkh6dUM5b1BvN0lEazlaN0M3NnY1SmhLUmkwMktE?=
 =?utf-8?B?REJPQ0wxckl3SkJPVkZjWXhZcnY2NEhnVmlvTnNoYmVZRHVPVEpDYVFKak5j?=
 =?utf-8?B?NUd2ekhjMVZuQWlCQWxMTVROQWxYR2dPai9SdTYwQkx2eW9yS3hHRU5LVlVJ?=
 =?utf-8?B?c2RpN2JZM1FCUU9tQUJwWUR5djNEcXFtSTBUeVJoY1ovUU1XSk9qMzJOcDdH?=
 =?utf-8?B?dy9oRkJsN3BzSElheE95clhsL09vUmVEOGN1L2toaHFPU1hTNmZLNkoxb2lU?=
 =?utf-8?B?ZGw2SjM5RTdHbGxzdWgrSXcyRlh1TUttVkVEb05ZMFl1SGYxb3crQVdBSVdh?=
 =?utf-8?B?bjdXM2piaXBieHJPUG5qNkxGMmh5UkJxT3lIdXR5QXpXdFIvYlZxRE1qbk1n?=
 =?utf-8?B?cDFUZm12MTNSNzB4RnYybWYwYkJ3ak00eDRlbCtJQmlwakxLRTdMdmNGWHhY?=
 =?utf-8?B?bWgzQ2xwNFhjZ1dOcHNhc1dwME43Y3pEaVpKRUNrUS9MQVZSQUdlZ0tJY1lN?=
 =?utf-8?B?V3IweER0bDJKTGtud3hMeUZQd3RRUnpUQnlWY2FZRngwN1d6M0dkdVh3N0tV?=
 =?utf-8?B?MXZvYjdrN2s5NnlHckdaNVpmd2ZOcXFVL1d0UzdabGh1aHJGTmUraExSdzdw?=
 =?utf-8?B?ak02M3dXODNLN1l6SWw1dHB5U3VLTW1paE5STnlZTDZhalpZMDBTR0VtcFJU?=
 =?utf-8?B?RW5JKzNsNm8zMytuck51V0pHU1F4SmJMWnA5SEw3aUdsNlJleUNqVVpxVU1w?=
 =?utf-8?B?TzNuQUFVUTRXaEdIVlZUaUZUbmhmQzRPalpZaEJKTWdDQ0FxaFZCTE94YzAx?=
 =?utf-8?B?UHgzTk1kcmNzeUZhME1GTUFrcGh5QllocGlZU1lCSys3SWJBa1NZcXNpdHVQ?=
 =?utf-8?B?dSsvczBYQ203eEFjTzN0Y0Y2N1RhZnZ4N1ZjeC85TlA5THF4WWxGdUdJMzh3?=
 =?utf-8?B?Q2tyRXpLdUdVV1B2VHJPSnl0SE9yaDN1dGVud2thdTc3NWpLVGdBb1ErRzd6?=
 =?utf-8?B?RXU0anZSY2M3WHhBOUJqODdFLzQzYUppT0R3Nkg3emdhcWVtUVNKNlJqa1JZ?=
 =?utf-8?B?byt3bk15TGNvTld3blZxSnRwclFhRHZzd3lXQkVXZ2dzUHVHRXBxUDRBa0Yv?=
 =?utf-8?B?YVYxZkdCWHRPM3laWkpueXBrNmtsWVNPQkFhV3F2U3VSZ2d0NC9JSWFrN1Vu?=
 =?utf-8?Q?jFc7k3OBL8K7LqmlabyYcHkpu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7532ad-2b6e-4f65-87d5-08dc4eb9192f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:27.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7SoCe5KVGVUV7m4A+EW4vBO0fPcW1B1BDgsjYJT0uNqagaM9j3NSv+LUKTGuL3g+l3nu+BKtBWc0v5VE8o3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

To i.MX7ULP compatible lpuart, there is only ipg clk, no per clk.
So add a devtype check for i.MX7ULP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/serial/serial_lpuart.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index ce08a6b4486..653ff99e67b 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -111,11 +111,18 @@ u32 __weak get_lpuart_clk(void)
 #if CONFIG_IS_ENABLED(CLK)
 static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
 {
+	struct lpuart_serial_plat *plat = dev_get_plat(dev);
 	struct clk per_clk;
 	ulong rate;
 	int ret;
+	char *name;
 
-	ret = clk_get_by_name(dev, "per", &per_clk);
+	if (plat->devtype == DEV_MX7ULP)
+		name = "ipg";
+	else
+		name = "per";
+
+	ret = clk_get_by_name(dev, name, &per_clk);
 	if (ret) {
 		dev_err(dev, "Failed to get per clk: %d\n", ret);
 		return ret;

-- 
2.35.3

