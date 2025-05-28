Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA40C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EBF83942;
	Wed, 28 May 2025 10:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RqFsiPKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E5A83910; Wed, 28 May 2025 10:05:36 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABBB83935
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54S85WxE3198616;
 Wed, 28 May 2025 03:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748419532;
 bh=EKB+jHL4kuRyi9N6QsvL1VQ2876mJqpyPuX55HURlw0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RqFsiPKnqMKukcudqwNEZKwQGueyDIT6Nh4ljV7HD2YrHQw/wJbBv1hkn/2Iumnjb
 sx3wOESb8oy8VR2RzCYoqRw05IY6PdIdCp/LywZEIREpX2t2UqTymtP9oH8xt82Ua1
 UYAUaDJtwyVIrIcb/n79iedV0UDw0slN7zrba7k4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54S85WC13422676
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 03:05:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 03:05:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 03:05:31 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54S85Jog023330;
 Wed, 28 May 2025 03:05:29 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 3/6] firmware: ti_sci.c: Add a function to query DM firmware's
 capability
Date: Wed, 28 May 2025 13:35:16 +0530
Message-ID: <20250528080519.677750-4-m-shah@ti.com>
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

Add a new function to query the capabilities of the DM firmware, using
TI SCI protocol to retrieve a 64-bit firmware capability, where each bit
represents a specific capability supported by the firmware.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/firmware/ti_sci.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 54d6689ce78..bb9738efa81 100644
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

