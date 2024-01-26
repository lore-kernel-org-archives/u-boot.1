Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E9DC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 09:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83ADF878AA;
	Fri, 26 Jan 2024 10:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="er0p2qgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CF0879A2; Fri, 26 Jan 2024 10:32:12 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D448785A
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0EcFrq4l0XqzG4saFDk6QXEG5B1hDHVMvfmbp2LjZvqhrybaaCIT7QC75CQCblkx3aokn+RVVlkcktSYiUMvhd0fOLeXrHQDdnS9cutfqZ2cIph60P7pZDVVuI8dR3OSenu4olMwWKVgSkSzv5Du4fOf+kdZY7NTnU4oMDGzmU3L4aFBNfCLrc+FmtXuHquA1xU3hrxPnGlLGZFyox9aV7egh+KG+B24YWmvNFAh3jTyXYGbKmmfZ7eJrCqpRyu3/LiMCtBmlcXO8KOsH6TaV+xJmGR82BWxIhcpYj04t8SxrGLQ1de9byDXE/bTj1pd7D4Z284Lldp1CPG/mJNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRA59UIxfzJmQVH5C0LVr5LCmff28F8oXL40WxkO2sY=;
 b=baL0ltw0FskFaXNLYFg8zzkkue3agyFnRGM2dOZxm7VXXlb2jAfQzSTWERuIez/ksC5lPzK/MCQwifAByQCMKWYoP03U6nkEuUrUFhZY/NCML/rCEoAAhKd8ZV/2IS/V8b5Z8Ql1x3SOhk7FNBhPXTFypJakrhsMLkDhxfyrezNSBWUW6DezkWEyL4qOyJ9E6N78etLDKwUmTOYOGZZ88VbyLho8Q+teA3NX+uv+6bffxSpvWk7rP1fwJQsLo14LbxczeDPcQj/QAF2kiFDu7+N+WeX4nglkUH+yZ32cfhQ86RGAGhK/bRaPD4Y4gyq1kdfbgL8Js5TYWB4dLGVpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRA59UIxfzJmQVH5C0LVr5LCmff28F8oXL40WxkO2sY=;
 b=er0p2qgx6mVsILc9LUZp9fCtgFXb+qEA1BeIhHpMtwkXLDaL1GbH9VRYel2G7SviCTjz0BHB6MJHVjkPzpwtHzZ5E6wKtpgeHQ1CSGmzoo/KPqUxvzZZbU3s91GzRE/j04U2aLH64+Ilpq5RpBZ5IJkmDPKydUeTV/2VzGFZnRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9740.eurprd04.prod.outlook.com (2603:10a6:800:1d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 09:32:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 09:32:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: anastasiia_lukianenko@epam.com, oleksandr_andrushchenko@epam.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	elven.wang@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] xen: xenguest_arm64: map all VIRTIO MMIO region
Date: Fri, 26 Jan 2024 18:29:38 +0800
Message-Id: <20240126102938.12613-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1fed63-4734-4622-78a8-08dc1e51a8a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbzYBSFJIKR2mN51pcun5q5Ejn/GZ/1Z8X+8KldXN/qR8OJ7NkRgaddOEi4U/TSP99aQQxFMMqcE7dRbaFbPO4kzlOD8BObb14/Xs54F5VXAl6a14Ihv5lqfuXEQdMYHAGOR7Dx9ezF6PULjsb4Z7SfslzKS1lBAraLQcPGXBHAVXI30xup3PML5CI0uhpzOWeRZiuRztHTHmXBACm8c5jLHYk9BkLlzKtPTzjiuUthdwhzpExauvY3Sz3xyvME0VUeX9tNLOctgZXMyrRnYAJOBAFn6yC/hAL0AWf4ZS7f6K1y9zRcucN5ECh4ZgNYWZe1wzDGOqi4wPN3ukH1Mhrv4luu0W2ydY0ZDj6yMVIKFBO/5snmLk+FQIaRf3Zsr3bhBOwlnjBYyvOR9knmgCoHvaEb9Y0boYrUpWs8akeG/3JcMFlkp/tL2fThGxs9oLlf6bNnZi9Hlt04534p7DYgWoTHRP1ApSSGevq+Gunkedf4hNa89ZZFsOqtRt7DGO/1hJvvSpKdtqJZEeLu2/OfvLunlBMsHnsjgNLfRu0NrolU/C6THzW1R51BV3SukXnEyMMuACZpPJyk75nx6YN/9S9MkovH43szzZU8Z7U+/9RENdIztjSXzF/YZq2GC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8936002)(8676002)(6512007)(2616005)(26005)(83380400001)(38350700005)(2906002)(1076003)(5660300002)(41300700001)(478600001)(316002)(6506007)(66946007)(6666004)(38100700002)(66476007)(86362001)(6486002)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PY4SaHxxpuWa8a6Dn2BD6tUz7OxFVYmlLeXlKVX/REThFy+xeZZQdS1xM5aw?=
 =?us-ascii?Q?8ATkd/d2hTlTgjL65jR5GcD86MNNs1ltuD1eh+3l7wkGcjml96ZrpQ6NJJ5s?=
 =?us-ascii?Q?hIsZrZyPKMoR/m4GFBHmxqp5yzLMcNS813tAhKrfHin6oh8ot/e1xm0I9oGX?=
 =?us-ascii?Q?tdtyU2aLfWO57dKJo2YDPF/ICiokE7KGYqkFLA8u+1/vIwCyx9wDcVwL0vGv?=
 =?us-ascii?Q?jW+NIVRY2cMdsy5N7uUQPt3y0gF0mG7JjepevqSVkOL2YQ7QxGZHw/dftuwK?=
 =?us-ascii?Q?Qofkbaexa6K+Ij+7nn9SHBCNGTRV6OdtXJx6LhBo7cynjhau0PrPLbFB9WB/?=
 =?us-ascii?Q?iv2FhWGPBZak0sbgq/Ppp2ejyjVS6gcgCOaAjoIC4cHHGrXtosNLaAWdR1WC?=
 =?us-ascii?Q?miJ2lpzPr31cPMUUjqIlXbhkaDszjjZpNtPcXtD2/fBap3McqMXG+NKCuiYu?=
 =?us-ascii?Q?gpdVKoQGuUTTjWJdPACbMWMBo35YfZx8rrKGh3FX7qKl3YSIdKi03/UG8o44?=
 =?us-ascii?Q?SO0dAGBQO9tC/VrEOHkThcLg4RwFYjy/5UOlqQlLmuZ2BTuo9PIRVg/bYObF?=
 =?us-ascii?Q?BbneiD2oz4siLtF667sEQmCxf0FdE/LLCgsaVlFegH2D3VkxxVAmuCl6h9n3?=
 =?us-ascii?Q?vrdAFxi+pYqs9VOt4Cdq72HGAEvRyC+bvxpQiB4Z9YRJDqHzScj/LZAZ+Y17?=
 =?us-ascii?Q?gv23PwWVq/phA+ZBMLvcMGLpu+JuJ6mt0KXbjXqkczN91zeZRns6etDriZpw?=
 =?us-ascii?Q?aTH+9jyNRvA4ybiIc8M7HSIa5HYwjVIryPscc6U41SFoBtBQyDHdEF4o3Yxd?=
 =?us-ascii?Q?4dfbyLWUfWKawKezUFKspmn4g6ezv/35FuwVL2EtLRd0GYtbRKY3HvMBiiKz?=
 =?us-ascii?Q?36DGmWEAChwuWW9SrAUcBfhkwH5L9o4t3sav+AzuONk/wK4IqgXMzHKlWC9D?=
 =?us-ascii?Q?BiOMt9dJ/cI6EpnAAu3OPe9tzOlrtzPk3jmd7/p35jZ4411rk6ULA8A+/ytZ?=
 =?us-ascii?Q?+Jn0WZJ6STLfPkUnuYBBrbiFe5I2t0dkKRDSsBOM19Q+t/844NOfXtpWOFco?=
 =?us-ascii?Q?q3fQLps5X39XHlarHru0Olb9eRLyZEFsqecIWHQeQagbakDMj09IUtYOvLBZ?=
 =?us-ascii?Q?LkS3D0rurgbW9yWnXU+ebKH4XpwiFbE/lsqY3RgCjdlN5GUHM0eyn5BvPAyz?=
 =?us-ascii?Q?m3QonBr0P7+gmi2C5V6k7TtynPMRdRaf2CGASD/MAvPP70+Sr4zaQvREiDRg?=
 =?us-ascii?Q?Y/ZBo1TotPLd3ZLA4zdp9iAxxaw2MJPimQKsuBYhxhv9pFqcNSGhBISN2Jxh?=
 =?us-ascii?Q?bfux+wajeh0AKLA5UcfrlIW90RCi3fdGvuaaiqUyDAgwvLyGgcwVTxNtX1mx?=
 =?us-ascii?Q?pKmzIGk8tO1Cg3jPQWqzoUm+717F7U0nm9g0z10U8mptt6VXLlaXkYmAmM/l?=
 =?us-ascii?Q?A6LJQqPiXwLMJS9TpLsQVy7LTVO230BOIUiCBwXilK5mrvzV4ujw1x4kajEK?=
 =?us-ascii?Q?YY4uboEWi24ro2KGBWubrRJ8T0U8Yht67PBxO9kEl6uR3kU/8Z08l1srVw13?=
 =?us-ascii?Q?0bEykMCI+besb9KvHW3gQok7gilZTv0+wPt+qAHT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1fed63-4734-4622-78a8-08dc1e51a8a3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 09:32:05.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es5gfCZbovGwugiH91AeAf0dY9yap7CiFcG+QKvcSC4sEIEktHip/3CkOA/5ZVnzvPuZMHjTdIzFQdWX/IKkEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9740
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

When run `virtio scan` on i.MX95, there is abort when accessing virtio
mmio region. The issue is the mmio region is not mapped. So let's map
all virtio mmio regions.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/xen/xenguest_arm64/xenguest_arm64.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/board/xen/xenguest_arm64/xenguest_arm64.c b/board/xen/xenguest_arm64/xenguest_arm64.c
index 244070a242d..1d2946f4fde 100644
--- a/board/xen/xenguest_arm64/xenguest_arm64.c
+++ b/board/xen/xenguest_arm64/xenguest_arm64.c
@@ -31,6 +31,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define GUEST_VIRTIO_MMIO_BASE	0x2000000
+#define GUEST_VIRTIO_MMIO_SIZE	0x100000
+
 int board_init(void)
 {
 	return 0;
@@ -212,6 +215,15 @@ static int setup_mem_map(void)
 				PTE_BLOCK_INNER_SHARE);
 	i++;
 
+	if (CONFIG_IS_ENABLED(VIRTIO_MMIO)) {
+		xen_mem_map[i].virt = GUEST_VIRTIO_MMIO_BASE;
+		xen_mem_map[i].phys = GUEST_VIRTIO_MMIO_BASE;
+		xen_mem_map[i].size = GUEST_VIRTIO_MMIO_SIZE;
+		xen_mem_map[i].attrs = (PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+					PTE_BLOCK_NON_SHARE);
+		i++;
+	}
+
 	mem = get_next_memory_node(blob, -1);
 	if (mem < 0) {
 		printf("%s: Missing /memory node\n", __func__);
@@ -219,6 +231,11 @@ static int setup_mem_map(void)
 	}
 
 	for (; i < MAX_MEM_MAP_REGIONS; i++) {
+		if (CONFIG_IS_ENABLED(VIRTIO_MMIO)) {
+			ret = fdt_node_check_compatible(blob, mem, "virtio,mmio");
+			if (!ret)
+				continue;
+		}
 		ret = fdt_get_resource(blob, mem, "reg", reg++, &res);
 		if (ret == -FDT_ERR_NOTFOUND) {
 			reg = 0;
-- 
2.35.3

