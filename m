Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C20C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AF88392C;
	Wed, 28 May 2025 10:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yGXhsXh2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEF083933; Wed, 28 May 2025 10:05:30 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEFC8392C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54S85QbN2042434;
 Wed, 28 May 2025 03:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748419526;
 bh=mGpWIVX92FQKHwOJDpAplBrMLD5GJRcZSiNXAgKrTV4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yGXhsXh2K5q43b1ycs5x/tvLaLL1Qhe3o1rq9j/I1aXJUIo7zDGlzbvLvYQ63N0hc
 TZxOWzX7YEZRT2sLeQWXpF4SZua4PAMTgQvUIW4f9HhXKmiu22/4v9rXqfmqWw/Qfk
 YozTI8OtoiP+fHqWQ3N2cBObKpv/eJ4buM+l31Gc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54S85QnA3422637
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 03:05:26 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 03:05:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 03:05:25 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54S85Joe023330;
 Wed, 28 May 2025 03:05:23 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 1/6] ti_sci_*: Add utility to access tisci firmware and SOC
 capability
Date: Wed, 28 May 2025 13:35:14 +0530
Message-ID: <20250528080519.677750-2-m-shah@ti.com>
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

Introduce response and request structs for receiving information
regarding FW/SOC capability from DM. The received capability can
further be used to call API's based on the feature supported by
the DM firmware.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/firmware/ti_sci.h              | 13 +++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index bb8bc7beead..f3d9eb453b4 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -26,6 +26,7 @@
 #define TI_SCI_MSG_BOARD_CONFIG_RM	0x000c
 #define TI_SCI_MSG_BOARD_CONFIG_SECURITY  0x000d
 #define TI_SCI_MSG_BOARD_CONFIG_PM	0x000e
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 #define TISCI_MSG_QUERY_MSMC		0x0020
 
 /* Device requests */
@@ -134,6 +135,18 @@ struct ti_sci_msg_resp_version {
 	u8 abi_minor;
 } __packed;
 
+/**
+ * struct ti_sci_query_fw_caps_resp - Response for a message
+ * @hdr:	Generic header
+ * @fw_caps:	64-bit value representing the FW/SOC capabilities.
+ *
+ * Response to a message with message type TI_SCI_MSG_QUERY_FW_CAPS
+ */
+struct ti_sci_query_fw_caps_resp {
+	struct ti_sci_msg_hdr hdr;
+	u64    fw_caps;
+} __packed;
+
 /**
  * struct ti_sci_msg_req_reboot - Reboot the SoC
  * @hdr:	Generic Header
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index aa4d105ee98..05a19a8d86c 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -261,6 +261,17 @@ struct ti_sci_core_ops {
 			  u64 *msmc_start, u64 *msmc_end);
 };
 
+/**
+ * struct ti_sci_firmware_ops - DM firmware operations
+ * @query_dm_cap: Query the DM capabilities
+ */
+struct ti_sci_firmware_ops {
+	int (*query_dm_cap)(struct ti_sci_handle *handle,
+			    u64 *dm_cap);
+};
+
+#define TI_SCI_MSG_FLAG_FW_CAP_DM	0x100
+
 /**
  * struct ti_sci_proc_ops - Processor specific operations.
  *
@@ -609,6 +620,7 @@ struct ti_sci_ops {
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
 	struct ti_sci_core_ops core_ops;
+	struct ti_sci_firmware_ops fw_ops;
 	struct ti_sci_proc_ops proc_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;
-- 
2.34.1

