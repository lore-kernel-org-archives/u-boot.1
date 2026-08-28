Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA15C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DEE940884;
	Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUNWOVJvvxnF; Fri, 28 Aug 2026 13:58:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925498;
	bh=qn+LHlqrHSaCQUp7VxJLjqqRqCz4CNqcaJfx5sWLfpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zx+vs/Dm2wgtePFCIc6yPvP54oUrbl9CZ4dXC3FfzryXirx0cxMi3SRF4UThHgW3j
	 JVY3Zq2rye49IdDq1gHzVgy9F6uoytvp/brBnMvD7s25yZSze7NYXQxRJ7+ofl4bDE
	 bl/YzVfsyRgWCmP6jj/BxFg0TnhgIoexHyrPqrevbgkMu1kl474W0mYAmi2UVUWQL0
	 vbAtvbVKJMJ968NBVccSXMelPfwrY5Pi/GTw/1GxZgtka7Sa6eWbrNlShFX74vt0nq
	 aisok+biMiTUJeHQ/iwOtobXhyLh+XSALqTrTqt4s4S9xCZ0aLyzun4xaaQG6CoLTF
	 OksEsRvPaz9rA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2E0A40847;
	Fri, 28 Aug 2026 13:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C8E386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEB1880F5C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u1g41VivefCT for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=jrB5G9if
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB4F080F55
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 39BC34E41401;
 Fri, 28 Aug 2026 13:58:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0D0D460537;
 Fri, 28 Aug 2026 13:58:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 97B3611C7833A; 
 Fri, 28 Aug 2026 15:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925491; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=qn+LHlqrHSaCQUp7VxJLjqqRqCz4CNqcaJfx5sWLfpY=;
 b=jrB5G9ifTaXqNLWeP0wXEQPnolpwu7KGVtduQyUWCyQadq6panoCT4gHeJxWXd8kHwJPn6
 l7sQI+HAzfSk7C4eMPaLZANFt7mhJO0BtUHSuc3td8ktIKJeMH4Y4kY3RELj7Q5G/N0OAt
 Kjrj2i0dohdXhF0PgeiZrLg4E8bhlnzqmZqQPk0bheezBJu4HOdav2uMiAXhXsbo2tMxpE
 FQmgwXlRJv2wkK/3NwhSYs7FiOwsjBw1up9hSt4EJmF8Z9CRBMXQcZHe5B7ajLTUU14pnM
 Fn8YwSiZqvv+dFMlSBIiSMpXBWanhr6zEsglXs3vm8CSp0FmYx3kbl5+2iLnfw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 07/21] mach-k3: r5: common: introduce k3_deassert_ddr_ret()
Date: Fri, 28 Aug 2026 15:57:16 +0200
Message-ID: <20260828135730.1565643-8-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Deasserting DDR retention pin is quite similar from J7200, J784s4,
J721e, and j721s2 SoCs.

Instead of duplicating almost the same code, add it in lpm-common.c.

NB: On J7200, there's a latch, so the clock needs to be toggled.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/lpm-common.h    |  2 ++
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
index 83e0fdcca6ca..7dbe72ce129e 100644
--- a/arch/arm/mach-k3/lpm-common.h
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -11,6 +11,8 @@
 
 void __noreturn do_resume(void);
 void lpm_process(void);
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle);
 void k3_set_lpm_core_bus_node_path(const char *node_path);
 void k3_set_lpm_core_compatible(const char *compatible);
 
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index c1a8c8e940de..ab39ea0cd67d 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -41,6 +41,33 @@ struct lpm_addr_info {
 /* This is used by J722s */
 __weak void ctrl_mmr_unlock(void) { }
 
+#define GPIO_OUT_1 0x3D
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle)
+{
+	struct udevice *pmic;
+	int regval;
+	int err;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC, pmic_name, &pmic);
+	if (err) {
+		printf("Getting %s init failed: %d\n", pmic_name, err);
+		return;
+	}
+
+	/* Set DDR_RET Signal Low on PMIC */
+	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~ddr_ret_val;
+	pmic_reg_write(pmic, GPIO_OUT_1, regval);
+
+	if (toggle) {
+		/* Now toggle the CLK of the latch for DDR retention */
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+	}
+}
+
 /* in board_init_f(), there's no BSS, so we can't use global/static variables */
 bool j7xx_board_is_resuming(void)
 {
