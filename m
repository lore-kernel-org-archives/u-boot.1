Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3901CCD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931398485A;
	Thu, 21 May 2026 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="je9GICKz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PMyH4prX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDC384877; Thu, 21 May 2026 20:06:24 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D5E84855
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGkFxQ4155671
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xwKyzvKGVgaO8EcP27LLv6xm0YnG4TDP4DS/iOvmCTQ=; b=je9GICKzsnyCWctm
 2xIUkuQuZeO+ox0vdP+RP+hXJ4nROAvpXgMCFscAyUkFryoZquWa50a71C/g0gqy
 HHyfh3uWFLaYU5ojh6KXDHIk3ZxBxb+f3in/qiODBMZF1oEIZzVUI90bBq4OcFYW
 vmNElL3dnIAS66lAEl28LHoj3adGBxeyaKhkGpNtBnZmXqNoIVhzuKUNKPjxpWDG
 hF3GpaChNXmct7J4OVIrszTAYRA+CWYJV9nsdCuh5hzLVt0pNbucFUCJycoVdjMq
 jC5crYwfdz/33yf/1nvf3LB12gUtxThndqnUdNPdxsi4ZAqjE4iswWEmmOPLnC+M
 H9JJ4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r963vnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4678c6171so67998615ad.1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386779; x=1779991579; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xwKyzvKGVgaO8EcP27LLv6xm0YnG4TDP4DS/iOvmCTQ=;
 b=PMyH4prX4IC4Mec+2o0nznCPgsIIBoIMtSUnEnRq9WZmyIR7wp9+cFD8jtmt4RB8l1
 zy9AdmjslJRXH2MU/l5SEoe9GQnjiWUQJ5X57qLBmmgnHCy6cGcWIDIMxL51ADcP4jyk
 NI/JvHiuy1WaPUm2aiCido6Vp7SwMpLQuNwvWqZSN7giucactVLqzvs195tViOazMwz9
 isec79qUsL10nUtavnZRW2UcTdAzJlABe3pGC76uLkuQ/nLrDCEReMA/fYY7jJY1zGy8
 9QcxnMHWvJUbtzwv0wXywTHOowEmciGzbL+A4QmxpVvnLQr0MxYNLI8MJSxky5SPVL4+
 XucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386779; x=1779991579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xwKyzvKGVgaO8EcP27LLv6xm0YnG4TDP4DS/iOvmCTQ=;
 b=Eb4Z8bCwzmtiYYOYoboM78c3AClxLMwnslDWB5i91ee2B7IuW/seE/ePi5Gny+BDYG
 AeUQQOn5P3r8N9EQhpLdfaKPsukI6y/gPgwPnHRFmbExxfN59mnMl5Z1dHjzR1VrzwyK
 +STdr4rYoUe//oK10k1+Ms3HgSOJbpo7N8KpPDrK79GBhhlvTKsblU1ieyw6yHu26ya/
 MQpvja2mV2oJBeni+8i6CFSmC5XO67EPqiU1IsQ2t95QkXiiN774XxKqvCwpdfwueJVg
 flgBgXBBeCzXfVQVy5HiH86kyyV7V9N5xyT8EFVKNvvzZ3eA+ymESsD0sFSPHBTpwSP1
 mrJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ++gAz5SZqjb5RgKkc6R6ZfMStYxgSKrh7ixyV9jrDYGl5HvVWAOrH8bB4dVjvel4Yl2TA34UE=@lists.denx.de
X-Gm-Message-State: AOJu0YyoxEB/K1HOY/lrPNmqlUlVRTwghYvtWPSrXrL82Djo14ubaJPp
 SbgzbVLK6nkCHZDNccpmqkDBO5/nO5whsEkMUG1KRzdwoUxZhRMl2xl9wZs0PuPH+e47LSZv5TU
 Obds7Gl15pvywV/vydD+ZyGbk09z3Annwh6K1nVja7FiGsXV33fJfeqaZ
X-Gm-Gg: Acq92OGGljD3JKLFS7c81LSKW430ruWs5pjBcrOseT27DGP12go3qcDW3foWsgrgqWv
 9lDNo7OIj8/+o0la0chyXNJawzGQTVP092Zhna0zeRMC9kYKVb3yWP7H2GT/KNbwbaDhzkCQbKv
 68XbYH2i1sPtR+Erjlc3jAOjba81VyhMO3eqr4jLQ8xv1jDnWNpLupX7JSHBZNBdyiJPlmycULu
 h8RJ6cBsPHqbfGp1OmOsqvyLyVZaMvYAyzpzBxYq2827d6pcVLQ8OaSo49JGzOvNo2nzuX/JJIw
 9RNJvMvsiEvw0cDLaAZWcls/NnaA6hj/r8EOHYBuJ0Zonz+OrqsWeBY1HFZxfXwAH/HRLlRskN6
 RwcLJlwv5mDALYxY4Ta745qAgvlkFpbIiUE6OXSWGYXWEzCP54UW4J0zRrFsNaJa2nviPTv+vI6
 T9F1n2atYL2KISmgo0uKRyswHTjIken+WoroUpKwkK
X-Received: by 2002:a17:903:190:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2bea3338a8cmr43725865ad.27.1779386778511; 
 Thu, 21 May 2026 11:06:18 -0700 (PDT)
X-Received: by 2002:a17:903:190:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2bea3338a8cmr43725075ad.27.1779386777928; 
 Thu, 21 May 2026 11:06:17 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:17 -0700 (PDT)
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
Subject: [PATCH v5 1/7] misc: Add support for bit fields in NVMEM cells
Date: Thu, 21 May 2026 23:35:43 +0530
Message-Id: <20260521180549.282377-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ILVptAgw9KsFHO0SVrt6sJbyo3aNgzTv
X-Proofpoint-GUID: ILVptAgw9KsFHO0SVrt6sJbyo3aNgzTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX9gm/sMS5wNA3
 G9guc5RNcJivmZVbaIv8ubjQFQKtUotQbN80BA1smmAk/ffRgzxEZSDONUK+qcKZbkawTQL1/Rt
 nT0Xj7jWuw5o3cH7Aq7oDOMR4rZDY7HiZgaykjtUX8kbtaAewddIF9k4XyF6hENLFGw8Mwn01zi
 6rrHnKbHSHKImkjmxYOeAC+GYXo6biMlgFP9+4mU6LGFTnCZ1YYymPJByQaqzGAe9t9Ks5nlWRU
 /7Y8pKemdU7tOMwZFDfyml4SAuqnLw6i7DJWxc9RZG6r4XdGydj7L2rhu1SF52lw2iOEoLLLrhD
 nl/OQtMVWrTHTJomnsCiBCJOjMNPgNAB06PUrzhloR/woBzKjLRiEQPUwecNlcqH2kcSdXsvz9a
 KgdzrElS6VCoiDf/HEERRg608+uCQI5FN+UFszfDIDK730U787SzLpoXJf3TmfpXr2yQLx28FXC
 Lu4K10wUg3iBtpEPrJw==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f499b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=T-YsAnR6KVLXiY_LWkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210182
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
                bits = <0x01 0x07>;  /* 7 bits starting at bit 1 */
        };

This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
untouched during write operations.

Cells without the 'bits' property continue to work unchanged, ensuring
backward compatibility with existing device trees.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v5:
1. No change in v5

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
index 33e80858565..03538343a29 100644
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
+			dev_dbg(cell->nvmem, "bit field requires buffer size %zu, got %zu\n",
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
+			dev_dbg(cell->nvmem, "bit field requires buffer size %zu, got %zu\n",
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

