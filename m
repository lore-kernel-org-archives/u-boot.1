Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C9D35165
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 16:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A2784099;
	Wed,  1 Apr 2026 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ArBwIn2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817E6840ED; Wed,  1 Apr 2026 17:05:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4F5840AA
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ioana.ciornei@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s16cuhhH9OXPOqlIftccaNMXkyx/e/4Kbpor60ZGZ+2cyCCAVkaEcTVDBTZEzRHw14hMtnJ4hr8pUGJ6nAKe+Nr3CIhnjIX6Om6gjgrqjFwQsn6F8FDxcwaZ4UfH7N+T3OdiAd8sHIMJob4xNHYMbZukptThfxz2ika4U07zGvIOEs6e+/vaSYbeCjQbhKlbmbkAa7MDd+xD50bc+WJBWG/3dXXa51+O5BSS8/laAlKu8iRavQM1MiqXPnl1Oxyr5kIgQHLGWEwXdF3asf6oktJxd8JPznBYa+rlgywBVE3SxICiWpnq6VeuSmYhF+Ly49jg5b6NNT6matb2Dal8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtG00dSbFAOpGyw1FFIAZo4IiFiYVYxT32qInig3T/o=;
 b=Lfz7/lhub/UXXZguWM65lVJ99s/rv6HAlbNl+xXHmA5mARQjoCTaQmUuo3jkjbRm/3jiLOInA3Az/ZxC3vhoxyEaQJv6w0Fyv3r6RTDQc8LUSRuA4any91hydNVEXm788Y/8+ws1nbGEoUSl/m/9A2oCsnrnr84mv3G4APTLCMmIZXVWZNdglr/vDacRxqoyBox6dNnMdizey9Z5/eEcmIJZdLJw6SmVX66KftievH81/0z7Gz/HV+G2yqB1SqBITPC4yEq9OWbYjhS9YJQwmHwLIL8CV9WfWyzd7Gr3HIeBczg9F7nq65tmRdpktl1lBTCz6QhTnCJDaS07wdtdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtG00dSbFAOpGyw1FFIAZo4IiFiYVYxT32qInig3T/o=;
 b=ArBwIn2Uq8fgncg4nEGG3XkIq3px193VfsbOPm0dd9RhEzQfjAnFR8BXSt3SSSPI8TulL10sdzO/BCaw9VhxUL0QE/VkIKNMjtrNopQjE1kTRCFcCvWlMwDD+usHAgM2jUojgQbJKbTLAREUyDkji8IOd0xdXh1GYLvIxWI4P03MyJtSjwN2PlA4HwH43gQRNV/qetanRBvC259n6P3s0atK3rvVzDpmPDaiCL3oAm0ImZ6ndNH3ECZldVCcSwOR7l0V7zCa32giP+w8ArEkYB6PMNSpdsjIa0ZI4nS2XH1k4VXcKXHt8qEPaNBGBjHRMKndnDxf7tVSPLGhJfB40g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:05:02 +0000
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49]) by DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:05:02 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 2/3] drivers: net: fsl-mc: cleanup the fsl_mc command help text
Date: Wed,  1 Apr 2026 18:04:44 +0300
Message-Id: <20260401150445.3070308-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
References: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::16) To DB9PR04MB8251.eurprd04.prod.outlook.com
 (2603:10a6:10:24f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8251:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ba8c05-4595-4b05-4735-08de90000c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UD56XAGVxwVHoDV775yCXh35iHQQSl582dYGTWXuAqyJFhF3I5kS17sz9pW2WDUli2iN/yekXbbgN53Ibexjh9BG+1XaKmn5hx3i6B4qhHq3KTM2VB3cFGhT8Dhh08GwBuPj5MDns+e5G2647SGqnwCHymcAGsTCthjSvPptHK+xAfiML5lVZ0O9a1j9bWpUejBZe0dOtPSrA8XNMPaCAci9X93Rf7BYu8/TrT232neAgnZKl9vei4n1mlf3cs6KSnEhaK5ijObvilDN6e52FN/e5I5JuTVP2iv2mFFka/FnLJRdyzUeFlWp+M4mkYq7761ncjiu4Fv+/EZnVN3tjKUgQuHwicq1VtCe+HVO9l36CVZvRj/HCwYr7DhN2KJihJgBStt8cCf201chizd/jPufGuKiljxbwWEyCS4/UCLtS8dIk/Y5i9WZmZqLhSm2zlbDBDgPFHJuF5c7zhZi2BCmqkJAnCrdn+F7LswWP26E1OJOD1zR2SKafMt1ojXPkLcmXIL+ehqs7aEAcSdG0JTQnT9rVrOHlUpU71fG4GXfMA72AIhMKJzva8WPMaEVij+TTD0sTxwNHlf47vnizst+/SdS6Z4jrjtM3r40LYFsoWMjfGHhaZ9zSuk/KLtwSd2JiUU+AbjLQMgXd3fdAumDUm+CtxRAAUE1cAOPkCGepH0jbxfa34BoNP5np8hbaqTDsmz7K7iqrqhZAXbl3UvUqwEovId+NU3m4BWiDKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8251.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gl5v5WIsOk2frZ+nSGAx6fWIZ6W6Rd5ymt8l3qQEiy7bATF2G5L8lBEwIyUz?=
 =?us-ascii?Q?/o8TLe1Kv00N8XpT60THNtG3aXSAMpeiT9l7/0NjFDolcMxFE3vqLeojm8hc?=
 =?us-ascii?Q?I95gku8pviZPMEx5m/WUhQdq8sPSSd2ph1ShJMqDtqxOEQ8nS+XjwXXtDwcV?=
 =?us-ascii?Q?RvvvDKMMzmS7H7SpdRIg0u/+m9cv6Em97iEVPyNci6d0rtAyAIzf/t6n4AKp?=
 =?us-ascii?Q?RXrKNA3pS60AemMDyCNAiNp1IXL3FhyIy1eFYdZI2djMUQ9Bi2C30p2qUSar?=
 =?us-ascii?Q?QFxQ9x+ejB/xq+/P66lu/J6ILHk836HCIyR5wdihEbgs9rHS2JaDIxXZwCFV?=
 =?us-ascii?Q?mUQenz4wg4IwpSsbeyrb7axF6l83qzunqsrg3HYI5iFhcGrnDSy2c02jURKG?=
 =?us-ascii?Q?dsL4fbzCV7uU6jJlpSVaUhluxQYgx5+A4OphppLQEDl0G3ThoG+yx4jBk6or?=
 =?us-ascii?Q?T71y/EI/RtfHGcbRvvBDtxWmQxn9hDzDBZasCeJMV8YVm6LyVgLc1s80PNpT?=
 =?us-ascii?Q?NK2L/u7UeO7XFdUjCasfhISWDbxg56Jp1VRZ0R7Vbhawd3czF8iA/w9eCT+/?=
 =?us-ascii?Q?XvxT7UCNv20ORgKmIN3UC2AxEnGV9vdcdXanPnyI3hGdv7iSbuPCfNoUjzMB?=
 =?us-ascii?Q?yL2C2C4na3seoE4NMhT4ftfDDAeNIYXhJAyIzx3BI0+V4aCWZJgjrzxf0SHU?=
 =?us-ascii?Q?KsPIFJp3IRr0LgynBh+eeOGvSTqvgrurozReGILrzOipTp6Z2947mayVirKS?=
 =?us-ascii?Q?Y3dl0Wbt8WMp8OtbnSJDqmevnSVSdOgvOWa0mQh0lDeGK+4ArGxoQO0cAacs?=
 =?us-ascii?Q?sFPYCuHjF4+JqJbDQxQgQcReVjB4s+ZAJ/zFHssKH2KByo11RkYcd4uPKU3E?=
 =?us-ascii?Q?lp/CO9Y+0FY/L5HNI2IzXZuyEzcixj+tLKEf7wTUe+pQGMv+8SVuBAwZwk76?=
 =?us-ascii?Q?HXTYHOBnYR3l+SC+brFtUT7Lx6Ij5l4OWzqGeM7u8uleNt9DKaOyi6uFovEQ?=
 =?us-ascii?Q?2TkzMmTqTzhcuQBsy4reAYvdUlCFlqwghqiGSL0W61wi4ljBdbFkgc2TnxJ0?=
 =?us-ascii?Q?hTDldSSkpCIqK00woiXWbSAQvHs/asXARjGZUXEMLotGbLeMYSqOxQkUb+pj?=
 =?us-ascii?Q?SDiiCehawQunbGuLP2QWAbw+Nfn7fXHx70zmD7aLp0SVQkFOAZUnd18XlMNz?=
 =?us-ascii?Q?dxkHNe91Y1l8h/BLwA9S9XORSt2eYo4bg6G41WoHnX9eLv0kpCmduFUSPxkj?=
 =?us-ascii?Q?XUI4TfKnFRMsHAA6kOqU4PAwMQgL5yZNoda9XKSUnruCLGyEn0dfHm71SKKv?=
 =?us-ascii?Q?AUGxlCh0NCejlb87zdaKzAVHH/mqiTWW22aHBLCU/HJf0l3MJXlncA+trglo?=
 =?us-ascii?Q?g4v5RL+uEuJuHhozfosqHaoYXNV89quz6mguSnf619PSTsK32HqqnG87eOgV?=
 =?us-ascii?Q?CQ5fXsaKpDK3Xz5BKjM4QkK277+SWOkv+7SZp61p57NB74y4gprjgFH+jryo?=
 =?us-ascii?Q?DTStzsiKDK8ifjcUWglhs1jTvzrNCbWM03aWqpBoS+967vBRb+l30naFa3Kr?=
 =?us-ascii?Q?RrvKS2td7pH1/t7arTG0Fh81KimluKz49pWaAM/6alLUGgeZETgb0CBhlE53?=
 =?us-ascii?Q?wgIrMXS+aAtioD10TFtnvmCOiqT8Y97nkVqov3INcG7YyJnNeHXoHmtuON8O?=
 =?us-ascii?Q?q4GLPikoLf9tkKKeGmkuAZOXEHpvnCQHsd4Q3lKuxmVpsko/wa1WWwylPzoi?=
 =?us-ascii?Q?XXl8r5XOcg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ba8c05-4595-4b05-4735-08de90000c9a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:05:02.0003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ve9Dn1JVhseuJKQF0F5L5yUaR/iEaaTxPL+6L4PpEnAxxMfmJmU/9SxdkM8buKH1Zuo7NFGSIXKE6Lto5E/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:15:20 +0200
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

All the parameters that can be currently passed to the fsl_mc command
are positional arguments which are mandatory. This is not perfectly
clear when reading the help text because of the use of square brackets.

Fix this by changing the square brackets, which are commonly used for
optional parameters, with < .. >.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/fsl-mc/mc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 6e42fde536a4..039375e5dfdd 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -2070,12 +2070,12 @@ static int do_fsl_mc(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	fsl_mc,  CONFIG_SYS_MAXARGS,  1,   do_fsl_mc,
 	"DPAA2 command to manage Management Complex (MC)",
-	"start mc [FW_addr] [DPC_addr] - Start Management Complex\n"
-	"fsl_mc apply DPL [DPL_addr] - Apply DPL file\n"
-	"fsl_mc lazyapply DPL [DPL_addr] - Apply DPL file on exit\n"
-	"fsl_mc apply spb [spb_addr] - Apply SPB Soft Parser Blob\n"
-	"fsl_mc start aiop [FW_addr] - Start AIOP\n"
-	"fsl_mc dump_log - Dump MC Log\n"
+	"fsl_mc start mc <fw_addr> <DPC_addr> - Start the Management Complex firmware\n"
+	"fsl_mc apply dpl <dpl_addr> - Apply the DPL (Data Path Layout) file\n"
+	"fsl_mc lazyapply dpl <DPL_addr> - Apply the DPL (Data Path Layout) file on exit\n"
+	"fsl_mc apply spb <spb_addr> - Apply the SPB Soft Parser Blob\n"
+	"fsl_mc start aiop <fw_addr> - Start AIOP\n"
+	"fsl_mc dump_log - Dump the MC Log\n"
 );
 
 void mc_env_boot(void)
-- 
2.34.1

