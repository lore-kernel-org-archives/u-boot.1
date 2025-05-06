Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E8C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4C182905;
	Tue,  6 May 2025 12:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GggFYoWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D751800C1; Tue,  6 May 2025 12:42:44 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DEF82999
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546AganU1031436
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 05:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746528156;
 bh=VPo2R/vIyYn+s0IP0babtFYCaQV3J2lEnuKV/vNswwM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GggFYoWc+ORKKls0TTXgVI+GtuSJJqXVrIqVFwUO31/1AWTJ3z4v08jXVrZOFgmyR
 n2wzjvBnQC2wxSBfQKmoB+Y4338QCiVhh0z1f1JoGYn9gPdBnOKyLS5fBexgqtPGPD
 81IG98cwTAA+OVbCJm2TNS1Mzdcc0KytL4O9bX1U=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgafK043875
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 05:42:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 05:42:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 05:42:35 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546Ag2uY103095;
 Tue, 6 May 2025 05:42:30 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 5/7] arm: mach-k3: Use FIT image data addr as fallback if
 'load' prop is missing
Date: Tue, 6 May 2025 16:12:00 +0530
Message-ID: <20250506104202.16741-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506104202.16741-1-b-padhi@ti.com>
References: <20250506104202.16741-1-b-padhi@ti.com>
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

It is possible for FIT Images to skip mentioning the pre-defined 'load'
address property. In those cases, SPL uses the actual address of the FIT
Image data as the fallback load address. Use this FIT data address for
referencing the image when the 'load' property is missing.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. New patch. Fetch FDT Data addr for accessing image if 'load' prop is
not present in node.

 arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 0b6604039f3..da5184e615c 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -327,12 +327,15 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
 {
 	int len;
-	int i;
+	int i, ret;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
+	const void *fit_image_loadaddr;
+	size_t fit_image_size;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", -1);
 
 	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
 	      addr, *p_size, os);
@@ -341,6 +344,22 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
 			fit_image_info[i].image_len = *p_size;
+			/*
+			 * If the 'load' property is missing in the FIT image,
+			 * fall back to using the actual in-memory address of
+			 * the FIT image data.
+			 */
+			if (load_addr == -1) {
+				ret = fit_image_get_data(fit, node,
+							 &fit_image_loadaddr,
+							 &fit_image_size);
+				if (ret < 0)
+					panic("Error accessing node os = %s in FIT (%d)\n",
+					      os, ret);
+				fit_image_info[i].load = (ulong)fit_image_loadaddr;
+			} else {
+				fit_image_info[i].load = load_addr;
+			}
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
 		}
-- 
2.34.1

