Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB683606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pm+oxVSA;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=y06NOYpE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7DB440A0D;
	Wed, 18 Nov 2026 13:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3cz-z8Pvpqy; Wed, 18 Nov 2026 13:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D966A409ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007929;
	b=AQv094pnlkPSK+wjUquzs7v1vPlBryaNMo/gKhb+XD4/rfQGe7tcbNcLWAl7kpLC8Ljt
	 LsSny9gtu5pdOJx9Qi2U81d7DCI2mArmvQKht7rBkIhmpWlxGvAenZckqHyxnOIaqbjyW
	 FnqZxr0v6PtdpTuPhkbrm5gRhgHQNANmgcI/bEDe+GFWLL8Nm3S7nA7WXzdJcc6MaJ6dv
	 dj2ER6I6D4SgrOzwGruerp6s+4kDlQKk7JL82ilNQuPS6m277u7UTwrqsAe28sPtKhf9l
	 iTX8yXDnqlkub5WsxQqfgeDnKRvoTkDgjX0QMP7Ae0xCYGh8zxd6H3kZXuJKmLicHWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Zq58mLGvVNaQN8zSHZcQ4IMLOOY2jtx834LpFMJeop4=;
	b=ahc01MZa3/NYAC/6iRJ/Qthk7207egrx3+JTEXbYYp3xG/9ejdzLvHYUDaa1AjUsgnXn
	 OiWUwOc83OuV/klUUGaexPqS+VYdCcS6X+tumZqyjGID8ivTCIVSQrQIfB+5WYO0VCldl
	 24fUj74+w+z1+KSpzc4kS8s7PDk/eXkPvizaPgGyodhrUpH4a08xVmdoCBzAYufqWevyn
	 RP5apBIaWfuwkjlS5jwio8y6Nam/J7hbC4do1uwjlZoe8aEC2ruy8HYeir5g6LPE/C3qP
	 8dnI/dRVY7Uor+M1Zz47/Vy+CEnUinPoqm662PnGlPhiYVGzyoIix2Xh35K+OLP8E2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007929;
	bh=Zq58mLGvVNaQN8zSHZcQ4IMLOOY2jtx834LpFMJeop4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pm+oxVSA5pAMqaK+lrpsipFRg5cCA7O1DvVYX00Exk198gMX27iz5+p8O+69HkFNy
	 iRhFBHqspaSQiH3KEsjfZZmway4K4Ko2JfbhhUMxrN2GpJ0Hl+HvWyiq4d1S2Kn45V
	 kMkvWTX5Xb+nq/b5pVgmEhkmYtbBIIBU8d33soqCtnwOkt0QlaS70qkXWfBvnIhABE
	 /LaTQiiTvkl8g2Cm2/6GCBARObB5kRa3zbBYcYeDvGH1p6tqVffyhd2jCJXmxDIDD3
	 AiabAA68SbNHccjGdyYWB+SIdGDlz8ZQY1x9PdMewqwCscBB7lcusScoe3PMTKqBTf
	 E0IGZdOMRHMfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D966A409ED;
	Wed, 18 Nov 2026 13:18:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 00F1161
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2DD340486
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1H2ZjVsA0ZRP for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9887C40481
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=y06NOYpE
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9887C40481
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2F9614E41627;
 Wed, 18 Nov 2026 13:18:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EFB625FE9B;
 Wed, 18 Nov 2026 13:18:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 53BE111BC1D4D; Wed, 18 Nov 2026 14:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007919; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Zq58mLGvVNaQN8zSHZcQ4IMLOOY2jtx834LpFMJeop4=;
 b=y06NOYpEMobRl6UavtmF98i+efKYT7CUj6bNhRY2/GoBGbCcSEQjm00DCSXbNYYrZ65GuS
 FuWLh4VVPSCMhVbg5qoOjyP2OaFmlzLdaSsiUdnOYbj9wBVS0tyC9CQjwnjtzJmT6jbe9i
 IeB9X5/wemXREiINrT1/qSDQvBlk4/yTCwub3uNG1V+4j/p6NCSqmLaYd2KtZRKPUv0ouy
 OdMKXRxZHFneefrEXeCf1Ami2OAjFf7ANkxzLKl65NO6kULdeNwZJVyXPkuOOpk1P/+6gr
 X53Q28oyeu1WZylRu4bdreESygLqyB9CYHOMgwC18QZv/XmXxolUNl2PbbRnbw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v7 05/20] mach-k3: r5: common: introduce k3_deassert_ddr_ret()
Date: Wed, 18 Nov 2026 14:17:52 +0100
Message-ID: <20261118131807.135859-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Deasserting DDR retention pin is quite similar from J7200, J784s4
and j721s2 SoCs.

Instead of duplicating almost the same code, add it in lpm-common.c.

NB: On J7200, there's a latch, so the clock needs to be toggled.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/lpm-common.h    |  2 ++
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
index 27a27065442c..17352b06353f 100644
--- a/arch/arm/mach-k3/lpm-common.h
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -15,6 +15,8 @@
 void __noreturn do_resume(void);
 void lpm_process(void);
 int save_lpm_region_idx(unsigned int image_id, unsigned long image_start);
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle);
 void k3_set_lpm_core_bus_node_path(const char *node_path);
 void k3_set_lpm_core_compatible(const char *compatible);
 #else
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 5d484f6df037..f1d16f38157f 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -46,6 +46,33 @@ enum k3_resume_state {
 	K3_RESUME_STATE_RESUMING
 };
 
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
 bool j7xx_board_is_resuming(void)
 {
 	static enum k3_resume_state k3_resuming;
