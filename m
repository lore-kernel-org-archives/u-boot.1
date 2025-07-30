Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFEBC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 13:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A5282F14;
	Wed, 30 Jul 2025 15:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pg1kkUtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF9780C93; Wed, 30 Jul 2025 15:37:47 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A6780548
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 15:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UDbhTq2774081;
 Wed, 30 Jul 2025 08:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753882663;
 bh=07ulomI8nofGMqM2hB1MkoqQNaIYPjpUJMipYwOXhQ4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Pg1kkUtl6aXL5t0rJdQrKCqVzoYZ8RIiXBkCOp/lROKEVVMxTM215q8NM++zjsKaK
 3baNTYnJTU/rai6xsQba5UX6xkbfYR3sMeh6ds0LR9Me8/j7Fqzdo596aeO8yF0bwp
 Nxe92lju8g8xU/B2mZcZ/6SJMN+cN6DPLAF/hDFY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UDbhcK3233002
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 08:37:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 08:37:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 08:37:43 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UDbKNL1315795;
 Wed, 30 Jul 2025 08:37:40 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 6/9] ram: k3-ddrss: Add support for number of controllers
 under MSMC
Date: Wed, 30 Jul 2025 19:07:17 +0530
Message-ID: <20250730133720.3315478-7-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730133720.3315478-1-n-francis@ti.com>
References: <20250730133720.3315478-1-n-francis@ti.com>
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

In K3 multi-DDR systems, the MSMC is responsible for the interleave
mechanism across all the DDR controllers. Add support for MSMC to obtain
the number of controllers it's responsible for using the DT.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index cd117d7eba7..2d2558eaa9e 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -127,6 +127,7 @@ struct k3_msmc {
 	enum ecc_enable enable;
 	enum emif_config config;
 	enum emif_active active;
+	u32 num_ddr;
 };
 
 #define K3_DDRSS_MAX_ECC_REG		3
@@ -1007,6 +1008,13 @@ static int k3_msmc_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	ret = device_get_child_count(dev);
+	if (ret <= 0) {
+		dev_err(dev, "no child ddr nodes present");
+		return -EINVAL;
+	}
+	msmc->num_ddr = ret;
+
 	return 0;
 }
 
-- 
2.34.1

