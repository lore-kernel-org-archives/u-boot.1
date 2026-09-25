Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D49C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFCA16081B;
	Fri, 25 Sep 2026 14:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTtkZaN3Wv3X; Fri, 25 Sep 2026 14:27:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F055560E10
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346434;
	b=r1cY++B7uCjhjyAwRB3yHm6jIVJiweJ13//NPhwgJ1qlbpjNoqa1jRX7XGXPWI29/mEj
	 B9gbFd/PGfXpoq8NiYW5qoROmLd6CKMqYzUZ1avSt4kan/l3VrsmKBJWRVajCJmiUcrK6
	 odzk5QDkILlH0eUSH/AD2xvQn3Ejv0//6M67/QdXi3Um0UIUDrGNMI+BbLQo44GPOwyPc
	 /zsG/hQkxGwx1GUlJX8CJv8yy0gRWLCv8lxut3cJE+VsvdAGUYy4dOwoCyY+P165akHwV
	 scdDVye9RCnMZSBrY3yLlflHg0zXrsUnDfTBMIkz1JSs+kpq0rePEO0xPJrNTuxP1uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yVDC8HdfU1Jn1mhmUEz4u5GibkcisVpNwKkMNH1B9Ko=;
	b=ftjJTRNGqSkoJG38ELR8S9J6QQkWjijXzelOw3YABV4Dx9b8h0XtruzzZs82MeFjWqnI
	 wIwU0eZNP1GigEEfrUicp5W+f7kSIUl1wA6lAGTzeOvs/wH56a14lhMfYsPEQzp0RClC5
	 /a+YmrKNWFa71KO9R1IlpFf74Qk5OHwOE22eIt3HryxyDHpaPAeiSA1/RognIqhfJTzUP
	 uJR2vcvWuxmJXSSug87HYOWorzX9IN9Mwj/fXnQrhgdmfCBlJCJXI85tjBBWddI30Lr1b
	 oqaMue01IQZsXFbu9IBlOBaKDkpfKS/pW8vspPK3++Hje8uHVCR9ZWskc81LXSflzJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346434;
	bh=yVDC8HdfU1Jn1mhmUEz4u5GibkcisVpNwKkMNH1B9Ko=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M2qYefbGjnzZcYgebtz90YZB1bsChwrkTVxNu66hqRZRx0zFk+mGpD3F9HSMzASI1
	 vE/rnoAdD9RqyoiYsksa82pz4t/UfcDAHmvdu8K9T6a9nbGaAz8zrircbART+I1ae5
	 JbCmanz0sFtgvPlnLVf4o8pC73WJIfkOySi1vVkUXLTCnjuwQ+PSXQpbj+M2pqcPnu
	 DD7pzyrCCDYr2ssICVokpEZOvo7iyCRD8hSF2v8W9AQpdQfTJ9t8w8u1J0qCENBmqJ
	 6i4bJNbhcDkLjlzfRQbEiPJonCMGLORce+l/l8qStI7rY8FYToZ/5SFVjN0equTfFw
	 qelJbfpt2m+CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F055560E10;
	Fri, 25 Sep 2026 14:27:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD3C6B00
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2CE1812C9
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7_LiAUPeq9H for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E71E811AE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=DSO9G99wxnVIsdjdlMpvq/BFnJUkJMNMnvVQOUc3IgK17kFo2BnZVbiqz2qNVjh6loAH
 gw0a3UbTpv39FXwXx6Yty5+grtKvIbaduH2xpeDEJPilVbjQguO+nfwbm3bUfdKb/2zbm
 jmt3xv0l4+pY2I7crTqgtJAT1ZpkvAHtI2aDYwEorni07yf4C1pzcAByA793uVkSUVRwF
 cDEqLVqDGZ4b98kJlfUnqnuoWlMlpvcjfj0kd0V9Qfrr3syYcPp7SwchZJxiHzFiv6ces
 Ym2pMtoRdPWQ1tUXSQYKXdpaR8ZUvTvohy//dLSSizAT9NZowgeIOiDvBXraVe03UAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yVDC8HdfU1Jn1mhmUEz4u5GibkcisVpNwKkMNH1B9Ko=;
 b=JS5FD4iFpSypDmmbcyDJFAlrT3qXxjKxg/54GZQcG8KHARTZp8tZvEgQoH/yw0SbV69g
 sIhIEK89b5JJPDqviCbLZOl8EwgFAav4HbYvD3IE62+q79iKASmWSSLsRx3ts1ex2Poav
 h+Tlu9C89Us6j0fYnCh5Iv7FRklE5sMmMJMJuekw3tBCwflKGNvhNVqgmBqt/r+cZO4zc
 LKTn6NHZkkA/mEuNLdMO4o9+amJl0vvg01mOre7s6N02+xqLrU5INOb7v/A5JId8Vx47j
 B1PTZkn4NCOg7iomBX8dGUEBUeZTV9cVa+utmrVntAS47kYa71kmfRZXFc8gD163YPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ookxTJDB; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ookxTJDB
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E71E811AE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PBLdI3900282; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yVDC8HdfU1J
 n1mhmUEz4u5GibkcisVpNwKkMNH1B9Ko=; b=ookxTJDBMF6nkHiheSOO1h8Fui8
 LRmLdtuMhVXNLeyxwKDicoYeWzC74GTQFr67vIeMd8ki2UDU9lu6knGckmEGqWLE
 7k5AjBc/Vz9iKgIDpDvPHhsyxAAt7auzF3lgyHtoPjc8x5A+YtXp6nmMdq9sDqp4
 8fo4NcpuY4XdFD6bZ+Z3HjugvrAASduP5FTkoT+uL6UzqMobbp3Xsa0PQjEpzOB5
 vlz/ir9JaLQXGgCmQZbmpQIM2TNpmU11W9uVqz6ubU2lYSCk8RqUeb20LwAIuHjJ
 PMAqVa3q5VFa6C829j2VWcymV5HXBWNq2ldTKMnmre+syyfPCRL/DrSzucg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr1008db-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwE5W518064; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68PCwDoY518060
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id D4C83620; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 11/12] configs: qcom: add Shikra SPL defconfig
Date: Fri, 25 Sep 2026 05:58:08 -0700
Message-Id: <20260925125809.1360030-12-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX1WA/rSQj9aFt
 Gv55VGcRbJQIMGRJyepQNut80ADj+rmCy6zBbq/9bVaG+g6d5LelMkLwE88G6XtkGnS9XqYSHku
 mhTjV50o5z5YC7iRoR+PqKFW5B39kZlCXaD4irVi2l62OxJCwjEyM+ODvg/l7rBpfnyY9cviCGy
 iK71cUrS5j9DNyQ3luJHAbJ1vut+8rSj+CjfhShQSBj+xFHk8/VnonKu2aVyaKo7RC9tsrXwIG4
 pcX1AlkkE5S+40jw+eLKyLkzJRzi/cph+H2473tRH2Nh4Bx1soAzZL5/LKYtZ6PYuNjpR6neBwA
 EAHZdGtr8XZf9x+Gv7HrvAh3rGhLfPxH8OXRh60lUNosOmO0NPQCwhvvaC5wPrVk+TiQcFiBzG2
 kuRV2TffqIF55qtJ7OLDroIDcllNhaWDCB3L8JN1u1oFTd/UE0cIGUKbiwohHTOPLo2kXlbXi7U
 r0G0jBGirwDOmX1Y4RA==
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6ab66fe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=GOj2LzLryEk95jnXa_cA:9
X-Proofpoint-ORIG-GUID: sYOiTFoI-sX2C8c37rloe8G3RA8N9yeO
X-Proofpoint-GUID: sYOiTFoI-sX2C8c37rloe8G3RA8N9yeO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX8/igCZMVTcMl
 kG/1WKM5Bozan1abtI4FSHosr5hf2Y4A+YvSUBJpP/xTW4ThOzdXJUEut/WkFXP50b/0fD7ABw1
 Eaoha2tYcX6PiEWUpHMEw7J8ehsLZlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Add the Shikra SPL defconfig with the early serial, eMMC,
pinctrl, SMEM, QCLIB, FIT-loading, and memory-layout options
required for the SPL boot flow.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 configs/qcom_shikra_spl_defconfig | 109 ++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 configs/qcom_shikra_spl_defconfig

diff --git a/configs/qcom_shikra_spl_defconfig b/configs/qcom_shikra_spl_defconfig
new file mode 100644
index 00000000000..7bcb3e21a15
--- /dev/null
+++ b/configs/qcom_shikra_spl_defconfig
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_DEFAULT_DEVICE_TREE="shikra-cqs-evk"
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
+CONFIG_CLK_QCOM_SHIKRA=y
+CONFIG_MSM_GPIO=y
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM=y
+CONFIG_PINCTRL_QCOM_SHIKRA=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_CLOCK=14745600
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
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_GENERIC=y
+CONFIG_SPL_PINCTRL_QCOM=y
+CONFIG_SPL_PINCTRL_QCOM_SHIKRA=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x48000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x0C219000
+CONFIG_SPL_MAX_SIZE=0x7B800
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
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0C2C1800
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x0C294800
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/shikra/shikra-spl-wrap-elf.lds"
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_BASE=0x0C219000
+CONFIG_QCOM_SPL_BOOTIMEM_FLUSH_SIZE=0x134000
+CONFIG_SYS_BOARD="shikra"
-- 
2.34.1

