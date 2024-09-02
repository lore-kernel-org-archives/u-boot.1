Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8250CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9936288B2D;
	Mon,  2 Sep 2024 12:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgKxoE1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC1088AFA; Mon,  2 Sep 2024 12:27:42 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8282088A92
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj+38C53qKgmbsAs2lnesJH0yM4iuLRsEXBrnxEHscnVqzfnsw+5GsqcAEsqHrufQ8ROIQgp5wdvLrTY899czFOAFZXbQyZpwWm2mj6wekSeYrExNlVEOBl8jn5bTZANjvpt/+D1OdlKJDOvJ4XQS77vcQt8vjQnnVW0dY1cZ4M8JGqU4xQ3RsPHjG0gEPH/nJu4AXzUKLfaUJO8QNxX72xQ9oJSeupuyoz7trhY2DJNk0ELW/zpiK2dsrfEB1jlfI5q+HHRZuJfRSk2JmEbuAAKUDbNS4IZlJ58ZZS9ECO2JKzk6GLXCZ9ZIamCsWb+s0yGe7vCIJNpWAWlDd+Ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxrYvKqcj+vVvzqlDFSESgjn7ifeMVRApXXocP759XE=;
 b=E0LK0o+y0/zA9YArYE8JXdflPvUI3vZGY/kzeLIHfBmHv5EgJYP956vuY5VK4ZStdHYEutp6h4RxnELgIVhkHitwstj2eKPl+uap4MrBMfeDFBzpWBO1BpWjHLW5QeehB/o0ZoEudbr0IVjP164C36cYO07+COk2mEsImTz51JB/xMLeNQ7ugvHaM40y+QMWj3pXzg86EbYEf27Z+NPRVvIxTZVuJ43jRwGs0xBcq1nmzT0JhONW4mT3x6Pc4eIxqZ1H2oHGAEAjYXSCtDD1S6MN4r0mTVcDC/qobf+DjuyySn+R47zZduMJeLRZBZGQpoJhm/s7c65qnKtUhe6X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxrYvKqcj+vVvzqlDFSESgjn7ifeMVRApXXocP759XE=;
 b=vgKxoE1LHMdKlNM6SBggc3bdpZ2YXE9R+RxWAL2XXEg7bsVXzzgyNWYSI6L9AapKItKz9KkzAGT0Ez0kMZDoCf1JSP6flvJ5Z/kdJqnfE+k57sHRD6RxpxgnBG5JKgGg1M/7ErxadUk9hLEqMgGijDAh7D3Sr0QMeIEKR4TsXNY=
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:27:36 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::33) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:34 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v12 8/9] config: xea: Enable the SPI_ADVANCE config option
Date: Mon, 2 Sep 2024 15:57:05 +0530
Message-ID: <20240902102706.1107-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: c38b94cc-645b-43a7-3e4d-08dccb39dce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6JJNAwOUNuVQHyd6fRbvCSuuTDS4U+ylsaxIS3l06UB3lmzqXTJ22Jn/B/Wf?=
 =?us-ascii?Q?+DRmk/xTEpyK7fmm+XWBNa4Sq4S0JIKAYrIpUr6A5xooCaJ8yDATRt0N7V0p?=
 =?us-ascii?Q?PsCNP+67y6Xhd2WrzdHPS5jkkjJ3eLp2NXOe+ZpAfTFfSiLxDpAs6iOzbDEz?=
 =?us-ascii?Q?vQvmRCh2hiyimPiYbJYVC5qbA2DR2Yl41GGutcefqra3ZXpLsQRqmm8QiC1z?=
 =?us-ascii?Q?WZVOZ5Bo5Wk1JNNxha6hu6OixALzfrMzrBHAlbf8aRhBzEk/AkhPm8JUXs+L?=
 =?us-ascii?Q?P8G6Aheqxu8ui3wn60gwjcT1O6sOWkLRrbuVBTuCcA/qNvzxD7QK1OXha8E4?=
 =?us-ascii?Q?OXx2KaVquxjJWS+mOvjWJx/3JD0pcwb7kyAKac2Tbx/V/SSMJYlZrVle41OO?=
 =?us-ascii?Q?qjufacLKLmLasZW8Me13jHZoCpZb28oL5fr12+/VvMiMTdRhoVu1QRHekmNF?=
 =?us-ascii?Q?o7sFxDhDZOVqvd9NaYmPA+dQdS3l6JpPN/gc587GQOeVMR27Zw6oZCKcSkUV?=
 =?us-ascii?Q?FSw+h5Cxdb3xTTQQWOD2Q8xUxwBJf0Yc02WZvVCOhwqHJCWmyZOji1c1qPMt?=
 =?us-ascii?Q?g7ZcZV+uyZAjkN3fWIJcbzfWTJQGCQkArQbtTvMm5psZVivdmUxAIEE4LQ1H?=
 =?us-ascii?Q?Usdtg34fYw/QWfkCuUWfFf8R9WbkWQejhRGDu3lVhQO18/EeXSVArofsg5t8?=
 =?us-ascii?Q?K9uyt/ytLlf6XHn3xr521eaK2eaj9LPDAouAYIIojkB61Ei8MHiOpHG5q//y?=
 =?us-ascii?Q?PBqDzB3ewQdCIMbxTLtDaNBT/aWe2WkLFJDr2EHBD6IOrW4ypWjgOSP5kn5B?=
 =?us-ascii?Q?ttj5QQex6cfrBwpKdnI1wMyJthN5fFMH3BlC1syduo4mhN1BcxWTrW2pcbK3?=
 =?us-ascii?Q?pkNSyVOVkLLQXb0qXAOJqdwpz5l/rrVkMCfCFv6hsfbs9y8xd53vk1eaWPJ3?=
 =?us-ascii?Q?TWlD7TBBhCVPo4koHz8lK+3Q2uy34HbZK0ckKxrCYo56PMRdwj3kbKyNKEqx?=
 =?us-ascii?Q?HfJQPb9/lf6eTLR/qMDP8qnGRK+CM5iTfes7BgQfCn4evw7cb6o5GZoo9H5W?=
 =?us-ascii?Q?9vFBIi5DnjS+XQZeblwrq5FgBZlrVoVqTCcKE8x0mfeCzaTN/u2dpPe1it8D?=
 =?us-ascii?Q?WdeVpKNIhfnEQYuVGwIjr3PdEMCGjOPD45wZjDOaRqOg5wHmRhl4FN8tyzUM?=
 =?us-ascii?Q?pwQEb7mqa/ysEntBKhg/dh4htlnGj4VOYHuSQrjgMBrJFVV+9uBgM+FlP4eK?=
 =?us-ascii?Q?eQQDPJh05MCJG864+EeEcxCYW2G6T13MGk89H0PyP0AZDbZNC5vbwBWPVkjT?=
 =?us-ascii?Q?iXDSoOd4Bn6x+qzBZuXol3m96lfjB5uM9fRzkc+0StX7BdmP8XMHB7XWcwxM?=
 =?us-ascii?Q?dxEQKmVVWU3jbxBEz1OU/wAxHs3qTc8mehCehG0p6YvWMW0mLWDQGLOhOkeZ?=
 =?us-ascii?Q?CURd6+lF0nT9UEWRhT5medohFbVTevJb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:35.7816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38b94cc-645b-43a7-3e4d-08dccb39dce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

Disable the config SPI_ADVANCE, as getting the below error
../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in function
`ofnode_get_property':
/u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/imx28_xea_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index d1470014fd..74c97d0c35 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -127,6 +127,7 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+# CONFIG_SPI_ADVANCE is not set
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
-- 
2.17.1

