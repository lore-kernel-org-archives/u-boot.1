Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645BAE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B101980607;
	Mon,  6 Jan 2025 10:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nTiwGHKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC1D805FF; Mon,  6 Jan 2025 10:07:53 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EF480601
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 50697mcY094877;
 Mon, 6 Jan 2025 03:07:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736154468;
 bh=JQjliIDkyVMto9B7VlGVp1lJ63S2J4IXM67Tt+tGrFE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nTiwGHKSedywqgUBvs372O8Rn0OcLhrIcqOtAJQhnygeGI0d8ibBrhwSj1cLfsHpy
 6SlpvQbHL72ChDVfJrLIOZ1IUkGWVghUsIiuAxH+yb7R3QzsjJecOUC20tynzNbQXf
 NXjrQEJtptejJASWaw1JIlW2o84XrAy4WePk3tCI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50697mlq105701;
 Mon, 6 Jan 2025 03:07:48 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:07:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:07:48 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50697Juc103050;
 Mon, 6 Jan 2025 03:07:45 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v6 7/9] ram: k3-ddrss: Remove 'ti,ecc-enable' support
Date: Mon, 6 Jan 2025 14:37:06 +0530
Message-ID: <20250106090708.1541212-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106090708.1541212-1-s-k6@ti.com>
References: <20250106090708.1541212-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The functionality of enabling Inline ECC is now controlled by
CONFIG_K3_INLINE_ECC. So, remove the support for 'ti,ecc-enable'
property to avoid redundancy and to ensure the Inline ECC feature is
mananged through build-time config.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index e4f9891bee20..05ea61bbfe9a 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -151,7 +151,6 @@ struct k3_ddrss_desc {
 	lpddr4_privatedata pd;
 	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
 	u64 ecc_reserved_space;
-	bool ti_ecc_enabled;
 	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
 	u64 ddr_bank_size[CONFIG_NR_DRAM_BANKS];
 	u64 ddr_ram_size;
@@ -408,8 +407,6 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "ddr fhs cnt not populated %d\n", ret);
 
-	ddrss->ti_ecc_enabled = dev_read_bool(dev, "ti,ecc-enable");
-
 	return ret;
 }
 
@@ -792,7 +789,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 	k3_ddrss_ddr_bank_base_size_calc(ddrss);
 
-	if (ddrss->ti_ecc_enabled) {
+	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
 			       __func__);
-- 
2.34.1

