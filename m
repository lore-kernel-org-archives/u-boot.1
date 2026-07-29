Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D69CC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 06:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8557406C2;
	Wed, 29 Jul 2026 06:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QaejWAm9xfG; Wed, 29 Jul 2026 06:01:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C31140AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304892;
	bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=D3PSS50qXbqdZNUWkSMsmzt7rjemKJe4CWSWHMIP7q5V0/INqREFKBaBBJ4WILgHd
	 i/i0smSvHtzrHp3mgqKY+jaVPBbDNq4te2179iHOn9+35zqh72M45loHlZdPsCzeN3
	 aOjjHNPpfYxqtrpNJKPuyTP5L6Nm6N+JazyuP3sFp1rFvl0jz9b1XQ2syPHsPyWBWM
	 Rgro7okJCelSs9OyHVLTTHDgJQ26F4SMIRtvbCEZ4WYvcoYjbKFurXPXu6RZg1o4ww
	 OMeWNDne3lCtG7aE1kclphsS2/3AT7Bqfn/5dT1UP1RVZlT/ogisvjWKIwX05EAT91
	 LliC0+1iDxDyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C31140AB0;
	Wed, 29 Jul 2026 06:01:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 52086788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 383F040AB0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mRkyL8y6ztB for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 06:01:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CCD2540A81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCD2540A81
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCD2540A81
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E3E8494B; Wed, 29 Jul 2026 08:01:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72A98404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:01:24 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T4cPe11153744
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:22 GMT
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq108tcr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so659507b3a.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 23:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304882; x=1785909682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
 b=PBX/wx+d3HZQehuW27h54D1aMwv39G6Hw4He0OEk/6cnAjB6BBg95DdhfFfv176nKt
 ObIfmXBUvXRXI5MGKsos4TqQNaZ30GfvYBHYAY4VVFz1E2lU0WrmNsXjRiNFDPH01/yn
 /0YCDRE1MqM4UMTfqLWJTw3XiOLL8emmb64od4bmffusXk/a8DRCrjsWNnMeWLfhnR1x
 O/zdOXEcWlYDzYqKDNlLIK8xukM1n0c6Ahz4MS6A6+8RHSqyZhIdjbDtAHDLToAQi+83
 UuscS3mVRYJk+8Q9vvkNqh91S1jm2dBp8aKdFg9l1RDPvj9zecxr2ZAfsBN0XmxctVQ1
 QykQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp5o/aLoGK9oxVGwFKh6VeBYK30E0xBW+FlafGk/w77i8ZTlnap2fjoOwIoIJc9bjXS4Gs6q0=@lists.denx.de
X-Gm-Message-State: AOJu0YwqI695rrfDnILoA74OF0Wza5xgWsYoSg+IVc0C/fUdiYPkE4bk
 U7pxBZzsxegG8T89DmlZ9K1qa7/oCBfLPTG9T0O1LslL0OOi7H6HJCUA40TFg5yejoA5R+pZyQv
 xKnD9qUbdvbWpkgpri/a+sBb8965kJnUPBFMzGjEUlC8ntKrla2jK6AZj
X-Gm-Gg: AR+sD13v7X8ryXY4YccO5UmIBfemojCusZmoZhGVVb3mmpV8offfzacoqi88qeE7Iw+
 /kiyBKXWvskeUWiF4GSIUh8NlGeSu+UVXAggaiwilKBLMot2fiKdce4+UEewJpP6/1NKbT/ZYBp
 Qp/y68OpwQpaTq/DeXqkBMIgAQSo/NzR/dsq8adz6BVBTHY5Q7Qp58PVsFwAbP7sKocIBJMZJSv
 Y6J8wxhOwEwVyd0U7aEu3x0IfP/Di9p+eGxjIcd3gJs6iO8JBwMXVUyd7g2bnrP8xtWaMulrmFq
 PrdsJQsiN1oJMMcr5mv4a61l6fOg6Hb9N8VF6WfVMEB7U7mj5J/O9jZHBuhUkv7kBH9wCLO+nVM
 z1PhkJpD9aeoHc2ybbmt841C6RSFqrHOASg6uhcH7EFNrPvqPQ+RikF05CynRrJ3E32LAcrBOFs
 Sl709QR8FB2ch8Gl2R8BcY
X-Received: by 2002:a05:6a20:918c:b0:3b2:924c:566e with SMTP id
 adf61e73a8af0-3c8ba5b7fa8mr6164187637.36.1785304880422; 
 Tue, 28 Jul 2026 23:01:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:918c:b0:3b2:924c:566e with SMTP id
 adf61e73a8af0-3c8ba5b7fa8mr6164106637.36.1785304879559; 
 Tue, 28 Jul 2026 23:01:19 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm6868367eec.30.2026.07.28.23.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:01:19 -0700 (PDT)
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 2/4] pinctrl: qcom: Add ipq9650 pinctrl driver
Date: Wed, 29 Jul 2026 11:30:54 +0530
Message-Id: <20260729060056.2183090-3-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
References: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bRVQqQwj4J2pnLtoMxgwe0lSV4yOQRR8
X-Authority-Analysis: v=2.4 cv=fufsol4f c=1 sm=1 tr=0 ts=6a699732 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=sqB9GGOAUEJllpBDIggA:9 a=O8hF6Hzn-FEA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: bRVQqQwj4J2pnLtoMxgwe0lSV4yOQRR8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX7gBBZYuFS2gN
 6d5De/3VAVGlXFIA59da/AlTXWWg9WaXx7iyiwDW56Acph07DsNaqtvuzU9xIrTv8C3r809cf0K
 /bi85exUoNrdqPUUXnX37xJn4Tz/CVE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX1DRC3MGouFpa
 5EQ1WvbqZcmQyqmGQIjt1nV0EXMn4UKD+cL9mkxSbiGFQN3QgeKie/DTAjQQHLhuDQ5GcbIFLfz
 cB/ovrKGX6P2+w9IdqCiIK7yc8C2/H5JC7ZeBKVQJ17DI/Yz5LLKhtYKBg+dvINZXi+jYYLXcqA
 N0yfguZ7BXtY5deHurFxCc7G5J9sxrrnWuTkuUtumxwG50ofaYcPAZNAFJ+srEZCtVJTBQAJrBQ
 Ba4Y/oLHvegokDoKu+xMTYkOurXA70rd9mHHJVJVLOxDyIFZv5dH+B6ABJJ+YY5Dja2tYLkuYFG
 eUGomwta3Q7bfMoSBPZj2IRQjayWbfSfc+gf57RYSc5lSszRJpGHC/0PB+RxeWR5lpyCII4/zUw
 8o/gGeC4rxNr5ViBYvH1DvfnxDfXlkTSmfbs9la4JV40rHWu8tL5nn1S2jx1FcjDmjzQ7bOqnNm
 pLHqXi/VmlLWGhRRmsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290046
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NJ2ErqS2xpu
 5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=; b=oXBRDxRxWJfKXl3IqanacyJGVfg
 KvKjT8HbrQehQhebhi5OhR1irNjZGHUiZiu69PYWdH6M9KhEAT7k5TwMuyvTv3iA
 JPhS3I7+LSXrX67yXobzwhtqIdqJtRDrqx140e3EmSu6y7/hXIlR0KqW2N8W4CBb
 +Y36aFfK2LXKp/FWNcJXt/cQEnMt+r8ZkGt+6lD1AY7YT7ANGUGIEmW+CHuvuLHG
 /5ah2L+70wZg4cGm4gyy3R2qmFeEfiss0Sx8SsLqXyDI1JAORw+6vCvwWE68o1fH
 jGj3Kg8jgHti8NRqmcMCP5zHihouLXBD/Schfh3qRb/ZqafWkKgcAiI86AQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785304882; x=1785909682; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NJ2ErqS2xpu5Q6d7Qi2vmRAkl0kQ2gb8SYBPApHjWJI=;
 b=kjkbKmvrdBZFx95SOND002ywYuLvxtmwW2QwlR+CvWTeJxlInRwy6gFRcwPzTSmKOv
 aIz1b91Fr0gZ6F/Kd84jth2kGaXS7F2WM09Q1wIHBNQeN52Zp0DGfkRqiGLJxsXS6RRA
 fiklRq5gq6G2kzfh0T+DLcLPJc0laUU/S7zg81l1zfLw+Da/3SpGxzQDIc0BVktaQrHd
 6AUE3f1keiOy+pSPmFM9imTOucgHlBp9K0hnzb+cp/w2grtHaAwrBOLihtPxY4rba8To
 hLrCA8Sj2Q+OvyTelriDnf/8CyI79IJLUuNd0EpuJ7WmGwaMajx6vdAQ3KE8XTAcYn5M
 U9GA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oXBRDxRx; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kjkbKmvr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXBRDxRx";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="kjkbKmvr"; 
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

