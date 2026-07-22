Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553CC44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7D1140849;
	Wed, 22 Jul 2026 10:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1FpZVwpNHH1D; Wed, 22 Jul 2026 10:46:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2E604085D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717216;
	bh=ZHfRG30I7SParnWmALg7bUgrqZtd5qkHajWf8jFdGnY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=dMEVrYN2IGWH1dChQP3XllJbIxEljo8RxWKy+EZBTVZrJDRi3ffk0MgTuwkP37xVW
	 8a/l1mFwbz/fGjY+xKCbDwMFLTsfyW5mHakR2L3Yy9bk1AVVLhaojJXPwzfK/kDE0j
	 mLFoMCV9+AhDp9wTwvmFuLcWxGB8+JQMlsuYGz/ApjAnHqy4GU3V+5DdKgo0VDLJjk
	 eao/stRufMVI8mrcqYcSLDrozGb1LtfWLVtB6FZDdJKQOb2XL5fTvWAB/aXmFEvrBV
	 51zCcWlOI0VKBK+BLhaXuCwdfi6d4PyqeHdbM8/vFZ/qrzFVSvX+VVTE7wj7OWE/G1
	 CKFWOfo3tMBrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E604085D;
	Wed, 22 Jul 2026 10:46:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D812242A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D55374085D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vZRQiai2SyL for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:46:53 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9742D40849
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9742D40849
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9742D40849
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273B0848BA; Wed, 22 Jul 2026 12:46:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03123803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:46:48 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xaWM269708
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:47 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6abkfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7131849bso3859632a91.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717206; x=1785322006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZHfRG30I7SParnWmALg7bUgrqZtd5qkHajWf8jFdGnY=;
 b=pfGkhSaP7UWEAbc3Oq8BvfbjONJ6+3Jp/b4qz3A4zmNyma2V84defzJ3Pin7sVW8YY
 mYUt1zHGnLUCtY3XQU6pzfeVGSY3OfSjjPSZn+NjKfla8HgeWSDLsBJzRyamkTkEIzzx
 sl1zRdwcTmwxOYhFaWERDpnCEB9BY0hZ+4owj2NMuvuqq+Ov9eOKtKDlkQ/mEjj9eC6U
 YkA9fWZ/xkbZYtdICdmpysaaz2Fg6xVQzgwrz5eidoAJ3OrLbjyL3E8jsOlqzL6KbV0K
 maihpTtvZ95jTDRNxj+dfTF1dmxG6U1hWdRjl3+YpMJOK4mfLa8AKMQU0Mbp5ZbxFiV4
 LJhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpb2yuNgodFyWMHyWMClcf4GgGQ2WDkX1XGagoQKjdsT8UfVAPYY3mv7VcsPnkAkgyr69AGsrY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs86SbpqB0401kqInnu5Gzcv5t38//H6MmtYXB7pzHuZOidAlQ
 JA5NNT56OG70TIKnZuUFxzhgLsOCanx/TNYIQPqwWf1uF957d+Szjh0fiF2MKJMn5NCGQOSp2Rw
 2t6bSv/ZG/cpxLlZhJ0spevOeRm6B1VFULC49jHsTyaQbHZMTHQS2TSw5
X-Gm-Gg: AR+sD11p2biw2iXdtDejfg1IYb75hZFJAARQDH7DJVNZhXVEDW/oO4wdMXFly+nvIYn
 M6N8eDAHgTHxIVMsx1BJILIeq0DJcaiIPzCvS+9BLr4L3iYk+bVkv+IBgJ0/+MmH9E2wTy1eWIK
 NdPRiHa1QiaVymlRAd8qQet2GyDb6pcP227n9tEOIrjeEVCt6ltqHS57/bipZ3WknhkTMuiyilR
 38HONreQ29toZY7MJMd9t7GjpyrHvLNYWq6ZFL1xH/ivQYD5qATAO2aQL2Ssc72swfuhd+xI/hD
 V7nW7XH9rFmPEmeDjjsKVvyT8wArLfbwUjnfUIeBpmEc31pGT3mzjWH6DFMV67XorNLMPrLAHJ3
 wbtPtV47bIRehsehXy3gxxW9SICysVI/5VkYEVyD7t76pKDoIKq1BK4nM5NCxrbw63uObAv98Vp
 wGZDjye7uTYBzWVXWJN4oF
X-Received: by 2002:a17:90b:5350:b0:38e:7a05:9c0a with SMTP id
 98e67ed59e1d1-38e7a05a1ccmr12725698a91.18.1784717205973; 
 Wed, 22 Jul 2026 03:46:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5350:b0:38e:7a05:9c0a with SMTP id
 98e67ed59e1d1-38e7a05a1ccmr12725663a91.18.1784717205486; 
 Wed, 22 Jul 2026 03:46:45 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm7581425c88.3.2026.07.22.03.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:46:44 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, badhrinath.s@oss.qualcomm.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 1/4] clk: qcom: Add initial Clock driver for ipq9650
Date: Wed, 22 Jul 2026 16:16:21 +0530
Message-Id: <20260722104624.3842833-2-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX+ap2MHQ6CVY+
 bdoNI1LMHQE8/uUKOweksT8yp7Il8q1fOkvCqt06RlVh1ALGEgsi7sFaXLGmC3JGZwO+GRAj/Wi
 XukNCRVPRTUeb4Mzvfs5STZqW2yTd1Mgtn6OQqJ+RoXCOaHis6X++TOQWYAkIdYtZa50DuAUBCb
 N1+Yb8RQBFpJpjeF82t/mpbHmugqotsC6PzOXpTXVhepHaFg7z0qPBew7hEFZWOP22WKcddaM1C
 BBJujAvz0ZPAe7gUMTgqL1AP1BPaSiIP6mKhuYTBhiO2q6hjDNlsoSZjLLuQ+7TwoVDDqSmlU9/
 XGSLCthcTBQF0U+hTVCoZFjXjB3hpSKNFyXbAj7AelCOSh0SKOuUACsm9a5CAb/NMRZPciB7d8x
 nEXZ5JHS6WKyJn0CWhN7Lnt+CJcLNkelfUjphZFCHJ6HUjdcRYSutrjUFOtvtb3dPZU0Qj/Rafd
 VS4W7ZoKXE2WPhjrxEQ==
X-Proofpoint-GUID: PefXuAOXsNu34qSLgaotgYFk5CQm0KMZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX816f2uKoIRAo
 blbt16m0EH2cKAMeWR6pN3p/ZC+cuD/qmjcAhETu7bAb2fgMGrrFduSgGnt8n2rDa4XfNBGfm7j
 t6ahHh1u3zrLgZHF9g1POJZfST0hFXE=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a609f97 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=DB69gxYeUc8pAmpVBpQA:9 a=mXSKdTlMQTHl_la7:21 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PefXuAOXsNu34qSLgaotgYFk5CQm0KMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220104
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZHfRG30I7SP
 arnWmALg7bUgrqZtd5qkHajWf8jFdGnY=; b=XB8efuHqxpl5MxWfAM63IMZSG1N
 9XxkZuSkLISGX4RiuwuR2603Y/afwgTF37zEvZWESHdiX+CESoflDnfvhlpBOxNn
 zZvqKb0vYM9Dbma4wc/Anf5gWJhdVRIbbJlUIBTKflaWQfhCqRI0E/G2gdJ6urwL
 e8utPS3kAmeChiL6AxhO5ib/5g/Mh8hqtCECuWG2KRpcHcv/F1ebCHOJBW+loqKP
 sNYPJEMKEEfE50zBjPGQCbHEAcmgsPOf4KQ+7miDppraEh5P8Ga6Dw3O19Qiy0aY
 Dmsnq8mSSo7aBsYQSu/K2YQQmv/w0ylfA1w7EzQ4cYIFF6jJEA3MrYbyifA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717206; x=1785322006; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZHfRG30I7SParnWmALg7bUgrqZtd5qkHajWf8jFdGnY=;
 b=DyUWiHu4YTMgfzHTcQy6WA79lW9EhLCj5l3ArekbLWy6+NMV05WSKJqI68q04DASoC
 EYlabZDO4kpCbIWW88l/1zHh2vuuq8ZmJWE9jQNVMdNOiQwII2T4B0uXbmSJthB4aD+D
 rnVsaE6zQLT3HrPg/85L9jWpVL5l3BbXhR2Vl5PpKAGebObOBul5UX4KoZqsiryv7yaF
 +rKdyKc6i2dUXbnLSQiO7rfdsBc2M592oYn0B0+G36qR1oYpGd9Ha9JaSVSKtAWuCzhn
 ILX9o6V3ra9Rhjh4JV5mz2ixojE6RsUwZc2GPDaMftSuaZgwRVhK1+DmuGwJvPlD/9tC
 dVUA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XB8efuHq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DyUWiHu4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XB8efuHq";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="DyUWiHu4"; 
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

Add initial set of clocks and resets for enabling U-Boot on ipq9650
based RDP platforms.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |  8 +++
 drivers/clk/qcom/Makefile        |  1 +
 drivers/clk/qcom/clock-ipq9650.c | 95 ++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0a2ce55aaa2f..82c56cf605a8 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Qualcomm IPQ9650 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_MILOS
 	bool "Qualcomm Milos GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b96d61b603e4..6cf069053743 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_IPQ9650) += clock-ipq9650.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/drivers/clk/qcom/clock-ipq9650.c b/drivers/clk/qcom/clock-ipq9650.c
new file mode 100644
index 000000000000..cdac71db4e1f
--- /dev/null
+++ b/drivers/clk/qcom/clock-ipq9650.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm ipq9650
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,ipq9650-gcc.h>
+#include <dt-bindings/reset/qcom,ipq9650-gcc.h>
+
+#include "clock-qcom.h"
+
+#define GCC_IM_SLEEP_CBCR			0x1834020u
+
+static ulong ipq9650_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_SE6_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     1, 2, 217, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		clk_rcg_set_rate_mnd(priv->base, priv->data->clks[clk->id].reg,
+				     5, 0, 0, CFG_CLK_SRC_GPLL2_MAIN, 16);
+		return rate;
+	}
+	return 0;
+}
+
+static const struct gate_clk ipq9650_clks[] = {
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
+	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK, 0x04004, BIT(0)),
+};
+
+static int ipq9650_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
+		return -EINVAL;
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map ipq9650_gcc_resets[] = {
+	[GCC_SDCC_BCR] = { 0x33000 },
+};
+
+static struct msm_clk_data ipq9650_gcc_data = {
+	.resets = ipq9650_gcc_resets,
+	.num_resets = ARRAY_SIZE(ipq9650_gcc_resets),
+	.clks = ipq9650_clks,
+	.num_clks = ARRAY_SIZE(ipq9650_clks),
+
+	.enable = ipq9650_enable,
+	.set_rate = ipq9650_set_rate,
+};
+
+static const struct udevice_id gcc_ipq9650_of_match[] = {
+	{
+		.compatible = "qcom,ipq9650-gcc",
+		.data = (ulong)&ipq9650_gcc_data,
+	},
+	{ }
+};
+
+static int ipq9650_clk_probe(struct udevice *dev)
+{
+	/* Enable the sleep clock needed for the MMC block reset */
+	writel(BIT(0), GCC_IM_SLEEP_CBCR);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gcc_ipq9650) = {
+	.name		= "gcc_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_ipq9650_of_match,
+	.probe		= ipq9650_clk_probe,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

