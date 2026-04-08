Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1121073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CACEA84201;
	Wed,  8 Apr 2026 14:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tj2q7wAO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kf+e52bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C1D838BB; Wed,  8 Apr 2026 11:13:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FC080433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6388rp9f2412265
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mPbuYTmkwmP
 MW96uiEBbBs6020Xh4UKH/Z99E4/TQv8=; b=Tj2q7wAOoUKDNamCOM9SppNbuDB
 UDXhwuUDXFFHqRA8/dIOgeS30RaGO8gglbHF8Ycj46BXDf3onm7N0OVboZmT5HKP
 1rPdNzCB2bQw+tDMDvTHLf8QKHiO8XAlMh6RRoXYRjxy+4z9O9y4roZiZS6xPD17
 PaI2d++krZjjdsEuk4HDPne/Pev7boDEex2PPzbTB4nOcGLDezpIHr+UM9Ft6yU6
 iF+LFbLAAhpjsgoh6LXP5kuJJFOzqTnKaXbg6IX1JbsSauIrSuVmfQTxZOaMNvaA
 jusvgtstJ3njQQI1t3hoHo0hvQ42o3fPF+MQDrZ1R7tsXkzWDIn/lgn10IA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vb138-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:13:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24e9b4d82so7091515ad.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639609; x=1776244409; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPbuYTmkwmPMW96uiEBbBs6020Xh4UKH/Z99E4/TQv8=;
 b=kf+e52bmCVOhE07htTiouhJFnW7TJvULe59CavxCKLGIyOrlrIkzHkPBMgF+eaDWrc
 AifBFEpGTAF7OyhS8A61VGiZyUI9NR7Cs6cpDtQZhlOj4gjMGVnMdZ4oacUCT1lwVw2q
 R3UVA23xqY/bd5Eivs03yXplvZlZyikWEsvwf9Ic1NveOYyA9L4ZwbdFsl0cwc3ytWbz
 cL9A1maogGNpYMjqW0Q38jzyXU+amak2zv/+XaSW5UZ2uTLV8nnoNqhDb+N/8BXPrwSV
 y5hOxtU03yjOBdJ+ijfEQ0F+PUn+cmPIRZqUHxbh5jpU7esDpmwxivObCkqiXz3iABfZ
 F1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639609; x=1776244409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mPbuYTmkwmPMW96uiEBbBs6020Xh4UKH/Z99E4/TQv8=;
 b=KgzeSmZPbCXIWnioFrqH0dbBXxgek4ctAPyY9xLPOHJ+iQnfYDYG1z61nCBsx7OQTZ
 n86GC3FnKIq9DKHmWxWpGrw0d1XNWnnj9qQuP3NcAl9QDJW1GMYYgc7aO60yPISn21j+
 Khu5UITET+HfSg6PJauis2i1wPoewW6fsgl6W06bZmFKJgmTo7shd9D7iqd0Dkz28ZyT
 thU0LizKz5nHN3CzREdXnDNrQJuABf1wO9I+TsOvzncKRmo1pSi5duKjXAQK0LFExIQ+
 ZacS1yNfPZc8TNUIEFsFsgGix2ttj4Aos5PiZP0vpk5IWvaw6jW/LuwWKVHbBzaMO9D1
 Ukew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxbo0wCEtM/sAQPI8PEL2A6wpZ+vtS+0Q50yarQij3mJS6wOTANd/CAyeEMP5WlQchbKw2yWc=@lists.denx.de
X-Gm-Message-State: AOJu0YxLT3gRRB03y555E1qjhT4Q+ex/+q05u11gcHVmvz7aqMsfHEDx
 H3L8P6u6tbcNT3odWKyssQ0qmEu5W/vDcDuU9XFuH/SWmNARSJvWrPi0sbirCLEYvEqk4kC7kgA
 Dn8s7jRc7+Ib/bzF73ZziCKkLviOCmMajWxqjgBqVwxhCFhPlDDQfiuPj
X-Gm-Gg: AeBDiev1iXGND4XkY8ondc9cUx8us7pd2yY7mCCshrCCAgkrRg/PUm8+HzBFGut5MsD
 bmNo7nJ5ih4u1fJ3Tt3EAINs0c3w2/QLYyfYYZT88paPo/D6gwqrVDNAqyaWOloxFFG2ay1OEXK
 4SlyJIYFIjQQ2sh9UrTTB1+YkCnsmpfakbrG8zW+dvJbgwEjf5r7xWkNc9y58M7FGGPcN2ncJRo
 HjNcfPJs52rFbiqLoLQY9j+oSWHM1sbDgVxl1HCxr2SwI5rn+UGr3HEeEKKKuRSHmYwgtuT+bY2
 8VsZEv+1YJuJF9F+NphO7EVoX+0rIXYRvf+tZCX5NBCnXa2XLs++qXfTCWfCpnUlI64GTPA6d9B
 em39bGrCX80pZw5qnx6YNVs7f3Jheuc9ecrH3yFzzFnDwaoRTRSVYqbMVNJ3OZBvuuIQRjnX6zz
 vmgmjL/MX1G5REwen2htcvA1zsMxtScXL1r6+bDOKpRsB3CcxZR18=
X-Received: by 2002:a17:902:cecf:b0:2b2:5070:79 with SMTP id
 d9443c01a7336-2b277e36bfdmr228612155ad.18.1775639609068; 
 Wed, 08 Apr 2026 02:13:29 -0700 (PDT)
X-Received: by 2002:a17:902:cecf:b0:2b2:5070:79 with SMTP id
 d9443c01a7336-2b277e36bfdmr228611725ad.18.1775639608568; 
 Wed, 08 Apr 2026 02:13:28 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:13:28 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 9/9] configs: add qcom_ipq5210_mmc_defconfig
Date: Wed,  8 Apr 2026 14:41:36 +0530
Message-Id: <20260408091136.2794546-10-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfXy0R7mjijzGFV
 pz5lm5fDniZdXeg5MOxQHIyJH5+Q06Dc2Arn81+VQuhvTBzU65kz1/OxqqUgfRkubf8qgUFwtBU
 631qZ1leuSGfntA1EB8RRtB6s+FtUL9QjxiSMQox4Xby7jXFlHpGN+2zA+ODwlyuxqghchIWju6
 09Rem0u6AFtQLnc8RQGk/UrbhBRoM4khYK0xORpHN1uQP8cqAC6UQcEbDq+MlUbUoZsHJwgNjPw
 vGBG1Gdl2Iy4T7dCI+3yO9q/Sb1Cy/J+CP6X3cLIpfxDJymcIuwUexadpX4xzQUFLYaMdHXFmep
 xD5+lD3RMAP+uXFUP0mmx0+UBZy56mpMCifdRr00l0m98y4IIuc9eNWXFke+HpmVBTBOCt6i1VV
 53EJwZTm05L2CxluQ5Z5Z5TeNdiviDBh0su0UgG5Cb6BJpmKIGaLBoTQsFdFijQVW72XookHWG8
 lW7+JCeMoM/ZIOT/C4w==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d61c3a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 1WXnZiq_JSNVqxI6rrfo4nXokWuLkEVD
X-Proofpoint-GUID: 1WXnZiq_JSNVqxI6rrfo4nXokWuLkEVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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
 configs/qcom_ipq5210_mmc_defconfig | 105 +++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..3800961b63f
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,105 @@
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
+CONFIG_SPL_STACK=0x08c60000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_WRAPPER_ELF=y
-- 
2.34.1

