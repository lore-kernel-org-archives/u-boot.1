Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD1C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1983683935;
	Wed, 28 May 2025 10:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a0Q4eBO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A583F83923; Wed, 28 May 2025 10:05:33 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7518683910
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54S85THf2042446;
 Wed, 28 May 2025 03:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748419529;
 bh=3FwwPmOwItUbClM4rESYZomZfdEMnmJ0pEqQlJdixKU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=a0Q4eBO11Cvs1PQhap/Vz4LrORIeSTfV4EGLhDeY2RL9wTKLE2ttZUFEwsNpW+pGk
 L8s1Dty+K0LAalnAnqNwNqqzP2lLAI3guSbVO2i6lvrasQkFV6SFpB4ulAKX/x0II2
 9b9cNky+3cCfg0WeSBX9WvzDVKua2mw3CvVQV2p8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54S85Tvn3464816
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 03:05:29 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 03:05:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 03:05:28 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54S85Jof023330;
 Wed, 28 May 2025 03:05:26 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 2/6] ti_sci_* : Add capability to access DM firmware's metadata
Date: Wed, 28 May 2025 13:35:15 +0530
Message-ID: <20250528080519.677750-3-m-shah@ti.com>
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

Introduce response and request structs to receive and request
information regarding DM version, etc from TI SCI.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/firmware/ti_sci.h              | 29 ++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 26 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index f3d9eb453b4..6ef77d83114 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_ENABLE_WDT		0x0000
 #define TI_SCI_MSG_WAKE_RESET		0x0001
 #define TI_SCI_MSG_VERSION		0x0002
+#define TI_SCI_MSG_DM_VERSION		0x000F
 #define TI_SCI_MSG_WAKE_REASON		0x0003
 #define TI_SCI_MSG_GOODBYE		0x0004
 #define TI_SCI_MSG_SYS_RESET		0x0005
@@ -135,6 +136,34 @@ struct ti_sci_msg_resp_version {
 	u8 abi_minor;
 } __packed;
 
+/**
+ * struct ti_sci_msg_dm_resp_version - Response for a message
+ * @hdr:		Generic header
+ * @version:		Version number of the firmware
+ * @sub_version:	Sub-version number of the firmware
+ * @patch_version:	Patch version number of the firmware
+ * @abi_major:		Major version of the ABI that firmware supports
+ * @abi_minor:		Minor version of the ABI that firmware supports
+ * @sci_server_version:	String describing the SCI server version
+ * @rm_pm_hal_version:	String describing the RM PM HAL version
+ *
+ * In general, ABI version changes follow the rule that minor version increments
+ * are backward compatible. Major revision changes in ABI may not be
+ * backward compatible.
+ *
+ * Response to a message with message type TI_SCI_MSG_DM_VERSION
+ */
+struct ti_sci_msg_dm_resp_version {
+	struct ti_sci_msg_hdr hdr;
+	u16	version;
+	u8	sub_version;
+	u8	patch_version;
+	u8	abi_major;
+	u8	abi_minor;
+	char rm_pm_hal_version[12];
+	char sci_server_version[26];
+} __packed;
+
 /**
  * struct ti_sci_query_fw_caps_resp - Response for a message
  * @hdr:	Generic header
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 05a19a8d86c..3f13a980433 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -30,6 +30,28 @@ struct ti_sci_version_info {
 	char firmware_description[32];
 };
 
+/**
+ * struct ti_sci_dm_version_info - version information structure
+ * @abi_major:		Major ABI version. Change here implies risk of backward
+ *			compatibility break.
+ * @abi_minor:		Minor ABI version. Change here implies new feature addition,
+ *			or compatible change in ABI.
+ * @patch_ver:		Patch version of the firmware.
+ * @sub_ver:		Sub-version of the firmware.
+ * @dm_ver:		DM version.
+ * @sci_server_version:	Version string of the SCI server.
+ * @rm_pm_hal_version:	Version string of the RM PM HAL.
+ */
+struct ti_sci_dm_version_info {
+	u8 abi_major;
+	u8 abi_minor;
+	u8 patch_ver;
+	u8 sub_ver;
+	u16 dm_ver;
+	char rm_pm_hal_version[12];
+	char sci_server_version[26];
+};
+
 struct ti_sci_handle;
 
 /**
@@ -264,10 +286,14 @@ struct ti_sci_core_ops {
 /**
  * struct ti_sci_firmware_ops - DM firmware operations
  * @query_dm_cap: Query the DM capabilities
+ * @get_dm_version: Get the DM version.
+ *		    Return 0 for successful query else appropriate error value.
  */
 struct ti_sci_firmware_ops {
 	int (*query_dm_cap)(struct ti_sci_handle *handle,
 			    u64 *dm_cap);
+	int (*get_dm_version)(struct ti_sci_handle *handle,
+			      struct ti_sci_dm_version_info *get_dm_version);
 };
 
 #define TI_SCI_MSG_FLAG_FW_CAP_DM	0x100
-- 
2.34.1

