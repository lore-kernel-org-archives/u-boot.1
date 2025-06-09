Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65594C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D67182C87;
	Mon,  9 Jun 2025 10:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ep+gUZbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D8D82C13; Mon,  9 Jun 2025 10:14:52 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90098007D
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598Elm91947717;
 Mon, 9 Jun 2025 03:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456887;
 bh=zAcxTi8z/6xm3IkTHToEZgNcNBLC9NNAeXw/SIxpwYk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ep+gUZboCwMajjSsH1duzTpNICDpibkxjB1ZcMQw06dUi0yLHezxqIkg8UfaVGz16
 I35QDvuOFTiSO/SptsNxODHDkaVdL0YUF6jmuEOC7IZ44w9fhPwaOsXAkRFVm/RIma
 af12G0AoIrYkFpRmDTDGk85Pgn2XYb4AnCqlkOl8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598El4o4125689
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:47 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqq1101163;
 Mon, 9 Jun 2025 03:14:44 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 3/6] firmware: ti_sci.c: Add a function to query DM
 firmware's capability
Date: Mon, 9 Jun 2025 13:44:31 +0530
Message-ID: <20250609081434.1000377-4-m-shah@ti.com>
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

Add a new function to query the capabilities of the DM firmware, using
TI SCI protocol to retrieve a 64-bit firmware capability, where each bit
represents a specific capability supported by the firmware.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 344df9454b3..2c91b2b71f5 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -278,6 +278,48 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_query_dm_cap() - Command to query DM firmware's capabilities
+ * @handle:	Pointer to TI SCI handle
+ * @fw_caps:	Pointer to firmware capabilities
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_query_dm_cap(struct ti_sci_handle *handle, u64 *fw_caps)
+{
+	struct ti_sci_query_fw_caps_resp *cap_info;
+	struct ti_sci_msg_hdr hdr;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&hdr, sizeof(struct ti_sci_msg_hdr),
+				     sizeof(*cap_info));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret)
+		return ret;
+
+	cap_info = (struct ti_sci_query_fw_caps_resp *)xfer->tx_message.buf;
+
+	*fw_caps = cap_info->fw_caps;
+
+	return 0;
+}
+
 /**
  * ti_sci_cmd_get_revision() - command to get the revision of the SCI entity
  * @handle:	pointer to TI SCI handle
@@ -2624,6 +2666,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
+	struct ti_sci_firmware_ops *fw_ops = &ops->fw_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_proc_ops *pops = &ops->proc_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -2694,6 +2737,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	fwl_ops->set_fwl_region = ti_sci_cmd_set_fwl_region;
 	fwl_ops->get_fwl_region = ti_sci_cmd_get_fwl_region;
 	fwl_ops->change_fwl_owner = ti_sci_cmd_change_fwl_owner;
+
+	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
 }
 
 /**
-- 
2.34.1

