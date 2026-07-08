Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D5C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3386884A5D;
	Wed,  8 Jul 2026 14:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZZgBDlEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0066838D7; Wed,  8 Jul 2026 03:13:29 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C3B8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXiev97su/V6J1HjLqMgNPprp6AxUjZC7QJ9fbyS5jTF0LYlf+/cjSJXNhCFrVOMSKfOwPhIJ/sI1X1Tup4vQoaW3rj+jCKpsbIJzbhsIbqxSznBjP3zsXGnCP0IGH1vgKhgppxuzpZi2+tZa0y+RYlq7/FoUqaetdlOVJpjSE1mcOsxbktIfjTvmj89gnVe2ggqd6ZxYrqGrX5vbK1FHnr95EldfUmmjhdbws4P+qIjCig4QIpLlziy6vpQd9uT2+XpMgi72MuymoNUinSepT+yBBslcXORA2TvAa3BbaQ4Uf6pg2U/cqVGaQpSshhdPz4QR3yWglPDuBCLutZupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip1/WKS0i67uDxM0igLcKl3FqH3GPGy0Zns1cZDwkx4=;
 b=drC5bZ5223hakump9zvL+9rckTDyJXmRDkrEIQKjV0jDwdm0IKA0ja5OmvYjnNnqg3KfICjKOeycKqKB1Lf7SRBiG5v0HMRRle05bdupsYHHQItmKjLjQlp2NbF2C557VWX+QGGIKkfJac9TyEA0pIjQsrqtimgrEXgUKnfT7QRTfzciPzzmRD+wjwRXczvBIPrgyV6fULnYWZQtBrc4xJFHvfnQBNueLoIYjxSsgCsTaqsEdczBjTw17GU7BOemC0d7GZJLU3bsb6E3geJc033yFzASGR28N1T1UrP2M4Q/9/3RIh1XqGN3k4a1JHMmSPp1dYg9BQz7HVFd+TjucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip1/WKS0i67uDxM0igLcKl3FqH3GPGy0Zns1cZDwkx4=;
 b=ZZgBDlEzYz2NphUpUiaDwPt+n8MjkUDxCO0GcAIndZ8wnSp5OF5a3CV5KlhJLKj+x4urnZ/lvbIq1GP6FCYfUkZkpZG9peENFLyMhO8SihgSJnGZ+KCsJ3+uPdHVgkEJpPkUG9vBWRko0XJhcvcV1iJaN/oR9O4H6Y10WIvCFckvH4w7dLXIN6se5bmzaWTCKZ3Lfg1l3Ffi8gI/PzQNHXC9ZCLlWu/svp4JlC+TyOyYMPJF0yachg/6DH+ltEtlmcuVpicsjmbuT+U00/VkqQW2uXKEcgDicnxZib+aa35Npw5uiuT18BjJV/TzKmNlEcWiASng7nehCZT59K3RwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:23 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:23 +0000
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
Subject: [PATCH 08/15] ddr: altera: n5x: re-init DDR after watchdog reset from
 init hang
Date: Wed,  8 Jul 2026 09:12:21 +0800
Message-ID: <20260708011228.15613-9-chen.huei.lok@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec4129bd-0d85-451c-d298-08dedc8e1aff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: SXi6p4QfZ2D2II/Rfl/TDStMIiLzhyfbPX/43QfiK5nZOhjs/M//OgODuf+OtXZZlclImsNGQD38IbcZsv1JHfNzNA8gRyBrQSUOtWg3Mb9D32lK7Z73Ec80O2cCBVzHcJifQdVhbfHaR1YQ4TZpaj61VQHQBEbtsdRJUPlrZfFYHBvZUbX6Y0S7NsCp37kQecT0uyG++/XDhWIeDmgOkvo4twXyTd1K2n0/j+Vn4R5Fi3siUFxfpiR6GT3GNAS+VxAsAZDexP0Ofv8hIK4GwGNHUWvoxhxsWmDQzMTicxSrwK8ivI8OCPOYv+smctt3mAYQBeC5rSLw43l2IWxQ3Lp3RRwAzb0eSB8l7yD63fw6jEASXEsKG65nzxUdSZL/9ZDgbyNakiMQNzBZU2PUalVvK+l4e0G46ZeURHcmb+fPKf1AOr9TEcCm8NSGi7fUUfUIzbv8HzlHdfsTenyFjzngpvONhpvHcUi6vaPgCO9DF8ArGzC50YfzsGp6zYhq4/08kE9sdcsN9RIM8/RxS8PJujt6QpKNmTN19DSbD2b+Qhaf1hDebi+HPv3Ti4BQJRctgDIGJ1Uzerh6j+1x+t96lkaZwl0GBZMhcXlj26+PzXh5AWApUTm01vXFTrsV/21zdhro2D1Gt8SmBlU4y6CFR97NmCumeTKBtce+G0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pba3HiH7zQbrJyvV2WQh6sGnRGTRVsWad/Zf4dk5ukr82xIlnCGkhKJucwfH?=
 =?us-ascii?Q?nqvggzDWPxRv56tIcXwV1q/Hb7OvMape/2NrOivULY8teK1Xs7v1Wu94J29l?=
 =?us-ascii?Q?ZfVf657rYrM6hsMTMAGgdtsCZMcvcKgocdQ9IQYhvuqg3+6PMnB0/NbQgS8X?=
 =?us-ascii?Q?keMDJk5lvhJFw5WBYK9BmZOd++k1SqBXYEsrXkFvURXRyHuoHNzR4HXmW85v?=
 =?us-ascii?Q?TrzTZEmo7c1+yiHptaeEQLWJ1uSnKL/V5KSL3nn7ZouO1kacjaAoPNdcYKYP?=
 =?us-ascii?Q?st2ZXClR8cidvL6TkoLLFY5eAbQEiuG7i5dQzEH4pnE2gHlYNSa4wEcdFZAq?=
 =?us-ascii?Q?dx/R4oSyAOnTRvZ5JxPdOVTR+fYMvo9dLXOe6j2/NlJQj0ZVQvfB8XPjbs25?=
 =?us-ascii?Q?aJWzWvGwj7YvPhtRnJC7cFj+4lW5zMO9Uy+quiaNCH3ejHJi9cAsBP3Whyy7?=
 =?us-ascii?Q?jGXx89rwKcy8Y/ls1hhYpl//5A+pVVj0XnL9Iopl3cnd+6jIf505K2ZwU6ao?=
 =?us-ascii?Q?v4fJF546sqxoaETeUue5V4ld9R1P2wTyKIailrGXkLPsiWfzbsWLblyds/Rm?=
 =?us-ascii?Q?wuytNR2jGlUcvDtQX1kF3IDIjo7na8Wdp0iNDtO/IoH9/cyz3t9CEfcOBeA7?=
 =?us-ascii?Q?QteA2Y6t7XS/eD8Y0EN+/sIh/5kvbKPqKe/FBpBAZM4vr8uqjipCzO0751Sd?=
 =?us-ascii?Q?/XuF3OIWb9yRHuvceEwVIB6HOL0Ldc2Q3HeVzr+Ou7+X8dCal03sg2xFfIvB?=
 =?us-ascii?Q?669o64CN0DkUWWgrOd3irjqDStbMo+FEiPMKDLN8MogT4wE25wly5cshroc/?=
 =?us-ascii?Q?VoMqP8Qtcizo/3TaclGkofxbPuFshnNVfJ3l3aye3VkMTUCwNR1KHO6fukDi?=
 =?us-ascii?Q?yxdrHSEgLWmQjcDt385Iz6ebmM37oakmeNuV+G/iwbudFVjsMn9D7GRSbbiB?=
 =?us-ascii?Q?gLIa+Yt12AdH+bcH3wUC+zaLahlTRo9vMMXGlHDmeOwnHwh0I2WUQPNi6UMK?=
 =?us-ascii?Q?TgdcZnGOczDUR261SIXCl7EjCAJgd9WxBHf0cTlKD1oI6uWuovwNGuvkp7zI?=
 =?us-ascii?Q?phovG5bP4U29yiDRs0n0nS1z142vpRUYnfqTZj8QwQKFxpeFHHBfWYp1CocH?=
 =?us-ascii?Q?WaR+EskqPGwAeDI0wtYCXjRXXCP8rScHe6obtVfdyZNU6QmjJKDDqlAWhktC?=
 =?us-ascii?Q?emIAJcGTb3Yw7a3CWFLEwi8aWsAbad6F9qSUf3dtcvyBk/30PMOEr99rbj2Z?=
 =?us-ascii?Q?0ttOjJt0ZBjDiW4ce6MYR5Dp82Dg3gEBrjYI09K7HLdM+qIel77zf1mPSO9j?=
 =?us-ascii?Q?0FlvNWu7W11WT0nvW0nHdKFxc3gYC03MhXKPuP7kAWBGuLFWWyhkc6/mWo5d?=
 =?us-ascii?Q?+bQ2lADAHGCEteJLBRN+D8bH/Frgm+x5xjVmLGsKchVmS9nPp0WZgqwraymb?=
 =?us-ascii?Q?YOCW1sdSXahWXpvRHpIfOiYS5MRmbS8QQ/y0JLqIoW+obcFgeQseiGn/Jntv?=
 =?us-ascii?Q?PHna1PbNicpHPEHVYSKsI1vbTbDcFufTTWaktEi2HCWRPH78aHXs4X1ikHfg?=
 =?us-ascii?Q?gYxc5GZZptyz18+/KESkymXYnH0j3j9jv0lbZpwwIccFOBE5Mv414enCPO6A?=
 =?us-ascii?Q?r0xXu7rMN/72hx8Gug5Q/vtaMj11a0FKwHcaZclP6TE1xso2vngoFRNUSlRS?=
 =?us-ascii?Q?6/Qt1uzv/Co+fX1FG4SM50Rlie9kQdG0WzkdVJPwuas7naqibWBp9hhjmjOs?=
 =?us-ascii?Q?EfZPAvQ1CX5VPuoypDPTmXlgNOnlUw4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4129bd-0d85-451c-d298-08dedc8e1aff
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:23.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aecL0TvgNIlfaNLXjrKMiKQbuM4xhTtM2NUQwlk4tzVJvFR15RYh6s0qaJNSk4hIwLUQGYZjGEqVLYo02TKJcXW4XtxUIlnPetjsf94RbQk=
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

If the previous DDR init hung and was recovered by a watchdog reset, the
DDR state is undefined and must not be reused. Detect the init-hang
indication and force a full DDR init and calibration instead of taking the
retention skip path.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index f6ce15bffaa..538a0369a39 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -421,6 +421,17 @@ enum data_process {
 	LOADING
 };
 
+bool is_ddr_init_hang(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK)
+		return true;
+
+	return false;
+}
+
 bool is_ddr_dbe_triggered(void)
 {
 	u32 reg = readl(socfpga_get_sysmgr_addr() +
@@ -484,13 +495,13 @@ void reset_type_print(enum reset_type reset_t)
 	}
 }
 
-bool is_ddr_init_skipped(u32 reg)
+bool is_ddr_init_skipped(u32 reg, bool is_ddr_hang_be4_rst)
 {
 	enum reset_type reset_t = get_reset_type(reg);
 
 	reset_type_print(reset_t);
 
-	if (!is_ddr_dbe_triggered()) {
+	if (!is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
 		if (reset_t == WARM_RESET) {
 			debug("%s: DDR init is skipped\n", __func__);
 			return true;
@@ -510,13 +521,13 @@ bool is_ddr_init_skipped(u32 reg)
 	return false;
 }
 
-bool is_ddr_calibration_skipped(u32 reg)
+bool is_ddr_calibration_skipped(u32 reg, bool is_ddr_hang_be4_rst)
 {
 	enum reset_type reset_t = get_reset_type(reg);
 
 	if ((reset_t == NCONFIG || reset_t == JTAG_CONFIG ||
 	     reset_t == RSU_RECONFIG) && is_ddr_retention_enabled(reg) &&
-	     !is_ddr_dbe_triggered()) {
+	     !is_ddr_dbe_triggered() && !is_ddr_hang_be4_rst) {
 		debug("%s: DDR retention bit is set\n", __func__);
 		return true;
 	}
@@ -1593,7 +1604,7 @@ static bool is_cal_bak_data_valid(void)
 }
 
 static int init_phy(struct ddr_handoff *ddr_handoff_info,
-		    bool *need_calibrate)
+		    bool *need_calibrate, bool is_ddr_hang_be4_rst)
 {
 	u32 reg = readl(socfpga_get_sysmgr_addr() +
 			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
@@ -1622,7 +1633,7 @@ static int init_phy(struct ddr_handoff *ddr_handoff_info,
 			ddr_handoff_info->phy_handoff_length,
 			ddr_handoff_info->phy_base);
 
-	if (is_ddr_calibration_skipped(reg)) {
+	if (is_ddr_calibration_skipped(reg, is_ddr_hang_be4_rst)) {
 		if (is_cal_bak_data_valid())
 			*need_calibrate = false;
 		else
@@ -2815,6 +2826,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 	u32 reg = readl(socfpga_get_sysmgr_addr() +
 			SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
 	int ret;
+	bool is_ddr_hang_be4_rst = is_ddr_init_hang();
 	bool need_calibrate = true;
 	ulong ddr_offset;
 	char *endptr;
@@ -2840,7 +2852,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 	 */
 	writel(SOC64_CRAM_PHY_BACKUP_SKIP_MAGIC, SOC64_OCRAM_PHY_BACKUP_BASE);
 
-	if (!is_ddr_init_skipped(reg)) {
+	if (!is_ddr_init_skipped(reg, is_ddr_hang_be4_rst)) {
 		printf("SDRAM init in progress ...\n");
 		ddr_init_inprogress(true);
 
@@ -2882,7 +2894,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 		printf("DDR controller configuration is completed\n");
 
 		/* Initialize DDR PHY */
-		ret = init_phy(&ddr_handoff_info, &need_calibrate);
+		ret = init_phy(&ddr_handoff_info, &need_calibrate,
+			       is_ddr_hang_be4_rst);
 		if (ret) {
 			debug("%s: Failed to inilialize DDR PHY\n", __func__);
 			return ret;
-- 
2.43.7

