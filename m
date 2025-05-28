Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B7AC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9928393D;
	Wed, 28 May 2025 10:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bhVR1nP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA6E83910; Wed, 28 May 2025 10:05:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C69083939
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54S85cRT2006309;
 Wed, 28 May 2025 03:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748419538;
 bh=X6GQCuQsXtIZtYhB374udLwM1FuuoN/vkKkkNHzrRk4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bhVR1nP3Wh7XA9yr6+yRGUYWDXlcdcZ+9x9hnhpV1wI337d/Hi1d4ZqbJA9bm07Xv
 wPalsgYyPq12Zwsjw2xrnSNXSIzB7FMic5CEG0XBhI3PeCJnSHak4gJK+eIt1SKXNZ
 9YlUtfpDAfQ2cwF+VQXu255LPPGpIwQfcxEiCP1Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54S85cGg3282599
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 03:05:38 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 03:05:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 03:05:37 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54S85Joi023330;
 Wed, 28 May 2025 03:05:35 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 5/6] arm: mach-k3: Add a function for printing DM version
Date: Wed, 28 May 2025 13:35:18 +0530
Message-ID: <20250528080519.677750-6-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528080519.677750-1-m-shah@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
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

Add a function to print version of the DM firmware in use.
The function queries the firmware capabilities first and if
DM split mode bit is set, sends a request to TISCI for
retrieving the version information.

The DM split mode bit indicates that DM is a separate binary
altogether and hence it will have its own versioning.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 arch/arm/mach-k3/common.c | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fa8cd93d664..524bb1da1a0 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -68,6 +68,35 @@ void k3_sysfw_print_ver(void)
 	       ti_sci->version.firmware_revision, fw_desc);
 }
 
+void __maybe_unused k3_dm_print_ver(void)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	struct ti_sci_firmware_ops *fw_ops = &ti_sci->ops.fw_ops;
+	struct ti_sci_dm_version_info dm_info = {0};
+	u64 fw_caps;
+	int ret;
+
+	ret = fw_ops->query_dm_cap(ti_sci, &fw_caps);
+	if (ret) {
+		printf("Failed to query DM firmware capability %d\n", ret);
+		return;
+	}
+
+	if (!(fw_caps & TI_SCI_MSG_FLAG_FW_CAP_DM))
+		return;
+
+	ret = fw_ops->get_dm_version(ti_sci, &dm_info);
+	if (ret) {
+		printf("Failed to fetch DM firmware version %d\n", ret);
+		return;
+	}
+
+	printf("DM ABI: %d.%d (firmware ver 0x%04x '%s--%s' "
+	       "patch_ver: %d)\n", dm_info.abi_major, dm_info.abi_minor,
+	       dm_info.dm_ver, dm_info.sci_server_version,
+	       dm_info.rm_pm_hal_version, dm_info.patch_ver);
+}
+
 void mmr_unlock(uintptr_t base, u32 partition)
 {
 	/* Translate the base address */
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 7bd72da1de8..487291697d9 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
+void k3_dm_print_ver(void);
 void spl_enable_cache(void);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
-- 
2.34.1

