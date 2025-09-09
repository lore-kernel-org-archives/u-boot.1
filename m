Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DD7CAC581
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 02:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7830831B4;
	Tue,  9 Sep 2025 04:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Wt+IP1cZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0818B82A9E; Tue,  9 Sep 2025 04:13:10 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1816830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 04:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2n6nRyOTAYoYsqziXtrLo+9OiOKRhop/ZrM5bLINLAKfNJeRJYSss1nUQJQ/dEupFwi+BwM2t7Jn0rxTsr6akNtGsBShviV/W5ijGtKHuLaMTnbRkDH9vG30KC1EvAru58C5vf2XphP4daum5hD2bYJ2fhS1KybmsnHVqmfg/pNYO2xZ2qRJ2i0Dr80b4Tklyn64M1d7bpP7Fr0ya9q1pytYKdrUIcZNFtAvuqWYvzT5+U1iWNkSEOaNgIgKBj8MYIa0eUevqPGIVP/AoH6chSrj5KoxHmtaOjbo36e2yNx5JDs6/PFtuFo3UMOJRP7dSZiAnhoQCQGmVKsMfWRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Tv6w4GwPQb5RbwY57I9yPIrDYC9IecaQKuIykR6ZfM=;
 b=uJXTuN2sRXU0GqgJNWq1fsL3+x/Ms4GiyxXHRAdiNZ33lPCHz23P/NEfyVdQnpaGf91UR5E3mpZgwkALVKKxJH9PzZNA/xqnAfRGRkEasLKj4ZDzQa2t8glgMm/s1Y5fUgVub2Sclu8caonyBf2fprGb52nov0vxLrWjdKDrpyqFdyrZb1vcf9tPg8drpE5y+EONbStK6Mz+g87g5P2AbNiBkZRH3VJpMZmnclDGwIz5HzcXO5FiUCWGDFsXk4zFDNvEwQ5CUYg5BsnNtc+zc2gFfnq97ZGjNzfPOdki1VuxdBQWzDAWCCW9+3OFQv7pVZqcSgqB6i98QpikyMVOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Tv6w4GwPQb5RbwY57I9yPIrDYC9IecaQKuIykR6ZfM=;
 b=Wt+IP1cZ5G0HIt6OR94dkmQRKdvFt81pYIaH2bKPpWXX8jyG11xv4nmuLOqn0SeHHHD+CZhxJGY0yKqQUpG3pp7bRxNGD4GTDVUCScN5swkO3waW3hU96+0tQO5Yg1BFoXYphKAtbgAbBd5ETkh0sm2ynK4xXlxFds6AsByZNikVRwNGbAuYGx4H4Kp6vUVEK6PUDRVL0YcpRKdTM81jcmD5Q9/8poiWWNpJB3fLSf7kwvPgEntZhcwSiCxOkoXW6iXeuh5lgaQQwDxfOs3ciYY+mASBXmzhmCA6THai877sbFXXkJbiS5cfBt84Khs/PnRkSwaFvHVvcdQrK9dpVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH3PR03MB7314.namprd03.prod.outlook.com (2603:10b6:610:1a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 02:13:03 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:13:03 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC clock via API
Date: Mon,  8 Sep 2025 19:11:16 -0700
Message-Id: <20250909021116.12599-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH3PR03MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abe0f71-7010-4388-5145-08ddef466825
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8uJihxnqXj+Nk8r616ZfS+trARZz/dcrAURUKuTg9M4FmY2v319OE06X9PjE?=
 =?us-ascii?Q?F9j/TvY2S5v/ehmeBeNTNtRvphtqGpcSusAHzjIXE2Z/2u9DCWR1DIq5lLp6?=
 =?us-ascii?Q?KcUApj33ubhaoBsaHKpy/XnrFFTCOvYC1flN0ZymbbeWRmkmeXe+vJeYX0GN?=
 =?us-ascii?Q?OBg3TqWoTW6Woptst50rIyWm2Xa5P5y0UhziuwU4hfFQZEKmi0jJEDuFqKet?=
 =?us-ascii?Q?E3JuONlZTHHXtLVEiOAFUeRFVS8fO8d+MMMoDzj/cEKVQbY9fcM00wtYdBpG?=
 =?us-ascii?Q?u7uMIBmt50DBiouJtT8IJabsNXtto55LmQJ/8yiyFsknNXDm3ejWE1qkHf60?=
 =?us-ascii?Q?uUjYC+ctfgCkB9+K6V+7D6k2tgcfzxZZia5ySRb+XYkdaz9Pqd7GkU/nPxEu?=
 =?us-ascii?Q?TZQVH01VL24i+qaqPjLlTiwNo0tHOhrbacEEqzHjVXFtLO7mmbf9UrKcRhyM?=
 =?us-ascii?Q?LHm/LwgT2MeyZcRGsAtE1paCvt9IvImq5LVzuS5b8HyYl4R9sOaqOQJfxc/h?=
 =?us-ascii?Q?dOJoQCBNbHh9SFdHgSJKTYAFKXBz0psOZ+W5iogHvS3+aVfbYZ06u0jo0F0x?=
 =?us-ascii?Q?YaxgI0QUIRdUZCs3S6eD0priUA1plGwryPL7DGiXfjFMjqSIP6S6UGRhlBqH?=
 =?us-ascii?Q?BU+a03MYvQ3dUQyasPvMqJyROp+VUnrjUZKs2a/vhOdmtgvbNvOJsD4JJD+A?=
 =?us-ascii?Q?REwrsYYOUmpcodss+9oyvVBW9vuht+3Cx1sx76uMnP8zx1dpe0byspLwQlZN?=
 =?us-ascii?Q?LqhKhCzugRKYlWm0oXFFLsPMeSF3+Ew4zQew6nG5+9YKF0IQeTYB9Sla9YWY?=
 =?us-ascii?Q?OD8Ol5rUXCcIM4awSt+yF4aYLkd1clGId57MJgDw+JXcmC9D7HbYe6Qk4zpy?=
 =?us-ascii?Q?LbFF/Q1Tb2rtmJj0kGAasSqJQd8djQu6i8Bu9caj/RVxPDvrFpi37rQxBW7A?=
 =?us-ascii?Q?luyx9Kk6hkoPMOihlhbVHe99OoN4QIuVr0kCvWYJYyF9m9psm5RtIL2RNjF+?=
 =?us-ascii?Q?43pIRfBo1cqiLNevDuZvua6BFYU0mHsbmbmb2SRIAyWU5+acc3DfvZLiePjR?=
 =?us-ascii?Q?xufgS749x53jAvJpe9Go5zrssnv4Ikur20tNwK7fMj5zPKLv06055tc7dzGN?=
 =?us-ascii?Q?qecwu41/hEauDlgxVU5jONpQ1AFuM98N8h++UTmztL7fl0BIOQg6HbnFjD1q?=
 =?us-ascii?Q?HMMETgKccQahbtjYPMClKg8GoVMiy+OLgse+TvCyuwlXE7oTKWFCvAvf7BPj?=
 =?us-ascii?Q?R1TsirzeNpUqb0HO8u/gF9R6Bj324MwRl0Sq+QVRqv2GfVuwrvIWpo+1taf2?=
 =?us-ascii?Q?TuIIhg3IvVRd3UACHAudFnYQzd6BTw5qrPvBBaOEYRZW1u0lTxEeTjaLBUdZ?=
 =?us-ascii?Q?1SHFu2ccYYX5OtjAgqLms1+JJKTypWVjWIsdoJYFsDI1PS/9hDRACOelKMLU?=
 =?us-ascii?Q?eSV8mPnQO5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXf/47KRbtp5uVbLDrU7vFgQe8Yz6yQk6UjldSVBKhxIlphkH3BMSCkuHilL?=
 =?us-ascii?Q?r7vLvb/7jMKQYqa79hji6Va2G8/cgitIsROViH2+btq72qnQlhVCTtTlhgQi?=
 =?us-ascii?Q?Tmiy56Taz+DQcZIsjkTM8u894FRUORpqK08sGTKe3hy5DtyhCUX2v+Qm3oLc?=
 =?us-ascii?Q?BmZ1FzZJEMH9AURNiE95udxSvVFpqXWEZZ7Cn8YPGEk9n/cU6wdw90Fzwl74?=
 =?us-ascii?Q?yy8PRaSmxRaY15Gk80So2RB5g+Tb1yEGHunsGOQMvq2yB0EF47WpQlQlBn5U?=
 =?us-ascii?Q?OxjL+FNsx23cjDUBpBvK49edmCdLv57ofk3cbSn/pduWVXeEfqS+csvsEudO?=
 =?us-ascii?Q?i5a9r1NsCbtHDu+Oa8xDrVmTXpSfq9eDHPUM1omQHvyRoRDIU/ave+fm+/cf?=
 =?us-ascii?Q?UgnveMQZhaG2SnLBUzeacvrN2IyMlKvDB0HFmn98ZaCa/h1gnzddFSoMl1tK?=
 =?us-ascii?Q?v8SNMQrnMAOTPI+Qkkm08EGsLhgZxQAv+SgWmKuqookwFlSkiCUHJtEZVVyf?=
 =?us-ascii?Q?rHa09s+UECzLQKkMEWl1YzDiXxDwrcmcJJYKcpn1HlJoTsH3Tq3vmQ7w0CwE?=
 =?us-ascii?Q?o2qgvLIvN4j63orzd0I+GtfnCfvjE6AwDAdGUt9nEeV+q0+xJDn26hm5oD06?=
 =?us-ascii?Q?MlXfzKbb2o39nVmyKbFKb2C2vByPN5YkV6or3udHGwiepB4podW2k7tVTrTw?=
 =?us-ascii?Q?uJrAfpfdFG+iP1mC3b15IjbH2uQ0BL6HDvzpF+Fy041OUt1VqEprOuO4AXeI?=
 =?us-ascii?Q?O+wMyAcUecYnFnjB1IJm0DR9d7b52d0O7eICVa/CbvCaVF7Le9JFre1Oo4s2?=
 =?us-ascii?Q?kfGmNMwMK0FnKWi+Lt9mdjUrp2laWouA59zKay4vP6Ht4afjp768SN+MqvNI?=
 =?us-ascii?Q?k5azND+OtDVbuNPpaW/zJEeinPXpnZkGCpCe7CewXJGfclJXiQT9XxInj8xL?=
 =?us-ascii?Q?abD5jKY/iEth6+nMWnALxmaeij9jlObaruuF5ezHAX+D1ci6y48qh1xyXwf5?=
 =?us-ascii?Q?qJB+TO2IEQKGCIrQnwr2lmXhegvd7Eu2LPkZM/wMd5ZQy7fNks7hQOL/vFU4?=
 =?us-ascii?Q?VdpOfH0RQQynRjawJ1oqDERijXjcTx/hVj1ersDGlng8Hbus93oNSwe9wyFD?=
 =?us-ascii?Q?Jqa4VFuX6r5JXeDWcsrkaS+cYKUQLuvdwL5apxmWMp7HjmC1wU/LWbw7M+Sc?=
 =?us-ascii?Q?pxs0/P10HbYYSOBp5KVGSee1zJP4n7AYyqDoQmP/JuWETGVwXlEJu8P+IQ44?=
 =?us-ascii?Q?z2eEFYKtzylJwwEEivZgqTQQivKJ0LXkwi5nBAQRgOV8s+nuCPj/oF0TlSpK?=
 =?us-ascii?Q?S1QtVX3tOlbppfj/+SOGA+naUHnIrF56O/fMRyhsJehvnTW+MCGUg0eo+EHX?=
 =?us-ascii?Q?S0YXolzBW/BwTGF3InhAc4PGOppwtjS4QLXnvD8MyIjOLIjZ8JnbCHIzMfeC?=
 =?us-ascii?Q?DkOo5SMy87slHWpKgkKQaCZR3PMDUZG1pZdHh97VCaKCH2y9cv8/odn506x5?=
 =?us-ascii?Q?SLiATys4vGFoNUhtthdXhw08guJkKmxwvUxBm/2vKF35PUoUkvoiNN56ErI0?=
 =?us-ascii?Q?vMU/qKqoROJ8QphhD45yL3TJ8CUiKDX1L0wtaa8yeZJb7B2aaXs/AMzHdNPu?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abe0f71-7010-4388-5145-08ddef466825
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:13:03.2306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVOPkxjF/hD3haDeyeU7F6pBNtSzGNolb6dVznjItRWKB6zurx49+ikl8tBPAn+JkP5Xvz5XsQ4uPAXsh9nDCtfbGlpF+Sw9LgpHCsiHVx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7314
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Update the driver to enable or disable the SDMMC clock via
clock driver model API instead of doing it in the driver itself.

This allows for scalability of the driver for various SoCFPGA
devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/mmc/socfpga_dw_mmc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 3b86bc9b18c..db4e0129c2e 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -29,7 +29,9 @@ struct socfpga_dwmci_plat {
 
 /* socfpga implmentation specific driver private data */
 struct dwmci_socfpga_priv_data {
+	struct udevice *dev;
 	struct dwmci_host	host;
+	struct clk mmc_clk_ciu;
 	unsigned int		drvsel;
 	unsigned int		smplsel;
 };
@@ -51,28 +53,23 @@ static void socfpga_dwmci_reset(struct udevice *dev)
 static int socfpga_dwmci_clksel(struct dwmci_host *host)
 {
 	struct dwmci_socfpga_priv_data *priv = host->priv;
+	int ret;
+
 	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
 
-	/* Get clock manager base address */
-	struct udevice *clkmgr_dev;
-	int ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@ffd10000", &clkmgr_dev);
-
+	ret = clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
 	if (ret) {
-		printf("Failed to get clkmgr device: %d\n", ret);
+		debug("%s: Failed to get SDMMC clock from dts\n", __func__);
 		return ret;
 	}
 
-	fdt_addr_t clkmgr_base = dev_read_addr(clkmgr_dev);
-
-	if (clkmgr_base == FDT_ADDR_T_NONE) {
-		printf("Failed to read base address from clkmgr DT node\n");
-		return -EINVAL;
-	}
-
 	/* Disable SDMMC clock. */
-	clrbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
-		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
+	ret = clk_disable(&priv->mmc_clk_ciu);
+	if (ret) {
+		printf("%s: Failed to disable SDMMC clock\n", __func__);
+		return ret;
+	}
 
 	debug("%s: drvsel %d smplsel %d\n", __func__,
 	      priv->drvsel, priv->smplsel);
@@ -92,8 +89,11 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 #endif
 
 	/* Enable SDMMC clock */
-	setbits_le32(clkmgr_base + CLKMGR_PERPLL_EN,
-		     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
+	ret = clk_enable(&priv->mmc_clk_ciu);
+	if (ret) {
+		printf("%s: Failed to enable SDMMC clock\n", __func__);
+		return ret;
+	}
 
 	return 0;
 }
@@ -169,6 +169,7 @@ static int socfpga_dwmmc_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct dwmci_socfpga_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
+	priv->dev = dev;
 	int ret;
 
 	ret = socfpga_dwmmc_get_clk_rate(dev);
-- 
2.35.3

