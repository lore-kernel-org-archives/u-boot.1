Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF5C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3580880E9B;
	Thu,  6 Aug 2026 16:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mKhgqVsTGpZ; Thu,  6 Aug 2026 16:12:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D371180EA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032775;
	bh=a9Kz1XmVKVmIkt3jQ9RUaTXVjspO2T8EUPyUIGS6qMM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BKhBh9Dkfr+AZn8nC73FkutsKOiEpeni591osjgL2N/wsxAXGL09LnD7TDaysmsIz
	 Br1i8nbP1yd0PMOUPNUSIy1vUu59Y21VsVJtzRG8thGikSCD2IsmWpSYHMF91pNaQc
	 6i4hCPTslGyQco9mHYMeOpjM4mUmt8uV1/rok+ydOCalV9DnO4L/B2QYQRSO3P4u8h
	 LgnT0QOAhEcoG6FdeAwZdJ2riE1MQCRzwDgWuhgP8XL5vWJLAw5aVLSawzypq+qZA0
	 sjc29g6p1VF7POl2IA+RkXVakt0CCpQMfxNXvxK4bcvEKdzOr7XcTplGaQMfSdwjih
	 aVGyPylvUpu7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D371180EA2;
	Thu,  6 Aug 2026 16:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C5DF28C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E608402A4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENpVv35ZdHRp for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:12:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DB7B9400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB7B9400D8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB7B9400D8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmPbH1553354
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:12:52 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvv5b0m9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:12:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so3346699a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032771; x=1786637571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a9Kz1XmVKVmIkt3jQ9RUaTXVjspO2T8EUPyUIGS6qMM=;
 b=FFulv8Ost7QzXYfe5XH+d21W9yHuPSe+S14qwGOMtkHX16SvB43nby50i30bQLSiR8
 1me0PG3vmGeAgEp6gis8OjBYIMqygGo2IMMVqWfFnPP07Q7U/Vw2MhiTSyO8ihWs3hbz
 t7+V0ypbXlVgylK9JVPIguuFrsZKLtJXLH0jdDzkuxXw6az7cWEP3jJqm0nrFryULBMz
 Ms/TU4/+nnYNPemo8hyxJfKaTShQJgazOG0aqnJgJSoD7B8LzEdui4YmUNfceW4lJp1i
 SEWoXFuMSdzaBEhVNb1fxBxBXHfoRQpet/qxoC6p3cfMoolnrs871dGRLRrJxoTcDK6s
 bD7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI3ssrQOGG0A3NYH/ni7RnuIemohqj/vPGLHbGH45O+FpFmdgigtk1EDS8EFKu9UWmePSDuzs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzCOMisSda7bHa0PHsef9qv17wX5cP2FwNGkiGtPz6m6FqweRM8
 5+bcFlOfiWkZ2dErAyPLgXYY25TweiOvIYpUKZGMs6jRfdRL4z9XwUbxEKLrHoanUuMrTRvq/I+
 MpKNbyi3p6jBSBawegsmZyt3kaN8AxcUzff29cmKaXzY+oCmwJKHf49eIOpI/JshGmxmp/WY=
X-Gm-Gg: AR+sD11wU+9c23fyxmSdIcXD0KeRkRWOA1OtqMk3l/kqsc2adEtwdjTmcuHXDFz7vBO
 M2xPf3tx8fSuEBz4Tc6zbsPV2QYyheT13ZCEzk7GS57BC2Lhk79lEk1MM4UbEMRwJ+z9gGPSDxS
 /uehFEcacKKJJAZE+FJ3mcofdXZAUXgXZQjz6g6rlwToDLTU9j+DQxw3lRIUH5EcyM+PNGxtLFH
 2YOvFFTLmuI5Lbo47sqAzMj6llKtIBohUdnmhZrR6AjF77KNG7lyh3k/H3dnlNfEoqrL/TkP6QZ
 t70CBb0KrS4gigrnRWt9xDLoiBEWQTNbi9X8gBVre0pRvmtdOxtmetzEWajB5aGbcpbOU2BS3le
 MBVPAjFB+B0LE9EvYJpaaU24Rpm7hD7SvsL6k+ckVvrJC3RL/ZvEUgov6yGer4cmwKRRaUkdToG
 pXoV3dN7xSc3fUSi3gqw6FxlAaOvTJ
X-Received: by 2002:a05:6a20:c5a7:b0:3c8:f98f:475b with SMTP id
 adf61e73a8af0-3cb85e6c950mr20186934637.19.1786032771007; 
 Thu, 06 Aug 2026 09:12:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:c5a7:b0:3c8:f98f:475b with SMTP id
 adf61e73a8af0-3cb85e6c950mr20186851637.19.1786032770334; 
 Thu, 06 Aug 2026 09:12:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:49 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:20 +0530
Subject: [PATCH 3/7] pinctrl: qcom: Add QCS8300 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-3-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=20870;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=upweHYxPRyesq7EzHrOxX/uetLFZjiAe5kZN7IdI1IQ=;
 b=ZBt1I4hTRPm1eTD+Yye7O2//j8QGCuPml5zDtSFYyxqqw3MPXyYtbj87Yh87w3y+vK/BmRz41
 98h7FWsoB4uAOx8ucmBxc793m67Kavvb0v2Ss9Cus7g8AdG2xOFVf9a
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX5PM38/mmS/pt
 HBd211tsL5FAFx1RybkR8aLLjthIS0QIgVdvMmeGntw+4MLSBArZJQ8qilWLrY6KNVEPwRpiFXe
 FK5649PBL5ejojHCtpb9hABv4VTi+DG5aRPqsJNLhHYpjUtgypdz/8K61rRKH32sSJBwbfAHdzv
 en35FGvnpAlWe+jf5x46PHYhxcvX/9cy7SlC0HlsCz07gO/KIzwLsHfkCJKsoiGXI7V2iiVyvzr
 LXr30t3k7Tbgle0+NIjU6dIQtHzoHSuFhPO/QEoq7WosY/ORhqhEs8taL+wjCPajaS1PABsDwLe
 tM/+FGv1Ln3GZ4TXV6J9btF/JD3cylXz9opHamE4CdT06Knur+4q0j3q1qtQnf1y2+g5dzmoSH9
 3e74ELPaMX58itt70ZfU1xdAji9EhcSL1IxIjeS7IgdIFhBFuZrskBFiq3rTTMNTfdYY1I8UWhU
 +x8ik4Vnc+ltoz+Spag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX2qpY04UkKk+8
 pYYuzN6YhOmMzwlL366/fbI3MKyixzuDRJjHCM8d0puQQl1WAsGFQmgK4fzdo4BE6zSuZ1YtT6d
 GBW/n7Doo6BEWUvspv6XU7/FTfQtTic=
X-Proofpoint-GUID: mEKt2wXGYLNnTaD87JcC6vC7tUXcJhau
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=6a74b284 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dCGXFTAdOoUR1-5AVuMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: mEKt2wXGYLNnTaD87JcC6vC7tUXcJhau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a9Kz1XmVKVmIkt3jQ9RUaTXVjspO2T8EUPyUIGS6qMM=; b=mYq6wW6ggqy4b3KJ
 2Xu+2cGV7vuvPFP/blUwwzGeVNtrcvTH9875yW10Y4IKApKmfMle+8/TkQ3Tkokv
 Jdfa0lQw0eq+hiN32jqcudTXgOmBUHghg+6mLszYfveMkb/t4EQmbscfjAd+HOUn
 klrG8ikiDx1FZUJBevnH4/Wj4piDJbtK+xwAKiQXlXtgSs9kd1NoZ4GmWFZ97VdC
 O7OOHdb8xWnZVF5tkejuzPdQaoBKebPgAXsrwSrf+zWxyogLA4JLdb4DvAsE3AK8
 7S3dPa/vnuuAhpoB0UkZ1ombLpyLklgv+1z/ESLYPHQUL+3W6gqmQxgMKhQ5K2wI
 rk8Tlw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032771; x=1786637571;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9Kz1XmVKVmIkt3jQ9RUaTXVjspO2T8EUPyUIGS6qMM=;
 b=dLPzQuxnBxH3rfLLmJk9aHd/7GoOedlDkB9rUXWeGdMXAIp3AsH5wbd8mfQpOYn9MI
 MEk2mnVLHplZg63fPFmcmXIYizA3FZoV9ILGvfnsXAfPtsUSsW8gtJUssOYeOYe+CqpV
 T0KbfzIYz4uvihwKGDcl9LZc4zIRI5evvRYj4LmiASzsgVm4w6jHt25VHFrQlXVTWkeT
 rL+gIqkpWU6zbnGdCmNQ8B6syeuYdy+wMNWpfL4kQ9/s0VXToGd6dxkmBrM5t5geWMbJ
 8Z05PQmfApcn6WNrnQBuXSOmyHrVPFKvvnhmB5pkaHpD487yzPDbqjxKSMDFfs9txktc
 VA2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYq6wW6g; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dLPzQuxn
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add pinctrl support for QCS8300.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 468 +++++++++++++++++++++++++++++++++
 3 files changed, 477 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 0bea461fcc3..2af71945c4d 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -86,6 +86,14 @@ config PINCTRL_QCOM_QCS615
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_QCS8300
+	bool "Qualcomm QCS8300 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS8300 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 87cb128c4d4..e10fbc3d3ec 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
+obj-$(CONFIG_PINCTRL_QCOM_QCS8300) += pinctrl-qcs8300.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs8300.c b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
new file mode 100644
index 00000000000..91f7c4fcf1e
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm QCS8300 pinctrl
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+#define MSM_PIN_FUNCTION_COUNT 12
+
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[MSM_PIN_FUNCTION_COUNT];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)\
+	{\
+		msm_mux_gpio, /* gpio mode */\
+		msm_mux_##f1,\
+		msm_mux_##f2,\
+		msm_mux_##f3,\
+		msm_mux_##f4,\
+		msm_mux_##f5,\
+		msm_mux_##f6,\
+		msm_mux_##f7,\
+		msm_mux_##f8,\
+		msm_mux_##f9,\
+		msm_mux_##f10,\
+		msm_mux_##f11 /* egpio mode */\
+	}
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)\
+	{\
+		.name = pg_name,\
+		.ctl_reg = ctl,\
+		.io_reg = 0,\
+		.pull_bit = pull,\
+		.drv_bit = drv,\
+		.oe_bit = -1,\
+		.in_bit = -1,\
+		.out_bit = -1,\
+	}
+
+#define UFS_RESET(pg_name, ctl)\
+	{\
+		.name = pg_name,\
+		.ctl_reg = ctl,\
+		.io_reg = ctl + 0x4,\
+		.pull_bit = 3,\
+		.drv_bit = 0,\
+		.oe_bit = -1,\
+		.in_bit = -1,\
+		.out_bit = 0,\
+	}
+
+enum qcs8300_functions {
+	msm_mux_gpio,
+	msm_mux_aoss_cti,
+	msm_mux_atest_char,
+	msm_mux_atest_usb2,
+	msm_mux_audio_ref,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c_scl,
+	msm_mux_cci_i2c_sda,
+	msm_mux_cci_timer,
+	msm_mux_cri_trng,
+	msm_mux_dbg_out,
+	msm_mux_ddr_bist,
+	msm_mux_ddr_pxi0,
+	msm_mux_ddr_pxi1,
+	msm_mux_ddr_pxi2,
+	msm_mux_ddr_pxi3,
+	msm_mux_edp0_hot,
+	msm_mux_edp0_lcd,
+	msm_mux_edp1_lcd,
+	msm_mux_egpio,
+	msm_mux_emac0_mcg0,
+	msm_mux_emac0_mcg1,
+	msm_mux_emac0_mcg2,
+	msm_mux_emac0_mcg3,
+	msm_mux_emac0_mdc,
+	msm_mux_emac0_mdio,
+	msm_mux_emac0_ptp_aux,
+	msm_mux_emac0_ptp_pps,
+	msm_mux_gcc_gp1,
+	msm_mux_gcc_gp2,
+	msm_mux_gcc_gp3,
+	msm_mux_gcc_gp4,
+	msm_mux_gcc_gp5,
+	msm_mux_hs0_mi2s,
+	msm_mux_hs1_mi2s,
+	msm_mux_hs2_mi2s,
+	msm_mux_ibi_i3c,
+	msm_mux_jitter_bist,
+	msm_mux_mdp0_vsync0,
+	msm_mux_mdp0_vsync1,
+	msm_mux_mdp0_vsync3,
+	msm_mux_mdp0_vsync6,
+	msm_mux_mdp0_vsync7,
+	msm_mux_mdp_vsync,
+	msm_mux_mi2s1_data0,
+	msm_mux_mi2s1_data1,
+	msm_mux_mi2s1_sck,
+	msm_mux_mi2s1_ws,
+	msm_mux_mi2s2_data0,
+	msm_mux_mi2s2_data1,
+	msm_mux_mi2s2_sck,
+	msm_mux_mi2s2_ws,
+	msm_mux_mi2s_mclk0,
+	msm_mux_mi2s_mclk1,
+	msm_mux_pcie0_clkreq,
+	msm_mux_pcie1_clkreq,
+	msm_mux_phase_flag,
+	msm_mux_pll_bist,
+	msm_mux_pll_clk,
+	msm_mux_prng_rosc0,
+	msm_mux_prng_rosc1,
+	msm_mux_prng_rosc2,
+	msm_mux_prng_rosc3,
+	msm_mux_qdss_cti,
+	msm_mux_qdss_gpio,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3,
+	msm_mux_qup0_se4,
+	msm_mux_qup0_se5,
+	msm_mux_qup0_se6,
+	msm_mux_qup0_se7,
+	msm_mux_qup1_se0,
+	msm_mux_qup1_se1,
+	msm_mux_qup1_se2,
+	msm_mux_qup1_se3,
+	msm_mux_qup1_se4,
+	msm_mux_qup1_se5,
+	msm_mux_qup1_se6,
+	msm_mux_qup1_se7,
+	msm_mux_qup2_se0,
+	msm_mux_sailss_emac0,
+	msm_mux_sailss_ospi,
+	msm_mux_sgmii_phy,
+	msm_mux_tb_trig,
+	msm_mux_tgu_ch0,
+	msm_mux_tgu_ch1,
+	msm_mux_tgu_ch2,
+	msm_mux_tgu_ch3,
+	msm_mux_tsense_pwm1,
+	msm_mux_tsense_pwm2,
+	msm_mux_tsense_pwm3,
+	msm_mux_tsense_pwm4,
+	msm_mux_usb2phy_ac,
+	msm_mux_vsense_trigger,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(aoss_cti),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_usb2),
+	MSM_PIN_FUNCTION(audio_ref),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c_scl),
+	MSM_PIN_FUNCTION(cci_i2c_sda),
+	MSM_PIN_FUNCTION(cci_timer),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(ddr_bist),
+	MSM_PIN_FUNCTION(ddr_pxi0),
+	MSM_PIN_FUNCTION(ddr_pxi1),
+	MSM_PIN_FUNCTION(ddr_pxi2),
+	MSM_PIN_FUNCTION(ddr_pxi3),
+	MSM_PIN_FUNCTION(edp0_hot),
+	MSM_PIN_FUNCTION(edp0_lcd),
+	MSM_PIN_FUNCTION(edp1_lcd),
+	MSM_PIN_FUNCTION(egpio),
+	MSM_PIN_FUNCTION(emac0_mcg0),
+	MSM_PIN_FUNCTION(emac0_mcg1),
+	MSM_PIN_FUNCTION(emac0_mcg2),
+	MSM_PIN_FUNCTION(emac0_mcg3),
+	MSM_PIN_FUNCTION(emac0_mdc),
+	MSM_PIN_FUNCTION(emac0_mdio),
+	MSM_PIN_FUNCTION(emac0_ptp_aux),
+	MSM_PIN_FUNCTION(emac0_ptp_pps),
+	MSM_PIN_FUNCTION(gcc_gp1),
+	MSM_PIN_FUNCTION(gcc_gp2),
+	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gcc_gp4),
+	MSM_PIN_FUNCTION(gcc_gp5),
+	MSM_PIN_FUNCTION(hs0_mi2s),
+	MSM_PIN_FUNCTION(hs1_mi2s),
+	MSM_PIN_FUNCTION(hs2_mi2s),
+	MSM_PIN_FUNCTION(ibi_i3c),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(mdp0_vsync0),
+	MSM_PIN_FUNCTION(mdp0_vsync1),
+	MSM_PIN_FUNCTION(mdp0_vsync3),
+	MSM_PIN_FUNCTION(mdp0_vsync6),
+	MSM_PIN_FUNCTION(mdp0_vsync7),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mi2s1_data0),
+	MSM_PIN_FUNCTION(mi2s1_data1),
+	MSM_PIN_FUNCTION(mi2s1_sck),
+	MSM_PIN_FUNCTION(mi2s1_ws),
+	MSM_PIN_FUNCTION(mi2s2_data0),
+	MSM_PIN_FUNCTION(mi2s2_data1),
+	MSM_PIN_FUNCTION(mi2s2_sck),
+	MSM_PIN_FUNCTION(mi2s2_ws),
+	MSM_PIN_FUNCTION(mi2s_mclk0),
+	MSM_PIN_FUNCTION(mi2s_mclk1),
+	MSM_PIN_FUNCTION(pcie0_clkreq),
+	MSM_PIN_FUNCTION(pcie1_clkreq),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll_bist),
+	MSM_PIN_FUNCTION(pll_clk),
+	MSM_PIN_FUNCTION(prng_rosc0),
+	MSM_PIN_FUNCTION(prng_rosc1),
+	MSM_PIN_FUNCTION(prng_rosc2),
+	MSM_PIN_FUNCTION(prng_rosc3),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qdss_gpio),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3),
+	MSM_PIN_FUNCTION(qup0_se4),
+	MSM_PIN_FUNCTION(qup0_se5),
+	MSM_PIN_FUNCTION(qup0_se6),
+	MSM_PIN_FUNCTION(qup0_se7),
+	MSM_PIN_FUNCTION(qup1_se0),
+	MSM_PIN_FUNCTION(qup1_se1),
+	MSM_PIN_FUNCTION(qup1_se2),
+	MSM_PIN_FUNCTION(qup1_se3),
+	MSM_PIN_FUNCTION(qup1_se4),
+	MSM_PIN_FUNCTION(qup1_se5),
+	MSM_PIN_FUNCTION(qup1_se6),
+	MSM_PIN_FUNCTION(qup1_se7),
+	MSM_PIN_FUNCTION(qup2_se0),
+	MSM_PIN_FUNCTION(sailss_emac0),
+	MSM_PIN_FUNCTION(sailss_ospi),
+	MSM_PIN_FUNCTION(sgmii_phy),
+	MSM_PIN_FUNCTION(tb_trig),
+	MSM_PIN_FUNCTION(tgu_ch0),
+	MSM_PIN_FUNCTION(tgu_ch1),
+	MSM_PIN_FUNCTION(tgu_ch2),
+	MSM_PIN_FUNCTION(tgu_ch3),
+	MSM_PIN_FUNCTION(tsense_pwm1),
+	MSM_PIN_FUNCTION(tsense_pwm2),
+	MSM_PIN_FUNCTION(tsense_pwm3),
+	MSM_PIN_FUNCTION(tsense_pwm4),
+	MSM_PIN_FUNCTION(usb2phy_ac),
+	MSM_PIN_FUNCTION(vsense_trigger),
+};
+
+static const msm_pin_function qcs8300_pin_functions[] = {
+	[0] = PINGROUP(0, _, _, _, _, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, pcie0_clkreq, _, _, _, _, _, _, _, _, _, _),
+	[2] = PINGROUP(2, _, _, _, _, _, _, _, _, _, _, _),
+	[3] = PINGROUP(3, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[4] = PINGROUP(4, sgmii_phy, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[5] = PINGROUP(5, emac0_mdc, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[6] = PINGROUP(6, emac0_mdio, _, _, _, _, _, _, _, _, _, _),
+	[7] = PINGROUP(7, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[8] = PINGROUP(8, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, qup2_se0, emac0_mcg0, _, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, qup2_se0, emac0_mcg1, _, _, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[14] = PINGROUP(14, qup2_se0, tb_trig, _, _, _, _, _, _, _, _, _),
+	[15] = PINGROUP(15, qup2_se0, _, sailss_ospi, sailss_emac0, _, _, _, _, _, _, _),
+	[16] = PINGROUP(16, qup2_se0, _, _, sailss_ospi, sailss_emac0, _, _, _, _, _, _),
+	[17] = PINGROUP(17, qup0_se0, qup0_se1, ibi_i3c, _, _, _, _, _, _, _, _),
+	[18] = PINGROUP(18, qup0_se0, qup0_se1, ibi_i3c, _, _, _, _, _, _, _, _),
+	[19] = PINGROUP(19, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _, _, _, _, _, _, _),
+	[20] = PINGROUP(20, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _, _, _, _, _, _, _),
+	[21] = PINGROUP(21, qup0_se5, cci_timer, _, _, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, pcie1_clkreq, qup0_se5, cci_timer, _, _, _, _, _, _, _, _),
+	[23] = PINGROUP(23, qup0_se5, cci_timer, qdss_cti, _, _, _, _, _, _, _, _),
+	[24] = PINGROUP(24, qup0_se5, emac0_ptp_aux, emac0_ptp_pps, qdss_cti, emac0_mcg2, _, _, _, _, _, _),
+	[25] = PINGROUP(25, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, qup0_se3, _, _, _, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[29] = PINGROUP(29, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_pps, tgu_ch2, _, _, _, _, _, _),
+	[30] = PINGROUP(30, qup0_se4, cci_i2c_scl, cci_async, emac0_ptp_pps, tgu_ch3, _, _, _, _, _, _),
+	[31] = PINGROUP(31, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_aux, _, _, _, _, _, _, _),
+	[32] = PINGROUP(32, qup0_se4, cci_i2c_scl, emac0_ptp_aux, mdp_vsync, _, _, _, _, _, _, _),
+	[33] = PINGROUP(33, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, qup0_se2, gcc_gp1, _, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, qup0_se2, gcc_gp2, qdss_gpio, _, _, _, _, _, _, _, _),
+	[37] = PINGROUP(37, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _, _, _, _, _, _, _),
+	[38] = PINGROUP(38, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _, _, _, _, _, _, _),
+	[39] = PINGROUP(39, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _, _, _, _, _, _, _),
+	[40] = PINGROUP(40, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _, _, _, _, _, _, _),
+	[41] = PINGROUP(41, qup1_se3, _, _, _, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, qup1_se3, _, mdp_vsync, _, _, _, _, _, _, _, _),
+	[43] = PINGROUP(43, qup0_se7, _, tgu_ch0, _, _, _, _, _, _, _, _),
+	[44] = PINGROUP(44, qup0_se7, _, tgu_ch1, _, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[46] = PINGROUP(46, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[48] = PINGROUP(48, qup1_se4, hs1_mi2s, edp0_lcd, _, _, _, _, _, _, _, _),
+	[49] = PINGROUP(49, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, edp1_lcd, ddr_pxi1, _, _, _, _, _),
+	[50] = PINGROUP(50, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, _, ddr_pxi1, _, _, _, _, _),
+	[51] = PINGROUP(51, qup1_se5, hs2_mi2s, qdss_cti, _, _, _, _, _, _, _, _),
+	[52] = PINGROUP(52, qup1_se5, hs2_mi2s, qdss_cti, mdp_vsync, ddr_pxi2, _, _, _, _, _, _),
+	[53] = PINGROUP(53, ddr_bist, _, _, _, _, _, _, _, _, _, _),
+	[54] = PINGROUP(54, cci_i2c_sda, phase_flag, ddr_bist, _, _, _, _, _, _, _, _),
+	[55] = PINGROUP(55, cci_i2c_scl, phase_flag, ddr_bist, _, _, _, _, _, _, _, _),
+	[56] = PINGROUP(56, phase_flag, ddr_bist, _, _, _, _, _, _, _, _, _),
+	[57] = PINGROUP(57, cci_i2c_sda, prng_rosc0, qdss_gpio, _, _, _, _, _, _, _, _),
+	[58] = PINGROUP(58, cci_i2c_scl, prng_rosc1, qdss_gpio, _, _, _, _, _, _, _, _),
+	[59] = PINGROUP(59, cci_i2c_sda, prng_rosc2, qdss_gpio, _, _, _, _, _, _, _, _),
+	[60] = PINGROUP(60, cci_i2c_scl, prng_rosc3, qdss_gpio, _, _, _, _, _, _, _, _),
+	[61] = PINGROUP(61, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[62] = PINGROUP(62, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[63] = PINGROUP(63, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[64] = PINGROUP(64, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[65] = PINGROUP(65, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[66] = PINGROUP(66, phase_flag, _, atest_char, _, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, cam_mclk, vsense_trigger, atest_usb2, _, _, _, _, _, _, _, _),
+	[68] = PINGROUP(68, cam_mclk, gcc_gp4, atest_usb2, ddr_pxi0, _, _, _, _, _, _, _),
+	[69] = PINGROUP(69, cam_mclk, gcc_gp3, atest_usb2, ddr_pxi0, _, _, _, _, _, _, _),
+	[70] = PINGROUP(70, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[71] = PINGROUP(71, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[72] = PINGROUP(72, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[73] = PINGROUP(73, _, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[74] = PINGROUP(74, pll_clk, qdss_gpio, atest_usb2, _, _, _, _, _, _, _, _),
+	[75] = PINGROUP(75, _, dbg_out, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[76] = PINGROUP(76, gcc_gp5, tsense_pwm4, _, _, _, _, _, _, _, _, _),
+	[77] = PINGROUP(77, gcc_gp5, tsense_pwm3, _, _, _, _, _, _, _, _, _),
+	[78] = PINGROUP(78, tsense_pwm2, _, _, _, _, _, _, _, _, _, _),
+	[79] = PINGROUP(79, emac0_ptp_aux, emac0_ptp_pps, emac0_mcg3, _, tsense_pwm1, _, _, _, _, _, _),
+	[80] = PINGROUP(80, qup0_se6, mdp0_vsync6, _, atest_usb2, ddr_pxi3, _, _, _, _, _, _),
+	[81] = PINGROUP(81, qup0_se6, mdp0_vsync7, gcc_gp2, _, atest_usb2, ddr_pxi3, _, _, _, _, _),
+	[82] = PINGROUP(82, qup0_se6, gcc_gp3, _, _, _, _, _, _, _, _, _),
+	[83] = PINGROUP(83, qup0_se6, gcc_gp4, _, atest_usb2, ddr_pxi2, _, _, _, _, _, _),
+	[84] = PINGROUP(84, qup1_se2, gcc_gp1, _, atest_usb2, _, _, _, _, _, _, _),
+	[85] = PINGROUP(85, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[86] = PINGROUP(86, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[87] = PINGROUP(87, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[88] = PINGROUP(88, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[89] = PINGROUP(89, qup1_se6, qup1_se7, mdp0_vsync0, _, _, _, _, _, _, _, _),
+	[90] = PINGROUP(90, qup1_se6, qup1_se7, mdp0_vsync1, cri_trng, _, _, _, _, _, _, _),
+	[91] = PINGROUP(91, qup1_se7, qup1_se6, mdp0_vsync3, cri_trng, _, _, _, _, _, _, _),
+	[92] = PINGROUP(92, qup1_se7, qup1_se6, cri_trng, _, atest_usb2, _, _, _, _, _, _),
+	[93] = PINGROUP(93, atest_char, _, _, _, _, _, _, _, _, _, _),
+	[94] = PINGROUP(94, edp0_hot, _, _, _, _, _, _, _, _, _, _),
+	[95] = PINGROUP(95, _, _, _, _, _, _, _, _, _, _, _),
+	[96] = PINGROUP(96, _, _, _, _, _, _, _, _, _, _, _),
+	[97] = PINGROUP(97, mi2s_mclk0, jitter_bist, qdss_gpio, _, _, _, _, _, _, _, _),
+	[98] = PINGROUP(98, mi2s1_sck, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[99] = PINGROUP(99, mi2s1_ws, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[100] = PINGROUP(100, mi2s1_data0, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[101] = PINGROUP(101, mi2s1_data1, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[102] = PINGROUP(102, mi2s2_sck, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[103] = PINGROUP(103, mi2s2_ws, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[104] = PINGROUP(104, mi2s2_data0, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[105] = PINGROUP(105, mi2s2_data1, audio_ref, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
+	[106] = PINGROUP(106, hs0_mi2s, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[107] = PINGROUP(107, hs0_mi2s, pll_bist, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
+	[108] = PINGROUP(108, hs0_mi2s, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[109] = PINGROUP(109, hs0_mi2s, mi2s_mclk1, qdss_gpio, _, _, _, _, _, _, _, _),
+	[110] = PINGROUP(110, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[111] = PINGROUP(111, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[112] = PINGROUP(112, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[113] = PINGROUP(113, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[114] = PINGROUP(114, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[115] = PINGROUP(115, _, _, _, _, _, _, _, _, _, _, egpio),
+	[116] = PINGROUP(116, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[117] = PINGROUP(117, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[118] = PINGROUP(118, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[119] = PINGROUP(119, _, _, _, _, _, _, _, _, _, _, egpio),
+	[120] = PINGROUP(120, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[121] = PINGROUP(121, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[122] = PINGROUP(122, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[123] = PINGROUP(123, _, _, _, _, _, _, _, _, _, _, egpio),
+	[124] = PINGROUP(124, _, _, _, _, _, _, _, _, _, _, egpio),
+	[125] = PINGROUP(125, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[126] = PINGROUP(126, _, _, _, _, _, _, _, _, _, _, egpio),
+	[127] = PINGROUP(127, _, _, _, _, _, _, _, _, _, _, egpio),
+	[128] = PINGROUP(128, _, _, _, _, _, _, _, _, _, _, egpio),
+	[129] = PINGROUP(129, _, _, _, _, _, _, _, _, _, _, egpio),
+	[130] = PINGROUP(130, _, _, _, _, _, _, _, _, _, _, egpio),
+	[131] = PINGROUP(131, _, _, _, _, _, _, _, _, _, _, egpio),
+	[132] = PINGROUP(132, _, _, _, _, _, _, _, _, _, _, egpio),
+};
+
+static const struct msm_special_pin_data qcs8300_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0x92000),
+	[1] = SDC_QDSD_PINGROUP("sdc1_rclk", 0x89000, 15, 0),
+	[2] = SDC_QDSD_PINGROUP("sdc1_clk", 0x89000, 13, 6),
+	[3] = SDC_QDSD_PINGROUP("sdc1_cmd", 0x89000, 11, 3),
+	[4] = SDC_QDSD_PINGROUP("sdc1_data", 0x89000, 9, 0),
+};
+
+static const char *qcs8300_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *qcs8300_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector >= 133 && selector <= 137)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "%s",
+			 qcs8300_special_pins_data[selector - 133].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int qcs8300_get_function_mux(__maybe_unused unsigned int pin,
+				    unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = qcs8300_pin_functions + pin;
+
+	for (i = 0; i < MSM_PIN_FUNCTION_COUNT; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data qcs8300_data = {
+	.pin_data = {
+		.pin_count = 138,
+		.special_pins_start = 133,
+		.special_pins_data = qcs8300_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = qcs8300_get_function_name,
+	.get_function_mux = qcs8300_get_function_mux,
+	.get_pin_name = qcs8300_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,qcs8300-tlmm",
+		.data = (ulong)&qcs8300_data
+	},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_qcs8300) = {
+	.name		= "pinctrl_qcs8300",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

