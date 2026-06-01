Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B004ECD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6654384A4D;
	Mon,  1 Jun 2026 14:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="tQLdVuWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1111884875; Mon,  1 Jun 2026 13:26:23 +0200 (CEST)
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com
 [207.54.77.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C758488A
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
 bh=VDCynlhXfcj3ySqTadKXSwWVs5OEdQcDHVx/M8g6G1M=;
 b=tQLdVuWUbhRomCfnQTtA2zTy2k53YUHUbrXXGiqBO/xvXWv+YKxU9UTN
 mh5EwkKVmakEgoJnS4Sv9ybe1MpB3qmr0r00C+MMXwAJ7BEJlMpGfoH8C
 k81VJaxiYXi+DdsWKSCnjOyFcUWxPdatWcuC/CHJiNbrDaY/au5aYyk/j
 19Url553/CeO8sZI5K3jpMlIv2CGS7fwxYt88UYa0/wJYNWYn7tOETeTa
 RewSc1OqiHikdBOb70LtcqP5y7ETxZ1WsM4qH77/A6WPdibKgpf7ddqqP
 erup5l0kXRqpAslQr7uLfSZzNwyw0gSGawCBZ8nzOs04ZyMp5yQ3vtaEN Q==;
X-CSE-ConnectionGUID: Zmfcwt1jR/2aOYofTkyq7Q==
X-CSE-MsgGUID: XOoRpl3BRiaUbcRO/hN7Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
 by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 14:26:18 +0300
X-CSE-ConnectionGUID: qQonYwPfRXqJuiC+z1q7Xw==
X-CSE-MsgGUID: ovM1Myj4Sd+kyvmC97O3yw==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.2])
 by ces01_data.me-corp.lan with SMTP; 01 Jun 2026 14:31:01 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Mon, 01 Jun 2026 14:26:16 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 3/5] ufs: Extend the ufs user interface
Date: Mon,  1 Jun 2026 14:26:03 +0300
Message-ID: <20260601112606.2278753-3-raz.benyehuda@mobileye.com>
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

Provide a user interface and help to ufs tool.
	query [lun] [idn]:
		(0h) Device desc
        	(7h) Geometry desc
		(8h) Power desc
		(2h) Unit desc
		(1h) Config desc

        set_lun [LUN] [parm]
                lu_enable
                boot_lun_id
                lu_write_protect
                memory_type
                data_reliability
                num_allocunits
                logical_block_size
                provisioning_type
                context_capabilities
                lu_num_write_booster_buffer_allocunits

	set_dev_desc [parm] [value]
		descriptor_idn, device, device_class
		device_sub_class, number_lu, boot_enable
		descr_access_en, init_power_mode, high_priority_lun
		secure_removal_type, initactive_icc_level
		queue_depth, write_booster_buffer_preserve_user_space_en
		write_booster_buffer_type, spec_version, manufacturer_id
		periodic_rtc_update, device_version, psa_max_data_size
		extended_ufs_features_support,
		num_shared_write_booster_buffer_allocunits
		write_booster_buffer_preserve_user_space_en

	set_cfg_desc [parm] [value]
		length, descriptor_idn, conf_desc_continue
		boot_enable, descr_access_en, initpower_mode
		high_priority_lun, secure_removal_type, init_active_icc_level
		periodic_rtc_update, reserved_HPB, rpmb_region_enable
		rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
		write_booster_buffer_preserve_user_space_en
		write_booster_buffer_type
		num_shared_write_booster_buffer_allocunits

	flag [flag name]
		deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
		purge_enable, fphy_resource_removal, busy_rtc
		permanently_disable_fw_update, write_booster_en
		wb_buf_flush_en, wb_buf_flush_h8

Examples:

To create lun 4 please:
	use ufs set_lun 4 num_allocunits xxx to set size
	ufs commit
	scsi scan

To change some value in the configuration descriptor
	ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
	ufs set_cfg_desc write_booster_buffer_type 1
	ufs commit

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 cmd/ufs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/cmd/ufs.c b/cmd/ufs.c
index 790dab50f18..bb0e2fd3a67 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -8,31 +8,109 @@
 #include <command.h>
 #include <ufs.h>
 #include <vsprintf.h>
-#include <linux/string.h>
 
 static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int dev, ret;
+	int dev;
 
 	if (argc >= 2) {
 		if (!strcmp(argv[1], "init")) {
 			if (argc == 3) {
 				dev = dectoul(argv[2], NULL);
-				ret = ufs_probe_dev(dev);
-				if (ret)
+				if (!ufs_probe_dev(dev))
 					return CMD_RET_FAILURE;
 			} else {
 				ufs_probe();
 			}
-
 			return CMD_RET_SUCCESS;
 		}
-	}
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+		if (!strcmp(argv[1], "query")) {
+			int lun = -1;
+			int idn = -1;
+
+			if (argc <= 3) {
+				printf("usage: lun idn");
+				return CMD_RET_FAILURE;
+			}
+
+			lun  = dectoul(argv[2], NULL);
+			idn  = dectoul(argv[3], NULL);
+
+			return ufs_tool_query(lun, idn);
+		}
+
+		if (!strcmp(argv[1], "set_lun")) {
+			int lun;
+			u32 val;
+
+			if (argc <= 4) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			lun  = dectoul(argv[2], NULL);
+			val  = dectoul(argv[4], NULL);
+			return ufs_tool_set_lun(lun, argv[3], val);
+		}
+		if (!strcmp(argv[1], "set_dev_desc")) {
+			const char *name;
+			u32 val;
 
-	return CMD_RET_USAGE;
+			if (argc <= 3) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			name = argv[2];
+			val  = dectoul(argv[3], NULL);
+			return ufs_tool_set_device_desc(name, val);
+		}
+		if (!strcmp(argv[1], "set_cfg_desc")) {
+			const char *name;
+			u32 val;
+
+			if (argc <= 3) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			name = argv[2];
+			val  = dectoul(argv[3], NULL);
+			return ufs_tool_set_config_desc(name, val);
+		}
+
+		if (!strcmp(argv[1], "flag")) {
+			if (argc == 2) {
+				printf("usage: flag [flag name]");
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			return ufs_tool_query_flag(argv[2]);
+		}
+
+		if (!strcmp(argv[1], "commit"))
+			return ufs_tool_commit();
+
+		if (!strcmp(argv[1], "clearall"))
+			return ufs_tool_clearall();
+		if (!strcmp(argv[1], "luns")) {
+			ufs_tool_print_luns();
+			return 0;
+		}
+	}
+	ufs_tool_help();
+#endif
+	return CMD_RET_FAILURE;
 }
 
-U_BOOT_CMD(ufs, 3, 1, do_ufs,
+U_BOOT_CMD(ufs, 5, 1, do_ufs,
 	   "UFS sub-system",
 	   "init [dev] - init UFS subsystem\n"
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+	   "query [LUN] [IDN]\n"
+	   "set_lun [LUN] [parm name] [value]\n"
+	   "set_cfg_des   [parm name] [value]\n"
+	   "set_dev_desc  [parm name] [value]\n"
+	   "luns - prints luns\n"
+	   "flag [flag name] Query Flags\n"
+	   "commit - writes luns configuration\n"
+#endif
 );
-- 
2.43.0

