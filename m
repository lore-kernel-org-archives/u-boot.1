Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8913CE8D4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D178422F;
	Fri, 14 Nov 2025 17:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="E3U2osxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25F8841F2; Fri, 14 Nov 2025 17:24:40 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE741841F4
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGLfQR2700855; Fri, 14 Nov 2025 17:24:37 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com
 (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7j3rpa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:24:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDTgVTPVmkK4HL424VZO6Fv3Lno9dILKjBAcXoHqJkM91Yurp1S/bIYIv0eVjYljE83ImzVyH7esKXp9yu8x7F2YEHdOjgnVUaeqaW1j2rYNOulcjioHZq5yfDdM597fAG/P+Agy7Qfr4eybskcwGLJxch27sSOYNle0TSeyqee0Bm+Gz1D0w77S0tZPqlKXNhSeLgCVsaOjkGaKUqwwdx0IgEbFldfoYbOJByXb+x+jZ9dbKdmyNqUxdLy8YXhQKdIjFHbaxsBx4jiZHJ8anA4LlvUB/g8JiAfw9noTIZ4wlk+yRoCy0HeSXH1ZkDJVViR702L5rKt7l+EKV8HsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi/UIYWk44wwUUQV9ai35/5aOcGJ8o4jcKZz4kpL3yo=;
 b=s9OeUv5MNB9HuX10BLzgYQK5uYNSPWq2XTeQx1rJcWUprT4zaZhU8Nj1GP1wki+2qAGXeL6XlUVCyGmxGAQr9++QloCgZ3ryJFTGhC1CSeC/hPgWUSnGVlHqitrQd3tcWKri1KuSLIBYoLxbqKh3GMfVtpA/HkjAQs1wpgDaGV6zh4Hl6q3MhAn2eiGFjy86BgGMLuNuV6qg8UpsURDpcY97VFl7Kxof1RnJUCIN7psxKWauOeRcROvQY2mOxaMZRgOwGngAisSnw8dl43+rHFCDQJ5yM0xUqabsp9qLICSyLNGIZ1oQssExAleKwVw0xjgsfTWWvu3WL6TJgYZLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi/UIYWk44wwUUQV9ai35/5aOcGJ8o4jcKZz4kpL3yo=;
 b=E3U2osxRV0wv8e+riMwZ6C+Jm4P7ve5rWNiX/zIUKEpZrpnz8vqWH6hk2Z+wIQtdbuFOdVV2m1f+PfkdobTZ0djYtZ62Zy9STiJDNtAil2YGMO8epMstqgvr28BTUIKytAqE08S0c0eBN7wvb3qc8g/PLcbNodpKFppdjcyRjnMAXbxrrpCLXnixybI9lYtio0BP7l+xl2+wVsFJ1gxE1X8qBXN6Ylu4WUWZAPQKEylc0Yxs9I7Xb0LtG4NcKgrXxCcEmxQYd1Sck6mOWFbGaIdIZGH99ApBpFtfzpfxX7v/v6xe6bW8ciMr0TV14joN203NdBPFINahwOn2GYG/CQ==
Received: from DU7P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::26)
 by DU0PR10MB7482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:24:33 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::3e) by DU7P191CA0016.outlook.office365.com
 (2603:10a6:10:54e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:24:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:24:43 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:24:32 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/23] configs: stm32mp15: Enable LED_BOOT for
 stm32mp15_trusted_defconfig
Date: Fri, 14 Nov 2025 17:23:48 +0100
Message-ID: <20251114162417.4054006-15-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
References: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|DU0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 36eef511-3c79-4d71-4528-08de239a4bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+EEUactKQ5S+p1lfdLg+V/XNhfvLK8O3HVLc0T/7RHCAYFHeAkXALXhBAIk?=
 =?us-ascii?Q?Yz3ifpJGdEMTXMljtjGRPUcAGfslBFfIwFlfy1bWmmafVxptiOl88J10LpmW?=
 =?us-ascii?Q?ERQ6hpRubsDJIFvxspf4fizV2Uqyb9yYVYFwnGLsPIYz3hGL8N29FPcdaZLU?=
 =?us-ascii?Q?ERZi/+sEbrRdD3Omn7PP6TS8nXEqAear6E2K7TdFgHxAHy1nzTkr7s0ceKiY?=
 =?us-ascii?Q?P0bpKRWpIQGbjUzwIeLCqO6+lIDJbzyVcCsttv67jTbAIRKO+CwAYQUY8SmH?=
 =?us-ascii?Q?sp1xceZYx4g86zCdui1ZWe9YrfBjXUN3MNDMcTPKKwffnNcdb04cFL32pOEf?=
 =?us-ascii?Q?9siuCpQXYf/jJhvXGrXpejkQ87y1N7yA2FE0Gv7XH3omETcCb8YA3LEqlXAj?=
 =?us-ascii?Q?7BGx7menoexH8gJr1OMEm5ae3kz25/t1xYaRXb3+gDjz5EL8A9VLKjzbemzD?=
 =?us-ascii?Q?1UfbsZK3TEn91dU7NsLju+GjCUqSv8b9j0f6BhjEFRkfUosb59W3y7ZvFDMZ?=
 =?us-ascii?Q?mzEtQSjCe78bmYYefu4Hr5vDH+8G6ebTtuzbb2umgaD/k4Ifr5WDYtgMIeOG?=
 =?us-ascii?Q?+z2kcoK3wO2wpL60tgps2x36FJ2g3IAWh31cm5PIxs7VGaH9+KF+/U6cANDg?=
 =?us-ascii?Q?VW1Tibg8YiWZx7F8xRQmXlu7fYH53zudYxLd2r++uiF5tmOXbKL61xRCablD?=
 =?us-ascii?Q?Bn3Kf3Ch1WHgzclMFEj8qqgV1OVlhJjdmokAlpRtwFZGaKxF+o1jzhia1NyL?=
 =?us-ascii?Q?iRWcjQugoLUefcxW4ou1auRFPgcmbWZgAiI1xwuoIHVClAkvOeFnNrZwZbFk?=
 =?us-ascii?Q?4lSdJLkSYaxuDWRcr4ZILbK2fH3rVGMkC834SmmffKkiFTcpuNvK4AzoIgMd?=
 =?us-ascii?Q?0cwWJe1LYmXsADRZ0yxSTl+YBATdV27yYdtDkw2+N8936yxBCzqbpwOZ0rSr?=
 =?us-ascii?Q?MrZTWrOA60PCH5ZO0LCHvYt2zyTs2aXrER1g7RRjTj2sYKB41ivvBWpSqhQU?=
 =?us-ascii?Q?5vReAgwOEqXJY9b4u/Zu0YdqgayJlD5bUMqA7wMLwO8DKH66Y54S7c/9Woj4?=
 =?us-ascii?Q?NgmO6N5R4sZY5d9nHKLoAMturucvOJiGvqbdGmgHpPXydsBkPSWYOxwNp4M9?=
 =?us-ascii?Q?gY9KXqYQDm8nfVW5FurHR6NJabQqiTSlbdJTJ7jnNweZiFKKy7y3WlbvU1IB?=
 =?us-ascii?Q?alpVbEmNmlzl07fe4KdGDhmE3XDnjct5wxDYF+i2DBma42Ab1OT35SQEvjcg?=
 =?us-ascii?Q?Lmumw72yPgWVaReT5FTsP9cI8ssXMYb/UQMlqHjOMMWQ/juZsOxvGgROIGeY?=
 =?us-ascii?Q?M0LoVo6i7AXeC830do2nr+BrEveV2JTAo4S9RfLNle4JYoaIk4+TxT+ZdHSZ?=
 =?us-ascii?Q?DLPDlf9G+MDaDyFHiMo2Y2+BKXSuJ0VI9c82RPFhAXj2VWbLjHHtGC75cOGJ?=
 =?us-ascii?Q?avdWwuSPLscaWiDPKuyfZPtzCj+G+tXt2VjVHL9eXPyo1r9RbD1B4Fvet+Ly?=
 =?us-ascii?Q?/WiWGDLS1Uu+rYLd8HkV7xTLnLxqGYAtAWV5fKuGJs5Wa0pO0AHDCL4t6XoZ?=
 =?us-ascii?Q?mOOIkZbOXroo6iqhiJ4=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:24:33.4387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eef511-3c79-4d71-4528-08de239a4bb8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7482
X-Proofpoint-ORIG-GUID: JW4h0wFAdzStVIgFP1n5pTr-JX4wLXFm
X-Authority-Analysis: v=2.4 cv=DPqCIiNb c=1 sm=1 tr=0 ts=691757c5 cx=c_pps
 a=3UzED/fGQ/gf+CUXnguJdg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=6UeiqGixMTsA:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8b9GpE9nAAAA:8 a=SxxZRTMbgU000sIlMgoA:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzMiBTYWx0ZWRfXwWZtdr7h/Vr4
 xOVDSpLf07gLl/mAsOFkDmNGp1KM3s1FJKOo+697yck712/pioVkUSMYJSHCv7fiZIAcM/rJtX5
 L4b/r9wLn71b0mjC5a5EymnV2tB2BArmHuWJnQ7vLw4Vr2XaLMZuT5CxE0/wzN8dVYmbKIX5xdB
 Y+pqj4HUd+f+BcHn7dn94m/N71Gjf7DyTvqN5CoEeD8bW59ZSIo0lZuzrXbtn/yzzaGJeEUAG/W
 GwNOb9HHUAxDiqKETDC6zpZ1J4f/hMb9jC77GYitf1+KxlRVy66AIq3NZvdm6cgEnKnzYprNgix
 6gh0EeDzaTjEOcBJKPy4OpAHgpF7vmnC+SvSNf+AYHG6L7UaFW1JedvUy6RqYsAnsfNTDDTvlC6
 EdJmq/guLdgoRsHaAqQbIaWlq5l0HA==
X-Proofpoint-GUID: JW4h0wFAdzStVIgFP1n5pTr-JX4wLXFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140132
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

Enable LED_BOOT to use led_boot_on/off() API in board file.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp15_trusted_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
index 09383ed4824..77684c0e8c9 100644
--- a/configs/stm32mp15_trusted_defconfig
+++ b/configs/stm32mp15_trusted_defconfig
@@ -95,6 +95,7 @@ CONFIG_HWSPINLOCK_STM32=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
 CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_LED_GPIO=y
 CONFIG_STM32_FMC2_EBI=y
 CONFIG_SUPPORT_EMMC_BOOT=y
-- 
2.43.0

