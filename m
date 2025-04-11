Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9814C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF0E83F61;
	Fri, 11 Apr 2025 10:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q9WjRXko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8301E83F7E; Fri, 11 Apr 2025 10:12:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701D483F69
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6O6AefmYJQ7sEAcv1Miq/c7GYPu+OZ2DIt9H5bo+h/9soGFYS8Pld1VUNvOltIms9XJl7aF9mvrPoHfmYI6C5OT2xMBxS5Y+TMPxncoYlnE1xeFiwoG21pHb70IBS3cfZhBUzpX2KiHNK2NMQYudR7LCCpebSk3pdSS5Ui+MUcUEXtPR/HMDo4xBtR2RnSvF5nZv0Q/fJRTdYhBXgRX5YVVkew6szgu7cnxYazQB04bdLnNGU1M3d86v9Apdqj2bffCKKpuXeXveQ1CGVyrzsheNIpP2s+vAFiA/WSEyZL7q9EUrvKyA4K/HoMQyu/fCsfSUY3/LUc/zDKcpsEoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgIkPHdJCtjQde0hCgf4vqoiG3PAQH1vcbLNCFXYgk4=;
 b=BCjgcc2Lv5sMVDnERkaSCIzWfMC9Z8myNPoeOjd7+f+5gEQNTb5AjuM7M3B7MyEtvwvctWvsK5y9iTwDbBfK111ApjokGB910nn5rVH3v8hUUc8LDFW8EX+6oSGRtLfXsKKjC2s3OqY/JsnRb1d7k96tD574rCvZjN7+Igmqxa56Bo9moKAwDLFQugueuHus7WXckwBHEE14BDIuuVXd/B3xQP4q1+XCW4NuJR6BtRqUKg7JpGCItKOUsZQtjJuFt3suUKhIn9e1ons3zx4Mb2IoS/lerNQ5QMSXJgThOInU+U2KTEZGN5rL5tChaRremEo13DJ0k+Kzz7xhAQUXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgIkPHdJCtjQde0hCgf4vqoiG3PAQH1vcbLNCFXYgk4=;
 b=Q9WjRXkoA3wsRNRzGXulb2AmVvv1rKiIEW10UVMRRQAV7TW6RRk3nY9vfMPkveaKSqHZvWjnN87sbwD21HLEGm7L0rrvBn4WD6az5I+Oqv19ys7CVPI2wEFfKwqMo9Uh5gFbRuPKlrdwBHhINJr/hsUx7PwbSgpWq7gZVkrptXapSoDVtui7I0rI0YZgOh9QZqoRAf6GfpAJ9GeBraf6IsggpZlhZ5qJ31CRQEVqelwwArnhop/wny+/w01M+mhaMwsBJKaxE92u/BuP8VgeswTZkLnNCMiegqdo9lrapBRBtKGPZ+qAG4Z+06/OfjKMturYree8qM/Z7+5f1JPxfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:12:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:12:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 12/20] spl: imx: use trampoline buffer to load images to
 secure region
Date: Fri, 11 Apr 2025 16:06:55 +0800
Message-ID: <20250411080707.602371-13-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c096c3-ef28-466c-bd85-08dd78d0a163
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cLijhnuulkAsBwq5yPOhIEwQWDXVjd9K8t9XPi+lOaMdFoD8USyvsxO1iSyF?=
 =?us-ascii?Q?xssJxcwfOUD0ZM9oGmgy6kqevJGpeR6uka9SIZko1BVBOxkrVklR2RZ0vzCg?=
 =?us-ascii?Q?fpRMsxXfwrrxqnUUac7Xf/ab0VA4lqcnZ6XmrXV2DvzYOdanEAcSfqgy+m89?=
 =?us-ascii?Q?4nnT/uviZ6JF7k1f166Wh2gi0EYi1Ru9qg77Q3CBpOjCebVt3g8HhHShPng7?=
 =?us-ascii?Q?H4XuLmGqOTdgVROqgiB7wE6c9LlQuec6S13SXMoLUDkU6fBfQZxDpdhTTgYC?=
 =?us-ascii?Q?O/R9PmSAFBbVPFh8xflZw4qJlTV1cScZfuHjJ2anaGTAihenq5iUVBWWNgbC?=
 =?us-ascii?Q?0eeVtPhdDJCsEvRLXt/rMDPkDkZkr21ZorpyjrpjJmlBi/+ooRxNYACxECpr?=
 =?us-ascii?Q?UP5f4HDxXfp0sI2U0iRaF+igWCcotD+FNEbU+vk2ZxLjAgm6NgUsYwKEgsbU?=
 =?us-ascii?Q?oVETilrN/pGYlKYENgpggjUZdTFjmMlQKGAqmjF8vDNAJvRIUFrWQpEnTjp+?=
 =?us-ascii?Q?5WJ+CpoREsUkosjITColiYi9n0YSNu6JMCSOdM+JcMHSXBNkcrhBK30mmouy?=
 =?us-ascii?Q?rIFjt3pSplk0p5FidI8Hi5Gx/0quCZelQuEQtqa9tAJRWilV1T5F/b91SNRU?=
 =?us-ascii?Q?BTi7Oa/Ay1KYbWEQoz5XeKbiG5K9XhDWn7LMHz0KFGUeTBadr5jNjR0/UV4p?=
 =?us-ascii?Q?SHqwOzQebW4wW1lbeTD4vbrtwfPegNrA584hGNzB1zVfyG/njxEzkKfWMGxf?=
 =?us-ascii?Q?qckRvfFH/jcIRRJQi5eaqz+i3o6Z4No9UXX0gYrvWbtkaNAM8C4Y4pX62UGA?=
 =?us-ascii?Q?18I0bfH1lk9fQ+1fJYzmUmQu2EqAvaO6lS4u8Evsm10SA3yNXepNQqw6eEft?=
 =?us-ascii?Q?k+48Y9nIx+J04c7KLOOsdJNpFdp18pQFbsjmrL7L+8VV8zPr1DLMgBKwdlQi?=
 =?us-ascii?Q?bDhvqZEkyPqHzJmBJb9cgB0WCF4b9QA+p0zUmwb0KlZdliGhijK91F0sEb6J?=
 =?us-ascii?Q?bsOISFsKSy4CmTw3AmuXVlxdodWeBmNyY5exvclwH/92o/oCqgokV1NkCXx+?=
 =?us-ascii?Q?P1ND5bFF0ii2yXiQzcz3S4xgx4cBN6d60GAyFsENCJziNqxS4inxk7fnCOtE?=
 =?us-ascii?Q?BzXToFjrs4X4aVF51l8lmsO9vbQFI3pyBDYADIrNHJl/sgJgIbph4Slf7WLP?=
 =?us-ascii?Q?RdwIaQcyBJSoWKHfBZoKjDDa06hHiNjx4LDOM785YpHwmeN7HiXdSxQZN589?=
 =?us-ascii?Q?Kw4T8BIBrwhG+jJzmONEkE31kpbDj0s7aLUbnd3Tu88cJrIMOc+ahmPS1d1C?=
 =?us-ascii?Q?IUcGvpsobPJGYWIniymB1PqbnPZVT5bUEZqZlx+8qG1x9P2eUZ3ZJCe9sNr7?=
 =?us-ascii?Q?Lr+lXFkPeVBDMksXOUQ6CMS+nAl424OuymmSAn1Fdy+QpTR9T6Km4KEZq5A8?=
 =?us-ascii?Q?+ovfVcKuM0zol5KcYyyY2tmQ3IzWw7Oc62gIdcxOKo0/u1ElIneTHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIeJBVdDHMJqPfjEP6MRsaL1OvHkj5OfvhsP1G2irTwS8ZhTAPLP2BIreu7K?=
 =?us-ascii?Q?Ekqld0jy5PXqhbH7aMOCDgyjls5+jlkuvxwgp9Ch7qA0cnN2fEPcnsnMwWc7?=
 =?us-ascii?Q?KswDK662HBOrthzbUsyot1Dp/OP4rswau9mWD+QEHBwtQ54F/3nww59DEJ+r?=
 =?us-ascii?Q?/8Uquosj/1HK2Bf9+IMqtsmxK0RzrKrGrLIIVsOpoCSPOQsJuuoRKqierm7S?=
 =?us-ascii?Q?5KzYpYdyPBfE8R6v7nQ7qheQooJ5FtFVNm+4qvozDd+/AAMqrWWKV0ITGZyB?=
 =?us-ascii?Q?7LPcMq2Mm1bT8jm1URmiKx9WYjjbHpOZ7cxYKkiqv/gaOXq74SIFnbnbOhv8?=
 =?us-ascii?Q?931fAunrDpkK+Ds6l5MTsGZHf+aV+QSN8FsAoTfgWA4cb0T2jfH7CjcJKCaZ?=
 =?us-ascii?Q?jqJlLoKWeH1jGj7OqvpoMs9TRkGSG0DeHIoSTF22AyAW1tZgbxALVnWEAIWq?=
 =?us-ascii?Q?9yNHsN1zuBalbTpMt0vbtSYZHSBmrrO3IZb/yDVzGPZeT98mrNpAE9vH8kza?=
 =?us-ascii?Q?m46Tl7foQZEHktjnGuP4/2Lxzd9nHgr/VlO8e2RrjduB3tlre23M3j3F79tC?=
 =?us-ascii?Q?YnJh6Cqh619gqlqxHKVCBYHOu0sSm7oWO+PxMkIY9nAHNUYwAclRqwxeUGU3?=
 =?us-ascii?Q?wmxazWI3YefEvezcU2eASP138tWyi1ikav/5zC1i5KKomEl7qHBnPYuHRwMq?=
 =?us-ascii?Q?zXIt6XjtaB+mHPzu8dccKhiybqrxWF5g+V5wXJIqcSz7/Y63Nj2Po+culBw/?=
 =?us-ascii?Q?2MYGIGOz6v73iOjd1szG5V0LaCepyDoYxDGvcyjaQ6zq28AmCSN9sfh/pQrK?=
 =?us-ascii?Q?mr5GS1zVERnmxBUpyIERxBquL0hGVo4Lrqx1IS4MyXEokkWgrCspsr658RQx?=
 =?us-ascii?Q?WD3dku6gYcJVY3qZb6rFtInrK7xmezihAUmnucefHF37NZHSdDnsojYbwh/I?=
 =?us-ascii?Q?pAOe+wTtbqEJQE+aFJaWF6tdTAqKQxPC8cOFpE/72pmfq9ykgHQc+cFmKwJ4?=
 =?us-ascii?Q?TLPmhjRX4b931ZTXDTVNUdSEdxlyszv5dCqb9v73JSYjeUQZ9rnPrV5xkq5i?=
 =?us-ascii?Q?a3dGPO6mAI/LqMoUJN3J4cxfGWzIxcPbIJn1p9kwng+TrDl1u1/SIlM81pfn?=
 =?us-ascii?Q?94s2KIG/kOk8nnMZU0s8FeftO0r4NqGgEgefCZPhjoYVZND7eQaPyoOfxKty?=
 =?us-ascii?Q?uHO9+qBL7hSs/n1WFbi8H67hCKjnIaf2EBNkty+sqzAz9llsf3p73qxk0umD?=
 =?us-ascii?Q?aJRc27GLceN41/xpXS8hQUjq4SjT9vkoII9cucdIXd5za2ZFo36KRE7DnPk+?=
 =?us-ascii?Q?g7txAiEp61B8aUIN+/ZabrjMYqybgeRNdqzwJtP3v1RzAlNQH8zAC9i43y7P?=
 =?us-ascii?Q?mhr/Ss9DzRAI4HDcGNitA/gv65zuWv+AqdMYp4iNXq/ooOUYm+UUZ5PNGZK6?=
 =?us-ascii?Q?iyYxhU8F7HoMwq/vEvKVydsP4aw/ySzM2elUhHM15dtgBfmql1HY4hqwINhZ?=
 =?us-ascii?Q?fo0WBIjn8qABqXMPUxN4XuSCBWFAnZ92e5p0/dpIm7tVoJTJi/2v7qpmr95U?=
 =?us-ascii?Q?onwPPkp1xYdEEo3ZUsi57+wAPr4hM9g2seAflNS/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c096c3-ef28-466c-bd85-08dd78d0a163
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:12:41.6851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUsFCB8MIgtnlVwWu49wtAqBvp4xHq2qynIeXHqv74BhAhEKgtfQ1p44vKpMgpjh0WVae5CGrlGh2EtLSGeosw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 ++++++++++++++
 common/spl/Kconfig                |  6 +++++
 common/spl/spl_imx_container.c    | 41 ++++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 3a5bdddd785..d2b0455bff9 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -729,3 +729,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08045f9c8d..1d46003fc5b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -361,6 +361,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3..6e6afec1ff3 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s: failed to load image to a trampoline buffer\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+				printf("%s: failed to load image to a non-secure region\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT
-- 
2.43.0

