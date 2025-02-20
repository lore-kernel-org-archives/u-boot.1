Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F54C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 03:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FE080A46;
	Thu, 20 Feb 2025 04:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="RTn67iRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5F780EBD; Thu, 20 Feb 2025 04:39:07 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F9E801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 04:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHDEaW001844;
 Thu, 20 Feb 2025 03:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=K3ahfbf3u2ZA098bqVJA+rkH
 ndyMP31wq5gpc+fwpng=; b=RTn67iRUie6O4JJMaaep3m2+btdP6iiXG1Ee9Ddz
 fNsdmyQwvUYTC6T8TA/hmIRob0sCUvF6sNnnV7S8z/8xsGaHt+KWvb0e0cVLV1Qu
 kBMtQhb7s5VxRCMCxhJMH9myChtbYHsA4mXUmpgamcbQpjt6TANqKuEu4jkemTjX
 3R8XTbxj6FK9X2PxspjRnjvlo0/izZyvuOTbZRWEDo8X908qpivDKJ+dFHIe6o8a
 ieDBV5DkPSAf+uAfbBB5D2vNrIlSSWHAuyo2D/iYxw+eziD5bBGKlDgAy5P3H2tn
 iw09mwQnoP92lNyyyofeGNR9ZWoPPcZXtwZzi+ecAe+3Sw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2cr19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 03:38:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K3clK9031352
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 03:38:47 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 19:38:42 -0800
Date: Thu, 20 Feb 2025 09:08:38 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Sumit Garg <sumit.garg@linaro.org>
CC: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <lukma@denx.de>, <seanga2@gmail.com>,
 <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <marek.vasut+renesas@mailbox.org>,
 <pbrobinson@gmail.com>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v3 8/8] configs: add qcom_ipq9574_mmc_defconfig
Message-ID: <Z7ajvmK9qO7kRN8i@hu-varada-blr.qualcomm.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-9-quic_varada@quicinc.com>
 <CAFA6WYPitP9+8o9XRieiaZS7gXZo+DhaerFvpNJuzBCN0LKcpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFA6WYPitP9+8o9XRieiaZS7gXZo+DhaerFvpNJuzBCN0LKcpw@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: sJz0SkbozL0SffvZ3qrdWH-68T4zkDQB
X-Proofpoint-GUID: sJz0SkbozL0SffvZ3qrdWH-68T4zkDQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_11,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200022
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

On Wed, Feb 19, 2025 at 05:48:48PM +0530, Sumit Garg wrote:
> Hi Varadarajan,
>
> On Tue, 18 Feb 2025 at 14:26, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Introduce a defconfig for the Qualcomm IPQ9574 SoC based RDPs.
> > Presently supports eMMC.
> >
> > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v3: Removed unnecessary comment
> > ---
> >  configs/qcom_ipq9574_mmc_defconfig | 110 +++++++++++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 configs/qcom_ipq9574_mmc_defconfig
> >
> > diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
> > new file mode 100644
> > index 0000000000..13b47cb2b9
> > --- /dev/null
> > +++ b/configs/qcom_ipq9574_mmc_defconfig
> > @@ -0,0 +1,110 @@
> > +#include "qcom_defconfig"
> > +
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_DEBUG_UART_ANNOUNCE=y
> > +CONFIG_DEBUG_UART_BASE=0x78b1000
> > +CONFIG_DEBUG_UART_MSM=y
> > +CONFIG_DEBUG_UART_CLOCK=1843200
> > +CONFIG_TEXT_BASE=0x4A240000
> > +CONFIG_REMAKE_ELF=y
> > +CONFIG_SYS_LOAD_ADDR=0x50000000
> > +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_BOOTSTD_FULL=y
> > +CONFIG_BOOTDELAY=2
> > +CONFIG_OF_BOARD_SETUP=y
> > +CONFIG_SYS_CBSIZE=1024
> > +CONFIG_SYS_PBSIZE=1024
> > +CONFIG_OF_LIVE=y
> > +CONFIG_MSM_GPIO=y
> > +CONFIG_CLK_QCOM_IPQ9574=y
> > +CONFIG_PINCTRL_QCOM_IPQ9574=y
> > +CONFIG_MSM_SERIAL=y
> > +CONFIG_DM_EVENT=y
> > +CONFIG_ENV_IS_IN_MMC=y
> > +CONFIG_ENV_SIZE=0x40000
> > +CONFIG_ENV_OFFSET=0
> > +CONFIG_PARTITIONS=y
> > +CONFIG_PARTITION_UUIDS=y
> > +CONFIG_MTD=y
> > +CONFIG_MTD_PARTS=y
> > +
> > +#
> > +# Turning off many options so that u-boot size is less
> > +# than 756KB.
>
> Is this due to on-chip RAM memory constraints or flash memory layout
> that the U-Boot binary shouldn't exceed 756KB? I suppose it's rather
> better to be caught at compile time, we have something like
> SPL_MAX_SIZE but I can't find any for the main U-Boot now. So it
> should be fine to at least document it properly for now.

Flash memory layout. Based on the below feedback, will not
include qcom_defconfig and have the relevant configs alone.

> > +#
> > +# CONFIG_BOOTP_PXE is not set
> > +# CONFIG_BUTTON_KEYBOARD is not set
> > +# CONFIG_CLK_QCOM_APQ8016 is not set
> > +# CONFIG_CLK_QCOM_APQ8096 is not set
> > +# CONFIG_CLK_QCOM_QCM2290 is not set
> > +# CONFIG_CLK_QCOM_QCS404 is not set
> > +# CONFIG_CLK_QCOM_SC7280 is not set
> > +# CONFIG_CLK_QCOM_SDM845 is not set
> > +# CONFIG_CLK_QCOM_SM6115 is not set
> > +# CONFIG_CLK_QCOM_SM8150 is not set
> > +# CONFIG_CLK_QCOM_SM8250 is not set
> > +# CONFIG_CLK_QCOM_SM8550 is not set
> > +# CONFIG_CLK_QCOM_SM8650 is not set
> > +# CONFIG_CMD_BOOTP is not set
> > +# CONFIG_CMD_GPIO is not set
> > +# CONFIG_CMD_I2C is not set
> > +# CONFIG_CMD_MII is not set
> > +# CONFIG_CMD_NET is not set
> > +# CONFIG_CMD_PING is not set
> > +# CONFIG_CMD_PINMUX is not set
> > +# CONFIG_CMD_PXE is not set
> > +# CONFIG_CMD_RNG is not set
> > +# CONFIG_CMD_TFTPBOOT is not set
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +# CONFIG_DM_ETH is not set
> > +# CONFIG_DM_I2C is not set
> > +# CONFIG_DM_KEYBOARD is not set
> > +# CONFIG_DM_MDIO is not set
> > +# CONFIG_DM_PMIC is not set
> > +# CONFIG_DM_REGULATOR_COMMON is not set
> > +# CONFIG_DM_REGULATOR_FIXED is not set
> > +# CONFIG_DM_REGULATOR is not set
> > +# CONFIG_DM_REGULATOR_QCOM_RPMH is not set
> > +# CONFIG_DM_USB is not set
> > +# CONFIG_ETH is not set
> > +# CONFIG_FS_EXT4 is not set
> > +# CONFIG_FS_FAT is not set
> > +# CONFIG_I2C is not set
> > +# CONFIG_INPUT is not set
> > +# CONFIG_IOMMU is not set
> > +# CONFIG_LEGACY_CRYPTO_BASIC is not set
> > +# CONFIG_LEGACY_CRYPTO_CERT is not set
> > +# CONFIG_LEGACY_CRYPTO is not set
> > +# CONFIG_LIB_RAND is not set
> > +# CONFIG_MD5_LEGACY is not set
> > +# CONFIG_MISC is not set
> > +# CONFIG_MMC_HS200_SUPPORT is not set
> > +# CONFIG_NETDEVICES is not set
> > +# CONFIG_NVMEM is not set
> > +# CONFIG_PHY_GIGE is not set
> > +# CONFIG_PHYLIB is not set
> > +# CONFIG_PINCTRL_QCOM_APQ8016 is not set
> > +# CONFIG_PINCTRL_QCOM_APQ8096 is not set
> > +# CONFIG_PINCTRL_QCOM_IPQ4019 is not set
> > +# CONFIG_PINCTRL_QCOM_QCM2290 is not set
> > +# CONFIG_PINCTRL_QCOM_QCS404 is not set
> > +# CONFIG_PINCTRL_QCOM_SDM845 is not set
> > +# CONFIG_PINCTRL_QCOM_SM6115 is not set
> > +# CONFIG_PINCTRL_QCOM_SM8150 is not set
> > +# CONFIG_PINCTRL_QCOM_SM8250 is not set
> > +# CONFIG_PINCTRL_QCOM_SM8550 is not set
> > +# CONFIG_PINCTRL_QCOM_SM8650 is not set
> > +# CONFIG_PMIC_CHILDREN is not set
> > +# CONFIG_PMIC_QCOM is not set
> > +# CONFIG_POWER_DOMAIN is not set
> > +# CONFIG_PXE_UTILS is not set
> > +# CONFIG_QCOM_HYP_SMMU is not set
> > +# CONFIG_REGEX is not set
> > +# CONFIG_RGMII is not set
> > +# CONFIG_SHA1_LEGACY is not set
> > +# CONFIG_SHA256_LEGACY is not set
> > +# CONFIG_UFS is not set
> > +# CONFIG_USB is not set
> > +# CONFIG_VIDEO is not set
>
> We should rather create a separate defconfig for this platform. It's
> just redundant to include generic defconfig and then make it platform
> specific.

Sure. Will post a new version.

Thanks
Varada
