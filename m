Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EE4CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 05:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4A684701;
	Wed, 10 Jun 2026 07:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3QFLMpd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TYvfHSGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6CF84704; Wed, 10 Jun 2026 07:37:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC7984701
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A4Whqs571720
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gnR0M96HDUP
 fLQnqVFlyaivCz0BoJNPlaVm+j37R4DA=; b=I3QFLMpdRxSBdZxokD8zKbwTzGC
 XZJTdDWX0AX0P+hYB+OviOKzEzregCFL9FvxjwlZQWq791GFLbbWNkuxllcr3uP3
 wpvj0TlmjaG0/BxwWHHNOqE9cJbGti+fE5i2qe6etwTaN89gANW3yIIxGchnEnIA
 rgD5dpqhkXvyMwDAT3BciCCIIAIp2ryHlXEP3QG71upFHpCOqhpV8kku7OvB8Vdc
 PQbml+ILsZu3d8bwNf4FR4PEu+hecaMEV+Av4BGgyApLH/c5o1W3c++pBPicotf+
 laTC9edJOUfIEcdk80u8UwkrX2Iw1TVqIdadjDb7mUj7OwxdyXCMgUb7JCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a867h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d98b5a68fso11078702a91.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781069850; x=1781674650; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gnR0M96HDUPfLQnqVFlyaivCz0BoJNPlaVm+j37R4DA=;
 b=TYvfHSGTWJxXu3As6iaDulJEYJsPlwFOeOtbHmP3mF03QaHmvZxoS7sNXQ32hN+AaA
 7M70HmJXHp0UepWywcmPFKKqYhdqQ6jaBICpz4dFQdapzHOt6sGtJfoep80W28bQ3MPd
 3j+cPIVa975g4g7HLIOIpuj2aPvYjL9nw3EhaNX12yjgGz8BSu4TFSCde5ZybJpNDxl8
 KLcUf5iedNLa2mY6o0g/v/mH7KzO2QBp3rxz0m8ZS2SBaei0eVN8cjzo0UBaF5kT7YWE
 q/md+8X3KiHmmXICDb+UA6SV9t6Xctg8IREriuaYfcg1w9WEQJXfxb/G70+2rJDVDhGW
 GS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781069850; x=1781674650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gnR0M96HDUPfLQnqVFlyaivCz0BoJNPlaVm+j37R4DA=;
 b=OS7G1Tn4ThdbGTWF+wIYfkhaGN6w05oU+xdP5MuVKeUfsD83l6jPgOT7a6poAljt4J
 bY5Mr9p0dZFFZhXjQpLACqpJ9JkhFr86XIUIdONjfSQcwqutq0K1iGhnIPrPMqeEVzeZ
 GP4V6dFUnVlXGmMKqAMCIQD3dK3UbAD5lpBZ/W5HEOf506S7fv1NrPIV6ZG9zqwFtNn2
 +mWViB9C39FfFeU9wcp3UL/SpTPEJA52un/NUvxqhgAJz1SShvcB2eXLj2orNsbaqqBH
 leqTAkoLN1JpIGRAcoanTwRa60DPEuOyAG4BjluGgMpuWkABGwv3Q/NnBUHyANrDZeub
 YOXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vOUy5FJ+7yaOO+bLJbwdU3IzvF6M4A9FH3i32ca8s3x5BpZYTylybZe169gB1wi7Yr71fs04=@lists.denx.de
X-Gm-Message-State: AOJu0YySg/7GpY1XYCcDN7xTbo/ZX+OdcIJwDQkFqMCcII5rU5Dp7hNx
 hWJSxxeFOXvAHIo84Pl/PydQe5hz/oAmGiBe48ZgVhlnO2xUuzwxi/8MuKc0Dj6R0lqTsZhyqjd
 bvREdiXMv/vcedViCdzJhMdJtZMpSfSya4agRQ3Mw7oIvw0r38dOMZuEY
X-Gm-Gg: Acq92OFKg880PQlJ3NZI40n8mDdBneJnna3WrWOZoXSVjo/hv01GgTZZLUDhUuELseU
 qj5hul7etV4SvnbYrr1K6BqxpHx3b/RIhRWlR8n3/+n4Km/PHEwOfYa1mGMLzFiQqmLQx5wMI0u
 m4Rcr/xWGI9v/i7GfUZvLq8gR5134JrE7ixIUtHzMgFC7pLw8PxKDSzaUQb98XcDmx5j3DnbDhv
 jYGpmDjKSNz2YYGQCmb3CKi9tYDIeknUvwIS90NanQzxNFQAyh18y9Fqodm+wfdfqrIzF3xESz0
 Gsqi/0svE+31TUQNNFR0Q/Jgsl4ypWCKknprwpjUivGRuOKZ0s1eLWmiPth3Tb6qICPO+73Ntr/
 tlcWdLJzIn7dfqSVJWRUuVeoYKNdTm6Mlp/VmK4wgXBtWWhXzbqiokJsRi/HGUel3GP/cQwE7BV
 l3yVmrAaa6Vi5b96aM5ZEkIQO5HnHjz1oigt8B+ha8+lfCrmOXIt3X
X-Received: by 2002:a17:90b:1350:b0:366:4782:1379 with SMTP id
 98e67ed59e1d1-370f0f459d1mr24695025a91.24.1781069849931; 
 Tue, 09 Jun 2026 22:37:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1350:b0:366:4782:1379 with SMTP id
 98e67ed59e1d1-370f0f459d1mr24694980a91.24.1781069849426; 
 Tue, 09 Jun 2026 22:37:29 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376467bab00sm831918a91.2.2026.06.09.22.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 22:37:29 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 quic_varada@quicinc.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Wed, 10 Jun 2026 11:06:55 +0530
Message-Id: <20260610053655.2825589-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a28f81b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=AgL0tj34FG0E83FnmwsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dWUPcXZlapE_N0ysLTlfgBHIWPrKRv_v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfXx781osL/pdJ1
 7zMGdFxxOF0SzZlYm4h4zW8KL3JTyQOHyAmDZcDIa/cKIwHzCdmpvz5cS8CS7QBvjoFsl49Ud3x
 tVDfA/d0X7Nr+Fsam7h2iy+47onxHVMP1uJilvF8U24nRK/WvyoLJJYb5eRiq4SHXgv35nQ/Kzw
 O9Kqv+9lSJeeUbF7BTVY7RCe88FqGA1Wv0Fzaa1TH226JXuep8vpD/n4RCwj9DdQQsimquiX+DX
 EXaaWdw2GyOhT8VysXzhy8/dEjLApIkTbzBvFt8v8NAy/njXEJo00ZoDJZ1Q7XqveoySYMZkZiQ
 ZmMMKtV8410AL9WtXkqRF26rh1XtJp0ouj9hv6WPEK6qtdy651zVw4ScCpZfPDAYOm91+u5MTwD
 xHR/0howF0FWZ6+j59eWslZv83FinBMM+tdl+3+5/gtq1tzjmyfuXCKVgfpgXMo54rTj7F1qnhe
 NHoFzdfzFUTF94LtTFA==
X-Proofpoint-GUID: dWUPcXZlapE_N0ysLTlfgBHIWPrKRv_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100050
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
Changes in v2:
- No changes

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

