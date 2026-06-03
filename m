Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE24CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61EFA84915;
	Wed,  3 Jun 2026 17:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="aKUxqjc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20369846F1; Wed,  3 Jun 2026 14:46:07 +0200 (CEST)
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com
 [207.54.77.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F14A84874
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780490765; x=1812026765;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPIWN8nIyiTrAsU0aAI5jOGmV1aOgj/47jBpAHlbMVg=;
 b=aKUxqjc7pjHIY5zUGk523AFco4xl8Vq1uiSRsIwU8tG3ki2cmKIFxape
 DALJX/kE0SWZeqSpaDoBPDoi4cjeBds25i+BVkijGg7YnRtC+NVtqnJst
 gJE0QFihh1lfkOz4PYXiwQCU1vqp8UYok1AnWfH3sBlbCXdeLamnQvH3w
 DLZkyOA+z3RNQj53kN0/hJWveRznpsq6FYXFqF6V0gGX9Ps9Bk3Bs5514
 al4a9oi9cGTIted3soT9wNIvn9CBj/JEZKUkmkHJ4tmFo52T9LxXUcw2e
 z8NUoX85m/6KL1IZtiWG4Eow95S3WmrRhx2ejY3tsrVTqWViexRArjnfO A==;
X-CSE-ConnectionGUID: lLCCoOuhQ/qRpQ1kRT8RLw==
X-CSE-MsgGUID: re1XxA5hRzqSphs0q+uUEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
 by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 15:46:04 +0300
X-CSE-ConnectionGUID: pTcVYcrbTgm1HR4iaVAPOA==
X-CSE-MsgGUID: Uw6Xfh/gTi21X/969cKGuQ==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.3])
 by ces01_data.me-corp.lan with SMTP; 03 Jun 2026 15:50:50 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Wed, 03 Jun 2026 15:46:03 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 5/5] ufs: doc/README.ufs
Date: Wed,  3 Jun 2026 15:45:39 +0300
Message-ID: <20260603124553.3763516-5-raz.benyehuda@mobileye.com>
In-Reply-To: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:19 +0200
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

Documention of the ufs tool.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 doc/README.ufs | 217 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 doc/README.ufs

diff --git a/doc/README.ufs b/doc/README.ufs
new file mode 100644
index 00000000000..bd9f5cd2856
--- /dev/null
+++ b/doc/README.ufs
@@ -0,0 +1,217 @@
+			ufs_tool
+		**********************
+ The UFS tool provides utilities for querying, displaying, and modifying
+UFS device configuration and descriptor information.
+
+Features:
+- Query and display Device, Geometry, Unit, Configuration, and Power
+  Descriptors
+- Display LUN configuration and calculated capacities
+- Modify LUN, Configuration, and Device Descriptor fields
+- Configure WriteBooster-related parameters
+- Query common UFS runtime flags
+- Commit configuration changes or clear all LUN configurations
+- Decode and format descriptor contents for easier debugging
+- Clear
+- Provisioning
+
+The UFS tool header definitions are based on the JEDEC Standard JESD220E:
+Universal Flash Storage (UFS) Version 3.1.
+
+--------------------------------
+Usage
+--------------------------------
+
+Query descriptors:
+--------------------------------
+
+    ufs query [lun] [idn]
+
+Descriptor IDs:
+--------------------------------
+
+    0x00  Device Descriptor
+    0x01  Configuration Descriptor
+    0x02  Unit Descriptor
+    0x07  Geometry Descriptor
+    0x08  Power Descriptor
+
+Configure a Logical Unit (LUN):
+--------------------------------
+
+    ufs set_lun <lun> <parameter> <value>
+
+Supported parameters:
+--------------------------------
+
+    lu_enable
+    boot_lun_id
+    lu_write_protect
+    memory_type
+    data_reliability
+    num_allocunits
+    logical_block_size
+    provisioning_type
+    context_capabilities
+    lu_num_write_booster_buffer_allocunits
+
+Modify Device Descriptor fields:
+--------------------------------
+
+    ufs set_dev_desc <parameter> <value>
+
+Supported parameters:
+----------------------
+
+    descriptor_idn
+    device
+    device_class
+    device_sub_class
+    number_lu
+    boot_enable
+    descr_access_en
+    init_power_mode
+    high_priority_lun
+    secure_removal_type
+    initactive_icc_level
+    queue_depth
+    write_booster_buffer_preserve_user_space_en
+    write_booster_buffer_type
+    spec_version
+    manufacturer_id
+    periodic_rtc_update
+    device_version
+    psa_max_data_size
+    extended_ufs_features_support
+    num_shared_write_booster_buffer_allocunits
+
+Modify Configuration Descriptor fields:
+----------------------------------------
+
+    ufs set_cfg_desc <parameter> <value>
+
+Supported parameters:
+---------------------
+    length
+    descriptor_idn
+    conf_desc_continue
+    boot_enable
+    descr_access_en
+    initpower_mode
+    high_priority_lun
+    secure_removal_type
+    init_active_icc_level
+    periodic_rtc_update
+    reserved_HPB
+    rpmb_region_enable
+    rpmb_region1_size
+    rpmb_region2_size
+    rpmb_region3_size
+    write_booster_buffer_preserve_user_space_en
+    write_booster_buffer_type
+    num_shared_write_booster_buffer_allocunits
+
+Query UFS flags:
+----------------------------
+    ufs getflag <flag_name>
+
+Supported flags:
+-----------------------------
+    deviceinit
+    permanent_wpe
+    pwr_on_wpe
+    bkops_en
+    life_span_mode
+    purge_enable
+    fphy_resource_removal
+    busy_rtc
+    permanently_disable_fw_update
+    write_booster_en
+    wb_buf_flush_en
+    wb_buf_flush_h8
+
+Examples
+------------------------------
+
+Create LUN 4:
+    ufs query 1 1
+    ufs set_lun 4 num_allocunits <size_in_alloc_units>
+    ufs commit
+    scsi scan
+
+Update WriteBooster configuration:
+
+    ufs query 1 1
+    ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
+    ufs set_cfg_desc write_booster_buffer_type 1
+    ufs commit
+
+Clear all LUN configurations:
+-------------------------------
+
+    ufs clearall
+
+This command clears luns, and commits.
+
+Provisioning
+------------
+
+To simplify UFS provisioning, the tool displays the memory address and
+size of the Configuration Descriptor (IDN 0x01). This allows the
+descriptor to be exported from one system and imported on another.
+
+Provisioning workflow:
+
+Source system
+-------------
+
+1. Display the Configuration Descriptor:
+
+       ufs query 1 1
+
+   The output includes the Configuration Descriptor address and size.
+
+   Example:
+
+       Config Descriptor: (0x00000008ffffc610)
+       Length                          : 0x0e6
+       DescriptorIdn                   : 0x01
+       ConfDescContinue                : 0x00
+       BootEnable                      : 0x01
+       ...
+
+2. Save the Configuration Descriptor to a file:
+
+       tftpput <cfg_desc_addr> <size> <filename>
+
+   Example:
+
+       tftpput 0x8ffffc610 0xe6 luns.bin
+
+   This exports the current UFS configuration, including LUN settings.
+
+Target system
+-------------
+
+1. Load the currect Configuration descriptor.
+    ufs query 1 1
+       Config Descriptor: (0x00000008ffffce00)
+       Length                          : 0x0e6
+       DescriptorIdn                   : 0x01
+       ConfDescContinue                : 0x00
+       BootEnable                      : 0x01
+
+
+2. Load the configuration file onto Configuration Descriptor using XMODEM or TFTP.
+   Examples:
+
+       loadx 0x8ffffce00
+   or
+       tftpget 0x8ffffce00 luns.bin
+
+3. Commit the configuration to the UFS device:
+
+       ufs commit
+
+   The imported Configuration Descriptor is written to the device and
+   becomes active after the commit operation completes.
-- 
2.43.0

