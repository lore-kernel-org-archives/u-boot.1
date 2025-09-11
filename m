Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7384ACA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688C6833BF;
	Thu, 11 Sep 2025 14:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SNkzonqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D75C833BF; Thu, 11 Sep 2025 12:56:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42866833C6
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooH1/3akVtuoLaAafwuR+VFbCbrTcUXqle3nUVtPOS/o8uyKIjjutgBXwHenYhiodE54TgBmwrJJ1c5bLPZ3jywW+uxLnyN35SkcuiBgOeaSkjGfWExkMidXfwXpm+CWQlatr3HGYc1X/t2Rrd6V6GoLUbKnGU2pWRzotmf98TmG5i1uN9vDVy8Alyo/A2QFeGGhYEC9psb8u78rMJl1EN85yK/6nIiCdIDlIi9ZK2I9w/HAzFZNOZc7c6y5xslVyUdZvAdf0VJ2HkNSDRmtzV4v2aoT7NCG3reGp0Z+GVZYXNvCRgQqROxZu7d9TO9e6fWTA0KsEY/ovxzZoZSEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cbwl4SAIXJv1s8upv664OvOirww+SdHZWKXpKQbiR0=;
 b=OVgY1mKGssIfw/qV3qVyHy2TfkIxYRC/pNhjhHUsmH2QEd6oY74xvKL85ey6xPzcNB2SjbR4Sckyku4BDfijS1GsF/50ahoQrZOuzu34nvkAekNupaz4/4RXVk7Vmbyx5pDLdH1Cg8wcq2eTH0rsFikaGG/znLcFKc7HVs6UEK8F1NRKk2E8IOIswAfoKI4s607ni6r9XDy8kcDnypTljJ7DJ0rWXXfa/ijkkeiHqZKm7bi1xlTqMRrrgw+oU31ShjbMWKAFsI1LqnQydo6H4l3bzA5U4/rFTeAXfBm0CIvFE5txqmk34WnneB7sS5GJsw9Tu5SFRNmnQIE80t5Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cbwl4SAIXJv1s8upv664OvOirww+SdHZWKXpKQbiR0=;
 b=SNkzonqgCWbNVZ3nGWPjxZ4x98wEVPnhJ38djbBqiED/1BjoGG+NcLpXZo/I/JRMhe6J75L95a4aS99lzEWR6VTpaT6Z4+jz3YEEoMBHzo556Sy0Bv4OapXX6G/mzkQD7DK/FQnqGXv8/BfJ6TVdumySSG91MZvYLVvoL4KXOaNHR7Fjk8yarx7lYrEOLMkKgo+gTMtSVoqzbBGpgg8diif0R0IwoeY55SrcJJ2TBifQhvuF/q2ana6TDo7c3faVIMeLF6H2+mPLivLGJFe5nFFVR9tf3tI+uP5ESLQGX7boo4CBUf4hAzfrduWZx7iHpK54RwSmgwJ/oEsdAfUPPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:36 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:36 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 1/8] pci: dw: Fix wrong register used for PCI_COMMAND
Date: Thu, 11 Sep 2025 18:56:04 +0800
Message-Id: <20250911105611.3664965-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: 45519264-2e75-4ac2-5e43-08ddf121e0c7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GiMnfH8NjR0RExwxClY4k2kd4068xLCf9qmjDcU4SfIhpzu3lqwu2KlV5mvV?=
 =?us-ascii?Q?fHmHOK6eyjpWnsnVv5ZBY4/vWpd4VVhSpE9ImqPNOjn6Q3BfOOopyUTyCvye?=
 =?us-ascii?Q?1FEy18GHzsULf72z4jv5VbE5KpXKgNAKL6Yoxz2DBq683+XyTHeWBBqCQFIw?=
 =?us-ascii?Q?71z9VW8ObaiSvWnjbPvf0uzL0Ef+zBT6LnUT/udLgIiCVJXLQKBdTkhbWl0e?=
 =?us-ascii?Q?HcknyGzWRUuGJRHhNrfTh2HAhF9+Nn6aGYZfHygMomPmyyoYGC4XrT/FA9mM?=
 =?us-ascii?Q?aGNsffZiFzbS+C+SJVjH5aayik8y6AL5vvBsaIXId59qh+juj2gVXec0ChwJ?=
 =?us-ascii?Q?vL53M9mnWpd+9AgZu6lC0RTuwuf5jeFEqxQJCRiJ2SPrhGWcGHFuI8Mxqlea?=
 =?us-ascii?Q?TlBKvfMWXVhLgOkQL0DkoNU4hmQRR5vOKegMeta8UlEpWYeDZp3aaDqscdbH?=
 =?us-ascii?Q?LIDWyZSv4TDFqHcUEbR8/GJ+KXEMOKRzQ4gN5COTPeKWcGC/4x2ndqEhNY1K?=
 =?us-ascii?Q?HCI4iHctlfv2g8qMtd9+kpOhBLc25fu1VWQmFv3qaYdy8I2uxDoPuLpb6jRr?=
 =?us-ascii?Q?4kkYXnyiGFEWokYeJ9Jqm7Bl7f2SPSGJg7tTFJrId3cg0BKL0rqm9WBdLXtT?=
 =?us-ascii?Q?j3H4DAS+6g2xcBh1lDhPUh/Kl+ARz2evgXEe19Ps0CsHVWBsSy3J8pzvlBZp?=
 =?us-ascii?Q?lhP792wt+WGPMUu1Jf3/ZMD2eBx+bqjxXiJibSD8HgvA1zmtfg7jNx0gTDYv?=
 =?us-ascii?Q?R+qG0J4aFOQsay478q94A6EgESLXwpHIvWuVmOwWiVIWv4WiCGy1SexpRZ27?=
 =?us-ascii?Q?JS1uD7htQhgIFFgmLK/x8CICdaMl/uXbUOi3I1rU139vnqDJQ91LwJShdSMK?=
 =?us-ascii?Q?j82f6y9ZOuTqCtGGKrxMbEZM6YqeMAktNeWWWwVQ8hpdOUBOo+6z52rWBWYT?=
 =?us-ascii?Q?cUxK6Qb4YZZnFzinqxDBtUNyOn1oTZav7VCbQuxkIBT0A8R/bRy+DfgWDU2v?=
 =?us-ascii?Q?yf72G1wNFcWDRnAzl8P35JXOImk9UJmfcpJwjeNjtVYqsKXZBkYi4PH70tRX?=
 =?us-ascii?Q?oO08UgD8lJTQfJk2RgFhBu5f+F0tOXas2iJPMxOPRBRgmK5hzZyDahCjQSX7?=
 =?us-ascii?Q?PY27FyjaN86neOY1rtH1BZjn33vwmfQ08dB90NgnAVD8wJ1hXHCzk2DOZEH4?=
 =?us-ascii?Q?6Pf88dil9K07zlUZFfd7/mJgjxs2+apcamoCn22S8gvfVMWxetwTDGCP0il2?=
 =?us-ascii?Q?5Fs3o9jBndXH1wvegUrHO+mPdfummYYhO3qo9YnyR+OO7SU1G0tqvHJ92Sgz?=
 =?us-ascii?Q?MAPOoukdJFmPR5QHqb8ubGDVVbLCPi7jCltjov/K20KoDXqGmm3Vctp4FRGg?=
 =?us-ascii?Q?L0+l19NbSSbXoyvPhdPNzYwUXsdETMa2e6RJfSKfzd6xvVppOVe8bszcbVyu?=
 =?us-ascii?Q?znhvCAxfybJuSW20qla2yUIW9o3e6TY3CBGDx7G5sZchg+WpksxMExCv1XgZ?=
 =?us-ascii?Q?kgBsbBVr03P7ENg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yl0tPDuoDGJeK9Qdhv8OxFaGr7fyb4KU+BnJ6DA3Qh72FQ64QBP6fkM5RqrA?=
 =?us-ascii?Q?1zpmwyrgiboM/M1ClG6zV/3RvDzomH26F2bJ/i1g7stYxAVoYzQcqpo0SEXD?=
 =?us-ascii?Q?4qwZ8ZQrA8ohmEVcRi2ol+wratTip2aHb9le7M2ONIJxJAoOl3VOqL35GrEW?=
 =?us-ascii?Q?Q7e+XhIEoalCdKK+7DYOOE6jC3MYCK4dCJYXSrPajB9MH7pqimf5L3TGWcRU?=
 =?us-ascii?Q?tAcy2uhKj82uqeSk9VgQ6aH5AMDRuuItkouBkvP2wxPTosu4Ravo7AsLeZWx?=
 =?us-ascii?Q?co3iGENhoqlFvKQHv48tn8gLiWpLVA9JrBpF9NR6sju1NKSSZ3t2iGRwWED6?=
 =?us-ascii?Q?sdUOKEJmyHdDUuLiUNAt5mISKQkegKD675RZGBk2AvBe7dgqbMgfPuu8+nix?=
 =?us-ascii?Q?pemzSwpftwtGjczOBB/qKvr8l0gio9cnizFIhX4BFTXi8VUu8RzVK7uSW+3M?=
 =?us-ascii?Q?dn+QScFk886rWZqMrId4X6h0UmwkNHpyCigC37ssaB0NjZjlg9eDGAMXBBlv?=
 =?us-ascii?Q?T5LFYR8TXfh/QoQ3iPrzkz0nCA5EIMQPJMdueA45Ns4xLLLkCUh6cob3l0MG?=
 =?us-ascii?Q?CGVeX/6mbuvqMM6tBvUsbHqW+wepymt7rRt8U+5nfixE9Nn0cg1BT7LJoakJ?=
 =?us-ascii?Q?PsdXcaa6vUyWx8xALZlzcqB4dhr9q/Ki+NOA4uMV19B80mu08Uh/6P+x4Nwc?=
 =?us-ascii?Q?/WJDN4feegvvvucFYAHmhGcqTbKykEVrQbBagTWUh0JF88jazIDFa2CiyLVH?=
 =?us-ascii?Q?iRaalPxKlJMquWDJuXIUqLkGuKt/eEd7cJq1YcPqxu7Wm+Mct+PTpZDd3CRM?=
 =?us-ascii?Q?R8MY2lwBG8LBdy9AuTgeWIs3R2zy9ZMdTEdmeVApY9QGXlcB7Zl/IjbqDrL2?=
 =?us-ascii?Q?6uCA6HpHNDMf7W/Djn2ZawgxIWW3MkPlREXpeiyQkfi2CYpX5KKDcivQwplo?=
 =?us-ascii?Q?KmrBmg3ORlrxPSkqSiYy9LqubJ6j2NAj/lov1eJIjrNKTRYJS49xpfCA5xSQ?=
 =?us-ascii?Q?IA7QuvZwEOhNMy7SwbwL78zM2HLz0c1fLrMQxLZr9L442L+ermlYeoCYeEMt?=
 =?us-ascii?Q?eNRRfjpLZlG0tPXEKvG0rkGp/GyFLNFYgRe1ETBw3ZEd4JPVgQFCJfvAsWkp?=
 =?us-ascii?Q?TA7ANW6aLPzzaTIvHWeu7gs3/f3EHIE1e7wFwImym+5pnH8GQiwRNic7tiwE?=
 =?us-ascii?Q?aFWSLR+j0HE3lRJclokVC5HOhpUFbl8gOiCPaMiwUmEb5krRh9s7HhTVe08e?=
 =?us-ascii?Q?rcK8lk8xh6aVypRuEAa6FRatMyPQ7iDiuvBMbPCCvRKKxCuyNnErR92WB4qm?=
 =?us-ascii?Q?hzJ2D6neNpwNBIAVJ1qMcxk6fyMNoeYsKl+r+4/MuKVzi8SgpCQ4eAiQINuI?=
 =?us-ascii?Q?6v+4R/XCdUxhfZomG5KMOnjeAxcCRXl754pbnQSdKsJdLROKqIu3emQ2Dc16?=
 =?us-ascii?Q?Eg+WGcSJH3rxnTWMVzYe8onGzIDsvLbaRUzGL8DYL2E5+ty2zjLAc4rjAOpT?=
 =?us-ascii?Q?viQxOj1W3qaoEPKWhytROVcX+eKz6fYskbIpxUt20BcF5N2s7qWEYubUouzw?=
 =?us-ascii?Q?E3BxZUEhapDttXDG7HP68cJHConYKUd6wOh8HmDj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45519264-2e75-4ac2-5e43-08ddf121e0c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:36.7259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgbuSMVkEynnDHJzPcsQDFo/zgPsgwxe+ZrFg6jPZDn6Ok0DHECJjGcQjNLmwFLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Wirting to command register should use PCI_COMMAND not PCI_PRIMARY_BUS

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/pci/pcie_dw_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index c4cad019373..4113a9f03cf 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -7,7 +7,6 @@
  *
  * Copyright (C) 2018 Texas Instruments, Inc
  */
-
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
@@ -385,7 +384,7 @@ void pcie_dw_setup_host(struct pcie_dw *pci)
 			0xffffff, 0x00ff0100);
 
 	/* setup command register */
-	clrsetbits_le32(pci->dbi_base + PCI_PRIMARY_BUS,
+	clrsetbits_le32(pci->dbi_base + PCI_COMMAND,
 			0xffff,
 			PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
-- 
2.37.1

