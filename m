Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13552606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bpY91YgN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMgrZiq4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEAA940E66;
	Sat, 14 Nov 2026 04:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfb4WCYyjGoW; Sat, 14 Nov 2026 04:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8119640DE9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629108;
	b=RAAkrqDqRxvkbCuKtr/aTQIRsnLBk9p3CKn5jr1sbV1WgTiKmPBBptKZQLFnlG+b0MSm
	 9T9oJLNy4POnQzB5XoDbWqkhpu4biUlJCNjtNxfFntG5Q2Axvw17yVkMem5So/Bu/uyAp
	 a+hbNCxQVNWar5hS94TrGu4BANqggOH8KUAlnwQND6zBVlbaHp2JH4FGlqoI70c9qTlMT
	 MEM8M3I2rpvINhn5JkGtkdU2Rk9c2FTygZfmrPoglSGIa54M1vpxLS4alOU8GriMMM1je
	 Rbta/6zStCRbDhoevw66BWkQJrQXPCmQPrr+dHYaQvm85hD49lTwDu1tjtHcv9f2bdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=8kq25ta6GPtV9B9v8TOEV+GVApYM9uiLNgODuEeKcx4=;
	b=c3bVk3ikIJaR06qKt7oT9UscLtOqnBfIFjk/Uz2mn1HY29KOq5fJ/m15UmAp7gdyDB66
	 24sSlRFGIUSUQmgMl67OffSed8Zcj7VgY9Np6xC1rbASoMfSI+Qv45C+47BiY/DtBXQmW
	 Uz0o3Zt/EIWMeSBiBrXgXaXhuoUjjQZUbU1dHNJIjxhWUQxBOa+0udX7mF13fiooB30IJ
	 2UsI10cedqhdeRl1I7jR1J0+OuMHZ40nZ7gCx3tO3HEpq2g6mAUgyxLKjj8VAXnhWgu/O
	 QlSA1SXP6H3fm0C900DahygGETZVg6cG/yCSxdlAaS+DRSbjwXpaHB2+77rSdbcyysg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629108;
	bh=8kq25ta6GPtV9B9v8TOEV+GVApYM9uiLNgODuEeKcx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bpY91YgNkP3rGhTIl3sm5F0bfhJGajB2A8kzxP/n+CPber4iALvk1C0eQkkqcnEJv
	 OVJYLDLVi3oEPitGAZVvbQ7K1wYOC0n01P1RkhwLHtrRwBKf6jXBWeucQ0lqU2hNjO
	 0dxMxoslu2rKlFpp5UiweDs3XFGrBO7lF0PnbW9HPSLgom7yglwiyoiiOdeoKKyEll
	 IcCKZy1pLsH6y/kqDstpyYSkvxJQiKTTuW1TIttzHxxunFKrl1QHmH0x5i4s4ZaA/b
	 H9sncUVP3AG7SJcpVX0MW5jscxcz+3WqB2riBkTQmHJyb1C6ivUzs81GN8n0V4hKyi
	 DbXwTUVfYcRvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8119640DE9;
	Sat, 14 Nov 2026 04:05:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4E6A150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA9DA81779
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_TSTD66SBlw for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A370C81774
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YMgrZiq4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A370C81774
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE0A546391;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0C84F1F000C7;
 Sat, 14 Nov 2026 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622936;
 bh=8kq25ta6GPtV9B9v8TOEV+GVApYM9uiLNgODuEeKcx4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YMgrZiq4xlapftxtIX5qZsYccCb0Q4LjjQIhTUui7H3PRd7q7u+FgW9px+QTSO/b9
 wIXq29tHh4mDIRDc8nF/5xWd6BL/jhmTJrSU+jJHltjyMFQgPV8J8d0TB5Cl1TxFwN
 l2+hatd0yZOzONGqqFtUW6sGoYq2iKiZdt6CNdOpd/WF0x1K6GigDdS+sP6CKDmdQ8
 9Yu2wrt/YSCibX5FbAO6yDV2Tisx2FxwVRQ8UrW7kXdDzPb3VkXCICweokrqdEu/Vp
 NgSdSU+NMvcxrB6s4V1y+cwA8P9/i12sNpO4clOl8Flfo3lu+Q+WQqodE270j4xI4b
 z9ebyftAvXWjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8C08449C2B;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:21:57 +0000
Subject: [PATCH 3/9] interconnect: qcom: Add SM8350 interconnect driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-3-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=9700;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=Y/9S1F4K86ewGZ32pcgQfy1f16WZQerIRRZt0CQBHNA=;
 b=oxhew4EGDD8fFXGSEYSCuGVgVXphoc5fegJ+e3RAg9pnSWJdqJ9wak/0Ji01D0Cpi7brpE2nP
 HgPMusYYxqLDJmV0RDfe+L3d89yxyactrmVpi4pfJ9mA5PPxCAXfuUU
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Add the interconnect (NoC) driver for SM8350 with the nodes of the two
UFS paths, the only ones U-Boot requests, as the QCS8300 driver has
them.

Taken from Linux's drivers/interconnect/qcom/sm8350.c (tag v7.4-rc1).

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/interconnect/qcom/Kconfig  |   7 +
 drivers/interconnect/qcom/Makefile |   1 +
 drivers/interconnect/qcom/sm8350.c | 271 +++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8350.h |  25 ++++
 4 files changed, 304 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 4123a1d224..6a030a7891 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -17,6 +17,13 @@ config INTERCONNECT_QCOM_QCS8300
 	help
 	  Enable support for the interconnect driver for the QCS8300 SoC.
 
+config INTERCONNECT_QCOM_SM8350
+	bool "Enable interconnect support for SM8350 SoC"
+	depends on INTERCONNECT_QCOM_RPMH
+	help
+	  Enable support for the interconnect driver for the SM8350 SoC.
+	  It has the nodes of the UFS paths.
+
 config INTERCONNECT_QCOM_SM8650
 	bool "Enable interconnect support for SM8650 SoC"
 	depends on INTERCONNECT_QCOM_RPMH
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ac6b8cee19..c4b38d13a0 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SC7280) += sc7280.o
+obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8350) += sm8350.o
 obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
new file mode 100644
index 0000000000..71423c9b22
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#include <dm.h>
+#include <interconnect-uclass.h>
+#include <dt-bindings/interconnect/qcom,sm8350.h>
+
+#include "icc-rpmh.h"
+#include "sm8350.h"
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM8350_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SM8350_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_UFS_MEM_CFG },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM8350_MASTER_APPSS_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM8350_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM8350_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM8350_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM8350_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM8350_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SM8350_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM8350_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_LLCC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM8350_SLAVE_EBI1,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM8350_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8350_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = BIT(3),
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 1,
+	.nodes = { &qhs_ufs_mem_cfg },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.num_nodes = 1,
+	.nodes = { &chm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc sm8350_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const config_noc_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const config_noc_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+};
+
+static const struct qcom_icc_desc sm8350_config_noc = {
+	.nodes = config_noc_nodes,
+	.num_nodes = ARRAY_SIZE(config_noc_nodes),
+	.bcms = config_noc_bcms,
+	.num_bcms = ARRAY_SIZE(config_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh4,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+};
+
+static const struct qcom_icc_desc sm8350_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc sm8350_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn7,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc sm8350_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct udevice_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sm8350-aggre1-noc", .data = (ulong)&sm8350_aggre1_noc },
+	{ .compatible = "qcom,sm8350-config-noc", .data = (ulong)&sm8350_config_noc },
+	{ .compatible = "qcom,sm8350-gem-noc", .data = (ulong)&sm8350_gem_noc },
+	{ .compatible = "qcom,sm8350-mc-virt", .data = (ulong)&sm8350_mc_virt },
+	{ .compatible = "qcom,sm8350-system-noc", .data = (ulong)&sm8350_system_noc },
+	{ }
+};
+
+U_BOOT_DRIVER(qnoc_sm8350) = {
+	.name = "qnoc-sm8350",
+	.id = UCLASS_INTERCONNECT,
+	.of_match = qnoc_of_match,
+	.probe = qcom_icc_rpmh_probe,
+	.bind = qcom_icc_rpmh_bind,
+	.unbind = qcom_icc_rpmh_unbind,
+	.ops = &qcom_icc_rpmh_ops,
+	.plat_auto = sizeof(struct qcom_icc_provider),
+};
diff --git a/drivers/interconnect/qcom/sm8350.h b/drivers/interconnect/qcom/sm8350.h
new file mode 100644
index 0000000000..580b139185
--- /dev/null
+++ b/drivers/interconnect/qcom/sm8350.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SM8350 interconnect IDs
+ *
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8350_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM8350_H
+
+#define SM8350_MASTER_UFS_MEM		0
+#define SM8350_MASTER_GEM_NOC_CNOC	1
+#define SM8350_MASTER_APPSS_PROC	2
+#define SM8350_MASTER_SNOC_SF_MEM_NOC	3
+#define SM8350_MASTER_LLCC		4
+#define SM8350_MASTER_A1NOC_SNOC	5
+#define SM8350_SLAVE_A1NOC_SNOC		6
+#define SM8350_SLAVE_UFS_MEM_CFG	7
+#define SM8350_SLAVE_GEM_NOC_CNOC	8
+#define SM8350_SLAVE_LLCC		9
+#define SM8350_SLAVE_EBI1		10
+#define SM8350_SLAVE_SNOC_GEM_NOC_SF	11
+
+#endif

-- 
2.53.0


