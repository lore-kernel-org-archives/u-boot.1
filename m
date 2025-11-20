Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C35CCF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3048409B;
	Thu, 20 Nov 2025 09:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="otmY8PiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0EF84057; Thu, 20 Nov 2025 09:13:10 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B498405B
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so4995355e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626388; x=1764231188; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+0SO5Z4c06o71aSBf0k3vR4v2Lmvyvz0QUgz+Cforw=;
 b=otmY8PiDhmKunSNPGh8kyWPYEU48KyMuDvZhfY9b0tkmH9q8lf8I++5oKQAvX9An2H
 V1RDdZA5Bgw0TB3izxRHvqk2TIuZiWhptO5PwWls4eRY17laXVZ1IDXIMLY1fCt3sqOX
 oriuJoDIDNy5/A4TBrOmkkb/VzzD6l/I3U2IuL1oxAL5sHakvH3J4+SJYOdqbpGndIxs
 69MbrNXYjExY27mcz8GyZwqqsnjwGeILWn8hNZwmHYqLXgGd7kQ9zJOrd2p5K4AC8ybH
 pQ3DGorMQTCsUmb4RubfrD4nwkPUGVGIn+CIVtSMB65PgbR69gGdg6FSDBYbJnPrwYkc
 zoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626388; x=1764231188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k+0SO5Z4c06o71aSBf0k3vR4v2Lmvyvz0QUgz+Cforw=;
 b=CK4MDX2Jje3yjQvkze8cy/Nlib2iSbC/sJydovvoQ+S4p1lIT+UZsJeFg45dDVca7i
 9WcXeGtbLqZp7SPTzN5XNQSUQx+rcPODPKKt2JuZusk7CwLeHGcpvQPm8BsKG/NIkgku
 WkVijKuCh44+Fa2oTq5A9Gj/4VBOACaFjV09H5LIivLRiRjHQDGCjjYdK72ryZhqgmo4
 ySXgsoMQGHoxypcWTcvB+O1diipj/jFBvBrBcQisDDTgQfjivBhFCQ5hqz6YMuPpzzzK
 yt4ue93FLXVKtL3xZsGBLl02hYWoeG03ekVL+MKcgdGgbq3o2eZBvdpXQeQH4runfXXn
 a3vg==
X-Gm-Message-State: AOJu0YynJAG9HUr66tW5+le4RZaSVHly6FpHMjS+vD1v+KctgL+hwsTe
 zw+LAsdoCRnD48hf0UfjHCWZdAnBwFBLvQNV6BuvYJgANXTeUWz1TDVAsMRKScoOwyA=
X-Gm-Gg: ASbGncvDGWIfzns0IC3PxJWWLdg6fUlxc2MRhk6uKMklT402DRji2nZakfcPzPwM7bo
 caP4bQD8uSX04aNoj/R9C7aazVlW8o81Rj4STuhDz3xiZS597WX5GsS9gGWDGR5nb0Jn1Iku0Hl
 yUgQF+h0+zHwhs3E8+kg4iMSiUQAbS4suW6G2LyNO/ZDq8T86u8u+V+FXUPkhG7bJ1Xh+SSnOkD
 0ecMTgmSNhUbw313rrzNYs2/wKRVAEwSzY/auPuE9D+A0LPYjqpVRj28gL9SfrjvZGK4tQAH8qW
 sOTlCwl7HYZUK5DmhSqPYogwx73XohNMW684m5FSjIs3t73g5eIuJ07L5sIIDjAcWGUNfBWZREF
 sJfx4YUdxrp5qn6hmF2XQM0iD4hm1evm3ReqHcz5OZajwbWKc3L7li5p+0MdEEIG+AmTndEjRWu
 L4w3yngE5r+8sNkuS8IXeRRuAgaiqkMI8=
X-Google-Smtp-Source: AGHT+IFNd1aOjNO3Oo04CvF7Z56UNYPZvd95YC8b3tXst/7fv4DxYK52jwyyG90sfe6ftnBCBK3dTQ==
X-Received: by 2002:a05:6000:1789:b0:42b:3b8a:30a3 with SMTP id
 ffacd0b85a97d-42cb9801049mr1739565f8f.4.1763626387380; 
 Thu, 20 Nov 2025 00:13:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:13:07 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Nov 2025 09:12:55 +0100
Subject: [PATCH v5 4/7] interconnect: add support for the Qualcomm RPMh helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-interconnect-next-v5-4-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23451;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LvshxgafimMS3CN0gNVeJEumesowgjqtzpygaOPRbCI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2JPOHI5SwKNOhEExebvy+nXaR8HZKYLGB5xb5W
 TB7khciJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NiQAKCRB33NvayMhJ0fCgEA
 C1BnyX6wBucQrKPDeYkXJJ18a7zMl7IAdKYcAtI6BajHV0UvE0dQDyJLAA1aAvnnMfT7CUYvPj4hEu
 xydwyNk/8SutHlFnMAmF4RaktRnkbvhwQdoN/syM6yjcoR4iBf8dRz/+FSiEIXy15047eXhrGwGIDr
 Z12VFrtGK0m2SMZirI74t/EM4K5hBZSRh0XzlBcU7HfdTBSSfmRj+/DNwZAikiPkDnpYQnWDuVHPWY
 +MbaT3OU9Gck+qZgTOjc5nO7tRUId6KoXlDF2rqm3sTD1G09FmVMQ4zfBJCmUVgmsVOgQbtuFNJD/g
 +0l8EZgz4zcNSTkpT1B9cPnDjNAdYfeIz6xd6lBxyOJF58TOo24lzp33kRMSCVxpOC0nfaOVEZamUc
 Ev3V1Vzvi5Pm9uWnZNKZ6CuwEc8JAR4z1bzD02a7bVKaz0KgzBZnQ1SgefDZJ9HBnHUSpl4tQsHUPh
 EjA7nNrHIleeA5DNgzeHOQmDvo12sinH6lGKRrLgBBVPkcZV9wRZZXSBb1XQTu9qrWJAdvt9GNeIyp
 liLwD6xxxvu29M1YDV1zCrByVsrXGf9EEg78XCgde22o1QzMMGWDJBkcKUBsVA1PpCFk19f2yKGIZr
 jfH/bPz/CYdwRxrhKogjtlg8V5S5foeO/1HQHRwlkAyNEG9gvY7h672yZgHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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

The Qualcomm SoCs votes for common resources via the RPMh subsystem.

Implement the necessary helpers for Interconnect providers to add the
nodes and vote via the RPPh "BCM" voters, which are vote endpoints for
each SoC subsystems. The APPS (ARM subsystem) has a dedicated endpoint.

The BCM voter will aggregate all the bandwidth for all the nodes
associated with a BCM voter, and internally the RPMh with also
aggregate all the votes from all the SoC subsystems for the same
BCM voter.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/Kconfig          |   2 +
 drivers/interconnect/Makefile         |   1 +
 drivers/interconnect/qcom/Kconfig     |   6 +
 drivers/interconnect/qcom/Makefile    |   6 +
 drivers/interconnect/qcom/bcm-voter.c | 340 ++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/bcm-voter.h |  19 ++
 drivers/interconnect/qcom/icc-rpmh.c  | 224 ++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h  | 130 +++++++++++++
 8 files changed, 728 insertions(+)

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index e9f4cc662ae..de868b9ad38 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -15,6 +15,8 @@ config INTERCONNECT_SANDBOX
 	help
 	  Enable support for the interconnect sandbox drivers.
 
+source "drivers/interconnect/qcom/Kconfig"
+
 endif
 
 endmenu
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 04b18589b7f..c9e8077b0f1 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_$(PHASE_)INTERCONNECT) += interconnect-uclass.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_SANDBOX) += sandbox-interconnect.o sandbox-interconnect-test.o
+obj-y += qcom/
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 00000000000..ab5b19567ec
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,6 @@
+config INTERCONNECT_QCOM_RPMH
+	bool "Enable interconnect support for SoCs with RPMh"
+	depends on QCOM_RPMH
+	help
+	  Enable support for the interconnect helpers to vote with
+	  the RPMh subsystems in Qualcomm SoCs
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
new file mode 100644
index 00000000000..4369ca07f61
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Linaro Limited
+#
+
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
new file mode 100644
index 00000000000..361b03f207a
--- /dev/null
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <linux/err.h>
+#include <div64.h>
+#include <dm/device_compat.h>
+#include <linux/list_sort.h>
+
+#include "bcm-voter.h"
+
+/* TODO drop WAKE/SLEEP buckets fills if we really don't need them */
+
+/**
+ * struct bcm_voter - Bus Clock Manager voter
+ * @dev: reference to the device that communicates with the BCM
+ * @np: reference to the device node to match bcm voters
+ * @commit_list: list containing bcms to be committed to hardware
+ * @ws_list: list containing bcms that have different wake/sleep votes
+ * @voter_node: list of bcm voters
+ * @tcs_wait: mask for which buckets require TCS completion
+ */
+struct bcm_voter {
+	struct udevice *dev;
+	struct list_head commit_list;
+	struct list_head ws_list;
+	u32 tcs_wait;
+};
+
+static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct qcom_icc_bcm *bcm_a = list_entry(a, struct qcom_icc_bcm, list);
+	struct qcom_icc_bcm *bcm_b = list_entry(b, struct qcom_icc_bcm, list);
+
+	return bcm_a->aux_data.vcd - bcm_b->aux_data.vcd;
+}
+
+static u64 bcm_div(u64 num, u32 base)
+{
+	/* Ensure that small votes aren't lost. */
+	if (num && num < base)
+		return 1;
+
+	do_div(num, base);
+
+	return num;
+}
+
+/* BCMs with enable_mask use one-hot-encoding for on/off signaling */
+static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
+{
+	struct qcom_icc_node *node;
+	int bucket, i;
+
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		bcm->vote_x[bucket] = 0;
+		bcm->vote_y[bucket] = 0;
+
+		for (i = 0; i < bcm->num_nodes; i++) {
+			node = bcm->nodes[i];
+
+			/* If any vote in this bucket exists, keep the BCM enabled */
+			if (node->sum_avg[bucket] || node->max_peak[bucket]) {
+				bcm->vote_x[bucket] = 0;
+				bcm->vote_y[bucket] = bcm->enable_mask;
+				break;
+			}
+		}
+	}
+
+	if (bcm->keepalive) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+	}
+}
+
+static void bcm_aggregate(struct qcom_icc_bcm *bcm)
+{
+	struct qcom_icc_node *node;
+	size_t i, bucket;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
+	u64 temp;
+
+	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			node = bcm->nodes[i];
+			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
+				       node->buswidth * node->channels);
+			agg_avg[bucket] = max(agg_avg[bucket], temp);
+
+			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
+				       node->buswidth);
+			agg_peak[bucket] = max(agg_peak[bucket], temp);
+		}
+
+		temp = agg_avg[bucket] * bcm->vote_scale;
+		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
+
+		temp = agg_peak[bucket] * bcm->vote_scale;
+		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
+	}
+
+	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
+	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] == 0) {
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+	}
+}
+
+static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
+			       u32 addr, bool commit, bool wait)
+{
+	bool valid = true;
+
+	if (!cmd)
+		return;
+
+	memset(cmd, 0, sizeof(*cmd));
+
+	if (vote_x == 0 && vote_y == 0)
+		valid = false;
+
+	if (vote_x > BCM_TCS_CMD_VOTE_MASK)
+		vote_x = BCM_TCS_CMD_VOTE_MASK;
+
+	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
+		vote_y = BCM_TCS_CMD_VOTE_MASK;
+
+	cmd->addr = addr;
+	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
+
+	/*
+	 * Set the wait for completion flag on command that need to be completed
+	 * before the next command.
+	 */
+	cmd->wait = wait;
+}
+
+static void tcs_list_gen(struct bcm_voter *voter, int bucket,
+			 struct tcs_cmd tcs_list[MAX_VCD],
+			 int n[MAX_VCD + 1])
+{
+	struct list_head *bcm_list = &voter->commit_list;
+	struct qcom_icc_bcm *bcm;
+	bool commit, wait;
+	size_t idx = 0, batch = 0, cur_vcd_size = 0;
+
+	memset(n, 0, sizeof(int) * (MAX_VCD + 1));
+
+	list_for_each_entry(bcm, bcm_list, list) {
+		commit = false;
+		cur_vcd_size++;
+		if ((list_is_last(&bcm->list, bcm_list)) ||
+		    bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
+			commit = true;
+			cur_vcd_size = 0;
+		}
+
+		wait = commit && (voter->tcs_wait & BIT(bucket));
+
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
+			    bcm->vote_y[bucket], bcm->addr, commit, wait);
+		idx++;
+		n[batch]++;
+		/*
+		 * Batch the BCMs in such a way that we do not split them in
+		 * multiple payloads when they are under the same VCD. This is
+		 * to ensure that every BCM is committed since we only set the
+		 * commit bit on the last BCM request of every VCD.
+		 */
+		if (n[batch] >= MAX_RPMH_PAYLOAD) {
+			if (!commit) {
+				n[batch] -= cur_vcd_size;
+				n[batch + 1] = cur_vcd_size;
+			}
+			batch++;
+		}
+	}
+}
+
+/**
+ * of_bcm_voter_get - gets a bcm voter handle from DT node
+ * @dev: device pointer for the consumer device
+ * @name: name for the bcm voter device
+ *
+ * This function will match a device_node pointer for the phandle
+ * specified in the device DT and return a bcm_voter handle on success.
+ *
+ * Returns bcm_voter pointer or ERR_PTR() on error. EPROBE_DEFER is returned
+ * when matching bcm voter is yet to be found.
+ */
+struct bcm_voter *of_bcm_voter_get(struct udevice *dev, const char *name)
+{
+	struct ofnode_phandle_args args;
+	struct udevice *bcm_dev;
+	int ret, idx = 0;
+
+	if (name) {
+		idx = dev_read_stringlist_search(dev, "qcom,bcm-voter-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	ret = dev_read_phandle_with_args(dev, "qcom,bcm-voters", NULL, 0,
+					 idx, &args);
+	if (ret)
+		return ERR_PTR(idx);
+
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, args.node,
+					  &bcm_dev);
+	if (ret) {
+		debug("%s: uclass_get_device_by_ofnode failed: %d\n",
+		      __func__, ret);
+		return ERR_PTR(ret);
+	}
+
+	return dev_get_priv(bcm_dev);
+}
+
+/**
+ * qcom_icc_bcm_voter_add - queues up the bcm nodes that require updates
+ * @voter: voter that the bcms are being added to
+ * @bcm: bcm to add to the commit and wake sleep list
+ */
+void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
+{
+	if (!voter)
+		return;
+
+	if (list_empty(&bcm->list))
+		list_add_tail(&bcm->list, &voter->commit_list);
+
+	if (list_empty(&bcm->ws_list))
+		list_add_tail(&bcm->ws_list, &voter->ws_list);
+}
+
+/**
+ * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
+ * @voter: voter that needs flushing
+ *
+ * This function generates a set of AMC commands and flushes to the BCM device
+ * associated with the voter. It conditionally generate WAKE and SLEEP commands
+ * based on deltas between WAKE/SLEEP requirements. The ws_list persists
+ * through multiple commit requests and bcm nodes are removed only when the
+ * requirements for WAKE matches SLEEP.
+ *
+ * Returns 0 on success, or an appropriate error code otherwise.
+ */
+int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
+{
+	struct qcom_icc_bcm *bcm;
+	struct qcom_icc_bcm *bcm_tmp;
+	int commit_idx[MAX_VCD + 1];
+	struct tcs_cmd cmds[MAX_BCMS];
+	int ret = 0;
+
+	if (!voter)
+		return 0;
+
+	list_for_each_entry(bcm, &voter->commit_list, list) {
+		if (bcm->enable_mask)
+			bcm_aggregate_mask(bcm);
+		else
+			bcm_aggregate(bcm);
+	}
+
+	/*
+	 * Pre sort the BCMs based on VCD for ease of generating a command list
+	 * that groups the BCMs with the same VCD together. VCDs are numbered
+	 * with lowest being the most expensive time wise, ensuring that
+	 * those commands are being sent the earliest in the queue. This needs
+	 * to be sorted every commit since we can't guarantee the order in which
+	 * the BCMs are added to the list.
+	 */
+	list_sort(NULL, &voter->commit_list, cmp_vcd);
+
+	/*
+	 * Construct the command list based on a pre ordered list of BCMs
+	 * based on VCD.
+	 */
+	tcs_list_gen(voter, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
+	if (!commit_idx[0])
+		goto out;
+
+	for (int i = 0 ; commit_idx[i] ; ++i) {
+		ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE,
+				 &cmds[i], commit_idx[i]);
+		if (ret) {
+			pr_err("Error sending AMC RPMH requests (%d)\n", ret);
+			goto out;
+		}
+	}
+
+	/* TOFIX vote for WAKE & SLEEP ?? */
+
+out:
+	list_for_each_entry_safe(bcm, bcm_tmp, &voter->commit_list, list)
+		list_del_init(&bcm->list);
+
+	return ret;
+}
+
+static int qcom_icc_bcm_voter_probe(struct udevice *dev)
+{
+	struct bcm_voter *voter = dev_get_priv(dev);
+
+	voter->dev = dev;
+
+	if (dev_read_u32(dev, "qcom,tcs-wait", &voter->tcs_wait))
+		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
+
+	INIT_LIST_HEAD(&voter->commit_list);
+	INIT_LIST_HEAD(&voter->ws_list);
+
+	return 0;
+}
+
+static const struct udevice_id qcom_icc_bcm_voter_ids[] = {
+	{ .compatible = "qcom,bcm-voter" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_icc_bcm_voter) = {
+	.name		= "qcom_bcm_voter",
+	.id		= UCLASS_MISC,
+	.priv_auto	= sizeof(struct bcm_voter),
+	.probe		= qcom_icc_bcm_voter_probe,
+	.of_match	= qcom_icc_bcm_voter_ids,
+};
diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
new file mode 100644
index 00000000000..5acb5822e0e
--- /dev/null
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_BCM_VOTER_H__
+#define __DRIVERS_INTERCONNECT_QCOM_BCM_VOTER_H__
+
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+#include <soc/qcom/tcs.h>
+
+#include "icc-rpmh.h"
+
+struct bcm_voter *of_bcm_voter_get(struct udevice *dev, const char *name);
+void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
+int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
+
+#endif
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
new file mode 100644
index 00000000000..23b4f5e16c6
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025 Linaro Limited
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <interconnect-uclass.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <linux/err.h>
+#include <dm/device_compat.h>
+
+#include "icc-rpmh.h"
+#include "bcm-voter.h"
+
+static inline struct qcom_icc_provider *to_qcom_provider(struct udevice *dev)
+{
+	return dev_get_plat(dev);
+}
+
+static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	qp = to_qcom_provider(node->dev->parent);
+	qcom_icc_bcm_voter_commit(qp->voter);
+
+	return 0;
+}
+
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+
+	qn = node->data;
+
+	if (!tag)
+		tag = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		if (tag & BIT(i)) {
+			qn->sum_avg[i] += avg_bw;
+			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
+		}
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	return 0;
+}
+
+static void qcom_icc_pre_aggregate(struct icc_node *node)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+	struct qcom_icc_provider *qp;
+
+	qn = node->data;
+	qp = to_qcom_provider(node->dev->parent);
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		qn->sum_avg[i] = 0;
+		qn->max_peak[i] = 0;
+	}
+
+	for (i = 0; i < qn->num_bcms; i++)
+		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
+}
+
+static struct icc_node *qcom_icc_xlate(struct udevice *dev,
+				       const struct ofnode_phandle_args *spec)
+{
+	struct icc_provider *priv = dev_get_uclass_plat(dev);
+	unsigned int idx = spec->args[0];
+
+	if (idx >= priv->xlate_num_nodes) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return priv->xlate_nodes[idx];
+}
+
+struct interconnect_ops qcom_icc_rpmh_ops = {
+	.set = qcom_icc_set,
+	.pre_aggregate = qcom_icc_pre_aggregate,
+	.aggregate = qcom_icc_aggregate,
+	.of_xlate = qcom_icc_xlate,
+};
+
+/**
+ * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
+ * @bcm: bcm to be initialized
+ * @dev: associated provider device
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct udevice *dev)
+{
+	struct qcom_icc_node *qn;
+	const struct bcm_db *data;
+	size_t data_count;
+	int i;
+
+	/* BCM is already initialised*/
+	if (bcm->addr)
+		return 0;
+
+	bcm->addr = cmd_db_read_addr(bcm->name);
+	if (!bcm->addr) {
+		dev_err(dev, "%s could not find RPMh address\n",
+			bcm->name);
+		return -EINVAL;
+	}
+
+	data = cmd_db_read_aux_data(bcm->name, &data_count);
+	if (IS_ERR(data)) {
+		dev_err(dev, "%s command db read error (%ld)\n",
+			bcm->name, PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+	if (!data_count) {
+		dev_err(dev, "%s command db missing or partial aux data\n",
+			bcm->name);
+		return -EINVAL;
+	}
+
+	bcm->aux_data.unit = le32_to_cpu(data->unit);
+	bcm->aux_data.width = le16_to_cpu(data->width);
+	bcm->aux_data.vcd = data->vcd;
+	bcm->aux_data.reserved = data->reserved;
+	INIT_LIST_HEAD(&bcm->list);
+	INIT_LIST_HEAD(&bcm->ws_list);
+
+	if (!bcm->vote_scale)
+		bcm->vote_scale = 1000;
+
+	/* Link Qnodes to their respective BCMs */
+	for (i = 0; i < bcm->num_nodes; i++) {
+		qn = bcm->nodes[i];
+		qn->bcms[qn->num_bcms] = bcm;
+		qn->num_bcms++;
+	}
+
+	return 0;
+}
+
+int qcom_icc_rpmh_probe(struct udevice *dev)
+{
+	struct qcom_icc_provider *qp = dev_get_plat(dev);
+	int i;
+
+	qp->voter = of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter))
+		return PTR_ERR(qp->voter);
+
+	for (i = 0; i < qp->desc->num_bcms; i++)
+		qcom_icc_bcm_init(qp->desc->bcms[i], dev);
+
+	return 0;
+}
+
+int qcom_icc_rpmh_bind(struct udevice *dev)
+{
+	struct icc_provider *priv = dev_get_uclass_plat(dev);
+	struct qcom_icc_provider *qp = dev_get_plat(dev);
+	struct qcom_icc_node * const *qnodes, *qn;
+	struct icc_node *node;
+	size_t num_nodes, i, j;
+
+	qp->desc = (const struct qcom_icc_desc *)dev_get_driver_data(dev);
+	if (!qp->desc)
+		return -EINVAL;
+
+	qnodes = qp->desc->nodes;
+	num_nodes = qp->desc->num_nodes;
+
+	priv->xlate_num_nodes = num_nodes;
+	priv->xlate_nodes = calloc(sizeof(node), num_nodes);
+	if (!priv->xlate_nodes)
+		return -ENOMEM;
+
+	qp->dev = dev;
+
+	for (i = 0; i < num_nodes; i++) {
+		qn = qnodes[i];
+		if (!qn)
+			continue;
+
+		node = icc_node_create(dev, qn->id, qn->name);
+		if (IS_ERR(node))
+			return PTR_ERR(node);
+
+		node->data = qn;
+
+		for (j = 0; j < qn->num_links; j++)
+			icc_link_create(node, qn->links[j]);
+
+		priv->xlate_nodes[i] = node;
+	}
+
+	return 0;
+}
+
+int qcom_icc_rpmh_unbind(struct udevice *dev)
+{
+	struct icc_provider *priv = dev_get_uclass_plat(dev);
+
+	free(priv->xlate_nodes);
+
+	return 0;
+}
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
new file mode 100644
index 00000000000..95421d61033
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
+#define __DRIVERS_INTERCONNECT_QCOM_ICC_RPMH_H__
+
+#include <dt-bindings/interconnect/qcom,icc.h>
+
+/**
+ * struct qcom_icc_provider - Qualcomm specific interconnect provider
+ * @dev:
+ * @desc:
+ */
+struct qcom_icc_provider {
+	struct udevice *dev;
+	const struct qcom_icc_desc *desc;
+	struct bcm_voter *voter;
+};
+
+/**
+ * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
+ * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
+ * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
+ * @vcd: virtual clock domain that this bcm belongs to
+ * @reserved: reserved field
+ */
+struct bcm_db {
+	__le32 unit;
+	__le16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
+#define MAX_PORTS		2
+
+#define MAX_LINKS		128
+#define MAX_BCMS		64
+#define MAX_BCM_PER_NODE	3
+#define MAX_VCD			10
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @links: an array of nodes where we can go next while traversing
+ * @id: a unique node identifier
+ * @link_nodes: links associated with this node
+ * @node: icc_node associated with this node
+ * @num_links: the total number of @links
+ * @channels: num of channels at this node
+ * @buswidth: width of the interconnect between a node and the bus
+ * @sum_avg: current sum aggregate value of all avg bw requests
+ * @max_peak: current max aggregate value of all peak bw requests
+ * @bcms: list of bcms associated with this logical node
+ * @num_bcms: num of @bcms
+ */
+struct qcom_icc_node {
+	const char *name;
+	u16 links[MAX_LINKS];
+	u16 id;
+	struct qcom_icc_node **link_nodes;
+	struct icc_node *node;
+	u16 num_links;
+	u16 channels;
+	u16 buswidth;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
+	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
+	size_t num_bcms;
+};
+
+/**
+ * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
+ * known as Bus Clock Manager (BCM)
+ * @name: the bcm node name used to fetch BCM data from command db
+ * @type: latency or bandwidth bcm
+ * @addr: address offsets used when voting to RPMH
+ * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
+ * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
+ * @vote_scale: scaling factor for vote_x and vote_y
+ * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
+ * @dirty: flag used to indicate whether the bcm needs to be committed
+ * @keepalive: flag used to indicate whether a keepalive is required
+ * @aux_data: auxiliary data used when calculating threshold values and
+ * communicating with RPMh
+ * @list: used to link to other bcms when compiling lists for commit
+ * @ws_list: used to keep track of bcms that may transition between wake/sleep
+ * @num_nodes: total number of @num_nodes
+ * @nodes: list of qcom_icc_nodes that this BCM encapsulates
+ */
+struct qcom_icc_bcm {
+	const char *name;
+	u32 type;
+	u32 addr;
+	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_scale;
+	u32 enable_mask;
+	bool dirty;
+	bool keepalive;
+	struct bcm_db aux_data;
+	struct list_head list;
+	struct list_head ws_list;
+	size_t num_nodes;
+	struct qcom_icc_node *nodes[];
+};
+
+struct qcom_icc_fabric {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+struct qcom_icc_desc {
+	const struct regmap_config *config;
+	struct qcom_icc_node * const *nodes;
+	size_t num_nodes;
+	struct qcom_icc_bcm * const *bcms;
+	size_t num_bcms;
+	bool qos_requires_clocks;
+	bool alloc_dyn_id;
+};
+
+extern struct interconnect_ops qcom_icc_rpmh_ops;
+int qcom_icc_rpmh_probe(struct udevice *dev);
+int qcom_icc_rpmh_bind(struct udevice *dev);
+int qcom_icc_rpmh_unbind(struct udevice *dev);
+
+#endif

-- 
2.34.1

