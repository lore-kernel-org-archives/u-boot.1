Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97788CD6E77
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE1E84962;
	Fri,  5 Jun 2026 14:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1F4TZ4C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8TSe7fi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C46848DC; Fri,  5 Jun 2026 11:48:43 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD4184879
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6555ot7G3111633
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 09:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/uqFYyoetsQ
 E28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=; b=Q1F4TZ4CdGGGOokXqzo5ByHzand
 K4bl7RnKV70LiANUmduf4NiWMadoRThCtS/LxgaXRlkKIaElVrq9bjUrvcrq8QrJ
 AAGP5wgYqWKpzHlrHHf6dBukul/6WJq/6Yu3Eu+9zHeR1eYtAGGlXwJTycE3bWuJ
 mgCy6z4l3+cptm1o6rlEt/dBu+OrGVI/M8XUeaOR7LCNPYMUkAJEGqkwsB/2iwr8
 t4V24IxxaJP11LU8p2/ZLT6icDNh1btfc8GzWm8QUIZ8pwu3/qx6/PNZcVbAaQjw
 GU0yGgtF7ltmvLttDIkI1YkItb68mz/8c9fqkPwDJA+xuWBiJN5gSHcUKXQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv72vad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:48:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so1231448a12.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780652918; x=1781257718; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/uqFYyoetsQE28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=;
 b=M8TSe7fiBUi4dCr9/dD6FJqjBuQ92XuVwqYQkYd2HDqg1fgwozpW7bDW13l3QFNkvR
 +qHLi2H0AdrpgCPl78l2Vo2YLRxVuDj57S3+YDLkp6agup9N/Q9/MO9m1h4NBOoTA+uk
 hYO8O2HSaIcQ4ksYAz0SjxrBIpwxk8TNUn7l9EBSz59PHtxXNbV61PZnromxRqerYlpn
 Y10kACxfsAg/5zfMEOBPpeL0BC3Lh0BaVtNK2wWjv9duD721j4y/WZL329xByfBiKCxt
 oyXrogMfRQBeZMxre9k0B3zt3f+0x1DmgX4asFSFvMlfCU1ZtGTj6wbEEEGYpqeZcDtP
 fV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652918; x=1781257718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/uqFYyoetsQE28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=;
 b=rGJ+jcJ5BgtpVA2iv7c5+rd0G/P1Fptsel14QLtXGtCcuIyW4hvWIR2w5a5rP79laC
 aFNFDoZMXpz2RqCxexIpcq14oKe0u73uYF9gz2joPil8m87CBPdrAAaf83UkApmAI4KP
 szcVIT79Q0EztNYjNYbmt6COe9EI8fphhS4ayy3MZyHSC//vsoxVxtrV4U5hIU2bb46d
 GIw959+hOSl+tbAeXUF6VhvY8z+62ZGTUX+M+oeBpr1RrLoNUsyvUu+hukjfdj6TB6aX
 1oKvaUPYq1n5viHbMpyOA5QU++s8rzbQs63jjULVZIt/2Beas846LnpCHiBWNbKZfiqZ
 yvZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v+Hi+VcUz7ypTbA5CMPPhv4UKjzCJeAGPDPflj6HfTZdxphhnxA0L3vja33ofqer6KI1QDO0=@lists.denx.de
X-Gm-Message-State: AOJu0YzZqbx3sXtxp8ZQuvv/gbAd0OBpA+4ce5nOaRVRLMvizeG0gBL3
 HiqEVlUnOoY83Lo9DPS0tmkFAdcbzOGDecZkzz2l5rp+Uz0KTqomETfgL8qlhqr/BNf4u9dMt7m
 ehsH/nycbCIWpsvzlId61pyKHl5hlGFbMKmOhcPMXgXdladCf8Cd/5ygW
X-Gm-Gg: Acq92OFenrOIEAMIW96udllRG2n7xfMHalkAYBcnfW9UPpKA8ouhog+feEwfDGMQYTW
 M1Hv8Z8EqtfCM4ypq30cE1SnVdaIr/Y+SDFOEBttBQK0bxi97bKjPRQHNeukzyDs4H0VZzk5cQp
 kwYk4wQ5XWfPlYpt6EcwF75w855ZENw8QtNoVJ4sZ4DatjRAm+77/luYhD2m6FMlMeQ8l85hkXN
 9r1zOt6HQc/2Zk5JmZZFeb2kqK5eVMxO/ZMzLxwtkyq1oBQPfmlxV64GdaILqGbFhy2u73Vx9ja
 8bXgKaJZd+N9gg/pCfnlO10dIsHEcSTpUwY5MXyGvj+LLDe0/y3AEFG+ZYae1w4/yGaxVg9DrTd
 zbgYmGAp2/zWJi9ZFek8/3kYj8MaNcuGmp6nc49io59vYFCkH74aGECbpBg0MxFOpZaKJBWxiyd
 gRFMmLJl9TWM0YtD6CfO7GmHve9XoFpggMFfRyC6o5Ai8qXsqM9hO5
X-Received: by 2002:a17:90b:51c1:b0:36d:df4f:ad1 with SMTP id
 98e67ed59e1d1-370f0285550mr3159821a91.13.1780652918287; 
 Fri, 05 Jun 2026 02:48:38 -0700 (PDT)
X-Received: by 2002:a17:90b:51c1:b0:36d:df4f:ad1 with SMTP id
 98e67ed59e1d1-370f0285550mr3159771a91.13.1780652917843; 
 Fri, 05 Jun 2026 02:48:37 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm6208237a91.9.2026.06.05.02.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:37 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Fri,  5 Jun 2026 15:18:01 +0530
Message-Id: <20260605094801.4130128-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
References: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G2CpCSwABzUaxSlvx7R9VzTCdVw83BLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5NCBTYWx0ZWRfX3AnzlzcGqzet
 Vrhq2PDfjmkqKt6o5xHSn/kvEhqGtqNppB6b3W7cPTqcT+gdgT90boe5vB4sH73PEigxn3BMY4n
 FAEBzt8oiVRE+6PIgk6U0llWfW96rUQrq3E8XkVjz1fbNDwc4CJyo5y9RoLakY5j2dE3os3s4zw
 zsLVzQfaHNCJ9oTwxkMlVSyW+jCV3fxjeqySY2cFAdEE2OqEmReR0oXbyvAz6FJJ7y83/Buf/RV
 +9C/LyIYqisbqP1Htthq5DToo9SrNp+YE2VOKh0treSbqCnQhCuzRljvMEKLHHpVq/0vHYREofT
 PP3JGPwyl94RwWQyEpXwkZFQoDEJ1BTfF6TZJnd1eCPsAL8nu/Ebfozf2FaFElq0Gu85cG6g6+P
 iTvmgb7mPAGmobbCCXgeTVGNaULsiSoG4W52Un2Yg8vYWVAv4Y7vUkx6S60PHixYuzh99dnOknG
 MfpGL0Av0kybKT3SZRw==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a229b77 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=AgL0tj34FG0E83FnmwsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: G2CpCSwABzUaxSlvx7R9VzTCdVw83BLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050094
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq9650_mmc_defconfig | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig

diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..ce2488d72eb1
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,57 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x8a280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_DEBUG_UART_BASE=0x1a98000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
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
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
-- 
2.34.1

