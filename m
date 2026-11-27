Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCB606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DP1f8D7R;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=V1096VA4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85C2140A40;
	Fri, 27 Nov 2026 12:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QM3knZRcBCyt; Fri, 27 Nov 2026 12:56:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57E0740A9A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784208;
	b=BpPqc2RovrS1YNSLAVBCRnl5xPmggXLyyRNEEO1NWmofseneVHISZ8lVi5y+6lBfO1BN
	 0Gw5NuEWcUVxf3YeeAnapn0vaKbZvR5YJWzY7UTrqslkSdhfQQxCHEWBsDzVhCGdkB1Ac
	 ay1iNaHRlfU6UE+/vn57HY+twZUTqj7X7HDNNyooGXTE5x3Dn+/ImEGVff91deL6C5gTk
	 jp5aY3nO9LEr5/rWY6aEysHfZh1e9YT8FudD84/ex9JtPFornz6u0g3TsnZw14Bg8oigo
	 JD6+X9FRXfo5Fh+MQTWfgClWw99luHTXC3im3kvvCGlySF40ROsHMbPwz4FXsuG3k8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yiiHctjgrVq/UhKFOC5XbKD7Jksf+UeknV8A16tOY1I=;
	b=oaFRYYeDqukv9cyogknkAaI5lIEcm0Pl8ewOE/vGWshPksrsNtlMvIKgJLcqHSu03Wqu
	 L238F1iJM2m7dWojb1WXaoQ2t/NYgy1FLTTNAVPcNYlXBbs2XjsrV+/BsDjCUaEqi6dDx
	 WXp7KH0qltpLyukMgfr5oqAue7F+Lj/2Z5RRU8rBYnDCAMCbWa+cFQFMsRJPiqC8f1X3L
	 Oi4ljtX9w8o/Z/ISxLi5yFEN37Y38xTUnRGNs6S3cGutYs048AQcGmkkZGLN5PYIuhAQh
	 2kbC4osw5CKdISybCIzpIhp/C9Bpn1HYyiTTtI6wD80ItkLNZHE9ntjKCrBa1NSK9AA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784208;
	bh=yiiHctjgrVq/UhKFOC5XbKD7Jksf+UeknV8A16tOY1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DP1f8D7RpPAZxN8HE7ZTtGn4g7E+t2PKBM5PmKgXglbtbMVmNsQMlN8ezsNx/1dqN
	 I/SJdIoxkmqi+N0/mAIQ0qQ+d6KY+KrgEISJlG4mtS73+vJhCHdWwKbWYXQAJaYm24
	 2YYhtJWTanGuR/RyrM28ilZnQ6R2gw/vrF2fSC9MoBHYfP1jRQ61Ivb9oAk31XZAY3
	 bSCmYqNofKoINwW0FFn4wtUn1sMnKBpxSs1KWJcQ5wJ49zjebh9Jb1rppRo+0+ppof
	 v9Dzf48UpdB1Kv8R51e44Zwl/aujUIX4EzAr4JFWLOWUQhc2NqX+EXgjpOAxk3/oUC
	 R+xwAf+lll3JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57E0740A9A;
	Fri, 27 Nov 2026 12:56:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC9F6D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2D72400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q05mtzUzu3az for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A27334004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=V1096VA4
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A27334004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yiiHctjgrVq/UhKFOC5XbKD7Jksf+UeknV8A16tOY1I=; b=V1096VA4K+P5YhwcpsVrfsiY8A
 RR5g8RQ6O2WqBqa3TIcVHk+IEocTOPx8zPfw7FxKZj+Ou1RZcYPrgMzBzz05nrVvh7gJnte49FY/c
 8kfa1O/3OV2cBERp33Z6/Xg1l7hsa9jqalu6cbKqjP234ThTtp+MzGMnThY8tyXSXJG0pcpML25IM
 OUJQEv6Si5lIRi0tpMiyIeq7zGbHvxEl6yl5eaJQTOIiyBh8XgFXWIKUn3uVwBbRdx5hjwpAYQIq5
 AgdmX3OpmRbtL11xBv+TVmMnd0JxDzUXZD1l4pwv6sC/v6goipWv8E1ZEVeTmpHHbQCLNY/FNbmpf
 Anq6eulg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV5-0006OI-0O; Fri, 27 Nov 2026 13:56:27 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV4-0003Uw-1W; Fri, 27 Nov 2026 13:56:26 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Fri, 27 Nov 2026 13:56:26 +0100
Subject: [PATCH v2 6/6] board: tqma6: add support for variants with
 i.MX6DP/QP CPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-update-tqma6-v2-6-3465ac0d32eb@ew.tq-group.com>
References: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
In-Reply-To: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Since the ENET erratum is fixed in silicon, this SoM variant comes
in only one flavour with 1 GiB of RAM.

Add Kconfig entries, RAM configuration, and boilerplate code.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/dts/imx6qp-mba6b-u-boot.dtsi |   8 ++
 board/tq/tqma6/Kconfig                |   9 ++-
 board/tq/tqma6/Makefile               |   1 +
 board/tq/tqma6/spl_tqma6qp_ram.c      | 148 ++++++++++++++++++++++++++++++++++
 board/tq/tqma6/tqma6.c                |   6 ++
 board/tq/tqma6/tqma6_mba6.c           |   2 +-
 configs/tqma6qp_mba6_defconfig        |   6 ++
 configs/tqma6qp_mba6_uuu_defconfig    |   2 +
 8 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx6qp-mba6b-u-boot.dtsi b/arch/arm/dts/imx6qp-mba6b-u-boot.dtsi
new file mode 100644
index 00000000000..d484a5dda00
--- /dev/null
+++ b/arch/arm/dts/imx6qp-mba6b-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index ab327c74730..4a86d54b4f9 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -26,6 +26,13 @@ config TQMA6Q
 	  select TQMa6Q / TQMa6D variant with i.MX6Q resp. i.MX6D
 	  with 1GiB or 2GiB DRAM
 
+config TQMA6QP
+	bool "TQMaQP / TQMaDP"
+	depends on MX6Q
+	help
+	  select TQMa6QP / TQMa6DP with i.MX6QP/DP
+	  with 1GiB DRAM
+
 config TQMA6DL
 	bool "TQMa6DL"
 	depends on MX6DL
@@ -82,7 +89,7 @@ endchoice
 
 config TEXT_BASE
 	default 0x2fc00000 if TQMA6S
-	default 0x4fc00000 if TQMA6Q || TQMA6DL
+	default 0x4fc00000 if TQMA6Q || TQMA6QP || TQMA6DL
 
 config SPL_TEXT_BASE
 	default 0x00908000
diff --git a/board/tq/tqma6/Makefile b/board/tq/tqma6/Makefile
index c29720341ff..73c56b7fb2c 100644
--- a/board/tq/tqma6/Makefile
+++ b/board/tq/tqma6/Makefile
@@ -12,6 +12,7 @@ ifdef CONFIG_SPL_BUILD
 obj-y += spl_tqma6.o
 obj-$(CONFIG_TQMA6DL) += spl_tqma6dl_ram.o
 obj-$(CONFIG_TQMA6Q) += spl_tqma6q_ram.o
+obj-$(CONFIG_TQMA6QP) += spl_tqma6qp_ram.o
 obj-$(CONFIG_TQMA6S) += spl_tqma6s_ram.o
 obj-$(CONFIG_MBA6) += spl_mba6.o
 endif
diff --git a/board/tq/tqma6/spl_tqma6qp_ram.c b/board/tq/tqma6/spl_tqma6qp_ram.c
new file mode 100644
index 00000000000..8dd1bf58ef3
--- /dev/null
+++ b/board/tq/tqma6/spl_tqma6qp_ram.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6q-ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+
+#include "../common/tq_som.h"
+
+static void tqma6qp_init_ddr_controller(void)
+{
+	debug("SPL: tqma6qp ddr iom ....\n");
+	/* TQMa6QP DDR config Rev. 0300D */
+	/* IOMUX configuration */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRPKE, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_0, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_1, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_CAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_GRP_ADDDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RESET, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE0, 0x00003000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE1, 0x00003000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDBA2, 0x0000B000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT0, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT1, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_GRP_CTLDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DDRMODE_CTL, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS4, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS5, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS6, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS7, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRMODE, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_B0DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B1DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B2DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B3DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B4DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B5DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B6DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B7DS, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM0, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM1, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM2, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM3, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM4, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM5, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM6, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM7, 0x00008030);
+
+	debug("SPL: tqma6qp ddr calibration ....\n");
+	/* memory interface calibration values */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00180016);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL1, 0x001F0018);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL0, 0x00130023);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL1, 0x00040018);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x43500364);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL1, 0x034C0344);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL0, 0x43580364);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL1, 0x033C031C);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x3C323438);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDLCTL, 0x383A3040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x3A3E4440);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWRDLCTL, 0x4834483A);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000800);
+
+	debug("SPL: tqma6qp ddr config ....\n");
+	/* configure memory interface */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00020036);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x09444040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x545A79B4);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xDB538F64);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+	debug("SPL: tqma6qp MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x005A1023);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
+
+	debug("SPL: tqma6qp ddr mdctl - leave reset\n");
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00488032);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00048031);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x19308030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x04008040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDREF, 0x00007800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00025536);
+	tq_som_init_write_reg(MX6_MMDC_P0_MAPSR, 0x00001006);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00000000);
+
+	/* wait for auto-ZQ calibration to complete */
+	mdelay(1);
+	debug("SPL: tqma6qp ddr init done ...\n");
+}
+
+void tq_som_ram_init(void)
+{
+	if (!is_mx6dqp()) {
+		printf("Not running on TQMa6DP/QP\n");
+		hang();
+	}
+
+	tqma6qp_init_ddr_controller();
+
+	if (tq_som_ram_check_size(SZ_1G)) {
+		debug("SPL: TQMa6DP/QP ddr init done ...\n");
+	} else {
+		pr_err("ERROR: Invalid DDR RAM size\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index f0f2ddfe48a..dc43674e835 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -97,6 +97,8 @@ const char *tqma6_get_fdt_configuration(void)
 
 	if (is_mx6dq())
 		return !tqma6_has_enet_workaround() ? "imx6q-mba6b" : "imx6q-mba6a";
+	if (is_mx6dqp())
+		return "imx6qp-mba6b";
 	if (is_mx6sdl())
 		return !tqma6_has_enet_workaround() ? "imx6dl-mba6b" : "imx6dl-mba6a";
 
@@ -144,8 +146,12 @@ static const char *tqma6_get_boardname(void)
 		return "TQMa6DL";
 	case MXC_CPU_MX6D:
 		return "TQMa6D";
+	case MXC_CPU_MX6DP:
+		return "TQMa6DP";
 	case MXC_CPU_MX6Q:
 		return "TQMa6Q";
+	case MXC_CPU_MX6QP:
+		return "TQMa6QP";
 	default:
 		return "??";
 	};
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index e8d166dfef1..136c75b6dc8 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -70,7 +70,7 @@ static void mba6_setup_iomuxc_enet(void)
 			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
 		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
 			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
-	} else if (is_mx6dq()) {
+	} else if (is_mx6dq() || is_mx6dqp()) {
 		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
 			     (void *)TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
 		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
diff --git a/configs/tqma6qp_mba6_defconfig b/configs/tqma6qp_mba6_defconfig
new file mode 100644
index 00000000000..23d2bc48f6e
--- /dev/null
+++ b/configs/tqma6qp_mba6_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6_mba6_common.config>
+
+CONFIG_MX6Q=y
+CONFIG_TQMA6QP=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6qp-mba6b"
+
diff --git a/configs/tqma6qp_mba6_uuu_defconfig b/configs/tqma6qp_mba6_uuu_defconfig
new file mode 100644
index 00000000000..e20d231cda2
--- /dev/null
+++ b/configs/tqma6qp_mba6_uuu_defconfig
@@ -0,0 +1,2 @@
+#include <configs/tqma6qp_mba6_defconfig>
+#include <configs/tqma6_mba6_uuu.config>

-- 
2.53.0

