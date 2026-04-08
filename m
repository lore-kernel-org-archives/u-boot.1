Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC126EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1190084198;
	Thu,  9 Apr 2026 15:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="bIbqmiwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556EE83936; Wed,  8 Apr 2026 21:25:06 +0200 (CEST)
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53B8838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.cisneros@hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638EoSTT203627; Wed, 8 Apr 2026 19:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps0720; bh=al
 HF8YJoB5bleRKrowXDm4hyXQ1G60R263at1TRSt/Q=; b=bIbqmiwA34Motjv8bt
 K+wUFmAhU+rRt3XglXDuoOmup0WVtMk4ry6rsQtXcryNbTrb9kXHA0bRKihbUPfS
 ENRvjQOwDQnLMVbtRbzqX+8+fakrWKFN0l2GwXCRrKfulL11z1c9l5Yzu7EuUXS+
 pKjUGS6vSLHxYFq18qJKkVxYfz7/KKl3LFIP7d+ynTH7zNyt+lj6/QcG3DQcacJ4
 Y40gD0UNPjTI8Tf3xh7w7v9r/OQ0X68upuA0S1/Wo9Z3RigREyLZ9p/CcEyT+f2t
 tiPMBQwqJVhOZVpXQZGu1raQTAtiC+DJPSnJfXERmkaS3Zme9b0JN03DJLenwEMv
 iHgA==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4ddm5kq7gj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 19:24:20 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id C309E801AC0;
 Wed,  8 Apr 2026 19:24:18 +0000 (UTC)
Received: from [127.0.1.1] (unknown [16.231.227.39])
 by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A701D805E55;
 Wed,  8 Apr 2026 19:24:17 +0000 (UTC)
From: Jorge Cisneros <jorge.cisneros@hpe.com>
Date: Wed, 08 Apr 2026 19:24:13 +0000
Subject: [PATCH 1/9] arm: hpe: Rename ARCH_GXP to ARCH_HPE and add GSC SoC
 choice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-hpe-gsc-upstream-v1-1-2be1fb7cbbfc@hpe.com>
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
X-Proofpoint-GUID: kardddbxFCKGzWOEpBHnqzs2jpg2DXeo
X-Proofpoint-ORIG-GUID: kardddbxFCKGzWOEpBHnqzs2jpg2DXeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfXyDfjuC0yhVfb
 w7Rm0AAyoHGK01RBrIq9ZqephCA4037ip6j6ybYL23tzupK0/Yr7taKqeQI63GSewVOZjSex8VU
 6jQeAF9amXF7SO+NCA1iYtrsprEHxU2KJrViQ9Fe43MVTtVLbVrPkNf/mGwrkXStaKeByoNtMDq
 MQ4GK5Ow4D4oEsnAZPo5XE1jDlUAw2vx2J/tNtyj6EWWVwd4ND53LJgVqY6iJ0BMvFsUiihv6OF
 ezWqqSIwFcyvGJlbYsebxlsAtJBR4Av+FJCxlZvpb/Dt4horkoCVPAs1nH/QNud8CffAkM7xepD
 ERkk9l2G1RyZSlwh/jDT9ae39BlT7PNdcSPnNOva/Lc6XUww0WkTdfgAmD/wcC8mOrlVguK5mFl
 1RjRmq+lp54lgXnrM+xVIsuZNTxsq83JliXP1H/Y2eNBubXQGMlcm4vjyQR//OTnuWcnJrY4fr1
 0N0p8pOHWiVwjC4cDMg==
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=69d6ab64 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22 a=MvuuwTCpAAAA:8
 a=EVURuLwGFxa9lwhGO1cA:9 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
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

Rename ARCH_GXP to ARCH_HPE to serve as an umbrella config for all HPE
BMC SoCs. Add a choice menu under mach-hpe to select between:
- HPE_GXP: Gen11 (GXP) BMC SoC (ARMv7)
- HPE_GSC: Gen12 (GSC) BMC SoC (ARMv8)

Update arch/arm/Makefile to use the new CONFIG_ARCH_HPE symbol and
migrate the existing gxp_defconfig. Add stub Kconfig files for the GSC
SoC and board to maintain a valid Kconfig tree.

Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
---
 arch/arm/Kconfig               |  9 ++++++---
 arch/arm/Makefile              |  2 +-
 arch/arm/mach-hpe/Kconfig      | 33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-hpe/Makefile     |  1 +
 arch/arm/mach-hpe/gsc/Kconfig  | 27 +++++++++++++++++++++++++++
 arch/arm/mach-hpe/gsc/Makefile |  1 +
 arch/arm/mach-hpe/gxp/Kconfig  |  2 +-
 board/hpe/gsc/Kconfig          | 18 ++++++++++++++++++
 configs/gxp_defconfig          |  2 +-
 9 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd6a454fd60..509a593eb77 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2182,11 +2182,14 @@ config TARGET_XENGUEST_ARM64
 	select XEN_SERIAL
 	imply OF_HAS_PRIOR_STAGE
 
-config ARCH_GXP
-	bool "Support HPE GXP SoCs"
+config ARCH_HPE
+	bool "Support HPE SoCs"
 	select DM
 	select OF_CONTROL
 	imply CMD_DM
+	help
+	  Support for HPE BMC SoCs including the GXP (Gen11)
+	  and GSC (Gen12) server management controllers.
 
 endchoice
 
@@ -2290,7 +2293,7 @@ source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
 
-source "arch/arm/mach-hpe/gxp/Kconfig"
+source "arch/arm/mach-hpe/Kconfig"
 
 source "arch/arm/mach-highbank/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b36b0742580..4a60cd94a66 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -60,7 +60,7 @@ machine-$(CONFIG_ARCH_BCMBCA)		+= bcmbca
 machine-$(CONFIG_ARCH_BCMSTB)		+= bcmstb
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
-machine-$(CONFIG_ARCH_GXP)		+= hpe
+machine-$(CONFIG_ARCH_HPE)		+= hpe
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISTB)		+= histb
 machine-$(CONFIG_ARCH_IPQ40XX)		+= ipq40xx
diff --git a/arch/arm/mach-hpe/Kconfig b/arch/arm/mach-hpe/Kconfig
new file mode 100644
index 00000000000..23840721435
--- /dev/null
+++ b/arch/arm/mach-hpe/Kconfig
@@ -0,0 +1,33 @@
+if ARCH_HPE
+
+choice
+	prompt "HPE SoC select"
+	depends on ARCH_HPE
+	default HPE_GXP
+	help
+	  Select the HPE SoC variant. GXP is used in Gen11
+	  servers and GSC is used in Gen12 servers.
+
+config HPE_GXP
+	bool "Support HPE GXP SoC"
+	help
+	  Support for the HPE GXP SoC, an ARM-based BMC
+	  used in HPE ProLiant Gen11 servers.
+
+config HPE_GSC
+	bool "Support HPE GSC SoC"
+	select DM
+	select SOC_GSC
+	select OF_CONTROL
+	select ARCH_EARLY_INIT_R
+	imply CMD_DM
+	help
+	  Support for the HPE GSC SoC, an ARM64-based BMC
+	  used in HPE ProLiant Gen12 servers.
+
+endchoice
+
+source "arch/arm/mach-hpe/gxp/Kconfig"
+source "arch/arm/mach-hpe/gsc/Kconfig"
+
+endif
diff --git a/arch/arm/mach-hpe/Makefile b/arch/arm/mach-hpe/Makefile
index afe5f7a29ee..ff566a3a047 100644
--- a/arch/arm/mach-hpe/Makefile
+++ b/arch/arm/mach-hpe/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SOC_GXP) += gxp/
+obj-$(CONFIG_SOC_GSC) += gsc/
diff --git a/arch/arm/mach-hpe/gsc/Kconfig b/arch/arm/mach-hpe/gsc/Kconfig
new file mode 100644
index 00000000000..9821bf6149f
--- /dev/null
+++ b/arch/arm/mach-hpe/gsc/Kconfig
@@ -0,0 +1,27 @@
+if HPE_GSC
+
+config SOC_GSC
+	bool
+	select ARM64
+
+config SYS_SOC
+	default "gsc"
+
+config GSC_I3C_HUB_DT
+	bool "Fix up the I3C Hub Node in Kernel DTS"
+	default n
+	help
+	  Enable this if I3C Hub is supported otherwise noise will show
+	  up on I3C Bus for unused populated ports.
+
+config GSC_PATCH_KERNEL_DTS_VPD
+	bool "Patch kernel DTS to add system VPD from virtual EEPROM"
+	default n
+	help
+	  Enable to patch kernel DTS to add system VPD from virtual
+	  EEPROM. This will add Vital Product Data such as serial
+	  number and model name to the kernel DTS at /.
+
+source "board/hpe/gsc/Kconfig"
+
+endif
diff --git a/arch/arm/mach-hpe/gsc/Makefile b/arch/arm/mach-hpe/gsc/Makefile
new file mode 100644
index 00000000000..f3cc6684b89
--- /dev/null
+++ b/arch/arm/mach-hpe/gsc/Makefile
@@ -0,0 +1 @@
+obj-y += reset.o
diff --git a/arch/arm/mach-hpe/gxp/Kconfig b/arch/arm/mach-hpe/gxp/Kconfig
index 2d43133ab06..42e65714ef6 100644
--- a/arch/arm/mach-hpe/gxp/Kconfig
+++ b/arch/arm/mach-hpe/gxp/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_GXP
+if HPE_GXP
 
 config SOC_GXP
 	bool
diff --git a/board/hpe/gsc/Kconfig b/board/hpe/gsc/Kconfig
new file mode 100644
index 00000000000..66346e2df27
--- /dev/null
+++ b/board/hpe/gsc/Kconfig
@@ -0,0 +1,18 @@
+if SOC_GSC
+
+config SYS_BOARD
+default "gsc"
+
+config SYS_VENDOR
+default "hpe"
+
+config SYS_CONFIG_NAME
+default "gsc"
+
+config GICV3
+def_bool y
+
+config TEXT_BASE
+default 0x10000000
+
+endif
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 7821759f83d..31e4d9b8ac8 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
-CONFIG_ARCH_GXP=y
+CONFIG_ARCH_HPE=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_GXP_VROM_64MB=y
 CONFIG_NR_DRAM_BANKS=1

-- 
2.43.0

