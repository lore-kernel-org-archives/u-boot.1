Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ADECCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5D883A48;
	Sat,  1 Nov 2025 07:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rZzUcFVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CAA83A71; Sat,  1 Nov 2025 07:24:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB4083A1E
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX7vWzygKhHXTbHKM4arCwnD4ykXnTI5WTO8PKnovmyH4wzsO7f9htoI1iJHfd5FZLRhV656U/WGUAVOatKTDZbKNa2yRDpNN/2EswXgJ1PIFZG+huJKLI0+I8ecOujosjBDsY5SO4llO4+7DDpcROsb5dHuGPMyhjxF1yd2zV9CTYa24yxL0GqfdwJGwtNM9+uz8mdprCFogJvR5hnu1Sl4P4D4q7ysAqiSQvC8aIWUXm6eDmlmkS8zLEqVTJCznYzaBULaO36bhl67YaBVgDBw2KHunpJrdW7QFe6Y5OEDaeeU3vlAIelqHuAGPY00jdQ6QKan+cc8aoaIk2ab+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhonbEXR+Qeya0D6PD42IbNeGiWyX+I/yvV6TfwG2T0=;
 b=i41cA/uUxEuq+LOSVspYG8EhVRkhK6IJnI0wBGeqlb4FYFiWLUxGJ5akUXI85qLs9drMI6WWQe5Z1tM0P++tpqLpPZzivJRzKz2JPTcLcahJ1Fh3xY8vsjFuYEvEk9YwPfN4+vRnHTFJqM1SkeFPpkds9r85YT4oXyIWzs8ofYGs5g6cXBw8brND0ai8MPzpULIIuiJ0f96aatHFJcSkNI31J0N2PHlDpljEm1k6dA3xsgwRvK/3HLe5HQjAPusKS2olX3jVzjeXxL3O4QDhohcb+YX2kZjK81qbeEk/x2ovLV/BVrUHu/yK2/+gZ1daYvrzm6f2G7MfLhfwn77yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhonbEXR+Qeya0D6PD42IbNeGiWyX+I/yvV6TfwG2T0=;
 b=rZzUcFVsurKERo2Su1xvOqnFxYeEYKzIoIgZKHj9O8oCjp6k2utIt8fsxxW3xu1kV/i4vGmXEX0eUs4H++kh0LZ7w/HTBYbc9o7n+9uO2EByv4LDOqGAFoeUPj+gCdTuGnbHkKYAy8b/BhTt3y0VoyHW5pKW+ymIwOzyPpHa0oYKg8G1o5isxiCnN1iUzglWz5ZYza98b0o58xgdyCqvNDOX7oexWRYmMK9W2nTOr5z9QoEBA9nhfyQikFx8N+layFgR5IShOxhksoqzuIRPJn2BdmvZKdOecBCI42F7Zl95WPiT8fzCmwehrhziYj2e2BsuCkJl1u+02Doo3CuWtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10488.eurprd08.prod.outlook.com (2603:10a6:800:203::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 06:24:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 06:24:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 0/2] coverity and 64-bit division fixes
Date: Sat,  1 Nov 2025 09:24:22 +0300
Message-ID: <20251101062424.2488169-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3b870f-69f2-4fc4-8d65-08de190f524a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9m+6ZeagXk7D2ziXrr0XO7SgRurgK3/teib49d4/orhFHP99r2NQ3Rx+QA1/?=
 =?us-ascii?Q?ZkIAH6DzUicqQ0PxCQAcXZYn6+U4ToPYm0c1LEWso4xDZoQkQYD4K1tzV+K1?=
 =?us-ascii?Q?T17wXTCzN9ycDWE75IZjQgEfueSO/1f7TC5DUCOLuPDJDPbu+sT8u6Xsyk31?=
 =?us-ascii?Q?lySxVXq5O/7R20jokkV3fmVTVih+SGGNXKskkdpbV6QeEb4n69D9vcA5QMKz?=
 =?us-ascii?Q?ii2aDLGx0As6X6hatZckEcE/AvdRyYS7KAFMJshrC7LM/v/x5tqGr8cV7SyB?=
 =?us-ascii?Q?t8R1bFAuAB9ImNqwhQhSyk7WDbUF2droskkun/l58gXbo9dg90toKEQlCfdR?=
 =?us-ascii?Q?MQHOQeWxHhmTP6J+rtv//e8+2qRmwoI1yasXvuVq3YDqRMjh1MLOfRgaU+AZ?=
 =?us-ascii?Q?Ncx94hq8fgvWUQkhTPWZITduQ6gM0G+glFuMcLnlM3IpVYEjkyNwNW4L6znD?=
 =?us-ascii?Q?D2RPh+st1SHesdhXvUL8xa3LDLsrEX85mmjVrlbnVSGmBxCL+og5arfcuZgC?=
 =?us-ascii?Q?7k4I04PV5nn9x9nQpSWPEp4o6dw/o3/HvdSBs4+p5R9Mtub9ZrvVPM9Ypox9?=
 =?us-ascii?Q?SV95u0Qe+mXFA1+os5rzGDLPcdezR2gRepfD5xC5zjfYL0Pm+4/mnNMxumWc?=
 =?us-ascii?Q?0A2icayDWAa/cJQWybM5moHkMUwxkYG6+F2hNO327mkEnNFfqE7/DHpnCD2P?=
 =?us-ascii?Q?eLsUVIOtq/HbxlrGIQf8OnmK3vydFwIaEUh3edfUrMGDHHu+ca5n9SYYlcLE?=
 =?us-ascii?Q?Fuz47wTl5wmh6Vo3wMAuHG1FbBEqFfkc1Ez+SzdTXZSyUthXcjuieHbfLZxH?=
 =?us-ascii?Q?6e4vCv453fUqe6GgyldqDfb/QLkSRgS1E1HH/B9f8uHQG1Q2jA3UMa1rvUW2?=
 =?us-ascii?Q?QNTyP4tvBRWo8s7jjbSDUk+VhXw84PvPIsyvg8Ow/vlI0vdJahBAFMhvh2gU?=
 =?us-ascii?Q?VyhAu/RXtBLJiW2Tr8I0smpJOUKOjMMqsSNroEAEOlqMI+V0KqLHXD2axp4r?=
 =?us-ascii?Q?tnQ7W4H+fkzjzaiAtz2lkyVPuc6fwo8S5kGB+Q66TyyVEurG/NS/oYLPGMz8?=
 =?us-ascii?Q?xMwdHD8yFr6DcYNaUH1wYFVbMdSE1jnZz64eYQ5EFmW/EIrki+twsPuB7Scb?=
 =?us-ascii?Q?E5jNiZ7FavQjVQRp7AArqdKuOiaYOYsnof+mUgWXsoIzBvhdx6e+Ymfp79v8?=
 =?us-ascii?Q?dX1juTLT3As4P9kKQbOqs7d3B7xEexnNsrwHUxsVBiMtluPBlRwDZnchs543?=
 =?us-ascii?Q?W4jErbX5iK2vHk5YASemlEu+bIj5SB1hkTUlRSTdKFT2El8RhHpaBc8t6m4T?=
 =?us-ascii?Q?jH2j/2S5IOeBtJZVsVdNppmSWJDxAz4rqCBOIHsLxuyQBMPtyuCMO6V1zprU?=
 =?us-ascii?Q?7fgYxjUAVUjhFBNPGNQGaq2Co8BZs6DcsVxU56cPmZMb2d4OB5zx/yCFzMYR?=
 =?us-ascii?Q?sDJpLf1R7yBNTG6vGmh2hv7oBsZQWJvTtQEuSaAzbHRsTKVtqqj+9w1olECa?=
 =?us-ascii?Q?eZEPrPnYUqOww6ZAfTYBayPAgDDe1NfkZxvW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZjZqbTfSz8JgdPNqOGlJxdZ+81HxlJnoXHuET5LEbM8L6FByg6RIKiPQd7K?=
 =?us-ascii?Q?QLrJenwir7jSNap2dl0q32wfQ+1QmN0I/yKT9GSAbZ6E8cb+VXzBt919qXQ1?=
 =?us-ascii?Q?J9rNrnPc2zJwHu2TogbKxlYuOlieelc0oNCf7+HVDkpwouhHyOeb4BXbcoG2?=
 =?us-ascii?Q?UJZofqUui48f13CiiiclrTxDzbbnYVYAtvWciYFBvVPV0xcom1mRbzzvNyQW?=
 =?us-ascii?Q?yCSBE+rH7NaA6RS7yky5Mbdu07mQAfVvMOLtlQEEmu0xYhRiGKzXdquYzYEZ?=
 =?us-ascii?Q?D8a4kUz09Y5qlnweJYiuFq490Tytw+e8M5Vahhz6/VEOIQ2XTWkPqMaiw4FT?=
 =?us-ascii?Q?wjkk/idB5rz3jWP63IoqA0myqeN7ybwrXHo3YXAj83WsJyw0hRg5uDZ0UjyG?=
 =?us-ascii?Q?FP16iX5T0LrWFzsWScpwYAr0lZJ+jR/KArz/HdBXFtAwNjkwAhmO1yruodk3?=
 =?us-ascii?Q?SlbNXEUskfwMEY4WS4BLamdqfq3ry6C/Xtt9OZRoh65w4ej/8v0KloavagLj?=
 =?us-ascii?Q?K9cX20Y3xaVUCxVqTNIXJQRpLEoeNqflPZhlqe5fMDOrTZYZFwFKMtnHZxPY?=
 =?us-ascii?Q?fJGaGZTyrqlI61DBGjHsTtwAfCoHkVbdT1L8ZQvItE1ZgIFMs5Gv184UT/lH?=
 =?us-ascii?Q?jSKcwar3k8ep2DfRq4V8TZQobPHVNPAKz3FnxLxLh+7srMs/aqVmXHxvrfx9?=
 =?us-ascii?Q?K7ey6Iv5QhUQRScaym97S85CdX8h07dQbUj3Chaudrk0SQ3KrYaXymphz8/T?=
 =?us-ascii?Q?V7Y+0gfRVxxD5PQUmGNrciOW9ojtf4EHJTXESQ4aWBpDFe7O2z2IE5Y7XqkT?=
 =?us-ascii?Q?0NPMKK7cs2AQTJI5jXAWdhwRHA9mdMn1vDQHaf/uUqa9pRJoj9Poi6H0OT8Z?=
 =?us-ascii?Q?YIzglffg5w7y+WabDA1JHyj5b5a0sFBBmawVtaYexNbB3zXiLKw0sFwqgyGs?=
 =?us-ascii?Q?zJOzEwXI7IQgr6IGvfgvlJ7RUzxJGnVwrp+8rwwVx7CyNg8pTkAbkzZGbMrl?=
 =?us-ascii?Q?gJE7R/WmFaAF3x10DPDJ7R9XVCXP5U5r6LNh/5zuuZDigxdiYgYhH6qufMU2?=
 =?us-ascii?Q?61rB6OAC8U7o/D9zUOhF8hqM0ODDMjoZyaGeIfK/4dsjfNX18t6DvwUNiNDW?=
 =?us-ascii?Q?+ZCaZlxZQVVetHhxSw9+V7MV0Gd7mzSVIMQmxVbQML233aBMAUSB5qN5syq5?=
 =?us-ascii?Q?IY2PBmQn24WPC1N4WCIqyobSSbOQSIhQk7YsD+4vHBGIOjpJG1V2yiQZX7P6?=
 =?us-ascii?Q?7WAUUML3P33qCYssCfmmpA+qr1yR3fvaomq/c14PvNxgZbmUhfkI3UckbvGF?=
 =?us-ascii?Q?lxQaK86HjnQ5noqUHD9+WL8nEOwsp9Mf9v4ZnGhgglA9cqsM4iu2PPjScSUD?=
 =?us-ascii?Q?gyCtyNEwGxrUSlYdn4Bro1UQhfJolHFAPrpuZkyEcM3rghlLzyB+GaAXVAxO?=
 =?us-ascii?Q?TSg/yNAm9OFpapQC9P4ABmRj2yqu7gR/vynbghOg7x7fJZM8tZy80l0XZcks?=
 =?us-ascii?Q?PWpnHtUfkRaDrJQFGNpWCBNvLvtXe+KM4o+bx7ErZJkdI36xOmqxFmaa7bPV?=
 =?us-ascii?Q?RC1C+WR9BFAj9YhHmjsxxtAqkczUR06tg2a1f2nXnUletJOuy4vVoB9Fv3s9?=
 =?us-ascii?Q?D6xVkTaAF9VmobWw1mus5TU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b870f-69f2-4fc4-8d65-08de190f524a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 06:24:33.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30OYwfN2MCtkVWmlO/CEchSUnfNCwHl53miHx+GLMolmieOlEoUm+UsxMuAmvx0e2VkNwDXvUTlLaXm495n1wkmpIMZQldj3sbVPJuYBQR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10488
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

This patch series fixes small issues founds in flash related code.

Mikhail Kshevetskiy (2):
  cmd: mtd: benchmark: use lldiv() instead of 64-bit division
  spi: spi-mem: fix coverity report CID 537478

 cmd/mtd.c             |  5 +++--
 drivers/spi/spi-mem.c | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.51.0

