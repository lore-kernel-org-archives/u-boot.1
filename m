Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C49CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF37184A4A;
	Mon,  1 Jun 2026 14:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="YhxfTit1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E4584875; Mon,  1 Jun 2026 13:26:22 +0200 (CEST)
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com
 [207.54.77.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CD18488D
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780313179; x=1811849179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pEqtuqPzthQXLW5dJL+rIPfTwJ3Mo/PsId6RwHIoDH4=;
 b=YhxfTit1v8Ooaxoo1weOinNVtGsWpAfbN95pu4rLL0Rb28GBXr7M7svl
 CVy7eWDfOval5V//WicTh0l6kvE3ru6OxsAvmc5DWk9Mv7YpgCD7YyDiu
 xpAWKiwJyI3jdyvztaiBu+AaHt39QXmUGra+B1WqpX7cKI7jSCePRXq+q
 8gKIO/w9tINntWrUVmAL3La8Rz/KIllDfEQvMBVfW9FE+JI1v2Gm2IK12
 L303YccUTbu4W8Envh2EiwYBtyH453MWdsLObsx2/zhF+xlaJH0Lx4lqA
 mwaRgUdUhMuwNu0ChJjshogvuZlxjBpPqoqRK/zPaxbEf8dnbNFJwaUdO g==;
X-CSE-ConnectionGUID: I05QphRNTtym58ls4MUe9Q==
X-CSE-MsgGUID: CoESyXPHQWK/Lj3XWycgHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
 by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 14:26:19 +0300
X-CSE-ConnectionGUID: k5c+ArDQRV2maH033l8RdQ==
X-CSE-MsgGUID: v0uchL9GS1CZP8B/ITfJtw==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.2])
 by ces03_data.me-corp.lan with SMTP; 01 Jun 2026 14:30:53 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Mon, 01 Jun 2026 14:26:17 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 4/5] ufs: add ufs tool the configuration
Date: Mon,  1 Jun 2026 14:26:04 +0300
Message-ID: <20260601112606.2278753-4-raz.benyehuda@mobileye.com>
In-Reply-To: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

Add the ufs tool to the Kconfig and Makefile
Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/Kconfig  | 48 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/Makefile |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..35ef6bb3860 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,6 +8,54 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
+config UFS_TOOL
+	bool "ufs tool"
+	depends on UFS
+	help
+	query [lun] [idn]:
+		(0h) Device desc
+		(7h) Geometry desc
+		(8h) Power desc
+		(2h) Unit desc
+		(1h) Config desc
+
+		set_lun [LUN] [parm]
+			lu_enable, boot_lun_id, lu_write_protect memory_type
+			data_reliability num_allocunits logical_block_size
+			provisioning_type context_capabilities
+			lu_num_write_booster_buffer_allocunits
+
+		set_dev_desc [parm] [value]
+			descriptor_idn, device, device_class
+			device_sub_class, number_lu, boot_enable
+			descr_access_en, init_power_mode, high_priority_lun
+			secure_removal_type, initactive_icc_level
+			queue_depth, write_booster_buffer_preserve_user_space_en
+			write_booster_buffer_type, spec_version, manufacturer_id
+			periodic_rtc_update, device_version, psa_max_data_size
+			extended_ufs_features_support,
+			num_shared_write_booster_buffer_allocunits
+			write_booster_buffer_preserve_user_space_en
+
+		set_cfg_desc [parm] [value]
+			length, descriptor_idn, conf_desc_continue
+			boot_enable, descr_access_en, initpower_mode
+			high_priority_lun, secure_removal_type, init_active_icc_level
+			periodic_rtc_update, reserved_HPB, rpmb_region_enable
+			rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
+			write_booster_buffer_preserve_user_space_en
+			write_booster_buffer_type
+			num_shared_write_booster_buffer_allocunits
+
+		flag [flag name]
+			deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
+			purge_enable, fphy_resource_removal, busy_rtc
+			permanently_disable_fw_update, write_booster_en
+			wb_buf_flush_en, wb_buf_flush_h8
+
+		luns
+			list the current luns
+
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
 	depends on UFS && ZYNQMP_FIRMWARE
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..0e472782261 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
+obj-$(CONFIG_UFS_TOOL) += ufs_tool.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
-- 
2.43.0

