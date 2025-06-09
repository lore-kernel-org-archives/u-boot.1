Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67359C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B20682C4D;
	Mon,  9 Jun 2025 10:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="srwoZ475";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7912E82C03; Mon,  9 Jun 2025 10:14:49 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB1282B18
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598EicQ717043;
 Mon, 9 Jun 2025 03:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456884;
 bh=902l53Ulq7r+P1NJD7GACAAppEeD79qV6Z5Ye0ewHiE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=srwoZ47555baEVLdPINALGsdN04Vgz9JWczfa72t7rLiGma3Yi5QMaytFVN8I1zMd
 PSHkIJScQX1i4XBOl+I5Lw0m12D+n7ja/SFMMD/oUQ0pn5Bn+zBJs9mkt3orOOLrqI
 A4uvzXi7vjtloLsZo6l8+Fa3Q5B2df/rbn28gQcU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598EitV3662878
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:44 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqp1101163;
 Mon, 9 Jun 2025 03:14:41 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 2/6] ti_sci_* : Add capability to access DM firmware's
 metadata
Date: Mon, 9 Jun 2025 13:44:30 +0530
Message-ID: <20250609081434.1000377-3-m-shah@ti.com>
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

Introduce response and request structs to receive and request
information regarding DM version, etc from TI SCI.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.h              | 29 ++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 26 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 292f7cd578a..ce50bf6800e 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -26,6 +26,7 @@
 #define TI_SCI_MSG_BOARD_CONFIG_RM	0x000c
 #define TI_SCI_MSG_BOARD_CONFIG_SECURITY  0x000d
 #define TI_SCI_MSG_BOARD_CONFIG_PM	0x000e
+#define TI_SCI_MSG_DM_VERSION		0x000f
 #define TISCI_MSG_QUERY_MSMC		0x0020
 #define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
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
+ * @sci_server_version: String describing the SCI server version
+ * @rm_pm_hal_version:  String describing the RM PM HAL version
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
index f967077b756..52696763ecf 100644
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
+ * @sci_server_version: Version string of the SCI server.
+ * @rm_pm_hal_version:  Version string of the RM PM HAL.
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
@@ -265,10 +287,14 @@ struct ti_sci_core_ops {
  * struct ti_sci_firmware_ops - DM firmware operations
  * @query_dm_cap: Query the DM capabilities
  *                Return 0 for successful query else appropriate error value.
+ * @get_dm_version: Get the DM version.
+ *                  Return 0 for successful request else appropriate error value.
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

