Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C7FC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B16833F1;
	Tue, 12 Aug 2025 14:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OOzAd3md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99466833C8; Tue, 12 Aug 2025 14:43:40 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838AD8312A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CChZ3k1826420;
 Tue, 12 Aug 2025 07:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755002615;
 bh=YNTNBjQMdhML0gTN7Vugp1uPBEcUdj1PSwvi2w1StPI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OOzAd3md0eaok76uZ7efxIWgEWAl+TkJW0JDrKoacBziotYZe0/VcUuGBPZiB4toE
 If5R8d1xTLDi5fyChkBj/F8OprIFBb4MGaRaqOJkm9u42WHuP+01Y5Vf8kBuh1a9jS
 XBO/Lzlo74JT64JCH5Cmzj7339QIdxAeNcKJz4Q0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CChZbM3814357
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 07:43:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 07:43:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 07:43:34 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CChPlB653236;
 Tue, 12 Aug 2025 07:43:32 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 2/9] ram: k3-ddrss:
 s/K3_DDRSS_MAX_ECC_REGIONS/K3_DDRSS_MAX_ECC_REG
Date: Tue, 12 Aug 2025 18:13:17 +0530
Message-ID: <20250812124324.124306-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812124324.124306-1-n-francis@ti.com>
References: <20250812124324.124306-1-n-francis@ti.com>
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

To prevent checkpatch warning once we start using this macro more
frequently, shorten the length of it. While at it, also move the
structure k3_ddrss_ecc_region above k3_msmc so that future patches can
have it as a member of k3_msmc.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 drivers/ram/k3-ddrss/k3-ddrss.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 7389fd8b82f..1c122c68784 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -121,6 +121,13 @@ enum emif_active {
 	EMIF_ALL
 };
 
+#define K3_DDRSS_MAX_ECC_REG		3
+
+struct k3_ddrss_ecc_region {
+	u64 start;
+	u64 range;
+};
+
 struct k3_msmc {
 	enum intrlv_gran gran;
 	enum intrlv_size size;
@@ -129,13 +136,6 @@ struct k3_msmc {
 	enum emif_active active;
 };
 
-#define K3_DDRSS_MAX_ECC_REGIONS		3
-
-struct k3_ddrss_ecc_region {
-	u64 start;
-	u64 range;
-};
-
 struct k3_ddrss_desc {
 	struct udevice *dev;
 	void __iomem *ddrss_ss_cfg;
@@ -155,7 +155,7 @@ struct k3_ddrss_desc {
 	lpddr4_obj *driverdt;
 	lpddr4_config config;
 	lpddr4_privatedata pd;
-	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
+	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REG];
 	u64 ecc_reserved_space;
 	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
 	u64 ddr_bank_size[CONFIG_NR_DRAM_BANKS];
-- 
2.34.1

