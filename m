Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD555C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3766C849BA;
	Sun, 28 Jun 2026 15:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCzmf+wV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OEZJPkfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0011E84105; Sun, 28 Jun 2026 15:16:22 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82298056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9PDuv3625836
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RxoCi5aTmkMOxD/b5jW0lbr7daJvDhcrpFdRIeOmqsk=; b=fCzmf+wV/ucj3Db7
 UHwQrY4AULJYgOEt3kzMmgWHHi/gsJlnbrCr+YP4VFdq2Pu1TuiL/bbrB/BGDyOp
 A7IyepeSfCLou670c4XfffRWnqygTZXxTN7WqLDFuUXjUdUypXHl3YdSAGef9FOU
 fvXQuGeCVC1+/h/rodJhAa8OMCJ8fu0euemO9QQLTnGEnCQhfxIwhf3fLa2C1Rfx
 t7ugsrTrXRrFnrZS4cDlVLihiGdb/Teoql9ORBbDHoxfdrlZ20mejdaafWTOWcKM
 1rHEBr4kl+zZX62FQrrV9LXhU+2Gpi3Z0CWgY/X4oxNESZBmyRomhpxiWdd6SWAN
 HPu7pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tujwxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:16:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso1791287eec.1
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652578; x=1783257378; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RxoCi5aTmkMOxD/b5jW0lbr7daJvDhcrpFdRIeOmqsk=;
 b=OEZJPkfxC3dFjTj9v5Xwp2Qw2ap10PJxKQfe+DwlPQSzYVmXvp7SG8qRi20VgBc7H/
 9s4NwWHhuH4PBGIpOTp3OD3ykUcBGYFaw8o0s1BbtiSufGlo/7M4QY9sQxxdSkyWAsVI
 BxlVQr9wwPrQy5nANjSau+7A1g9wg/qq0PYSX/SDHJ6LTq6GaFAW/uj/GscG4U1lAUk/
 coh1cp5WTQLI79vvvasOmSTDV8Ygt8KBwwRUU49wQp8ZISR1p/sWDDWmK92rUyMaoSgp
 UvwsSXldcyVDqGRuUEMQYi/dD1DfVMUPwVSfMewy4V0o83+ekh51yaHoEi2woihLyBCV
 Afnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652578; x=1783257378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RxoCi5aTmkMOxD/b5jW0lbr7daJvDhcrpFdRIeOmqsk=;
 b=ZAny7RabSoIsd4BvdV6ymn2XTDV0yonA9cl9n39K+sWz21UDdQoFMLkR/2GQZ6sd8A
 ILX/8ALWhdXbXVhGMrGIjpBQwdlRuTWPboEVOmz3N74XYme3n9xae+cJ9xEWtbP9j+1R
 D96wPI2JRDTuijdJxXXk39Na7thFbhzYmeW47XPa19Z05nKBCv0v6hBQEpZ6QXYVONVM
 ABVaOdHexkpHjrEUL83pdJgZ3dNrOr/KrRtLrnweuX+2xauTItbDzrnflIuznhczWE1n
 pbi5M+YoaLgAxFiQD4PSmJmNMmHFjHVBwZg4d05Sa8SSOVqCWR/XF5hNBNBSfjPsS8T8
 5TyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqTs+J//jVu+8Tj2fk5Y/v5sStlCQEovqC0Idh8NdSap1qRyq1cPutLE9bJ0jjiHoU8U9YH2g=@lists.denx.de
X-Gm-Message-State: AOJu0YxKJs3QWNGiB2dc7wqsLzzc1Y00KY2Q/gW7DPsZ3Hgb5xvjpGQZ
 ntcDIAT6aVJ0ZAGGLI3kZWfeI16SL4rM4oORqKawc5gXWmHtQbLrlxWiS/ZKSjQlQSzaM0JZWEj
 +9WCUkEQsKYwjNdIYUCN302xJSm6X6o1kX3dHv3EvYwYbWL9pBVvSh3Hi
X-Gm-Gg: AfdE7cnBMjHAhX8Mcz3DFQBqBS+mUQeDA1OWHv1/ht5lN+E4d8GQKc2AbzY0cLrtrky
 GX+8Cq+A4HgA8yqaf4tIpf6B/CYXv/mAzHlpI5dBRKdP7YbBJqgd/gaP32JXwmh4AFonBGAD5hM
 pPNfQYWkENP1h7KbpvdFPaD4vKR5/jmpGM8nnk1c/ZYmHxnN3lVrnMEoZvzMGAWfQ8TtPHJb39X
 3n6Ga5Qx5pKV0x4wPTCnzZ1LLDxmNyxL9n9IsAce/5NkFpcPujqnAB+WuA5O4RO1nSyDqAt6jxv
 C1t81I1vbEcZ5skb69LzP6XVG3I//Da0+jdeGSTUoq+I+XHfUtrzoiZa6mJu7fcWDFdxyNuMotH
 XuRBg4F43UyNICTBxwCWJtlFIzRTsHGF7Hwkj+CVgc9ItIZA=
X-Received: by 2002:a05:7301:644c:b0:30c:5cdc:176 with SMTP id
 5a478bee46e88-30c84b3236bmr13103478eec.1.1782652577975; 
 Sun, 28 Jun 2026 06:16:17 -0700 (PDT)
X-Received: by 2002:a05:7301:644c:b0:30c:5cdc:176 with SMTP id
 5a478bee46e88-30c84b3236bmr13103432eec.1.1782652577482; 
 Sun, 28 Jun 2026 06:16:17 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm35875335eec.19.2026.06.28.06.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:16:17 -0700 (PDT)
Message-ID: <7674106b-a9f7-4ced-95aa-feb3034018e6@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:46:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] configs: add qcom_ipq5210_mmc_defconfig
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-11-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-11-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Z_Ufy2N1HCd9Lnu-FMBu-ALjD2rf5GTZ
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a411ea2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8COV6_o7v0DDbIfUJ78A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Z_Ufy2N1HCd9Lnu-FMBu-ALjD2rf5GTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX2yWd7Ndq4Jvo
 QN/ro5UOXgjGmFQA423HAJ5mPtVeESJ7Izy6w389wniiLgQycsCM4c//EYxy6l8UGajvSq5gXg8
 3kzlmYuyxbtqb6FMn7m4lmLq4MxJbmB+f8mc15AjjDPVTOv3D0Gd3lQ6FSwKvJQJajcpaufaNCD
 344hh8dxNi37sdvM7Bjt1f/UKyqefjrUNZmrpZge4644pDu6+5b0L/s40xXILV03tqz6dMj4T0K
 fEfG5jk27qcXERvFc+kqPLlTr1qGa0SYkMp7dC1Gf0snkBcLQ5ZgRsBCkv75buwfqO9+XDTz+n0
 4/17zwS94ulc8/Rvcs02Wmb8hHJw3grVYI3CFccOWJwO9ZAamRiW5PimKiKb1ERv0Cq9VWFgEk8
 r59sQPMa8GtJ2vfLRS8marL/x1JWz6TGbuuSSODQCWwQkt6LXzU7nAz+zrdf2OA4RbO4v325YUL
 OIr6r8LUqN0DDBzz4JA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX8yIENkan063Y
 3gmclGyQnN6GT2MftMQopeackK4EsdKym5+ON2v3UQdfzqVS+CTY796KcE/CYFfXPlkjwCg2/qw
 YOYYfDrnzIX9qUCBTOxHGP91vwWe5Xw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280116
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:25:03 +0200
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

Hi Varada,

On 6/23/2026 12:18 PM, Varadarajan Narayanan wrote:
> Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
> Presently supports eMMC.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

> ---
> v5: Add CONFIG_SYS_BOARD so that board/qualcomm/ipq5210 directory is built
>
> v3: Change CONFIG_SPL_STACK from 0x08c60000 to 0x08c24000
>
> v2: Enable CONFIG_QCOM_GENI_MINICORE
> ---
>   configs/qcom_ipq5210_mmc_defconfig | 107 +++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
>   create mode 100644 configs/qcom_ipq5210_mmc_defconfig
>
> diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
> new file mode 100644
> index 00000000000..6d608de822f
> --- /dev/null
> +++ b/configs/qcom_ipq5210_mmc_defconfig
> @@ -0,0 +1,107 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_TEXT_BASE=0x87980000
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
> +CONFIG_SYS_LOAD_ADDR=0x90000000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_BOOTSTD is not set
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_PBSIZE=1024
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PART=y
> +CONFIG_EFI_PARTITION=y
> +CONFIG_OF_LIVE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM_IPQ5210=y
> +CONFIG_MSM_GPIO=y
> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +CONFIG_MISC=y
> +CONFIG_QCOM_GENI=y
> +CONFIG_QCOM_GENI_MINICORE=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
> +# CONFIG_MMC_SDHCI_ADMA is not set
> +# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
> +# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_MTD=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
> +CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QMP_UFS=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_IPQ5210=y
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SOC_QCOM=y
> +CONFIG_SPL=y
> +CONFIG_SPL_FRAMEWORK=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_OF_LIBFDT=y
> +CONFIG_SPL_DM=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_DM_GPIO=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_SMEM=y
> +CONFIG_DM_STATS=y
> +CONFIG_SPL_SYS_MALLOC_F=y
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
> +# CONFIG_SPL_SEPARATE_BSS is not set
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +CONFIG_SPL_TEXT_BASE=0x08c24000
> +CONFIG_SPL_MAX_SIZE=0x3D000
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_SPL_STACKPROTECTOR=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_STACK=0x08c24000
> +# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
> +CONFIG_SPL_WRAPPER_ELF=y
> +CONFIG_SYS_BOARD="ipq5210"
