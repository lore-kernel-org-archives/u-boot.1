Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46337CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293898493E;
	Thu,  4 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSxLkrOs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZltBRl//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE9C8486D; Thu,  4 Jun 2026 11:34:10 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A5F84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548V9AG1135908
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LVp/0UC1q6N
 X8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=; b=RSxLkrOsB5D4jXPR0/H//cegdvV
 hwh3Q9KHVnO8871LbM2Oy6lSmTOKty/ws31Fj6vT7hs9/KJ3Axs4J2cIrOm6Jxcy
 GXSgHLQUur9SVkO+Xn+ed+WtBd5ejP3cJ0BkdTLNgsjKVSMW3dQxuDSOcmcm8zPQ
 CjGz8OV4XlGDCIXaWdeO1eQ9inoRys2nXpkhbOjckp8yLBtWdvkDcRUgAENkDLRp
 Jh5FRbwKvUxnQX3Yarb2b1wnBhGyx5uOTnvXD6gohs98jk61abi8XMT6tkWVlEuc
 HWqoxIlHMlq61dUq1rute9clDeBTHs6SGy9kViVOxRpMqWGB2sazJrB8q+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsg7t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:34:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36e09ec696aso992925a91.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565646; x=1781170446; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LVp/0UC1q6NX8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=;
 b=ZltBRl//PGhXsGMISqWaRUndqGouc5Xd1X6/5sCkIZlhvX+DAbVSdvGFm0miXaXAqK
 S5kpk1SYC2TibC3DfaBOU0QhCVBowjkbCXoZzwFHXkWjmLRijk0C3nbtFuthDTNwZBF1
 DTwCHbXAREFhwRQ2fO2OYe1aAuQuMeEPyz6/ReRxW74GhJRHso+oC4IrLyV6IDZxAiT9
 C91V/Ltqim0HsuzcxQFwjo2+3mddeTZ972fI3gv62KaXb2sD7ekL4ew6yXMSv2ObF8+a
 NC4eKFQLFS1UlM+mWdRQoPJY6WC4I0PSp0Cm4c0zBVupqH7BRK3IbhzsgXX2zzgTvX8w
 U4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565646; x=1781170446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LVp/0UC1q6NX8tC+M/QgUwFCUgQ5mXSqcRwM0SxDIcY=;
 b=oIh2O5IRyqTCJ8v9/ZDzE7pN0FLD3zV8EuoyRJhDgh+1FIhfqtqVHF1KpwlMHDGpOO
 bk8bcNzk0xyJYa6Fgrg4jugB49XSiYH4+iZikHuL4NOR3tD0XQnQ5d/Q6yxLqSyIlGOt
 BSuMI/B9RQqecPvviL0Km/gkrPcmshs8KgmG/s3wry0guewv5YVd2GKBJ+aLkwckzOJv
 qN+kKiu7aJ1/qfJZcXGsX9HDO+ptwEsXW1h6QKzORYZ9rROWkja5n6l0TSVXotp/hsv1
 pQMZ/KOIyv11gaLzDcqMsnXz9Q7TCYTjICa1rfaAJ8zrXaVNZtrLL9lfs/7H1a75fiXT
 nCaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RzHJS0FCDxns5TmdDIgRkZlq0VQlPnT/dJ3zytpPFI6O6q0CTocv1M8GjrSqsHZBiPQlLmn0=@lists.denx.de
X-Gm-Message-State: AOJu0YxVYnkmHGgoqHRk2DT+SwAdOYig/GFVHaYqON0Gblm3zwqNYJ59
 YZvOdDz3sejYe1o0PWSNoRSzFRGv8HkmxtmkgH9TtrIZJyYm8UIQYxYgX/VQJTx+0sdSGm0j9z4
 9u6RDP1U6ZVhFOXyMaanM8cg7uyfHSwWvocHG59NU+pSnMUqXZfvWxZVC
X-Gm-Gg: Acq92OH6uYdSqV0qM+D8Z2XTK9ef+CivNsAWB/ZGPWmrP3tpcWFb661PNUvfmyUPkFb
 tvlUOo54qH8uGrs57q40shOzsvP4HOXEciGFzh7V27fcHiN36EkR4BSW3rOCAxozERMN8OnE3M6
 09MWBpyq13LjOIsOiy3rkKQfjvOJJqs84G0mAC3it1H9tWIBMN68ueXbOjUj+Mo3AELI/TNu54S
 0+HvUszCqEjcI5j6Me0pHBzXO4yMdw93+1JU7NsiBJcfXq4WUG+8uIpNitDlD5VFAHObhfCDgBS
 d/RHEThounEG+9R+NvmqSCxP8WZfsRr2KD3HifxkyGCSYzEswj+0ZybywAs+ftU7lrxCkKDzu4w
 MXkx9GU1yDzv4R9wleU6cy7bNaQoYQ2M3uw+CVME1Oe673DfMbl26J1qQW8EIZ0vOvuXOAe0wJZ
 2JImDfeltyeyU3Y8wUD7hQvEyRKRhLn//X5EYxMten3cYj073D1tcWn8d4sQkIkw==
X-Received: by 2002:a05:6a20:d52a:b0:3a2:d838:bfdb with SMTP id
 adf61e73a8af0-3b49782ebdcmr7999088637.29.1780565645722; 
 Thu, 04 Jun 2026 02:34:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:d52a:b0:3a2:d838:bfdb with SMTP id
 adf61e73a8af0-3b49782ebdcmr7999036637.29.1780565645293; 
 Thu, 04 Jun 2026 02:34:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:34:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 12/13] configs: add qcom_ipq5210_mmc_defconfig
Date: Thu,  4 Jun 2026 15:01:31 +0530
Message-Id: <20260604093132.757583-13-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gO6wfLSki9w-lKM-QMSM8aL2MzRig7ik
X-Proofpoint-ORIG-GUID: gO6wfLSki9w-lKM-QMSM8aL2MzRig7ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX3mkMGMOhq4QU
 yYcwgedBWjOhGtWbsfEqYf05C1MxjQLz3mp62D+gm3xiUpHV8/NRBDoamRlcKP2+DjJZejGktTK
 5sygl9UoVPLrA0Pru29lJmpEMMsc4NAoOEIkv+5lKKuAEIrtsTJrhsuE3GjDi+72YjTuAFaeRJ3
 YD0zjNzJEi0O3e4PhQCJwFpYrQgFK2lEycGpt6fdl2pbhVBgulM2Hz1dJHk25qXV9UBpxV2bP3U
 dFmQcClLqM184OrkgLb4YDbmeFxfs5JzHIsa8PPeUo51IfTI3gmre6w3wkiBMDgragQ8kkinc+m
 hAnD4mzAr0sYOK73D7x1b2Ial+Fdplge3cemxILXoo422vU68PNSWT/PBpZCrPQLH9KTwiwd6Xi
 OAidLBFuMNNxJHpFglJFbZz1GEE6T0BnyIOEOtCnBxAO5lvKv3fZHnIcGfXT9oR3qfRHpHY2p9y
 c5BHIZWM5mYHry/9I0w==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a21468e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

