Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F09DC61DD3
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 389D280F71;
	Fri, 28 Aug 2026 13:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elk09ykECtbj; Fri, 28 Aug 2026 13:58:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925510;
	bh=zeHvJI0vlSOr2Y8iNyql4j6JU9YP1TAKhE49d9+azL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EUT/TirZAWJNytv9wNpAwoEp+9RcEU/4fN6dZjYdK61hnAOHRX2ddHrMwR7qzzYzR
	 Ryvv6O7ouXWfqKPKdZsIK0+pe4HPnN3WSaJFilP3qa046fZyRi3mQq+gcOFV9H7ybx
	 MkfckBfMqf2taK+LFu71Vab1u4kZRBMCHRjT5OQNDkpGwn3prRb5h4WI6ULBfU34XG
	 R1opOdCLtIUpcgZSdtVeG7o6nXgu4b7xnu+l+7QTYjizCQ4bFqWm9QT5uTCnyQpllG
	 qTa6RExG7ZOozn8zG81LdtlAn/bKqixbGrreM45tz/XSqR82gwLUk1E3CAqXh+Fq/A
	 Pz9bHmS7320oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83C3A80F72;
	Fri, 28 Aug 2026 13:58:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C548378B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B71EA40871
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4URfvSbvSN9 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Y3Box2b9
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A15740861
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 03E224E41401;
 Fri, 28 Aug 2026 13:58:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C690160537;
 Fri, 28 Aug 2026 13:58:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C891F11C781DF; 
 Fri, 28 Aug 2026 15:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925503; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=zeHvJI0vlSOr2Y8iNyql4j6JU9YP1TAKhE49d9+azL8=;
 b=Y3Box2b9tayqMCU7roI+NEh/xDwCXtUyrViMGQoW+r+XrlAi4twx7C9LxDkpzClyHLQfoD
 N7k1l7jIeT/J+oxPSg0vtTBTq32pjhm36LVfkbYC65Kx/AHrBNXvmRyJKOqz2Js+mRh2g/
 34NKoJEqftHFgm04El4hF0/h6VKJZ51CWL+lm/jXEzYikMRg00okpRB8QgOgLQPB5tljNf
 zK7vrKaiv9GGj+RG1XIZTq37nQKpimxMWoF2eXZCA/qdKq2Us9Z8aucNE/G15jBNFPWACR
 Pa0KTkTcw/a1P7al4xA9wZZPxfHckqPy5Ry6nTaR/E/jRcogvERVCCNihZefiw==
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
Subject: [PATCH v5 11/21] board: mach-k3: r5: common: Set PMIC NSLEEP triggers
 bits at resume
Date: Fri, 28 Aug 2026 15:57:20 +0200
Message-ID: <20260828135730.1565643-12-richard.genoud@bootlin.com>
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

If we are resuming NSLEEP triggers bits of PMIC-A and PMIC-B shall be set
to prevent transition to S2R state while clearing interrupts.
For example PMIC RTC Linux driver accesses to interrupt registers, in this
case if NSLEEP triggers bits are not set it triggers a S2R transition.

Suggested-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 0e5feae6d12d..4b67b9417c29 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -29,6 +29,9 @@
 /* PMIC register where the magic value resides */
 #define K3_LPM_SCRATCH_PAD_REG_3 0xcb
 
+/* PMIC NSLEEP register */
+#define K3_LPM_NSLEEP_TRIGGER_REG 0x86
+
 /* Wake-up source IDs */
 #define K3_LPM_WAKE_SOURCE_MAIN_IO 0x80
 #define K3_LPM_WAKE_SOURCE_MCU_IO 0x81
@@ -161,6 +164,30 @@ bool j7xx_board_is_resuming(void)
 
 		if (ret)
 			printf("Failed to clean magic value for suspend detection in PMIC\n");
+
+		/*
+		 * Ensure that NSLEEP triggers bits are set to prevent a
+		 * suspend/resume transition when accessing PMIC interrupt
+		 * registers.
+		 */
+		if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
+			ret = dm_i2c_reg_write(pmic, K3_LPM_NSLEEP_TRIGGER_REG, 0x3);
+		} else {
+			struct udevice *pmic_b;
+
+			/* Some boards may have more than one pmic */
+			ret = uclass_get_device_by_name(UCLASS_PMIC, "pmic@4c", &pmic_b);
+			if (ret == 0) {
+				ret = pmic_reg_write(pmic_b, K3_LPM_NSLEEP_TRIGGER_REG, 0x03);
+				if (ret)
+					printf("Failed to set NSLEEP triggers bits on PMIC-B\n");
+			}
+
+			ret = pmic_reg_write(pmic, K3_LPM_NSLEEP_TRIGGER_REG, 0x3);
+		}
+		if (ret)
+			printf("Failed to set PMIC NSLEEP triggers. Spurious suspend/resume may happen.\n");
+
 		/*
 		 * For robustness, the DM should also clean the magic value at
 		 * startup.
