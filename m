Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A8F8A173
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D954684255;
	Thu, 16 Apr 2026 15:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hIjaGKGW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eqAvFUTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E918407E; Thu, 16 Apr 2026 07:41:32 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BB483C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1VPNR3089108
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LVp/0UC1q6N
 X8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=; b=hIjaGKGWPWq5IjaOy6oDhI2fioi
 QxiguMvlAirtYdUo8Bbq+Z0PA51hmLwNI4M7PzkBX7lnohMpsKtC5q7+eoM0RBk3
 gMu9wrVCndqtfkbxec4N9r6GNl2R6g4k6qemBOQm5LqNAf2rrw3pe5jW+FOGe/8c
 MMXgwuobDwsvcqtChfWVB7qhWt3+MTz/RQqEwUluCTGV5sDhXLDxsE/hEzatmf0u
 eRGC1FQTX69q7Cu+sMfeycuezexnpnwa9KT3/zFkdD2CwBV3GUV6cqBPpbkVU8mF
 IjDXxPfyLZMkeTOAPVBEDGzQCj1Iz8r4VY+Jy6spX5QNAsguwyhqDHjyfng==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djp6a8nmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c4664f75fso4735850b3a.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318087; x=1776922887; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LVp/0UC1q6NX8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=;
 b=eqAvFUTcLUdsbNA1r0YhbHuFtM7SE9L6QP+tGO2RIbw15TnBbhudrFSWXXJAT3JqKp
 du0AiUEVqRKOO2tlwwLjRYEknI+T+ppHVxM8f+4G5S8IOXbx0Qf1t/iWyReeaqthj+EN
 phYfcV+gkuiKUeczcL/LRWtZ7wI9PZbuU84tizHzcOGG1KOYghcnIQgTw5xF04RwvpeY
 basPrg7Bt3TYoAP9Iku578x8Pp3EEa8pCaVQZcbeU5eMwUxViozNMsPHxq0LUNLzWAEq
 VvcAWYBAoYJHm45LUQvaolM9p82f9JAyx8+Bie5JdCBEpGtuxQKcTrsPs7WaRhUNN0sf
 gPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318087; x=1776922887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LVp/0UC1q6NX8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=;
 b=YI+tbjeMQer+BpjEi/anNTWFi7TEiZ/7FACzVD0nXoDpw4+qyLSqwKopeJRgzh/Md4
 Db2BVXUgzhoqMEfNtZimTOuApPqMsQ/zWdajR0epv+DtdUK1BotrJprOLOTvAs/RVI54
 UADmFl/sGDJIziP4g2IDpVKwTLzKBSTtTAH+7xGRIMJkFuJXde7Q/R3QV+uvEjafynMg
 0BEyVtuYb2zoLPE9gDw1Ylazb13WW7b4BHB7vquYWDR0/HViBMR0vmbPoCFpOhVu5uVN
 odp3WfXFvx9syNzt5pgxKSQXx4SDaRbv/P+fwz9V2LDBIM+UcBNze6/CF2PtWrZFHxa3
 RMWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8Vys400U4hNbiJSto6Axi7UJVlsbP4ZC54auZ/+uqV+orjOrTZ21jw5hTPrCtG0Va/uLymoI=@lists.denx.de
X-Gm-Message-State: AOJu0YyPsvJ8K6luYfNc+OAUr2zCX6CsVR8aLFx27iNkXZcq1s1qYDS3
 ARdvwhZUn9IQyIOSaZznwNUgoJ1lkUDjoP6edZ2/ZAlHF1TygbPFzhpmU8hv7I5AGthTetR/2Dv
 svI8sEn3ELVJjjfbkrqbjzBobxjD/7OJ2Qh/WFYLIkT5MnmQtXur6Ovre
X-Gm-Gg: AeBDiesg3ss74Q1IWYbVtMb1wMZq3jF3lhFJJtYw7yVFFxsStfbAOkgGHtfxv7whnTb
 8qIAZbYbNoEIzQuLqHJn9CTpeFD3y58rxJAU+Z5eT8orpBDvqtnwJvI2Ca7qdESPMjweHUDtaVC
 FrFltoyoPIPrS3qskq9905/RQKY92Ug27yS/XkwSdPWLuj+DD7QQ7/7bWdp71kcy60crb+VX7JS
 F0pXxUye/fF1iHJ4H0GHGucPqPNNBjlKPcEgP/SnaauGZGtXAv9GTsR2YkCAs16wkoi3lsn64q+
 S37jxnzrSZ5rYW3Z4Tq78q6+jkB8cSLSugVSdco6anUvmEKsJWfY/WJjkbQqWSKVBIRJYUE+KtG
 FpieRe3N5NfdJcm4gomrd88IINRA+DiKGqSGVmVexE3ufO3TRzG3W1PA9E8/AIJcTJJFyGpLHW0
 GUH8bnxsrCXw/26TbF357UwxHVk9n8Uo1XU/YoBMpEIdDPA3Bl7O8=
X-Received: by 2002:a05:6a00:b902:b0:82a:60ad:874 with SMTP id
 d2e1a72fcca58-82f0c1633d0mr22932168b3a.19.1776318087208; 
 Wed, 15 Apr 2026 22:41:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:b902:b0:82a:60ad:874 with SMTP id
 d2e1a72fcca58-82f0c1633d0mr22932124b3a.19.1776318086702; 
 Wed, 15 Apr 2026 22:41:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:41:26 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 09/10] configs: add qcom_ipq5210_mmc_defconfig
Date: Thu, 16 Apr 2026 11:09:27 +0530
Message-Id: <20260416053928.2834699-10-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BSZr3Jyx9AwGiONGr8AOJfeh99j1Je61
X-Authority-Analysis: v=2.4 cv=NuvhtcdJ c=1 sm=1 tr=0 ts=69e07687 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: BSZr3Jyx9AwGiONGr8AOJfeh99j1Je61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX2GLwCkQAobbQ
 NYVKDavzChSolXTUhcFZ+U3FtsQCGechAy2NVXD8aItPgDEYk+IRcKaP2WxM1sclPtvjXy1Tx72
 Vgp9IQXf9CezLgGwzb+UPwC4sBV1LSWaa2wbAL6vG4CMuR9ue0F8sQqzyrMrWLP1VYtvnNOj4nB
 1ejylyvGvw0cXbjDBr3WLI2cCDX9e5p8OzIQcd6FjYI9apHjxfPTvnEIIX1OsMzmJ7D+wg47Z12
 gWOuryA8/5KOkC/SDNEHHN4yKEJoeUjGAhAb5qRl4LWMuU6ODXxGcHn636elh52zh087U78HGpr
 aWlkxHV1GEkS8yvdImAOjqwrZvZ3/QPvZyDFG9fJSyggt/XL5iWEO5ZYo7y4cWIojgU43Plvwyg
 doklh0sFYR4VM6p1/xKh0biFQMuxWTg/LVj89KdWGGfOMWZ2rtS8CCV6nNqxTNgobhRldFFc1Ly
 zUAYeJ7l8mpc4LzAJ9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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
v3: Change CONFIG_SPL_STACK from 0x08c60000 to 0x08c24000

v2: Enable CONFIG_QCOM_GENI_MINICORE
---
 configs/qcom_ipq5210_mmc_defconfig | 106 +++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..e903daa581c
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,106 @@
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
-- 
2.34.1

