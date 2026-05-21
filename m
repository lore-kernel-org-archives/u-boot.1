Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58137CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD648484C;
	Thu, 21 May 2026 20:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gmzf6uak";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vs2jm1NQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FBA84857; Thu, 21 May 2026 20:06:31 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3888482E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGk3TW2765202
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u5vAe9NM+JS
 B4ltQVk+5ls4/HFg24qEU+f633KjRG2Q=; b=Gmzf6uakaBQFOKvgVr6JB6GesT0
 AtzWHETumLg/qGtNorubmxZ4nY1pizfyz8VyFqrUrhXesTYg8CDd6hPOO4qvsa38
 oUpOG5m4b5dMYACMMjt+1ED68rDI6ehhCsinzOuB1N35mrdHICGapD8O0SSdWZ+3
 NuG4LdH326buoCd4RVzgbAz+iLGnfGj4x5bRDE5yWPkZ8E+dLnwQ4Fr1KpkgJJU8
 y7E46fXMMfFNHnUyJcN/GmaImYNrxIpJ3JGtvRPjjZG6t+VPFUJ8RgAMBjBiKzXB
 hURTOYbd5W2ld+2ZKe4mMPkO5Rk+u3KTcRxN4VgBAcFomWlRmCPiL7b3lPg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7rxsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba15e384c7so44157355ad.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386787; x=1779991587; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u5vAe9NM+JSB4ltQVk+5ls4/HFg24qEU+f633KjRG2Q=;
 b=Vs2jm1NQKLGDbbbQzDBh8TZ7ieY+/KRlbeqh3aK5gOS/+WOTMKydAXQLCMJ490E1Hz
 1C3872waIkxIOb6bQNBPfmM/aQXcq6r87NCKtosbgalAyTaEVjNssVnl4gTjnPZvmuRv
 VBao7fvPing8Hn8DNPBOdC0sCQu9yBXonPYjk3ZtiYQjCoB/96+xDl8knhV/n7Q3OlPd
 u6FSivJjU8YmS2U3PSxE0lxYoBNZFPiVeDbvklMowXjMPWTD1HddHE4X9eM8Q1wTb2M3
 p7OqfDlaNIH1cj5kZVvcpu8sOm+NYfRH4+GFKCZafJzmGkTVzJtr8mP/AM6gAHulElSy
 UuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386787; x=1779991587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u5vAe9NM+JSB4ltQVk+5ls4/HFg24qEU+f633KjRG2Q=;
 b=dbW4N9XTc8QfuL0h7CCuhZrK5pwuYSlhi0sjTbO43OVXHkDigq+c5IMUk2LQ2mpU8Y
 Xkbljoy0SuhrcTSZy+P3F1qTqPNJaT+2Onb6C0Vl9vD1VXXNyKfrtV50CcRWUbLkjgXz
 ayRPKY3o4AHzLI6/zuX1I709swgWFHWC1+scNcrXC9M6i6luauUjATrGxJ9lbT1kmqOp
 a/joD+Si02BHmczJ0D1wKbqIhww9rnfE90lAeXcoTPAzsk18peYJ7wEvPGM5Q0yltYDS
 Th7fgk6VEEjsYVrO/dK65U/H7P4LFcdNtCIyFYeD4Dl1D5PBjiaoICrsB1CAhnrGgbPo
 AykA==
X-Forwarded-Encrypted: i=1;
 AFNElJ95pIjVOk287uswNyK6eS6Bd1rbthBMD2+X8tpKHjJ1Y/4OFCokuLZTdzaapY0A3E7tUIB8zAY=@lists.denx.de
X-Gm-Message-State: AOJu0YxYIazF8NNRkEwIMU4CzjCIn9xtd3hfkTXPhdH8iT7NSC82bzU3
 F2ruej7IbsUE2CNwk10Hbvd6heqWOT6U2RhgwW7so9RwFBWTId/FtrnJOj8o/ouoU58FRRWz7Sg
 roZdhq1Kg69ucNgsVS2snINxJLWo4iH/9Oxj4nut15v7nR8DXMcCLHzPw
X-Gm-Gg: Acq92OGYKtR5Sfsk7PFvuiS7LpRdYf+CjJT62rhPahKVT+JWgIVUkEQYCWdjS8+WYgB
 XbRp2r/Mn7vF/Vq/pti6JGnxGgyD0FuuwJ89cqCAp/9otgv2JbB6vYsrLV6oekRjy9sO+zKmt1u
 6GasnQe4l1gayRnQt3N8QoxTYR08bk4Fp+Oue+iGKdYjKAjITzKuR0pjo+lGNq+8Ir/xHHxtJdy
 sKA9EAolEsEQ3qgJJPXNGNfMhng4Q6c5rmB67K3L8/Hb5kh9iggnvyv7OcMON/k+L6qB5Cxj7/X
 5+gHY2vEPNAbVZg2BTE3my+Xmh2BuU8tr8/tGvqmqzeb6d/YUTPCaA3npZ10vMAmjWTLp3wc5zZ
 pm+k/U05360XX2ReAyPLL6od9xwG8uJ63prK4TSx1utmBbPw4R3a6Xz9w85OwHEd2awBxNwPQPV
 USg3aRfcDuqs+wGyekpoYccgr6oO3D4/6ck6u66Gj4
X-Received: by 2002:a17:902:ccca:b0:2bd:a413:6b07 with SMTP id
 d9443c01a7336-2beb031ad32mr733885ad.8.1779386786869; 
 Thu, 21 May 2026 11:06:26 -0700 (PDT)
X-Received: by 2002:a17:902:ccca:b0:2bd:a413:6b07 with SMTP id
 d9443c01a7336-2beb031ad32mr733575ad.8.1779386786379; 
 Thu, 21 May 2026 11:06:26 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:26 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, clamor95@gmail.com, m.schwan@phytec.de,
 msp@baylibre.com, aswin.murugan@oss.qualcomm.com,
 lucienzx159@gmail.com, sajattack@postmarketos.org,
 luca.weiss@fairphone.com, varadarajan.narayanan@oss.qualcomm.com,
 peng.fan@nxp.com, anshuld@ti.com, ycliang@andestech.com,
 n-francis@ti.com, jamie.gibbons@microchip.com, justin@tidylabs.net,
 quentin.schulz@cherry.de, michael@amarulasolutions.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 2/7] misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
Date: Thu, 21 May 2026 23:35:44 +0530
Message-Id: <20260521180549.282377-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a0f49a4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=KXyqN4TDWVq06ypP18cA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: N6lMJzK25zKa1ndtsL3OV2GMh04bnuQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MSBTYWx0ZWRfX+HLzQjqNMu5n
 i3kdNlvEm6FO/N7IX3xOs2LskyJqE/2TrtpFvbYiL9A+Fo+I/gflCSjVIg2zOrQYHH4hUUbnPsF
 vmSo7gzaPLh5QoS7OR1h+Djh6T3Bm7LYRkADZ2PIW+Raen+hMUh1blo3mX/G6ZHWfct04Uu4k0I
 fJ1Ig7IMj4lLBmdmfQrBamKUVXTigxc4Lc+GDnhgindsb3Fwrc8JlRaf6W4MhIZf/enNCv2JZuY
 pvo154x8xBzaorR4ofJsqOTevDofIUc6i1sggt/GKGwygMCRr9vyjfa40WITOFlRTE196i1kilY
 uWVuPCtCHjEIBH85hoS3uBMqdIJPMjhEZ+JxRKWDBYhZiH4+/ZxM35u2101885Me7E2FDSnEnpw
 /9MjsbplwPe+zGvRJ1wwXuDKWl4eJ1NlAicXEuzX1hkiDDERz4vzogM9FynMFutT2j+iFwxoVMA
 /j0dR5H8YMV7XLiYQSA==
X-Proofpoint-ORIG-GUID: N6lMJzK25zKa1ndtsL3OV2GMh04bnuQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210181
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
Changes in v5:
1. No change in v5

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
index ea785793d18..c00aa11d65d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,14 @@ config QCOM_GENI
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
index e2170212e5a..13800cc8b7f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
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

