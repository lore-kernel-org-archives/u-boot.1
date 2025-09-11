Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C9ACAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD050835B0;
	Thu, 11 Sep 2025 14:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="URPN4XOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3241E833C6; Thu, 11 Sep 2025 12:56:51 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49457833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNMhGtSgbLl2DJw5Y6qFYwpi4WnkJrJfwS6v9nR0TJXoLCs/zUd8m1YQIzv5vb8aH46KPOdkkFpIM71yuXZdbSA3g83CIWq/RqBmuPFZgaNCzgGWE56lPza+XPYNoLDXD1guHCdCNStvaVNfHvbTHXe3Gsp+DwCmrAfZfH3DRzWHSIfcJDiaX4Sn25p/R2+qwSW3/5wPQaXCgXwQ8gh/w2tCW7M2eZevYDv1WAL4Xau2VKfdnzZSG3QkWgUoA6ug1kq9+3Y3lErg3IuBBoHlIbeUEmpyGAyqh95Kr4JMDdfNSuSBchokFS5zoAMO+NaoAq1LpNDe5M3pPxmuKMDpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFapok5f6C7fukpw3fcvVwA0pAjKyYefn6czVIKAf50=;
 b=yDSM7CphdQMXcq0Gkcpa+FgKEpZjpA5Pj4MTR1xO3vbEM4pp+Gmo9uHEGMvpFGy1O6XjPS2K8UjFP7WKTN46wrG5lEvkIgtAkEg4TIuzgbZLzuVItNRGyIXj+ZUbTTfxQdtKRCVLDI4ryyox/B8oxz7qpR4H6o1+rSAxXaLSzQCElEpYVAADxy0nl/DTl3WXJdVHXpnfqGNXizIBYk8HskWAGzl5Dctiaw2sAPq+AGMi8MjAy3K0c9nH6fA/dRZaedGv9VRToywv7I9nRmp105UkuEHB5tIS0QzA9J+VVsOxbhMe/sxGXszLxgdQAqRX2g9TxkkympPBH0KefPV7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFapok5f6C7fukpw3fcvVwA0pAjKyYefn6czVIKAf50=;
 b=URPN4XOK3mADX2PAtR/o/xMxibuOgwRh7bGbpCM9/cR4x2T4e80Xf/k5cHwYCLGHYi1XilAuD6ZeuSZ7N02M+/Qd2v8J+Cbu0kiErBsltppuVC3Vrmzz1hdsNtnfG4osssHEFm3eYpZYSOS8GbMOWu4/ROYKOnyH8v/MDKPUB0YLKj8A7Lax/qATPOfbJMuBEJRh4ZJ30XNND7C2wBlf+TVogR0ohgYWalxVehPONvSc5RCSjWKnFK0PZAHxkEhqWSnz9BIqmD9jD/O9ye53/V00im6EtQouSAZx688oKNpRKK24KiiGJ1K0g41mezu9r6P/kKI1RJaVVpdB0HI7ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:47 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:47 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 5/8] clk: clk-uclass: Fix clk_set_default_rates issue
Date: Thu, 11 Sep 2025 18:56:08 +0800
Message-Id: <20250911105611.3664965-6-ye.li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 797916ca-c935-4148-33ad-08ddf121e777
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v/2zyaHvbDCNsTc+gtLhspiI1GUl+FRme69AsW9MUHxPHJ70JyTdPIdBTz4p?=
 =?us-ascii?Q?OduuXfSXqfDChL5Ki3PcUksqEi9dSLLdpigezhvEZQwm6tuzFAILcw/TC95+?=
 =?us-ascii?Q?xO3GWp5rVAGkTugn0QsFiCgoHzUJg02ef2rl3zGFfyQhxWFDBbwLnnQI1OSx?=
 =?us-ascii?Q?X9SVptksJrAQg8OrvXuURkrrYwKEb3duB9OFH6uJGi0ECjRNeuEYiLKEX9Z3?=
 =?us-ascii?Q?ZmQuv5MF+lhNX5wWaFKzPuKB+YZ4jFwCWdwnWd2fuafQMd92mTH1Z2RQ8b2p?=
 =?us-ascii?Q?8CmFEPL788DRucFOrsX5hk8c3EWX2x++VbqrBUdZX4vIF6fvhYdRfYg71TUq?=
 =?us-ascii?Q?J5gl66dXQgT2QYdEg+hEAd8hHmtriN1hwl3I0c1qWKwaEJgluDu01yz55yzP?=
 =?us-ascii?Q?1+y5W8pCZhf4I1BAC9Pgtu+uusbutDuFZkWwuhY1h7VCcfwxpez7CeISjI6f?=
 =?us-ascii?Q?9zaXqU58+Szyv9cN0ghnCTFSW6FnteOge3fAeSxPNQzAqce6IW34zZFy1DYf?=
 =?us-ascii?Q?+jSG8Nfw8erdT3BQt4jfCp28GQHhq1lOOgwJz2xhQzJRPxvJG4jCGBwo43Kx?=
 =?us-ascii?Q?IPxLyjfLwC4MPjTfAyaygBCswq9TrIbB7WqkbSrfG5FtMON+I+RJtsAcUV+H?=
 =?us-ascii?Q?qeNqY2p8H14bigxNFIUDBAhFupKcItYtNPVenBj15GzGEgHGbWVLLkcoHtGL?=
 =?us-ascii?Q?W8/GXDTslqik9x9dVhrrSfLB3SWkMYwGWW6KfeMrgRRSqoccVixxOK8yy5he?=
 =?us-ascii?Q?LAHjkuwrAGvq80QznllcNrNr6FM5DWvirsZEwlgKguhPtBTxBo6OEHKh3rtN?=
 =?us-ascii?Q?kUwb//0Eh9aRAM3XOvqLlSP7O5Do+9EQ78MVUNvYU1O6BxDheMR4fKBLu9oK?=
 =?us-ascii?Q?wycIeZPzoCbNM7LC6Or6TTlh1AHI0L7R7EnSccDe0nV462yF9S0yx06DyifA?=
 =?us-ascii?Q?SmeoH92ua44Vl2x5hJcy8s/e8wvnQ+Wc+hxnb09V6WwZv8CmQLR8+g30tmfe?=
 =?us-ascii?Q?P220ZIBAHkwGil1v3Yuifj0z2QPi8B7BlIVCptgTMF1Xtcz5JRgLB2Q9zIjA?=
 =?us-ascii?Q?F+T8CaIGddHrBPK3CRAK/iqTe7KIZkc+4yZ5lf6XJ15nX00B4EFSc6JHsUQU?=
 =?us-ascii?Q?RlE1LVsaXnlwUPLxIFpVpFCFlR7gm81nAR1eSkRXE96JCHedA0v5IJ1PYC3S?=
 =?us-ascii?Q?ju3E0UJ27VrOhGLa20HO2wyAsUKcxu24RM3RhCS6nkL0u99Hek8ATlK+uAE1?=
 =?us-ascii?Q?dBQNJzw0jWEEzkuTQwIGSAGYukGNEdnIUZBULyTwI5tLZORhITQp5kfciCnf?=
 =?us-ascii?Q?9/r4xNARAzoqsSIsnDM1jvRQzrrjAxvrMtN4DyycXK0Qwhjkc9gfN+/oJ44n?=
 =?us-ascii?Q?55Xg1YGSx9xdX05NNG1deLoSDAII+0bpgizOipC6WKAgGp6OdX0Nk9vzNKMg?=
 =?us-ascii?Q?zaYW4kji7637TLAwG+MIelyY0hq9coWqcsm4tJupHKzbAUnhx9y4w8pGH1Rr?=
 =?us-ascii?Q?f10zP0jQwbpmUFI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkRnadT2GdnBFbbZ3iZxNhoyCe+mkqcNBVtoc3g19fHrr4hIFQirAncCpGPA?=
 =?us-ascii?Q?/0Boccc9WGKW7YbNYWITqCI9n7UQEW+MViPJdSWvELMIUUEDKX+/JIGzVnjd?=
 =?us-ascii?Q?F29yhZpD8igNRfcTb37/gVoXuFqxoUcECKb2HkDcqODXph8dqUm05f4FcxW5?=
 =?us-ascii?Q?wkz8331nZxlJhLkNcdxLrdE9xjjYmEP2+ic2b3xUZsJhjpo5L00Lgzk0A/Ty?=
 =?us-ascii?Q?77Jztx6qsePSPrOVJMlhmu5P9OfHIiGeoPjZ/7feFrZr+lGPuTLPUUXii9Qd?=
 =?us-ascii?Q?N0uybuayHWEm8x21vjOZLQuxNW5TtjcSqLtknNJjXh5OYA3/usTydLeYN7b+?=
 =?us-ascii?Q?3tbvUGsh8ZVq99HY9zndmB8/FsI9HZCvxOT5LalHilx372xl1RzDCgkFaQL6?=
 =?us-ascii?Q?H7J809ljW1/9ActHxTn/RfSEoV5oQDlMv6Yi1iKFc2kjEmoFX2uKpSSnJnUJ?=
 =?us-ascii?Q?b491uy01BSqeCkk16hpno/rEKCxMBvQ7WV/5QKvUDU7Y8TmAV1wQJMBEVLvp?=
 =?us-ascii?Q?CBG630176Om3Jd4jIOeF5vU27nuqU7JCIdLEaINTpdyCjYVlBX5TMLpwTUxT?=
 =?us-ascii?Q?dYNAiOXJrWbo3Tcdu+kHbww1b9Juoy7lnC/ht5nmgF5Xe1qnaadkHAl+hXfZ?=
 =?us-ascii?Q?N6+Q+LpAt1QBdcQB0Rb6LTDosw3lH9E0UgSPpYh8RuyysT4sCWFlCzqlCUdn?=
 =?us-ascii?Q?7qXtZuSGZfkcjCVULpHXCCJXgJtD2HLH18uxvDGujBAUgUDyfzMjStyYTrtW?=
 =?us-ascii?Q?0beDOd2s6ylSIRsuI/4FNWwIg+jf9u1Yd1iZbz0rDNFXhTdYNWpuAbRx7zGu?=
 =?us-ascii?Q?PcWr38KSXqwVoIGtG4q1MsDyUnSfBlVDxvLg50AtfiaL5dW3jnyr9PM1gXPv?=
 =?us-ascii?Q?5RF1Yg/1zOrg136Dv7sQhNrhnzTfQGaUDlxyjN2HP7lvYHOn7SZCWT7pk5LK?=
 =?us-ascii?Q?UqYZ6q/W0qMmNz1QGo18+SlLi9Igee65qjbG2ZvfsXbu9BtZM6ouMpvX4zh/?=
 =?us-ascii?Q?x0XvI9QxIq2e2p03AGmkZshaOImSlVGjA+s5FPTRtL/B4/qPSX+uAzgZG1Mf?=
 =?us-ascii?Q?2t9tI/1hXRnlRCQYpwrHLP3PhFxZniv9VmxZA56IW8btkvXIjE/6Qv9z+Hgs?=
 =?us-ascii?Q?e9oOHoPFB7tX/VuGEQEGd6wCRMSfEm+5Vpeej7wzkgeLQsj7BCY/FS7ikHCJ?=
 =?us-ascii?Q?X9iKUSrbygTQJjcVkJH2aTIa4XGZzJrLTpzSWVfsTeqp2K1g0jcdruDQ1vVa?=
 =?us-ascii?Q?zyKba3hFFw2RLeKDQhpPu2XThXKLSvViz7pnbYyMGYFxzCe0ohEjGjHWJunn?=
 =?us-ascii?Q?fBA4tw27zhj1ixtsdY4ixJ2AdzC4kuL7EpPDx+KmtaADx3FtDlCsumruA8v/?=
 =?us-ascii?Q?kIp8TLvtGY1ZDW8ZPWrDKF9c4SkSqPP03ipswoWMbFEFToebNTeTV61EeHCK?=
 =?us-ascii?Q?I4DTgPw+jwZId2lgW43xKp2XeeSfqTT9wG27TgbRuOspOoFg5sgJYKWviyx7?=
 =?us-ascii?Q?m7f+efAmYaaSQR48Ik/jqZkoXEnpztNWdjBE0YvXZ7mcpDQy7sasOqgDz2Af?=
 =?us-ascii?Q?6gG1RQcXdN57hCa/x1XtPk5EydRnUcfVKpbJ4jCm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797916ca-c935-4148-33ad-08ddf121e777
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:47.7365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+gQy575LEqGR7IA0ZtXpiq8nQOn0eLMmxmvh+BmgnqclP9w8lqO/i2LLSfG5f26
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

clk_set_rate returns the actual clock rate, When assigned clock rate is
higher than 0x7FFFFFFF, the return value will be recognized as error.
Change to IS_ERR_VALUE to check the return value.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 7262e89b512..3dbe1ce9441 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -358,7 +358,7 @@ static int clk_set_default_rates(struct udevice *dev,
 
 		ret = clk_set_rate(c, rates[index]);
 
-		if (ret < 0) {
+		if (IS_ERR_VALUE(ret)) {
 			dev_warn(dev,
 				 "failed to set rate on clock index %d (%ld) (error = %d)\n",
 				 index, clk.id, ret);
-- 
2.37.1

