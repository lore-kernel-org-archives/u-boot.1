Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE21061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3FC8409B;
	Mon, 30 Mar 2026 19:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRhuzrCk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fCPv+mw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8125A84099; Mon, 30 Mar 2026 19:15:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2B684035
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UF20Wg3722902
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=slXb2gDCo2L
 wbIeQDDmSfavD/g9D26oI5K4beeswrg4=; b=nRhuzrCka106vS2pzuHnzymIm68
 PY+gG0MnN6p2lmEEXsDHe5a5T8XG8eDtYEGT1Yzr1T8WeLodp2uoSLeyYMBsQEpj
 UymVErlgB9xHyj5stHQqjHHr/ZazT8e6t3W+z1xTwC4LPXqq7dcjfTVBiWH0wHty
 DJL6ixSKFz6QZHaI9lBPrNJybwFy+X7LNf5xfLwMeIZ4wxvvB/glFyQ0OxsMOBYZ
 1v2FVsYAi7fzIwM32Rn3MVeA6PIcrlNpQXBTW3aUmp8T52k0ZlGUNw65/o4mry8u
 Vk+GnloEZLbWVDCYxPSdfoziP1trajsCI1GpV4zyUcNlHgFxfYWdeeOqTmw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmssjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c73627355so2906333b3a.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890929; x=1775495729; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=slXb2gDCo2LwbIeQDDmSfavD/g9D26oI5K4beeswrg4=;
 b=fCPv+mw2FSjSEHFltXRNuugoec181nLbL2kK4pN84SEKhUdY0StzoHuQR7tt41J52x
 e58yGzHivlo1T9ewoLesva6ZFqWfK+1EdVs1ie3IA+jHSJJnDa77e7qNGcAn9sgs3wmS
 Le88kRzG0bNKRDIfAskPo4hd4J8GVHmtNL6dRNyxHaY4GhLbGxeYx/xGUa9Pr+3NOd32
 AE5lerK2Q4j2a6gf7p56ZrMIhfUq1EtUWNCfHxDPq9eLyyfxxp1nit/OOI1D/n7KpE86
 MKrXJLRIpLJh/KuWXEeJmiTvPeHpiJa7rltGPRzicfEynlmG0Vv+uk7n/Lb1T/8Mik0z
 dAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890929; x=1775495729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=slXb2gDCo2LwbIeQDDmSfavD/g9D26oI5K4beeswrg4=;
 b=O2d9P46bl09oLm+duavtPs1F58OaBHQCNID/b3xOhuUJTfgyhD0KifAGme0fMz76yC
 +UDChC6YceeSN95MUpXbPzqVV5K2sqX0cIojvZ/HOSqOxTraiiL+4G6xWTHAgab3nMr8
 ntxfqjpZ03pKVIIsLbJmqeiCOqp6IEBT4sHqnpoz9shXo35cNZmTbjuoxM1vGWLMIC9o
 05Wyd0ta0zCCA9vc2fMfwJuvE8xS6vdppZlVFmAHMd29f+p95/D5++kMKCKTjqI9dP7u
 BY1Abvim0pmZQPkD+CVjJctlEUlXPXSNIyODWkk4eG0irWscI+Ppfl8p1bJmy3BYg/wD
 7/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUql7ClT5sOd5KIwIRP0duypMWtzP0NsoAicLY96HkX4jLJ22GatiaChKxVt6IxPZ4QqsVejIk=@lists.denx.de
X-Gm-Message-State: AOJu0YxUyel7DiPDQtyv7O5JfIFO+ahrbPPtlgI4ANuWEom40U9tuXYk
 Mw0oCdDw6btefKfcYPtVj7xai74MaeVy27227ot7gHtpnmSRV7ZmiLERjgbcI0/Y04jfY/3Z95Y
 GCVkYOgOgcZ0InQUh1kDDTWYXDkZKOYI0jAtupeWEYYdZU/9fFD/ALJmL
X-Gm-Gg: ATEYQzxaydxB6Q2csUTrLWiU7RQpMlO+ae8Q4a/eaSXs7A1TkeVIcXv7Mpoc/dAAKZJ
 bs3waI05sfD35z0Y1R9uzO6KMo2mSLT1z+Pm/udJw8G/C3gyAq2CGiPuOuwdojqB0bINW6M9BhF
 WJIaD6QTZxWwwuWbV1ec3mPb7ComWaceliMJAcEiqjIojBM3wceGRJXLmM5ylHJ1yBFDJXie+Lw
 aQk4FMHPvCbmnq/w2Qen+ydf43eN9jrnivDikNeE6b7sGhwiHMBN2XTBnLnsAd7hYRDTxx43fTG
 B69piKGfMxmfgeW//CEZSG2x1SXuTIxF4kjQiVQ6m0VAaYlz9W1qm8zvsWNSLr7ZFHxLxIZXdpi
 dLG4NgEJs8lEHUKr71RvLjs01ySrJtyoq5gVNXJyYto6DB43H1CU9UG/DgBpC60sLm+ir6+ObsD
 2rVcwNsves1A7z1E8pvYMJGi+tiiirKoZAmsu6SYoM
X-Received: by 2002:a05:6a00:138e:b0:82c:213b:123f with SMTP id
 d2e1a72fcca58-82c95ee5fc2mr13305801b3a.31.1774890928382; 
 Mon, 30 Mar 2026 10:15:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:138e:b0:82c:213b:123f with SMTP id
 d2e1a72fcca58-82c95ee5fc2mr13305743b3a.31.1774890927580; 
 Mon, 30 Mar 2026 10:15:27 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:15:27 -0700 (PDT)
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
Subject: [PATCH v3 6/7] test: dm: add comprehensive tests for NVMEM bit field
 operations
Date: Mon, 30 Mar 2026 22:44:18 +0530
Message-Id: <20260330171419.1117817-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SoYtsQYBhNw0HDYB7zeis2GY7Fmoj4bn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX/kRKVL+tu17b
 iWi2n4TkkZJ4orR3DdTHsBiw6PTpZCbl8BJ1k9qXOPAvvqmj9CPkkddkjm+EI7pG5nnhU4A0DbG
 WwflkS4V2UrRshYU45vDhSIFUqzI7OG0/0XF+ymfL7iJcVaMcuPUs3XyIsLEWYVPgB8C5hGquSr
 n8qk3IhBsUTYwZTRfmDau4JfacBigphww41p8sBzVsfBmdYG0lbN5UAfq5SxkOUdBm5Zs7y+do/
 Ly0/w77twxSTub1zbVauQ+HP8g5yAhmDIfkQf94Oa7uJM4ZJjWxwLTRESXOpTvgMzyP7OjZEdkR
 7eQ6IM2gpNIW/f5t64Yxop7cYwtLxY1LoUxEIMk0ij3wEkp9uNMx0t0tCD0orwAKYvAyW8H5vMc
 prSFmS4Iwaq3Usak/yPzc+sdcsbwt9BRp9Dgqe/+m+QDp1jL9arPthnTjjsiZGdVAz4AoPooaco
 9yn4PpZqvPFlkMbbj2Q==
X-Proofpoint-ORIG-GUID: SoYtsQYBhNw0HDYB7zeis2GY7Fmoj4bn
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69caafb1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2eTTHJJ0khsgQslqM3AA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141
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
- 1-byte cell with 7-bit field
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
 arch/sandbox/dts/test.dts |  12 ++++
 test/dm/reboot-mode.c     | 137 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

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
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index 9a3b2bf0a43..8e6634339a8 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -15,6 +15,8 @@
 #include <test/ut.h>
 #include <rtc.h>
 #include <linux/byteorder/generic.h>
+#include <nvmem.h>
+#include <misc.h>
 
 static int dm_test_reboot_mode_gpio(struct unit_test_state *uts)
 {
@@ -66,3 +68,138 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reboot_mode_rtc,
 	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+static int nvmem_test_write_raw(struct udevice *dev, uint offset,
+				const void *buf, uint size)
+{
+	return misc_write(dev, offset, buf, size);
+}
+
+static int nvmem_test_read_raw(struct udevice *dev, uint offset,
+			       void *buf, uint size)
+{
+	return misc_read(dev, offset, buf, size);
+}
+
+/* Test NVMEM bit field operations */
+static int dm_test_nvmem_bitfield(struct unit_test_state *uts)
+{
+	struct udevice *nvmem_dev;
+	struct nvmem_cell cell;
+	u32 value;
+	u8 hw_value_u8;
+	u16 hw_value_u16;
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
+	value = 0x7F;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	value = 0;
+	ut_assertok(nvmem_cell_read(&cell, &value, sizeof(value)));
+	ut_asserteq(0x7F, value);
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, &hw_value_u8, 1));
+	ut_asserteq(0xFF, hw_value_u8);
+
+	/* Test reg = <0x18 0x4>; bits = <4 12>: Spanning byte boundary */
+	cell.offset = 0x18;
+	cell.size = 4;
+	cell.bit_offset = 4;
+	cell.nbits = 12;
+	hw_value_u16 = 0x000F;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u16, 2));
+	value = 0xFFF;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u16, 2));
+	ut_asserteq(0xFFFF, hw_value_u16);
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
+	hw_value_u32 = 0x0000FFFF;
+	ut_assertok(nvmem_test_write_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	value = 0xFFFF;
+	ut_assertok(nvmem_cell_write(&cell, &value, sizeof(value)));
+	ut_assertok(nvmem_test_read_raw(nvmem_dev, cell.offset, (u8 *)&hw_value_u32, 4));
+	ut_asserteq(0xFFFFFFFF, hw_value_u32);
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
+	value = 0xFF;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_assert(ret < 0);
+
+	/* Test bit field exceeding 32 bits */
+	cell.size = 4;
+	cell.bit_offset = 0;
+	cell.nbits = 33;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_assert(ret < 0);
+
+	/* Test invalid bit_offset + nbits */
+	cell.size = 1;
+	cell.bit_offset = 7;
+	cell.nbits = 2;
+
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_assert(ret < 0);
+
+	/* Test nbits=0 requires buffer size == cell size */
+	cell.size = 1;
+	cell.bit_offset = 0;
+	cell.nbits = 0;
+
+	value = 0xFF;
+	ret = nvmem_cell_write(&cell, &value, sizeof(value));
+	ut_assert(ret < 0);
+
+	ret = nvmem_cell_read(&cell, &value, sizeof(value));
+	ut_assert(ret < 0);
+
+	return 0;
+}
+DM_TEST(dm_test_nvmem_bitfield_errors,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
-- 
2.34.1

