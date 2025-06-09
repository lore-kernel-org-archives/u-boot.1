Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B64C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FFA82BD9;
	Mon,  9 Jun 2025 10:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jzbf0K/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5B582CA0; Mon,  9 Jun 2025 10:14:58 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E4482C13
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598ErhQ1947729;
 Mon, 9 Jun 2025 03:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456893;
 bh=yvtDHqfhaQ/wNWUGw34OB4ufNw725Z6ciOuRi241c08=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jzbf0K/WXH1QuEo+SkMvdZrT0LS5GkNhnLz68sZIP6eg09g1A5/D6K6hX2QJxT20Y
 l827XPAgzNV3ozDbuzqBjShLlXwb3NdY1/sW4CEv7tTyYWF3IHWlILx/4snmCWuhCT
 EQfSJxRBiQVEebCjP71VsbCtKQZ9KxvBQlP/FhhU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598Ere63552506
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:53 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:53 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqs1101163;
 Mon, 9 Jun 2025 03:14:50 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 5/6] arm: mach-k3: Add a function for printing DM version
Date: Mon, 9 Jun 2025 13:44:33 +0530
Message-ID: <20250609081434.1000377-6-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609081434.1000377-1-m-shah@ti.com>
References: <20250609081434.1000377-1-m-shah@ti.com>
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
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/common.c | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fc230f180d0..1b09488b884 100644
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
index 02c74731fea..e19ae18dbb1 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -42,6 +42,7 @@ int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
+void k3_dm_print_ver(void);
 void spl_enable_cache(void);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
-- 
2.34.1

