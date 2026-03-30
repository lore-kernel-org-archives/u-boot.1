Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5E41061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9048584056;
	Mon, 30 Mar 2026 19:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ddl2CptG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8FKIuwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D357E83DBF; Mon, 30 Mar 2026 19:14:54 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8DB83DBF
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGCCYQ3173878
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ub3w5r5ERnT27Tt8pqmB4/FZhi0rKt0JwJy9n8K+EgU=; b=Ddl2CptGYlOjqrgU
 jqEx6t7isLACVHlogB+0N+LNls8g4f6NHvZY8bwZCI/MUMnYHAJ1BrxpmJu1Q6HY
 0lRqSM4JKgOMRVXdn62A9W+vlKIGePbmjWsIZXgFoVmk71+VCGIAlqx6YvAhnlbG
 YP/g6mHjpa5M5O05nOgC1YIjJY5zXNz3vA6GM1MQTPQnzxpS+uyNg/57F31bQ6sj
 luAUz9oMo8Tt/FcLVyak1lAeSPQ0G47hNoZ2gUbZJW4KXAIi0cnpcESpM/1xu5lz
 HyX5mR8uDe85GGhp2PWRs+rdFLF2Zrpd1mtEzfeUDGLrKqjLmzoIxgEQfTZYw7Tg
 Jm6skg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h1mvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:14:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c739120475fso3072326a12.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890890; x=1775495690; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ub3w5r5ERnT27Tt8pqmB4/FZhi0rKt0JwJy9n8K+EgU=;
 b=I8FKIuwBdtVNXExQcQKKio+ICc0dY+80uLXWJxMNamVLD53swGBBIZC9r/7ZeVQizT
 vF/SR4hi11kx4E84gyejMevh0RSUVMMuF/Uy1ZmKJN7MeoZeTi57822SzkECiANSHZBB
 Q49ptp7S5XAUBCUjXlNEwmR3XHXRg9dIM8esQVW7oGsM43bkURr+WwvnD5nEnc0wGHW6
 VS59Ciz1P+bonx2BEYAF1EtC44nmjbbgIF+2UCpCWtE6LUwhi8lUUIL2ULsW8YtWlwUI
 DsxZ4dpUjZg3S2E0Ulpq0wwxKrB+1YQkRLUTYP/L8Efp4YGitl4/ofTk8q1NCJ0RQm3a
 ARKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890890; x=1775495690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ub3w5r5ERnT27Tt8pqmB4/FZhi0rKt0JwJy9n8K+EgU=;
 b=LCK+k8piTE58KD7rSId3W68fJAETzRVsWiYNlotpC4TQVWc/W61vgKvyx3h+yE7RXb
 st1y6AZWiIEUjDD+i+cfqJ64Z0n8lJfWSrt9rP8sxpKmMARjJQedDhqDRbiEx6k37xvf
 WFgcSUIkhxAU/o3TeVNv2OzEQJIZoHd9HJlbBo3WzOK8nPJ6ekDJy6csov/TaCH/XVGU
 PfFNv40FwQzQxDiGDbHG7Zc7FML74y0/26FpFAi6Km/PychkAkQJ8+TaTBXA//+8L+PJ
 0oomc4smjKlQAauvEIACYEiEtxx95j2UvnSOERE2DG0Fm2aB4zqnlrlKbF5dk4FdtThN
 dsJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF2KdOx/vlPm/e6qmkm4t2YFqg7RHoM/cJy0emQiCXSDvOEEnW+DZF04+u9nT8VQbv9WuSqUc=@lists.denx.de
X-Gm-Message-State: AOJu0YyoeZmtTTw6JDGNDwkIZ9ZgLZ4j1Xl4uyvZPSzKOlpQmOsm+FeQ
 Hfr9kjRuLqNjT0hLLgQVHHJBzM0tCyQVh/w8go1diVc4tcsEpJfA+YokVFTFZfLeEvUPJGSq/5w
 TgUnR8QFL20xbzEknmSWRGEPC2XHjCLJLe1/onpBwvt4/UaaU5JYiLjZN
X-Gm-Gg: ATEYQzxbq/fiLDkSR4fhKhssrmeAgGHjtAH5UhTcX9YodBHeT5kXQl5e2sVRdEof3z5
 hcerDHohe4tEhKMjkF+8JVSwJhUra0v3EAR4uaHtCepWPn2DpB5UhgkVpCFBI4zHfdqRZDjwMNf
 uIkaWhRGeyiMIfBy3AqUDMhkyz+mVa0g3qh86LAZZtCxoXrQ0KT2mBWN40LiuIU+EWlI6aFzMFw
 8S6+wvwKca+lJtHPkjJok8lfKqK9T1o/q9ZngKwzGE0yrBsUamqLutmsG27myWLHLDTRF4vwbS1
 mMwT6d5WrLuZ5q4VyxoMw2jaHtfETE2vyZct/rvAJII+iTvIjVnRAYboe6mimJQ/clrqMocYNwI
 jWf0QmzyGAM27L6Efja030dG9jheuVqCP0TZKI5V/Zb+ihXbcwI9ksvIZ1CILWV6VR3pCuTGbfn
 9gVQ0A6oCkSQoblTu1zZNW/N0EdAO8syVcj/CWbFSM
X-Received: by 2002:a05:6a00:27a0:b0:823:cbb:a484 with SMTP id
 d2e1a72fcca58-82c95d45b1fmr12549393b3a.14.1774890889519; 
 Mon, 30 Mar 2026 10:14:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a0:b0:823:cbb:a484 with SMTP id
 d2e1a72fcca58-82c95d45b1fmr12549359b3a.14.1774890888921; 
 Mon, 30 Mar 2026 10:14:48 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:14:48 -0700 (PDT)
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
Subject: [PATCH v3 1/7] misc: Add support for bit fields in NVMEM cells
Date: Mon, 30 Mar 2026 22:44:13 +0530
Message-Id: <20260330171419.1117817-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MCBTYWx0ZWRfX4tGhleJNP5Qh
 ImT4IfM8PAH5A8H+NrM7kH4CAo7IomRITPYSTBPZg9XB0nDJR70FhXK49KJkUTEgFVS4GfEaEm5
 JRrW8boTdyucpRL41lq0A6BYCWhTE/yMXRPnvF14wmFKAC1NVn2JD4OEQyaTwzzLJPL7bIwYslk
 eENDXUjP0uKY0mhv7RcvlvfexhwlLSiXqoPiqGsRrlYhjlYZv7LtGAlqab8of56LQg1SDdQgBVA
 FXM+N3FZMjzndif0SwYSlP87XN+6B00s8k/Yyg/LpMBmMEk2e1wmIMZdRgEWjzcf8nVtNv3ZNiO
 CK8JSZL1bRr2JbVa4gUIyYjQEHGMvwxRL1ZilzLS2+pHWfIST2b/g3yYqKw7+Ph9cFe4JKxbayC
 /imps38X0EwOwfZxkMI1VNZiuQo3BH1tR9cejcJmHTBdwXXdI5vEy+XRl7/EVwZLxUXem+zsq7D
 PPl0Z5BhNmVLT4wHJcw==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69caaf8a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=77Gp4gJqd9K2asR3UTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: JL4BSR_TtpZR77W_xLOaB47ZUV7LShIq
X-Proofpoint-ORIG-GUID: JL4BSR_TtpZR77W_xLOaB47ZUV7LShIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300140
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
Changes in v3:
1. Simplified bit field handling to maximum u32 size (32 bits).
2. Enforced strict size matching (size == cell->size) when nbits == 0.

---
 drivers/misc/nvmem.c | 159 +++++++++++++++++++++++++++++++++++++------
 include/nvmem.h      |   4 ++
 2 files changed, 141 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index 33e80858565..883ced9e898 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -12,55 +12,156 @@
 #include <dm/ofnode.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
 
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
+	if ((cell->nbits && size < cell->size) || (!cell->nbits && size != cell->size)) {
+		dev_dbg(cell->nvmem, "NVMEM: buffer size %zu invalid for cell size %zu\n",
+			size, cell->size);
+		return -EINVAL;
+	}
+
+	if (cell->nbits) {
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE ||
+		    size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "NVMEM: bit field requires %d bytes, cell size %zu, buffer size %d, got %zu\n",
+				bytes_needed, cell->size, MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+	}
+
+	ret = nvmem_cell_read_raw(cell, buf, size);
+	if (ret < 0)
+		return ret;
+
+	if (cell->nbits) {
+		value = *(u32 *)buf;
+		value >>= cell->bit_offset;
+		/* Handle nbits == 32 specially to avoid undefined behavior */
+		if (cell->nbits < 32)
+			value &= (1U << cell->nbits) - 1;
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
+
+	if ((cell->nbits && size < cell->size) || (!cell->nbits && size != cell->size)) {
+		dev_dbg(cell->nvmem, "NVMEM: buffer size %zu invalid for cell size %zu\n",
+			size, cell->size);
 		return -EINVAL;
+	}
+
+	if (cell->nbits) {
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+
+		if (bytes_needed > cell->size || bytes_needed > MAX_NVMEM_CELL_SIZE ||
+		    size != MAX_NVMEM_CELL_SIZE) {
+			dev_dbg(cell->nvmem, "NVMEM: bit field requires %d bytes, cell size %zu, buffer size %d, got %zu\n",
+				bytes_needed, cell->size, MAX_NVMEM_CELL_SIZE, size);
+			return -EINVAL;
+		}
+
+		/* For bit fields, perform Read-Modify-Write */
+		ret = nvmem_cell_read_raw(cell, &current, sizeof(current));
+		if (ret < 0)
+			return ret;
+
+		/* Apply masked bitfield update (shift + mask + merge) */
+		value = *(u32 *)buf;
+		value &= (1U << cell->nbits) - 1;
+		value <<= cell->bit_offset;
+
+		mask = ((1U << cell->nbits) - 1) << cell->bit_offset;
+
+		*(u32 *)buf = (current & ~mask) | value;
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
@@ -121,13 +222,27 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 
 	offset = ofnode_get_addr_size_index_notrans(args.node, 0, &size);
 	if (offset == FDT_ADDR_T_NONE || size == FDT_SIZE_T_NONE) {
-		dev_dbg(cell->nvmem, "missing address or size for %s\n",
+		dev_err(cell->nvmem, "missing address or size for %s\n",
 			ofnode_get_name(args.node));
 		return -EINVAL;
 	}
 
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

