Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB09CC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87102884D1;
	Fri, 17 May 2024 14:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G/vTBmw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802CA88490; Fri, 17 May 2024 07:28:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B9A8848D
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923690; x=1747459690;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=juRteyv5EkojtpK4/X2NpGr6OrXlPJcwZT8usP1UT+Q=;
 b=G/vTBmw3vgAtdDcGBUW5Nw98OAOqX9q66ngJ4pthjCXUELw/9X9uuzJc
 fMsDgvq02Gc3tpCb43bEuBnCXGQpqI7zszC8jGdq+lFSl76Au/TSWyipD
 rSE7RwqNIgo44ZhEcXrXvrWU03yXcbfJvngm/zFxISUWpIoVhqbPSZ8gQ
 wWhS/G9KxkMj3zH9Abwgn/KWr/58mTs5CRTa0iiIFJWvz6PjX2TnjKvkN
 NPoV7Z9SW/pAqKA+Q4T29jbX6EOsfK9FE8K1LmEL1giZY8KDbhV8EJfHt
 FNl7MDl25wiP7+IjkT7xfJCjdb4rA5ytNbmTkuIAH2bq9rTas+WV38djE g==;
X-CSE-ConnectionGUID: RlxLCSb4QMy6/VPgGW+LAw==
X-CSE-MsgGUID: zeeLzBeYSuWQdZpHX3uMdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929994"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:28:04 -0700
X-CSE-ConnectionGUID: zwoMCzeQSqCtVrlMbf9Olg==
X-CSE-MsgGUID: MZQN9ctgR1GeSqw+GFkMeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188272"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:28:00 -0700
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
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 08/16] ddr: altera: Add
 iossm mailbox for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:53 +0800
Message-Id: <20240517052701.12949-9-tingting.meng@intel.com>
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add iossm mailbox driver for Agilex7 M-series. HPS will interact with IO96B
and DDR subsystem through software defined mailbox interface.
HPS can retrieve memory interface calibration status, IO96B configuration,
memory interfae configuration, trigger calibration and etc with the list of
supported mailbox command type and opcode.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 drivers/ddr/altera/iossm_mailbox.c | 637 +++++++++++++++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h | 182 +++++++++
 2 files changed, 819 insertions(+)
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h

diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
new file mode 100644
index 0000000000..f84a3a070d
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <hang.h>
+#include <string.h>
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include "iossm_mailbox.h"
+
+#define ECC_INTSTATUS_SERR SOCFPGA_SYSMGR_ADDRESS + 0x9C
+#define ECC_INISTATUS_DERR SOCFPGA_SYSMGR_ADDRESS + 0xA0
+#define DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK BIT(16)
+#define DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK BIT(17)
+
+#define DDR_CSR_CLKGEN_LOCKED_IO96B_MASK(x)	(i == 0 ? DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK : \
+							DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK)
+
+#define IO96B_MB_REQ_SETUP(v, w, x, y, z)	usr_req.ip_type = v; \
+						usr_req.ip_id = w; \
+						usr_req.usr_cmd_type = x; \
+						usr_req.usr_cmd_opcode = y; \
+						usr_req.cmd_param[0] = z; \
+						for (n = 1; n < NUM_CMD_PARAM; n++) \
+							usr_req.cmd_param[n] = 0
+#define MAX_RETRY_COUNT		3
+
+#define IO96B0_PLL_A_MASK	BIT(0)
+#define IO96B0_PLL_B_MASK	BIT(1)
+#define IO96B1_PLL_A_MASK	BIT(2)
+#define IO96B1_PLL_B_MASK	BIT(3)
+
+/* supported DDR type list */
+static const char *ddr_type_list[7] = {
+		"DDR4", "DDR5", "DDR5_RDIMM", "LPDDR4", "LPDDR5", "QDRIV", "UNKNOWN"
+};
+
+static int is_ddr_csr_clkgen_locked(u8 io96b_pll)
+{
+	int ret = 0;
+
+	if (FIELD_GET(IO96B0_PLL_A_MASK, io96b_pll)) {
+		ret = wait_for_bit_le32((const void *)(ECC_INTSTATUS_SERR),
+					DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK, true, TIMEOUT, false);
+
+		if (ret) {
+			debug("%s: ddr csr io96b_0 clkgenA locked is timeout\n", __func__);
+			goto err;
+		}
+	}
+
+	if (FIELD_GET(IO96B0_PLL_B_MASK, io96b_pll)) {
+		ret = wait_for_bit_le32((const void *)(ECC_INISTATUS_DERR),
+					DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK, true, TIMEOUT, false);
+
+		if (ret) {
+			debug("%s: ddr csr io96b_0 clkgenB locked is timeout\n", __func__);
+			goto err;
+		}
+	}
+
+	if (FIELD_GET(IO96B1_PLL_A_MASK, io96b_pll)) {
+		ret = wait_for_bit_le32((const void *)(ECC_INTSTATUS_SERR),
+					DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK, true, TIMEOUT, false);
+
+		if (ret) {
+			debug("%s: ddr csr io96b_1 clkgenA locked is timeout\n", __func__);
+			goto err;
+		}
+	}
+
+	if (FIELD_GET(IO96B1_PLL_B_MASK, io96b_pll)) {
+		ret = wait_for_bit_le32((const void *)(ECC_INISTATUS_DERR),
+					DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK, true, TIMEOUT, false);
+
+		if (ret) {
+			debug("%s: ddr csr io96b_1 clkgenB locked is timeout\n", __func__);
+			goto err;
+		}
+	}
+
+err:
+	return ret;
+}
+
+/* Mailbox request function
+ * This function will send the request to IOSSM mailbox and wait for response return
+ *
+ * @io96b_csr_addr: CSR address for the target IO96B
+ * @req:            Structure contain command request for IOSSM mailbox command
+ * @resp_data_len:  User desire extra response data fields other than
+ *					CMD_RESPONSE_DATA_SHORT field on CMD_RESPONSE_STATUS
+ * @resp:           Structure contain responses returned from the requested IOSSM
+ *					mailbox command
+ */
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp)
+{
+	int i, ret;
+	u32 cmd_req, cmd_resp;
+
+	/* Initialized zeros for responses */
+	resp->cmd_resp_status = 0;
+	for (i = 0; i < NUM_CMD_RESPONSE_DATA; i++)
+		resp->cmd_resp_data[i] = 0;
+
+	/* Ensure CMD_REQ is cleared before write any command request */
+	ret = wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_REQ_OFFSET),
+				GENMASK(31, 0), 0, TIMEOUT, false);
+	if (ret) {
+		printf("%s: CMD_REQ not ready\n", __func__);
+
+		return ret;
+	}
+
+	/* Write CMD_PARAM_* */
+	for (i = 0; i < NUM_CMD_PARAM ; i++) {
+		switch (i) {
+		case 0:
+			if (req.cmd_param[0])
+				writel(req.cmd_param[0], io96b_csr_addr + IOSSM_CMD_PARAM_0_OFFSET);
+			break;
+		case 1:
+			if (req.cmd_param[1])
+				writel(req.cmd_param[1], io96b_csr_addr + IOSSM_CMD_PARAM_1_OFFSET);
+			break;
+		case 2:
+			if (req.cmd_param[2])
+				writel(req.cmd_param[2], io96b_csr_addr + IOSSM_CMD_PARAM_2_OFFSET);
+			break;
+		case 3:
+			if (req.cmd_param[3])
+				writel(req.cmd_param[3], io96b_csr_addr + IOSSM_CMD_PARAM_3_OFFSET);
+			break;
+		case 4:
+			if (req.cmd_param[4])
+				writel(req.cmd_param[4], io96b_csr_addr + IOSSM_CMD_PARAM_4_OFFSET);
+			break;
+		case 5:
+			if (req.cmd_param[5])
+				writel(req.cmd_param[5], io96b_csr_addr + IOSSM_CMD_PARAM_5_OFFSET);
+			break;
+		case 6:
+			if (req.cmd_param[6])
+				writel(req.cmd_param[6], io96b_csr_addr + IOSSM_CMD_PARAM_6_OFFSET);
+			break;
+		default:
+			printf("%s: Invalid command parameter\n", __func__);
+		}
+	}
+
+	/* Write CMD_REQ (IP_TYPE, IP_INSTANCE_ID, CMD_TYPE and CMD_OPCODE) */
+	cmd_req = FIELD_PREP(CMD_TARGET_IP_TYPE_MASK, req.ip_type) |
+		FIELD_PREP(CMD_TARGET_IP_INSTANCE_ID_MASK, req.ip_id) |
+		FIELD_PREP(CMD_TYPE_MASK, req.usr_cmd_type) |
+		FIELD_PREP(CMD_OPCODE_MASK, req.usr_cmd_opcode);
+	writel(cmd_req, io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+
+	debug("%s: Write 0x%x to IOSSM_CMD_REQ_OFFSET 0x%llx\n", __func__, cmd_req,
+	      io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+	/* Read CMD_RESPONSE_READY in CMD_RESPONSE_STATUS */
+	ret = wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET),
+				IOSSM_STATUS_COMMAND_RESPONSE_READY, 1, TIMEOUT, false);
+	if (ret) {
+		printf("%s: CMD_RESPONSE ERROR:\n", __func__);
+
+		cmd_resp = readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET);
+
+		printf("%s: STATUS_GENERAL_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_GENERAL_ERROR(cmd_resp));
+		printf("%s: STATUS_CMD_RESPONSE_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_CMD_RESPONSE_ERROR(cmd_resp));
+	}
+
+	/* read CMD_RESPONSE_STATUS */
+	resp->cmd_resp_status = readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__, io96b_csr_addr +
+	      IOSSM_CMD_RESPONSE_STATUS_OFFSET, resp->cmd_resp_status);
+
+	/* read CMD_RESPONSE_DATA_* */
+	for (i = 0; i < resp_data_len; i++) {
+		switch (i) {
+		case 0:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_0_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 1:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_1_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 2:
+			resp->cmd_resp_data[i] =
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_2_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		default:
+			printf("%s: Invalid response data\n", __func__);
+		}
+	}
+
+	resp->cmd_resp_status = readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__, io96b_csr_addr +
+	      IOSSM_CMD_RESPONSE_STATUS_OFFSET, resp->cmd_resp_status);
+
+	/* write CMD_RESPONSE_READY = 0 */
+	clrbits_le32((u32 *)(uintptr_t)(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET),
+		     IOSSM_STATUS_COMMAND_RESPONSE_READY);
+
+	resp->cmd_resp_status = readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET);
+
+	debug("%s: CMD_RESPONSE_READY 0x%llx: 0x%x\n", __func__, io96b_csr_addr +
+	      IOSSM_CMD_RESPONSE_STATUS_OFFSET, resp->cmd_resp_status);
+
+	return 0;
+}
+
+/*
+ * Initial function to be called to set memory interface IP type and instance ID
+ * IP type and instance ID need to be determined before sending mailbox command
+ */
+void io96b_mb_init(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	u8 ip_type_ret, instance_id_ret;
+	int i, j, k, n;
+
+	debug("%s: num_instance %d\n", __func__, io96b_ctrl->num_instance);
+
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		debug("%s: get memory interface IO96B %d\n", __func__, i);
+
+		IO96B_MB_REQ_SETUP(0,
+				   0,
+				   CMD_GET_SYS_INFO,
+				   GET_MEM_INTF_INFO,
+				   0);
+
+		/* Get memory interface IP type and instance ID (IP identifier) */
+		io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 2, &usr_resp);
+
+		debug("%s: get response from memory interface IO96B %d\n", __func__, i);
+
+		/* Retrieve number of memory interface(s) */
+		io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface =
+			IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) & 0x3;
+
+		debug("%s: IO96B %d: num_mem_interface: 0x%x\n", __func__, i,
+		      io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface);
+
+		/* Retrieve memory interface IP type and instance ID (IP identifier) */
+		j = 0;
+		for (k = 0; k < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; k++) {
+			ip_type_ret = FIELD_GET(INTF_IP_TYPE_MASK, usr_resp.cmd_resp_data[k]);
+			instance_id_ret = FIELD_GET(INTF_INSTANCE_ID_MASK,
+						    usr_resp.cmd_resp_data[k]);
+
+			if (ip_type_ret) {
+				io96b_ctrl->io96b[i].mb_ctrl.ip_type[j] = ip_type_ret;
+				io96b_ctrl->io96b[i].mb_ctrl.ip_id[j] = instance_id_ret;
+
+				debug("%s: IO96B %d mem_interface %d: ip_type_ret: 0x%x\n",
+				      __func__, i, j, ip_type_ret);
+				debug("%s: IO96B %d mem_interface %d: instance_id_ret: 0x%x\n",
+				      __func__, i, j, instance_id_ret);
+
+				j++;
+			}
+		}
+	}
+}
+
+int io96b_cal_status(phys_addr_t addr)
+{
+	int ret;
+	u32 cal_success, cal_fail;
+	phys_addr_t status_addr = addr + IOSSM_STATUS_OFFSET;
+
+	/* Ensure calibration completed */
+	ret = wait_for_bit_le32((const void *)status_addr, IOSSM_STATUS_CAL_BUSY, false,
+				TIMEOUT, false);
+	if (ret) {
+		printf("%s: SDRAM calibration IO96b instance 0x%llx timeout\n", __func__,
+		       status_addr);
+
+		hang();
+	}
+
+	/* Calibration status */
+	cal_success = readl(status_addr) & IOSSM_STATUS_CAL_SUCCESS;
+	cal_fail = readl(status_addr) & IOSSM_STATUS_CAL_FAIL;
+
+	if (cal_success && !cal_fail)
+		return 0;
+	else
+		return -EPERM;
+}
+
+void init_mem_cal(struct io96b_info *io96b_ctrl)
+{
+	int count, i, ret;
+
+	/* Initialize overall calibration status */
+	io96b_ctrl->overall_cal_status = false;
+
+	if (io96b_ctrl->ckgen_lock) {
+		ret = is_ddr_csr_clkgen_locked(io96b_ctrl->io96b_pll);
+		if (ret) {
+			printf("%s: iossm IO96B ckgena_lock is not locked\n", __func__);
+			hang();
+		}
+	}
+
+	/* Check initial calibration status for the assigned IO96B */
+	count = 0;
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		ret = io96b_cal_status(io96b_ctrl->io96b[i].io96b_csr_addr);
+		if (ret) {
+			io96b_ctrl->io96b[i].cal_status = false;
+
+			printf("%s: Initial DDR calibration IO96B_%d failed %d\n", __func__,
+			       i, ret);
+
+			hang();
+		}
+
+		io96b_ctrl->io96b[i].cal_status = true;
+
+		printf("%s: Initial DDR calibration IO96B_%d succeed\n", __func__, i);
+
+		count++;
+	}
+
+	if (count == io96b_ctrl->num_instance)
+		io96b_ctrl->overall_cal_status = true;
+}
+
+/* Trying 3 times re-calibration if initial calibration failed */
+int trig_mem_cal(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	bool recal_success;
+	int i, j, k, n;
+	u32 cal_stat_offset;
+	u8 cal_stat, trig_cal_stat;
+	int count = 0;
+
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		if (!io96b_ctrl->io96b[i].cal_status) {
+			for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+				/* Get the memory calibration status for memory interface */
+				IO96B_MB_REQ_SETUP(0,
+						   0,
+						   CMD_TRIG_MEM_CAL_OP,
+						   GET_MEM_CAL_STATUS,
+						   0);
+
+				io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+					     2, &usr_resp);
+
+				recal_success = false;
+
+				/* Re-calibration first memory interface with failed calibration */
+				for (k = 0; k < MAX_RETRY_COUNT; k++) {
+					cal_stat_offset = usr_resp.cmd_resp_data[j];
+					cal_stat = readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+							 cal_stat_offset);
+					if (cal_stat == INTF_MEM_CAL_STATUS_SUCCESS) {
+						recal_success = true;
+						break;
+					}
+
+					IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+							   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+							   CMD_TRIG_MEM_CAL_OP,
+							   TRIG_MEM_CAL,
+							   0);
+
+					io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+						     2, &usr_resp);
+
+					trig_cal_stat =
+					IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) &
+					BIT(0);
+
+					debug("%s: Memory calibration triggered status = %d\n",
+					      __func__, trig_cal_stat);
+
+					udelay(1);
+
+					IO96B_MB_REQ_SETUP(0,
+							   0,
+							   CMD_TRIG_MEM_CAL_OP,
+							   GET_MEM_CAL_STATUS,
+							   0);
+
+					io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+						     2, &usr_resp);
+				}
+
+				if (!recal_success) {
+					printf("%s: Error as SDRAM calibration failed\n", __func__);
+
+					hang();
+				}
+			}
+
+			io96b_ctrl->io96b[i].cal_status = true;
+			io96b_ctrl->overall_cal_status = io96b_ctrl->io96b[i].cal_status;
+
+			printf("%s: Initial DDR calibration IO96B_%d succeed\n", __func__, i);
+
+			count++;
+		}
+	}
+
+	if (io96b_ctrl->overall_cal_status)
+		debug("%s: Overall SDRAM calibration success\n", __func__);
+
+	return 0;
+}
+
+int get_mem_technology(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n;
+	u8 ddr_type_ret;
+
+	/* Initialize ddr type */
+	io96b_ctrl->ddr_type = ddr_type_list[6];
+
+	/* Get and ensure all memory interface(s) same DDR type */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_GET_MEM_INFO,
+					   GET_MEM_TECHNOLOGY,
+					   0);
+
+			io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 0, &usr_resp);
+
+			ddr_type_ret =
+				IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+				& GENMASK(2, 0);
+
+			if (!strcmp(io96b_ctrl->ddr_type, "UNKNOWN"))
+				io96b_ctrl->ddr_type = ddr_type_list[ddr_type_ret];
+
+			if (ddr_type_list[ddr_type_ret] != io96b_ctrl->ddr_type) {
+				printf("%s: Mismatch DDR type on IO96B_%d\n", __func__, i);
+
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int get_mem_width_info(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n;
+	u16 memory_size;
+	u16 total_memory_size = 0;
+
+	/* Get all memory interface(s) total memory size on all instance(s) */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		memory_size = 0;
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_GET_MEM_INFO,
+					   GET_MEM_WIDTH_INFO,
+					   0);
+
+			io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req,
+				     2, &usr_resp);
+
+			memory_size = memory_size +
+					(usr_resp.cmd_resp_data[1] & GENMASK(7, 0));
+		}
+
+		if (!memory_size) {
+			printf("%s: Failed to get valid memory size\n", __func__);
+
+			return -EINVAL;
+		}
+
+		io96b_ctrl->io96b[i].size = memory_size;
+
+		total_memory_size = total_memory_size + memory_size;
+	}
+
+	if (!total_memory_size) {
+		printf("%s: Failed to get valid memory size\n", __func__);
+
+		return -EINVAL;
+	}
+
+	io96b_ctrl->overall_size = total_memory_size;
+
+	return 0;
+}
+
+int ecc_enable_status(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n;
+	bool ecc_stat_set = false;
+	bool ecc_stat;
+
+	/* Initialize ECC status */
+	io96b_ctrl->ecc_status = false;
+
+	/* Get and ensure all memory interface(s) same ECC status */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP,
+					   ECC_ENABLE_STATUS,
+					   0);
+
+			io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 0, &usr_resp);
+
+			ecc_stat = (IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+					& GENMASK(1, 0)) == 0 ? false : true;
+
+			if (!ecc_stat_set) {
+				io96b_ctrl->ecc_status = ecc_stat;
+				ecc_stat_set = true;
+			}
+
+			if (ecc_stat != io96b_ctrl->ecc_status) {
+				printf("%s: Mismatch DDR ECC status on IO96B_%d\n", __func__, i);
+
+				return -EINVAL;
+			}
+		}
+	}
+
+	debug("%s: ECC enable status: %d\n", __func__, io96b_ctrl->ecc_status);
+
+	return 0;
+}
+
+int bist_mem_init_start(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n;
+	bool bist_start, bist_success;
+	u32 start;
+
+	/* Full memory initialization BIST performed on all memory interface(s) */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			bist_start = false;
+			bist_success = false;
+
+			/* Start memory initialization BIST on full memory address */
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP,
+					   BIST_MEM_INIT_START,
+					   BIST_FULL_MEM);
+
+			io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 0, &usr_resp);
+
+			bist_start = IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+				& BIT(0);
+
+			if (!bist_start) {
+				printf("%s: Failed to initialize memory on IO96B_%d\n", __func__,
+				       i);
+				printf("%s: BIST_MEM_INIT_START Error code 0x%lx\n", __func__,
+				       IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+				return -EINVAL;
+			}
+
+			/* Polling for the initiated memory initialization BIST status */
+			start = get_timer(0);
+			while (!bist_success) {
+				IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+						   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+						   CMD_TRIG_CONTROLLER_OP,
+						   BIST_MEM_INIT_STATUS,
+						   0);
+
+				io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr, usr_req, 0,
+					     &usr_resp);
+
+				bist_success =
+					IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+					& BIT(0);
+
+				if (!bist_success && (get_timer(start) > TIMEOUT)) {
+					printf("%s: Timeout initialize memory on IO96B_%d\n",
+					       __func__, i);
+					printf("%s: BIST_MEM_INIT_STATUS Error code 0x%lx\n",
+					       __func__,
+					IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+					return -ETIMEDOUT;
+				}
+
+				udelay(1);
+			}
+		}
+
+		debug("%s: Memory initialized successfully on IO96B_%d\n", __func__, i);
+	}
+	return 0;
+}
diff --git a/drivers/ddr/altera/iossm_mailbox.h b/drivers/ddr/altera/iossm_mailbox.h
new file mode 100644
index 0000000000..2a10b0dba6
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#define TIMEOUT_120000MS			120000
+#define TIMEOUT					TIMEOUT_120000MS
+#define IOSSM_STATUS_CAL_SUCCESS		BIT(0)
+#define IOSSM_STATUS_CAL_FAIL			BIT(1)
+#define IOSSM_STATUS_CAL_BUSY			BIT(2)
+#define IOSSM_STATUS_COMMAND_RESPONSE_READY	BIT(0)
+#define IOSSM_CMD_RESPONSE_STATUS_OFFSET	0x45C
+#define IOSSM_CMD_RESPONSE_DATA_0_OFFSET	0x458
+#define IOSSM_CMD_RESPONSE_DATA_1_OFFSET	0x454
+#define IOSSM_CMD_RESPONSE_DATA_2_OFFSET	0x450
+#define IOSSM_CMD_REQ_OFFSET			0x43C
+#define IOSSM_CMD_PARAM_0_OFFSET		0x438
+#define IOSSM_CMD_PARAM_1_OFFSET		0x434
+#define IOSSM_CMD_PARAM_2_OFFSET		0x430
+#define IOSSM_CMD_PARAM_3_OFFSET		0x42C
+#define IOSSM_CMD_PARAM_4_OFFSET		0x428
+#define IOSSM_CMD_PARAM_5_OFFSET		0x424
+#define IOSSM_CMD_PARAM_6_OFFSET		0x420
+#define IOSSM_STATUS_OFFSET			0x400
+#define IOSSM_CMD_RESPONSE_DATA_SHORT_MASK	GENMASK(31, 16)
+#define IOSSM_CMD_RESPONSE_DATA_SHORT(n)	FIELD_GET(IOSSM_CMD_RESPONSE_DATA_SHORT_MASK, n)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK	GENMASK(7, 5)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR(n)	FIELD_GET(IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK, n)
+#define IOSSM_STATUS_GENERAL_ERROR_MASK		GENMASK(4, 1)
+#define IOSSM_STATUS_GENERAL_ERROR(n)		FIELD_GET(IOSSM_STATUS_GENERAL_ERROR_MASK, n)
+#define MAX_IO96B_SUPPORTED			2
+#define NUM_CMD_RESPONSE_DATA			3
+#define NUM_CMD_PARAM				6
+
+/* supported mailbox command type */
+enum iossm_mailbox_cmd_type  {
+	CMD_NOP,
+	CMD_GET_SYS_INFO,
+	CMD_GET_MEM_INFO,
+	CMD_GET_MEM_CAL_INFO,
+	CMD_TRIG_CONTROLLER_OP,
+	CMD_TRIG_MEM_CAL_OP
+};
+
+/* supported mailbox command opcode */
+enum iossm_mailbox_cmd_opcode  {
+	GET_MEM_INTF_INFO = 0x0001,
+	GET_MEM_TECHNOLOGY,
+	GET_MEMCLK_FREQ_KHZ,
+	GET_MEM_WIDTH_INFO,
+	ECC_ENABLE_SET = 0x0101,
+	ECC_ENABLE_STATUS,
+	ECC_INTERRUPT_STATUS,
+	ECC_INTERRUPT_ACK,
+	ECC_INTERRUPT_MASK,
+	ECC_WRITEBACK_ENABLE,
+	ECC_SCRUB_IN_PROGRESS_STATUS = 0x0201,
+	ECC_SCRUB_MODE_0_START,
+	ECC_SCRUB_MODE_1_START,
+	BIST_STANDARD_MODE_START = 0x0301,
+	BIST_RESULTS_STATUS,
+	BIST_MEM_INIT_START,
+	BIST_MEM_INIT_STATUS,
+	BIST_SET_DATA_PATTERN_UPPER,
+	BIST_SET_DATA_PATTERN_LOWER,
+	TRIG_MEM_CAL = 0x000a,
+	GET_MEM_CAL_STATUS
+};
+
+/* response data of cmd opcode GET_MEM_INTF_INFO */
+#define INTF_IP_TYPE_MASK		GENMASK(31, 29)
+#define INTF_INSTANCE_ID_MASK		GENMASK(28, 24)
+
+/* response data of cmd opcode GET_MEM_CAL_STATUS */
+#define INTF_UNUSED			0x0
+#define INTF_MEM_CAL_STATUS_SUCCESS	0x1
+#define INTF_MEM_CAL_STATUS_FAIL	0x2
+#define INTF_MEM_CAL_STATUS_ONGOING	0x4
+
+/* cmd opcode BIST_MEM_INIT_START, BIST performed on full memory address range */
+#define BIST_FULL_MEM			BIT(6)
+
+/*
+ * IOSSM mailbox required information
+ *
+ * @num_mem_interface:	Number of memory interfaces instantiated
+ * @ip_type:		IP type implemented on the IO96B
+ * @ip_instance_id:	IP identifier for every IP instance implemented on the IO96B
+ */
+struct io96b_mb_ctrl {
+	u32 num_mem_interface;
+	u32 ip_type[2];
+	u32 ip_id[2];
+};
+
+/* CMD_REQ Register Definition */
+#define CMD_TARGET_IP_TYPE_MASK		GENMASK(31, 29)
+#define CMD_TARGET_IP_INSTANCE_ID_MASK	GENMASK(28, 24)
+#define CMD_TYPE_MASK			GENMASK(23, 16)
+#define CMD_OPCODE_MASK			GENMASK(15, 0)
+
+/*
+ * IOSSM mailbox request
+ * @ip_type:	    IP type for the specified memory interface
+ * @ip_id:	    IP instance ID for the specified memory interface
+ * @usr_cmd_type:   User desire IOSSM mailbox command type
+ * @usr_cmd_opcode: User desire IOSSM mailbox command opcode
+ * @cmd_param_*:    Parameters (if applicable) for the requested IOSSM mailbox command
+ */
+struct io96b_mb_req {
+	u32 ip_type;
+	u32 ip_id;
+	u32 usr_cmd_type;
+	u32 usr_cmd_opcode;
+	u32 cmd_param[NUM_CMD_PARAM];
+};
+
+/*
+ * IOSSM mailbox response outputs
+ *
+ * @cmd_resp_status: Command Interface status
+ * @cmd_resp_data_*: More spaces for command response
+ */
+struct io96b_mb_resp {
+	u32 cmd_resp_status;
+	u32 cmd_resp_data[NUM_CMD_RESPONSE_DATA];
+};
+
+/*
+ * IO96B instance specific information
+ *
+ * @size:		Memory size
+ * @io96b_csr_addr:	IO96B instance CSR address
+ * @cal_status:		IO96B instance calibration status
+ * @mb_ctrl:		IOSSM mailbox required information
+ */
+struct io96b_instance {
+	u16 size;
+	phys_addr_t io96b_csr_addr;
+	bool cal_status;
+	struct io96b_mb_ctrl mb_ctrl;
+};
+
+/*
+ * Overall IO96B instance(s) information
+ *
+ * @num_instance:	Number of instance(s) assigned to HPS
+ * @overall_cal_status: Overall calibration status for all IO96B instance(s)
+ * @ddr_type:		DDR memory type
+ * @ecc_status:		ECC enable status (false = disabled, true = enabled)
+ * @overall_size:	Total DDR memory size
+ * @io96b[]:		IO96B instance specific information
+ * @ckgen_lock:		IO96B GEN PLL lock (false = not locked, true = locked)
+ * @num_port:		Number of IO96B port. Example bit 0 represent port 0, bit 1 represent port 1, and so on
+ * @io96b_pll:		Selected IO96B PLL. Example bit 0: EMIF0 PLL A selected,
+ *			bit 1: EMIF0 PLL B selected, bit 2 - EMIF1 PLL A selected,
+ *			bit 3: EMIF1 PLL B selected
+ */
+struct io96b_info {
+	u8 num_instance;
+	bool overall_cal_status;
+	const char *ddr_type;
+	bool ecc_status;
+	u16 overall_size;
+	struct io96b_instance io96b[MAX_IO96B_SUPPORTED];
+	bool ckgen_lock;
+	u8 num_port;
+	u8 io96b_pll;
+};
+
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp);
+
+/* Supported IOSSM mailbox function */
+void io96b_mb_init(struct io96b_info *io96b_ctrl);
+int io96b_cal_status(phys_addr_t addr);
+void init_mem_cal(struct io96b_info *io96b_ctrl);
+int trig_mem_cal(struct io96b_info *io96b_ctrl);
+int get_mem_technology(struct io96b_info *io96b_ctrl);
+int get_mem_width_info(struct io96b_info *io96b_ctrl);
+int ecc_enable_status(struct io96b_info *io96b_ctrl);
+int bist_mem_init_start(struct io96b_info *io96b_ctrl);
-- 
2.25.1

