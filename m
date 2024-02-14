Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AF7C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7771C87E5C;
	Wed, 14 Feb 2024 17:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TAC4ZsGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6345887E30; Wed, 14 Feb 2024 17:30:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A26087E45
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUBha103509;
 Wed, 14 Feb 2024 10:30:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928211;
 bh=9qqptXywbmxk8kXH6bs8cRy5kDoK5Wibf42vpi1X6fk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TAC4ZsGJhbhkJk+UfNzHsk5s91fCbeLUWDrAPKruth6DIqxgww5aiEmKxKRR4OFO3
 YZu0oQmy1b09In/JgUjTpGRQRvmQlueoT9DuNm+Fub9mX5aCe8bgvMu8/7q4XIsexT
 ZZ5Y29gVJ5tCHtKSgsrGCjgPrA5a5qpTvA32aFf0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUBtE028183
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:11 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:11 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9rv014388;
 Wed, 14 Feb 2024 10:30:11 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/6] arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory
 node in FDT
Date: Wed, 14 Feb 2024 10:30:07 -0600
Message-ID: <20240214163009.983034-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214163009.983034-1-afd@ti.com>
References: <20240214163009.983034-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The address we load TF-A and OP-TEE to is configurable by Kconfig
CONFIG_K3_{ATF,OPTEE}_LOAD_ADDR, but the DT nodes reserving this memory
are often statically defined. As these binaries are dynamically loadable,
and in the case of OP-TEE may not even be loaded at all, hard-coding these
addresses is not a hardware description, but rather a configuration.

If the address that U-Boot loaded TF-A or OP-TEE does not match the
address in hard-coded in DT, then fix that node address. This also handles
the case when no reserved memory for these is provided by DT, which is
more correct as explained above.

Add this fixup function, and enable it for AM62.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/am625_fdt.c  |  2 ++
 arch/arm/mach-k3/common_fdt.c | 52 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common_fdt.h |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/arch/arm/mach-k3/am625_fdt.c b/arch/arm/mach-k3/am625_fdt.c
index 970dd3447de..b26186456f3 100644
--- a/arch/arm/mach-k3/am625_fdt.c
+++ b/arch/arm/mach-k3/am625_fdt.c
@@ -43,6 +43,8 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
 	fdt_fixup_gpu_nodes_am625(blob, k3_has_gpu());
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
+	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
+	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
 	return 0;
 }
diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 645c4de42f7..3bdedd7b509 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -112,3 +112,55 @@ int fdt_del_node_path(void *blob, const char *path)
 
 	return ret;
 }
+
+int fdt_fixup_reserved(void *blob, const char *name,
+		       unsigned int new_address, unsigned int new_size)
+{
+	int nodeoffset, subnode;
+	int ret;
+
+	/* Find reserved-memory */
+	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
+	if (nodeoffset < 0) {
+		debug("Could not find reserved-memory node\n");
+		return 0;
+	}
+
+	/* Find existing matching subnode and remove it */
+	fdt_for_each_subnode(subnode, blob, nodeoffset) {
+		const char *node_name;
+		fdt_addr_t addr;
+		fdt_size_t size;
+
+		/* Name matching */
+		node_name = fdt_get_name(blob, subnode, NULL);
+		if (!name)
+			return -EINVAL;
+		if (!strncmp(node_name, name, strlen(name))) {
+			/* Read out old size first */
+			addr = fdtdec_get_addr_size(blob, subnode, "reg", &size);
+			if (addr == FDT_ADDR_T_NONE)
+				return -EINVAL;
+			new_size = size;
+
+			/* Delete node */
+			ret = fdt_del_node(blob, subnode);
+			if (ret < 0)
+				return ret;
+
+			/* Only one matching node */
+			break;
+		}
+	}
+
+	struct fdt_memory carveout = {
+		.start = new_address,
+		.end = new_address + new_size - 1,
+	};
+	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
+					 FDTDEC_RESERVED_MEMORY_NO_MAP);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/common_fdt.h b/arch/arm/mach-k3/common_fdt.h
index 4d23ae638ca..52c07957483 100644
--- a/arch/arm/mach-k3/common_fdt.h
+++ b/arch/arm/mach-k3/common_fdt.h
@@ -8,5 +8,7 @@
 
 int fdt_fixup_msmc_ram_k3(void *blob);
 int fdt_del_node_path(void *blob, const char *path);
+int fdt_fixup_reserved(void *blob, const char *name,
+		       unsigned int new_address, unsigned int new_size);
 
 #endif /* _COMMON_FDT_H */
-- 
2.39.2

