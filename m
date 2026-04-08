Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4CB1073CA5
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC61884118;
	Wed,  8 Apr 2026 14:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8Y++KxK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HE0tZlnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC028404A; Wed,  8 Apr 2026 14:20:32 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B8584120
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638B29s1263342
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7gmz65N45KppacmQTZ8HP0PtbwNgWbJFVMftib9X0WU=; b=m8Y++KxKCwshQiaQ
 rzT1Ule9+1Xijyu5bIntZ2mlLBaJ4+oa1nIHmNrbBxwL0kzSptsiEXhDBZ0rxX2+
 fIqsaFdlNGXwyrZwvq1jD1CNSUM5sSIBvLOd93W/ttkCZDoUJ83pJ7nYq3XB23dr
 EeVRospVLqhky09ohiSn4BZ59TbCpA1xU14W3RSwX60j7RMxtowDQLd0pYtxDpJN
 Um+W2XlqRPKOaO+04LOD1oWOqWOTPUNprJ2MvTidsyQnrzSE2MdviIbR7MQSvOeq
 1Jr1Vn5YETwgKh5E2SHWt9TLSPfgXVRaQzMNu5eojrhoQHW1Ic8LCg9IH891TJ4p
 +Nanyg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7t239mx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:20:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c709551ec08so10110677a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650827; x=1776255627; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7gmz65N45KppacmQTZ8HP0PtbwNgWbJFVMftib9X0WU=;
 b=HE0tZlnB5kF8+SgdGSbdTZsGd1zjL4lnVGl6fi1tVtueoWf0oK9KTSrJGxoDkq+Kel
 Mr67o2iEvtJuntWVRJy6W1JEl0FhnDGqvM13nIPLdRlvYaNS7F0A+fspNK/ppuVirqQI
 jJaUGVoHqUIewGGOO3wQrGUo2Vf+UPfqetZtQU3OLPX1vcGETHX0v1tEBe3rDilnjXZs
 aW9m70gTM7gb8GHw9Re9uX0OvPlYt6YqNvPhwFCPTHOW2X24DZkWZgYexDfWQ9mCd1P8
 G+I5AFJha76QDQ9z/llowxyxf1Dv0NVxpX9JTGCmgPOZhUNulX1ckoBr0DkoFLamFD6G
 M24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650827; x=1776255627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7gmz65N45KppacmQTZ8HP0PtbwNgWbJFVMftib9X0WU=;
 b=d1r6IXzZoNK51wUVUwnIma67nQR2ePQi0W9rnFv2y5ssBc1/TTIxs7gevqRCyzdC54
 wcODN0DT6GKV+u7qSzVS0N1bD+dMc0EOGw7uASUx5Dc3vjgKzSwdMVKACetCeLriip5F
 qP6tpX2mL+cu4uULZNvwSdjgGU4hJ6z5MbyRf2RVORhHvHJ7AQLiVI3/G8h6nRCQmKTh
 A/XpmVgn++tt3bMx3ZLEil15/ibjeg4xz2S4gwy3ivw7wKFmpRrz+dzJ3srKSkfRd1eE
 nptEK6vvDvWBsd2wCoPBjgzxGNVsowrqOzlRnz542uTiMkKUMiDSBGaakNe5xoSdt+EC
 CNgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjP9zdtoN9k+HwcJSl7QVX8ibULv3aIpzGLKuFktklJeiLjTsvgbQJQNRnYnUuv8//vjjQBMc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzpv2p0SwSkFXPbM4CvJnAfdUkiPZ1Cce5ed61Hj0014sYLUQeC
 hR/dLepegymkRdgvF543qjMPnvtRa5djz6atIIxxvRHsWq3Q/218Twtx8F4NbfXQEer3jajeEfd
 FvodSYp9AyQXC/fE7M5Kp0IkrxUZeIxUNSaQ2fyo2cvu4ieZKcddQV+8I
X-Gm-Gg: AeBDievmiTKUijc9x+blkHgxeJBU3iG5Ej3Y0+lYHIWZHHCop8LUEvSXaMGDrVwM4uj
 9KwtAcG8p2o2kzrA1l+2FyUTWHbEGk8IqFKR2SJc8PdqiM1Ge47zjIEQxS+nxXy7VOmyBKBuxM+
 z7xT+qO0XuR1RM9o4m3kt1wxOUSsof4MeD/SGdcDU04TEgaSuH3vS6sy98ruLrTpukCauUDMy7j
 fMIg5jJPFAcSUQe4CKpQYQG/HhkZr+de1PWDkCL1sT/DAJ5oysluLWepwG/pRn1PjLe5rZQ0D4s
 XKt50lVf6bWt/Rb591uIrjY7O2rj6GhL/SSbTfVr5+dEUgtCDCRcH0VP3h6z8SCbkexcbQb2JZz
 XeTCyZgImSwhAt1NHZ+hKHZnwME+DA1NZwQ/UYBjhOWa2kkcZrZS1RKbqfRm7VTLP0ZXu0Xz6Yc
 QnZrbXMar0CgvdD7j9VSJTu550n8ZvRhBfG6suGI5P
X-Received: by 2002:a05:6a00:418e:b0:82a:7893:e14f with SMTP id
 d2e1a72fcca58-82d0dbb9939mr21606511b3a.41.1775650826714; 
 Wed, 08 Apr 2026 05:20:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:418e:b0:82a:7893:e14f with SMTP id
 d2e1a72fcca58-82d0dbb9939mr21606468b3a.41.1775650826151; 
 Wed, 08 Apr 2026 05:20:26 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:20:25 -0700 (PDT)
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
Subject: [PATCH v4 1/7] misc: Add support for bit fields in NVMEM cells
Date: Wed,  8 Apr 2026 17:48:35 +0530
Message-Id: <20260408121841.186410-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=De0nbPtW c=1 sm=1 tr=0 ts=69d6480b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=T-YsAnR6KVLXiY_LWkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfXxQVwbdIezp2q
 VdAByeWdzgUiynkMc0L5tB+xImyVX0Gk/pghWpmPS/dabk1SziwhKuBh95V5QOEhR8fLRweLEcb
 C1MtfwUuaWr5luDz8Bq85FXXx+VPQbY74BY+W8wgr4Jmsd9Waj9uP2rStx3yfJHy4YGXBPMuyYF
 mIZH6tBZU2Fj30NgPDnGubvANgth7KM6kcN5LUBVLOopoWaWq1AtM/8nqaPZgGlbalCo4maPbvm
 2lW929TVwuxbR25rPylGs46Xa8o0PtpZXP4+wo1cAYWQa9m4UGsGeaEk9uOu+tSHjBNEMnoeRcB
 HFDXiGFWzfQ0BWPuV7JEC9cooHgcTUXOrQM/8wrHSDMziPdBWRRv7uvdBEnP3QH/3fWGBlIzSQr
 Kymfn25uySj2ezSsrH57G4dVcHGRGM7Zhxeubo73r7+4nEILB1J6yUz4bcjdZwfUCF3wdAbpfti
 MA4jA7voeP/tup6WxFA==
X-Proofpoint-ORIG-GUID: qsYlJH8wwZ3lj9xUJNgfKa8XSVhgzGcv
X-Proofpoint-GUID: qsYlJH8wwZ3lj9xUJNgfKa8XSVhgzGcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
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

NVMEM cells currently only support byte-level access. Many hardware
registers pack multiple fields into single bytes, requiring bit-level
granularity. For example, Qualcomm PMIC PON registers store a 7-bit
reboot reason field within a single byte, with bit 0 reserved for other
purposes.

Add support for the optional 'bits' property in NVMEM cell device tree
bindings. This property specifies <bit_offset num_bits> to define a bit
field within the cell's register space.

Implement bit‑field handling in the driver to max u32 size

Example device tree usage:
        reboot-reason@48 {
                reg = <0x48 0x01>;
                bits = <1 7>;  /* 7 bits starting at bit 1 */
        };

This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
untouched during write operations.

Cells without the 'bits' property continue to work unchanged, ensuring
backward compatibility with existing device trees.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
1. Explicitly interpret hardware bytes as little-endian for bitfield operations to ensure
   consistent behavior across architectures
   Read path: Hardware LE → CPU native → bit extraction → return CPU native
   Write path: CPU native → bit manipulation → convert to LE → write to hardware
2. Removed const pointer write violation in nvmem_cell_write()
3. Replaced unsafe bit shift expressions with GENMASK() macro to avoid undefined behavior
   when nbits == 32
4. Consolidated size validation logic for clarity

Changes in v3:
1. Simplified bit field handling to maximum u32 size (32 bits).
2. Enforced strict size matching (size == cell->size) when nbits == 0.
---
 drivers/misc/nvmem.c | 166 +++++++++++++++++++++++++++++++++++++------
 include/nvmem.h      |   4 ++
 2 files changed, 148 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index 33e80858565..7cca34b09d5 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -12,55 +12,163 @@
 #include <dm/ofnode.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
 
-int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
+/* Maximum supported NVMEM cell size */
+#define MAX_NVMEM_CELL_SIZE sizeof(u32)  /* 4 bytes */
+
+/**
+ * nvmem_cell_read_raw() - Read raw bytes from NVMEM cell without bit field extraction
+ * @cell: NVMEM cell to read from
+ * @buf: Buffer to store read data
+ * @size: Size of buffer
+ *
+ * This is an internal helper that reads raw bytes from hardware without applying
+ * bit field extraction. Used by both nvmem_cell_read() and nvmem_cell_write().
+ * Caller must validate buffer size before calling this function.
+ *
+ * Return: Number of bytes read on success, negative error code on failure
+ */
+static int nvmem_cell_read_raw(struct nvmem_cell *cell, void *buf, size_t size)
 {
-	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
-	if (size != cell->size)
-		return -EINVAL;
+	int ret;
+
+	memset(buf, 0, size);
 
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_read(cell->nvmem, cell->offset, buf, size);
-	case UCLASS_MISC: {
-		int ret = misc_read(cell->nvmem, cell->offset, buf, size);
-
+		ret = i2c_eeprom_read(cell->nvmem, cell->offset, buf, cell->size);
+		break;
+	case UCLASS_MISC:
+		ret = misc_read(cell->nvmem, cell->offset, buf, cell->size);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != cell->size)
 			return -EIO;
-		return 0;
-	}
+		ret = 0;
+		break;
 	case UCLASS_RTC:
-		return dm_rtc_read(cell->nvmem, cell->offset, buf, size);
+		ret = dm_rtc_read(cell->nvmem, cell->offset, buf, cell->size);
+		break;
 	default:
 		return -ENOSYS;
 	}
+
+	if (ret)
+		return ret;
+
+	return cell->size;
+}
+
+int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
+{
+	int ret, bytes_needed;
+	u32 value;
+
+	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
+
+	if (cell->nbits) {
+		if (size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires buffer size %d, got %zu\n",
+				MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires %d bytes, cell size %zu\n",
+				bytes_needed, cell->size);
+			return -EINVAL;
+		}
+	} else {
+		if (size != cell->size) {
+			dev_dbg(cell->nvmem, "buffer size %zu must match cell size %zu\n",
+				size, cell->size);
+			return -EINVAL;
+		}
+	}
+
+	ret = nvmem_cell_read_raw(cell, buf, size);
+	if (ret < 0)
+		return ret;
+
+	if (cell->nbits) {
+		value = le32_to_cpu(*((__le32 *)buf));
+		value >>= cell->bit_offset;
+		value &= GENMASK(cell->nbits - 1, 0);
+		*(u32 *)buf = value;
+	}
+
+	return 0;
 }
 
 int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size)
 {
+	int ret, bytes_needed;
+	u32 current, value, mask;
+
 	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
-	if (size != cell->size)
-		return -EINVAL;
+
+	if (cell->nbits) {
+		if (size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires buffer size %d, got %zu\n",
+				MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "bit field requires %d bytes, cell size %zu\n",
+				bytes_needed, cell->size);
+			return -EINVAL;
+		}
+
+		ret = nvmem_cell_read_raw(cell, &current, sizeof(current));
+		if (ret < 0)
+			return ret;
+
+		current = le32_to_cpu(*((__le32 *)&current));
+		value = *(const u32 *)buf;
+		value &= GENMASK(cell->nbits - 1, 0);
+		value <<= cell->bit_offset;
+
+		mask = GENMASK(cell->nbits - 1, 0) << cell->bit_offset;
+
+		current = (current & ~mask) | value;
+		buf = &current;
+	} else {
+		if (size != cell->size) {
+			dev_dbg(cell->nvmem, "buffer size %zu must match cell size %zu\n",
+				size, cell->size);
+			return -EINVAL;
+		}
+	}
 
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_write(cell->nvmem, cell->offset, buf, size);
-	case UCLASS_MISC: {
-		int ret = misc_write(cell->nvmem, cell->offset, buf, size);
-
+		ret = i2c_eeprom_write(cell->nvmem, cell->offset, buf, cell->size);
+		break;
+	case UCLASS_MISC:
+		ret = misc_write(cell->nvmem, cell->offset, buf, cell->size);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != cell->size)
 			return -EIO;
-		return 0;
-	}
+		ret = 0;
+		break;
 	case UCLASS_RTC:
-		return dm_rtc_write(cell->nvmem, cell->offset, buf, size);
+		ret = dm_rtc_write(cell->nvmem, cell->offset, buf, cell->size);
+		break;
 	default:
 		return -ENOSYS;
 	}
+
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 /**
@@ -128,6 +236,20 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 
 	cell->offset = offset;
 	cell->size = size;
+
+	ret = ofnode_read_u32_index(args.node, "bits", 0, &cell->bit_offset);
+	if (ret) {
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+	} else {
+		ret = ofnode_read_u32_index(args.node, "bits", 1, &cell->nbits);
+		if (ret)
+			return -EINVAL;
+
+		if (cell->bit_offset + cell->nbits > cell->size * 8)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/include/nvmem.h b/include/nvmem.h
index e6a8a98828b..dd82122f16f 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -26,11 +26,15 @@
  * @nvmem: The backing storage device
  * @offset: The offset of the cell from the start of @nvmem
  * @size: The size of the cell, in bytes
+ * @bit_offset: Bit offset within the cell (0 for byte-level access)
+ * @nbits: Number of bits to use (0 for byte-level access)
  */
 struct nvmem_cell {
 	struct udevice *nvmem;
 	unsigned int offset;
 	size_t size;
+	unsigned int bit_offset;
+	unsigned int nbits;
 };
 
 struct udevice;
-- 
2.34.1

