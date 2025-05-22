Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308FC54EDA
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B46383010;
	Thu, 22 May 2025 09:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z1lGo+cB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A920A83018; Thu, 22 May 2025 09:18:44 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618508300E
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7Idb4575805;
 Thu, 22 May 2025 02:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747898319;
 bh=CndUoF8cEYcHB8Q4giia5RY9B3LKmn0RtNiRVOSEfFY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Z1lGo+cB4XJHsO1gJGOaOiIxWE/az/uSa54BU8+GGcA+OVWB5CtNzEifDvifghGZf
 Jrd7XfVSozCpiF90a+3b7e+Q/cYRQ0dvZcSfPEQsjVzAry3PzKb+gwWx3LvT6GmqUq
 OPihsD4kp6+tkAVO5el2gjco7cvumsRTXVYrc0cw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7Id093314378
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:18:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:18:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:18:39 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54M7IT9K467991;
 Thu, 22 May 2025 02:18:36 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/6] arch: mach-k3: common: Add support to shutdown MCU R5
 Core 1
Date: Thu, 22 May 2025 12:48:24 +0530
Message-ID: <20250522071828.285462-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522071828.285462-1-b-padhi@ti.com>
References: <20250522071828.285462-1-b-padhi@ti.com>
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

During boot, ROM can bring up the MCU R5F cores in either lockstep or
split mode based on X509 certificate flags. If booted in split mode,
core 0 will run DM firmware and second core sits in WFI. Add support to
shut down core 1 so that other firmwares can later be loaded on them.

The shutdown of MCU R5 Core 1 is invoked at A72 SPL init, as by that
time Device Manager (DM) is up and running on R5 Core 0. The shutdown
request of Core 1 is handled by Device Manager itself.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/mach-k3/common.c             | 55 +++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/j721e/j721e_init.c   |  9 ++++-
 arch/arm/mach-k3/j721s2/j721s2_init.c |  7 ++++
 arch/arm/mach-k3/j784s4/j784s4_init.c |  7 ++++
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fc230f180d0..68f24948134 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -31,6 +31,10 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 
+#define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
+#define PROC_ID_MCU_R5FSS0_CORE1		0x02
+#define PROC_BOOT_CFG_FLAG_R5_LOCKSTEP		0x00000100
+
 #include <asm/arch/k3-qos.h>
 
 struct ti_sci_handle *get_ti_sci_handle(void)
@@ -328,3 +332,54 @@ void setup_qos(void)
 		writel(qos_data[i].val, (uintptr_t)qos_data[i].reg);
 }
 #endif
+
+int shutdown_mcu_r5_core1(void)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	struct ti_sci_dev_ops *dev_ops = &ti_sci->ops.dev_ops;
+	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
+	u32 dev_id_mcu_r5_core1 = put_core_ids[0];
+	u64 boot_vector;
+	u32 cfg, ctrl, sts;
+	int cluster_mode_lockstep, ret;
+
+	ret = proc_ops->proc_request(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
+	if (ret) {
+		printf("Unable to request processor control for core %d\n",
+		       PROC_ID_MCU_R5FSS0_CORE1);
+		return ret;
+	}
+
+	ret = proc_ops->get_proc_boot_status(ti_sci, PROC_ID_MCU_R5FSS0_CORE1,
+					     &boot_vector, &cfg, &ctrl, &sts);
+	if (ret) {
+		printf("Unable to get Processor boot status for core %d\n",
+		       PROC_ID_MCU_R5FSS0_CORE1);
+		goto release_proc_ctrl;
+	}
+
+	/* Shutdown MCU R5F Core 1 only if the cluster is booted in SplitMode */
+	cluster_mode_lockstep = !!(cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP);
+	if (cluster_mode_lockstep) {
+		ret = -EINVAL;
+		goto release_proc_ctrl;
+	}
+
+	ret = proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_MCU_R5FSS0_CORE1,
+					   PROC_BOOT_CTRL_FLAG_R5_CORE_HALT, 0);
+	if (ret) {
+		printf("Unable to Halt core %d\n", PROC_ID_MCU_R5FSS0_CORE1);
+		goto release_proc_ctrl;
+	}
+
+	ret = dev_ops->put_device(ti_sci, dev_id_mcu_r5_core1);
+	if (ret) {
+		printf("Unable to assert reset on core %d\n",
+		       PROC_ID_MCU_R5FSS0_CORE1);
+		return ret;
+	}
+
+release_proc_ctrl:
+	proc_ops->proc_release(ti_sci, PROC_ID_MCU_R5FSS0_CORE1);
+	return ret;
+}
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 02c74731fea..6e33f578151 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -49,6 +49,7 @@ enum k3_device_type get_device_type(void);
 struct ti_sci_handle *get_ti_sci_handle(void);
 void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
+int shutdown_mcu_r5_core1(void);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f31c20f7ed6..edca2634fb9 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -296,9 +296,9 @@ void do_dt_magic(void)
 
 void board_init_f(ulong dummy)
 {
+	int ret;
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
 	struct udevice *dev;
-	int ret;
 #endif
 	/*
 	 * Cannot delay this further as there is a chance that
@@ -371,6 +371,13 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 #endif
 
+	/* Shutdown MCU_R5 Core 1 in Split mode at A72 SPL Stage */
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		ret = shutdown_mcu_r5_core1();
+		if (ret)
+			printf("Unable to shutdown MCU R5 core 1, %d\n", ret);
+	}
+
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 5941fa26a95..6342161f830 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -230,6 +230,13 @@ void k3_spl_init(void)
 		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
 	}
 
+	/* Shutdown MCU_R5 Core 1 in Split mode at A72 SPL Stage */
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		ret = shutdown_mcu_r5_core1();
+		if (ret)
+			printf("Unable to shutdown MCU R5 core 1, %d\n", ret);
+	}
+
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 }
diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 787cf6261e4..2756accbe12 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -206,6 +206,13 @@ void k3_spl_init(void)
 
 	writel(AUDIO_REFCLK1_DEFAULT, (uintptr_t)CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL);
 
+	/* Shutdown MCU_R5 Core 1 in Split mode at A72 SPL Stage */
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		ret = shutdown_mcu_r5_core1();
+		if (ret)
+			printf("Unable to shutdown MCU R5 core 1, %d\n", ret);
+	}
+
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 }
-- 
2.34.1

