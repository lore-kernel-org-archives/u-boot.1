Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3159FC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4F6C408DB;
	Wed, 22 Jul 2026 10:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21j6ONJJtUlR; Wed, 22 Jul 2026 10:47:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 884714087F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717259;
	bh=vd3iY/tr97dIolggyG+P2HWv8mqIy7DOsjKTzddAoTU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=o0EaL6169fY3GeHZotZFdJU7Yxm62hDl5uKet8QDyksQ8ooxC9/v7HKTl6lU4q2Rf
	 j3QbcVF6pvX9oCaSozZkE+6XDtcG52S3+hLsQhSuQbWqND0CmQGMeGe93tv0UtjhW5
	 6dOMD7xdKHCaa0btgiuS32XlCLGbsvJ5VCsgwV6TWhh1YvO49fsr/RlIACe6WDoBCY
	 NDwC3POF7TGuqIGXWQQnp17oiVWQSc3qlYFqu1XFHLFoHzujOZXcb7R4ZU+lSKsV+g
	 zIMgBrcHkGBejxYJWNJNtnV6KAMYaLD6O7xMWXcg8jrn/oXLh6hF4qY3QYkl9wNkCb
	 KX6sAnj5i0ppA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 884714087F;
	Wed, 22 Jul 2026 10:47:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B251E1099
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98686607E2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fK9F2eG0JQwO for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:47:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 481B0607D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 481B0607D4
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 481B0607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB72848BA; Wed, 22 Jul 2026 12:47:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1862803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:47:33 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MA7RI8512834
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:47:32 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu7844y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:47:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e2237bc43so15056555a91.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717251; x=1785322051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vd3iY/tr97dIolggyG+P2HWv8mqIy7DOsjKTzddAoTU=;
 b=PgpJxrkHcjwZXEiTO4T07NEPL7+AOopQ1Cfjjs/KyuQLYdH7ro79f5qxEkBRh5BQoj
 C9dA0/48ZnOp+36UsOLB75GiLF7B/BYZrN/ZiIhvxgAPuqTOT85nUePv/Lq6xlWmt/0o
 JkkJDAi7uTLteW5J5chWDY8VBhEivGm9SLRisrBzf0WCWDPiXi8Kqb76Rzyow5Ce5buV
 JFEzYvTuWIDwfO1VF1xgGXiPfCbbzXt5JsoENiRGjcP5mfXX29m7Ytpit3lIhd8/SycE
 b3x9LF2Dt5rGpS65dnoflf5KsF5hJms9m5/VYcFaUuUtpsR4tewHytCH7nlCbanWbVAu
 YKNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopBQf3/mUOhbIR4+y80wX1JkmXzvdvK4lWjBIQSZ3ds4+IbAa+jvkhICy5XLhGPvzwe0qAgnk=@lists.denx.de
X-Gm-Message-State: AOJu0YwlxrvGBsHEdo2KfmvWEdITqCOnq6pDPsCN53zxmuWZhzSlqGha
 71foHX81WwPzbVYtwl7efZPisSo1neIrelpSqEqXn+NfVtOaLfQIPupYDE/LbvnMDSFx+zUTgwc
 bLJ9QUu4s5bzXf31eN1dSaaJzdquAhek729K0Bbp+J/ZmRE8j6bVaeN6H
X-Gm-Gg: AR+sD10TPyCObpG5v4Q9+azUDJOMbREGfZRTm+QKqF1x2+EZRBOYPfATGPBO13WcxJ3
 xaGtDBZanxE6oUwwgTVZXmeKN6l9W+965jc9lbMKYx5a0oVsCZN9u3GjGgDhxrFbNJjdPgxaHnT
 pGIosv/gE60z1TxgbpBV8+eSFqM6oXCNYTqSlkECz87x6VlRJwvnL5rgStYKLtJ73ZhyhlswD2h
 K1+bE9iCEy9kIPl8UALpj1/blEJ7gI3Cbmz5NnaxxQAtDU+cWnHWcI/p/aIlfKj95aFrjgmNW0x
 X0ncpmxTG+mbJmg4+bEYFeCPvESdOzyciMhzA0z7SbFriToRtoJCvcq3vMOOYdd0Sl13YPo60VJ
 2wZm6Dq294fTiykcflrzqOIkLSKZECMVApBgP6yoTImuZU2cnDkaAvAQ26r9z25o2qWZAu8BlHd
 0lqOSxRiO63PjOFVUIj4uH
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38e679f4dc9mr11717072a91.30.1784717251062; 
 Wed, 22 Jul 2026 03:47:31 -0700 (PDT)
X-Received: by 2002:a17:90a:c104:b0:38e:679f:3b2a with SMTP id
 98e67ed59e1d1-38e679f4dc9mr11717038a91.30.1784717250592; 
 Wed, 22 Jul 2026 03:47:30 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm7581425c88.3.2026.07.22.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:47:29 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, badhrinath.s@oss.qualcomm.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 4/4] configs: Add defconfig for ipq9650 RDP488
Date: Wed, 22 Jul 2026 16:16:24 +0530
Message-Id: <20260722104624.3842833-5-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w9hX0wOLLCLiftwfj_xldl45uCx8nl82
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfXz9lAwsXdQgG6
 iw4fNwgNp6ZYRdjDXHue6ctYlUVJzoYTR1HuDhmZPfWFXFNUnFJPMG0pmf9xyFe9ay6A10GTvqp
 q4j2Qrrnl4VrOH9phDtcRtRulzT5uYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX3f1Q6Dhra+92
 FkXpEvQCs5V67qX9SdEFD/3Z0jX8F8oiBcCIMrQihNINEbBegQLwdQR66JnUC6CdzHr8UROnxPm
 MeGF6z5997UyztXOU4j7UV5ellTtkU5befozoSn9JxvaeEUOMBguCCGgsi8Y6enZszPOKKKdDo1
 7ZiCoAibbeZOtShYV9Ll4idVPQnqrc8DA6xATQIwPRZ4dPk/84ADtIQBo1dPe9oRUw0JsBH9VyZ
 34UErBxxUwM8KCYND7+2i+1r+JW7L+ZDMHbCn9zmEJgFeggUxYSmstU6tOx/B+CI7DsoMY+tUo8
 Hj1bgfKINKGY0eNK9HTjRqZ/sVrgexkiLjLhemXOolLsTe4kcQGeR5u6PwIZzhSh32v55YMMH86
 t9Cg6q7j+OtEr5/Q1yW70VbIVlwfrppntBIm8susiVhtwi/PPJVqPU6ceXZlr465nyLCzhWEncB
 91GCfbXw9NIWrw0Pmkg==
X-Proofpoint-GUID: w9hX0wOLLCLiftwfj_xldl45uCx8nl82
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a609fc3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wHs4SkhdiV1T9ea67W0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220104
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vd3iY/tr97d
 IolggyG+P2HWv8mqIy7DOsjKTzddAoTU=; b=gTwAcdZv8SlfSjqmLhACiJRJTHg
 YTIZKM/ATb0KiY31GiZH3YBImREZDIUwtAEgsEXXdZ4BqS7CJUPyQYIEMB9ClAiF
 vJGcFYwBEXnBqDDXHQZf3/PgzyfSJOuahKQce52yDGEvURZ5m6Vq+SuCKQ3apPFI
 ztGfg+YeMTIGuZKbZq/b/mQ3KRgBH4lMS44udulVbxNSKF3MQwnxFz9hhMIYOh9C
 63S6pgp4FNAqowqXdqpTUcdCiaPMIVAOGEXdHPQMo4Meh4Dp9tE8YmlWn4Li/Hl8
 gA1BqpPt3x1Snt0VvkyZH54ghlMTY6BaMdbCvFibMQ2gfio/hlrVlq2GGNw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717251; x=1785322051; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vd3iY/tr97dIolggyG+P2HWv8mqIy7DOsjKTzddAoTU=;
 b=FjNspUJPGiEvdIwSxNeY2l2Y8S6vOUkHOKMmSz95xhpC0/ddxU1LVfOn/lU2xhWSPC
 w5QVUF2oRilB92QwxbM+Cu8LCqSO/N5hrqM3zrK4xifOR2vFbMHf6twrSTG1LaCOSqAR
 vIRS/0ZgtgPAHEQZqbhaKE8JnrV/TQwSip6Zes0rv4r559Ps5hW2a9L3BxnXHkVVYmMP
 oL+olB/srJE7r8/0aoAU1vnf8rKjiKUQzl3YxaKX+koRfTrSnXPGCzvS03/kpD6SXXlN
 MZMl+WtqNTGQcrkdDX+y3y5i/xd2d9kMlM4a+lZkRw9PF+daSa09ylr7QK8E9SQj+XKd
 mQsw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=gTwAcdZv; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FjNspUJP
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTwAcdZv";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="FjNspUJP"; 
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
 configs/qcom_ipq9650_mmc_defconfig | 17 ++++++++++++++
 2 files changed, 54 insertions(+)
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
index 000000000000..e78455a1db71
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,17 @@
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
-- 
2.34.1

