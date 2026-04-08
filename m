Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58A5EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918978420C;
	Thu,  9 Apr 2026 15:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="c9/aU81v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F1F83936; Wed,  8 Apr 2026 21:25:09 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CF1840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638E2cor1362419; Wed, 8 Apr 2026 19:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=mx
 aHCLlgXZ/lzhcIbdCfc7dbgoFgM/jKhnBhShUqRJE=; b=c9/aU81vnN7pCmVrIf
 fr8svjWxTfgZbsZh3R/kxvvy9BdYIF7p0Fq8NCCG5snEwq8SX9gcjF6uR+lQgZQy
 bH+nLqDz1C/Lyus+mXM22Omd2iiluc+TksJwn0yXqizfJJC3grHoal6nHPilAhjl
 OPsd/c7xP0TaPXId76GzWxCSH6kT3Zuj+uLZeFK9LAaLMhFkhfxaRQYhuejqty07
 NoXsbrUByhIOugLMTSTCT5U0DcaV1avvDPUgArlpb0Ozh0SovMFFHzGJJoCsTtV0
 RPJR5DFeRyYqrn9jfDsFri3fP37cTKaEhdQjwCNid4rhN83V00mLmeFMUBj+ZRkf
 86jA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddpa7nn19-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:21 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EF01E801705;
 Wed,  8 Apr 2026 19:24:20 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D1B4F805E55;
 Wed,  8 Apr 2026 19:24:19 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:15 +0000
Subject: [PATCH 3/9] arm: dts: Add HPE GSC device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-3-2be1fb7cbbfc@hpe.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX2doUd2eedYXL
 7nqHeBzJZo5v18csW3JyztMqZ+mJeszNAq9AYwY4ozYt5stNd+CDTYjzxtEHp5hlKzTkU1bjIv/
 OlU6Kh6JXzmfdiZ3fDY38dN1Qa1nZVmOslE2kSW+s1xjf4RoeDGMS8AznVqBNSjsK0nWAcLiBU6
 R3AjNGqj2+/8RkBvEhtJwYPznWR49QPx2F0I92Q8jcolX81ZD4wTlb661KxAoSvW2KKI59w1Z16
 QhFaDIyz7dV1cdAkqw0WK/KCztnxFzOO2bSH+RChIqQospVUl5rjuLw+p7k/g4mMMLcLU5zGT4Y
 rJ9yv7bEDEdhDitWlK5qWj5nkbHMcK/B1LX9/6oAnquylDQryvjNreNHRMg/vWrQSkBC0cs0viC
 PvgtJ4KJF/ZfM9k6pAo3UI9FPQI0fZzCllYJwvzWbtqT6mNnwHuCwH/5NmzQlmDwtNeDxlDpcpw
 6QmSwYkfZ3sX2Won+iw==
X-Proofpoint-ORIG-GUID: Dg416uck9nFU9N_dhkepC2Vvo_3remGf
X-Proofpoint-GUID: Dg416uck9nFU9N_dhkepC2Vvo_3remGf
X-Authority-Analysis: v=2.4 cv=eZ4NubEH c=1 sm=1 tr=0 ts=69d6ab65 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=k7r4yCLl9DVLXMiQTbtC:22 a=MvuuwTCpAAAA:8
 a=4-u-6RC85il1AJvS1_IA:9 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080181
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

Add device tree for the HPE GSC SoC including:
- Dual Cortex-A35 cores with spin-table enable method
- GICv3 interrupt controller
- NS16550A compatible UART
- GXP timer and SPI/I2C controllers (shared IP blocks)
- Two Cadence GEM Ethernet MACs with SGMII PHYs
- Synopsys DWC MSHC eMMC controller
- GSC watchdog timer
- Memory-mapped virtual EEPROM for VPD storage
- Fixed clock definitions for peripheral buses

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 arch/arm/dts/hpe-gsc.dts | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm/dts/hpe-gsc.dts b/arch/arm/dts/hpe-gsc.dts
new file mode 100644
index 00000000000..162099c2b60
--- /dev/null
+++ b/arch/arm/dts/hpe-gsc.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * GSC Device Tree
+ *
+ * (C) Copyright 2019-2025 Hewlett Packard Enterprise Development LP.
+ * Author: Gilbert Chen <gilbert.chen@hpe.com>
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "hpe,gsc";
+	model = "HPE GSC";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uartc;
+	};
+
+	aliases {
+		serial0 = &uartc;
+		spi0 = &spi0;
+	};
+
+	ahb@80000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80000000 0x52000000>;
+		ranges;
+
+		gic: gic@ce000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			ranges;
+			interrupt-controller;
+			redistributor-stride = <0x0 0x20000>;
+			#redistributor-regions = <1>;
+			reg = <0xce000000 0x10000>,
+			      <0xce060000 0x40000>,
+			      <0xce200000 0x40000>;
+		};
+
+		timer: timer@c0000098 {
+			compatible = "hpe,gxp-timer";
+			reg = <0xc0000098 0x08>;
+			clock-frequency = <1000000>;
+		};
+
+		uartc: serial@c00000f0 {
+			compatible = "ns16550a";
+			reg = <0xc00000f0 0x8>;
+			clock-frequency = <1843212>;
+			reg-shift = <0>;
+			no-loopback-test;
+			status = "okay";
+		};
+
+		watchdog: watchdog@c0000090 {
+			compatible = "hpe,gsc-wdt";
+			reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
+		};
+
+		spi0: spi@cef00000 {
+			reg = <0xcef00000 0x80>, <0xcef08000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "hpe,gxp-spi";
+			status = "okay";
+
+			flash@0 {
+				reg = <0>;
+				compatible = "jedec,spi-nor";
+				spi-max-frequency = <50000000>;
+			};
+
+			flash@1 {
+				reg = <1>;
+				compatible = "jedec,spi-nor";
+				spi-max-frequency = <50000000>;
+			};
+		};
+
+		i2c2: i2c@c0002200 {
+			compatible = "hpe,gxp-i2c";
+			reg = <0xc0002200 0x70>;
+			clock-frequency = <100000>;
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom: eeprom@a0017f00 {
+				compatible = "i2c_gsc_mem_eeprom";
+				reg = <0xa0017f00 0x100>;
+			};
+		};
+
+		sdhci0: sdhci@cefe1000 {
+			compatible = "snps,dwcmshc-sdhci";
+			reg = <0xcefe1000 0x400>;
+			interrupts = <0 23 4>;
+			interrupt-parent = <&gic>;
+			clocks = <&emmcclk>;
+			clock-names = "core";
+			bus-width = <8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			non-removable;
+			max-frequency = <200000000>;
+			mmc-hs200-1_8v;
+		};
+
+		macb0: ethernet@c0004000 {
+			compatible = "hpe,gsc-gem";
+			reg = <0xc0004000 0x1000>;
+			interrupts = <0 74 4>, <0 75 4>, <0 76 4>;
+			interrupt-parent = <&gic>;
+			phy-handle = <&ethernet_phy>;
+			clock-names = "pclk", "hclk", "tx_clk";
+			clocks = <&clk125>, <&clk125>, <&clk125>;
+			phy-mode = "sgmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet_phy: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+		};
+	};
+
+	clocks {
+		clk125: clk125 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+		};
+
+		emmcclk: emmcclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+			clock-output-names = "emmcclk";
+		};
+	};
+};

-- 
2.43.0

