Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5526AC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 09:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2E887E3B;
	Thu,  8 Feb 2024 10:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="A+bD1KQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 710DF87E31; Thu,  8 Feb 2024 10:30:12 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BC587E21
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C3AEB22B5F;
 Thu,  8 Feb 2024 10:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1707384597;
 bh=S+RDFaoLzGwUhsDXddrYImxZPSq4XEWQR+T/45nh1yE=; h=From:To:Subject;
 b=A+bD1KQITCjjAoTEYDsziYTq58YyoMtoE5wVwEvBVu12FDklf9AZMnsRwgA7Lvg5u
 kYWoZ5dTotcd4srcW7edp6VBL2gkm5V5LUJnuLzn7ap++c9NLRKh/6uLtHBXyXra1G
 8fAE5enFpGkfBnRsFjMJqHFyr5R8m/O3GZCGXxRh3m6CBMg4T2CUT//8xA2NXAxpCr
 nHZw7d21k7N0QDwN1Y50yCHdbBrUuYgNTWbLc6p8z08LPMHnSEwDH4+QQiGLr1ZZ07
 sufxieP5fitunMiZxnjVS7jrrtCelOKe98OYOs/etm4EVcGWMgJ3fJPxdBUZErox0r
 xiMpt9COiU1Zw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] arm: mach-k3: am62: Fixup thermal zone critical points
Date: Thu,  8 Feb 2024 10:29:51 +0100
Message-Id: <20240208092951.11769-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208092951.11769-1-francesco@dolcini.it>
References: <20240208092951.11769-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Read the max temperature for the SoC temperature grade from the hardware
and change the critical trip nodes on each thermal zone of FDT at
runtime so they are correct with the hardware value for its grade.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/mach-k3/am625_fdt.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-k3/am625_fdt.c b/arch/arm/mach-k3/am625_fdt.c
index 970dd3447dec..3c46d1028fd0 100644
--- a/arch/arm/mach-k3/am625_fdt.c
+++ b/arch/arm/mach-k3/am625_fdt.c
@@ -38,11 +38,48 @@ static void fdt_fixup_pru_node_am625(void *blob, int has_pru)
 		fdt_del_node_path(blob, "/bus@f0000/pruss@30040000");
 }
 
+static int fdt_fixup_trips_node(void *blob, int zoneoffset, int maxc)
+{
+	int node, trip;
+
+	node = fdt_subnode_offset(blob, zoneoffset, "trips");
+	if (node < 0)
+		return -1;
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type = fdt_getprop(blob, trip, "type", NULL);
+
+		if (!type || (strncmp(type, "critical", 8) != 0))
+			continue;
+
+		if (fdt_setprop_u32(blob, trip, "temperature", 1000 * maxc) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static void fdt_fixup_thermal_zone_nodes_am625(void *blob, int maxc)
+{
+	int node, zone;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return;
+
+	fdt_for_each_subnode(zone, blob, node) {
+		if (fdt_fixup_trips_node(blob, zone, maxc) < 0)
+			printf("Failed to set temperature in %s critical trips\n",
+			       fdt_get_name(blob, zone, NULL));
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
 	fdt_fixup_gpu_nodes_am625(blob, k3_has_gpu());
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
+	fdt_fixup_thermal_zone_nodes_am625(blob, k3_get_max_temp());
 
 	return 0;
 }
-- 
2.39.2

