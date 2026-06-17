Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7CBCD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614CB84A38;
	Wed, 17 Jun 2026 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gYqpmTB3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z23cOerK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2501841DF; Wed, 17 Jun 2026 12:20:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8861838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8VZbg2190769
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WJDE1aa3i4m
 1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=; b=gYqpmTB3pHiTAeges8ZxrEfduc3
 3vMXnecC1S3LYbeZxLWJWROJ6wQv6vLbC3oi/++XxpOX6ZPGxvTfqMCEoYlObapV
 XBeMyZhikXJC6Upd+fxwX/tpNODvyeYEuFFyeFLNLmVKDlQgqmhkN2JIC4T08OXO
 iD5jSLmvp4idvMRNuDrOF4ZpG6FegrUVExkvuG/942VPGLhzNuiUX8qBzFkA/am9
 UTeWB8I12pN/wCjs5uEjd9vgXk1YHRiUK5cRwHzL5fzzCJqH4hY/QI8VluBSelC+
 fr4GS9QACmRAhhhZHCNDfG9MzOi3ExGJgL57CN5DCp8c4neNsn8KyIavlLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjnhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423f544944so3931606b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691646; x=1782296446; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJDE1aa3i4m1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=;
 b=Z23cOerK6cnBTIOFEwd7SyKa2UtWL3zUrW76ECgxmdgiEhOe/Fe6FLvF5HAVG/XA4l
 z1Ps6zPomlh/kMf/h0aTPvIPcBUVG21mt8flH3f+vztxkls0cQNCG80++GUSON4o/26u
 V/zQkNRL+tByfK8zPR7mj9A2Q8wJSuRxlS8qUvQA7F8VsRTEFw8cQ8NTGYsMtfZgJGRg
 z8Psi9RO07+68vrjW6VUgzLOfHIK057t/jHL9IBZIihGTFJ5v5gzUB/aNBbExaBNqcsW
 S+A9QFmZGffYmzuyWYYf6P+9o8dO3nYdwefqyrBF3+AlLNH1UdW+ZuDlivQtyrHNM/XQ
 SWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691646; x=1782296446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WJDE1aa3i4m1hwxeQ2Yg5sDz0hh0In4D0evCVdkTHWs=;
 b=W7FVXKnVK9qvrDuoeHDxVy00PKefFd5eh6x0f4nKzT9OI/h/xg/tOqhn9e1/1wXID8
 EzaFwQiTLkrLBExXgX+WriNmspyIK7m4IJXkKL6ACO3pn4i5FFQAQHBGEfXZ9Tm3e/N4
 bucObicXdRpANL3jE4XdfPos7L8yQ+VDGtV9ehJ+zqsPI2ijYCXU5/Q/uQPxIkFkLZJ5
 LAoJJnY6pPZ2gRQFc8OTvxrV63xGg47S+hOuDFvWYl0a/+E683R2iOLIVi5/hJYXnghA
 8HKJLPG6shyFYe2m0X+E8AckFJXQ99POLz/WqgpUmJFBxXJZeFCdxMc+w7LRFN87ASGK
 04bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o0dPo7MnFnZHxJ5sTkC5VmZXYyYPHeog7QJMOEfo5OtevlzPXaU/DuoBUUhZS57w6Rb1rGNM=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ5qdhJdQ8oKah16jqfwG5A593lBK3C4H5c6rgmfHc0rP2izY2
 8zEx6CwtmU4NJLQ2iYcLKOuarRbCkRdArBRDagsG7tFch0D78LUrsuY4qjL/JFtlgqOUGaBSjZj
 cFME8sgm8rPfavex8ikHBYnStlfa3WfmgapTZ/9MSTUgy2cTzD/+SheUq
X-Gm-Gg: Acq92OEPsaNQImrde9lfZfUjNw60qvuhJWx4MbkeNZ/eBK9vALWKBOX8Pwfrk+MwD35
 5sQnjzoWA7ybQ3PVeY1ixwlajAK0OPOitua/4ggWJjUBfe6JIjwzARqa4Raniy+Hl7/59mBfAdZ
 SrbfKwJ2QOluEgfAWWQelMJzTH49XHEnafyHfvevjtl+2y1pjDAh8q3vIEenYJV8l74cQayIZbi
 MFzKNOXaG9ao1hNqT/itrkXQYRS7rP7D9v0hWwZjELQQ19VhaXz6UYwEZofyjiYWbjhqRJb0rix
 gJf3lTngsWXHQaA0l85d82WkGaFcqnx8K3JzbxF4OxLFW+kJ2MbPK6MEbmIRgj22IaBdxM/J3Je
 fysKFXaCDJ8SdnSZDRi8Xt2NEDG9UKo2a86rAtw76Ul7+iL44RuSNQQr/51PrrdC8zVQHtKJObf
 XF5yIBogc58pfpduetlt0LMdAc9f++cVzeVLTjTnSF
X-Received: by 2002:a05:6a00:1741:b0:839:dd77:3505 with SMTP id
 d2e1a72fcca58-84524557601mr3072806b3a.22.1781691646241; 
 Wed, 17 Jun 2026 03:20:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:1741:b0:839:dd77:3505 with SMTP id
 d2e1a72fcca58-84524557601mr3072754b3a.22.1781691645773; 
 Wed, 17 Jun 2026 03:20:45 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:20:45 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 12/13] configs: add qcom_ipq5210_mmc_defconfig
Date: Wed, 17 Jun 2026 15:48:11 +0530
Message-Id: <20260617101812.299586-13-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX8T1XO9xKYoiz
 uHhuUue26gu5og+OxvcAnddDar08L26O2nuWdvLKs9z0esVKmdPmTUN+q4YaJ6vspVdZyGEGjjV
 cmniy67UJ0bs9V3+EMmXZk4zI5o9nsD2c7esXwO4SnfA9qO41d/iEpkqJa8T9JT0PFSQjK3OWJm
 RyRFgYypVc19Uhi6XVWClzeLCukgYtCBjuk8Bt0hpXgFidCyLsLx7pLZRn6WNUUebhbgZdeVuN9
 tnnc3ZbQrHKmy6pJEuuWPprjie9e3b/I2UmDfGBjFPWNHaXvyPdaLXaIA3Vq91NosrIW/3+rtc0
 9zU7tmd/uKzjkBGXEOgU5qDjAHUOLOl6pV6llgZxBqlgRUO7F8RK6WjJps0Q4RmmqRoPGrAsyKi
 NKBl2GVv5M2567H1it+KypNj3cwvlABFZt3ePvphQYfr0UfQCOhPXSGolVX2h1i0ctY4wZv8XgG
 oEHjKxTNw3xOtFT5vJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX0+Gq9vx2nGrf
 ZCeEwQ9wP51hO+QKkvRKU1xmnCDpBsRqs2MIFhhvoIkLo4PZSJivcrqd/tUvaNmJ7yy4/Djm42X
 deEu8MlO9VhyBzc+yej0q8cCTSnVlqA=
X-Proofpoint-ORIG-GUID: McxDMfS7BA6izwioKQd3eo2pUSrkhY-Y
X-Proofpoint-GUID: McxDMfS7BA6izwioKQd3eo2pUSrkhY-Y
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a3274ff cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

