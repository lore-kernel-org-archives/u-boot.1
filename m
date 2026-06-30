Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C714CC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA4F84B52;
	Tue, 30 Jun 2026 14:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ln6vI08b";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YsCEcBhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D3B849FB; Tue, 30 Jun 2026 10:10:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CA984857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CLTf1056057
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mlt3ejXZzO46SeM/cT+lkcHG49IjU5ZoSQJ2qEal1fQ=; b=ln6vI08brD87I1KR
 hkW6jBsbigoMfNxUNq3XNDFSmI4AZZvuPLVZF5Y8wkjsfZhKvSMYf1vZ7w/F4scy
 S9VY/b285vIN+8G7szQj00hMEhbJpfygKX9ZqAby7qZVq6FOGP25bvt9Jfx1ShGv
 O0QTJ2J5/57ghQubdZXGkaAyxMWJ890TfB+/pckKOqHoAYgESV9NHzdhyZlUx4QO
 GMILtP+3gRKErBRvk9GaWcj2bTD4tF1k3g5V93iPh+dvkpmMd5WH5o7RFRLqrgkf
 SDyNOJSOZZwifY5m7fMjJobmLrGxd5gyBYrvs8OT6CMdC9dM4VMcrRmvxy9eIUDI
 QaQjjA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f46861159-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:10:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so10745857eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782807052; x=1783411852; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mlt3ejXZzO46SeM/cT+lkcHG49IjU5ZoSQJ2qEal1fQ=;
 b=YsCEcBhH9cdJPz89fsFcq3NqPLcrBBvgbV1A3agK9Fjg5skh0N9RwMR2PfTrs/mKnl
 10WjpgUpw9TPvKKOFRj0U5iIOpH/55bg95OaelHGtkYYk6iHKSydxNWHVi7aGji7iMXL
 r82jZU5Q+h9hsKBxHqvZHkjlPP3cbKZSFZ7JWzVQ/iItSmU/PWJe3i/g8dDxAYXw8ZBu
 nvA4bDvuWlsO9IGheue5x5hbkQ6kjhX+oPWX1c18bfb/+7XzgW/og2igSje7f5/bx6ev
 lf/pZx0oDhP089jXtADREi5dTev08fBUvRlzo6jSoIabbaMabUkff7pcEelv0KLrgtNk
 uxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807052; x=1783411852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mlt3ejXZzO46SeM/cT+lkcHG49IjU5ZoSQJ2qEal1fQ=;
 b=ZX+Y+OBUxEX95IZF53K4y22+VfaI+We9Q7M9qwaM47vJL999ubZx4MJNnSq4m+UYnM
 YLM7jeUc1c4Nmsc4t4RVrPT/mlwPQsrOMFd0EohxrgIUu8NQmNtiKCcy6xYqjvd++2y5
 OCKa9R7sMDg/s1JpAAqlnxvAlCYqQbS9xKSxLnZPzJFctYDVUSQFmBclhc+M+Yht4N+q
 z2+yHSOOMeS4i/ON4WzX82dnUj47Sec2rdFrald1o3/I88JH7x2F+sEhA7K7cu08uUc9
 /QctZaHHtSMqojL0Q6wV8jXTT7Qa1Yh12i86E/kYaabjbJaiSTkXqgHgP3qs4RWIAWsg
 E1vA==
X-Gm-Message-State: AOJu0Yxmjpw019DwPtPTW3Mv4eC6IsxYitJ06LBXBKeSfrGGOLTzUYwE
 3bOtOkxdHmjYt8r4QvSzSBIXKf54Dg6s20ofA+GbViLLcs6icwHQfZC6fhAraNivAwfjGwLSAsw
 gf8Oa+4//Of0RNc53DM/QozXdT8Bj5MEltlrjwtFKN0lwup6K24VBqXvF
X-Gm-Gg: AfdE7cnFrN5hAbbPHQxrhv+hxVEA7BuXTEXOmodGRn0RM2vRWKK7bld/e9QoP7qh6zI
 d74Bt291085FEypJ18L0nOzyldlZTujiRZOIuXr9eCWksSmOoZLiMIkRODaKzjcmUrMGFVsKxNN
 nCOUwucK2uaofLlEn6jdX24u7tjJ+X0NeXeaYdXxT/dcwGLse4nYibWM9TiT6zbwieZGt5UHYuc
 abgC29QEn0rs6NxPvNKnzIjxmtWUiXSGBGoSMEFtQ4EqB9y1lvCAvrIZpjQAaVUeIKLhErrCAOy
 CSaFxCbtoUU5TyMm6A5nl1Yej3UJcWf6pGvsh9YH4gHT/dH6KAtHPrA57EmLLV3hV7JmAyhz+WY
 nHPwqN0Au8b6fBjoIIftKHZmOf0azE1WICVxefoZX7wzC2jcvfCMCghMFnR005lQu3/jpLhme9i
 TP6vlSpqnoEiGjOr2kvwRzLR3VymXfG5yY4ZctlFKX
X-Received: by 2002:a05:7300:2d2c:b0:30e:952b:ddea with SMTP id
 5a478bee46e88-30ee12c2bebmr2087474eec.4.1782807051994; 
 Tue, 30 Jun 2026 01:10:51 -0700 (PDT)
X-Received: by 2002:a05:7300:2d2c:b0:30e:952b:ddea with SMTP id
 5a478bee46e88-30ee12c2bebmr2087451eec.4.1782807051502; 
 Tue, 30 Jun 2026 01:10:51 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:10:51 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:32 +0530
Subject: [PATCH v7 10/11] configs: add qcom_ipq5210_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-10-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: ZGpf3ENx83SRfsP8BGrXw6tKEzrznwv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX9rPrwOMOOkjX
 NEY/iD1T3efolvrJisAAWsHequUWh5FQoba1uX+Cm7NIgbbf5Bku1wQIOfqqEZ+TAv+TfEbjSwO
 srfDi9g5DNrmUUa13Q4z7vi8GjwXySKb/GyXkwhMSXtLP4J43WG0+HNeATQ3gn0VNOBqntvjwuC
 2YstnSOycQsrKhojLiBUo6zGOhhNS7dwxR5Hja/iVeTrA16q9P9htXwmNj2JFKT6fr71tbisLKK
 rW1PlG0U0iGTdddpoDzXMATyOWyQ3No8H/wCy3R7BQ+M8oqCpk4G9R+X+2csIaNp+ffU0H9dWlX
 o3KzrYMqa6e3CqSrfcuZi2dLojgcXICsvl2UjW56LqgzIR9sHauNSA//hycrHnCqujHaCMvyJJj
 Y3Qni4FImxzFz1tU+PGU3rJ0aVKuboSkLmyI7rlJKqyyCftalEgq4XrHExqTPibH0meGnjQzDf5
 GneumSkk0kpvfJ/Yd4Q==
X-Proofpoint-GUID: ZGpf3ENx83SRfsP8BGrXw6tKEzrznwv2
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a437a0c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GOj2LzLryEk95jnXa_cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX3dBJwGYefNP2
 /8zFCfMlLUNk3DLkvuTV8p8zKsJ3m7jzlQZVQxg+F6lIoMM6d9X0JsEJAxYAKmbafnQyPvutuT5
 bt9yOfHl7b1POqPFX/4c+eaiaHULVLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq5210_mmc_defconfig | 107 +++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

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

