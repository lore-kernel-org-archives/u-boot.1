Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E29105F7AC
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1363D84308;
	Fri, 13 Mar 2026 14:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FeCS29Eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD2B8431E; Fri, 13 Mar 2026 14:59:29 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853B08420D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6KJgX9riYS35Y/WEJKYoeGC2/cQJhsKs5pW9W/b6rCq0K4e4F+4pneaw1FPIiRQnhz/1PadqKfMwC0IvvL6CjJFZO6X4uMuWdM4BjqGV2z9bEvu9+tXyY9gg4XrGCir15vJycA02tJj/gRyRJ6L02sNmYjVs4eriZ0b13Xq3Icp8XMOmkkAlVnrDbzRjzFtOIoLWr52EnVuVP3+w/wu2+ofPpb+I/XIQTNOQZogfLPoX8kDqWb+NIru5px1lAezcxVN0uSRhqwaB4g/ksXovCHSEuv90UMpikxzlRDYyoq+Z/+PXXz2ME3otuQ9XlYrTjTSXbTPKcYZxCiWdMyzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1Vd6cvlX0/NtRIdZr6EL8PpAXatHWLmFvslmWpI5Bg=;
 b=GTW1dXKInFsDjgTiqaNLipudsmVVDTAEfuaEhZSDcrkpN8OgCQz4zhMDwBJBPcAdNvyJfYCPcd9P1OsAx961TzEBEny651PkR7nNfkE8GF3XjrqsaxstjV5hXmpLjAtRkBwv64R2FzOwXciAoTmkEQhowtPqoTELBezQmymCSCwcKE/OJ30VSTm+FZQJpbWJKlvN3KJ08RNXdQml1cCDcsHSZLHciZHvSYGwYz3N0dYABoveqgQaULA5Mocu1CVaNNsecaTA8YrYBiuUwJBHYgd2nT9kj21/FDjVtUFCJ3qO2H6UH9IWyzz+0Owe+HK2Hyh8c0mUQNdgxra3txYwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1Vd6cvlX0/NtRIdZr6EL8PpAXatHWLmFvslmWpI5Bg=;
 b=FeCS29Euzf3Bg+ic3CaDtSHW15lOXbeaNowPOxCI11TsqdQ9D9cufh0XDOBBw/5Y1BIp9iwTRwvzPwyHiViqeZGxbFlSbgHreXcELuG4pyt4LYUgDVwZ8YmkxQIEyAjxa37M1mXy1WH1fvxqGTaSUrmNUKUMw2f+9evWUzni2Tk=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 13:59:22 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::b8) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.13 via Frontend Transport; Fri,
 13 Mar 2026 13:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:21 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:21 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:21 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jb638000;
 Fri, 13 Mar 2026 08:59:19 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 05/19] ram: k3-ddrss: Add functionality to identify resume
Date: Fri, 13 Mar 2026 19:28:46 +0530
Message-ID: <20260313135900.3430264-6-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA0PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dccd5cc-f894-44b7-9daa-08de8108ba59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sUTK14CkXy7L0zKfCh/bXA2Ucyk8Dh376dRAaHbmcEV28traP049544ioMdFKyOqrVr+LgZKt/SGI9P+Yzwfss/phVBd9q20I4Ry9Ulw4YI687FuDM5cs6WoyMfe0ri460KQF51M3BwN43yP17kMTZjPbho8hmCVRBtjmgtoZY200P8yyegCUm/MO6HC9rEAIUwi2B32MZlEaj7KA3T33s6TLlsRxzaK7Da091ditOS01jvqPoRnnTsE6xIHe983sNvnBqO1nRLcVo75OTf5XvH0SHqRbHMDvq9gzgDlJgnuu0csS0Y84th8oh/9O60f/48yvuj8HRx3SkgTcdUPBKajZYxRe5fd5bX3sDS8FyC+4dTpjRZQyug4b/hbmG6i/XYlOJky14BOXpl9nfUjUzGH4gBlfrRz8lZc0+T7eu44+VWLXLsDWTBEx9o3d05Ykb0/Hd10wtOvbR64ftDXHXHsxIAFEu/cC0Xzf/o8d4isaz+5zpCS7+2de6k0x/zhMwJkBNMJiAK33PfzbhzLemjHVNjFjU3QZ7DpJcWjl8CWgXcMjD8knlK14iMEyX0Q6bYvDLf6d8/avji5cR3ogemeHb6XCHFCbpN5SsDYLJSQmlvKCaWsA0LrW0CX4rGSdBLyxxTAzyVpOM8M+98ULjfUHiegymsJXi98c+2q2oaSzDnzDNqAF7BgzKSo+TKem3GWlLH6fKzOD2l1Rncov7/RDsM+YZs9FfAKnEq3EIoMtRgAwLSqirXc7kNQ/mvdl6GLRubBlXTqntP5M0/5TA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bE6eG4aQg8T4CJuJaHW5TH/HaXy4LaZfyDbkdCxsByI0qHRdyWdQV6DPcb/07W+ANhx0VXJvgrxMkmTisT3mk8Z/aXSXR7Ax2iun/y/lEL7kR4/V1gN1q49tKck3Yur85Zc7kSIkSrvPCRJmlARBox+xGdzMBkhFgoK0ri0QEiw824DDMoDpbFGU59s1OabUE+CYNHB9e03yMgLERmtvP05y18V1A+UeT/mJU5z0BMvKG011LeJZsTfsn97kVM/b6uL7m2DYZxm7XNl9iFJpqCgl36qlbRN+ieUspMqCl16GZ/m43WnPNe1k/OpmGt1AB11OJEU1L9/NNJm+ucuTs/59nlWeEG08tgt31kTD1MHZhMlXiVzyRyAAPd3iKLDFEFZcAaFaDApv/mYOR55ff5g6z5GdDWLTwBCIXfQnJ2dC3su7hpJ7i7P/qC2CKNYR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:21.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dccd5cc-f894-44b7-9daa-08de8108ba59
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
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

While returning back from suspend, this is the way the driver
knows that it is not a normal boot but a lpm resume sequence.
In this case, it doesn't need to perform the bootup activities.
Add a weak function board_is_resuming(void), which notifies the type
of flow, whether a normal boot or lpm resume flow.
Individual devices need to override this function and implement
the mechanism to identify the lpm resume flow.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/k3-ddr.h |  2 ++
 drivers/ram/k3-ddrss/k3-ddrss.c        | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 5dd4025bdbb..76fbf254829 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -35,6 +35,8 @@ int dram_init_banksize(void);
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+int board_is_resuming(void);
+
 /* LPDDR4 power management functions */
 void k3_ddrss_lpddr4_exit_retention(struct udevice *dev, struct k3_ddrss_regs *regs);
 void k3_ddrss_lpddr4_change_freq(struct udevice *dev);
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 140bd7678bb..276bb5c8e4f 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -442,6 +442,11 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 
 #if defined(CONFIG_K3_J721E_DDRSS)
 
+int __weak board_is_resuming(void)
+{
+	return 0;
+}
+
 void k3_ddrss_lpddr4_exit_retention(struct udevice *dev,
 				    struct k3_ddrss_regs *regs)
 {
@@ -1151,7 +1156,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
-
+#if defined(CONFIG_K3_J721E_DDRSS)
+	if (board_is_resuming())
+		return 0;
+#endif
 	k3_lpddr4_start(ddrss);
 
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
-- 
2.34.1

