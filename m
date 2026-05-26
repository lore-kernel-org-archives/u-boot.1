Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E10CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131B883FF5;
	Tue, 26 May 2026 08:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TitCW8Wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A62844CF; Tue, 26 May 2026 08:35:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15A783EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSWset3VpqU9kO0CXwqMgxPZua9f1PYUPXPB3HkhVSfK79Hj9dZZPOTtB3t+EOCZkcaD8LUDnRjedxHQL44TcJqrxlZSko4PlE3FwoEv3wZIP9Q3+0n31YO6LmkfasIL5w14fjUv+DEWGWdtZ6fbrj0cwiVSuvMTgnh51wzgXBRebSluHs9ySr5jG0tD/z4/S9BEr4NPOVQy/NHkNrbZbxCedrJ2ZYXfoe7Kz0AGrlW/M1/I0AOS/FKUCYPh3e1y94eVAFFBHEXdu4kDNVe7GEHo/KpiPe3IidnSfCnAvtqEtgQiQDweFUKA4pDet9mQg2F3L+V2sx6sj1k4/3hxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T94n2ZlHAupZGGOXGkp26iKtGaAr6qOb0GQTo7Hx2XM=;
 b=O67bIvTFJ/yHOnEA3onGcIUuPmXJtLbSNHgGZUC2KLEOWT2zkwwofcG/0z4liJJtNmjOsL+3DrkCxtRiVnUlT0vXXqPwIcjWQm4RgjH0kRY/NdcxG+gKKhXkcL6/KBc6/PbEvjUUlCDlQKgUD0yG1PKgIZZf5RyFCIdkMnitD33iaFlKJARg/YfJUZ/0MOrkv083DQ+v+cVw76M3t4ORd+5GygmriUzzZqrtiwZGkGYoeme0b08lO5l0hC7VR+akSQs7+fA3KA8kbwb5CjI3NP0FUfPxlJceXJqT1Kix8AS+myhjo2dd1JLCZWyIP9HHlHdlGsigliY6H5XMl5jdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T94n2ZlHAupZGGOXGkp26iKtGaAr6qOb0GQTo7Hx2XM=;
 b=TitCW8WxLirdTckpuTRAt0VduZ3r/Cs8kRz172BN1MX8FQ2SkZHAPIuhv/GIjfTXhwVbX+ivS6CR6xAiTHvYK+E2GEoBe5ga0kyNhH/aqOrRlymOVUfoKx7+SErch23Z2SwPXwElWwMe6d6dir5c+JlFal31UbuAE3sFuOCY9YKX3CrhpeA6SxIqyXLgRWNW5NpT/kaxaSdU83yHPDb7CipFbSXipUsQRNdhQ+zcKXgr9jCHiBtOqCWbpmDRezb6ww4A/22RTNMenpZJ3i5NCo+K9eruFpAg5IEEsxQfelc1MFPHey2MQ0yB3HHB1xJbt5nvDKuq/Teg92bJSEpS6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB7983.eurprd04.prod.outlook.com (2603:10a6:102:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:35:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:35:37 +0000
From: peng.fan@nxp.com
To: sughosh.ganu@arm.com,
	xypron.glpk@gmx.de
Cc: trini@konsulko.com,
	u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] rng: rproc_rng200: Use dev_remap_addr()
Date: Tue, 26 May 2026 15:52:18 +0800
Message-ID: <20260526075218.2801329-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0246.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::13) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: c076c9cd-1653-47eb-179b-08debaf0ff69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|19092799006|366016|38350700014|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /BOAZ7aAkoIceqSb8fHIm23o+gx1mBS6BOZhExci3S01L2svzvecVLP0sIXW28HWpVBXFAms+VGcWSWigagUbf3h3XS5dA3RhmWy322Z+4J7YteMmXcnHftm/f7SL6JcppYGZaw9jbmE5+Zy1oTRRx7GGo0IN/mednvJpxX8QNU1rsPGxMYZiJVusetOeXedlC8ArG2QgfJg48CfJHbt83K2mqF2F4Nc1LEK4Lzc1Sz6RaQN4lQL+qUNKFjGy7qQkBvaC9TGdyQzpeBKwjQr2WRqDhUpNnS9Ot/1JuPpayyzp21HwCurh+H019bVOf8YZm+f5Csrn60ZbSYIYRgQfVq+e51MPWwEGvfP12Cza9fEmCxMSfpG2HxEwXL7k5As2It3dA7KqItyOWIF2Vr13lyPEyQgMFmw6u0qW36b+BliZGsrLfMMtBihX3NnWF1BZusEs/ey61tygia0M1jgDvV68Zp3sAFrFHieLAYMYqSxuFORBnQAm6mdrvDTiwJT3dmYCdIOCjwIGEoO3FbhHbOOOiBtdKy3+55WGxaTMH67V343LURG6u2wceFxC1TT75YqdamSgOi4f6XDGUoD4GPGirzcX1HujHjoWJV3ZvD7ArRzpcVf/4fgInZhzbwOqBvJ+t6KbUwZLxd62MDUCuQTQfEp0npoR3KozAHbhTAKJNptCruZgRJ+OJlYq7ypSrHkPtmQ+O1Kdbo0snVY50FKD3XnvCTYWV0Ab7OCFAtTOigmlZXxGWKC9Sktv6jJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(19092799006)(366016)(38350700014)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88HZiTYDo850jzwThJN4irO5bRoBuIt3k6ufKQCWTy/dP+aqtgdlFmlMEqKp?=
 =?us-ascii?Q?2YCQoww6Js8MA1OWAWBUnRszQE/Ng3PGAKzmNeWjATxZTJgOIWvTy50UctTH?=
 =?us-ascii?Q?OcEVXm1ZTUUgBrHLDLDPNbAGxGfRzd2iGS89H/i04ThTTpsdlab+YUHFNiMO?=
 =?us-ascii?Q?axKGYbw3QVROnoGJEcgb/poEaTAUrmPyi6+t1fsEMnjRbyuEMjKQEudWQ/gG?=
 =?us-ascii?Q?vaDWyEns/j80UM920UUBVHGbPFKEKtTKVuoSE82fX7FeM3XQAWY0tH6DHmEp?=
 =?us-ascii?Q?mKG+/LSIogn/TdgEFndaqqNXQO1Es3d52ou39ImXOg1hGii62WBHZC5PQSmF?=
 =?us-ascii?Q?BN9l8ks+qVDt9VR9p7YXYh/QCArfU7nCkwI9IQ5Gg09gJpYlQARIdlnGhJbj?=
 =?us-ascii?Q?eBHQ27rGoRangbPvnQtop90gLbgHNWxFRHm1kAzxTY3MenWYhEwR3vjKWgh5?=
 =?us-ascii?Q?KbgPPpGH9KxNpcQ4cMulZIqkCdr/8kxmbKdca1V5FDT/s0Ms0bA3lWxrEUsV?=
 =?us-ascii?Q?UNyg7FS+XqvLo0moCdlS4mOa5IwBNnzQlBtk83CSntepxJvfVee9czlZy6s3?=
 =?us-ascii?Q?hKRXwx9fGOZmCjVzNCCbb8mj5ggs2+RrFOURYFP76/DdHVcvWklYwMeUX71N?=
 =?us-ascii?Q?Yk/p6VqCymVp/XIeor1hgCTXqDWRXqqqZeWcnrSvj2gUUe3piVc3C/8YNSeN?=
 =?us-ascii?Q?VhOy27Bo+KlNfEF3PtH9zSQqpYxIR8Vkd++DM3i066DQBomxL4QJQ3qoysfC?=
 =?us-ascii?Q?8YLSuPCdqhTpb1UNAQmqjoK/E2oKrxE28hoKYcftP81fWgxCIBGdEIvtWetE?=
 =?us-ascii?Q?bYHkrZeUCwmcMW8KDM8B3iDD6CbcpgIwueDWhF/fm7dIpg8eDsCNK4YkmHk9?=
 =?us-ascii?Q?3hXQd59YCfTotcIKP8Na7E4ynauvhQz5o4kl5IzZJsiMGGcHIBjnfBt4Ai3Y?=
 =?us-ascii?Q?A2G4GqqxDuGH0V3JfIdOBQxZssrevOz4Og5dUvvv6muuVnrqPM9ycMAcOzzY?=
 =?us-ascii?Q?zs8CPpItGokjyM2GHMLBwfKX/lpb+lgnGwNqo5yyvjXWfghF+cAuC0XsATF/?=
 =?us-ascii?Q?O6I1AP6I7a+LcMc7Y/4MOuxmlCwwaHBw4AI/eP2/sRY0mM9+CCEP5zlpHxHI?=
 =?us-ascii?Q?3igvB7b1OPXczYpkgBhxP801KihE32nfEwVtw6yj+ncODZdJK0U2LHlGrn4J?=
 =?us-ascii?Q?ap5qoH6wBqhDB3HAMvuA+59BsGn/7p5qvCKuLVmXqanmLTqsXit0SmRqZ9dc?=
 =?us-ascii?Q?lwbF/t5FxxmsiDeZ7+mWKTWawjUfI70Z6MorxpJ348Xmx3Hp2RB+nQWLRyMJ?=
 =?us-ascii?Q?pm9Y8yFrTbxF1Xx+H3rMcj7Pu+vTCrMv0t5FLGyWWqNM87CQB8EEqUNBMB2W?=
 =?us-ascii?Q?N8H1E1QuE1C+ryO3fd8td49E3atAiF236tDF1TOwiIAJxzWfmyn58kAuttrW?=
 =?us-ascii?Q?j0A5sJluam1tWLHHXHrVj/1y3Q6SmjoW9x3bTfWnEtyd232df+Z6kaIwHrCn?=
 =?us-ascii?Q?cRr/3aFwJqbCHFTQtV3p0uDinkaS7vxL+2WRfqRqJX9Z/OPb60UO1fiBLn0q?=
 =?us-ascii?Q?kUyawJAACTu8JZM54WsbdCafcy0DKEuOajLW6IzqzMFvqhC6fHnhQ642a+og?=
 =?us-ascii?Q?CgFKL/sgHUN10nP2dafE3WzF29eY/4BywTl/Zh/VO1kNoq+WAnYoyRPiwZcN?=
 =?us-ascii?Q?1GP+7sjTwS4odmQdPY8SjmSUcUCFOpuN98DWNnlwqZL38kfpaKlzwsmlIU29?=
 =?us-ascii?Q?5VLIKM6+Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c076c9cd-1653-47eb-179b-08debaf0ff69
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:35:37.5683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c57MPUqRfUGX3QPPgWVQxgz5YtQbh0HcnUTFQz9jWJCImxsHO3S2FwNQ92etoUvwOmgNbJjW8MuFCcpONOF6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7983
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

Use dev_remap_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

And only mapping sizeof(void *) is wrong, RNG_FIFO_COUNT_OFFSET(0x24) is
accessed in this driver. So dev_remap_addr() could also fix the mapping
size.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rng/iproc_rng200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rng/iproc_rng200.c b/drivers/rng/iproc_rng200.c
index 4c49aa9e444..aa211df28cd 100644
--- a/drivers/rng/iproc_rng200.c
+++ b/drivers/rng/iproc_rng200.c
@@ -155,7 +155,7 @@ static int iproc_rng200_of_to_plat(struct udevice *dev)
 {
 	struct iproc_rng200_plat *pdata = dev_get_plat(dev);
 
-	pdata->base = devfdt_map_physmem(dev, sizeof(void *));
+	pdata->base = dev_remap_addr(dev);
 	if (!pdata->base)
 		return -ENODEV;
 
-- 
2.51.0

