Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71079D148B3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E179183A1E;
	Thu,  8 Jan 2026 07:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FyHHTZVN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PEA+rPAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661F483B0D; Thu,  8 Jan 2026 07:56:05 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11970838A5
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 607LKtcj2239586
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=snm3GNBWr4aWNukkKrP998dijpzCbBhv487
 PCqw2SyQ=; b=FyHHTZVNzEprxkeROv91TwkA6kd7L0WBdEmGKlsawjkk/XYd/Yq
 XYZQ8VD25++v7dckGbqrH5J9Zt840vz3n6bJdIdVy/TCF0USgQZh0IOyVeP5jjxx
 hCnx/IRqzvj2OEtDm8+ZJJlNOh/iuQOmjxTP1ouPQ0CkNjXubpy7h4n+4fpy1a3R
 HKQFJDO37b/2gDEDndQ/FsjKs5ZA2+LcVqknC9Vr5wfa6yIgjaFHZKt1UptUZIzV
 eI1HPWxArJs2ruZnerx/eg8TFhrDxPaGP+ka/0JkaTEIGsJeRs4sLjx1fqEEb2m/
 yx+3EIY5IVqRq4ufGHObJpwaxS7M6rU6g2w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg2ybb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:55:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34abec8855aso3801833a91.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767855355; x=1768460155; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=snm3GNBWr4aWNukkKrP998dijpzCbBhv487PCqw2SyQ=;
 b=PEA+rPAjmuBaWlzT4AkbkFAEjU/kYvzXAUYbQ6fZmeeoROJPvPXjiqG3FYIDXGI3to
 Jfghuad+061aTEoNVIO9+f4u5AqY6BOQGkHiDftAAlbNCOCBDhBdGzHSYQ6Mvt+PB0Xs
 RKfXRz0sDGdHnDb5md6DTnn+pLSR/AVaA/Hr98wOZnZjpvSdUFTQ3xJ9/3psgnEZnM+Q
 wHjkpxD/nCscLR85sem2sjnuDYTtWT032R0+A09QhDjPegppmV63p6NgefSDFsUV7PJS
 m09xi6RJjhXvgxhK3bYw0kvs4CotEJUzzweZwmOD6tqgBRERjcF5dYxRO/RcIxfQxsuK
 mgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767855355; x=1768460155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=snm3GNBWr4aWNukkKrP998dijpzCbBhv487PCqw2SyQ=;
 b=NZ3Wev9OJwiExRcu1/Kxp55WuXDJTt5BiO3zFeZt86X/I8NMhXsDG4W2JDWLShDsuz
 1TPzu2V5KJiwjBU8tD+JTihtFejSmHo/Shu6ZHFmsir9DkAX/bDuBn55JHRznJTZzkU3
 y+D6owJAyMKtyohGEQpE+aVVOtfVvhYgpQ1khfoNcQxv+S9lQjzrxX4s1+/8HJNOGQEq
 yT9w8Q+w0cub2gtxRZj3aQ9koLAEzU/MkSd0pp+98vRsDK/iaYoTa/d/Cq58DxdMLbNo
 u93l/Cbt7vK/DzNsKmSuLKHe7TmSlVM8VpzHH8FOKlvfSUBd24VT3X73rMOq49Wene0X
 FnZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDYskHbuxNf2Vyktfyz6imFLs9mbV8VrFpyO1iGjgNI/hf4Nem99AYaKcZiblW8O82Z8c+RU0=@lists.denx.de
X-Gm-Message-State: AOJu0YzpuNyAX7cuRaGohJyuGnADH3Mhx/WE5G5dxH5QFHiiQ57GgtTY
 nxCW0kQBrUa3qUNto+WkWsvzm6yfvDiJbMRfEaL0apX2KynGeMgi75lqcPJTkNtLXDPi0PYoNXG
 bfczddWnqx0KniRXpx15oJcLikqS6zFN+ey2lLlTX4yRYXORZjnHdP/y8
X-Gm-Gg: AY/fxX6jcgRkwGXSJES523JEVCZLXwCRnatLnYoywsv9Iee3BzNWrnm4hj4HL3hjtas
 azMIAMe2eMxRJiB1THsyd3L/MX5DSuqFJ72JT+gOp4OjBaSf4yXpJDEAsEtlYSNE+gA/nwLnHBn
 aeZXMYtk7UlRiASwcs06r3PsmFCKt4mE4eFi6CTx82Ae30VUHMa+vceWNoWxDw5PbvsesICjmyw
 XLV39apVNHqLy9vz80yFNj6k8xox+RpvaofiDpWz2URZRPmVGvvhw6SE8s1VNRBFFJCdaXLfiZ/
 I04LJTWp2NfJY5ovhw1JlxOWy5xlKq4eUhO1xfwS5Wxmeg0YtUXaYWwJ6K+FpjmXD0mzJBvKwzK
 gSN8BDn7/6ijLawR3xOJczYRKouL1J9p+VIIeOp0wJe8hNNM18+3bGuWoBGHqzAqr963MxTlcAJ
 Rxdj5VTA+9lMrwEw3B1YOhS74nc3gZ
X-Received: by 2002:a05:6a21:3291:b0:366:14ac:8c78 with SMTP id
 adf61e73a8af0-3898f9f1d5bmr4957434637.78.1767855355348; 
 Wed, 07 Jan 2026 22:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMXw9yYM5Vyh1CcGsqaMnBVi2g4FnU4Zv+iEIgZ+dJysVCcK5PBDRpMbKDMeycKfQQIKCawQ==
X-Received: by 2002:a05:6a21:3291:b0:366:14ac:8c78 with SMTP id
 adf61e73a8af0-3898f9f1d5bmr4957408637.78.1767855354843; 
 Wed, 07 Jan 2026 22:55:54 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm7157704a12.14.2026.01.07.22.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:55:54 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] mach-snapdragon:: Add support for fastboot reboot reason
 detection
Date: Thu,  8 Jan 2026 12:25:33 +0530
Message-Id: <20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RfVY_NEzQYIYMaC02Vy-RwzILtprO_2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0NCBTYWx0ZWRfX+CbaX3fOgj76
 qmamyJ7oEbSfdAQ3ncreu3VCdKrvibIpxoCj+o/nr6IgrYFt78AbO2TkTRmMjh6CSaGwAxJEbLU
 /K4IqZqQLxDRu7EgBsCUfqAwpNrJ326yUDc9eJAMc4S4MiMOD/DqDyT75F6oBB6kmKqLCLizttk
 wOfelt/1w6F3itQuKFRrHlSbbc6ETyPk7m9PezUexVQuLJvbRfdv3diZzhEFGfJquuOJ59o7Plh
 5E+MWW6g9GG2x2ttaJ1rLIXGDNB+B5dxBhrk9GEaihYYkjuFeO/Uz6wViQCflSkEwTe4lhJjip6
 gKaibrgA9Sl2XsSIrZWaA+GyXAih/exEYD5Po/pyOeKCGIF3DdE9r7l8GhEz5EHN2OnZIF6CvYh
 szGOiuo09lbrFMingpVSkAsY/eZMcAul5SxXY4FICB18CvXGHrnB9rNBFi7FubkNutrYgN0Fqfz
 4lUaDVOYMAiHEtj3wBg==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695f54fc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8vXO5aDFmHXwxmQ8TQYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: RfVY_NEzQYIYMaC02Vy-RwzILtprO_2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080044
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

Add functionality to detect and handle reboot-to-bootloader requests
by reading PMIC PON (Power On) registers. When the device is rebooted
with the bootloader flag set, U-Boot will automatically enter fastboot
mode.

This implementation supports multiple PMIC generations:
- Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register (0x88F)
- Newer PMICs: Uses SDAM-based PON_REBOOT_REASON register (0x7148)

The PMIC model is automatically detected via revision ID registers to
determine the correct register addresses. After detecting a fastboot
reboot reason, the register is cleared and fastboot mode is entered
via the "run fastboot" command.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 146 +++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..02b84297e05 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -19,6 +19,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
 #include <power/regulator.h>
+#include <power/pmic.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
@@ -32,9 +33,32 @@
 #include <usb.h>
 #include <sort.h>
 #include <time.h>
+#include <command.h>
 
 #include "qcom-priv.h"
 
+/* Reboot mode definitions */
+#define QCOM_REBOOT_MODE_FASTBOOT	0x2
+#define QCOM_REBOOT_MODE_MASK		0xFE
+
+/* PON (Power On) register addresses - Gen 4 PMICs */
+#define QCOM_PON_BASE_ADDR		0x800
+#define QCOM_PON_PERPH_SUBTYPE		(QCOM_PON_BASE_ADDR + 0x5)
+#define QCOM_PON_SOFT_RB_SPARE		(QCOM_PON_BASE_ADDR + 0x8F)
+
+/* PON register addresses - Newer PMICs (SDAM-based) */
+#define QCOM_PON_REBOOT_REASON_SDAM	0x7148
+
+/* PMIC Revision ID registers */
+#define QCOM_PMIC_REVID_BASE		0x0100
+#define QCOM_PMIC_METAL_REV		(QCOM_PMIC_REVID_BASE + 0x02)
+
+/* PMIC identification values */
+#define QCOM_PMIC_TYPE_QC		0x51
+#define QCOM_PMIC_SUBTYPE_GEN4		0x4
+#define QCOM_PMIC_MODEL_PM855		30
+#define QCOM_PMIC_MODEL_INVALID		0x00
+
 DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
@@ -489,6 +513,125 @@ static void configure_env(void)
 	qcom_set_serialno();
 }
 
+/**
+ * detect_pmic_model() - Detect PMIC model from revision ID registers
+ * @dev: PMIC device
+ *
+ * Reads the PMIC revision ID registers to identify the PMIC model.
+ * This is used to determine which register addresses to use for
+ * reading the reboot reason.
+ *
+ * Return: PMIC model number or QCOM_PMIC_MODEL_INVALID on error
+ */
+static int detect_pmic_model(struct udevice *dev)
+{
+	u8 rev_id[4] = {0};
+	int ret, i;
+	u8 pmic_model;
+
+	/* Read 4 bytes from PMIC REVID registers */
+	for (i = 0; i < 4; i++) {
+		ret = pmic_reg_read(dev, QCOM_PMIC_METAL_REV + i);
+		if (ret < 0) {
+			log_debug("Failed to read PMIC REVID reg 0x%X: %d\n",
+				  QCOM_PMIC_METAL_REV + i, ret);
+			return QCOM_PMIC_MODEL_INVALID;
+		}
+		rev_id[i] = (u8)ret;
+	}
+
+	/* Verify this is a Qualcomm PMIC device */
+	if (rev_id[2] != QCOM_PMIC_TYPE_QC) {
+		log_debug("Not a Qualcomm PMIC (type=0x%02X)\n",
+			  rev_id[2]);
+		return QCOM_PMIC_MODEL_INVALID;
+	}
+
+	pmic_model = rev_id[3];
+	log_debug("PMIC Model: 0x%02X (Metal=0x%02X, Layer=0x%02X)\n",
+		  pmic_model, rev_id[0], rev_id[1]);
+
+	return pmic_model;
+}
+
+/**
+ * check_fastboot_mode() - Check if device should enter fastboot mode
+ *
+ * Reads the PMIC PON (Power On) register to check if the reboot reason
+ * indicates that fastboot mode should be entered. The register address
+ * varies depending on the PMIC generation.
+ *
+ * For Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register
+ * For newer PMICs: Uses SDAM-based PON_REBOOT_REASON register
+ *
+ * If fastboot mode is detected, clears the reboot reason and enters
+ * fastboot mode via the "run fastboot" command.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int check_fastboot_mode(void)
+{
+	struct udevice *dev;
+	int ret, reboot_reason, reg_val;
+	u32 pon_reset_addr;
+	u8 peripheral_subtype;
+	int pmic_model;
+
+	if (!IS_ENABLED(CONFIG_DM_PMIC))
+		return 0;
+
+	ret = pmic_get("pmic@0", &dev);
+	if (ret)
+		return ret;
+
+	/* Detect PMIC model for address resolution */
+	pmic_model = detect_pmic_model(dev);
+	if (pmic_model == QCOM_PMIC_MODEL_INVALID)
+		return -1;
+
+	peripheral_subtype = pmic_reg_read(dev, QCOM_PON_PERPH_SUBTYPE);
+
+	/* Select register address based on PMIC generation */
+	if (peripheral_subtype == QCOM_PMIC_SUBTYPE_GEN4)
+		pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;
+	else
+		pon_reset_addr = QCOM_PON_REBOOT_REASON_SDAM;
+
+	log_debug("PON reg: 0x%X (subtype=0x%X, model=0x%X)\n",
+		  pon_reset_addr, peripheral_subtype, pmic_model);
+
+	/* Read reboot reason */
+	reg_val = pmic_reg_read(dev, pon_reset_addr);
+	if (reg_val < 0) {
+		log_debug("Failed to read reboot reason: %d\n", reg_val);
+		return reg_val;
+	}
+
+	reboot_reason = (reg_val & QCOM_REBOOT_MODE_MASK) >> 1;
+	log_debug("Reboot reason: 0x%02X (raw=0x%02X)\n",
+		  reboot_reason, reg_val);
+
+	if (reboot_reason == QCOM_REBOOT_MODE_FASTBOOT) {
+		log_info("Fastboot mode detected, entering fastboot...\n");
+
+		/* Clear reboot reason */
+		reg_val &= (~QCOM_REBOOT_MODE_MASK);
+
+		if (pmic_model == QCOM_PMIC_MODEL_PM855)
+			pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;
+
+		ret = pmic_reg_write(dev, pon_reset_addr, reg_val);
+		if (ret != 0)
+			log_warning("Failed to clear reboot reason (%d)\n",
+				    ret);
+
+		/* Enter fastboot mode */
+		ret = run_command("run fastboot", 0);
+	}
+
+	return ret;
+}
+
 void qcom_show_boot_source(void)
 {
 	const char *name = "UNKNOWN";
@@ -573,6 +716,9 @@ int board_late_init(void)
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
+	/* Check reboot reason for fastboot */
+	check_fastboot_mode();
+
 	return 0;
 }
 
-- 
2.34.1

