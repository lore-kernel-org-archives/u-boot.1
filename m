Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C22CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C01F83936;
	Fri, 31 Oct 2025 08:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jzMJozFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9E283849; Fri, 31 Oct 2025 08:38:40 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B8483936
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW5g2ZnwfUC+mQISilQtLSHd2SLPinQ+8nzFQHRn43dw+ZOoinm1HXiK4EqKVvYZ5iM+cPmvpElzbGzs8/I5Acs5rkyOyoR49NcGq4GbXkJEePP4pEA2qyD7f283ZmjH+fMYWSNZlfoanFFSCi3d+OE3rkL+3SpXrNz3CP7RnwGQYxcWeDiWeF49WiKcqCeFoYzeT+c4mHffrnL2sa2VjOegrC/pQflAf/4j/Sdz3GHJNIoiglLpehy7J+bYzNHDLQ/F11xE/Spt5jpRvhqyR/vKyeTVttOrsJqeVtKTtqj6utMwlpB0FWIWjt5e+sAkuQSQ/QfRrreNwp1p2lkn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOTCvD5HDbWZmw6NUrDYe42fiJ5NyHQHNcGqQGiBKis=;
 b=dlA3Jm22nkyof8F8WnjuVoI1Hbu3sQSTxCLE1MRd7vzXilmKS5p6e7SxbrkRvcVwH8Oj8hqQF7S9+nTPfQlxFm8bUBeszi2aeo6xGB8VyQRtm+LW+GEgbMz9HUlFVODsowfMRTJsYlF8zFrsH/g0UkaLwwMNJnRvPxeCzQh3eAhUWeHqKV0hzr5Zbtx3MHy17+n0jDRAMJnoN/NsOA7ojTgUfi5uXpw/f4rJGz5Gqxy9Clbo09fpL2rNV1J8/ELN0CP1WpJltrKFZzqQheMDZbhuDo2VnYgpvNekCEbcy8v5DGYpOwCUyXwmOR71IpMe8CaAJTh3BHKdPpdfkPXXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOTCvD5HDbWZmw6NUrDYe42fiJ5NyHQHNcGqQGiBKis=;
 b=jzMJozFCVBwZ+04wj+HspB7S1w2AlGceCnaFEEOTVuaUHF/TWtzqlxTbZeuFYj6FkGcajlhzphg2z2s5koNn1Fd/6+2U8RcqSPSCOOdnJUVQK4eN05karHEPTtpzQnHTgVSaEJQkIqNbj/LY+vwXZ4Cq34GXTNvUmAfTgzeTano=
Received: from PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::10)
 by DS7PR10MB5903.namprd10.prod.outlook.com (2603:10b6:8:85::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Fri, 31 Oct 2025 07:38:29 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::aa) by PH5P220CA0013.outlook.office365.com
 (2603:10b6:510:34a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:17 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:17 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7cGVh3540009;
 Fri, 31 Oct 2025 02:38:16 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 6/7] mach-k3: r5: common: add bootargs to kernel's dtb
Date: Fri, 31 Oct 2025 13:07:56 +0530
Message-ID: <20251031073800.344500-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS7PR10MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c45c0b-989d-402f-5632-08de18507b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t7+WSDxA8nlSeLlIYWc+vejiMiKuF9PUC6Qi87OCRR3gp0HqmigFolftDu4F?=
 =?us-ascii?Q?S+1lyz8s7TbPhF/YSVW6imyYbszFa6Pmzm99NW09F66f7Y+bYxZLNoA/yxtr?=
 =?us-ascii?Q?rloW0gHDSiX4GDIYJjKeookMRUUufWPEH+Qk8Hg02spNQQMRxeBOnqS7JHRR?=
 =?us-ascii?Q?k0Z7VVANgyJG8no6D2MoL9xw+4fOpj0FPjPo5UuJ9skc7iRFxVuxFnc4T8dL?=
 =?us-ascii?Q?rdzNM+vHtXuxNPpg/fsshoiZ9RoxUB0/h7mWjKEfL6mqDVOyZ5nA6rTqbLVk?=
 =?us-ascii?Q?BcXfL1Te4D3fm8WgkjD9cXzY0GBB7+qQPq0FMVn+7AeDpIUHkf2nL2QeqM7H?=
 =?us-ascii?Q?ORu5l3bi5WvoMNc/qXIIQZzaAcOYhXWaRcvj8ERuDf+DYkTHqw3LU0MKcsLk?=
 =?us-ascii?Q?moLtjTsL0J53Qo8n77+KrXnlFqH6jj0iTH3TD8bGC3gi4Uw5VwP8fLC3ofDW?=
 =?us-ascii?Q?pWtfVEZ/NgSA5Lye+MnLslZmRgIlzbxqMcyi38xWN1/rVrgHlFgGkBpgYMIZ?=
 =?us-ascii?Q?FalcYAqIu1H7KygJZke+h+QaixPA8taI72N8j36shyKe8oILVdoNPfCtyKkb?=
 =?us-ascii?Q?Ew/2ZPPC4lG/+JmrG8EgORFLeYPMMn2Hyxg0lYKV+tqNLJxWx/cKwccL4uWS?=
 =?us-ascii?Q?nFrekOWml3me9bOBsswQre4ZW3894O+d/yntc3OCNKtjdu6jaduQO2yeDaVO?=
 =?us-ascii?Q?rMD6/3GJdsbco5L8aP9jhHTcXUgSY3xhaz3eGpZQRIYlCsXQwH0/TbqY3Oft?=
 =?us-ascii?Q?ov15ZxL8QIUvo60CEAS3BMKpiaK41pRMXYjG+Q+v2hDnM0nyHX3NLk59KSMA?=
 =?us-ascii?Q?Lusmbe8AxS0Wgqmfp4Tml/eZtxi0DEIa7KXnME9f2nIIOepTOBloXnJHJn1L?=
 =?us-ascii?Q?+NF59K1O2d5pDcm1ZzGrb/RdopC4cwtPjymrf3mUFNYbqZUmVZZT7x0Zv/Uc?=
 =?us-ascii?Q?q5ff5wrAhy8g9FQjvNISlCBcB8qzn4b/LPZFXLGO1F8+R+iFwWl7+bshOY9b?=
 =?us-ascii?Q?I9RNhu/uH2nfwU/xSgZwhkstvF/5spTZ4HVPJJXPwZnXqze4xQpSTR4bHF2x?=
 =?us-ascii?Q?ii8lG3N3TlWhq5hIXbnlsKZL0yLF5hHBTJrPhKmmOoC7QD2f3nDNw+vRgemu?=
 =?us-ascii?Q?iXG83WWR8U9VRgKwCEHeKRJrjeJQLFKETMqrq5WeWJCi9uCMr62j7a34R6jS?=
 =?us-ascii?Q?rRZmXfCTGm8Rl7htJZwRqwdLwbVFHAyhJ28PUX71vyS8AYs5jGmKvfNlcbna?=
 =?us-ascii?Q?dkug/dP8kp6kagvTC5hyz21tvhPw9BgNeRqBrGJ5vy1E4ac5b758tLjKxUXl?=
 =?us-ascii?Q?T/74a8U7JBOX/OQBc9pa+DeDtvuFHNUYbL9pcSy6EWyNj7pcYIkNJBEnZwDd?=
 =?us-ascii?Q?oOhKTcnmWW5bedSNRbDHtW/FaSMyEP/pXFbk4U5NDebS+7ut3f1WBgwYmH+6?=
 =?us-ascii?Q?GxNFy5l6zv3YYt4M9IO9SDQOCwIuatd4zvSmncXrYkwH3mWcu6qbZl0DJkEo?=
 =?us-ascii?Q?YP6LXmcdZU8h1XC3XTKE+KTfkay2nZUnN5Op4BRbxXjiI2UEOTRPeB3H1+eQ?=
 =?us-ascii?Q?BuncAfaLYBjtE2WCBhE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:28.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c45c0b-989d-402f-5632-08de18507b8d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5903
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

The bootargs are passed to the kernel in the chosen node, this patch
adds support for populating bootargs in the dtb if missing.

The values for kernel boot params is taken from the env, with 'boot' and
'bootpart' specifying the rootfs for the kernel similar to the
non-falcon boot flow.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 8e002504897..03638366046 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,6 +406,46 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_add_bootargs(void *fdt)
+{
+	struct disk_partition info;
+	struct blk_desc *dev_desc;
+	char bootmedia[32];
+	char bootpart[32];
+	char str[256];
+	int ret;
+
+	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
+	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
+	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
+	if (ret < 0) {
+		printf("%s: Failed to get part details for %s %s [%d]\n",
+		       __func__, bootmedia, bootpart, ret);
+		return ret;
+	}
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+		printf("ERROR: Failed to find rootfs PARTUUID\n");
+		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
+		       __func__);
+		return -EOPNOTSUPP;
+	}
+
+	snprintf(str, sizeof(str), "console=%s root=PARTUUID=%s rootwait",
+		 env_get("console"), disk_partition_uuid(&info));
+
+	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
+				   strlen(str) + 1, 1);
+	if (ret) {
+		printf("%s: Could not set bootargs: %s\n", __func__,
+		       fdt_strerror(ret));
+		return ret;
+	}
+
+	debug("%s: Set bootargs to: %s\n", __func__, str);
+	return 0;
+}
+
 static int k3_falcon_fdt_fixup(void *fdt)
 {
 	int ret;
@@ -415,6 +455,13 @@ static int k3_falcon_fdt_fixup(void *fdt)
 
 	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
 
+	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
+		ret = k3_falcon_fdt_add_bootargs(fdt);
+
+		if (ret)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
 		ret = ft_board_setup(fdt, gd->bd);
 		if (ret) {
-- 
2.51.0

