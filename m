Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A83C41513
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC15A884D7;
	Fri, 17 May 2024 14:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ar0pj4Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F1C8848D; Fri, 17 May 2024 07:28:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF3C883C7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923692; x=1747459692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nZvrDaNa5Wyhl1t/d2aFiu+UzkmELGqt+6f9IcOgMVk=;
 b=ar0pj4VwF7VwaAJ/QR1oZPalpJ6qtqS71X/RVI2aE/7Sn26C/neXlMr6
 bei2bVzuTJjvZf9DNE7t7DKsj4JUahOgQUUSRzvNeH0m/+3bx57nWK/vC
 2qBh3EWsWyat7uQrOppvsRnVYRe+mAGzOnyygV5F/7s/GC2WnCXV2pU6I
 CqpUHUbgzDy8l0flGo6P95rGaLAqVVpDfPmwpkmhdPBULStuBJ25hfnJf
 165IRO4VDVZDFwccLdLqSD+hFWHF8B+u5dIGgIq99yAWQVywt7aDXmL19
 ySy8yAhJq85CyxmzOB0tmbHlZydM3X5SgdZkPbvD5TxX337enM5/IYNq/ Q==;
X-CSE-ConnectionGUID: CQADuYb2STq0tOgS6/RIzA==
X-CSE-MsgGUID: MaPHWlhgQx6wSAefMg5Wbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11930002"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11930002"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:09 -0700
X-CSE-ConnectionGUID: Yyy/mMB+Q8WObKO5Weukyw==
X-CSE-MsgGUID: 0Y8PZ29PSD66ed6wVVmCEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188282"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:04 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 09/16] ddr: altera: Add
 uibssm mailbox for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:54 +0800
Message-Id: <20240517052701.12949-10-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Teik Heng Chong <teik.heng.chong@intel.com>

Add uibssm mailbox driver for Agilex7 M-series. HPS will interact with UIB
and HBM subsystem through software defined mailbox interface.
HPS can retrieve memory interface calibration status, UIB configuration,
memory interfae configuration, trigger calibration and etc with the list of
supported mailbox command type and opcode.

Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 drivers/ddr/altera/uibssm_mailbox.c | 311 ++++++++++++++++++++++++++++
 drivers/ddr/altera/uibssm_mailbox.h | 117 +++++++++++
 2 files changed, 428 insertions(+)
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.h

diff --git a/drivers/ddr/altera/uibssm_mailbox.c b/drivers/ddr/altera/uibssm_mailbox.c
new file mode 100644
index 0000000000..a6e2a5f44b
--- /dev/null
+++ b/drivers/ddr/altera/uibssm_mailbox.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+#include <hang.h>
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/io.h>
+#include "uibssm_mailbox.h"
+
+#define MAX_RETRIES 3
+
+int uib_bist_mem_init_start(struct uib_info *uib_ctrl)
+{
+	struct uib_mb_resp usr_resp;
+	bool bist_start = false;
+	bool bist_success = false;
+	u32 start;
+
+	/*
+	 * Full memory initialization BIST performed on all UIB channels
+	 * start memory initialization BIST on full memory address
+	 */
+	uib_mb_req(uib_ctrl->uib[0].uib_csr_addr,
+		   UIB_CMD_TRIG_CONTROLLER_OP,
+		   UIB_BIST_MEM_INIT_START,
+		   UIB_BIST_FULL_MEM, &usr_resp);
+
+	bist_start = UIBSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) &
+			UIB_BIST_INITIATE_PASS;
+	if (!bist_start) {
+		printf("%s: Failed to initialized memory on UIB\n", __func__);
+
+		return -EINVAL;
+	}
+
+	/* Polling for the initiated memory initialization BIST status */
+	start = get_timer(0);
+	while (!bist_success) {
+		/*
+		 * cmd_param_0 is not used in BIST status request,
+		 * hence set the value to 0
+		 */
+		uib_mb_req(uib_ctrl->uib[0].uib_csr_addr,
+			   UIB_CMD_TRIG_CONTROLLER_OP,
+			   UIB_BIST_MEM_INIT_STATUS,
+			   0, &usr_resp);
+
+		bist_success = UIBSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) & BIT(0);
+		if (!bist_success && (get_timer(start) > TIMEOUT)) {
+			printf("%s: Timeout initialize memory on UIB\n", __func__);
+
+			return -ETIMEDOUT;
+		}
+
+		udelay(1);
+	}
+
+	debug("%s: Memory initialized successfully on UIB\n", __func__);
+
+	return 0;
+}
+
+int uib_cal_status(phys_addr_t addr)
+{
+	int ret = 0;
+	phys_addr_t status_addr = addr + UIB_R_INITSTS_OFFSET;
+
+	/* Ensure calibration completed */
+	ret = wait_for_bit_le32((const void *)status_addr, UIB_R_INITSTS_INITSTS_PASS, true,
+				TIMEOUT, false);
+	if (ret)
+		printf("%s: HBM calibration UIB instance 0x%llx timeout\n", __func__, status_addr);
+
+	return ret;
+}
+
+void uib_init_mem_cal(struct uib_info *uib_ctrl)
+{
+	int i, ret;
+
+	if (!uib_ctrl->num_instance) {
+		uib_ctrl->overall_cal_status = false;
+	} else {
+		uib_ctrl->overall_cal_status = true;
+
+		/* Check initial calibration status for the assigned UIB */
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			ret = uib_cal_status(uib_ctrl->uib[i].uib_csr_addr);
+			if (ret) {
+				uib_ctrl->uib[i].cal_status = false;
+				uib_ctrl->overall_cal_status = false;
+
+				printf("%s: Initial HBM calibration UIB_%d failed\n", __func__, i);
+				break;
+			}
+
+			uib_ctrl->uib[i].cal_status = true;
+
+			debug("%s: Initial HBM calibration UIB_%d succeed\n", __func__, i);
+		}
+	}
+}
+
+/* Trying 3 times re-calibration if initial calibration failed */
+void uib_trig_mem_cal(struct uib_info *uib_ctrl)
+{
+	int i, j, cal_stat;
+
+	if (!uib_ctrl->num_instance) {
+		uib_ctrl->overall_cal_status = false;
+	} else {
+		uib_ctrl->overall_cal_status = true;
+
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			uib_ctrl->uib[i].cal_status = false;
+
+			/* Initiate Re-calibration */
+			for (j = 0; j < MAX_RETRIES; j++) {
+				clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+						UIB_R_INITCTL_OFFSET,
+						UIB_R_INITCTL_INITTYPE_MASK |
+						UIB_R_INITCTL_INITREQ_MASK,
+						UIB_R_INITCTL_INITTYPE(UIB_RST_REQUEST_WITH_CAL) |
+						UIB_R_INITCTL_INITREQ(1));
+
+				cal_stat = uib_cal_status(uib_ctrl->uib[i].uib_csr_addr);
+				if (cal_stat)
+					continue;
+
+				debug("%s: HBM re-calibration UIB_%d succeed\n", __func__, i);
+
+				uib_ctrl->uib[i].cal_status = true;
+				break;
+			}
+
+			if (!uib_ctrl->uib[i].cal_status) {
+				uib_ctrl->overall_cal_status = false;
+
+				printf("%s: HBM re-calibration UIB_%d failed\n", __func__, i);
+				break;
+			}
+		}
+	}
+}
+
+static void uib_mailbox_write_request(u32 data, u32 target_write_addr, phys_addr_t csr_addr)
+{
+	int ret;
+
+	/*
+	 * Read from chms0020 MBWRADDR_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #1 Read MBWRADDR_VALID from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRADDR_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <target write address> to chms0024 MBWRADDR */
+	debug("%s: #2 Write 0x%x to UIB_R_MBWRADDR\n", __func__, target_write_addr);
+	writel(target_write_addr, csr_addr + UIB_R_MBWRADDR);
+
+	/*
+	 * Write 1 to chms0020 MBWRADDR_VALID to indicate the address is now valid
+	 * for FW to read
+	 */
+	debug("%s: #3 Write 1 to MBWRADDR_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRADDR_VALID);
+
+	/*
+	 * Read from chms0020 MBWRDATA_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #4 Read MBWRDATA_VALID from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRDATA_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/*
+	 * Read from chms0020 MBWRDATA_END and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #5 Read R_MBWRCTL_MBWRDATA_END from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRDATA_END, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRDATA_END is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <write data> to chms0028 MMR_MBWRDATA */
+	debug("%s: #6 Write 0x%x to UIB_R_MBWRDATA\n", __func__, data);
+	writel(data, csr_addr + UIB_R_MBWRDATA);
+
+	/*
+	 * Write 1 to chms0020 MBWRDATA_END to indicate if the <write data> is the last burst
+	 * for FW to read for the <target write address>
+	 */
+	debug("%s: #7 Write 1 to MBWRDATA_END to inform FW this is last burst of data to read\n",
+	      __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRDATA_END);
+
+	/* Write 1 to chms0020 MBWRDATA_VALID to indicate the data is now valid for FW to read */
+	debug("%s: #8 Write 1 to MBWRDATA_VALID for FW to read data\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRDATA_VALID);
+}
+
+static u32 uib_mailbox_read_request(u32 target_read_addr, phys_addr_t csr_addr)
+{
+	int ret;
+	u32 reg, rd_data = 0;
+
+	/*
+	 * Read from chms0030 MBRDADDR_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #1 Read MBRDADDR_VALID from UIB_R_MBRDCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBRDCTL,
+				UIB_R_MBRDCTL_MBRDADDR_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBRDADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <target read address> to chms0034 MBRDADDR */
+	debug("%s: #2 Write 0x%x to UIB_R_MBRDADDR\n", __func__, target_read_addr);
+	writel(target_read_addr, csr_addr + UIB_R_MBRDADDR);
+
+	/*
+	 * Write 1 to chms0030 MBRDADDR_VALID to indicate the address is now valid
+	 * for FW to read
+	 */
+	debug("%s: #3 Write 1 to MBRDADDR_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBRDCTL, UIB_R_MBRDCTL_MBRDADDR_VALID);
+
+	/*
+	 * Continuously poll the chms0030 MBRDDATA_VALID. If MBRDDATA_VALID are set, read
+	 * chms0038 MBRDDATA and chms0030 MBRDDATA_END to retrieve the <read data> and
+	 * <end of read burst> status accordingly
+	 */
+	debug("%s: #4 Read MBRDDATA_VALID from UIB_R_MBRDCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBRDCTL,
+				UIB_R_MBRDCTL_MBRDDATA_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBRDDATA_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	reg = readl(csr_addr + UIB_R_MBRRDATA);
+	debug("%s: #5 Read data from UIB_R_MBRRDATA = 0x%x\n", __func__, reg);
+	rd_data = reg;
+
+	reg = readl(csr_addr + UIB_R_MBRDCTL);
+	debug("%s: #6 Read end of read burst status from UIB_R_MBRDCTL = 0x%x\n", __func__, reg);
+
+	/*
+	 * Once done retrieving the data, write 1 to chms0030 MBRDDATA_VALID,
+	 * chms0030 MBRDDATA_END to clear the register
+	 */
+	debug("%s: #7 Write 1 to MBRDDATA_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBRDCTL, UIB_R_MBRDCTL_MBRDDATA_VALID |
+			UIB_R_MBWRCTL_MBWRDATA_END);
+
+	return rd_data;
+}
+
+int uib_mb_req(phys_addr_t uib_csr_addr, u32 usr_cmd_type, u32 usr_cmd_opcode,
+	       u32 cmd_param_0, struct uib_mb_resp *resp)
+{
+	u32 cmd_req;
+
+	/* Initialized zeros for responses */
+	resp->cmd_resp_status = 0;
+
+	/* Write CMD_REQ (CMD_TYPE and CMD_OPCODE) */
+	cmd_req = FIELD_PREP(CMD_TYPE_MASK, usr_cmd_type) |
+		FIELD_PREP(CMD_OPCODE_MASK, usr_cmd_opcode);
+	uib_mailbox_write_request(cmd_req, 0, uib_csr_addr);
+
+	debug("%s: Write 0x%x to UIBSSM_CMD_REQ_OFFSET 0x%llx\n", __func__, cmd_req, uib_csr_addr);
+
+	/* Write CMD_PARAM_* */
+	if (cmd_param_0)
+		uib_mailbox_write_request(cmd_param_0, 0, uib_csr_addr);
+	else
+		debug("%s: cmd_param_0 is NULL\n", __func__);
+
+	/* read CMD_RESPONSE_STATUS */
+	resp->cmd_resp_status = uib_mailbox_read_request(0, uib_csr_addr);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__,
+	      uib_csr_addr, resp->cmd_resp_status);
+	debug("%s: STATUS_CMD_RESPONSE_ERROR: 0x%lx\n", __func__,
+	      UIBSSM_CMD_RESPONSE_ERROR(resp->cmd_resp_status));
+	debug("%s: STATUS_GENERAL_ERROR: 0x%lx\n", __func__,
+	      UIBSSM_GENERAL_ERROR(resp->cmd_resp_status));
+
+	return 0;
+}
diff --git a/drivers/ddr/altera/uibssm_mailbox.h b/drivers/ddr/altera/uibssm_mailbox.h
new file mode 100644
index 0000000000..5d0dc0f475
--- /dev/null
+++ b/drivers/ddr/altera/uibssm_mailbox.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+#include <linux/bitfield.h>
+
+#define TIMEOUT_120000MS	120000
+#define TIMEOUT			TIMEOUT_120000MS
+
+#define UIBSSM_CMD_RESPONSE_DATA_SHORT_MASK	GENMASK(31, 16)
+#define UIBSSM_CMD_RESPONSE_DATA_SHORT(x)	FIELD_GET(UIBSSM_CMD_RESPONSE_DATA_SHORT_MASK, x)
+#define UIBSSM_CMD_RESPONSE_ERROR_MASK		GENMASK(7, 5)
+#define UIBSSM_CMD_RESPONSE_ERROR(x)		FIELD_GET(UIBSSM_CMD_RESPONSE_ERROR_MASK, x)
+#define UIBSSM_GENERAL_ERROR_MASK		GENMASK(4, 1)
+#define UIBSSM_GENERAL_ERROR(x)			FIELD_GET(UIBSSM_GENERAL_ERROR_MASK, x)
+
+/* UIB Responder Initialization Control Register */
+#define UIB_R_INITCTL_OFFSET			0x10
+#define UIB_R_INITCTL_INITREQ_MASK		BIT(0)
+#define UIB_R_INITCTL_INITTYPE_MASK		GENMASK(11, 8)
+#define UIB_R_INITCTL_INITREQ(x)		FIELD_PREP(UIB_R_INITCTL_INITREQ_MASK, x)
+#define UIB_R_INITCTL_INITTYPE(x)		FIELD_PREP(UIB_R_INITCTL_INITTYPE_MASK, x)
+#define UIB_RST_REQUEST_WITH_CAL		5
+
+/* UIB Initialization control and status registers */
+#define UIB_R_INITSTS_OFFSET		0x14
+#define UIB_R_INITSTS_INITSTS_PASS	BIT(1)
+#define MAX_UIB_SUPPORTED		8
+
+#define UIB_R_MBWRCTL			0x20
+#define UIB_R_MBWRADDR			0x24
+#define UIB_R_MBWRDATA			0x28
+#define UIB_R_MBWRCTL_MBWRADDR_VALID	BIT(0)
+#define UIB_R_MBWRCTL_MBWRDATA_VALID	BIT(4)
+#define UIB_R_MBWRCTL_MBWRDATA_END	BIT(7)
+
+#define UIB_R_MBRDCTL			0x30
+#define UIB_R_MBRDADDR			0x34
+#define UIB_R_MBRRDATA			0x38
+#define UIB_R_MBRDCTL_MBRDADDR_VALID	BIT(0)
+#define UIB_R_MBRDCTL_MBRDDATA_VALID	BIT(4)
+#define UIB_R_MBRDCTL_MBRDDATA_END	BIT(7)
+
+/* Responder Error Mask Register */
+#define UIB_R_ERRMSK_PSEUDO_CH0_OFFSET	0x520
+#define UIB_R_ERRMSK_PSEUDO_CH1_OFFSET	0X820
+#define UIB_DRAM_SBE_MSK		BIT(25)
+#define UIB_INTERNAL_CORR_ERR_MSK	BIT(30)
+#define UIB_DRAM_SBE(x)			FIELD_PREP(UIB_DRAM_SBE_MSK, x)
+#define UIB_INTERNAL_CORR_ERR(x)	FIELD_PREP(UIB_INTERNAL_CORR_ERR_MSK, x)
+
+/* CMD_REQ Register Definition */
+#define CMD_TYPE_MASK			GENMASK(23, 16)
+#define CMD_OPCODE_MASK			GENMASK(15, 0)
+
+/* supported mailbox command type */
+enum uibssm_mailbox_cmd_type  {
+	UIB_CMD_TRIG_CONTROLLER_OP = 0x04
+};
+
+/* supported mailbox command opcode */
+enum uibssm_mailbox_cmd_opcode  {
+	UIB_BIST_MEM_INIT_START = 0x0303,
+	UIB_BIST_MEM_INIT_STATUS
+};
+
+/* CMD_PARAM_0 for opcode UIB_BIST_MEM_INIT_START */
+#define UIB_BIST_FULL_MEM	BIT(6)
+
+/* UIBSSM_CMD_RESPONSE_DATA_SHORT for opcode UIB_BIST_MEM_INIT_START */
+#define UIB_BIST_INITIATE_PASS	BIT(0)
+
+/*
+ * UIBSSM mailbox response outputs
+ *
+ * @cmd_resp_status: Command Interface status
+ */
+struct uib_mb_resp {
+	u32 cmd_resp_status;
+};
+
+/*
+ * UIB instance specific information
+ *
+ * @uib_csr_addr:	UIB instance CSR address
+ * @cal_status:		UIB instance calibration status
+ */
+struct uib_instance {
+	phys_addr_t uib_csr_addr;
+	bool cal_status;
+};
+
+/*
+ * Overall UIB instance(s) information
+ *
+ * @num_instance:	Number of instance(s) assigned to HPS
+ * @overall_cal_status: Overall calibration status for all UIB instance(s)
+ * @ecc_status:		ECC enable status (false = disabled, true = enabled)
+ * @overall_size:	Total HBM memory size
+ * @uib:		UIB instance specific information
+ */
+struct uib_info {
+	u8 num_instance;
+	bool overall_cal_status;
+	bool ecc_status;
+	u16 overall_size;
+	struct uib_instance uib[MAX_UIB_SUPPORTED];
+};
+
+/* Supported UIB function */
+int uib_mb_req(phys_addr_t uib_csr_addr,
+	       u32 usr_cmd_type, u32 usr_cmd_opcode,
+	       u32 cmd_param_0, struct uib_mb_resp *resp);
+int uib_cal_status(phys_addr_t addr);
+void uib_init_mem_cal(struct uib_info *uib_ctrl);
+void uib_trig_mem_cal(struct uib_info *uib_ctrl);
+int uib_bist_mem_init_start(struct uib_info *uib_ctrl);
-- 
2.25.1

