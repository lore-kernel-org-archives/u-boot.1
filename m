Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D889F44852
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C7584227;
	Fri, 10 Apr 2026 14:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EXBh8pDN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CdzGeNUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8719D84106; Fri, 10 Apr 2026 11:14:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698E783DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6qmjW2629321
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BHsLKJ3IuFj
 0JVhRjgu4sqdKZu7iYrlgMuhDVnFKrqU=; b=EXBh8pDNtBrYZQU94gfLkJ4PtGC
 rzQw4d3lDvr/KHhELhsFGWSnj//IAGjheTmkgYWmctliI2VKv7WlYs0DUqxgimH0
 7+AcqtdyzgScgkf79oenNi9F0CL09n/BH38ASk0f86yhFzgDvph/zOImWfOaQLHQ
 z8GvbmOBZmTiFLJexwL2RRGETHGL4HYG7H7jnthZIjC4ukOqAKLKOsGMxzpKPy7t
 eiQVTFuCcztbyxV7LxyoslFsjNnOrggbv2lp2SnugRsqOVOwjyoHNRGFRvHXYA0Z
 Ubz0/Lc4a3L9tevzzEcHyCME313iviwCucPgaIyi4EhWAWKKAV9jnvw6rPw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu3ht2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso2188179a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812438; x=1776417238; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BHsLKJ3IuFj0JVhRjgu4sqdKZu7iYrlgMuhDVnFKrqU=;
 b=CdzGeNUNNiUyt3zWIGCPlu2RwRFzMD735n+UT+tlLmfM84MFOhJR6Oq24vTjgJ2djP
 DZQt/UYTfcVgTwfU1CguC7hWboPwgN+Gv089YQsNEMHWSjivNNzDJ+6QNiJ2BHKVmda7
 Vokj0ZEFPmBzdqLOY8k2LkU6NjcvEk5uYalm41EWVCIngR/6+8FEfam7VuW/H4s9ZEPV
 YUgCcriB904r0/DpLBk42rOvGp8TKjoTIEvHyH6LmYlC15RoIzaOSkd+XmK7bp1B429y
 DsxLSoSshGQmg9SfWkqoy6DYp2a5Wacpx/b0tz3kVstIx/iTlEZvUBNtmvXtDVf+afj3
 orPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812438; x=1776417238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BHsLKJ3IuFj0JVhRjgu4sqdKZu7iYrlgMuhDVnFKrqU=;
 b=ebBq4b8o+IVx5ynKSSX1z7Pkvfl/ZVkArb4S+pfqTlrIPEY+QgHmUjcfTypKNtVBM6
 h0K5A+Mg63toxmZoNy4jdWM9hZ/lNJ1xRBPBwFlUCUUUB8nWuw87xRMl4tMn2j+r4exF
 6nKhqfChzIZdWEEx7OV3O8SzHedIMGCMAIABLsUnhFA7bRneYZYvtAOUS4LwIxfQtwXl
 sXCGxrVrssh2ssLtzBfIUmru0Bh5RJcsIv0EdrjrLbxKHPPR3SO9JBW34R+mkmCyqgDj
 ZgFf1/VtxfFnwdmyMb/zPGj2fq4l0MiGt7506Vo7edv36ugx748ngf/IdVGyQOeBafHb
 +kmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf9XWw9st7EsiNdGozW/+s9VM8DXfG2av1AwhyLlet86vLNqRyyJtta3WiuPbKw3Xfv7PuS5k=@lists.denx.de
X-Gm-Message-State: AOJu0Yyshac+EkXm16GMnvn/rbLBnYfwjqzuaoS7H5uo8FVOEEn+Wf1c
 dMgzMEBlsCkSXC//uSEPvwCQz29YTLdyMAVdemCq6dqUR82zaKrgWlU+d4DmCNI2bmmXOb5cn7y
 8ZM7fhrZHq2vY4Zl5Y8RmLkRebevvijBM4nfkQzSuYyjdeOBWb9jzavEG
X-Gm-Gg: AeBDieu2NBOww27g9IRiFTuUKBoEKX13A4Xz5f1Db75bPTbQ0lSMTBv3EalrAKi6t1y
 q3CfogBlBvtHkzLC7GoNrai09UN4bBnQ7s23rHDgfzPr5IjLWeQD8uXywTC1ObHBm03M//Y0lGH
 WJscA1zAG5Ys6baeiBHYMwZdT138SaPcMyEW23IL1/M+qgNlSUgTPCMiyxAjnek8RYzbsubxe4U
 3UQv3p/37tr6juUn+Lhbx4U70BL+Bh9KBWQ+NrYnl3BsaOFrV/TXas9zaNddugifsruCan0bYvf
 R16wkSOrdIi2XKIgEfHKFb1KHYLPqH/5/K0i/MWmBsYayzrWiYcsXyHJdrXY1MBniix3caHXYOh
 r+nJ6ytnKnfqxvkJR/kV2eQl21atCRQo8+NrXtalncAtw0xbHeoynXjpk/vgPPf1eN1HIY5holH
 +i1efh+yj9qTmuSREQgQjeFLDmkjZxS1Iegb3eXT3xnCBg1Z9EkIM=
X-Received: by 2002:a17:90a:d406:b0:35d:a22b:80cb with SMTP id
 98e67ed59e1d1-35e428152c9mr2485706a91.16.1775812437613; 
 Fri, 10 Apr 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:35d:a22b:80cb with SMTP id
 98e67ed59e1d1-35e428152c9mr2485673a91.16.1775812437097; 
 Fri, 10 Apr 2026 02:13:57 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:13:56 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 9/9] configs: add qcom_ipq5210_mmc_defconfig
Date: Fri, 10 Apr 2026 14:41:54 +0530
Message-Id: <20260410091154.1001021-10-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YJ3aRqC6bejIZubHeYHnjM3Fy64IpJy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MCBTYWx0ZWRfX1+6tKtqdgNbJ
 hQyxrFEX+TXx6NE3zyH8xhUr0dgLLEnttnCkN9Ffm0h7rFRH3KOJO2+UKRKwILWMFsuTsnWuyj8
 Sn2FCp9O7v6aButGVwuEANvezC6lCqyFEB0WF6rvjMLav6QuuaUyCv+wq79u0/kzwsAT2xmB/ld
 Ulmr+5AZyETRwukF4hYz3BcwYNxe4TAR+4zy7fhP/09uGcyPeFuMuB61CeUcstrKTeC6nlnulCB
 QbfQhvK1g2w7DWqPa6pg6F7tDSB+8HSJohHT39s+ZH4UdpssirtEFsWZNE8S57sdE2DlTYsw5eH
 SR7p5AQ21Bncy2H3flHdX8LZLApMB+fA1ZUftdB+F1tZFDGecP2MwNgmlXMiKsKaw8EBvYdVXNg
 CDQx3GWG/KmTZwYcuWxNoGrCmslxGkjEMfN4h3JrRJx26qH/vZVCoAtgx4jlyXIZVxMOy84u3yT
 GGbYdlv+Rd40Wx7JvWA==
X-Proofpoint-ORIG-GUID: YJ3aRqC6bejIZubHeYHnjM3Fy64IpJy3
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d8bf56 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GOj2LzLryEk95jnXa_cA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100080
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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
v2: Enable CONFIG_QCOM_GENI_MINICORE
---
 configs/qcom_ipq5210_mmc_defconfig | 106 +++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..dfe47080c2b
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
+CONFIG_SPL_STACK=0x08c60000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_WRAPPER_ELF=y
-- 
2.34.1

