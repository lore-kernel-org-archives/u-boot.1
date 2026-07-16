Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB91C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A4784D65;
	Thu, 16 Jul 2026 08:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNMOFQe5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H8bZdMmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D0584ACE; Thu, 16 Jul 2026 08:29:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3931D84D8A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wgSx1573758
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yIoUbQeCQGD
 bm7WzNsgI3LppbHaTO/0R7jsLgtdAPnY=; b=oNMOFQe5dVN56j18okiWF593gEP
 V20g7l9RyO//+4HdkPUsO9AgWh39Kt/Y2uQHoPLD+eXdkN1Q23JRy4eoO689b32U
 ouGMSW/6AgpUq2ZrnkVuR3RSSrS11oqYMNyW0lIlYJzCP/ePkn2UiZPPtoBobvZu
 9jyEkl/GqLqnl4s1Cs5Y3ZsGcVRlfl2sT+J/zv82BZAPtXLvSqD7GtSNnP8iL3cD
 lNQbswKb6yQY5qFDlbaH1dXGCqkmzD6SY6BDjN/7eyFtODIaEnskz1DFM4vF437D
 FN8qeZxKmAv25h1pXPTJMF9Oi/1eFGdmDLNiZxSxfDYD9t4PJpOd4F4ekcw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q649v7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:29:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso14976762a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183384; x=1784788184; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yIoUbQeCQGDbm7WzNsgI3LppbHaTO/0R7jsLgtdAPnY=;
 b=H8bZdMmJIwSasp2/mMBdTYVrrAukPYBKfv/7C0WeGYoQO97TVZLbPa3mLwsWYWtxt3
 zJkWfpeRcYEUzg8A2Jy1Zc4uQDDkMWEn7InimaApTjav1HBODB3RaxL114+02KSW7Sre
 Igj04XIagqBqL3u5TVNsmDI4n0uCXSMx2inn+EMdsLq6PswLjIGkeOzF+zmvnnWHmOcb
 qGG9jq61yst/7zzpceHy7b0jFvdtlMegamhRycd37ImOPVMKR9s2WmaOKxKgR6qFkuJ8
 1YfXk554sDdFoNX4pphlH5fHceZpKwDc8/Zu3F2qm/0xNe3HmZlWhBtff7KaJ3LvBYiJ
 j4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183384; x=1784788184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yIoUbQeCQGDbm7WzNsgI3LppbHaTO/0R7jsLgtdAPnY=;
 b=kNwKOYUddv0+yRifAkvdIcJlyBhOahRe4BS4ExdBsm/zAb1asGC/OPu7Nkx/jo+8Pa
 x2YylXcr2E+HFz51uplET2ikvj+xeO7IkuqJvjWE2aDzcFL1ohQzq0Gl4vTWmmy8eARM
 VOqo3W2N9Ll+Oj95rCwMZwsHjDEB+O2RKei1IS8/WPV49G5V1w3pCZJm0YqnAvM26mEF
 JOt2o+S2ly6Kl05gYRneDj7ogFFL/sAYssuSheN4KdzlsObfTz2ydxc4rV4Wbj0NaEii
 H/21eDJaOmAknYpgce9zIfrzCD8bKnFyxp6qHlejLqaVEr0A41S9fFX4MXygPaw0Hd86
 /qsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwZI2h8vBspJUu08E0aBoBIL158wATI/oBoPTX+K0BR4gw8jTf0/jx75ymDlnzMAFFZVvDgVE=@lists.denx.de
X-Gm-Message-State: AOJu0YxJr2WcpaMwbZa+1R+6GaqGsOrCN2lGYqp/eBJ+JKMinM8+q+4U
 RiYnrbOcDYXUYFE8fqYMwxZzV61RaB0SVLjtzWN/CJfr5fbqIs7D5K+2DltwOhi7VcaUhifgkio
 031kQ/vSRHpheLTJRfDwaJCFZiLMKZpDPrBrkSPvKhnc2pas6NeM8P/K6
X-Gm-Gg: AfdE7cmDpnSPqi30d375S2TO64oIIcvOczDHXKwyGrUcfwl5ydOzpPmA2x2dN5SvCBx
 cNcrYpIgX3MkaIoEmxgKf3iWMZYXE197powBU6JRyU4zKBhchPlX1koNbyw6HEyQyiuJ+Nn+G9M
 +6nt49fp5pdaGw3xZHJewz/vSS977Mx9ByY9WHfVT5d2hXHrVMXMbZPam6DuOnHUiIz3wKr2oBQ
 UlF3ZLtNcK5CHKsgI1oHyI0vpMwYmAMGJSSiuOIUBjEysnHBd+qC0kpGzpGLppiZfTdekyym+a/
 aANqdAsv4XcplrbmYMl/PIEYatE7cGAGYQOPqSBjsL62PFgbsWB8co5eziTGm7yfm2qJzUI1jOV
 Lblov2O8GuiWdecj0aCUItLaAc663B+ndyqY2bpZGJDFkE2emUqAFEu5flr3qqnhe61uQ8u0GGF
 8/LASXHbT2gHPPkeU=
X-Received: by 2002:a05:6a21:4882:b0:3c3:7cf0:3874 with SMTP id
 adf61e73a8af0-3c37cf06741mr3809040637.7.1784183383730; 
 Wed, 15 Jul 2026 23:29:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:4882:b0:3c3:7cf0:3874 with SMTP id
 adf61e73a8af0-3c37cf06741mr3809026637.7.1784183383331; 
 Wed, 15 Jul 2026 23:29:43 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm9895966eec.21.2026.07.15.23.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 23:29:42 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
X-Google-Original-From: Badhrinath S <badhrina@qti.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Thu, 16 Jul 2026 11:53:18 +0530
Message-Id: <20260716062318.4121929-5-badhrina@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
References: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfX4Fj7kizXPQ/P
 XKW29mVJy4+rpTK9BgrdjocHGDoBaaJRh6rWrkkj+WcB4sKgnfjFnoMicHydvv0q0t/WMU7GTUx
 9VX5vzdZSb1joCqZdy/pR/n58jVccYw=
X-Proofpoint-ORIG-GUID: 7SMJKUqCQdl32dain7bdfIEoa4G0Tse7
X-Proofpoint-GUID: 7SMJKUqCQdl32dain7bdfIEoa4G0Tse7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NSBTYWx0ZWRfXzLnvS8t+BZNX
 Y7foZhO9xerHqwmxSL4Z+7xFTNqhZheRnqLHn8gGcnIdKPH0OJ6t0rZFH5SuJiSyCBFS8ijuN2o
 eKBY5CVplgFP8Nnv5V2tr4qMsXB2Nt3uRqzluIbmkdeGaZYtcefFJY5JVPFKLeszjzcDiFa7vrV
 M+IJ1a2zHKfE0AEEbI2bzRmFo016PjovQHgt7xvKY7hhyfyKYuObdmG3PCwhobn3DvXOWRLhrR5
 bQO5r4ucAio9UlTtlIJbbPFSFvZczjJ1nTBXd8I3f40qAKyRFPVuaCvBPk1KQRbzoiUOtz7J4Bx
 VOn/WH5wYL4MYvE5VoQqnQKBhMQLtDRc5CoZ22OgjQBdheFQMsg8Il8jr2uZJ/yGRf+5lLp4Hrh
 rl30F1e4IbFAyr5tpDgSqeXVm0ttbsw3sMtbxxAsmw92BNHPpAZQxBsB8T/Z42xLRem/n9LNPb5
 wEYauryCE4XAjnDMkcQ==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a587a58 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wHs4SkhdiV1T9ea67W0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160065
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

From: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq9650_mmc_defconfig | 21 +++++++++++++++++
 configs/qcom_ipqdefconfig          | 37 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 configs/qcom_ipqdefconfig

diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..de730067359c
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,21 @@
+#include "qcom_ipqdefconfig"
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_TEXT_BASE=0x8a280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_DEBUG_UART_BASE=0x1a98000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_SYS_PBSIZE=1024
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_CMD_MMC=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
diff --git a/configs/qcom_ipqdefconfig b/configs/qcom_ipqdefconfig
new file mode 100644
index 000000000000..6a7f3c1b4ac6
--- /dev/null
+++ b/configs/qcom_ipqdefconfig
@@ -0,0 +1,37 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_CLK=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
-- 
2.34.1

