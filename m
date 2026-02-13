Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619DCEDF148
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A3D83CEE;
	Fri, 13 Feb 2026 12:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GdnPLhg7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5DSjSj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA7483CBD; Fri, 13 Feb 2026 12:27:53 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8093E83CEE
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D4i0RE3951637
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4fdNZ/nnmDA
 qKBhzVNkMUmbM3aVDC7uqk4LwzdSB48Y=; b=GdnPLhg7MsmvS86hiAVbn0wdi0Y
 +xG/5lqpSepmjWTxaXyw19lR2d0Gg5JCKfdpSv8zZqfSclP+wfIOrbRHLil2ikYD
 em7n0j7gt+jmXH9w7Nr6YnrC3Ee8+d4t/uylQ3MqLLXUgWp8JNg9JqvxdDtv6SxE
 A15ViZGZ2ruOtQzYNvkRbiwEWAq6f3JSQFxRN/2coBwyA6aEdS0KBzUy0GFk4Gze
 yQuAkhSyBCCC9P+s66WUQvTgFLH50fB7A8n/xLhSGVwGcRt7GGszTY3dXskq6yy1
 fDkfT0L54fWIe6NUsZJCCVdoE1HQ1AD6VDUNHR6xz32k1Sfjtwu5MBG/EvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ps2tmqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35301003062so3600672a91.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982068; x=1771586868; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fdNZ/nnmDAqKBhzVNkMUmbM3aVDC7uqk4LwzdSB48Y=;
 b=M5DSjSj7IzWiDymziNNjd4fnwhAMUdbLfKxXJiVrf79DPrY9kPkuXjPCmEFUq1bDao
 xr2biuj//TfNpVYokQ1mt7KP72JsBCgdCZ87/hsJiqKTeKRfwWMVkIrFjidRPFR0sr7Y
 CtpCSTl51fTk+fYsYBI7G6gJlJVO2tz2iqWlItXFq1aNFcxbp2JandIjgpeL85u/MUk6
 +L+2Dr1+jxbSl6ihald8Wi/e2zJrEJrdP45EdYaojxRzraDxmrRQ/MSktfZbCIvIQAdy
 Aa1eQXO+ZzcGWBD6E72StfFwUZufE+E9Oow7OlLJO1SRFKTIW0SeB9e4ARNLxbXPoBCB
 oEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982068; x=1771586868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fdNZ/nnmDAqKBhzVNkMUmbM3aVDC7uqk4LwzdSB48Y=;
 b=DlUJnvAVVyRp9xzMGm/k0QmbP1QG7Bzr1rqC+Cba9Kd/NEbN+HHZNtXZXSNNwsTN+/
 +aY+fgwa+VfyW3bPV8XMgERyM9OKrMDTTyOf706H+zjcOWZOgnsMZNEtvcqh0c5EI0nD
 lZdi6VfuMoIVwgL8C5m2kxO4qVAYewBZSQ+Sg3td3nGVqyCpjFqOWwBf5dG2ikG9tHrX
 L8CN08B5wSAf0c6XRNvRb6poPuScbqXhAKhd4/4CYu/NGIcnkyUo7l1G2Ag/C1lA9299
 lfdDVkSL5AqKJt/IJUMrOr/+nR/zeUZG4I1jliO4Bf2K1jwP7QlfS0/o0VkBXfLeq3I6
 xxbA==
X-Gm-Message-State: AOJu0Ywg0osdr0ViU3bNXr6KFnJ8mOpcU1v0mdm1C8GU1unviT+3yhVP
 LoyFwD3KF2xMZvJta+6JMIar3Vn8N9qUBofO8K9OH4lPhexwRHRvRrY07KdaP3TdVjc/voWLR3f
 y1LwaQyQXhxZtzmt9kNVoZmjDyvwIbjNCPSK+zcCG9hiz0jCp8NozAPI3WtAy5OiH
X-Gm-Gg: AZuq6aJS1cfI+vtosFd+TCbwv0KWMltadnZgYzPKUQrIPFxBDYR7Qf6TPYUn4+cON4R
 D8VE20HoPNwIXhA64KaRvMZgKejlCKoI6f37CAoM2ufPabi+S6bFuNqqikCDKVse4pB/MTX1Lb0
 z/VL12TpG4YZHCjhVrp+/jabQjmJ+pMNVuTOT29KXVDsmEjJDViKahVmS/oea8qxL8q0RbUQNsR
 3GSjf1uaOBlkwAN0cEv8hlWoNXjWJ2M5rGXqbfrFB9K/Y0p9iXHvL3c7Sz+Xw+iZLjE1H08K8hr
 XOhOZO9CwgB7j72vu3UqQcclYmPxGKbzL23yHYBjBiTkW+cTFiuYm3XBFsanb9y3ScDMZgm9dsX
 m9l52EmZU7zWxY+v6g7TxIzAMbLm+HRURpfQqOYYGdbUoVF5FCan57t+Og5ngqwyqxFJ3UzAFuA
 fXQyRrx2j+u8X+CeJrOUPWnpQwYwll48ugUpq776n4
X-Received: by 2002:a05:6a20:3d0f:b0:38e:9acd:97aa with SMTP id
 adf61e73a8af0-3946c7869bdmr1435547637.28.1770982067618; 
 Fri, 13 Feb 2026 03:27:47 -0800 (PST)
X-Received: by 2002:a05:6a20:3d0f:b0:38e:9acd:97aa with SMTP id
 adf61e73a8af0-3946c7869bdmr1435517637.28.1770982067079; 
 Fri, 13 Feb 2026 03:27:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:27:46 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
Date: Fri, 13 Feb 2026 16:57:13 +0530
Message-Id: <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y2U67xwVBKKBkQXEhM8AU9dv36AiADld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX84xIacRRvfdO
 z13lKwBPfO7oVgpaDw7ARjwrkcUz2efL3y2YcfoXBe5Rf4CGd39K8LS1GqptwoaKArYUlAcMdDv
 lY8+tijRfo0uB20K47Y/08rlKGdGl+bMQX0wXn8TL6Sp1GjmpqveTkCPCGGIj+/bD4oL5qDGIpz
 9sMAIEdNx+VCkgL2J1SUogw457nBlsRQn7nPq9cMkpgthi3gGxVpJ340GZHriByGpuTAzI4EW/g
 8JBpS8Pcb+E+kRFZwJvUR5IFALID1oaT3m5yzOkiGIfMzhn0uFjd2GXH4k/tjuApTcD1afFqkEt
 j3WYPor0U+8rfrVimZ5bUr5vRBhwHOP1dCx3RrclllFJgYhi9hO9wbtp+MFhCc5AEybJEsEgl1N
 GFezRZmbrpynvEqyceRRt3mb0+PCxMadctubgFxBbUqpEyOM8Se3dIRq8ASTNsJVKboCGBuKEGU
 DQGli+/FXZoGm9kwg/w==
X-Authority-Analysis: v=2.4 cv=LoOfC3dc c=1 sm=1 tr=0 ts=698f0ab4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=g_Wre9PPLzhfHXV9akwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: y2U67xwVBKKBkQXEhM8AU9dv36AiADld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

NVMEM cells currently only support byte-level access. Many hardware
registers pack multiple fields into single bytes, requiring bit-level
granularity. For example, Qualcomm PMIC PON registers store a 7-bit
reboot reason field within a single byte, with bit 0 reserved for other
purposes.

Add support for the optional 'bits' property in NVMEM cell device tree
bindings. This property specifies <bit_offset num_bits> to define a bit
field within the cell's register space.

Implement multi-byte bit field support by porting bit manipulation
algorithms from the Linux kernel driver [1]:

1. nvmem_shift_read_buffer_in_place() - Extract bit fields from raw
   bytes by shifting and masking across byte boundaries. Handles fields
   that span multiple bytes.

2. nvmem_cell_prepare_write_buffer() - Perform Read-Modify-Write to
   preserve bits outside the target field. Read current values, mask to
   preserve adjacent bits, and combine with new value.

Example device tree usage:
        reboot-reason@48 {
                reg = <0x48 0x01>;
                bits = <0x01 0x07>;  /* 7 bits starting at bit 1 */
        };

This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
untouched during write operations.

Cells without the 'bits' property continue to work unchanged, ensuring
backward compatibility with existing device trees.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvmem/core.c

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/nvmem.c | 241 ++++++++++++++++++++++++++++++++++++++++---
 include/nvmem.h      |   4 +
 2 files changed, 231 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index 33e80858565..6a75c326189 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -12,52 +12,251 @@
 #include <dm/ofnode.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+
+/**
+ * nvmem_shift_read_buffer_in_place() - Shift read buffer to extract bit field
+ * @cell: NVMEM cell with bit field information
+ * @buf: Buffer containing raw bytes read from NVMEM
+ *
+ * This function shifts and masks the buffer to extract only the bits specified
+ * by cell->bit_offset and cell->nbits. It handles bit fields that span multiple
+ * bytes by shifting bits across byte boundaries.
+ *
+ */
+static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
+{
+	u8 *prev_byte, *buf_ptr;
+	int i, extra, bit_offset = cell->bit_offset;
+	int bytes_needed;
+
+	bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+
+	prev_byte = buf_ptr = buf;
+	if (bit_offset) {
+		/* First byte: shift right by bit_offset */
+		*buf_ptr++ >>= bit_offset;
+
+		/* Process remaining bytes, combining bits across boundaries */
+		for (i = 1; i < bytes_needed; i++) {
+			/* Get bits from next byte and shift them towards MSB */
+			*prev_byte |= *buf_ptr << (BITS_PER_BYTE - bit_offset);
+
+			prev_byte = buf_ptr;
+			*buf_ptr++ >>= bit_offset;
+		}
+	} else {
+		/* Point to the MSB */
+		prev_byte += bytes_needed - 1;
+	}
+
+	/* Clear extra bytes if result fits in fewer bytes */
+	extra = bytes_needed - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+	while (--extra >= 0)
+		*prev_byte-- = 0;
+
+	/* Clear MSB bits if any leftover in the last byte */
+	if (cell->nbits % BITS_PER_BYTE)
+		*prev_byte &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
+}
+
+/**
+ * nvmem_cell_prepare_write_buffer() - Prepare buffer for writing bit field
+ * @cell: NVMEM cell with bit field information
+ * @buf: Buffer containing value to write
+ * @size: Size of buf
+ * @data: Output buffer with prepared data for writing
+ *
+ * This function performs Read-Modify-Write to preserve bits outside the
+ * specified bit field. It reads current values, modifies only the target
+ * bits, and prepares the complete bytes for writing back.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
+					   const void *buf, size_t size,
+					   u8 *data)
+{
+	int i, rc, nbits, bit_offset = cell->bit_offset;
+	int bytes_needed;
+	u8 current_val, *prev_byte, *buf_ptr, prev_byte_val, prev_bits;
+
+	nbits = cell->nbits;
+	bytes_needed = DIV_ROUND_UP(nbits + bit_offset, BITS_PER_BYTE);
+
+	memcpy(data, buf, size);
+	prev_byte = buf_ptr = data;
+
+	if (bit_offset) {
+		prev_byte_val = *buf_ptr;
+		*buf_ptr <<= bit_offset;
+
+		/* Setup the first byte with LSB bits from NVMEM */
+		switch (cell->nvmem->driver->id) {
+		case UCLASS_I2C_EEPROM:
+			rc = i2c_eeprom_read(cell->nvmem, cell->offset, &current_val, 1);
+			break;
+		case UCLASS_MISC:
+			rc = misc_read(cell->nvmem, cell->offset, &current_val, 1);
+			if (rc < 0)
+				return rc;
+			if (rc != 1)
+				return -EIO;
+			rc = 0;
+			break;
+		case UCLASS_RTC:
+			rc = dm_rtc_read(cell->nvmem, cell->offset, &current_val, 1);
+			break;
+		default:
+			return -ENOSYS;
+		}
+
+		if (rc)
+			return rc;
+
+		*buf_ptr++ |= GENMASK(bit_offset - 1, 0) & current_val;
+
+		/* Setup rest of the bytes if any */
+		for (i = 1; i < bytes_needed; i++) {
+			/* Get last byte bits and shift them towards LSB */
+			prev_bits = prev_byte_val >> (BITS_PER_BYTE - 1 - bit_offset);
+			prev_byte_val = *buf_ptr;
+			prev_byte = buf_ptr;
+			*buf_ptr <<= bit_offset;
+			*buf_ptr++ |= prev_bits;
+		}
+	}
+
+	/* If it's not end on byte boundary */
+	if ((nbits + bit_offset) % BITS_PER_BYTE) {
+		/* Setup the last byte with MSB bits from NVMEM */
+		switch (cell->nvmem->driver->id) {
+		case UCLASS_I2C_EEPROM:
+			rc = i2c_eeprom_read(cell->nvmem,
+					     cell->offset + bytes_needed - 1,
+					     &current_val, 1);
+			break;
+		case UCLASS_MISC:
+			rc = misc_read(cell->nvmem,
+				       cell->offset + bytes_needed - 1,
+				       &current_val, 1);
+			if (rc < 0)
+				return rc;
+			if (rc != 1)
+				return -EIO;
+			rc = 0;
+			break;
+		case UCLASS_RTC:
+			rc = dm_rtc_read(cell->nvmem,
+					 cell->offset + bytes_needed - 1,
+					 &current_val, 1);
+			break;
+		default:
+			return -ENOSYS;
+		}
+
+		if (rc)
+			return rc;
+
+		*prev_byte |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & current_val;
+	}
+
+	return 0;
+}
 
 int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
 {
+	u8 data[size];
+	int bytes_needed;
+	int ret;
+
 	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
+
 	if (size != cell->size)
 		return -EINVAL;
 
+	/* Calculate how many bytes we need to read */
+	if (cell->nbits > 0) {
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > sizeof(data))
+			return -EINVAL;
+	} else {
+		bytes_needed = size;
+	}
+
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_read(cell->nvmem, cell->offset, buf, size);
-	case UCLASS_MISC: {
-		int ret = misc_read(cell->nvmem, cell->offset, buf, size);
-
+		ret = i2c_eeprom_read(cell->nvmem, cell->offset, data, bytes_needed);
+		break;
+	case UCLASS_MISC:
+		ret = misc_read(cell->nvmem, cell->offset, data, bytes_needed);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != bytes_needed)
 			return -EIO;
-		return 0;
-	}
+		ret = 0;
+		break;
 	case UCLASS_RTC:
-		return dm_rtc_read(cell->nvmem, cell->offset, buf, size);
+		ret = dm_rtc_read(cell->nvmem, cell->offset, data, bytes_needed);
+		break;
 	default:
 		return -ENOSYS;
 	}
+
+	if (ret)
+		return ret;
+
+	if (cell->nbits > 0) {
+		/* Extract bit field from raw bytes */
+		nvmem_shift_read_buffer_in_place(cell, data);
+		/* Copy only the bytes containing the bit field result */
+		memcpy(buf, data, DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE));
+	} else {
+		memcpy(buf, data, size);
+	}
+
+	return 0;
 }
 
 int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size)
 {
+	u8 data[size];
+	int bytes_needed;
+	int ret;
+
 	dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, cell->offset, size);
+
 	if (size != cell->size)
 		return -EINVAL;
 
+	if (cell->nbits > 0) {
+		bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, BITS_PER_BYTE);
+		if (bytes_needed > sizeof(data))
+			return -EINVAL;
+
+		/* Prepare write buffer with Read-Modify-Write */
+		ret = nvmem_cell_prepare_write_buffer(cell, buf, size, data);
+		if (ret)
+			return ret;
+	} else {
+		bytes_needed = size;
+		memcpy(data, buf, size);
+	}
+
 	switch (cell->nvmem->driver->id) {
 	case UCLASS_I2C_EEPROM:
-		return i2c_eeprom_write(cell->nvmem, cell->offset, buf, size);
+		return i2c_eeprom_write(cell->nvmem, cell->offset, data, bytes_needed);
 	case UCLASS_MISC: {
-		int ret = misc_write(cell->nvmem, cell->offset, buf, size);
-
+		ret = misc_write(cell->nvmem, cell->offset, data, bytes_needed);
 		if (ret < 0)
 			return ret;
-		if (ret != size)
+		if (ret != bytes_needed)
 			return -EIO;
 		return 0;
 	}
 	case UCLASS_RTC:
-		return dm_rtc_write(cell->nvmem, cell->offset, buf, size);
+		return dm_rtc_write(cell->nvmem, cell->offset, data, bytes_needed);
 	default:
 		return -ENOSYS;
 	}
@@ -121,13 +320,27 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 
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

