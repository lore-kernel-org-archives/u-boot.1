Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8018CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE1484A4B;
	Tue, 23 Jun 2026 08:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNXodSkr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agwiHubD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021FD849BD; Tue, 23 Jun 2026 08:50:24 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80C8800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cYmA3338347
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WJDE1aa3i4m
 1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=; b=kNXodSkrcSQj/wm1B6utayCSwKv
 PrRVEHO7/aFX7LwZXOsAlHsdvM3IysbSydChaGn4ASgpxs3qJlvAF8lV2Bmyds4a
 D+hErim3muNMTtC/XW1rxn1N9JeCae24CTkgUtXAYLVijIdGrjfjvBMbEz0zTpxz
 fCdq1MPgph2KqskeXZl0DZLyz44oysnQY8UgqcrVGSoDMay5rQM1NwBtUc5EkyxC
 0mOqQ0wW0+Y9VWutmZrk1hWubeIOPrdHO4sfwlcbX24ApJq2g8IpRqjSn/98CIK7
 A5hEbVYwyrmNDKs7BuGw4RKqHyTP8x9NxoV+dMuAUN2aCBfJJ/Bx6aFY7aQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjgy1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso2248874a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197419; x=1782802219; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJDE1aa3i4m1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=;
 b=agwiHubDwdYfmLpv81k+LdH9Y7lzh4mF3UHHHKWI5odUmrLePBs4WTPCCWEgslqPja
 mTG1A+Ds0kQsJoE1TeL8sc8ndIsLn31nOQxLoLxTUSTRegvYvonpPDjd5/j56Bgw/CEO
 wFtzMLsK7hJrQlGTMoQMAU/Bp8jI7CWEDFxHcNJzHLnLcGjs+srmCzs6JjCq6aCk9Usd
 zhxA9NPFNs56IOwZ5V0n3N90y7XWBoRehXdqI7phnSKmxxh6TNjLdS2rkk+N5YwqXggx
 IhsYffO7T1eKYDGgzzZj9pKbGgRp31n2Fi1YpfRcO2nmBN+kwRcYJUL8gxVaJvIIBMHX
 cwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197419; x=1782802219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WJDE1aa3i4m1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=;
 b=X4imJ+g1Fwb/16f5PoTKvGaoc+o7DnS3n7oXW74zP2z3yxS8XWri1yVMspGFbxIDjo
 32z6wGW1v9dlqsYhX+Ls/jFIbDYIvgyDDO20xEtGVg4zL+moZ43ai7B8/r879y7cMYmi
 PVxNTrLk2+QIvczOC+IhdjunWFyszNkPRQFmlDd1jIvjnns0iq7GHux8hqHWbTCxlZlG
 pUeZPC9U5zMus9mExlYWYtIRtSGhSh3e0TwkzNCSzpoR0cxiHmWO0+d6qTqezcXto8OI
 V3WmlJRp89dUdmqPj5WViik+2m5dgxSJIw8yl64gD8FcF3H0Nhp3gaKVSzOKv4YxLGWS
 Tf1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpd/ZrFEWOVUo9ocYwjA0HdngWsgp2DxH/CfqYTSrPJqnU2QUdSaeHgwpJYczZArDvujQkxBL8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7o23KnC4viWSND6u9dtMVcpoaRtRi/7u7t91jB+f5vQyqspYz
 dPbnDMgutmkPVl1N6y7ON+89fVsnJbR6bwDzgiJf4sADNAnN0AStZGEEM+VIJjwdOC8KmNJuh6s
 s2kQjOKzs9YQiVG5WVwoG7qw3QWpuleg9txnqIhrDCnvV4F1Zb1uX7LBq
X-Gm-Gg: AfdE7ckIFTTCSuWmbXUFauEmmJmHMZjlripqDr4wZJfLzx4hNugw/cI026w/BiGYrsC
 arkbSz0gm92c/KvjD0aXO56rEzcjtBQPwzdMGrnJvad48CGvjcv/lXmmlStXIvFQhSwI+RMPsLR
 Hz6ycSdSMo8RjQNsz+5JfzZK/erQT75CUjMdDmwazgutRV9p9UcAYCnldXGdV7RvngQd8i1nrfD
 NXkwwpoo/EoKkElcEa98GEuFCjSyONYTJAv+ZpcKSQMLAYMKjL1vQhypEmZYewHVzZM1eFYmTZy
 buOub8hTUmZVB7vGAr088wVuOScd31468sJNOVFTeCI1E1/GrWth4Pz1LVGGuUlA2mtxEGsvw93
 Gp8RbrFHcpPRu6X6jAnrLwtlytCA3t8B3PVOKleQWPtTQOq5+Qn8L1/SnAIdDlJbT24BFm3iahp
 c1PINJY5mCtxZ/4ifZZfGHR03+opzxwb1ls2Qmr1n3
X-Received: by 2002:a17:90b:4d01:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37dd1747ab3mr1507651a91.16.1782197419110; 
 Mon, 22 Jun 2026 23:50:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4d01:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37dd1747ab3mr1507609a91.16.1782197418627; 
 Mon, 22 Jun 2026 23:50:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:50:17 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 10/11] configs: add qcom_ipq5210_mmc_defconfig
Date: Tue, 23 Jun 2026 12:18:03 +0530
Message-Id: <20260623064804.3988799-11-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX8Xpipl67KWmy
 H60ABD5LD2BhTJXIuhQHgcheIoZ52SNDmJNlze/x0BJ9rTIDgbHVTkSKMmSckfwYM3GRFEv5iHQ
 7GFSdzoiF14nmGA4ZsQqqnF2ruqVxsi1OjGK3CzDoa9eNnhwoQeMoE7ARNGURrmHGktKk7S4oMR
 BHMis3ph28d6igJ/68QlJqvW4X3RLGqJ3Ib71WLe7uYAQe4PXIrc5mOk55kkbXbeW8cMmMzYwaM
 5JgfZy23DJijOVSiduq6XrgtFccJs6mVTSRQ0Fn/GIniTk7Eckp4zTPKMIq1CDTwwGpQ24/1d88
 DEQTmpEa1Ri7vY1BswmThoUADxcYonDsXOT1jkzy5QFm4iinVrt6hEOAEvFajQ427nuD8ZGKxMY
 H7QQgE1hSz85l8gzz+KwAHXscd35JYL1gdkcoQb2B2vQ7mh+yayg8/kKDijohkHC23tQvMGLjZn
 Fon0M+xIy5mXCxuhZMw==
X-Proofpoint-GUID: ZK-KgiYDUQzart3VkL9WYp9JYR_zzKN4
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a2cac cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX4r2w8Hp/R4mW
 f9sFTQfaRE6rlRg+2jhX/BvktxTYAoQ8+Csw+uJ+O1Mh6AQUAtEfauSB048Ol6FR98N0qq2nU20
 CA5Vo67vZg46GC9ydi5Tn8S93tVPVF8=
X-Proofpoint-ORIG-GUID: ZK-KgiYDUQzart3VkL9WYp9JYR_zzKN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
Presently supports eMMC.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Add CONFIG_SYS_BOARD so that board/qualcomm/ipq5210 directory is built

v3: Change CONFIG_SPL_STACK from 0x08c60000 to 0x08c24000

v2: Enable CONFIG_QCOM_GENI_MINICORE
---
 configs/qcom_ipq5210_mmc_defconfig | 107 +++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..6d608de822f
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,107 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
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
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ5210=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
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
+CONFIG_PINCTRL_QCOM_IPQ5210=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x08c24000
+CONFIG_SPL_MAX_SIZE=0x3D000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x08c24000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_WRAPPER_ELF=y
+CONFIG_SYS_BOARD="ipq5210"
-- 
2.34.1

