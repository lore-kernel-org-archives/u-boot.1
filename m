Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD0C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F2FC80F0A;
	Wed, 22 Jul 2026 10:47:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scY6ryAkUpbU; Wed, 22 Jul 2026 10:47:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EEB980F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717224;
	bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TmFv2vbPWzEqaATTuYQlbqk+khK/7sMs0CWp+6W2u5qJKdCGYtDjCkQJdeSwrS8sp
	 gWYuSI/+715ntIQWqjmVKShp0QVZJ0pp890lBBgjF3a465LtwGsZvosSGWBAV1fA5Z
	 pE2uIIG7OjN5eKSq5F2TuuUNtkXXmcyYfkQ2yet3hPKCwz6l/Q9bNatr0jwJaQKZ47
	 /UAdo6F0fgHm8SgKo4dQRNHsOo5qD3cXhVdQypZDKugXb9+U0rH8Ep5NSffFkaxQ5Y
	 wp+fEd0KHGYjK7jaIZOtECYJgtoUd2VMq8KdpG+ALOKK3Rl9lv9ql6d+PnBpzhnMrN
	 xZ1LMl4TpanLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EEB980F0D;
	Wed, 22 Jul 2026 10:47:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D70F390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F048607D9
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnEg7HeOCHGH for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:47:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5509607D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5509607D4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5509607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:47:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE5C848BA; Wed, 22 Jul 2026 12:46:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B7E803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:46:57 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x6Ia140605
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:56 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2rg19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so8331108a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717215; x=1785322015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
 b=KyMRmIcZX3vLtQO0XBqO7it8buIxYoUeYTOW1YCmXFgu/Yd5fx9XJcZs/DpbTv14uY
 /n2b6cG1Z7gGfzkf6Djw5zrHV86xnvs6BV4WpEf9Rm1kL4J3Mgsf/Ju6K53dWu5OV7yK
 EHur3YXG5TygiB+kXsegi+vwb8YsxbVZ0R5coeMMj4O3GjLOc3oc568W4+Lc+DvOcb4/
 qblfXAK/6dUYT/mTUeWjaQUf83n2pXiBGHAmC2kCjHXCeLv/CDj1OX8kX0tVJ/45ZCvT
 Aqi4RKstVCuCcOz0QTHi0dixyr90/HLxLrPRvuxtZyAp+niUb51LbeuhcXBJMI3wCWnW
 rLOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpT48vVwj8Ft3rsb8+gSROea2w75mTduUuD7oz9MoFwsktKgI+47XuplxZxlAhqxw/Wdt1hr4g=@lists.denx.de
X-Gm-Message-State: AOJu0YxNXPVqX/gG/1qYg7pD0HM/nH+lwJP5JZr2yQGVsRSeGutyky/h
 19GfAM9rq6Xol8OXKSGh3kxCbcABa2EFtAxrVW9ACc5iPgGMrbROY69ooegkglZgGftgHYVu/G8
 QzsfZOMNaCOCWNllW+ESoXME4rnS3brhfTyYfkPE3pUA5jAlqdN4KxSSCja6UnXC2
X-Gm-Gg: AR+sD12vKJlTIsvLMpJMlCnauxzEgopUze49Z/siXMlVCF095EaBvwAKB4UFVIhInrL
 4Z7NuJovWMtLJI0rscDbjdqvwS/al6MS+2d5NhBfL6UwVYTuEUnWM1jVpF4pTur7p7XTT6SNXhr
 OzTdhnk1Q89iMQxv90hujH+KvgzX2I2MBLjoPeY82XfXYOzvvkzZs8oklXsNomhsp0ZVJHkLo8z
 EvTIVIkMgRPOS/5mioVSizspCc7ePlqjbKFPB8Xf6oqw50ALM0eDq1W52OorpPkshSEYioFwPXT
 l/pBTMZ8Q0ULilbVypzF8DdYNDM/d2c3EQIXIq/689bxfyHMTZ5Y1qeMy/3FrcMbRslxa7x9q9x
 zLtlvyTGWRUCUNy7ySDMW9hN5qp+vuu6itwI9tkOpVkBD9hkfmCQP6QZpHTFKvtN1BmUAtaJjkd
 jXFs6TNJXa+YMykYOdqrhn
X-Received: by 2002:a05:6a21:7d06:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c3ad85e2f3mr23590565637.27.1784717214500; 
 Wed, 22 Jul 2026 03:46:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d06:b0:3bf:7ab7:98a4 with SMTP id
 adf61e73a8af0-3c3ad85e2f3mr23590532637.27.1784717214009; 
 Wed, 22 Jul 2026 03:46:54 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm7581425c88.3.2026.07.22.03.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:46:53 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, badhrinath.s@oss.qualcomm.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 2/4] pinctrl: qcom: Add ipq9650 pinctrl driver
Date: Wed, 22 Jul 2026 16:16:22 +0530
Message-Id: <20260722104624.3842833-3-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX0atiEkrcdinh
 cgieeoKrb1FiSludE3LoJPszyR5ag8QPOe6x6jffr5RASUrGgSJDJMPk3YpZbC84TZy/J/DcezN
 hdzQg3ha0KAJuIegwKvKGqJ8UXC6L/bYwe8gvmRaaRxMyuvMkw/Xk/SxxkiGQSi4d2QgImTEwOR
 zGTHZix8dDjzBwPMragJ8PfG/NxeaIaRA48aR6b/WNYVq6qZPdnP3Gwbl0eFdtn/09k/B/hSsEX
 iQE9GsmPKuzDVR7x69ykxv8jO1hBD1YgwZuDRtt6aWPt2skjjBvF1pbBrxQCdAqUlRhp9sAIGpk
 xBvaWZ6an1wDla47IbzKwaduT6g8whGycmUwkOTB3w22qq2qZ/XfAOL5ezGiXk7UX2SgE5Z2Yj7
 fYVehLvPocADEQbF7UUNBvH1b3cP2qo6wEYZqgH6VRG18aK3M7bBcjC+PSzcA/+DArvgsc8CPOl
 IKUfOsicgM0AiZzDCFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX6UtDuostc6D3
 jYojxxq7ebKkXuCIK2IEcQHl5sg4EK6FUbhmj8BYxOrN/HdXal6u3eibqh5eIFm7bvcMSCYIl5y
 V+b5pWx2IK7UVAtDCG8626oEgP7ASww=
X-Proofpoint-GUID: muEHAI2cS7xzxEXpiUcwB0Y-nerHzB8S
X-Proofpoint-ORIG-GUID: muEHAI2cS7xzxEXpiUcwB0Y-nerHzB8S
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a609f9f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=sqB9GGOAUEJllpBDIggA:9 a=O8hF6Hzn-FEA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220104
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NJ2ErqS2xpu
 5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=; b=o7mNJnG3/MEFmEBV7zXZDo+go/T
 QC+GwvrVuWN6cucwGF2ySM6F0LrwB5qq/P+2nhRKYVrVpkzx8TkRPm7vklxv/FKW
 gdH08HNohiYAIYqX+ol1IFxrMrwPbhNW7KYjglPRtCiDwWj4+n5hXmGy/jpAiyUb
 CDyCJqfkv/rhdHRqCBrRreIk2D/ukKdQLLjxXilRP0UUAZsa0m3Ch3GYxsO65QpW
 0vhJ4qb4NnCzLa2dt0+aP5v3nMsK1FqcRN8Krq5WN6zIl9DVJ/ozPNqPd2HIsVVG
 QppKhtqkDHJmyjn9SoYxnSOvivjWrgOxcOxDXGb0Iqi4troV9vl2M9sSuLg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717215; x=1785322015; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
 b=gcXzsjQ0vISwTnbaudsnojqNJbHSP8tvnYUnmjq/QOeursxW6AE44tb8HQEWlRGsDH
 RUwW32ZsB39MTekV+cOncqaGgGA4Y6ZU8dLN0/nDYx4v/or0MUR+3Dpu05pbsLJbuoHX
 Gzgz2H1jxVX4zBStImGhjCVhHxuHAnVE1ic32i31oudhNMnrdQb/1EnekrroaLinTX9X
 OyQ+UkNuyfUCQxUqU2u+KqBmj5M4KbIvM5U/PQLGQtLN2oYwbSa358K9Goc5T09pFMAb
 VrA+pL6Z6+DyaoByxk+A3qhoWew350ZILRhSbyGkwgoQUUoDi2L9753GSoqYJ4gdOK6a
 saoQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o7mNJnG3; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gcXzsjQ0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7mNJnG3";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="gcXzsjQ0"; 
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

Add pinctrl driver for TLMM block found in the Qualcomm IPQ9650 SoC.

This driver supports 54 GPIO pins with various pin functions including
UART, SPI, I2C, SDCC, PCIe, and other peripherals.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c | 430 +++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3e..2c0e40807f0f 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -54,6 +54,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ9650 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_MILOS
 	bool "Qualcomm Milos Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4096c1aa4919..17c88885f8de 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ9650) += pinctrl-ipq9650.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9650.c b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
new file mode 100644
index 000000000000..6496405ae32d
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq9650_functions {
+	msm_mux_gpio,
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri0,
+	msm_mux_audio_pri1,
+	msm_mux_audio_pri_d0,
+	msm_mux_audio_pri_d1,
+	msm_mux_audio_pri_fsync,
+	msm_mux_audio_pri_pclk,
+	msm_mux_audio_sec0,
+	msm_mux_audio_sec1,
+	msm_mux_audio_sec_d0,
+	msm_mux_audio_sec_d1,
+	msm_mux_audio_sec_fsync,
+	msm_mux_audio_sec_pclk,
+	msm_mux_core_voltage_0,
+	msm_mux_core_voltage_1,
+	msm_mux_core_voltage_2,
+	msm_mux_core_voltage_3,
+	msm_mux_core_voltage_4,
+	msm_mux_cri_rng0,
+	msm_mux_cri_rng1,
+	msm_mux_cri_rng2,
+	msm_mux_dbg_out_clk,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pcie2_clk_req_n,
+	msm_mux_pcie2_wake,
+	msm_mux_pcie3_clk_req_n,
+	msm_mux_pcie3_wake,
+	msm_mux_pcie4_clk_req_n,
+	msm_mux_pcie4_wake,
+	msm_mux_pll_bist_sync,
+	msm_mux_pll_test,
+	msm_mux_pwm_out00,
+	msm_mux_pwm_out01,
+	msm_mux_pwm_out02,
+	msm_mux_pwm_out10,
+	msm_mux_pwm_out11,
+	msm_mux_pwm_out12,
+	msm_mux_pwm_out20,
+	msm_mux_pwm_out21,
+	msm_mux_pwm_out22,
+	msm_mux_pwm_out30,
+	msm_mux_pwm_out31,
+	msm_mux_pwm_out32,
+	msm_mux_pwm_out40,
+	msm_mux_pwm_out41,
+	msm_mux_pwm_out42,
+	msm_mux_pwm_out50,
+	msm_mux_pwm_out51,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_qup_se0_l0,
+	msm_mux_qup_se0_l1,
+	msm_mux_qup_se0_l2,
+	msm_mux_qup_se0_l3,
+	msm_mux_qup_se0_l4,
+	msm_mux_qup_se0_l5,
+	msm_mux_qup_se1_l0,
+	msm_mux_qup_se1_l1,
+	msm_mux_qup_se1_l2,
+	msm_mux_qup_se1_l3,
+	msm_mux_qup_se1_l4,
+	msm_mux_qup_se1_l5,
+	msm_mux_qup_se2_l0,
+	msm_mux_qup_se2_l1,
+	msm_mux_qup_se2_l2,
+	msm_mux_qup_se2_l3,
+	msm_mux_qup_se3_l0,
+	msm_mux_qup_se3_l1,
+	msm_mux_qup_se3_l2,
+	msm_mux_qup_se3_l3,
+	msm_mux_qup_se4_l0,
+	msm_mux_qup_se4_l1,
+	msm_mux_qup_se4_l2,
+	msm_mux_qup_se4_l3,
+	msm_mux_qup_se4_l4,
+	msm_mux_qup_se4_l5,
+	msm_mux_qup_se5_l0,
+	msm_mux_qup_se5_l1,
+	msm_mux_qup_se5_l2,
+	msm_mux_qup_se5_l3,
+	msm_mux_qup_se5_l4,
+	msm_mux_qup_se5_l5,
+	msm_mux_qup_se6,
+	msm_mux_qup_se6_l0,
+	msm_mux_qup_se6_l1,
+	msm_mux_qup_se6_l2,
+	msm_mux_qup_se6_l3,
+	msm_mux_qup_se7_l0,
+	msm_mux_qup_se7_l1,
+	msm_mux_qup_se7_l2,
+	msm_mux_qup_se7_l3,
+	msm_mux_resout,
+	msm_mux_rx_los00,
+	msm_mux_rx_los01,
+	msm_mux_rx_los02,
+	msm_mux_rx_los10,
+	msm_mux_rx_los11,
+	msm_mux_rx_los20,
+	msm_mux_rx_los21,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux_tsn,
+
+	msm_mux_NA,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri0),
+	MSM_PIN_FUNCTION(audio_pri1),
+	MSM_PIN_FUNCTION(audio_pri_d0),
+	MSM_PIN_FUNCTION(audio_pri_d1),
+	MSM_PIN_FUNCTION(audio_pri_fsync),
+	MSM_PIN_FUNCTION(audio_pri_pclk),
+	MSM_PIN_FUNCTION(audio_sec0),
+	MSM_PIN_FUNCTION(audio_sec1),
+	MSM_PIN_FUNCTION(audio_sec_d0),
+	MSM_PIN_FUNCTION(audio_sec_d1),
+	MSM_PIN_FUNCTION(audio_sec_fsync),
+	MSM_PIN_FUNCTION(audio_sec_pclk),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(core_voltage_1),
+	MSM_PIN_FUNCTION(core_voltage_2),
+	MSM_PIN_FUNCTION(core_voltage_3),
+	MSM_PIN_FUNCTION(core_voltage_4),
+	MSM_PIN_FUNCTION(cri_rng0),
+	MSM_PIN_FUNCTION(cri_rng1),
+	MSM_PIN_FUNCTION(cri_rng2),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pcie2_clk_req_n),
+	MSM_PIN_FUNCTION(pcie2_wake),
+	MSM_PIN_FUNCTION(pcie3_clk_req_n),
+	MSM_PIN_FUNCTION(pcie3_wake),
+	MSM_PIN_FUNCTION(pcie4_clk_req_n),
+	MSM_PIN_FUNCTION(pcie4_wake),
+	MSM_PIN_FUNCTION(pll_bist_sync),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pwm_out00),
+	MSM_PIN_FUNCTION(pwm_out01),
+	MSM_PIN_FUNCTION(pwm_out02),
+	MSM_PIN_FUNCTION(pwm_out10),
+	MSM_PIN_FUNCTION(pwm_out11),
+	MSM_PIN_FUNCTION(pwm_out12),
+	MSM_PIN_FUNCTION(pwm_out20),
+	MSM_PIN_FUNCTION(pwm_out21),
+	MSM_PIN_FUNCTION(pwm_out22),
+	MSM_PIN_FUNCTION(pwm_out30),
+	MSM_PIN_FUNCTION(pwm_out31),
+	MSM_PIN_FUNCTION(pwm_out32),
+	MSM_PIN_FUNCTION(pwm_out40),
+	MSM_PIN_FUNCTION(pwm_out41),
+	MSM_PIN_FUNCTION(pwm_out42),
+	MSM_PIN_FUNCTION(pwm_out50),
+	MSM_PIN_FUNCTION(pwm_out51),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs),
+	MSM_PIN_FUNCTION(qup_se0_l0),
+	MSM_PIN_FUNCTION(qup_se0_l1),
+	MSM_PIN_FUNCTION(qup_se0_l2),
+	MSM_PIN_FUNCTION(qup_se0_l3),
+	MSM_PIN_FUNCTION(qup_se0_l4),
+	MSM_PIN_FUNCTION(qup_se0_l5),
+	MSM_PIN_FUNCTION(qup_se1_l0),
+	MSM_PIN_FUNCTION(qup_se1_l1),
+	MSM_PIN_FUNCTION(qup_se1_l2),
+	MSM_PIN_FUNCTION(qup_se1_l3),
+	MSM_PIN_FUNCTION(qup_se1_l4),
+	MSM_PIN_FUNCTION(qup_se1_l5),
+	MSM_PIN_FUNCTION(qup_se2_l0),
+	MSM_PIN_FUNCTION(qup_se2_l1),
+	MSM_PIN_FUNCTION(qup_se2_l2),
+	MSM_PIN_FUNCTION(qup_se2_l3),
+	MSM_PIN_FUNCTION(qup_se3_l0),
+	MSM_PIN_FUNCTION(qup_se3_l1),
+	MSM_PIN_FUNCTION(qup_se3_l2),
+	MSM_PIN_FUNCTION(qup_se3_l3),
+	MSM_PIN_FUNCTION(qup_se4_l0),
+	MSM_PIN_FUNCTION(qup_se4_l1),
+	MSM_PIN_FUNCTION(qup_se4_l2),
+	MSM_PIN_FUNCTION(qup_se4_l3),
+	MSM_PIN_FUNCTION(qup_se4_l4),
+	MSM_PIN_FUNCTION(qup_se4_l5),
+	MSM_PIN_FUNCTION(qup_se5_l0),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(qup_se5_l2),
+	MSM_PIN_FUNCTION(qup_se5_l3),
+	MSM_PIN_FUNCTION(qup_se5_l4),
+	MSM_PIN_FUNCTION(qup_se5_l5),
+	MSM_PIN_FUNCTION(qup_se6),
+	MSM_PIN_FUNCTION(qup_se6_l0),
+	MSM_PIN_FUNCTION(qup_se6_l1),
+	MSM_PIN_FUNCTION(qup_se6_l2),
+	MSM_PIN_FUNCTION(qup_se6_l3),
+	MSM_PIN_FUNCTION(qup_se7_l0),
+	MSM_PIN_FUNCTION(qup_se7_l1),
+	MSM_PIN_FUNCTION(qup_se7_l2),
+	MSM_PIN_FUNCTION(qup_se7_l3),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los00),
+	MSM_PIN_FUNCTION(rx_los01),
+	MSM_PIN_FUNCTION(rx_los02),
+	MSM_PIN_FUNCTION(rx_los10),
+	MSM_PIN_FUNCTION(rx_los11),
+	MSM_PIN_FUNCTION(rx_los20),
+	MSM_PIN_FUNCTION(rx_los21),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+	MSM_PIN_FUNCTION(tsn),
+
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq9650_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(1, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(2, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(3, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, sdc_cmd, qspi_cs, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, sdc_clk, qspi_clk, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(6, qup_se0_l2, pwm_out51, NA, cri_rng0, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(7, qup_se0_l3, pwm_out41, NA, cri_rng1, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(8, qup_se0_l0, pwm_out31, NA, cri_rng2, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(9, qup_se0_l1, pwm_out21, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(10, qup_se1_l1, pwm_out11, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(11, qup_se1_l0, pwm_out01, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(12, qup_se1_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(13, qup_se1_l2, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(14, qup_se4_l1, mdc_slv1, tsens_max, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(15, qup_se4_l0, mdio_slv1, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(16, core_voltage_0, qup_se3_l1, pwm_out02, NA, NA, NA, NA, NA, NA),
+	PINGROUP(17, core_voltage_1, qup_se3_l0, pwm_out12, NA, NA, NA, NA, NA, NA),
+	PINGROUP(18, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(19, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, mdc_slv0, qup_se3_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(21, mdio_slv0, qup_se3_l2, atest_char_start, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(22, mdc_mst, atest_char_status2, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(23, mdio_mst, atest_char_status3, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(24, pcie0_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(25, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(26, pcie0_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, pcie1_clk_req_n, qup_se2_l3, qup_se1_l4,
+		 NA, qdss_cti_trig_out_a1, NA, NA, NA, NA),
+	PINGROUP(28, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, pcie1_wake, qup_se2_l2, qup_se1_l5, NA, qdss_cti_trig_in_a1, NA, NA, NA, NA),
+	PINGROUP(30, pcie4_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, pcie4_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(33, core_voltage_2, qup_se2_l1, gcc_plltest_bypassnl,
+		 pwm_out22, atest_char_status0, NA, NA, NA, NA),
+	PINGROUP(34, core_voltage_3, qup_se2_l0, gcc_tlmm, pwm_out32, NA, NA, NA, NA, NA),
+	PINGROUP(35, core_voltage_4, gcc_plltest_resetn, pwm_out42,
+		 atest_char_status1, NA, NA, NA, NA, NA),
+	PINGROUP(36, audio_pri_d0, qup_se7_l2, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(37, audio_pri_d1, qup_se7_l3, audio_sec0,
+		 audio_sec0, rx_los21, qdss_tracedata_a, NA, NA, NA),
+	PINGROUP(38, audio_pri_fsync, qup_se7_l0, rx_los11, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(39, audio_pri_pclk, qup_se7_l1, audio_sec1,
+		 audio_sec1, pll_test, rx_los01, NA, qdss_tracedata_a, NA),
+	PINGROUP(40, pcie3_clk_req_n, qup_se5_l4, qup_se4_l4,
+		 NA, qdss_cti_trig_out_b0, NA, NA, NA, NA),
+	PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(42, pcie3_wake, qup_se5_l5, qup_se4_l5,
+		 NA, qdss_cti_trig_in_b0, NA, NA, NA, NA),
+	PINGROUP(43, qup_se4_l3, qup_se6, pwm_out50, NA, qdss_cti_trig_in_b1, NA, NA, NA, NA),
+	PINGROUP(44, qup_se4_l2, qup_se6, pwm_out40, NA, qdss_cti_trig_out_b1, NA, NA, NA, NA),
+	PINGROUP(45, qup_se5_l2, rx_los20, audio_sec_fsync,
+		 pwm_out30, NA, qdss_traceclk_a, NA, NA, NA),
+	PINGROUP(46, qup_se5_l3, rx_los10, audio_sec_pclk,
+		 mdio_slv, pwm_out20, dbg_out_clk, qdss_tracectl_a, NA, NA),
+	PINGROUP(47, qup_se5_l0, rx_los00, audio_sec_d1,
+		 mdio_slv, pll_bist_sync, pwm_out10, NA, NA, NA),
+	PINGROUP(48, qup_se5_l1, audio_sec_d0, pwm_out00, NA, NA, NA, NA, NA, NA),
+	PINGROUP(49, resout, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, tsn, rx_los02, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(51, pcie2_clk_req_n, qup_se6_l0, qup_se0_l4,
+		 audio_pri1, audio_pri1, qdss_cti_trig_out_a0, NA, NA, NA),
+	PINGROUP(52, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(53, pcie2_wake, qup_se6_l1, qup_se0_l5,
+		 audio_pri0, audio_pri0, qdss_cti_trig_in_a0, NA, atest_tic_en, NA),
+};
+
+static const char *ipq9650_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq9650_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq9650_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq9650_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	debug("Can't find requested function for pin:selector %u:%u\n",
+	      pin, selector);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq9650_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq9650_get_function_name,
+	.get_function_mux = ipq9650_get_function_mux,
+	.get_pin_name = ipq9650_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq9650-tlmm", .data = (ulong)&ipq9650_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq9650) = {
+	.name		= "pinctrl_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

