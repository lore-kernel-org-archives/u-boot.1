Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB7CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C96884869;
	Tue,  9 Jun 2026 11:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvaWPVE/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H++7idFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B318486D; Tue,  9 Jun 2026 11:20:10 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5897384869
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rqWK2001516
 for <u-boot@lists.denx.de>; Tue, 9 Jun 2026 09:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/uqFYyoetsQ
 E28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=; b=XvaWPVE/H4i+8D904sUgf4x59Ev
 Ck8dehJ1vDTb9I4q0cCh1m6Pu2q8g1tVWXcjPhNSpkLasSvN2JYM23jWYuYIGSJ4
 uL1lvPprUWXfme5UCDx+0LRi/hD1LfrbnDga538QXthXaIc7VIhHy2MWUQyERi/e
 8HGkEQMFg/xiplNq4mFrbUlShkeIM1i0qbGmth7y8Lx3yh1oHXyAZR/CUVz0pEae
 pfzN7/CTx+yJm3Vkd/P4TsfgAOWzmgCzhHIX3LowNnUt609H5goLO3QSVDRpUK99
 T7AZHt4YIhPsILwbsZJDZpIRrN++WDkgq7z9BSH+BqWZBpyGrK+iEk0jSlg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25rjfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:20:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bc02d28b6so4043560a91.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780996806; x=1781601606; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uqFYyoetsQE28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=;
 b=H++7idFw3mBuGTf4JrcJJtel/FSZlts0iyeyWlSQXvyhv63XexmvrNGN2oiMsZ192/
 99DuJeWyaJxhc0znqf0vrODS+RqYY+qeEzh+hcFqlkM/EwmLcslPAh4uXDdhO65zqfqI
 KlIOLkMSbfCQoskxgcW/aK1ZK8jWmjjpMeQxBfoFqnCHn1qbEkh2pmcv3EBC1vBJL8y7
 pRubljnWfgsMqqDQFata+ouAao5VXBMfyUWPnqpqfJKoHyRXdRXoB9ppjNOHCSdWa34H
 M/OZ9TEtc/YocphHAGW4+1Z4EUBebhTGabyALa3ZI2sE68hqodtbDPIYKZVms8CRUVrm
 0k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996806; x=1781601606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/uqFYyoetsQE28DzPf0fOwXNswe+/xuR3iNkk1vGoCA=;
 b=BFTNY5nufepJo8pkinbc2OYsTdknf1+Ns/ioylwMym/vvm96Fyf3SmGhgm+ezaVtyz
 uPGf6RiaHkNNK0sd8stDB18UeO1w2rd8RxRjucbn8lnr4n0dXtajUrWaLqGT5KwiEc4o
 dSoVPdmb9YxUgrQ0UwbX2sNtVxbO+i//S+7TiaOHqfR8Rw8WnHWNyiNj546ZK57zSdTm
 PH6XxOfGIieSIcdCPkiqeH+jtdTUV5GDEfI1scollv4LAHfMA+XRMXQEHIiUhuGRjGEr
 3dQ4GBXKjzpe/ESxAwGafjPNPgDXWseRUZPcR/4waPTLUnYSe3FALAfr7/BcZpW7tYUt
 x+og==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JCxmaRcitzQkk7DyTUKDQx3N2fvwQNa1jImr35KQu9vgjr2yJwRPxOLIjHjum9Hksdq6Qwk4=@lists.denx.de
X-Gm-Message-State: AOJu0YwDTJQwvuQ0M5BIcl/qL9u3T9OT9Z9tArJbmmtvuogeJ+qCLyzX
 mPpORy2ISF9ONLYq0+SRgK6DFumQdkAoV3QXpPo8mbDmFJh4pz//2BsLZK2YuVemzPe2fFKjcfR
 i6SCgFl8DuOFFmwBCyCTc4KBKOMYED7claaucOBbRnManHxj3Dh4ugNDk
X-Gm-Gg: Acq92OFXHGw0AhBnQdsMn4flQGmPwB6q3qi0B/ZrwHVq974q/4m2i1/zRLTRU/Au4bN
 VXVx9LZOjsI/0ZxQJkx1ND1ZnDhkH8x45Vi+tSeJg17XspWVBPf9eo+la/aRJyOw3Avpk6xgYJV
 6/vbvqY0BVxWFZew/R7f0KJzdc+DeigmvJrXBtA81K1K0SQyEWgFpye6e1aitKMYabDXHY8Ola2
 BUbfJ0+lxfHtEetcaw/+9vn4yclJTjC6oqtZ2GJSdSyGVpWcPY10I3+SnVu5EBsa0CpVbJpVFMo
 eHlX3ZXNL3vUPhRJx9iJxVaIrUst0EgcLbYyzL9nUcMoyspGP7HJIMoSoRJxhoS8787NCmtaiHQ
 nTYMDXz70MNVVUURAqPb1ZdPsRi3V2hEjytg3qkZ0FbmXIq80qxFvRA7D9doyDZ2kUcqAYmBbvk
 vrzpzP2nOAFaAEkE8i9m2xB82e3hc/a0AYA9rEldjeUV/1COxFhbaM
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr20937904a91.7.1780996805707; 
 Tue, 09 Jun 2026 02:20:05 -0700 (PDT)
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr20937853a91.7.1780996805288; 
 Tue, 09 Jun 2026 02:20:05 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf90a32sm22851397a91.1.2026.06.09.02.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:20:04 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: funderscore@postmarketos.org
Cc: adrian@mainlining.org, aswin.murugan@oss.qualcomm.com,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 casey.connolly@linaro.org, danila@jiaxyga.com,
 david.wronek@mainlining.org, jh80.chung@samsung.com,
 luca.weiss@fairphone.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quic_varada@quicinc.com,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Tue,  9 Jun 2026 14:49:28 +0530
Message-Id: <20260609091928.1564605-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
References: <tg62gv.1na72fsokrnbj@postmarketos.org>
 <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7J7WejM8s2iwv_WrSvOhQ0jOYgZEVvlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NiBTYWx0ZWRfX5Sjwx59Cd+4n
 2Na4ECdBZckiy52b3/nupIVvdHDJyAoCOupw+TH7AYURIUN2qO/9DexP+PnTvytmk6LbsGLQD4P
 ul32f+WGTjDOQUIJGgvtDxttcESCn43BgZyboGQQlkizt38gNist2FjZjQJKDRFb77MAOtpVY/G
 X+c4zYkKLwK3CP1OcxjgU38WZgl12gKzlpv2a8k75jb1Ygh2ppLKUi8lcBaSbipCdrivC3YqrhT
 cIUqnDKJFBRpoip5ddIcbprWPv5MIZxTSrClM9c8lTV2mmdxZ0lZ/1YUTsIxmWMSHSMKyZqxQ8P
 ywC5vYA6B1RTmOH2n0QdOqINdgw/xwrH9bEHLkcLy+TPIRvXaKre9Ed2EGXaBc+vYMjhq7Jx4/Y
 2nuMj+kpcqyFjv4ya78mYqrEXd3Y5IGJ3cIbQYkUJd/2qsIaimDin77g0ajvXfdUN9EpKtXeeUF
 kr8RV33CThUa+Aa42JQ==
X-Proofpoint-GUID: 7J7WejM8s2iwv_WrSvOhQ0jOYgZEVvlQ
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27dac6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=AgL0tj34FG0E83FnmwsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090086
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

