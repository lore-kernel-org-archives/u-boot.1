Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB9B1061B17
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE0784035;
	Mon, 30 Mar 2026 19:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="izMOBW61";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ckvVZ9J7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92078403D; Mon, 30 Mar 2026 19:15:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400C483DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGNrQb1402844
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iy80Js7bnV+
 SnqQqkACVhIrdRYyTidBddHsEI8ZZoTE=; b=izMOBW61mRcY2TIrmZgmhewwgFs
 pz2QXwgyX28AkMDmrBAaRd0lT66OaGcJ+OqbMxXhaeqpDIFVP7lLQP4aMOKY6Wuw
 E/GVRZlSasok7vvqhwEhoZVFuZgZmRpMTDpT42260CWz+HEy7wVGurIyKMBTx4jo
 YReoUoHIqGXjefneTXwhjxz5dStMn7zdP7RKOee4GccwLK/xRzLbllICOeKi1xHy
 /704ODvtJ4wRef5/xjeksYiRkqQOjKGoFRrUtQU553xk7v+EewF5+KXs3nNhNy0A
 sZytwrRhG/T+RHPmA175mfldCrbqqwfq66kz3hhK/78guQUfcTKj3qv/E9A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h9kcu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c699d8caaso8756261b3a.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890897; x=1775495697; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iy80Js7bnV+SnqQqkACVhIrdRYyTidBddHsEI8ZZoTE=;
 b=ckvVZ9J7cW6lpNa5IY9+EPfAtzGly01Erp7xdyIxdHarCVbEsdzRN2pvCgIHL94yVv
 OI0FHAV0Nu5OeFBEyiY4aZG8KoYkNLqubZHbbSfskDSiFZe+Wum0LSS1E7F1UFbZ9QX7
 9PvSWfssESBs9379PYzzPOezT0GsJOwl5JqrQmmVq5KJQJvQV27XtaRm1qarSdnn/nEM
 rBlOCo9Y6vtd0QIowu4Hn3SicER+AIBtl5lIc5TKZcjvOtsXEpyy+6yXrwR1aSe07cFp
 HqwG3j01stgVI0GImv7hMw0Ys1W7uU7Vvx25pihGPfN5zu6Ah4fBVm4KGxZ9PxLi5cmo
 o68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890897; x=1775495697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iy80Js7bnV+SnqQqkACVhIrdRYyTidBddHsEI8ZZoTE=;
 b=D9uhZG0Hz2hcjmj0lX4yB86AkZXZM2/8h4WWVkM2zqj0NvxSWYhb0f9sxfkONrY105
 2917V1O2erietCg7QAzIoB6FYQB31VplfDRRtl6K77daBdCBpspTho9c8ydIarLRzi7S
 moOZAdN1QH040rFTouzPySCMuNAmAToZy/FsJLmWEK+FZLJ2poLyyHIanSRm5BPTKm4o
 WE0CDfO9ugJTnfhHUbIA1fADfaFlyPWbO2OBrXix2T4rhZVEposRSl0AuRB9BEu0Ob9I
 5aa1akjLE5rENrheMt7r6UuLD17llOz03NSeGr1lV+XgphNU8697Xv8yJsR1IwCoNJeg
 LVHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1B+ydJ46iMcizmQY8yL/qCHoIsXr21duRo7nc5nnStdvmlBjJM0ib9Yeq4RsjfL+WCuzOuxA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1fHro2XZeZtWwhC1wSvRSYAAkuZKdNig4L46MpeF8wupHo+g+
 1i5R+gro8tYqH5B3gXlF5wgBubQD99aBBPHlg8g67js1HGBr79Eaa4+5AdaCcbeuDDNcmLBlBfl
 hG+VvcXSw1O+EBjh/uLENWjc257Ic1fcneo0QZcYQ28w/Vcpq0Wf5O65z
X-Gm-Gg: ATEYQzz8t27TBwyrVt0r1eMLYT5KUj4aAqpwd0T4cLV8jm6LZADhMePZAXNX9njf4pY
 MwofZhxC4IOuT3Xqkis/jDCiBh124+loRZT58bjJEh7Ucx6KeFHN0XHzmoOazQ3kNVnAIO1+W//
 H8e7l3+jvINtpxB9c4zxFhSLI9aDXvu/OXnQv+MEWcQHgtmiJjw+VmOkFPCk/BkZgYxRQnNvXWA
 xaqAWa1t6/JYMnotZXfQRUhHKGPpnFLKsC4TUP6f05JPdx6u1t77AxOub2eHUfuViYbYYQYtFbz
 wCX/oaLyEXcbUCyh1G9SJGeV3/t1H8LClJ0Yq0V4HZM/n2w4hWojyn2tk+va4bVZwwd2r3Orcgr
 A4ix1GsiEYmwOsIg3VVADf6B5+J5jOFTglD+YfAr6etMs6+Y6wpHVjeVAkIHrrJqkciBKOqYIoE
 47mlWnrgeDfUnOwguV1MBJZnZU9fCMG/VKFrzXVfZ3
X-Received: by 2002:a05:6a00:2e9c:b0:824:a635:4181 with SMTP id
 d2e1a72fcca58-82c95afa7femr13999619b3a.15.1774890897233; 
 Mon, 30 Mar 2026 10:14:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9c:b0:824:a635:4181 with SMTP id
 d2e1a72fcca58-82c95afa7femr13999573b3a.15.1774890896707; 
 Mon, 30 Mar 2026 10:14:56 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:14:56 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com,
 justin@tidylabs.net, xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com,
 ycliang@andestech.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 2/7] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
Date: Mon, 30 Mar 2026 22:44:14 +0530
Message-Id: <20260330171419.1117817-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MCBTYWx0ZWRfXzzfdjKuQmvgU
 KG5QW0RYTM09NXNjtjS4FKctvUgPX5DNCOmpLuH5admfY3ykfQrEY98RhximB/RF4sEl02YsmVg
 svlQUfqzGwUgpx0S4eu25hAAG8G/TcQa2ETFrTo1aNNEAH0KDxvALOg4qapIvOMiXjJYhCWpKFU
 PII4jgIWGZ7cvyusyR/8OmOCDljbNGi4tBd2d8JmwlzXE+kCWYSN5xFvAAfUZGx8FQcKAEY3LN8
 LAKwy4sH4xA8/lw+QfYmluJW2bL1+n66cv0jDxv944wEI1m5bG/35i0GL+S/+OJ1GMkd0MvrFEC
 7AjlJqJtwDihOrbakpyrFfhZWwfxPaWGBd7QnpbKPnAzlPkojCeH31NERPlzLHW0M4XFN6NwC3z
 iVWlxFVYHiuvCZ8SWj5bCOTuVHCPH7Uts9+HMBGlmYIImFMicYcrm1cHMl4NpzoYWXl/P0YDWjR
 Xm4Xo5M+8/Z6TJnT9BA==
X-Proofpoint-ORIG-GUID: Le3ai4oCEqwbuVprx2gGYlR4eOXLBK5r
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69caaf92 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=xi5d6GjbYgY_MreKiQQA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Le3ai4oCEqwbuVprx2gGYlR4eOXLBK5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300140
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
Changes in v3:
1. No change in v3
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

