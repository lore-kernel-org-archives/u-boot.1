Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767D4D262B2
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AB683A8F;
	Wed, 21 Jan 2026 07:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAbnR2Sv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pu+K3icd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E726783AB7; Wed, 21 Jan 2026 07:39:45 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 776A983A8F
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L4XX8A3229160
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qNXKCavUtB8
 Iq7lwHgyx56smDzTiWwLWCgly0OpEmRM=; b=dAbnR2SvPcmyERZwA9iXiuM4slo
 oZaoO4q33sH3hbrbf+30UtQ/Qs1gJ8WoVv8kH+YsfRfpebQC5yY5ubBtVbCoCaUP
 vvlpz8Cz32curD+QheUrRR1gMNi1fnV8tb3xMtqzcQTVK2ardO0I64d5PdC9hL3L
 qS0nicd7azpNc++ySwoW2OD5mdS2Nx4SQb2dR/Rj/E3fOc2M4UNgUs3tZ7uGB/9r
 sbKiLTJcSNKSXAmAsXujl21o16EeJD9dvnhT4/G4qP+ob5zWrT8StBgZsqpGo/1D
 C1THLhhBkp6TIT3enNM7YPz9bI/++MysgFdDmupf+JHyGGWD0IcmCL+q73A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqvp8b5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a13be531b2so59388775ad.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977581; x=1769582381; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNXKCavUtB8Iq7lwHgyx56smDzTiWwLWCgly0OpEmRM=;
 b=Pu+K3icd9iEP02HlahGRI5+z8u69Ruw8M/hDrNxzmVfbtJhvgH7edK180v+gLgTSg+
 KEmpEVyJp5oVHac/g2t4H/0fZmF5IaQMABIKoNkrEidDZ1lFlZsjZpjGKyCuCRC1Zo5n
 RVqINPpH3VyMa9vyI0yJZ0mP4R6xcuFT4cfyrc0UbQscvUo4hR28n/gsl38EUaoDBsEt
 EwEbdPjHlaPXM2eakPiQtr5DCQMDD1b1AZ3pRqwIA4uEpLoJgdYxRLrHE5tn14WwvDqP
 958edvz7gMwQcpI3+14e8C7Sc1vZaxubaJk7zjnaOpWr9+X97UecCUzC/IR9FUqtW/NL
 YWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977581; x=1769582381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNXKCavUtB8Iq7lwHgyx56smDzTiWwLWCgly0OpEmRM=;
 b=pK8nRZPb2PYC7MWZ5V2x4YA28Qpap6APeFTptjg+mu2fLMkvK0b+S+0VMbJpDXUu6y
 33T0o9OeKHg/kqe8t5ZRI6jmbLIlcX+q45J0Oex1eQxKfS4f13qTbh3EDnjqbu0+ivkn
 qcF4IrbwYIzMBzGcFpwsGMC1/FXkvn1vCEvEhFTAlABAbl0EI7tAPAt7TU68Uj4DGtqz
 mrkWBa55cXEcUW5oqN6QiQidNRrAXfSWmTyTs9G5Eyr6nU6P7bwIdJ7DWSo3dzsTHlMX
 E8bjqB012YQx/bMtp9epXCUuPEZd4yH4WHNRXm2tfv6xstlZi15oc8PtcpXvuNlgxiI/
 OkBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmLBKzUN1zHkQPXeWPZ4P8Rm2s20V3Yse69F1o/1GhT+PVFP2h7Ztas3BetGJivLfT8T0KMW4=@lists.denx.de
X-Gm-Message-State: AOJu0YwXASwpgIf5xqxF3S0J1o7ghozEnziCtcXO47B+OOYVRPFxlIR9
 Y6YD1X19c8cVU5Z1Cm0KoKvoI/FTnRBk08wQ3T4uVtQ2b+Z20iTkSyUnQ9q7TUf96ZbIg219stt
 B5MvkPfyLZsbyFRvwM5U9ADgHPRxjfIZ4a9FG9Va46X2n0OX7dsucq1+g
X-Gm-Gg: AZuq6aIvVH8+8QbKnAUH3iETXrlgofInPBa/EVM+R1TctgKTWAMgYwbw8zbeAIBaAp5
 H/JkCQUotQrq5MelAj9ncqoKmCfOSH2pyATVHAggNuC/zybfhktFPK/L+UtCHnhfw+dsnICHUBK
 SSW8KvoWnB9FMq5wKfX97HHr8EOjJMnIq3E3+gb2owhQT5vmzSh80r7VcgHonj6ObQn6Sgdl89x
 RuG+1mQsLq4mML1656PQiYxiN4mDX9e/NmWJV9N0+rjD6KpLonpXNjd0U6Yv8dFhEwMOaDhkLW0
 zLsAthfBtyc2lwu8MJLwUTwZrzs8ibJ2jhIKXgwxewlGk78O3GXxcAZRjxNhkLUs/Nv6bqlRYw0
 DA79oGVtmeE7hQBO+fbtdFSq6cqFlNKrqd3h0Utw1cE7D0uXRX8LA1oL3R47Rn1qieN/7k0o9MV
 A3tJcNuzA6m5O9I5f6a80fVJFD5Cb0WZw1Qj/584E=
X-Received: by 2002:a17:903:1a0f:b0:2a0:b467:a7cf with SMTP id
 d9443c01a7336-2a71740af3fmr143819445ad.0.1768977580844; 
 Tue, 20 Jan 2026 22:39:40 -0800 (PST)
X-Received: by 2002:a17:903:1a0f:b0:2a0:b467:a7cf with SMTP id
 d9443c01a7336-2a71740af3fmr143819195ad.0.1768977580354; 
 Tue, 20 Jan 2026 22:39:40 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:40 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Wed, 21 Jan 2026 12:09:18 +0530
Message-Id: <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H5doN8THR3J6H4_vHHAGdbnDwi0qWhtJ
X-Proofpoint-ORIG-GUID: H5doN8THR3J6H4_vHHAGdbnDwi0qWhtJ
X-Authority-Analysis: v=2.4 cv=cdPfb3DM c=1 sm=1 tr=0 ts=697074ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=c-n4J4-pAAAA:8 a=KMrddx77dZ4Wm-S9ziwA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfX2xWO3RPIGmss
 vYGd4KkzzOdYxFUCF77W5nUZ+G0hfUL8FQTKsauY0pK1p4xpvDZ9lgVS3VnABpCyFhvG7jxOzSe
 jIMSTeV2BOSuEp0mgNuW5dgWy4LdlOY1dRyn5XD3OdNSHtN7yozcJSCeI6ZGcZabYWwNa6xzeNo
 SfHLtS++O2LMZP4bStLIUJfoTPo4Zp2Sr8vWF0DOkOq/ek/DLzMfeObCkSG3rrhOGtOVwxptn1k
 TABys+fDBLZMa2AETavpndA+IktRXPf7x6EGG8u7Mcb6FYhtnvgtRrkOMWDQK7tBF2kCgn+xA+2
 zLiUPaje9k4ZyP+f6ikB0ArDNCVwur2hMEG638zPPzKsDvbGe07bDOD9Cw0u/7/km7zjeVimnGJ
 pHgjtOV6I9eMh/bd/xnbKyz4Ac44Mfw4YdNNqNzgNFH0QJY7WetMtYw/KOG67GuIGiDimZkN7h8
 Rlpcbh3ptcS/X3As3OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053
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

Implement request_arg() sysreset_op for QCOM SoCs that use
PSCI to reset to EDL (Emergency Download) mode.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
      issuing it

v3: * Move argument handling to a separate function and pass the
      arguments to the actual handler to process
    * Drop Qcom specific SYSRESET_EDL from the common enum

v2: * Update commit message
    * Elaborate Kconfig help text
    * Use '-edl' instead of 'edl' for consistency with other arguments of reset
      command
    * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
    * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
---
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  6 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2e3223e1c32..b6838a244d2 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
 					 NULL);
 		if (ret)
 			pr_debug("PSCI System Reset was not bound.\n");
+		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
+		    device_bind_driver(dev, "qcom_psci-sysreset",
+				       "qcom_psci-sysreset", NULL))
+			pr_debug("QCOM PSCI System Reset was not bound.\n");
 	}
 
 	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 6fb0ca81dc6..905ad2a7769 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -301,6 +301,12 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_QCOM_PSCI
+	bool "Support reset to EDL for Qualcomm SoCs via PSCI"
+	help
+	  Add support for the reset to EDL (Emergency Download) on Qualcomm
+	  SoCs via PSCI.
+
 config SYSRESET_QCOM_PSHOLD
 	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
 	help
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index f5c78b25896..8bb1eabd48e 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
new file mode 100644
index 00000000000..3627bbf5c82
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-psci.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <sysreset.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+#include <linux/psci.h>
+#include <asm/psci.h>
+
+static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
+					  char * const argv[])
+{
+	if (!strncasecmp(argv[1], "-edl", 4)) {
+		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
+		if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
+							ARM_PSCI_RET_SUCCESS) {
+			psci_system_reset2(0, 1);
+			return -EINPROGRESS;
+		}
+		printf("PSCI SYSTEM_RESET2 not supported\n");
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
+static struct sysreset_ops qcom_psci_sysreset_ops = {
+	.request_arg = qcom_psci_sysreset_request_arg,
+	.get_status = qcom_psci_sysreset_get_status,
+};
+
+U_BOOT_DRIVER(qcom_psci_sysreset) = {
+	.name = "qcom_psci-sysreset",
+	.id = UCLASS_SYSRESET,
+	.ops = &qcom_psci_sysreset_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

