Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F394CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B4F83837;
	Mon, 27 Oct 2025 14:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pNv4+TVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA6683837; Mon, 27 Oct 2025 14:00:21 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C5A836D1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD0GHX2430665;
 Mon, 27 Oct 2025 08:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570016;
 bh=HCSJoRKdFCzIyOXu2CzA5mGaTiaFlp0mhz7nGJuGarM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pNv4+TVigQTaGq/WaccC5z9oEb/g1BEsNZcUkEmw9s9UIGoikeT9VzmXrknPXI47J
 D8J2zoKvvll3kJcqjxGYhnxarHtTFRLBcSRvKnC8mccGh3t0zDIpfGg3L0FsD08B8B
 jfq1Zc3v+FiOsfgvVozOAaNrKyAFk1GthJOQk448=
Received: from DFLE214.ent.ti.com (dfle214.ent.ti.com [10.64.6.72])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD0GD41399805
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:16 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:16 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD0FFC680441;
 Mon, 27 Oct 2025 08:00:15 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 5/8] mach-k3: r5: common: add fdt fixups for falcon mode
Date: Mon, 27 Oct 2025 18:30:00 +0530
Message-ID: <20251027130004.2156121-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
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

This patch adds fdt fixups to the kernel device-tree in R5 falcon mode,
these fixups include fixing up the core-count, reserved-memory etc.

The users can opt out by disabling the respective CONFIG_OF_*_SETUP
config options.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index aa94c0c1956..4788aaff3ea 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,12 +406,43 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_fixup(void *fdt)
+{
+	int ret;
+
+	if (!fdt)
+		return -EINVAL;
+
+	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
+		ret = ft_board_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in board fdt fixups: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
+		ret = ft_system_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in system fdt fixups: %s\n",
+			       __func__, fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int k3_r5_falcon_prep(void)
 {
 	struct spl_image_loader *loader, *drv;
 	struct spl_image_info kernel_image;
 	struct spl_boot_device bootdev;
 	int ret = -ENXIO, n_ents;
+	void *fdt;
 
 	tifalcon_loaded = true;
 	memset(&kernel_image, '\0', sizeof(kernel_image));
@@ -429,6 +460,13 @@ int k3_r5_falcon_prep(void)
 			if (ret)
 				continue;
 
+			fdt = spl_image_fdt_addr(&kernel_image);
+			ret = k3_falcon_fdt_fixup(fdt);
+			if (ret) {
+				printf("%s: Failed performing fdt fixups in falcon flow: [%d]\n",
+				       __func__, ret);
+				return ret;
+			}
 			return 0;
 		}
 	}
-- 
2.51.0

