Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FEC105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320F84359;
	Fri, 13 Mar 2026 14:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gPKzT+pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223BA84332; Fri, 13 Mar 2026 14:59:41 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251B184307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xB3fNW+nuaDoOG9j+ZhirpjFJjtixt2wKdI6hU9udT8XFeWVVQksF9kZVynVOL8SvA4Vbre6wh66b88Cf8+vziI7exp1W+xSc18Zi8FI4M+PpU6boFIbodHGY4chcnXLPI9FzFaCDU2ygxm5LtcU22jnoXreafebthJTo8okoPI9baE3G+0TL2znHgK6svIXvmspJKlONN6yA7OkawgPehOL7JSe7mH3Is2PhIXxR+Trf82W6VMrRPDCpN7yBVfi6winVw14UY0OfRopme8V/QDXSWOQzSDPOcKeykVrh6uCQJhaxlGnvpMg1SRM+NiJRJOTFay47eE7ed2VUaXDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5UMkRAYzdZzyiknDkEYAqyf5+4Zl2WZezDynQ7KRCg=;
 b=VH9QKPYKZVnizstWI9gNiAWy69DgJhy7yK0pTyoCmAzqAIv+B5ICnEeitsmspo02YFBeS/M9aRO0cO4ieRe0nBmXR/8srwdCjmeeeklTS2POi0jUaC0G0Zdtfp4o+vGdNlX4RoYVC3PVGziYpNF8X2keY0+UxxzaqujDUBeqnKjheWTdaYPEHf8qVLCilrxmV3Lmhr6bByBcYmCNAHvA1E9kkojGAI4Qyy4vL9kGdu9Vf2Kj9P/nfwHwlf0ATVy5vcADpjlnI8p9zqrS4FkTib1Q11TPr2oDID52dscQQGB0RHTSJdl3FPX517ceqvH1w+zKfKsLpGs/ENj6MJF6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5UMkRAYzdZzyiknDkEYAqyf5+4Zl2WZezDynQ7KRCg=;
 b=gPKzT+picxGHVeiSMKSqfwudaOAo1jaxwaUdq7Y2lPhKmR6RS1NjuiyIWu41QAMo5jGr1YVopGHoR3IWUg+ZwBUwCiDeHuM0T2xL001qUlMUjUuOFjqQ3K+42OvOTIhUtQrTzhvx7DVpWG6yySS/sj7d5GxzjeCyJ0xPzNJJhVo=
Received: from CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:34 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::60) by CH2PR20CA0002.outlook.office365.com
 (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.31 via Frontend Transport; Fri,
 13 Mar 2026 13:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:33 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:32 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:32 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jg638000;
 Fri, 13 Mar 2026 08:59:30 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 10/19] firmware: ti_sci: add low power mode operations
Date: Fri, 13 Mar 2026 19:28:51 +0530
Message-ID: <20260313135900.3430264-11-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbc78a2-3bea-4ca9-3daa-08de8108c188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CFJYN+he6hVPhpf/YEipbeUvJ6DPNau4rxGTYhz/8kJcAyJCayiXRN+oMENYuocQVsckRa6cpK6nofv8+k7KLHxfZuN+BEXa/zpG0VXfWeF1KMbEeYFwRmRAvnSHAVba9tNNCpb+N6Jh8JPn6c5v1rDY/R0INtr+rL2LKxf5PsQuYosG8CqcHdHdy86mEQW/RLUjSO+srHU+VH76GVaNybIUAEy9+6oTG6cDk8u2AavuSMLzeUD79CkQ7t7IacjspKs4BJCN/+1djrVQVQzuCphZfHRmgO+yhTjxthT8Mv/GaLEOoZVRik8TaezvndgxA48nwiYdz1s1YHIdvUknaI6yrfys3Cb+p6Ee6yJaCTz7aHlvXTZ6JS0lFeEGeVorXNq+n2/tFxwKTgGty1NkgGmsAmnoFiTXiBEi1XSMwNf6OlGfaw0MTjRCp+RHtJusFdmqA2Spi8p+xaxi/NgRTzoY6MEPvGHH6E37nHgPtlweKqHfwSj3FW1ZnsfW97/gBC9IcNjDsDSd9I9MeiFBlUk4juuZYK/FevVeZyD5TYx4JsSnNbgaAPLx0BET/InB5uswzBfaj9Z8yqZ8xvEKMYRVW23BDaoKhfaVIQJ0Dt2soDjT+u6g9+aLflD9inAgEbyYxNmqk9LT5K0Jr0Gh87kCxpKkZIqRjxYHGijUyJWx31qt/Y+KoRc6CbpcVnXbSDEHVDQAcSnT2/HOHHZgIqDl0tr4Xw3QxmL2ZTOlvie+lXz7OsfqC67LWBR7D/GXDFiQsDwR+iWMhQNBXL+8Ww==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X514XHUaAJMs+Nk1EPapHCYaJNSFJYGzwFtE9rrCsu2q/8fX5wAIAK7/hvhKSeOD94oOmL0LH4qWs6LfOd04Wc9bEPDwgwYVawdGAVEtKNE+TVRQ8GV7DiU4bYGZ94eNvODuNjJ29REPgD0cWSO2u2DOducvpy7DH1paqjiJH6TM2hdrmpjb0SGhQRy31oAlfQavFFSHHIxi7h3lqiw0A83iwlqXiem5z6CtUUOU9fm92RS3EvcxH2RYws6yTVPxLBcR+fe/btMVCKFMQKyhY74L4o/KPh6m5V7Zfvq1vL96NLzMOc5KQsX2M8JtQrquUlLCbMvrr7lYadOl20IDJZdFOCsBX685uDEzdL+/3RNewT6tp3j+mdvtSyhOxltQI1jR3ZpDXV60R6z1FacDGX67GSqWjF2rOcTK1wZ2eKI97ympSy1xLA4e91ss/yQe
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:33.8919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbc78a2-3bea-4ca9-3daa-08de8108c188
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
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

From: Richard Genoud <richard.genoud@bootlin.com>

On TI-k3 platform, at resume, uboot SPL needs to do several tasks:
- Restore context from DDR
- send ddr save address to TIFS
- load TFA in msmc
- set TFA resume vector to its warm_entrypoint
- replay firewalls of the certificate

All those operation are now done by tifs with those messages:
ti_sci_cmd_restore_context
ti_sci_cmd_decrypt_tfa
ti_sci_cmd_core_resume
ti_sci_cmd_lpm_save_addr

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/security.h |   2 +
 arch/arm/mach-k3/security.c              |  64 +++++++
 drivers/firmware/ti_sci.c                | 218 +++++++++++++++++++++++
 drivers/firmware/ti_sci.h                | 103 +++++++++++
 include/linux/soc/ti/ti_sci_protocol.h   |  17 ++
 5 files changed, 404 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/security.h b/arch/arm/mach-k3/include/mach/security.h
index 8502b57bd80..f233cf63b57 100644
--- a/arch/arm/mach-k3/include/mach/security.h
+++ b/arch/arm/mach-k3/include/mach/security.h
@@ -9,3 +9,5 @@
 #include <linux/types.h>
 
 void ti_secure_image_post_process(void **p_image, size_t *p_size);
+
+void ti_secure_image_replay_cert(void **p_image, size_t *p_size);
\ No newline at end of file
diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index c7017bba99a..6df93206e25 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -133,3 +133,67 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
 	      spl_boot_device() == BOOT_DEVICE_UART))
 		printf("Authentication passed\n");
 }
+
+void ti_secure_image_replay_cert(void **p_image, size_t *p_size)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
+	u64 image_addr;
+	u32 image_size, backup_size;
+	int ret;
+
+	image_size = *p_size;
+	backup_size = image_size;
+	if (!image_size) {
+		debug("%s: Image size is %d\n", __func__, image_size);
+		return;
+	}
+
+	if (get_device_type() == K3_DEVICE_TYPE_GP)
+		return;
+
+	if (get_device_type() != K3_DEVICE_TYPE_HS_SE &&
+	    !ti_secure_cert_detected(*p_image)) {
+		printf("Warning: Did not detect image signing certificate. "
+		       "Skipping authentication to prevent boot failure. "
+		       "This will fail on Security Enforcing(HS-SE) devices\n");
+		return;
+	}
+
+	/* Clean out image so it can be seen by system firmware */
+	image_addr = dma_map_single(*p_image, *p_size, DMA_BIDIRECTIONAL);
+
+	debug("Authenticating image at address 0x%016llx\n", image_addr);
+	debug("Authenticating image of size %d bytes\n", image_size);
+
+	/* Authenticate image */
+	ret = proc_ops->proc_replay_cert(ti_sci, &image_addr, &image_size);
+	if (ret) {
+		printf("Authentication failed..but assume pass!\n");
+		hang();
+	}
+
+	/* Invalidate any stale lines over data written by system firmware */
+	if (backup_size)
+		dma_unmap_single(image_addr, backup_size, DMA_BIDIRECTIONAL);
+
+	/*
+	 * The image_size returned may be 0 when the authentication process has
+	 * moved the image. When this happens no further processing on the
+	 * image is needed or often even possible as it may have also been
+	 * placed behind a firewall when moved.
+	 */
+	*p_size = backup_size;
+
+	/*
+	 * Output notification of successful authentication to re-assure the
+	 * user that the secure code is being processed as expected. However
+	 * suppress any such log output in case of building for SPL and booting
+	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
+	 * protocol transactions.
+	 */
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
+	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
+	      spl_boot_device() == BOOT_DEVICE_UART))
+		printf("Certificate replay passed\n");
+}
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0f5e180e9e9..fb17798c6b3 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2014,6 +2014,63 @@ static int ti_sci_cmd_set_proc_boot_ctrl(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_proc_replay_cert() - Command to authenticate and replay the
+ *			image certificate
+ * @handle:	Pointer to TI SCI handle
+ * @image_addr:	Memory address at which payload image and certificate is
+ *		located in memory, this is updated if the image data is
+ *		moved during authentication.
+ * @image_size: This is updated with the final size of the image after
+ *		authentication.
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_proc_replay_cert(const struct ti_sci_handle *handle,
+					   u64 *image_addr, u32 *image_size)
+{
+	struct ti_sci_msg_req_proc_auth_boot_image req;
+	struct ti_sci_msg_resp_proc_auth_boot_image *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_PROC_REPLAY_CERT,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		printf("%s Error making the tisci command\n", __func__);
+		return ret;
+	}
+	req.cert_addr_low = *image_addr & TISCI_ADDR_LOW_MASK;
+	req.cert_addr_high = (*image_addr & TISCI_ADDR_HIGH_MASK) >>
+				TISCI_ADDR_HIGH_SHIFT;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		printf("%s Error sending the tisci command\n", __func__);
+		return ret;
+	}
+
+	resp = (struct ti_sci_msg_resp_proc_auth_boot_image *)xfer->tx_message.buf;
+
+	*image_addr = (resp->image_addr_low & TISCI_ADDR_LOW_MASK) |
+			(((u64)resp->image_addr_high <<
+			  TISCI_ADDR_HIGH_SHIFT) & TISCI_ADDR_HIGH_MASK);
+	*image_size = resp->image_size;
+
+	return ret;
+}
+
+
 /**
  * ti_sci_cmd_proc_auth_boot_image() - Command to authenticate and load the
  *			image and then set the processor configuration flags.
@@ -2710,6 +2767,160 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+static int ti_sci_cmd_restore_context(const struct ti_sci_handle *handle, u64 ctx_addr)
+{
+	struct ti_sci_msg_min_restore_context_req req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_MIN_CONTEXT_RESTORE,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.ctx_lo = (u32)(ctx_addr & 0xffffffff);
+	req.ctx_hi = (u32)(ctx_addr >> 32);
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(info->dev, "Failed restoring context %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_decrypt_tfa() - Request for decrypting TFA to specific address.
+ * @handle:    pointer to TI SCI handle
+ * @unencrypted_address: Address where the unencrypted TFA will be restored to.
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_decrypt_tfa(const struct ti_sci_handle *handle,
+				  uint64_t unencrypted_address)
+{
+	struct ti_sci_msg_decrypt_tfa_req req;
+	struct ti_sci_msg_decrypt_tfa_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_DECRYPT,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.unencrypted_address = unencrypted_address;
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_core_resume() - Request for resuming TFA.
+ *
+ * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
+ * message.
+ *
+ * @handle:    pointer to TI SCI handle
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_core_resume(const struct ti_sci_handle *handle)
+{
+	struct ti_sci_msg_core_resume_req req;
+	struct ti_sci_msg_core_resume_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_CORE_RESUME,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_lpm_save_addr() - Message to inform TIFS about the context save address.
+ *
+ * By restoring its context, TIFS will restore its firewall.
+ *
+ * @handle:    pointer to TI SCI handle
+ * @ctx_addr:  address where the context will be store to and restored from
+ * @size:	   Size of the context save region
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_lpm_save_addr(const struct ti_sci_handle *handle,
+				    u64 context_addr, uint32_t size)
+{
+	struct tisci_msg_lpm_save_ctx_addr_req req;
+	struct tisci_msg_lpm_save_ctx_addr_resp *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_SAVE_ADDR,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.ctx_addr = context_addr;
+	req.size = size;
+
+	ret = ti_sci_do_xfer(info, xfer);
+
+	return ret;
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -2728,6 +2939,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2777,6 +2989,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	pops->set_proc_boot_cfg = ti_sci_cmd_set_proc_boot_cfg;
 	pops->set_proc_boot_ctrl = ti_sci_cmd_set_proc_boot_ctrl;
 	pops->proc_auth_boot_image = ti_sci_cmd_proc_auth_boot_image;
+	pops->proc_replay_cert = ti_sci_cmd_proc_replay_cert;
 	pops->get_proc_boot_status = ti_sci_cmd_get_proc_boot_status;
 	pops->proc_shutdown_no_wait = ti_sci_cmd_proc_shutdown_no_wait;
 
@@ -2795,6 +3008,11 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 
 	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
+
+	lpm_ops->restore_context = ti_sci_cmd_restore_context;
+	lpm_ops->decrypt_tfa = ti_sci_cmd_decrypt_tfa;
+	lpm_ops->core_resume = ti_sci_cmd_core_resume;
+	lpm_ops->lpm_save_addr = ti_sci_cmd_lpm_save_addr;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ce50bf6800e..c21f2fd6730 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -54,6 +54,7 @@
 #define TISCI_MSG_PROC_AUTH_BOOT_IMAGE	0xc120
 #define TISCI_MSG_GET_PROC_BOOT_STATUS	0xc400
 #define TISCI_MSG_WAIT_PROC_BOOT_STATUS	0xc401
+#define TISCI_MSG_PROC_REPLAY_CERT	0xc402
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
@@ -82,6 +83,24 @@
 #define TISCI_MSG_FWL_GET		0x9001
 #define TISCI_MSG_FWL_CHANGE_OWNER	0x9002
 
+/* LPM requests */
+#define TISCI_MSG_SYNC_RESUME			(0x0302U)
+#define TISCI_MSG_CONTINUE_RESUME		(0x0303U)
+#define TISCI_MSG_CORE_RESUME			(0x0304U)
+#define TISCI_MSG_ABORT_ENTER_SLEEP		(0x0305U)
+#define TISCI_MSG_LPM_WAKE_REASON		(0x0306U)
+#define TISCI_MSG_SET_IO_ISOLATION		(0x0307U)
+#define TISCI_MSG_MIN_CONTEXT_RESTORE	(0x0308)
+#define TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT	(0x0309U)
+#define TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT	(0x030AU)
+#define TISCI_MSG_LPM_GET_DEVICE_CONSTRAINT	(0x030BU)
+#define TISCI_MSG_LPM_GET_LATENCY_CONSTRAINT	(0x030CU)
+#define TISCI_MSG_LPM_GET_NEXT_SYS_MODE		(0x030DU)
+#define TISCI_MSG_LPM_GET_NEXT_HOST_STATE	(0x030EU)
+#define TISCI_MSG_LPM_ENCRYPT			(0x030FU)
+#define TISCI_MSG_LPM_DECRYPT			(0x0310U)
+#define TISCI_MSG_LPM_SAVE_ADDR			(0x0313U)
+
 /**
  * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
  * @type:	Type of messages: One of TI_SCI_MSG* values
@@ -1572,4 +1591,88 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
 	u16			owner_permission_bits;
 } __packed;
 
+/**
+ * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
+ *
+ * @hdr:		Generic Header
+ */
+struct ti_sci_msg_min_restore_context_req {
+	struct ti_sci_msg_hdr	hdr;
+	u32			ctx_lo;
+	u32			ctx_hi;
+} __packed;
+
+/*
+ * struct ti_sci_msg_core_resume_req - Request for TISCI_MSG_CORE_RESUME.
+ *
+ * @hdr:			Generic Header
+ *
+ * This message is to be sent to start the TFA on the main core.
+ * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
+ * message.
+ */
+struct ti_sci_msg_core_resume_req {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct ti_sci_msg_core_resume_resp - Response for TISCI_MSG_CORE_RESUME.
+ *
+ * @hdr:			Generic Header
+ */
+struct ti_sci_msg_core_resume_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct ti_sci_msg_decrypt_tfa_req - Request for TISCI_MSG_LPM_DECRYPT.
+ *
+ * @hdr:			Generic Header
+ * @unencrypted_address:	Address where the TFA should be decrypted
+ * @encrypted_address:		Address where the TFA lies encrypted
+ *
+ * This message is to be sent when the system is resuming from suspend, in order
+ * to restore the TFA.
+ * The TIFS will decrypt the TFA at specified location and restore it in SRAM.
+ */
+struct ti_sci_msg_decrypt_tfa_req {
+	struct ti_sci_msg_hdr	hdr;
+	u64			unencrypted_address;
+} __packed;
+
+/**
+ * struct ti_sci_msg_decrypt_tfa_resp - Response for TISCI_MSG_LPM_DECRYPT.
+ *
+ * @hdr:			Generic Header
+ */
+struct ti_sci_msg_decrypt_tfa_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
+/**
+ * struct tisci_msg_lpm_save_ctx_addr_req - Request for TISCI_MSG_LPM_SAVE_ADDR.
+ *
+ * @hdr:			Generic Header
+ * @ctx_addr:	Address where the LPM data is to be saved
+ * @size:		Size of the context save memory region
+ *
+ * This message is sent to TIFS to inform it about the addresse where it
+ * will save the context to in case of system suspend and where to get the
+ * context back from when resuming the system
+ */
+struct tisci_msg_lpm_save_ctx_addr_req {
+	struct ti_sci_msg_hdr	hdr;
+	u64			ctx_addr;
+	u32			size;
+} __packed;
+
+/**
+ * struct tisci_msg_lpm_save_ctx_addr_resp - Response for TISCI_MSG_SAVE_ADDR.
+ *
+ * @hdr:			Generic Header
+ */
+struct tisci_msg_lpm_save_ctx_addr_resp {
+	struct ti_sci_msg_hdr	hdr;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 52696763ecf..b2c9573293b 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -336,6 +336,8 @@ struct ti_sci_proc_ops {
 				    u32 *sts_flags);
 	int (*proc_shutdown_no_wait)(const struct ti_sci_handle *handle,
 				     u8 pid);
+	int (*proc_replay_cert)(const struct ti_sci_handle *handle,
+				    u64 *image_addr, u32 *image_size);
 };
 
 #define TI_SCI_RING_MODE_RING			(0)
@@ -632,6 +634,20 @@ struct ti_sci_fwl_ops {
 	int (*change_fwl_owner)(const struct ti_sci_handle *handle, struct ti_sci_msg_fwl_owner *owner);
 };
 
+/**
+ * struct ti_sci_lpm_ops - Low Power Mode operations
+ * @restore_context: Request restoring context from DDR.
+ * @decrypt_tfa: Request for decrypting TFA at specific address.
+ * @core_resume: Request for resuming TFA once decrypted.
+ * @lpm_save_addr: Send DDR Save address to TIFS
+ */
+struct ti_sci_lpm_ops {
+	int (*restore_context)(const struct ti_sci_handle *handle, u64 ctx_addr);
+	int (*decrypt_tfa)(const struct ti_sci_handle *handle,	uint64_t unencrypted_address);
+	int (*core_resume)(const struct ti_sci_handle *handle);
+	int (*lpm_save_addr)(const struct ti_sci_handle *handle, uint64_t context_addr, uint32_t size);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @board_ops:	Miscellaneous operations
@@ -654,6 +670,7 @@ struct ti_sci_ops {
 	struct ti_sci_rm_psil_ops rm_psil_ops;
 	struct ti_sci_rm_udmap_ops rm_udmap_ops;
 	struct ti_sci_fwl_ops fwl_ops;
+	struct ti_sci_lpm_ops lpm_ops;
 };
 
 /**
-- 
2.34.1

