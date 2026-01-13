Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D928D0C849
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A6F836D3;
	Tue, 13 Jan 2026 11:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AW5lUdd8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RsCC9Yz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81B08389A; Tue, 13 Jan 2026 11:39:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50D6836AC
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D7AHs7177577
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Sd5ludPbhiv
 5qACsPKf/x7RujGAZaQXL+/GOKb328/I=; b=AW5lUdd8YZ5gq7ycR0272TEAVRS
 hDi+QeMPgEEtDalwkdvc9PelE7SFRySLNhOBAk5OrFMMwuA+5R9AHt6PofQxhoI2
 qiEPfKTynDF9HcLBwOrItnp3UflVj6ZaZPMuLUFtKL4K4S/+F0pSKa83iuU6jzti
 ZOwqc6s4dWQPQggAguZTVgOsrN81i+0r+k+tYoibTJ5b9Nq9AjHNZTGkp93ZWdit
 5/SdI5NRd5QMNIC4rAaAxx2qEHhmoqG3PxdrhSBnAUOcRXnTNoH7MF9JlVsNsxiq
 j75Z+EeXNkW0KkZFG1BSINwuy1wWqnW62Eq3dPqkazvVLDgWtriuB0vTwyA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn52f2vbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f2b45ecffso26461645ad.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300740; x=1768905540; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sd5ludPbhiv5qACsPKf/x7RujGAZaQXL+/GOKb328/I=;
 b=RsCC9Yz+2ihPQ+BB6uwhaX+m1xn4oFsIFFSP37HdrX/g2mrHNK0jWo00REHdHxskfP
 eoviOy7GAsb9VYddPJ+mPxYhoGzRLZwDQVK5qg2v6nkD22pj7wqci0kZMNONAgZUrjsJ
 yHHvFv26yhNNUmHDfMDDtgixSZ8mG2m8AcN/do4t7r/QF1RPK0PaCEhA/TfnxwtqBppD
 u1z3m1MYQxA4DHEKaUQTPAm0RPJ5dqfSMtyjHFu3EYfAywwmA1daGzaqtiqNR6jDNfwy
 5qXHBph4PKiYzY1VBdq4jsfUfupTGeZgIuCG0sYVYt3Z8OPntfAYkDTSnmL/SSdOVSQ7
 BtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300740; x=1768905540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sd5ludPbhiv5qACsPKf/x7RujGAZaQXL+/GOKb328/I=;
 b=VZ6SwzIpwwg1wSSXd3ZaLnIAhtmWcXEZf5Mm7vf7rXIOtZqk1zoi+c7oOxEgS10PKQ
 cpgSA+zOCseGd6JeRuTy1euQlF+Ibq8YtHRtJkPRyPBF0jSK0r3MCBVkfKynMJ48nrDU
 TpNPFEnJ/HbD8jGOOeUG9AsmGYKpYZ4FOZT+Z5p24tDIMC5Yv8yYkxpTEio5S270itt6
 hK9a/sM/acK3LTdVokpNlwdxNj5IeOsvmxLKdS6HIUmBj6tmcIxu1/OJ3rKv/zj+aAct
 N6D1tNtNw3rtJ+skP05/68HAo69mPoYpyDV/9MP77w0mUoUuD40dn0CRjlOl2bb4HM8d
 li/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTf53uyOVLLAx3yvaPHRRPqNXqujxZrCk2t9t+ofdulhPgBTzLmi/fOzWlS1ldUW7r77hnGy0=@lists.denx.de
X-Gm-Message-State: AOJu0YxBcP7rRYr4mRhYJgfMMeUOeHVdy/fHpIILDGq+Z4VLcR/H+0fZ
 0djMFPqnSzglz955TU1dBCfq0c9c4B+VuR5YBzqXBBLrxBhwjpa+ZqDIFq6Y2Ukd/4+fhFg6Tlp
 Rm8lqZLpE3d9JBiwU+VRzaoOft67bmXy+QX8PoyzWBbFyAPaPln8dZyea
X-Gm-Gg: AY/fxX6JiUnQVx9U/SEsBP+W7rwIP7oEvxkWhUFncFDzMZRQ7r1kDnyuhJSuEXECC4s
 daAbzcKZ9MnxZRPJEowlQqQVaH8ikt3DrVS5xOTqPEqwcx4lC6KcKEEZkcuwBUl0gm3HctjpbkH
 VhdNrUiPxkmW829WcQCjCu8OAh8QHIpgKqLfqrDN3tNNUpEOiCsFFKnKAsdsV7pECzgPbBbepyZ
 WnKgh69CQ7Jn2EHuP0i/pNuhvTxTDwEGTeFC856Rmock4kV1yEhPZ5Bfhk5cihdVSq3jsqZ/Mwm
 nh+pbTzFzw5XazEpgyvU76jPfyjRu6q0E43t2ORNSOZX3FGvs39O1cPzeLhI1xCc1PXmnrRLjpf
 lWpVEofEgfYcdA68GxUDI+u0zzVTL5MinIiVA0oMYo/FjVV0L1TVwm8zefxHtvUzna2fSdVROEB
 Pzlsu1DK/+aRlGZ1qnLCdWiFsidwlQKkcQTe+cCUo=
X-Received: by 2002:a17:903:3bad:b0:2a1:3ade:c351 with SMTP id
 d9443c01a7336-2a3ee41511cmr200353375ad.2.1768300739720; 
 Tue, 13 Jan 2026 02:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL1Yiqyh7f4Wy+whfISY3TbADkt8mBPcG+LSK1cm22Um16hDV/kpVyV0ztPJs9mkQ9Y6w23w==
X-Received: by 2002:a17:903:3bad:b0:2a1:3ade:c351 with SMTP id
 d9443c01a7336-2a3ee41511cmr200353075ad.2.1768300739206; 
 Tue, 13 Jan 2026 02:38:59 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:38:58 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 3/5] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Tue, 13 Jan 2026 16:08:38 +0530
Message-Id: <20260113103840.1948029-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX7VyN1YBZDAYz
 4wECLTPXcAkD9nh8iyZPeesu/lTSU1a1nFV7KiJkY7iIJEdxpSimf9W0yYcdT22PsEXZbxG1SNu
 nkhhin10YdjSh+4AJqqIv0xip1sbPyyFLgm6Hmg0cB0IkAANRL5mLGDMBe6nd/kjwakuk7OAawB
 bk70wIGBEY2HBrze0O0/2+4csMKzfH/LYUylboOcGTQOsBkdE9mr3cl9sKylJ8ImXrrnYHtZVFe
 4WYVUHBkMJisLAF4ZC4WI2QWaCuEh7I2BwQUwwpVCP86pCHC5kXv+pSFt+R9XjNWuB6o+uTWjky
 XJtQZETZXG7VrGGzepjQjdUGRTSNHjR4ydFfBnb+5j9cL9RsH2vJQWPXARloX3xDOHUOogO+vt0
 y2XvEhlKhL9wiMHF17i/XGA3V2XkLtCCSK4psNlifTV2Gjl73sTDtF00n1DHu0zcyGD2rWctf1o
 MJigaNOCggsEJMekulw==
X-Authority-Analysis: v=2.4 cv=TcCbdBQh c=1 sm=1 tr=0 ts=696620c4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=c-n4J4-pAAAA:8 a=KMrddx77dZ4Wm-S9ziwA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mJAfHRmrC2imWQsOVLel8_TgeTDsJy79
X-Proofpoint-ORIG-GUID: mJAfHRmrC2imWQsOVLel8_TgeTDsJy79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130090
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
index 0181f6cd581..8e010bf1ccc 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -293,6 +293,12 @@ config SYSRESET_RAA215300
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

