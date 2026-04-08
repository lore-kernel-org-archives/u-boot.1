Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EEFEA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C1C841A2;
	Thu,  9 Apr 2026 15:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="LLBAwvp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB74983936; Wed,  8 Apr 2026 21:25:07 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2988407E
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638H3KpP1755873; Wed, 8 Apr 2026 19:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=iX
 uLIKE0o2uE301AfUL84nBsQKb4zu1bZ8Q3lEls9f8=; b=LLBAwvp+OpRH8FAyEw
 mQj/X+jBTSf19Mg/YOVaetBiLAyl3FodZqYb/ZcO0OO9PFcKAmJOICP8h8mtx9kH
 9HvG4Xczi+DfyLYq7W75UfbspUskNpiqjrvluTrIUwsK8hg+RKCogTA6LLHrXjpW
 +ZgFtmZrb8ApNM/Gs2q3rd0KhnE1wfsO4ZK7ygJZ6daf9JL6ByFA+EPoCapA59h8
 SMD64J1MmmDTde9mq02QSuisfQ2VBBtW6KQkgsMmxi1AL6bzTT4+jcPHZM5GuWbE
 8VCWFPgJh16RnqK4PnaxsLNTr6WSwOYsplxjJo2TyiH6k2ogWdWNr5rz/ygeWnI9
 rXhw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddu35hj0k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:21 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 189BA801AD8;
 Wed,  8 Apr 2026 19:24:20 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id BB224806B47;
 Wed,  8 Apr 2026 19:24:18 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:14 +0000
Subject: [PATCH 2/9] arm: hpe: Add GSC SoC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-2-2be1fb7cbbfc@hpe.com>
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
X-Authority-Analysis: v=2.4 cv=JPgLdcKb c=1 sm=1 tr=0 ts=69d6ab65 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22 a=MvuuwTCpAAAA:8
 a=nW4WiQT0LLkrqWE3KoYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4bZIGNOHYYN1SKcD9UEnPh8sROkgyqOz
X-Proofpoint-GUID: 4bZIGNOHYYN1SKcD9UEnPh8sROkgyqOz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfX+H/EeXF59grn
 ksq6nrrXFqLOgmC+0b6TOOUSZaaaKz0mKYWSVSOPARIn2I1fSjVq+l7hLyvHZc4gP2dAq9zKMpB
 L2rH+v65RENFU8+b3vn+mKBMLOHu1CBFiRDe1S6AYVUFrh1Rcm2wk9W3U4V5PO98FLfJzrFd4qZ
 9Zc3TlWt/OxFmj88leLG3KYCWuaTSuFRmGHpcEMuXg7N1JmCH+FjENAsj1o93OeBmgyXN2Q3wI5
 JPdax8njm9GP5jetxCfVTkOld7nSpe2v1Q/Gc1J/WfMAsGa7EasMenGWAOsa1A3kY8U9IEo5eyI
 aXalQNSZJaisc6QSaGcutswhJLLzl9ongiMhwX6A6k+oAYEncUpGa8VUVoxW22TQVrdDm8qQN4G
 j69tFGjZnPdE00pCaMRsMUZ464cn+ozVGvBEo/ehkhGBEJmLLbxg/ssyrkKtZ9Az6qkaEFA1SxS
 5h0xpk8zabW2hyi5aBw==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
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

Add core SoC support for the HPE GSC (Gen Server Controller), an ARM64
BMC SoC used in HPE Gen12 ProLiant and Synergy servers.

This includes:
- Kconfig entries for SOC_GSC with ARM64, I3C hub DT fixup, and VPD
  patching options (SYS_SOC set to "gsc")
- SoC reset implementation via writel to GSC system control register
- Architecture-level clock header for MACB Ethernet driver compatibility

The GSC reuses several GXP IP blocks (timer, SPI, I2C) while adding
new peripherals including a GICv3 interrupt controller, Cadence MACB
GEM Ethernet, and a Denali DDR memory controller.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 arch/arm/include/asm/arch-gsc/clk.h | 14 ++++++++++++++
 arch/arm/mach-hpe/gsc/reset.c       | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/arch-gsc/clk.h b/arch/arm/include/asm/arch-gsc/clk.h
new file mode 100644
index 00000000000..19922c433d4
--- /dev/null
+++ b/arch/arm/include/asm/arch-gsc/clk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * HPE GSC SoC clock interface
+ */
+
+#ifndef _ASM_ARCH_CLK_H_
+#define _ASM_ARCH_CLK_H_
+
+static inline unsigned long get_macb_pclk_rate(unsigned int dev_id)
+{
+	return 50000000; /* 50 MHz */
+}
+
+#endif /* _ASM_ARCH_CLK_H_ */
diff --git a/arch/arm/mach-hpe/gsc/reset.c b/arch/arm/mach-hpe/gsc/reset.c
new file mode 100644
index 00000000000..67fc83b2deb
--- /dev/null
+++ b/arch/arm/mach-hpe/gsc/reset.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * GSC SoC reset
+ *
+ * (C) Copyright 2019-2025 Hewlett Packard Enterprise Development LP.
+ * Author: Gilbert Chen <gilbert.chen@hpe.com>
+ */
+
+#include <asm/io.h>
+
+#define GSC_CCR	0xC0000000
+
+void reset_cpu(void)
+{
+	writel(1, GSC_CCR);
+
+	while (1)
+		;	/* loop forever till reset */
+}

-- 
2.43.0

