Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E39EDF154
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BF283DEC;
	Fri, 13 Feb 2026 12:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImVd4hvE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fB+5Lt8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAA483DE4; Fri, 13 Feb 2026 12:27:59 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2FC83CBD
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7MuuC2628874
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p88NtLXZBqr
 rSproJ8xTgbK+swPRn/4tIyopt2bqzrg=; b=ImVd4hvEUuADSJOV3dP1U7LxP/Y
 yQXdEOjuLC4KNPdhfiOOXwO7dUfPVMO2T+rCKU0OluTRkzl3zsptCvY8hM3imEVT
 A1cAjMRL81kMtu+otHPLDyTJsb9LmB71GfK917v53a59LZb5Lof2mz2xXR+RvUi/
 qs0HnTAOVc32BTJ2CT7W9/bRBCAMRXvV5wR3M2cMpx1oq8ZbwF6p7ovrTFy+rENk
 F4q/I9sv9vDHy4LvSeneehYeMq9rpq5btynvf4rt0Rh1CJ+g5wjpifHADZcsQkn2
 xKuDyunSdMpR5Eo1NPt41umSi2I7mrKW7vKtc88TXrq65O+sfTpt8HsAyjg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ygurvrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so9767055ad.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982074; x=1771586874; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p88NtLXZBqrrSproJ8xTgbK+swPRn/4tIyopt2bqzrg=;
 b=fB+5Lt8mw+C4RXBn6HoBSwCMblZ/n7iFyug+afwRCE0xS0vyGT9cKeehSc0zIfPFEQ
 rqjT261P7BpVSAqM/JVmg/MssqnBMj11QoNxqOsp347ds3WAOhzgfsjMMTvAv/edId14
 AcqWLvPq5PBeFjcNZnjnuy6zVJKoPUBj0G3j+nkb6Wz6/VI71ea+fm0nCtznxsJLkV8f
 HYOV3SMobKSoePV6PvCwko3xGqQjbUEmWcNPYrvCL7+EunZ3uS2rwSp72SJT/v03E+yh
 3EVlufM5J026/uwThpTlqgpiWrLuvdC1xlpr39JXmUhDpzwdn0ZzHW/Q2fegAV3B4fAv
 Tg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982074; x=1771586874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p88NtLXZBqrrSproJ8xTgbK+swPRn/4tIyopt2bqzrg=;
 b=uZ3Ff4PA/0awJ+rs3IM/9+7xOO4kpDffJwq2LXJBV2yyJti9LbdXpUlT0730DgJzDK
 1jB4bIKm0vsqRDxFdPQTIPGnYOO+NzTehPHghYNquWtIribLb9p832HaVP1LHuA8nEn+
 0MkOsYj5vJtb3eeIkkpi7z9dwog8RBdmsYG8gkp+4scvJqPVcjVPHQpT8/qigZx60t0j
 ejTCNykqPDvdTITnEl9DrxFdVnHLIyVGTvvJwhOYPluTjJwan6cQOPCuZx/UxpGVQq2B
 qKLljUdNqe/kPPKQHuxZZL985d2+b8+sLdC+aK7ZeQ6jvtt9n6R2Gbqx7U5Mf66JR2bm
 RKsg==
X-Gm-Message-State: AOJu0YwAiMhFH3sPaspBizkEfgbs9wYFCVkh+3qE2PWns3p86hn7RI5a
 a3zG+mjv1jUX86mDNPFa+28Uw/P42Zafe9uh1qWsNQUfYr9UP6E6ETqaA2ZCtmQqAPL6T28+VVi
 4wzr9xl+2wUCGOZBe0TTMG+CLo0kzXXv9oeTigAz0bS7SNZXERHOtaTw7IchT6J/n
X-Gm-Gg: AZuq6aJPeFbzHWSVlEU7aHsT7dy1RcKnBCdczQhGprmbuKqSs39T+yBazfScEwG0Sz0
 +UU99Xje0/dMMGUemuXRymiZk5I223QR/MoRGVhpF3Z3Hcz2HNKtIrWCVnnwySAccg6PfpZHZ54
 ggwuOjK/reSQclEMY6rK1ciqFep/b0tMJbv5ecMfhoKCorAABRhGsqsrajJ87GBLzsSMSHhfuiv
 BESw5DjmD2nEHTXZv5iuEsPiWMAn9DArVarsvQFaIm5tDOmq9BgvbG6cgHUcy3QwgnTfCcJS22m
 EsvnEaENhca0rSbaWfJMQ2EJsoXQGWDg51vddUgbOyJs29o/NySJs+q1cm/PRlnAGgk2JEIkH75
 tRqgJiUq8xRc31OU6RKrcnV5KurjGH/DN0u2f6Hxxow56IQzAdtG2P5kYbTJVDQ24h0HhV5rGM+
 3G5hEVP7UN/P0JmIdJldPiVJ1hr3hQuFc11ISGGXGh
X-Received: by 2002:a05:6a20:e68d:b0:38e:9c27:72e6 with SMTP id
 adf61e73a8af0-3946c798cd7mr1539632637.5.1770982074003; 
 Fri, 13 Feb 2026 03:27:54 -0800 (PST)
X-Received: by 2002:a05:6a20:e68d:b0:38e:9c27:72e6 with SMTP id
 adf61e73a8af0-3946c798cd7mr1539592637.5.1770982073475; 
 Fri, 13 Feb 2026 03:27:53 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:27:53 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 3/6] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
Date: Fri, 13 Feb 2026 16:57:14 +0530
Message-Id: <20260213112717.1256823-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _Olh7lwbWZI9NyRRXPDKuVkSPTciQb4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX/oEmzf6KLFDT
 fRbga/ie+sgPZs3IrSvx/Vs7NpZRft5dBlZ24T/ULeE52pmYpjuRvak//SuEqC6IuAEKrwPUCsf
 8y5OuoVUXEFJDA4wyYvgiPuxgT6BZqe5YMHxx2MjRHgyP4QINbk2RQE8e9FY2m2SNqBg6jwuvTj
 t43bkhtgLEPH1HV38H5r3wJYbJPz8m5sTbjy/fj7zPWKaCSAQ3eu2izXoropKT/EcyhxJvxXqOO
 MLSqErD/fTHqJw+PFkPn2DlRcioZdusNYgKxawTcv7J6jQ5bkosWETWCRYQsStDzxtP0pvJfAzM
 1jNqOVABBQojwQTVLTojk39ZAGIZ68CBr1fhr6QJrWdun3zGOTjp5LxTnxE71fXxQvoNZg0V/UK
 KaOnAS+SQQ7mShgAPVV1dwX9MvmR+WpmA/ygTd/h5Bvr9N7cNDX5p4zwJHToIoxR6TZRlpZuipe
 4dU2BDxrcX3HCdJDGmg==
X-Authority-Analysis: v=2.4 cv=If+KmGqa c=1 sm=1 tr=0 ts=698f0abb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=xi5d6GjbYgY_MreKiQQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: _Olh7lwbWZI9NyRRXPDKuVkSPTciQb4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130087
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

Qualcomm PMICs include SDAM (Shared Direct Access Memory) regions which
are used to store persistent data like reboot reasons that must survive
across reboots.

Without this driver, U-Boot cannot access PMIC storage, preventing
reboot-to-bootloader functionality and other features that rely on
persistent state.

Add qcom-spmi-sdam driver that:
- Probes SDAM regions from device tree compatible "qcom,spmi-sdam"
- Implements NVMEM provider interface for standard cell-based access
- Uses SPMI register read/write operations for data access

This enables reboot-mode and other subsystems to access PMIC storage
through standard NVMEM APIs.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/Kconfig          |   8 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/qcom-spmi-sdam.c | 200 ++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a0aa290480e..8ace19c1128 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -92,6 +92,14 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_SPMI_SDAM
+	bool "Qualcomm SPMI SDAM NVMEM driver"
+	depends on MISC && NVMEM && SPMI
+	help
+	  Enable support for Qualcomm SPMI SDAM (Shared Direct Access Memory) blocks
+	  as NVMEM providers. This driver support accessing SDAM blocks in PMICs
+	  for reboot reason functionality and other NVMEM use cases.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab..bed2cb63fcb 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_SPMI_SDAM) += qcom-spmi-sdam.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom-spmi-sdam.c b/drivers/misc/qcom-spmi-sdam.c
new file mode 100644
index 00000000000..482156f3bb7
--- /dev/null
+++ b/drivers/misc/qcom-spmi-sdam.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm SPMI SDAM NVMEM driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <misc.h>
+#include <dm/device_compat.h>
+#include <dm/uclass.h>
+#include <spmi/spmi.h>
+
+#define PID_SHIFT 8
+#define PID_MASK (0xFF << PID_SHIFT)
+#define REG_MASK 0xFF
+#define SDAM_SIZE 0x100
+
+struct qcom_sdam_priv {
+	u32 base;
+	u32 size;
+	u32 pmic_usid;
+	struct udevice *spmi_dev;
+};
+
+/**
+ * qcom_sdam_find_spmi_pmic() - Find SPMI controller and PMIC USID
+ * @dev: SDAM device
+ * @spmi_dev: Returns SPMI controller device
+ * @pmic_usid: Returns PMIC USID for SPMI access
+ *
+ * Walks up the device tree to find the PMIC parent and SPMI controller.
+ * Supports both direct SDAM under PMIC and virtual NVMEM under PON.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_sdam_find_spmi_pmic(struct udevice *dev,
+				    struct udevice **spmi_dev,
+				    u32 *pmic_usid)
+{
+	struct udevice *pmic_dev = dev->parent;
+	int ret;
+
+	if (!pmic_dev) {
+		dev_err(dev, "No parent device found\n");
+		return -ENODEV;
+	}
+
+	ret = dev_read_u32_index(pmic_dev, "reg", 0, pmic_usid);
+	if (ret) {
+		dev_err(dev, "Could not read PMIC USID: %d\n", ret);
+		return ret;
+	}
+
+	*spmi_dev = pmic_dev->parent;
+	if (!*spmi_dev || (*spmi_dev)->uclass->uc_drv->id != UCLASS_SPMI) {
+		dev_err(dev, "Could not find SPMI controller\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "Found PMIC USID=%d, SPMI controller=%s\n",
+		*pmic_usid, (*spmi_dev)->name);
+
+	return 0;
+}
+
+/**
+ * qcom_sdam_read() - Read data from SDAM/NVMEM region
+ * @dev: MISC device (SDAM)
+ * @offset: Offset within SDAM/NVMEM region
+ * @buf: Buffer to read data into
+ * @size: Number of bytes to read
+ *
+ * Uses the same SPMI register access pattern as pmic_qcom.c driver
+ * for consistency and reliability. This function is called by the
+ * NVMEM subsystem via misc_read().
+ *
+ * Return: number of bytes read on success, negative error code on failure
+ */
+static int qcom_sdam_read(struct udevice *dev, int offset,
+			  void *buf, int size)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	u8 *buffer = buf;
+	int ret;
+
+	if (offset + size > priv->size)
+		return -EINVAL;
+
+	for (size_t i = 0; i < size; i++) {
+		u32 reg = priv->base + offset + i;
+
+		ret = spmi_reg_read(priv->spmi_dev, priv->pmic_usid,
+				    (reg & PID_MASK) >> PID_SHIFT,
+				    reg & REG_MASK);
+		if (ret < 0) {
+			dev_err(dev, "SPMI read failed at 0x%x: %d\n", reg, ret);
+			return ret;
+		}
+		buffer[i] = ret;
+
+		dev_dbg(dev, "Read 0x%02x from 0x%x (PID=0x%02x REG=0x%02x)\n",
+			buffer[i], reg, (reg & PID_MASK) >> PID_SHIFT, reg & REG_MASK);
+	}
+
+	return size;
+}
+
+/**
+ * qcom_sdam_write() - Write data to SDAM/NVMEM region
+ * @dev: MISC device (SDAM)
+ * @offset: Offset within SDAM/NVMEM region
+ * @buf: Buffer containing data to write
+ * @size: Number of bytes to write
+ *
+ * Uses the same SPMI register access pattern as pmic_qcom.c driver
+ * for consistency and reliability. This function is called by the
+ * NVMEM subsystem via misc_write().
+ *
+ * Return: number of bytes written on success, negative error code on failure
+ */
+static int qcom_sdam_write(struct udevice *dev, int offset,
+			   const void *buf, int size)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	const u8 *buffer = buf;
+	int ret;
+
+	if (offset + size > priv->size)
+		return -EINVAL;
+
+	for (size_t i = 0; i < size; i++) {
+		u32 reg = priv->base + offset + i;
+
+		ret = spmi_reg_write(priv->spmi_dev, priv->pmic_usid,
+				     (reg & PID_MASK) >> PID_SHIFT,
+				     reg & REG_MASK,
+				     buffer[i]);
+		if (ret < 0) {
+			dev_err(dev, "SPMI write failed at 0x%x: %d\n", reg, ret);
+			return ret;
+		}
+
+		dev_dbg(dev, "Wrote 0x%02x to 0x%x (PID=0x%02x REG=0x%02x)\n",
+			buffer[i], reg, (reg & PID_MASK) >> PID_SHIFT, reg & REG_MASK);
+	}
+
+	return size;
+}
+
+static const struct misc_ops qcom_sdam_ops = {
+	.read = qcom_sdam_read,
+	.write = qcom_sdam_write,
+};
+
+/**
+ * qcom_sdam_probe() - Probe SDAM device and register as NVMEM provider
+ * @dev: SDAM device
+ *
+ * Handles both real SDAM blocks and virtual NVMEM under PON blocks.
+ * For virtual NVMEM, adds the parent PON base address to the offset.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_sdam_probe(struct udevice *dev)
+{
+	struct qcom_sdam_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Could not read base address\n");
+		return -EINVAL;
+	}
+
+	priv->size = dev_read_u32_default(dev, "qcom,sdam-size", SDAM_SIZE);
+
+	ret = qcom_sdam_find_spmi_pmic(dev, &priv->spmi_dev, &priv->pmic_usid);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "SDAM base=0x%x size=0x%x PMIC_USID=%d\n",
+		 priv->base, priv->size, priv->pmic_usid);
+
+	return 0;
+}
+
+static const struct udevice_id qcom_sdam_ids[] = {
+	{ .compatible = "qcom,spmi-sdam" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_spmi_sdam) = {
+	.name = "qcom-spmi-sdam",
+	.id = UCLASS_MISC,
+	.of_match = qcom_sdam_ids,
+	.probe = qcom_sdam_probe,
+	.ops = &qcom_sdam_ops,
+	.priv_auto = sizeof(struct qcom_sdam_priv),
+};
-- 
2.34.1

