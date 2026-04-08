Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A11073CA5
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06BE783D8A;
	Wed,  8 Apr 2026 14:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CegSHejh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h51mvMXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3088414B; Wed,  8 Apr 2026 14:21:15 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E54838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63870N7U1620396
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 12:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CD+ErMxw0eP
 eAgny4Y4In3ltzYl0syzzc0ajt0HIu1Q=; b=CegSHejh/crhOihVfhgmOcolXEN
 ZXQtk8/LjDDgFrCxDdd42Y945yO/hvQKyjFB7G4QkcQ9+d8oNev1ljIzp4/s+Mng
 GmVEeMGPMbtzK7FsooI6arVH5nVkQMQ7OeCNAulZGHGGY8sWqhDQ1KFKT89sw0Th
 Z5PwGL/WNiH3I6wcICbkczfleYrVtHcNMigMDXBjeHWif5ywBmtrmguCC+oP47DR
 iLQGOibc6Q2wZJ041vfQS3niND6RsNQvlfB1KZ8oklR9jmSg1DLN7ScM8AJ8NYx1
 sJ4M4H4EhDYaQaFcnWaYbKdbtBBKkMi+xwfH6zGq+ct4TBBZSkeCJHLZTsg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrjr63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:21:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c6e24ee93a6so565315a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775650870; x=1776255670; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CD+ErMxw0ePeAgny4Y4In3ltzYl0syzzc0ajt0HIu1Q=;
 b=h51mvMXVzTsTXf8tdv80obP62S5l0LT8kck6qdXvXJjBPHLvhmRF0JV1HoaPZPXsUG
 nA7KkX7VZDKaD0AJTQA4T/8HinaAoXCEjo2J2gjXktuTLiQo1mdDX1jcvnT2IhQCrlLg
 +LKzSX8jMSmaOijj8K3oD4t4YFkZbRPIWPv6XzOM7TdHlsE1zoKVWMwfnK4tJu3MCneE
 18bEiHEcv2psCxaDkWpX5g7TnhU0/jfmVNgY2WKQZXIOetplPsHgRk5VcpcODGuLsDMF
 Ca628JCOg9TCgpegO0kNA2fVdTrbO9mjy9H5oAYaaU2InqrXVqPoR255RNyF8uivvptZ
 0OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775650870; x=1776255670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CD+ErMxw0ePeAgny4Y4In3ltzYl0syzzc0ajt0HIu1Q=;
 b=fh/JvZdc4J6HOG1ghKb6no+KvSvukcjATk9R5+FWosFc/FRBIcIphPVT2M/F6fgtr7
 t/elBcJ3odKW7F+B3DlL3drmV6sBpceJBYhbcgxJre5uwzba24ZQqBRwecUQPvTKmJea
 YVjRoPpNgJTsaovvud4FKs9xKfC7ISDvrt30ZpJjEwSW+vTuyurHDV+NubV/ZJwgtj61
 Um0yWVItmozuTeGJtFXXjqrS6lZgBKjc+KQyDTVOnxmg8W5h6WWLane8zFN50/k3yCMl
 aCf1kXlqyPFqpz6Fg9Pb0Fh3DaAeKiD7HC4nbJ3KGpMu6L2u2WBqWzZ3gtLx3rHp5jTD
 KImg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZJSA6FCEZ6KluZf+TKT1CuvcU34X0Q0exIEu6Crow4JSPvZu3vaXxgvczEal7ui9vdO4diK8=@lists.denx.de
X-Gm-Message-State: AOJu0YwYSXFiNl8d78+05DD7PxGPxYZQQmaOsK+VaYWZqqZv+lDMVljP
 yVbcDh0heu7lBxOIrls/22jXFHcFr4+BkD9SyPkHQezRxKhmzrpgT7a1y5OMN1LebVYlPgFKwvL
 HEOclMlFUKSoIKJ8m/mTf5fa1gux65JnVPEVmd3zSJGJ6d5kdifJG3IaO
X-Gm-Gg: AeBDiev96h+tSc1qiH5Kr9XfkZfqxKAmDTbOAxKg9CCUB4RLf6e0w33PbDmwZq+Spg6
 84G39v6sfBqyUrs2vJzYNYh1zZfUbkCZfngIsUEudVxU8mK02RWTi+a3qj+wDjUbV8cmQP/D5Q3
 NxG76JnFfLk5o/RFDlyBBejW+YaCQQQXHJqEyTpRpLl6CLlwFIur7I404FAMo7UeEggmKvqeloH
 1iEL112qgTdxRZHnxsp21qC4G2m2xTCdgsbCxNSN5MTJqGQ8x4uV74KvRC/QU9v/DomvBebwhks
 hdk52BBTuUY0O+SHvSEHepTy2FheQ8ekoypTcYN1gs3XMyeb7YCcBOZoqiOWwKJaNR8xij2OOr5
 KzqM+BwSFsZshIxwy4Xfp6epCjLEomIWY7RR7MJnDihNt68u1hgJTPMZMTDkLcIWiPzZZZxEMAW
 CFHLXJuWRCjpXxZzFKE5+rxOq09Ty86KtRasiYIXGU
X-Received: by 2002:a05:6a00:2393:b0:827:2dff:7116 with SMTP id
 d2e1a72fcca58-82d0dbe01f4mr17295979b3a.13.1775650870081; 
 Wed, 08 Apr 2026 05:21:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:2393:b0:827:2dff:7116 with SMTP id
 d2e1a72fcca58-82d0dbe01f4mr17295954b3a.13.1775650869367; 
 Wed, 08 Apr 2026 05:21:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9a24039sm20512602b3a.0.2026.04.08.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:21:08 -0700 (PDT)
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
Subject: [PATCH v4 6/7] test: dm: add comprehensive tests for NVMEM bit field
 operations
Date: Wed,  8 Apr 2026 17:48:40 +0530
Message-Id: <20260408121841.186410-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tGiPHm7bZlmSerjcRScg9uuoxbHIDj_u
X-Proofpoint-GUID: tGiPHm7bZlmSerjcRScg9uuoxbHIDj_u
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d64837 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=W1BiHNyAc7_2oUjjS0wA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExMiBTYWx0ZWRfX+5T7/vg4lAhp
 6eV7AbJdRKdGdUkkUV1tgdQW0vBGYF+3HAo4DJJLI9Q6MN2UiKPxQnqY34Sh86bLIycVPQLKVd2
 ZbKO3oPmIy2ZkSbNP2vtYbw6SA6eg1yitGoFDgLclHEHf0poDMcWPz8Di2m/g1WCTiVRqpYYaRi
 wBsnuN8d/AKCfWloqSunx0lbOxInZSPxMPVMOaECeRxgM8JjGLtwFdPgce/6DDbffrxL6NitIen
 d1H6A1IwutccUDbkj23H5QLplUBudG65i82soZQKzRwu1eNedd7R+3AthiAxQ8tPsQcM7SXdc10
 x2LEO6S0dX8TZ+OaLpupeLt8cHQtY6H6MLE62Mthr8yqxAF2WL/NjoHzrhcf44RmH5oqtQtqs9i
 z1kmrcCHzesTQjx1mN5CskYZfy49spDcn8elzaDyTjlZLZAztIhi+NzBk0v1dtDOSFWlynWEb1k
 JvX/0YVikQQylVMuTQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
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

Add a mock I2C EEPROM device (nvmem-test@50) to the sandbox device tree
to support NVMEM bit field operation testing.

Add test coverage for NVMEM bit field read and write operations to
validate the new bit field support in the NVMEM subsystem.

Test cases include:
- 1-byte cell with 7-bit field (Qualcomm SDAM reboot reason use case)
- 4-byte cell with 12-bit field spanning a byte boundary
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
Changes in v4:
1. Created separate test file for NVMEM bitfield tests
2. Fixed test to use correct I2C EEPROM functions
3. 4-byte cell with 12-bit field spanning byte boundary

---
 arch/sandbox/dts/test.dts |  12 +++
 test/dm/Makefile          |   1 +
 test/dm/nvmem.c           | 160 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 test/dm/nvmem.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 762c1d9bbe2..4fb4d0a8ef5 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -959,6 +959,11 @@
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
@@ -976,6 +981,13 @@
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
index 771b703b737..c60bb077e10 100644
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
+// SPDX-License-Identifier: GPL-2.0
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

