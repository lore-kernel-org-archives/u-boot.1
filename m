Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B42C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8531C81DB4;
	Wed, 26 Mar 2025 18:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l7RtNyOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA3181CFD; Wed, 26 Mar 2025 18:40:50 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56D481951
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so30995f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743010847; x=1743615647; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RmqA50PCDppqH6GiGKSG3+l+ZThH5KEwpsHaK/l2KQM=;
 b=l7RtNyOq3+K2ssMkwSDjv2nUreWq3fffPmK5TBOllz8rgwJ6WuE3C3VkWNA4r27FpI
 HM0Cl3whYzaWxAsL4bzxopOde095XYPPwPMgsjB+CJYiCx3PNZuWsi/CaRQQ/yS0Txqk
 B4kmjwPqH3tC1Cymv5VtOjKlj6MCki2Dh9UGzYVJfCGJvqDtxZxKLQv4ued5v0H1by9z
 nqfh+LvzMHgfmP66Rjfz0XsHaYKYCIY7nRmda4gE9V55Thr/qcEg/UbM431Dixmxcy85
 0ZhJ1wq5DQjsqDXgCLNUIe3iVR0DKmDLILmvWmOMnS/sqcSlmJ51+T1Wnzj/+A+Jgva4
 4r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010847; x=1743615647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmqA50PCDppqH6GiGKSG3+l+ZThH5KEwpsHaK/l2KQM=;
 b=albWMkcpKsrqPWv2qZIrtS3VWPBUQZQidQAeunGGkqlc/T7UwKn8ggU9y5v6wOR18+
 hCsuo1uTyOfEpg2R5vtpe4wa5D91qpW9FRMJI4qy/WvfwIOWfOkhNT3W4XWWoETfS2D6
 WCwq9A333ZzFB4r7omKAu9b4ln4WYtJSHvPUqaVXJPYWEHjbtGIz+PPGa3Sc7woELMOM
 7+EvLaalf1HIZXnKjT2Bjx7ndguwMjQnCk53cinqoXfVoo7Id1ltwXqdGV01OvtVGayZ
 EwsiKZMQrJeywyMv4S+Vt4LL/jCsaHUtzzyXFLaZWRo6KqKndQZfvtjIgPX1Kza4qTwo
 4mvw==
X-Gm-Message-State: AOJu0YzbbB2qqYZefizWCqLDUQZ4IRlzuiXcdsEdqlVjaPy+oGZiJI37
 mO0r0x6IFy31Y/aGobhZmBtdgqkgDecrOJcnxjx+jt3tzZU9mV2Cbs8H69KNwuY=
X-Gm-Gg: ASbGncsW5S4Ma3BnauDG9v7t2SXy5uMOHKiFoHFRJnyNPkdrx2s10w7csjNcZWI6rZ2
 nxGDPEgiYwrscAbekGMHp1dJcoY7UpN/G2M4qka9aCRw/wBGGFTxkZokSC2gRGnHEObIAnuK2C6
 Q+duflbBW6W6tu9DGuZzn3Yzm40Wpe7Au3Xmi5H36VzC1V1SGPmaUA7qLonStxKobo6hiPeittS
 W+MDDM9qhlJa4l2oO0Ll+nrmpvY8vd7DCI1kizgJsQ0ymILb+4nbkRpPlU5oFzjtCF8vYKNuYbv
 sTYbkqp+sHgTMufBOCUAfPT54kZ9YtDQoxZzSzjz4wKzDJyUbyodNyus1OjIKChXlEaBfUaS9es
 IEYxyVpMPQxu4
X-Google-Smtp-Source: AGHT+IEdk8O2qXsUxXEYtU6OElkV168vPovRTPMNwFFoKsv9uea9Ucs2/Zjb6uNf+JzoMtzrwnz/5g==
X-Received: by 2002:a05:6000:1fa1:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-39ad17979e2mr245855f8f.49.1743010847187; 
 Wed, 26 Mar 2025 10:40:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm17397321f8f.9.2025.03.26.10.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:40:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 18:40:34 +0100
Subject: [PATCH 1/4] mach-snapdragon: track boot source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-b4-qcom-capsule-update-improvements-v1-1-afe2e3696675@linaro.org>
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=9/IPLkaPm9HY3mq3N3ogOIhYVqL1ygq2C0t1I6Hslso=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn5DwbJ7jRYBL0lCUT9jZRImfJukNXMDsXipTlc
 tVOfqx4w3eJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Q8GwAKCRAFgzErGV9k
 toXgD/9C5ycwn/GOzmQGe5faV0JBiDQyDfPhh9ZrOjhfj+JNUbs06iq2n4wHKWzchc8HStKdCiA
 ybg8nVciSAEMi8Khi3zqM1UKdkpb6eabqpU03uCOOnj/lRtstPnXNDYdT+Pv/6liGX2hj/O4CFZ
 SxpS4ytBSnVUwFEv4y+0LzA71gmNwtHc7S711UIBVHrUq9VRS8AeX8lNh3H+3TnXNmUIy8mmXPQ
 BuJ/+0XW1yq9YOCLRnxx+eKmHyd+FzCug+OyOLngEO44YlL8FeBtBtgc+RXKlrcgpvMBAhrs0z+
 8FhG7p9Ozn9IPurQ7R1CAQjpmIpUvmVYsTBQ2MoEPC6emNq7ObYY35XOzAGbm++YMomGNKbX9Fr
 sqfcum4O7Q/jX+4ahIQuQul3Qk9PryWTE8XQDpK82i1zkpYze78reQk9K+jV7ecS6bqRgW+K3/L
 aBwjBQcabJf1WxUX3dBGKZZeFwRoS19X2Xf2s+//muNfuE3LjhIE7pwNZVVNaLtdaCYGTAYd75h
 0nK+mJkIQEn5CN1r+Mas2QUHjxP9G6Gp4e4bdnoVWzhNrvlikUezYRWzRkjJ8kXA5tJD4A7YY+D
 +5LsUgMPoz8Kmmz3aFVvbnP1FaiLcRa0xZv7M4vrnOifDQwEOI1VXLAJlm61rFaAQ22ClAmjt2T
 zV4InzU55IrwCNg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Keep track of whether we were loaded via ABL or if U-Boot is running as
a first-stage bootloader.

For now we set this based on if we have a valid external FDT or not,
since it isn't possible to chainload U-Boot from ABL without there being
an external FDT.

This will be used to inform the capsule update logic which partition
U-Boot is flashed to.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     | 25 +++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789eab75d5fe735159b4cd820c02c45..245a963f5321bda3030d3809e1b108f280b3c2b5 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -36,8 +36,10 @@
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+enum qcom_boot_source qcom_boot_source __section(".data") = 0;
+
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
@@ -237,8 +239,14 @@ int board_fdt_blob_setup(void **fdtp)
 
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
 
+	/* If we have an external FDT, it can only have come from the Android bootloader. */
+	if (external_valid)
+		qcom_boot_source = QCOM_BOOT_SOURCE_ANDROID;
+	else
+		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
+
 	debug("ram_base = %#011lx, ram_size = %#011llx\n",
 	      gd->ram_base, gd->ram_size);
 
 	if (internal_valid) {
@@ -472,8 +480,24 @@ static void configure_env(void)
 
 	qcom_set_serialno();
 }
 
+void qcom_show_boot_source(void)
+{
+	const char *name = "UNKNOWN";
+
+	switch (qcom_boot_source) {
+	case QCOM_BOOT_SOURCE_ANDROID:
+		name = "ABL";
+		break;
+	case QCOM_BOOT_SOURCE_XBL:
+		name = "XBL";
+		break;
+	}
+
+	log_info("U-Boot loaded from %s\n", name);
+}
+
 void __weak qcom_late_init(void)
 {
 }
 
@@ -515,8 +539,9 @@ int board_late_init(void)
 
 	configure_env();
 	qcom_late_init();
 
+	qcom_show_boot_source();
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
 	return 0;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 74d39197b89f4e769299b06214c26ee829ecdce0..e5eb4cfbc2b752de799b1407ede69683c81474c1 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -2,8 +2,22 @@
 
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+/**
+ * enum qcom_boot_source - Track where we got loaded from.
+ * Used for capsule update logic.
+ *
+ * @QCOM_BOOT_SOURCE_ANDROID: chainloaded (typically from ABL)
+ * @QCOM_BOOT_SOURCE_XBL: flashed to the XBL or UEFI partition
+ */
+enum qcom_boot_source {
+	QCOM_BOOT_SOURCE_ANDROID = 1,
+	QCOM_BOOT_SOURCE_XBL,
+};
+
+extern enum qcom_boot_source qcom_boot_source;
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}

-- 
2.49.0

