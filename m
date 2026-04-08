Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8D1073CA5
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0871684132;
	Wed,  8 Apr 2026 14:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpzrPtoi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjrvMCvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9525838BB; Wed,  8 Apr 2026 14:20:40 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7534A84129
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6388Rc9O1795453
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1uC6vw1i+z9
 WbhU08ywK77VqvBxqxas/AWXih9WSstY=; b=VpzrPtoikABw4osW/gUap+9RPaj
 UrcxWf5T434i+h8S8abr2gD7JBSiYtx30fuv0Eqopmv6X5SQTzdrHYXO4pdj7mIb
 unJ/4fweQaJhU1uqzHIDmJP6g+02g4w/41l/7H8ENVi9w0iBvk9/L+s/KHhfXvtY
 HAfXPJSl3UokZCj5rliNblMLdAUFiV+0JeKsPP+4gh6XxcMIQfXvmieEaVWlOMMa
 7v9ZuwYz2ZFoRh/XLU5TwDOO5X7tmk8h0PfJ6dXDaYLYmWc0Bn4BoKKA/tsf5aA6
 Ordo1QR4poLiuSjpDZn6t7Jsr0/J/HvLLsz2kM4nTOYvwOpPZ60Hkq8HqJw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51dc3tt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:20:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c741c4cebf3so3912094a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650836; x=1776255636; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1uC6vw1i+z9WbhU08ywK77VqvBxqxas/AWXih9WSstY=;
 b=OjrvMCvdPjRQ369tAMYLfFKNCLZF9a6uhE2uGPWUzZPS+sY2m6U8JJJcT/gc3E5kpA
 eLnxSoXgE27AtrpC8vOCJSlSWAD0ALC3gRKK63DjlUezauWMMiQlDCcdp0Fn6mIJfilf
 xf0OEpx7nKCFUAaPi7xx9kUlDBsOV7zngL0nOJXT7phxPBHSMv3QRpd+60u5bHZVhm28
 HZkZQAtAevEZm9e5YA46U4i0QLHTgFJ2edBPnzICLG5DNgAHQoQhB5q+oUQl6rFVqa2W
 9/7E4sEfn8L66xtFyzTg07w5/VEdbwVyRRcX4wwXx8EJgM/k3K0xyoXybYRvhd41WcsX
 JaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650836; x=1776255636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1uC6vw1i+z9WbhU08ywK77VqvBxqxas/AWXih9WSstY=;
 b=cv8813xV3vZrKmIPh6JwqX02tMC8birNbUlUUKInzZyzUiDH7NwQcBaFZScKPvBoC+
 GkXArff1qwVGopkqZIRmQuY5Kt0HyO1xRObB1gQLP5qtJFbmS6+afIjeuZ2xHwwTOZjj
 I1izFMtgCu58eF66k//Z6kP/e6S027t0HU6UeWsbh0X7iOz2W0Vk+LO1MvXROS4xfjy+
 WKhZmK+BobvkeDyZ1XT21jWKPH82v/RAUBFQ8LZ76vZMEZ0/xwybpReJrBDcI5rc3MOR
 9/N3vWo6rqQH0RRPXohi5iyfnr1EaqCVraiPw/gUxHrafJwxk8psSNI23GHOrV9TinWU
 b9uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXmPZKb/Ul0os2c3sledfmaaCwOMoffdSVAEAIwscZwIgBR+I0pWIAGWmxXiOiMRKu43I9qno=@lists.denx.de
X-Gm-Message-State: AOJu0YxfZtmRtg/IEu3N8MpTKZQBpHRHHVQUbR1D6ZNH/TS0346IzBZJ
 jix7gBljXRmE3UQ7PB/xnfqbae5+0PtPQE8YDjmPzopnaKBx+iiilQA9LYfcI8RHWByTPxTIAQR
 k1qlawvMRmHOi0N3h56YOBxdoBTXqEuq/UUJixNguZJscuzTfNFEXUUDv
X-Gm-Gg: AeBDieuhU9BV07yJ/6nohtMMBjSYYgt8PWIzi4WxFi6NkMYJSHBZaCtQmlEeWujYlfu
 s9tXlyyuJKTNVU8RfQiyhAeILPkwirHnSSF3FsDW40h8vjjFPKcBbGpYo+YM+/tZczmE2ODwYEP
 AKXTBuDidmp2z2nTSeNfgQvuVidl3w6VqYGLW9sBAzaZ5FPfUwYqszj/OwD07eEQNmRtgnFn7Cn
 7E5kpu55sX9mvlFmG/aJ3BVE0pVPoLxqsd1m6oZs87bhNQ3fX/IgmBgnOMbTkEikwtRaEVQiiDI
 NwTyjYsArB4oaX5znY7+X3tkukr9f8RA4SysVYGSXXYlMEVgmrTfOJnMgNyaTdUS2lnaqE/yNJv
 o1/6l5CignSDj4YJi5+96vQrnT0fZ3LE18J1FknJ/cY/ePum2p0TaKC7dq6X8cqBYr8rbxrYhTh
 6ZTnj3BRNX77SOwUYyt4XQkI6GECnASJDB+40vmbXj
X-Received: by 2002:a05:6a00:1250:b0:82c:249e:a85b with SMTP id
 d2e1a72fcca58-82d0da4394emr20010198b3a.13.1775650835600; 
 Wed, 08 Apr 2026 05:20:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1250:b0:82c:249e:a85b with SMTP id
 d2e1a72fcca58-82d0da4394emr20010135b3a.13.1775650834928; 
 Wed, 08 Apr 2026 05:20:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:34 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, sajattack@postmarketos.org,
 peng.fan@nxp.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, mateuslima.ti@gmail.com,
 justin@tidylabs.net, wens@kernel.org, n-francis@ti.com,
 ycliang@andestech.com, jerome.forissier@arm.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 2/7] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
Date: Wed,  8 Apr 2026 17:48:36 +0530
Message-Id: <20260408121841.186410-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FfbtbqDL8ACt28sav644pnIB1rNmJgOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX5SI5QcMJMvn7
 +iEjyccYXJ9c7fn9f7NralZdwL2zLALI3eFWlKMiH1kaOeZuNKJ8BR+F9jGyKemYhayPd35EbLt
 a1yF95heCzPfUNIXoLDN8S2eExfbKQ7ubwZ6TRUdPsSQidt6t1aEA0F+oNrubpOs/iPpKnYtafn
 Wolpaha5GzkF8B6V58wkSybhPXJgmjI9jYiugOKMqdJdQHOmd2UYalAtWKj8p2g6WUMqeZlK9k5
 hqM2otyMolwztGPdBxYIHk7eGKBjERbu1v3hizgn3fByCvQDn9JTVBj14eP4RNVCEEMoWXhck0n
 rBVkydDdBpw7abkwkhD+KljQcNBjTSZoF2aUAyZt2rStaBiGqfKcgH3F6M8RN1UROdBdw1QDpeL
 PXx+Fka6TsERAc8kafEGPRhuNesOUZ57eVGVlUV8fPN69Hld83tr9MX7lbg+XR41+zzIvWNgZLW
 XqI6vBa+3lvcqklD9GA==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d64814 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=xi5d6GjbYgY_MreKiQQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: FfbtbqDL8ACt28sav644pnIB1rNmJgOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080112
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
Changes in v4:
1. Use local `fdt_addr_t` variable to prevent silent comparison failure
   on 64-bit platforms
2. Removed non-standard `qcom,sdam-size` property
3. Hardcoded SDAM size to 0x100 bytes per hardware specification
4. Changed `dev_info()` to `dev_dbg()` to reduce boot log verbosity

Changes in v3:
1. No change in v3
---
 drivers/misc/Kconfig          |   8 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/qcom-spmi-sdam.c | 202 ++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
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
index 00000000000..f987c19deb4
--- /dev/null
+++ b/drivers/misc/qcom-spmi-sdam.c
@@ -0,0 +1,202 @@
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
+	fdt_addr_t base;
+	int ret;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Could not read base address\n");
+		return -EINVAL;
+	}
+
+	priv->base = base;
+	priv->size = SDAM_SIZE;
+
+	ret = qcom_sdam_find_spmi_pmic(dev, &priv->spmi_dev, &priv->pmic_usid);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "SDAM base=0x%x size=0x%x PMIC_USID=%d\n",
+		priv->base, priv->size, priv->pmic_usid);
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

