Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8319AE82CA5
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D121486D5F;
	Wed, 27 Sep 2023 17:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Qg91rfGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFED86E02; Wed, 27 Sep 2023 17:31:09 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0628A86D5F
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHkrl0JVEsGOeG67VgHpw9PAniJLV5uNksqVKYW8h/kb3BzN/eY9UJ8oZKpVbQUAG+4FCAKBprLMPS0bjaPIIGCpzv0af/XJKKMENy9kqPBOJPCnhBvjQ/Cn6aSFQZp02biyaxyEHvPgXOeUTA3kutZsv9MKI2OF1zLTrX5+WHOrSMTu7CYaCyC4Nk1otXpZI8w/EI/QsqHGZiE0SvSM5QfSI81uR6cVEN2pwcVvCq4UXW8WH3glGeaSlSo/vAk9aN6i+MC4DpsJal/CfSs1vD0DTrfq5a12AaZ7+ZfYlx+p6XeVS41QhlzafqQl14LPznAj07W2yULIhgPw+4tNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuL02PCPrLrP2Up53LBSoTTczBCAU7+ImQLpEARBH6U=;
 b=kLHEKSEBqopxPyfUy2y9eO45cBfeKcdyIWqK8H8A6Cj1bFk3jMNVlGctA3cdneeZesWnlwu5+VCgwtPilUwwGSiS/5Ltzx6jlitiN14e2De4iG89sEhwE7TDRJ+VYJK0CIB2Ki15895Gf83kKjg9NstjiSA3BsnTiPrx3V0gkynDcFKTNaVUlqLMBVNK8vcjn7R3F0yvnm4bvxgD7HS6jLMDtcvNDtsbzUbahG0ylLu3aNSsU/FazXTPy5U8qp/YhSCtZDGCRX1XaMQaAopVxiNvjamUomCK7UvNVY9TSDhep5H/O+khz7XRi42rTA3FyVuU+rx5T6IipP8sp01eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuL02PCPrLrP2Up53LBSoTTczBCAU7+ImQLpEARBH6U=;
 b=Qg91rfGCu3C+XKoisfWhqnfcl5kPARmGDIC9rg1YNT4vhtjcStuDBS4WZKgPdyOG+vF54NHBqACculbCZIAMCsBeLc1hcKrZwiDyi3O3PT+2EXZwi8D0dv5PD7GLwrcxypoyunT8rVuo8xN6X/NB+dwervRB39XE9aDfNgwEjpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 15:31:05 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:31:05 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: robin.murphy@arm.com, thierry.reding@gmail.com, jon@solid-run.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 1/4] armv8: fsl-layerscape: make some functions static
Date: Wed, 27 Sep 2023 18:30:46 +0300
Message-Id: <20230927153049.12786-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
References: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: df0cf3c2-ea9e-4b46-1476-08dbbf6ec37c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayfnco6M/h7SvwUP+4hy2s6+7aDnQ8Juzb3+2u4h1gIUknHvFRdGpcFMOrgrwDmTYtWiNReYUwYymyqQsuuFPIgJMBu3OizWoEagWcpE9EaIjRJkhBgXfmesPSd9fYKlJXC0dc37EVfYkrUDeXKF8SzkZ8ct/lIhzH5106IswMSCuRNihCqCSt15lokS/7xEg15LmzQLYgD9apLjDkeeQOYqqSTZAUCcTFx4tvhgGr41i9lAgZFl9f8DRxsixietp81QlRI9X7LPGAMWx3Dw/0vUAUMidBav8S1nEg3oLvui1CH56okUAKQruhvrbTnSX5MTXl4TcV+hSUzaYfWpLmx+FIJB0Zn2wCnY1ytrP88itj3VowSy5XHezlTWtTnyN5quokbkztM23iFyIS/gZPLQnHwotW/SJrWeQKh1zDSkX287fipIVGz+ttaaLf/rQFwZUUy5Hi0TGjC1jpqhZlQhZfKs0Ui5wpCkH8VLgm5zKXcPupwkn+foT/roxfF/7Ir2eNFDG7xeifl731HjzRVdmOq76XC8fPNqWcg437kYLvDLZMOMD0KoaQDBRySMwMM3MqXxI0xwL+QJDKy3mEfq0xETjD5vtMJIwTElXzBt+FINkqOLRxJJylPQwXLl0EAlT6qGT0DdvH5bArILHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(38100700002)(921005)(8676002)(38350700002)(83380400001)(36756003)(52116002)(478600001)(6486002)(2616005)(6506007)(6512007)(6666004)(26005)(1076003)(41300700001)(86362001)(66946007)(316002)(66476007)(8936002)(66556008)(4326008)(2906002)(5660300002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39LTz3bP5ihsRVMAuTvSbQ6BJlESlaftS4N4ZZr2rSv0orDor0M2wx9uHaYz?=
 =?us-ascii?Q?oe+FRm0HIsqCIGEs66mBrFaO6B1PeESRykreqaD+ZNvaDH+p5lfL6kDopdmB?=
 =?us-ascii?Q?hv5dc4RiRiz7a4ZhAT/uM1j6hTcU2L/xRlJ/u0eTfZwgvnE0+iCqAf7jBqg7?=
 =?us-ascii?Q?jpP3oFUWMagY9DWdSqMezr/9h1HKrfUyhDTSYnZWoyROX2c82eWbvUX/UqZj?=
 =?us-ascii?Q?EZN2oKme5LNAJUeDCYJ8kwVhFBPEf1GbCATxLybi2M7zJaGKwUR2NyV8WSgf?=
 =?us-ascii?Q?2GEs0iFTHNhaKYO0QTHxcH9QfY8XMzrKkAok7ew3O5eOjUKaOTTSw5HCfoq3?=
 =?us-ascii?Q?RznKhuPtZoXZ6mCViymkfdfBLHXdu/WrtOhts8ZF/Nig+AYRI1tzOenUtA2U?=
 =?us-ascii?Q?ShneGCZDGXTxTUGyO1zuiftrKVSRxan9YEReflgz/AHHS2VUg2BX2/0cPT7q?=
 =?us-ascii?Q?Mt44vBdcJ6i4Wr4Wp8j7nmf/WDDwG7yf6jB4NE/L4/2Wo9wEI3qWGElM8zeE?=
 =?us-ascii?Q?+rFOPqQfkjrEyahT6P6neqf5zV22NSgG+k44DWXM7tLMd5a7moK9q3hCY3zl?=
 =?us-ascii?Q?n4oLQ80dbS3eUxuxBLAeWofl4sYCAAI0xZzrSs7WWUlv3wGqJWeBRcZ9sTzB?=
 =?us-ascii?Q?EHfSYg0XTNqx+ub3H2MO5kyLynqaVJFInHPM03cssfhOMX+DuJmXxXZ9t081?=
 =?us-ascii?Q?+d+yON8km+T17iuwKcujHlyQAAXF5sqFI8MhUkOhnb+zJbrv2F1+sTcIWa4o?=
 =?us-ascii?Q?cCzhW4xlNf3aBVNigI1kAykz51e0JemrF18u0qilldlVrlFRL7HzsEfBkEgw?=
 =?us-ascii?Q?lzchFkryqWNkTC4sH4P4NWVqUfPlyIC3IowFPA3u9QQb8Z87sDSAUzrxV4MB?=
 =?us-ascii?Q?BSKxl39eNUzImIxPGuzeJRRfhOMbB6t1qK08I+FfZIoVZrKEw+vtT5RohnBs?=
 =?us-ascii?Q?+Rpn6ztZgs5hqy+7ivRMPgfWdrvSmZaB0P8Lza+CX8tNI7As2vFiVFoiMQ5i?=
 =?us-ascii?Q?H+IS1/wKnS+Ak9oE4as9KYFN0yhFRGCV8t+MWPoldVAE2YL7+5B7uzjG1dFK?=
 =?us-ascii?Q?4rfEFfGzclTkXOzqVU/SM3zPVwHSYI66xtb48beWt99SVlahKb+lvpxWecYd?=
 =?us-ascii?Q?WSAdN8N6YoDSCjLjASLpO1W0Ub03gFgZrRKzHL0OMp9J+17T6aED/EM+Zshi?=
 =?us-ascii?Q?0hV+c0ukG21P31fwx+Y54+w6uXExRbxKZQwj1v+b6P71zS/ijRga6uWhmvh7?=
 =?us-ascii?Q?Z5iFWV1sZN1ZA0iVnJpDwll3v5pJZT/PN8LGDtRdr7FnAxKBP52TVNtYCozC?=
 =?us-ascii?Q?h+MGkYTX0ZRh0h4q322WvTq7LvsN62yOVsN6qkq7h/MLNesdFt7LUxkuumSn?=
 =?us-ascii?Q?2gegrTAg+BKKkIc+ldOSU+/s8MTbK2ZHe6GUyyjiz3nYzgaZ2Dd6r61Y9Yh2?=
 =?us-ascii?Q?dhZ8ehmFuX/Eq+aQ2ymh5EjceNk41TOUqEji+6naPE4h2tMEMcxItDL+Y2VL?=
 =?us-ascii?Q?5NYT2+YAKz9+O3s0oBQ5DTqOguggfSfsEOq+YISCF1BisW44SKNZ1jJst90G?=
 =?us-ascii?Q?ftZ9KlbVFdEkz98LwJYVX80HKRJ4ialjR8wdO2+I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0cf3c2-ea9e-4b46-1476-08dbbf6ec37c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:05.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yiw8y9l8SgAyugC62CD5tgF7lBSVRJLsPN02OWdjFF8AbylkWKK3w8KMszGLEDw+qiMWE8EqiUFiI4GaT/u9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959
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

Some functions are not used outside this file, so make them static.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/icid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
index ad20d71717b3..c22e73253c3c 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -23,8 +23,8 @@ static void set_icid(struct icid_id_table *tbl, int size)
 			out_be32((u32 *)(tbl[i].reg_addr), tbl[i].reg);
 }
 
-#ifdef CONFIG_SYS_DPAA_FMAN
-void set_fman_icids(struct fman_icid_id_table *tbl, int size)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+static void set_fman_icids(struct fman_icid_id_table *tbl, int size)
 {
 	int i;
 	ccsr_fman_t *fm = (void *)CFG_SYS_FSL_FM1_ADDR;
@@ -71,7 +71,7 @@ int fdt_set_iommu_prop(void *blob, int off, int smmu_ph, u32 *ids, int num_ids)
 	return 0;
 }
 
-int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
+static int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 		       struct icid_id_table *tbl, int size)
 {
 	int i, err, off;
@@ -98,7 +98,7 @@ int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 }
 
 #ifdef CONFIG_SYS_DPAA_FMAN
-int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
+static int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
 		       const int size)
 {
 	int i;
@@ -111,7 +111,7 @@ int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
 	return -1;
 }
 
-void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
+static void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
 					const char *compat)
 {
 	int noff, len, icid;
@@ -140,7 +140,7 @@ void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
 	}
 }
 
-void fdt_fixup_fman_icids(void *blob, int smmu_ph)
+static void fdt_fixup_fman_icids(void *blob, int smmu_ph)
 {
 	static const char * const compats[] = {
 		"fsl,fman-v3-port-oh",
-- 
2.17.1

