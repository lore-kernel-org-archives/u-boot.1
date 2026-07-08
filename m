Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEF2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E213C84A5B;
	Wed,  8 Jul 2026 14:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="V3o4YUv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5862084994; Wed,  8 Jul 2026 03:13:24 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB47838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WROZjR2ZhFtxXlCuwF1ear0noIJYRj4Rvwe+46sq6ui9k/De1NX7YtaRziI1kRtXy6Qd2H+DQpL2vAAKE3mtdwAEgosFVBRSH8H0kEUDxdI44wSyAhbS08MSQGu24Zyhfa3XJbI/D1RGrkUvALB+rIPtt2qKVwQni5BhjANnWluvjTuQlyE2JbUOJ/ROs8NCvNIhyIJTKfOjRCvZ+1e4JJsw+CcOjb4YJDTxRtMEnq7VBLv5coedEmqnU063b/1hPYleR2GDFK9qkTW2M9/XE0v84SmU6ecCsfI4Z6hyDTACEv+AQyvfbX6GH/uiL7LSjvP7VNwzGSVwMCv6nSF6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxCLC7UtDtF2nyZoLkaozjpWTf9++O0Spwn81PXkddY=;
 b=KnNhPPXL5M2zhgr2fihtbnus594wwAaOBYrs2QUW38fQpnu/sPfN3m3WxBnwdjHodlsxDKm9BVe/oIteDJqlMorqKz4JVRLSJWx8f9vTKMHXs6BSzUFPr9jQKSoOo8IBfA5f0LBQqQmcDapuTwrkr64ZhdwtyWKlP8L9wnAEV6Ay5B8Fsm59d63Qa3Wyg+sybGh6472StKP8VhchPcO5fVxzUuFO7UPSCILHLLh2TWg2ztJdHBma8eKzlWZUHJjqdq3Tcok59BK7Cy/TEj9PSFPEJnp8BRhdfKzMyH7g+5QaNPQv91qWpyGcBoweyTJOFZy487t2NbKf1P19LR0N3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxCLC7UtDtF2nyZoLkaozjpWTf9++O0Spwn81PXkddY=;
 b=V3o4YUv8XSFs7IqtgznpljajR7+TArTHyzld1CTJVpOGqd/8xwQ8tlngVAsiJHGt1IlQ6xj0TRGsoESq8w5y6sfIdqhBnhtDZPJyaC1kLXPCsO+AtfxAdIUDuQfc5EuV2ilICbAiaFEPQwIaBJm8gbJ4U6psd6SqDRdGqVZcGbSNY8OIiCyL+MgekejltEgLUEtMzpyWS/Ox+JQpNCaTMocp0GwlAo5NdS2xvmdkiOIDFlp+ky+nTx7+J2aiRSXV/NsF1tunfZt43k6ceSK4OOe2mMfg9ilacTi6+wjKowC6mkJq4hwC+1W0IJDJ/mk2xj4Irpo+Ts2jtOWE5OVUSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:19 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:19 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 07/15] ddr: altera: n5x: re-init DDR when double-bit ECC error
 is detected
Date: Wed,  8 Jul 2026 09:12:20 +0800
Message-ID: <20260708011228.15613-8-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2883eddb-4637-46ae-6f59-08dedc8e18a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: N7z7Z1R1v8PgC2YGmFOLuf/HHqjTlbkF4gDAk1JdMgJf+KxcL3573ZEopCclsB24Nk87jSbMR6a887jFCQAoWD36eV4BcU8onWhxAh5ARrIHSTkG0/oPmi1aDgWjvGHyoQMKabD0V185hnz+HHlafXSN4K8fbL1ndQ+9YjF4gCoeVXwa/WdUgMZ1gchLzRPOz11eLC+T6+yWG6Mbt4UvylTCmROxNBmWUVQU2UypSmk6nMBrLAyRcYWuHdiZvSpGfxyU7/ryf76jOCArse8Pz15iKlZEOsnJN9EHUQgywhJqxtZXZMTJx1l5zYDywEgm4YH1RNRS9iAp7XJaILYye7f3hsObeWlgbZV0zgdiGTc0TWZkBSbVwiTZrAQZXJiDoSwF70KuZ+M/qDlCJvaVHkQ43q/jjb1E41Y6ZpA2wjtqC4PyzOByudGGP+lvweo/TSA7sbZK0K3m28bA6Q0/A+/01XVtQjlXicipaTY7If92VYIBcQZF1p+Qq5JeFAC+wSAIkwRpsnOBnrLjxFKWsyfrqKvMdc1kKPWemX3dJkQaDgqzDriuxtfFiQNG3szkW1yM7MVplUNqRJH2FczcRRVrV7oihr7ALednFL3tCVPjj4skPCrViTxWyPvX50tAuhR0s3Q/3BhbU6xlq9uTTp2eXa4RKP4+L/62AGwUmEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gh/PyYxurQhHeNHOgY7aAht3i4yciAKsO+c8VPIy7jFzqwVaol1beriwZBce?=
 =?us-ascii?Q?MhqsYeY3Pgzz+Eyt1nvlsvOdOiryGcFhSbQOTbcr6nzg82KfwsfAchbuXGuY?=
 =?us-ascii?Q?s251AnDzoi5oaTHH2VGZty6+c7rXRcQWDV3Ga8eKCbpVxYfWB29WyBOlUxMP?=
 =?us-ascii?Q?7DtDN4fMTuKTrekWCnBz0g+LfjYZ73Dy9SgRfMSgO3cl3PrOwX98fMEptKNK?=
 =?us-ascii?Q?3l7GccwajficTm3KZDIs45fPNBxGPv28f1GKU57EfOls+VCtlJ1W+N6Ntxe8?=
 =?us-ascii?Q?gUXbbPT86+/0d9z7IIs6c8g5jPXqe1adyxcdOIBxjCKo1/vAnrxx2IFqjcB0?=
 =?us-ascii?Q?QJkgXb4PeZxbo7U7JC9KG14tmbUfl0EI6WC85lDJC8yhN1X6Zq4m5N2hBCIq?=
 =?us-ascii?Q?5WyblgPM1QS+nOZe3S9qEjC8HRAqj1owEl7i9PLceWTqVYNXRwc14Dgspp2l?=
 =?us-ascii?Q?f7ynHqQ2eTuLRalC1Bf/BD88VID+tWPPWxS3xXQEv5hyPYpzaEc2BmQI7zn6?=
 =?us-ascii?Q?m3BL1G3JT7RnZB8AfB+Kx81VOdjaOILEyYKkCktyg6fN76kmlI7ibkN4wMrr?=
 =?us-ascii?Q?q6xJAXFgfhtlv1PEKUA5Kh53UsyFWdUTON3ut9jBIB6noRe5kcDNdWjs4ZD9?=
 =?us-ascii?Q?B7lpWR733aaC05ObZQZUoYZEwErGzSj3qEg3v7JRwtxkRfheEBMyCIoEWtjJ?=
 =?us-ascii?Q?4QCGMXoa9zfvFwd5l4al/ALjRNWu78FrL2UOu5FlKkuofE1PZ9u8pWQ+rUMK?=
 =?us-ascii?Q?RQ6deSK1uOCDoIHG2CPydoG9ZPdQww29ma3LTsUABn98VmcalyLNZH5M7L2h?=
 =?us-ascii?Q?IXxnEs2+6q4CdS+B5E7arAFciugKL7v+RChncpoe9Cl+SHoet3i69X5v47kU?=
 =?us-ascii?Q?0pD9ErZTsNyTPqK89JL6QSopxpF8NyIuTP6h8cCN98ekepUNlRgLY14XeWS4?=
 =?us-ascii?Q?EYKx3ENtldbgkvHdORiLeUc3CubL2glGLrCrkH9lqIUrMkYvJ/sfE+clh5Yq?=
 =?us-ascii?Q?VsDykjSZaIi4iggqAxviRNxKkpz8pBLsD1ws31TMkXoo8X1Pe2IFUYB3U/qH?=
 =?us-ascii?Q?ZgICb1bTFiImgN6ok+wDhVaqQJs+TeKpE0+r6nGRgICoWi5qBHkcbYHSCU6+?=
 =?us-ascii?Q?2B1fDb90CfswPSx6HcSWbx7siphG5maVrZne6HMGR5ZsSzrsMqRoTra2sjYR?=
 =?us-ascii?Q?zvbsqYIm9LOc+mbNuf28bsn/gx2Zg9vtrKS658U952teDQWA9mUWOczOtZH0?=
 =?us-ascii?Q?mEhFf2tL9QAAGSvkdyyXDPsw5W+kQW4Dhh2q+qW+qnR3Vy/o/QSUHzXnz374?=
 =?us-ascii?Q?2UxJX3VDhW4+2Nl02txkaMVSwer21D4SZyFj+5pqMiowbJ42SPZCsZJUOSWW?=
 =?us-ascii?Q?p4REGnnIjGLXwxD+Cv4Q5eWv4UQ97KUM7myubzBpW6fmpbOr+HtT5jOKsk6f?=
 =?us-ascii?Q?zliRruqpR14yFe5qLmrGFAfr8WTdhZ0ssmPF1PmFEfXGEE60Sbf3ULwElEb8?=
 =?us-ascii?Q?shGLNZOPA6RDmxXYdNFxZQHcNisy5fqkrTRMI8hd/avqqKqChMRiUWwNEMYS?=
 =?us-ascii?Q?JnNvhQrjAfCV2OZXxcYieQxMs3Iq05IbikmUBMFQEXLZFAPGo5V57OdtAGLS?=
 =?us-ascii?Q?zYtT4otZbi1TuXzAfJp+jc2M4m1ljLonx/lZyVdtm6VWjyUQeiQro+0CZEFm?=
 =?us-ascii?Q?3LZasidESAapTrHVUHXu4aDEWF4vl38q5yW+xTiKEKKRI/qstfrTi62hxnAl?=
 =?us-ascii?Q?Ir9lTTXvw3TG9G5X7bvdLulp4IsJBok=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2883eddb-4637-46ae-6f59-08dedc8e18a2
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:19.4046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCBsj9XE9mc38wRBqjOlBXKaRpqT3O1WflZS9uJzqVhLnYwXVzvRYg++ETF9hKRThxFx6kn1dATVTBsJlM5fUpgmjxEqu5uNDMAqDAPDcyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

A double-bit ECC error (DBE) means the retained DDR contents can no longer
be trusted. Detect the DBE status and force a full DDR init and
calibration in that case instead of taking the retention / warm-reset skip
path.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 9c3f07b409d..f6ce15bffaa 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -421,6 +421,17 @@ enum data_process {
 	LOADING
 };
 
+bool is_ddr_dbe_triggered(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK)
+		return true;
+
+	return false;
+}
+
 void ddr_init_inprogress(bool start)
 {
 	if (start)
@@ -479,17 +490,20 @@ bool is_ddr_init_skipped(u32 reg)
 
 	reset_type_print(reset_t);
 
-	if (reset_t == WARM_RESET) {
-		debug("%s: DDR init is skipped\n", __func__);
-		return true;
-	}
-
-	if (reset_t == COLD_RESET) {
-		if (is_ddr_retention_enabled(reg)) {
-			debug("%s: DDR retention bit is set\n", __func__);
+	if (!is_ddr_dbe_triggered()) {
+		if (reset_t == WARM_RESET) {
 			debug("%s: DDR init is skipped\n", __func__);
 			return true;
 		}
+
+		if (reset_t == COLD_RESET) {
+			if (is_ddr_retention_enabled(reg)) {
+				debug("%s: DDR retention bit is set\n",
+				      __func__);
+				debug("%s: DDR init is skipped\n", __func__);
+				return true;
+			}
+		}
 	}
 
 	debug("%s: DDR init is required\n", __func__);
@@ -501,7 +515,8 @@ bool is_ddr_calibration_skipped(u32 reg)
 	enum reset_type reset_t = get_reset_type(reg);
 
 	if ((reset_t == NCONFIG || reset_t == JTAG_CONFIG ||
-	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg)) {
+	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg) &&
+	     !is_ddr_dbe_triggered()) {
 		debug("%s: DDR retention bit is set\n", __func__);
 		return true;
 	}
-- 
2.43.7

