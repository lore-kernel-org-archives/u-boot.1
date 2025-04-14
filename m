Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C00C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CBE826AD;
	Mon, 14 Apr 2025 22:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gopI0OK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A43328219C; Mon, 14 Apr 2025 22:20:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AA88214D
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK3PX2257197
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 15:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744662004;
 bh=VblEjpsqOHcWBFzatvamOBD2tzhassxiOLiGt5R7bSg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=gopI0OK/82FAttuTdxgHfaQtkF0P/ecWRAmOwnNSaBRTx+cDdbe3R7G9ij5EAc8jm
 ZKMYiTBOnI+0/TDmgr7MPWNRXcmaXqQm3RDEODu964Ur59e4Jp6WM/yrAbnCv1lJx7
 MOyljOwrt5fM4/fzhz1iIEBryANi1OOoZuy/QBzM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EKK3Vf026947
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 15:20:04 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 15:20:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 15:20:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EKK3Ua036855;
 Mon, 14 Apr 2025 15:20:03 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 14 Apr 2025 15:20:02 -0500
Subject: [PATCH 1/2] arm: mach-k3: support disabling a single firewall region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250414-firewalls-v1-1-89090085c08b@ti.com>
References: <20250414-firewalls-v1-0-89090085c08b@ti.com>
In-Reply-To: <20250414-firewalls-v1-0-89090085c08b@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

During boot some firewall regions could contain the R5's code which if
we change the firewalls settings will crash the core. To get around this
issue, define a new function which allows us to specify specific regions
we want unlocked.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/common.h    |  1 +
 arch/arm/mach-k3/r5/common.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 7bd72da1de812..2ec60c7879ad8 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -35,6 +35,7 @@ enum k3_device_type {
 void setup_k3_mpu_regions(void);
 int early_console_init(void);
 void disable_linefill_optimization(void);
+int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 0f6c294f1eb22..0d97e7f5537ff 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -253,6 +253,31 @@ void disable_linefill_optimization(void)
 	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
 }
 
+int remove_fwl_region(struct fwl_data *fwl)
+{
+	struct ti_sci_handle *sci = get_ti_sci_handle();
+	struct ti_sci_fwl_ops *ops = &sci->ops.fwl_ops;
+	struct ti_sci_msg_fwl_region region;
+	int ret;
+
+	region.fwl_id = fwl->fwl_id;
+	region.region = fwl->regions;
+	region.n_permission_regs = 3;
+
+	ops->get_fwl_region(sci, &region);
+
+	/* zero out the enable field of the firewall */
+	region.control = region.control & ~0xF;
+
+	pr_debug("Disabling firewall id: %d region: %d\n",
+		 region.fwl_id, region.region);
+
+	ret = ops->set_fwl_region(sci, &region);
+	if (ret)
+		pr_err("Could not disable firewall\n");
+	return ret;
+}
+
 static void remove_fwl_regions(struct fwl_data fwl_data, size_t num_regions,
 			       enum k3_firewall_region_type fwl_type)
 {

-- 
2.48.1

