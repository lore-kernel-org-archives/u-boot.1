Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7DDCD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE4F84867;
	Thu, 21 May 2026 20:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E794uFku";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vnt6rMJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B0E8486A; Thu, 21 May 2026 20:07:06 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D955184825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGkFHX1658128
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d3h6Jl3ID3A
 NEE8xC9B4je2vd80LMhgxdYk+pe8nuec=; b=E794uFkuvcx9/5bGQoAL5/VwFnn
 rtuUZsDoOlJWCAJEhkA19CCtHou8JCTGGE6VYpcpybNNnC5l6qv5wJ7jfT8BgcZV
 qP+LgFb5804Gvx/+1DqysCWCRRkgSbcRx21cCLbRXnip5dYz1HNIj0nzaC9orIVo
 1FRTQZIXDkwn7+B47qf7k5N3PcQawYGrVzHik6ij2yzy4khY0dL3yH4lefrFo8Yy
 4rHnQdj5QfTI9LvAZeLuB6cfpt1qiVzXhgPou+TEo339pQcnbuW9NmI4u2x0k2fz
 qWCnVfl/94Xo0Q7+Ssxnetw8iEhcfZXDlR8El2DEbHHQoFjS9GaipYSx20w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkhua1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:07:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba054e0304so58604395ad.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386821; x=1779991621; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d3h6Jl3ID3ANEE8xC9B4je2vd80LMhgxdYk+pe8nuec=;
 b=Vnt6rMJTRsI8UZXN0Wfpiff4FAtwyYb0h2LTxxwYFrlLXQJZCU953fDSbRqwL0K4d1
 zv/odBJTaXuVF9x0fiWkIj9Yc8dinKr9Wnu5hrknC5cFlx6ssfY8NyKSFpXSGqf9ODpY
 Y3KBpBNny/KYDFOkTPvOsjKmMeaDPWMcINw/yfL6fm6L9VpYfIOmr3hSH4yHyUaEvyq1
 RKiHcyUWtRJ0PEqT4MJZ3MeZI1J80LdLwXXUEYKm4QWbLQAIMVQhw8iccLtCi8B+/BBz
 uJ5gLBA+q/U0inPKHFfBoSYe1PtPkinRW6JOm8rcQJF01EsAu87ECHimCH9AKPrdrEoW
 1IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386821; x=1779991621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d3h6Jl3ID3ANEE8xC9B4je2vd80LMhgxdYk+pe8nuec=;
 b=Desgm0+birwhCGTsvcAe3DrGi5oCw5fJRnf0WazNAoLdjvLgKAA7Jp1iINOEhw0yIc
 Rw3QeDRVLU/GbZva9VYMKaGiVVzDFETs4+J5hFj/W4ZKKK6aMhqSuv49cvU6M925W6dI
 Z0wUp6c5S86naoRBwEbd6fK9RD6+Sq3RIUJEC98FbGx0NlzGaX9kday2p3QEvwh/0zyx
 ujJq885z5gQudiOQqFU1Fu1AYb7Zy8jGurQl6RgsRB7SXVAq0+PJUMNLXYr8xlsXa2BN
 lhfYutT8TUZIQKFQw2hXjW9/CSGAZLGsDpnwDjFo/O6kj9xrqBD4wQEposfjw/reQ1ZG
 L+Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rgR06aqtdz8vh5SnuyFu+AtPFjGm2+7PreDPzJWUmk5OIEp/SE2tnNzzc2RHtb6YtdmyESgc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzszh4uY9JNR6cVHJfzhBIf/TfOD2TIH8sRXXY6DrdAUokAj/3i
 hDqcNkEELiQ5k3i4/fGYW+nl4XEAleCMKzvPuF61AjrZRbT6SrSgBgv5Au9Bm8tM8hbMwLriYi7
 1X+adjZOM9EIo+XA21ieBCm4cBIAQclzvJcL+CFsbPJO+k0clh8QL1wlB
X-Gm-Gg: Acq92OHF7bdZCnJEQnqimWYKMaN8dazoG58U0v8XBRyTFsKbS4gO4DEvmGR9nQpLhXY
 l/hUwLVQH/qg04eUt4pVyoR8+H/uqqzQnK3NBn/Spc69JChOkorLiQ+NlKGXAD5Cf6m4F4QBHUh
 o2IBC+IYC9afeizNkgcOyT/USxPS2NZMXUlloLfPo+1K3BsQXuObqHS7CARI34R5vRIXlK+poH2
 n1QqZS2yyluG7nyvR68obQNWADeX34teVTTCuxv/MA9vJKgq1tcElKXNZallF1WP57RQQ3NFX52
 OFo85bGI3pXzFxAwHOuCBz+zOsGkNLsqGWh/UDGL1eyUJJ3dOKkcsLZ8jNPzFZBfMZ13qCcIRJy
 m0TXCiV6dTTvAeqLoETzMPUIw9c90R1EqyHjLYaeZMRwgcdxDn776PVXi/RV+6gqwPMX4xiXG/J
 vI9GNfdHkIjAQvxQBTiMdc1b6Ext75w+u4UXYcxOF7
X-Received: by 2002:a17:903:2285:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2bea25fe683mr35300855ad.10.1779386821088; 
 Thu, 21 May 2026 11:07:01 -0700 (PDT)
X-Received: by 2002:a17:903:2285:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2bea25fe683mr35300505ad.10.1779386820541; 
 Thu, 21 May 2026 11:07:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:00 -0700 (PDT)
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
Subject: [PATCH v5 6/7] test: dm: add comprehensive tests for NVMEM bit field
 operations
Date: Thu, 21 May 2026 23:35:48 +0530
Message-Id: <20260521180549.282377-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfXyX84m5DFHeUM
 n1cvQsZ8pUDctVx2lQPXJFFxdZUuJYj92q1ENsn7FYvOKkJ0rtW4jNiIc0PQscSsYcHtYpZwTtU
 rpY9PLqvxnfq/ufsdu8qblP0TH2WCqWXIxfuiUJIrHKZRMHmalEg3hK51C9fU2TUnMwar7hAyFM
 MYfJLQi4q8BGfaErfP4O7pnxobdh4BvRfZaapQrXabjhsXUgUl2aOsZ77MU8SUTj9RiGNW6/vRy
 iWHB/ECKFOxyPKuumGAqtkWb0fIPD8ehX2Vc33zTdX8zys4C73qP8mJJkCZHKwTOS0jbNLCYRkv
 4ByFB6YwtBKOOCDVDr484vgyjvuN50JK+KIzs4D27XeKO1j3MY/JWR1kqEUeL2d4HHsRlTXQPWt
 vE4H1MM/5cjb9zNUPm8is0j2RY1WgOzo8uZU8iRK28L5IH9v1uANDtaJmSGF2jO9cJSy70u/9Kl
 jtUFOGMdQ5Vf0Lziwuw==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a0f49c5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=W1BiHNyAc7_2oUjjS0wA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ffsWxU7fvPPAW7Xm0dMXCps_HwYIcOZs
X-Proofpoint-ORIG-GUID: ffsWxU7fvPPAW7Xm0dMXCps_HwYIcOZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210182
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

Add a mock I2C EEPROM device (nvmem-test@50) to the sandbox device tree
to support NVMEM bit field operation testing.

Add test coverage for NVMEM bit field read and write operations to
validate the new bit field support in the NVMEM subsystem.

Test cases include:
- 1-byte cell with 7-bit field (Qualcomm SDAM reboot reason use case)
- 2-byte cell with 12-bit field spanning a byte boundary
- 4-byte cell without a bit field (legacy byte-level access)
- 4-byte cell with a 16-bit field in the upper 2 bytes

Error validation tests cover:
- Bit field exceeding the cell size
- Bit field exceeding the 32-bit maximum
- Invalid bit_offset and nbits combinations
- Buffer size mismatch in non-bit-field mode

The tests verify:
- Correct bit extraction during read operations
- Read-modify-write behavior preserving unrelated bits
- Proper error handling for invalid configurations

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v5:
1. No change in v5

Changes in v4:
1. No change in v4

Changes in v3:
1. No change in v3
---
 arch/sandbox/dts/test.dts |  12 +++
 test/dm/Makefile          |   1 +
 test/dm/nvmem.c           | 160 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 test/dm/nvmem.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..769f43efe4d 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1021,6 +1021,11 @@
 				sandbox,filename = "i2c.bin";
 				sandbox,size = <256>;
 			};
+			emul_nvmem_test: emul-nvmem-test {
+				compatible = "sandbox,i2c-eeprom";
+				sandbox,filename = "nvmem-test.bin";
+				sandbox,size = <256>;
+			};
 			emul0: emul0 {
 				compatible = "sandbox,i2c-rtc-emul";
 			};
@@ -1038,6 +1043,13 @@
 			reg = <0x41>;
 			sandbox,emul = <&emul_pmic1>;
 		};
+
+		/* Mock NVMEM device for bit field testing */
+		nvmem-test@50 {
+			reg = <0x50>;
+			compatible = "i2c-eeprom";
+			sandbox,emul = <&emul_nvmem_test>;
+		};
 	};
 
 	i3c0 {
diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66..ca2401dabc1 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CMD_MUX) += mux-cmd.o
 obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
+obj-$(CONFIG_NVMEM) += nvmem.o
 obj-$(CONFIG_MTD_RAW_NAND) += nand.o
 obj-$(CONFIG_UT_DM) += nop.o
 obj-y += ofnode.o
diff --git a/test/dm/nvmem.c b/test/dm/nvmem.c
new file mode 100644
index 00000000000..dd8d0151d2b
--- /dev/null
+++ b/test/dm/nvmem.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for NVMEM bit field support
+ */
+
+#include <dm.h>
+#include <i2c_eeprom.h>
+#include <nvmem.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int nvmem_test_write_raw(struct udevice *dev, uint offset,
+				const void *buf, uint size)
+{
+	return i2c_eeprom_write(dev, offset, buf, size);
+}
+
+static int nvmem_test_read_raw(struct udevice *dev, uint offset,
+			       void *buf, uint size)
+{
+	return i2c_eeprom_read(dev, offset, buf, size);
+}
+
+/* Test NVMEM bit field operations */
+static int dm_test_nvmem_bitfield(struct unit_test_state *uts)
+{
+	struct udevice *nvmem_dev;
+	struct nvmem_cell cell;
+	u32 value;
+	u8 hw_value_u8;
+	u32 hw_value_u32;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_I2C_EEPROM,
+					      "nvmem-test@50", &nvmem_dev));
+
+	cell.nvmem = nvmem_dev;
+
+	/* Test reg = <0x0 0x1>; bits = <1 7>: */
+	cell.offset = 0x0;
+	cell.size = 1;
+	cell.bit_offset = 1;
+	cell.nbits = 7;
+	hw_value_u8 = 0x01;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, &hw_value_u8, 1));
+	value = 0x7f;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0x7f, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, &hw_value_u8, 1));
+	ut_asserteq(0xff, hw_value_u8);
+
+	/* Test reg = <0x18 0x4>; bits = <4 12>: Spanning byte boundary */
+	cell.offset = 0x18;
+	cell.size = 4;
+	cell.bit_offset = 4;
+	cell.nbits = 12;
+	hw_value_u32 = 0x0000000f;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	value = 0xfff;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0xfff, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	ut_asserteq(0x0000ffff, hw_value_u32);
+
+	/* Test reg = <0x9 0x4>: Full 4-byte access without bit field */
+	cell.offset = 0x9;
+	cell.bit_offset = 0;
+	cell.nbits = 0;
+	value = 0x12345678;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0x12345678, value);
+
+	/* Test reg = <0xc 0x4>; bits = <16 16>: Upper 2 bytes */
+	cell.offset = 0xc;
+	cell.bit_offset = 16;
+	cell.nbits = 16;
+	hw_value_u32 = 0x0000ffff;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	value = 0xffff;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0xffff, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	ut_asserteq(0xffffffff, hw_value_u32);
+
+	return 0;
+}
+DM_TEST(dm_test_nvmem_bitfield,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* Test NVMEM error handling for invalid configurations */
+static int dm_test_nvmem_bitfield_errors(struct unit_test_state *uts)
+{
+	struct udevice *nvmem_dev;
+	struct nvmem_cell cell;
+	u32 value;
+	int ret;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_I2C_EEPROM,
+					      "nvmem-test@50", &nvmem_dev));
+
+	/* Test bit field exceeding cell size */
+	cell.nvmem = nvmem_dev;
+	cell.offset = 0xd;
+	cell.size = 1;
+	cell.bit_offset = 0;
+	cell.nbits = 9;
+
+	value = 0xff;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test bit field exceeding 32 bits */
+	cell.size = 4;
+	cell.bit_offset = 0;
+	cell.nbits = 33;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test invalid bit_offset + nbits */
+	cell.size = 1;
+	cell.bit_offset = 7;
+	cell.nbits = 2;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	/* Test nbits=0 requires buffer size == cell size */
+	cell.size = 1;
+	cell.bit_offset = 0;
+	cell.nbits = 0;
+
+	value = 0xff;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_nvmem_bitfield_errors,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
-- 
2.34.1

