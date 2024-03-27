Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C024CD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D46588019;
	Wed, 27 Mar 2024 14:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lXGkFcvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD09880D9; Wed, 27 Mar 2024 14:11:21 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 165BB880D2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIVQKPtsFdKDXFBGL0Wat0gPSxjcbEkpccfauGIGR9IkFKi+WzoyASrdnOxeeGfPLTy4LLnRMsJsBQqeuPM7VT4nGMvJAE1XkOL9e+wkJWMaxWQVpfU0dVvPdtW0Hga9F+TN73nF7W9e8wCBwKcYOFwLgLNSX8tkycoF0rAno/I57FFTAswGtrqDXiouhWMak4zNuajgHKKyzRexp2bAfSEwGn4/GcEQ1RABEJoQpCHY8lCR+669t6yFZYiFzrqNSYKObYM9HeQvs+tExXxr3b2w2OmaNLXZfFBYQ7wCzNaM4MngFti3ja47nOv3SXtZsTGkZnl0j5jUKXCxKAV/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=kI2NSWxh74fhR1mQPO1+mr1cwxdB27wrupjVVVVx2p+Do/xCYRwmHxAI0ydi/QfZ8DMqORSPTo3dbvMpZhmjenFDUo6i+M/taCz6EdsiAqEi99AXX9+dqv5ZVtw3CpLz4IARReCvLqb4lj/rkKEKUwji3ZhsFpNT6cYqMi/GkipGIe8HalNaQ7Ttl3ifxJkkz1X/lRWELkmS/68idJSLknxzEW4Q5lWewaOCXgKk0n6R+itkD26E+1+afnB+LKoNox/46Z2yqSb3hq4cwfD57gomQslCNcwO3Mkf7Cmxz4XZhy71IS9vO2aLJlGj9Is+BGx3j3iEzK2J3ixj9lT+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGHKDlu7iTW2jC9AZauBYtxtmV0PjeCY5piYfD0f3VE=;
 b=lXGkFcvB/DfqwhOER6VY5osK764dtnoTIGeumtzJfhu59LFAB6iuvAT5BNB/Lg+M1f7LgHzFAj+mybMKHLFMVnD8WQFLzzA7+N/auAGk9QJtMxaw/D+ASXMyEdohvzf2h2kdfIQz8gp7gYSB0hBLe1MU602Kw2LggUvCQUE0beI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:46 +0800
Subject: [PATCH 2/6] serial: lpuart: use ipg clk for i.MX7ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-2-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 216b5eb0-c3f5-461e-22c4-08dc4e5f626b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sE8WMl00Bi8xQmg+pg7FCO+pGmUtrXDgcYMIJIeCRRDxT58kP3siCNWXFMpKYfYIeCEG+0mazkLRHWMiElSwu5OLFVjsUr+tZqWZuSOnB+if/8NMiw/KOjvKfoQ5kzCyKXPoAvzVqW5Tb+ZFgE6tggFHyeHMAedToyrK1GUo9mnNy8FH9Xzbq1f1R49x7Jr80eShqBuDrvBh7D8RwyA7AuUNBNzGvp2/mM7gJ5i6/iDZ1HVMsJMGEXUoLbq142p1Wg5J0nSf0ESj1OtYZvMEpzeJyf+YBsTVdMtN0KgoG2hcP5U7aRBqG7E4++iLyfl4Kb9du7azr+7yB/TnxiDDhESpJbC84iKbFIjPR2oqyOntttI8FgrinIK7wBDEspx5cRxIF0302pdJJ+9Vgs/8uNV/MN8CdZi05iNX3C6n/X/XBGu3nWUTxigvFIQiupWBmmfyiEGlh3nLpczrXKWbTJtRonV1Ja1gZGXwtJj2E31Uj1R9IXntfj5lNc3zdCivRRmf9lFel45ijvP9veEke0+AGCM/12oDCINg8mw/L34izOaScQsYY+5KVVGEEcR1uWuXfYH21d+ECiwKivcLZdoPRxw4SSmw2Mz3745AyoJFLdIVXpZs4tpnvrPeyeZD/71usKBj6g2zU/txFppfJMT1CCnPhGNcGFMHbVqymK6q7847z8agFtd/u0HiQkW0k2geOqKmTSQyIpgNLFHjIQ9cf8ZVsjio2WMuZ/1WCXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVZYkdVVldFa3p5MzhuSmRZS2FFWFJzWmZKZThDd0dxdDlCUkNZb1ZwWG1m?=
 =?utf-8?B?cXVsanlCa2lMNlNVOTh6YWJHV0ZEcGRlN1pEUGxVdkdXcFBBQXk3UnUzYzlh?=
 =?utf-8?B?QWdacnRwb1pyZDcyRmZjQndrclMyR05uNHB1cXEyR05yZHJqZ0JKNWNBMjlx?=
 =?utf-8?B?aVhtazhGQTh2T3B0dlVOcDN3S2pVaHVPVzFYSzVOang1dUdIbkdORGticTdZ?=
 =?utf-8?B?U0lremVNbnhadnphOFAzbmJicVBJeWowd1BhQ2R3cVpsNHpOL1ZBT3BITVk0?=
 =?utf-8?B?ckplelJ2aStGSlhXS1V4d0IyOFlUd1p4Z3VZTmFLRXI2ZVBVQ1BoaWxBL3l2?=
 =?utf-8?B?N1Y0b0l4SHJvOC9hY3V1US9yNnRXTVlreDROQXU5aUNTZHdTR211MldMOXZD?=
 =?utf-8?B?RmxZV0dURDNLQWMwNEFYRUdHcEo1YzFnNXRwcFhmRFNKbGVHemN0L1pFZXlT?=
 =?utf-8?B?by9Fd0JmRWJvbFBZWUsrcUlrVU16RVNSV0RvQldBZ1U2RFFodWRvdGRrTXlp?=
 =?utf-8?B?cXQ1OVJEd1d6a21KeWlpSEdSTERyM1MydCtlSzl1cWhUSGhFbm9tVmhwT2lu?=
 =?utf-8?B?K3VDTlFkUkV6Q3FlVFVSeGhTMmhZVnIxT3dnNktzZXF4S3p2RTkwWUlCYkZz?=
 =?utf-8?B?THh2aW1EVEZNbkNtdnNzUlNtZkF3YjE4WTlHUVNUWG5rZ3JxcDNOMHZ4UmFi?=
 =?utf-8?B?dTJqLzAycGpmYVI2QmZweUNJM1E3cWZKc0EzRnRNb1FUODZTTCtxMGR5a0ta?=
 =?utf-8?B?UTRaQzFSRmZXbEFUNkhDenAyckNUQTRZYUFOdVJ3dnZ3VFVUV084SE00czFo?=
 =?utf-8?B?Y3JGQXp2YmpRbWpRVDdKNTRoaktZeGd0MEhHRnBRcmtJcEFoR0pxSXdNeUJE?=
 =?utf-8?B?RFlYa2FOUC9paThUNml2NGhnRjUxbEtOSFF0R011aFFtaGZIS2dvL25QczVh?=
 =?utf-8?B?S0cwWGVqVW4yM0R6bU1NM3RhRE8zOVowY05BdWFkRS9sREtWYmxMUTU4QTBL?=
 =?utf-8?B?NmQ5NkdyL214NVNhNGJScTZiN1hTOUJ6Wjl3S3NKTFNnZ2t5SGg5MnpTM0l4?=
 =?utf-8?B?bHpXL2k5eG5NTVMrUHZLUzNMV3dmd1ZMQVNFckJkWFg5a3RQdjZZOERTUzFH?=
 =?utf-8?B?L3dCQldSQ0VLQTZLYno3OFhGU3RTZ0VUZDV2dWJtK083bTlLSmt3Yitiakkv?=
 =?utf-8?B?UUN1TTY5SzBxY3U5S2hUSDd5d2N4eWtZdDJrUjc2cllCcXdHUnVpTCsyOFlG?=
 =?utf-8?B?YjM3MGR5VCt2YmN0U2NXdGUyays0RHVoam5CMXlqRk94TXpla0JncitGc0pu?=
 =?utf-8?B?TDd1bnE4VmZ1YS9PQ0pCdzNRa0RuRGpacGR3V0ZFaGVOeHQ4RW00blE0L2dC?=
 =?utf-8?B?Ky9iSlpkR0RmeWM1REpTdU0rUzhxVWh5UXp6a0ZzcVc1dEp6eW1aOUFiUzc2?=
 =?utf-8?B?VmZ5S0dYNlZPcWFyWUZiUlNXaVJQanZkTlhhUkJRRXhCRi83b08zZGljaGhk?=
 =?utf-8?B?NFBaaHF2T2IvTzFMUG5tSVZvWUxYc29QU3ovYm5vRlA0QjdBeFNmTnZKYllt?=
 =?utf-8?B?UFlHWHJiSWVRNkFlcnk4L3NUbXpBQi9QMDNXem9HeEw3SitHdVZYMmt6dVJV?=
 =?utf-8?B?RzNuTHduSkd4NmpPVnBHUkZlem16elBISVJnSFBDN3V3Uy9jb29KYmVxNlVK?=
 =?utf-8?B?VGsva2ZOdk5UOS8xbStaQWVleHlZV2tyaXI3dlppWUY0cHc5ajJxd01FSkVV?=
 =?utf-8?B?TWRXbzBzMElDYXprTVIwcGFUZUVUQlVvU2xtV2hjOTJ2dld0cVVGc0VnaURm?=
 =?utf-8?B?QXZDV1ArMWlEL29oNU1QYTYxUlpJRktqOVJMZ1ZGeXp0VEI4TGp4bmFKbmp3?=
 =?utf-8?B?c0IzaFJ6Tnh1NFlpZUxORjhyZHpvV3BRZFBzNFlqdXdNSGxaWVdFTmNGZVN5?=
 =?utf-8?B?T3RKTUZYRzdYS3NCRk9iRmZDaXFpdVRIWjhZQmx6dzhmaFBCM1dwZVk3ZjNj?=
 =?utf-8?B?UkJuSTJxMUF2Q0dnL0tFejQ4S0h5Y2ZXV2I0eC9NUjdXMW4yUWV2MTFUWE1r?=
 =?utf-8?B?ZjJ3K1ZsM25oTE52SUZsNDU3dENUaHh0WG1MK0puMzRrU0MrNHg1cGZEOEsy?=
 =?utf-8?Q?I4hCp1IZ3xdfDZdPrVjSAi02u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216b5eb0-c3f5-461e-22c4-08dc4e5f626b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:16.0963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoEunxT+DCK9FjAWg8nUECoOHCxotBdstTdGr2E9JK72APXruyMyEY08k0xhIFnw7DzNrQRnN9jor82Gan08Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

