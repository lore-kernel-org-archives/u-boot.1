Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE75F88090
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C19884201;
	Thu, 16 Apr 2026 09:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObRbNBaw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="deUuXz23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D033784222; Thu, 16 Apr 2026 09:04:04 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC1884223
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G6OmK52651712
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5Xhcy5Kqf96
 HAeecZnZ24Jlfw2k6R7neMZwT3s6wVbA=; b=ObRbNBawhYhkOdFuBUbDRVTWxkf
 0B1YcACS3KsWKdiXZxTej+RhSGRh3MDVN/z2lMOasUjDDKc4jZc3CaiW7BdXVScG
 XxCm5ZBpiOUMz485oNGtmnSXUn5/vsTex5Ek+qfPVb9xhfAoiAn6E0wH/FEN7oVi
 29cMCIvJBjScwoAlbytB6bl89349dslG7o8HA8fM1X/RMLGYEiqQQJn89mYQX7Mh
 fs4Av94WFF7Aw2U6KBBtDQxMNp9sfUlCq1QhaH6UKHxwJ1w1vw/hOdV9qme7i9s1
 j7SAer8MVkTtVVmp0XDTbLMjrItDuSQD03dEm+fNTEd0kgVBOZmT3KPLlsQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtfug46a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:04:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b4678c6171so40638895ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323040; x=1776927840; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Xhcy5Kqf96HAeecZnZ24Jlfw2k6R7neMZwT3s6wVbA=;
 b=deUuXz231uEFuVFQnAJOC2/NTWAESug02pc72W7PhYkbEPmwmvuQKkMbur3xKiFDwK
 B8Bix+UUZcRoKY5UXQvo4EQ7AbLTgkX/eGbYeTEYJCIpCVtvyPMA1cbv1Y/tllRb9TAn
 FpzGjYe8F7YMCjkcs69GhAxpeG7zLwSY3oBFSCWUICaVuqvR3l/zHgLHhvhHIOXHDfvO
 Y6SOj0HsDudnY57qdris0HDioEyt28fCiCqY/9NX9wSq9X8cfkKzOCFVm371Rg9wVMir
 CNg2YxTsa7tyaZdw6/1y3KnQ8nZDGGgNVO+jz7CmPlB38jPWNUgj+vhq8yBHP8X2Tt3J
 HkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323040; x=1776927840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Xhcy5Kqf96HAeecZnZ24Jlfw2k6R7neMZwT3s6wVbA=;
 b=MtoiXdNYF7/WoRH/7zPhm+kffA2/9AKcZdUf1gfyNdk8/2nv8bGReacP4zaV5a7xFe
 cE8zMTkrHUPiQlBvcGwp8ePWy1+mEzr+h1xhjWe0UC+eRCMnJzosNnORhu0HYRCuWh2E
 gjOofN7bM7JlE88hEXiqybj1OqR09effMbj+AKf1MmsCoVl4vOfpUBKM3PUteQWPYUYi
 9MX3XGja3OHuUmPVl3II5yE2ogBL6YqYEXco82bAMEOovLf6HcyzzCcB3ZoYFpyxX9Sh
 cN2o1xETSe93uwP6/jQewbunlTSu8SXcKa+3D4vf59GXBR4PBwM7pShfqBPtgJ0Hgev0
 0sEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D0Ot4KsRGptGZvpbVP3t2yZr8lL6pZwIrueG7aH+VgMkeu9a7p+XGzemR8OKbP35+qE1KbmM=@lists.denx.de
X-Gm-Message-State: AOJu0YxPiYftOYWsoh3ULBBgrPDgAhZDj5k7sOFrlaGdlKpHLSYo9B3Z
 AHWnDMbbpNc9v7L1CFfhnZuHwn4jRGL7lSFhgtT46PakHIpE/1Kj1EkjGpTTcxPtxOWnQeC+0hS
 O89xJe3IDzYsjsPG3pm+yxW/ejbtGPgt90KODo4UXE/Pjc859sJ5OyY5b
X-Gm-Gg: AeBDievOIyX4Jfx7+ijTMx85h7R32oopmWX/p4yse6sTYcJSJStDKpA6NjHpoX41+VG
 elC81KwyFwWqdhxDl5yIQtlF99S2eUY76eUFmEPUOzwz8fm5502eexfAsS/mkaoxhjKtk4SzMw3
 QgqNfpPZBOp5mokRnfSRPIJeJVivfM8pi9oVGcZCnxmhx9DVzZk+/nsf+EYJoa373ZBm9LBC6ra
 1+t7cZlR2TdZWzdvdAQGqfp5PvueH+VB+kYNH7NH8m4yqZ71GDVsts2GU/cuEBej6p96QnGCJnk
 KUZHv2x9oV/tCpAnIybgwabF3RhOeUKsp3ZbIizNKKNIezmnDAlxmhKzGL2oJ1De+KltxsA1vSP
 HM+jK4806QBYXzqggZZ3Hdacdl+DkAvZRYn2Lqd6zEQJGGqZC0+xOWHrMjaRXnL55TsIEApUeD3
 XvFK0Jo++2DdHtbbtzwx9EfYi1oTMK1o4UsFtrHRKFOCXLxFO4v74=
X-Received: by 2002:a17:903:2b05:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b2d5a4e995mr233368655ad.30.1776323039638; 
 Thu, 16 Apr 2026 00:03:59 -0700 (PDT)
X-Received: by 2002:a17:903:2b05:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b2d5a4e995mr233368255ad.30.1776323039048; 
 Thu, 16 Apr 2026 00:03:59 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:03:58 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 3/5] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Thu, 16 Apr 2026 12:33:28 +0530
Message-Id: <20260416070330.3006528-4-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5YS1p3q-V9DPxIMpGOzH31YyHLJ24944
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfXyFpxXfGOy0Rw
 jnHvqZ1ShQzT7UDvPY21WsGu4o2WdIfvq7vFo0N3MMXf0sWs9KoGVv9qmFnEg5awO3D+TEl0by1
 ANuY2aXkDDdcin5D6BSdx5wSXfTZqbN57fJRjcjxqdLq1E6X9P1hX/LP5Qm5FzyzlcxfbR7caJZ
 JW7rsbG5zed7ZDFzraKjKt6sgLHYKQDGt5ucYm589IgWbqGIIQPnKH8NvE6maTNG4gFjLsFs7qR
 Nj2A4YpOzkd686MSQPdPYixq6dpSezoB5dOOy+D4RGpF1KmQWDVY/nupn/FzCO1rsW0PmgwuuLu
 mbLACTlviMLEl6+mTsQLhc+UXcurM/TnFcMFo8ZMU6ezbwz1Lz0MSWelaBje0f6ChLOTkrHi2zi
 0syUbZwqL3hvQqZwUxkikDEi13WxrJMDfjzLcN9DImBE5kDCSoEDOsr8SrRtjCuaXD/DLYdJhz/
 ppwfNex/T8Tl2inspRg==
X-Proofpoint-GUID: 5YS1p3q-V9DPxIMpGOzH31YyHLJ24944
X-Authority-Analysis: v=2.4 cv=KrF9H2WN c=1 sm=1 tr=0 ts=69e089e0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=c-n4J4-pAAAA:8 a=oUc18nVTi94oOmveUj4A:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160064
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
index f589ad15418..f4a6610eef3 100644
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
index d18a5d52360..b5b99235b6e 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
 obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
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

