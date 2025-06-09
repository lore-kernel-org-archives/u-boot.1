Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D87C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D71482C44;
	Mon,  9 Jun 2025 10:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NJklMAqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CA382C44; Mon,  9 Jun 2025 10:14:56 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C9182C7F
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598EooY717055;
 Mon, 9 Jun 2025 03:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749456891;
 bh=eALDm3sGCjgsovCFVla2W+9AgT6IjZYhpLXEP7K7YwA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=NJklMAqMk7OGV1/FiZPn/ZFEWHQj6Y2q56CyYPPki8+snIOirVVn6t9M1j+q9yAUt
 00+e38ze3YGVKmeU6GCJ91rYjsif+uqEh2L+UMb4spMm81O+BFq72660QGRYdzEaaW
 xf/0MCjcjqXaYMAHGFKbGhLNPn09quFCp3wZwnzQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598EoDs1239959
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:14:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:14:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:14:50 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598EYqr1101163;
 Mon, 9 Jun 2025 03:14:47 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH v2 4/6] firmware: ti_sci.c: Add a function to request DM
 metadata using ti_sci* calls
Date: Mon, 9 Jun 2025 13:44:32 +0530
Message-ID: <20250609081434.1000377-5-m-shah@ti.com>
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

Add a function to retrieve information of the DM firmware's ABI versions,
RM/PM HAL, firmware version, etc using TI_SCI protocol.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2c91b2b71f5..8013afef304 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -320,6 +320,59 @@ static int ti_sci_cmd_query_dm_cap(struct ti_sci_handle *handle, u64 *fw_caps)
 	return 0;
 }
 
+/**
+ * ti_sci_cmd_get_dm_version() - command to get the DM version of the SCI
+ *				 entity
+ * @handle:	Pointer to TI SCI handle
+ * @dm_info:	Pointer to DM version information structure
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+
+static int ti_sci_cmd_get_dm_version(struct ti_sci_handle *handle,
+				     struct ti_sci_dm_version_info *dm_info)
+{
+	struct ti_sci_msg_dm_resp_version *ver_info;
+	struct ti_sci_msg_hdr hdr;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle || !dm_info)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_DM_VERSION,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&hdr, sizeof(struct ti_sci_msg_hdr),
+				     sizeof(*ver_info));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret)
+		return ret;
+
+	ver_info = (struct ti_sci_msg_dm_resp_version *)xfer->tx_message.buf;
+
+	dm_info->abi_major = ver_info->abi_major;
+	dm_info->abi_minor = ver_info->abi_minor;
+	dm_info->dm_ver = ver_info->version;
+	dm_info->patch_ver = ver_info->patch_version;
+	dm_info->sub_ver = ver_info->sub_version;
+	strlcpy(dm_info->sci_server_version, ver_info->sci_server_version,
+		sizeof(ver_info->sci_server_version));
+	strlcpy(dm_info->rm_pm_hal_version, ver_info->rm_pm_hal_version,
+		sizeof(ver_info->rm_pm_hal_version));
+
+	return 0;
+}
+
 /**
  * ti_sci_cmd_get_revision() - command to get the revision of the SCI entity
  * @handle:	pointer to TI SCI handle
@@ -2738,6 +2791,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	fwl_ops->get_fwl_region = ti_sci_cmd_get_fwl_region;
 	fwl_ops->change_fwl_owner = ti_sci_cmd_change_fwl_owner;
 
+	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
 }
 
-- 
2.34.1

