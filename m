Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92438C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 06:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470A940ACD;
	Wed, 29 Jul 2026 06:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1IurLX8ey3p; Wed, 29 Jul 2026 06:01:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A164F40A81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304901;
	bh=PRM/GmldSlQvFYK73UGplESamOkG3Co+VcrGWKBSJ4E=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=HuV8U4s8dmkdDOkJi5azz6wK8N7ClLv2iVfTII+U6l1E/Hw2Ch1XujqTm8/wqF536
	 +8wOtRFTyQVr6Kr1NzBPRItWWXszPS0fMXTEKVRKKubGqhwmEpZ6aqCBXhf3uAnp8o
	 WcpA/KZM0SfQBc+M+s8O8hYWYkxf8Pvfj9/blV2CcbxF5F98WEP1KEbzCaYiaoZsZP
	 2vhr5kiyyYEvyFOZH3Rb5P1LU308Gp3syRQBygcFGdl/GjDARepDhaIp3g7+wC9BJP
	 LxMJYUNSJOZQxEMBKgZcoO3w+TP8bG/uB03S5PLibvDCNIQMMWjQ9xaEfpicmZvKQe
	 V9/RMRTkZDeWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A164F40A81;
	Wed, 29 Jul 2026 06:01:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A775826C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D85B60A88
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WXdaDxWtIkJ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 06:01:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4088460A63
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4088460A63
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4088460A63
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A298494B; Wed, 29 Jul 2026 08:01:37 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E038404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:01:35 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T5bOaT882849
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:34 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbhj82g0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso17308685ad.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 23:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304893; x=1785909693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PRM/GmldSlQvFYK73UGplESamOkG3Co+VcrGWKBSJ4E=;
 b=Z8cUiFxc6C+c5joiWDJ0xNoLVirScnJP0Y5+xzxsbK5f/0TXyR8pZMejFKCovMiFtu
 cIDUAMTUqiZcX/S8mAoGL7oNqdvlotyBcGlZaUF2E1f7BnAmS23t6fy+gQ0NU/9iXvlJ
 3co/mH6DyggLnj1T1akJU26EhPiU+rYcu0jayycCk/+lfKe3HeY/gURffmYBbYAZNitE
 kxtYXPxov1geqewhFkLizWakZ6+t+hCMlKR1mZIPNHtMujv9ZjaaNF18e82OWu12dYL/
 X+lKOgWBJE3+wx7r6cZfObdWI6QkRQXeUBeBaWYwjZsCG/fQBaheMf+jsX9LVEiFQHu6
 +4gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLjAp+YRenO/TMMqlPHEt0APsgdPyD1A0jGpGkI/L6YkkGw2Vuow0LxCcCRcaofK6fCIQjz28=@lists.denx.de
X-Gm-Message-State: AOJu0YzKNi7E7FER/8mg52EIFEvU9/9mWWsYFo72M1Mp2Vfbr5O0mAGX
 M1PnqFhTb84CyY5+oFOMmE9fFjCSnJpnIkIxu0iegy7t9AoAsfmocR1/ot4Mw5mJmBgQ88uSeVn
 5bnpCvSSlF3KW7hLzAxWu1SzQhzWiEC6bp7hINLOeYKKRaFejrHlFq07s
X-Gm-Gg: AR+sD10lk35EawtlnN0j3e0B/tZy0dcxiRxHrrMk8JBdB+1a1tn9NVETV5WXfm7aiQr
 AbO4p9WfncO+/LJMb1Ygi5BJum526SiJl1ndXMG2daKb9/AgxoNKhxMrJFJ7MsSu/Uj5wls8ht/
 n7leh41WUm221oKsJbTKPQdDPFCeImTbIaRK/PZhEv09jo4ygV/OxhDxeolIiqLCjcONVcQpeLC
 vSQgsbl2gYZIXbhr3/NELfR5jE/9KS5imBGPKqlZ0GYn4FFb40VaHKCoekz3Bj2gLqB2JGHbJ5h
 r3OwGIXn9gNGqzKI10x2zAR+sXMZS2LThC4doQpN9SagGsHZ/nfm8VgFDyMlEhHw/FAPMYb2Anp
 SyOWQXwi3BVbawCh3RfsO8kXw1JR2xMPahv9jPmhqpOCM4GOsFANkXdBj3kW8hpSiXltRPaQVW/
 iFwfZXvc9QHnsPVrO7GnCh
X-Received: by 2002:a05:6a21:112:b0:3c3:7bb9:c93 with SMTP id
 adf61e73a8af0-3c8ba61523bmr6695098637.53.1785304892684; 
 Tue, 28 Jul 2026 23:01:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:112:b0:3c3:7bb9:c93 with SMTP id
 adf61e73a8af0-3c8ba61523bmr6695057637.53.1785304892305; 
 Tue, 28 Jul 2026 23:01:32 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm6868367eec.30.2026.07.28.23.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:01:31 -0700 (PDT)
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Wed, 29 Jul 2026 11:30:56 +0530
Message-Id: <20260729060056.2183090-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
References: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX4Z+MkM8iZETY
 vIodmZ8D2Ipmej6j50RPR6K8w5ZeT6RmVfEoy0APANuXmqEPAWQz4zp1P2cC2ZnEpDntQ+kM/6U
 Ys7AP2jEduBX8WGwspUxDoFOnKlwP7ocR/LebgXGYUjYHU7+51I/9YIvsxm0bOOaq5KaAJ+rq5f
 XMLe8MexOk7i40g5+IFIB1ysDRm/buuhfbFY4B3153AyvnPpp66DcvZaNnJmqu+trsAvZ/QI+Xu
 YJ6cAZ3TQHBexNpLVcj7DgtV9qKrqH5YuFT+oqKEnhHn5MHKSwqMOlL0qzQwLikRghzt2wQzo1/
 ChC3/NbxyrTyJ/2WcKWjfdU3ZrOKZH9R1dy0PPZHQoXrbxEdA+PZJgsznokVR4W1zIRWG9v5WCV
 mkaEUsxtFip9cnoGRCkcLMdHzI84FVIkQThF8HviQ1Y9+PHXQ03LxUmLZ9ULg4E0qywka2+Eyzs
 fDSjaRnm/p4Aq8ChKEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX4QS6UHx9WMgX
 X0b/7/4T481xeTM9b4XyhZiObw2vxUs/wQrPDFZd9HBsKGUQhf53XgIWgKk3ZQ6YTg/oDg+W5bQ
 w9V68N0ezTXKFrFgaaG+FADNJQ4M7tk=
X-Proofpoint-ORIG-GUID: l317IRxt7ai0bmEYYxO2mHbyoQ2xV0d0
X-Proofpoint-GUID: l317IRxt7ai0bmEYYxO2mHbyoQ2xV0d0
X-Authority-Analysis: v=2.4 cv=dsvrzVg4 c=1 sm=1 tr=0 ts=6a69973d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=wHs4SkhdiV1T9ea67W0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290046
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PRM/GmldSlQ
 vFYK73UGplESamOkG3Co+VcrGWKBSJ4E=; b=jVaq7z/Rhtv6lGLDn6nv8T+0/wf
 er62wUkftsAJsX1HpAV6fH3aIhztBX73F6f475J6c7+n+S9n87kCsSuzOvEVe29N
 PZLNHoN8jcoGATJLAidfdyf8mczVr/MiK64vteT0Jcu8F4IwILvMjI9c4Zci4Tud
 Mw87bvk3T4khp1cC/d3dVyagdKLL2J4MFR+/3mSSjs8QbD1yQ4NrGXOMnqxhPsiw
 gG/PXBVNo34y72diHbBtAqjDqyOT7b1FdPQDzgb/let6y6S369GcFy3GKY7Jg5Iy
 LYLnWXnDLl6XlgT0eGL/pPM9vgait0hXz8kYIo7aFsIDTYs9AWtGgrkt59w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785304893; x=1785909693; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PRM/GmldSlQvFYK73UGplESamOkG3Co+VcrGWKBSJ4E=;
 b=SqXwePV5W+aiq9X+3qx+mCgSqmIPdPmpGibYiNeNKXuTgzOogM9O7UDIwtEa8dblDc
 iun4jgdZKtKUML25ASbCm8Sm2gaT70OuAOGpE/QKp22nq3lbrHkkiC2yYPbn05RFEkDG
 Gig9qVhFrqthoYap+ZTujl2JA8CtrqrCb0K3vamVdnF51ke41mv55TE5WJ4IdAqOPRo8
 IJ5QLQAxuf6Y2Ev65C/7vi1PbbxRjWaRHUdqT/aVVJh4ixQN3nKoXCCTcrkOWdWl3Yo2
 +7CD2W9aglnrZSqadxKJ9cFkQ3hwAfnQzyuEAz/2bfhreawqzzxIIIZ98kSgqq1FkkYH
 9tVA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jVaq7z/R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SqXwePV5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVaq7z/R";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="SqXwePV5"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 configs/qcom_ipq.config            | 37 ++++++++++++++++++++++++++++++
 configs/qcom_ipq9650_mmc_defconfig | 18 +++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig

diff --git a/configs/qcom_ipq.config b/configs/qcom_ipq.config
new file mode 100644
index 000000000000..954a97042ba3
--- /dev/null
+++ b/configs/qcom_ipq.config
@@ -0,0 +1,37 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_CLK=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
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
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+
diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..9438f4844d37
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,18 @@
+#include "qcom_ipq.config"
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_TEXT_BASE=0x8a280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_SYS_PBSIZE=1024
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_CMD_MMC=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
+
-- 
2.34.1

