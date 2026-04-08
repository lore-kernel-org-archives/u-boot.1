Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0311EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B197E84181;
	Thu,  9 Apr 2026 15:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="f3iGF0KO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD53783936; Wed,  8 Apr 2026 21:25:05 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E480683693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Dtg0d1224013; Wed, 8 Apr 2026 19:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=3k
 NMA94sDi5z6jvNUhFrIO8I1nP5PWggkV4NmHgz65Q=; b=f3iGF0KOrBOp3ZEJZW
 O+lGzOeRVDAucvw1i260f0oKJpgvChUydoVMxYd20B/1F5Zwij02MhCc5tHhyOVw
 VcvysbgDcKk4uUJ7mkLgtPcseQoo/9duC+W1p+gR48QYRnf8miSHaorP0RNP6QcZ
 Xl+5VDYP00YBDw/olhgZvvbEk3I4X2ApQkPt9Av7lBSmeDSlyHdxk1l+oWl6hcCN
 TyYN7bWQPHMkOtKPupTb8EXzx5/OzWnyWc0GTNCWpeUhXKTmjEJJmj3AqknT8lol
 6H06Q7NzeGWB1yWhKk+IZvf6xcCwqop5h0YFK1IkGn+xX+DiTgOUjZYIaUj6sLVd
 UbTA==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddrb6uyyv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:33 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1F84C259;
 Wed,  8 Apr 2026 19:24:23 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 020E2806B47;
 Wed,  8 Apr 2026 19:24:21 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:17 +0000
Subject: [PATCH 5/9] misc: Add HPE GSC memory-mapped EEPROM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-5-2be1fb7cbbfc@hpe.com>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
In-Reply-To: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Jean-Marie Verdun <verdun@hpe.com>,
 Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jorge Cisneros <jorge.cisneros@hpe.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=UMLt2ify c=1 sm=1 tr=0 ts=69d6ab71 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22 a=MvuuwTCpAAAA:8
 a=6ZYzDi2jFxUr4rbyXHYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GR4cax_FoF-l1gCO27aDKEPpz9kwGuZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX7o/ddaUbWLdW
 QYSAOH3xh4RFuLj1NOQPprmU7cxezI/wtNhvzr9wdet/UseGLRTvIhrTuhhJDO8zeUA7tlPjm6S
 UJ+ntjxINnpOLCRfvN+zJbYdT7sUfS0pn+mI8L++g0/ostHyxn5Aa67YejSRWeW2LJ+kbaRogHC
 OaVxuiwN/0Oky5h634ranc6/H4VzcG8qiAqS4ZDrKbI4KXPnZtlYPomor9vIBe+e5g4KE2oV0hG
 qjGngxK7Xo3i3LmFtVzF1GV+M8viUI8Yj7b7itTkxCafiEMy6xi14tYw0jKpN1+oPApa6U0l0+K
 DvVeoAfG4l1uLHtcCVO5eaeMdz4aeAO0PXbg5sf2alyhgisC94OcES78diHt/FFVG1UyLZ1KERy
 rtVbObs57xkmoZkEh2fz1nobJIWQllg0sU2h+bK0WTCpzTjA8xTMF4XNTC33qlIUKZMf3W9o09Z
 FQLctWC8utva5aeZPtA==
X-Proofpoint-ORIG-GUID: GR4cax_FoF-l1gCO27aDKEPpz9kwGuZW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080181
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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

Add a driver for the HPE GSC memory-mapped virtual EEPROM. This
device provides access to system VPD (Vital Product Data) including
MAC addresses, serial numbers, and part numbers through a simple
memory-mapped interface.

The driver registers as UCLASS_I2C_EEPROM for compatibility with
the standard EEPROM read/write API and includes checksum validation
to detect data corruption.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 drivers/misc/Kconfig          |   7 +++
 drivers/misc/Makefile         |   1 +
 drivers/misc/gsc_mem_eeprom.c | 118 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a0aa290480e..5d316b03ec7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -573,6 +573,13 @@ config SPL_I2C_EEPROM
 	  This option is an SPL-variant of the I2C_EEPROM option.
 	  See the help of I2C_EEPROM for details.
 
+config GSC_MEMEEPROM
+	bool "HPE GSC memory-mapped EEPROM driver"
+	depends on MISC
+	help
+	  Support for HPE GSC memory-mapped EEPROM used for storing
+	  VPD (Vital Product Data) in HPE Gen12 server BMCs.
+
 config SYS_I2C_EEPROM_ADDR
 	hex "Chip address of the EEPROM device"
 	depends on ID_EEPROM || I2C_EEPROM || SPL_I2C_EEPROM || CMD_EEPROM || ENV_IS_IN_EEPROM
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1d950f7a0ab..e616b9f67d2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
 obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
+obj-$(CONFIG_GSC_MEMEEPROM) += gsc_mem_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
diff --git a/drivers/misc/gsc_mem_eeprom.c b/drivers/misc/gsc_mem_eeprom.c
new file mode 100644
index 00000000000..f67662fe40b
--- /dev/null
+++ b/drivers/misc/gsc_mem_eeprom.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HPE GSC memory-mapped EEPROM driver
+ *
+ * (C) Copyright 2025 Hewlett Packard Enterprise Development LP.
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <i2c_eeprom.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+struct memory_eeprom_priv {
+	u64 mem_offset;
+	int size;
+};
+
+static int validate_checksum(u8 *data)
+{
+	u16 sum = 0;
+	u16 word;
+	u8 rev;
+	int i;
+
+	rev = readb(data);
+	switch (rev) {
+	case 2:
+	case 3:
+		for (i = 0; i < 64; i++) {
+			memcpy(&word, data, sizeof(word));
+			data += sizeof(word);
+			sum += word;
+		}
+		if (sum == 0)
+			return 1;
+		debug("%s - Computed checksum fails 0x%04x\n", __func__, sum);
+		break;
+	default:
+		debug("%s - Version byte 0x%02x unsupported.\n", __func__, rev);
+	}
+	return 0;
+}
+
+static int mem_eeprom_read(struct udevice *dev, int offset, u8 *buf,
+			   int size)
+{
+	struct memory_eeprom_priv *priv = dev_get_priv(dev);
+	u8 *ptr;
+
+	ptr = map_physmem(priv->mem_offset, priv->size, MAP_NOCACHE);
+	if (!ptr) {
+		printf("%s - failed to map physical memory.\n", __func__);
+		return -ENODEV;
+	}
+
+	if (size + offset > priv->size) {
+		unmap_physmem(ptr, MAP_NOCACHE);
+		return -ENOSYS;
+	}
+
+	memcpy(buf, &ptr[offset], size);
+	unmap_physmem(ptr, MAP_NOCACHE);
+
+	return 0;
+}
+
+static const struct i2c_eeprom_ops i2c_mem_eeprom_ops = {
+	.read = mem_eeprom_read,
+};
+
+static const struct udevice_id i2c_mem_eeprom_ids[] = {
+	{ .compatible = "i2c_gsc_mem_eeprom" },
+	{ }
+};
+
+static int i2c_mem_eeprom_probe(struct udevice *dev)
+{
+	struct memory_eeprom_priv *priv = dev_get_priv(dev);
+	u8 *ptr;
+	u8 crc1, crc2;
+	u32 reg[2];
+	int ret;
+
+	ret = dev_read_u32_array(dev, "reg", reg, 2);
+	if (ret) {
+		printf("Error reading reg from DT: %d\n", ret);
+		return ret;
+	}
+	priv->mem_offset = reg[0];
+	priv->size = reg[1];
+
+	ptr = map_physmem(priv->mem_offset, priv->size, MAP_NOCACHE);
+	if (!ptr) {
+		printf("%s failed to map physical memory.\n", __func__);
+		return -ENODEV;
+	}
+
+	crc1 = validate_checksum(ptr);
+	crc2 = validate_checksum(ptr + 128);
+	unmap_physmem(ptr, MAP_NOCACHE);
+
+	if (crc1 != 1 || crc2 != 1) {
+		printf("%s - Warning: Invalid checksum\n", __func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(i2c_gsc_memeeprom) = {
+	.name = "gsc_mem_eeprom",
+	.id = UCLASS_I2C_EEPROM,
+	.of_match = i2c_mem_eeprom_ids,
+	.probe = i2c_mem_eeprom_probe,
+	.ops = &i2c_mem_eeprom_ops,
+	.priv_auto = sizeof(struct memory_eeprom_priv),
+};

-- 
2.43.0

