Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3189C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 891154073D;
	Wed, 22 Jul 2026 07:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ELbrhBsPaGVN; Wed, 22 Jul 2026 07:43:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 226C440769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706205;
	bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pUSxl+4n6XQHGgxSNiptczdtefTYWASbQq4qkYjrAPoIw+Kns0iotoMQGo/Vm7uzH
	 ZAPqhIh9xkh3hxtijlV9DfOFpHQSiebtnjIEXiz4xK2/bR33FXaIhUj0q4B2o8Uimt
	 yLulQAn1ERHfsggDGAY12IGbZcg8xV2hSzMHWAHNXpTPjar+iCy3IqqITyVevuJkvN
	 sknBYiTESwMacBLRDz4ormuO8COHO4qs1L/OInkZPNV1gHNkl+O2qrz5AvCp4QYsbI
	 LXwBGTjCyn8eQdI/g790YjPImrj3Cr0hAcDe0qZEVQT0fMlAcGh355Mqe8QdCm1RtM
	 cfradvMvRl5jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 226C440769;
	Wed, 22 Jul 2026 07:43:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2BB8DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98CA760739
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqCuIfp_pZHL for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D7FF60740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D7FF60740
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7FF60740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53bcI3662182
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:21 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2usj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso16982301a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706201; x=1785311001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=MuFLdTG60jCvtOReudo8nOW+TXuXH4iXWQAiLJH7UoYL0vdAi2kfVXiEnCAaOV4kTz
 3ARJu7lq0btJBWMD5Ltcee5VHQnchfu9GuCsEQbiQ77U79fsCBpnOTb7jJvl0clwIGIx
 qSkXoRBkkcslHguXGYct7Op7FWX9rSJJmrUac2GHFqQ5t5S377Ix9+zC6fb0iDMSQxi3
 El+LUlmcz07680J7n5a6XirM4+LgYM7CiDBKxR3j5d5YXkkejzxfHBDy4QtW0xle/w7q
 xar+0niB/Gt0tMhg0PGaleOZCnVABB3CrFyZXQtb+AfwBbhOpeOwVA/GBgCk7MTZxzcM
 8UtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZPofU6I55yuTG6DJYIRrQoV+r3LYydKnSexq4S9H3TwXauyuEeMi64WTjNg/a08L3vvMPTGU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwPu4A+KiQ92YEjCMSj1xFEIxkJ6clSbuEOZQtjO7haqGvW+706
 PJy+vXW/pQY8PC/fRT93xrJnlwwAp+VIAKukqGvkw0/FySaNY7MjC0BEhHfotYRq88+aC/w6Whi
 MDm4FI2UrkHhpETlGV/L7cjIcSKNT+iciHUxEDWYyXqb1kgYtilkFcsG+FFI7770ncRIh+lc=
X-Gm-Gg: AR+sD13UuocvYHqTwTpbra2SDSG7cv4jn0CTR4vRb+j1MJHUZ3Ao4/ABaqiBaw2RC3/
 H8k9s9bHpPXKDWaF6QIxKUamULKgm7wdMSkJpz5UAqseYr9co5fU/T90oo29R6SmeDb1tSNOZbh
 JPhb5p/FuEg7YosTTh8yZ8DXCN3VPINJBTenK3VN+/AD8R9NlDVasYWuE75f+3PqYVC9kR1JKgQ
 KE0v7u0KhJ+OYMHGVYgkc23Oj1bGTyPtDTSDhhrA+qXqyyRqj6wqPWU/ZGiIQp6TDUZGh4V8f3l
 21HKkNmpaYtGK9h27ThVsPXx0ruV+z5LYuFAtwaMDkI3fCxe1eIhxEiTWA3WXUvgxa4vgICmSFX
 xhOzrmDFqAm6qXNicN6TDYuQA4LEmTy7ZDfxQLPKeZPsdgpmIEh42NAPdwgCSZXa3VqIPNdih8W
 miXLTdKWTQU+cRIhLTaYMy1Qyr9JjS1Q==
X-Received: by 2002:a05:6a21:1506:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c3ad95b5fcmr24218276637.47.1784706200955; 
 Wed, 22 Jul 2026 00:43:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:1506:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c3ad95b5fcmr24218248637.47.1784706200460; 
 Wed, 22 Jul 2026 00:43:20 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:20 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:23 +0530
Subject: [PATCH v8 12/15] pinctrl: qcom: Add ipq5210 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-12-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FxXrW13nfS9Wm2rAawUeV6uUlaYZZd--
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a607499 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NzvCGKM8m0lGn9t9IsgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: FxXrW13nfS9Wm2rAawUeV6uUlaYZZd--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX0YLF5OhLW6VF
 YHVumSj75wbjBUi4bwaqsrrZKj7jNXMa0I2Y4Vnqe1BOki/3dpjS/JoEBYHILuzfBMfaMjklsnz
 yRbTVKAOvmBPJM12dr2QBYxuFKXF2/Mf3hEaOTJOW/ZpQKK1Qq1ymQ/x+ZPz2b2NIKjStWJHe02
 /H77vmIev7SoFrkBRaw/osWDlClpJuAtqZKY3XGVOo9IAs+Ow5Qq2U3RaNd2pmWjkoSJ2qfUzjI
 W4dX0DLwrjga2C/jdiKE8aNQlkwLhCeYIkQGuJdNvB9ZpxD5MHfs/U1yKv9k2sq7LLMq9x7Fxyk
 ihWaorNWkzu9OYYkzf79dXneFw4te0afI3G3qV8NWZNPKOqi2FmQWHQRATtacqTe7YIZsb9WsQj
 sCHlBVmHP1ITEPq9CDYiB527U7mt1Z3I08ZkD3Hgs0KAsJK5uwk89RyIPM6zynbVOFMjOmFrJF/
 ZTY5H2l0uuLz83WDVRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX7K9QdyigPB8v
 FCL70X3qDj2GfTh5Uv4VB1w2kbX+n1qbEjsPjk+/inmrdyUkFyvy6mih8yiVRhv5Dey6lCVnzHM
 QrI64V5AH4PaRSaROi8SBqivqr84/X4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=; b=OKP/XXcrbipQpQRS
 o1hOGTUEObHl48nCK7tJiZZgwC6VByZBthrmZMJp+Mdn4Jlp2Kv+uIweznejHXyp
 qxsD78AiJGIbd0DQ0bJ80hn6hbGosKZoUgx05a2XB9NqLWeFBwMlXBNhwFtVxIpP
 Icq0D/MPuEEHufjh4KUsqFFMLMtLR33nDUjGQLYoZoTw7Yj2NKwm1F2OntHJinJA
 aWPSNvNvjdsuWzI3k/m6jBHo2PuN+cRfZQEMwIWKKYiUr9b72gHv2b/Fd+pCXVg8
 B9SVrJm9q/kQo2i+VVpXSSOXkJvt8Db47No2cgh3AKftWU/fD0ob3pR939uc3vD+
 eNM+qQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706201; x=1785311001;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=YmrduZkj5KHrKDWTu2kCMP/sZ4ym2kD3Io/l3xxl7GZhVTFOEyxpHnxCTtl4hLCvFz
 PMSJq22kQkQbu9nHb23Qd2WeiNu43RLj3PCm4pJLp+2xMUiDpzm3IaEmeb5C92CZQAY+
 VxO2AGYUS3HtJd8dK81Mcq/FFlHx265lJWGwfWtXA4J4tLw3SlDycVt/cqT+X8mg/do9
 TYAdPtfKIDLYaGwMldYCI8K92ENhSer3OOQegIQ8O3mvKAQDE6ZmrIou83I75FCQOugQ
 I1S7dSIA66elPs8rt53MuD2Ob7XkFtm9vh3FolwejIXjPphBo+iI7RA0KRcvrP776M0K
 40yw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OKP/XXcr; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YmrduZkj
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add pinctrl driver for the TLMM block found in the ipq5210 SoC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c | 349 +++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..dbb51cd7fe6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -38,6 +38,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ5210 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..9fe32fb8fec 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ5210) += pinctrl-ipq5210.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5210.c b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
new file mode 100644
index 00000000000..a9b435ad543
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm IPQ5210 pinctrl
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
+enum ipq5210_functions {
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri,
+	msm_mux_audio_pri_mclk_out0,
+	msm_mux_audio_pri_mclk_in0,
+	msm_mux_audio_pri_mclk_out1,
+	msm_mux_audio_pri_mclk_in1,
+	msm_mux_audio_pri_mclk_out2,
+	msm_mux_audio_pri_mclk_in2,
+	msm_mux_audio_pri_mclk_out3,
+	msm_mux_audio_pri_mclk_in3,
+	msm_mux_audio_sec,
+	msm_mux_audio_sec_mclk_out0,
+	msm_mux_audio_sec_mclk_in0,
+	msm_mux_audio_sec_mclk_out1,
+	msm_mux_audio_sec_mclk_in1,
+	msm_mux_audio_sec_mclk_out2,
+	msm_mux_audio_sec_mclk_in2,
+	msm_mux_audio_sec_mclk_out3,
+	msm_mux_audio_sec_mclk_in3,
+	msm_mux_core_voltage_0,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cri_trng2,
+	msm_mux_cri_trng3,
+	msm_mux_dbg_out_clk,
+	msm_mux_dg_out,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_led0,
+	msm_mux_led1,
+	msm_mux_led2,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdc_slv2,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_mdio_slv2,
+	msm_mux_mux_tod_out,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pll_test,
+	msm_mux_pon_active_led,
+	msm_mux_pon_mux_sel,
+	msm_mux_pon_rx,
+	msm_mux_pon_rx_los,
+	msm_mux_pon_tx,
+	msm_mux_pon_tx_burst,
+	msm_mux_pon_tx_dis,
+	msm_mux_pon_tx_fault,
+	msm_mux_pon_tx_sd,
+	msm_mux_gpn_rx_los,
+	msm_mux_gpn_tx_burst,
+	msm_mux_gpn_tx_dis,
+	msm_mux_gpn_tx_fault,
+	msm_mux_gpn_tx_sd,
+	msm_mux_pps,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
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
+	msm_mux_qrng_rosc0,
+	msm_mux_qrng_rosc1,
+	msm_mux_qrng_rosc2,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs_n,
+	msm_mux_qup_se0,
+	msm_mux_qup_se1,
+	msm_mux_qup_se2,
+	msm_mux_qup_se3,
+	msm_mux_qup_se4,
+	msm_mux_qup_se5,
+	msm_mux_qup_se5_l1,
+	msm_mux_resout,
+	msm_mux_rx_los0,
+	msm_mux_rx_los1,
+	msm_mux_rx_los2,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out3),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in3),
+	MSM_PIN_FUNCTION(audio_sec),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out3),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in3),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(cri_trng2),
+	MSM_PIN_FUNCTION(cri_trng3),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(dg_out),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(led0),
+	MSM_PIN_FUNCTION(led1),
+	MSM_PIN_FUNCTION(led2),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdc_slv2),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(mdio_slv2),
+	MSM_PIN_FUNCTION(mux_tod_out),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pon_active_led),
+	MSM_PIN_FUNCTION(pon_mux_sel),
+	MSM_PIN_FUNCTION(pon_rx),
+	MSM_PIN_FUNCTION(pon_rx_los),
+	MSM_PIN_FUNCTION(pon_tx),
+	MSM_PIN_FUNCTION(pon_tx_burst),
+	MSM_PIN_FUNCTION(pon_tx_dis),
+	MSM_PIN_FUNCTION(pon_tx_fault),
+	MSM_PIN_FUNCTION(pon_tx_sd),
+	MSM_PIN_FUNCTION(gpn_rx_los),
+	MSM_PIN_FUNCTION(gpn_tx_burst),
+	MSM_PIN_FUNCTION(gpn_tx_dis),
+	MSM_PIN_FUNCTION(gpn_tx_fault),
+	MSM_PIN_FUNCTION(gpn_tx_sd),
+	MSM_PIN_FUNCTION(pps),
+	MSM_PIN_FUNCTION(pwm0),
+	MSM_PIN_FUNCTION(pwm1),
+	MSM_PIN_FUNCTION(pwm2),
+	MSM_PIN_FUNCTION(pwm3),
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
+	MSM_PIN_FUNCTION(qrng_rosc0),
+	MSM_PIN_FUNCTION(qrng_rosc1),
+	MSM_PIN_FUNCTION(qrng_rosc2),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs_n),
+	MSM_PIN_FUNCTION(qup_se0),
+	MSM_PIN_FUNCTION(qup_se1),
+	MSM_PIN_FUNCTION(qup_se2),
+	MSM_PIN_FUNCTION(qup_se3),
+	MSM_PIN_FUNCTION(qup_se4),
+	MSM_PIN_FUNCTION(qup_se5),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los0),
+	MSM_PIN_FUNCTION(rx_los1),
+	MSM_PIN_FUNCTION(rx_los2),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
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
+static const msm_pin_function ipq5210_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(1, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(2, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(3, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(4, sdc_cmd, qspi_cs_n, _, _, _, _, _, _, _),
+	PINGROUP(5, sdc_clk, qspi_clk, _, _, _, _, _, _, _),
+	PINGROUP(6, qup_se0, led0, pwm1, _, cri_trng0, qdss_tracedata_a, _, _, _),
+	PINGROUP(7, qup_se0, led1, pwm1, _, cri_trng1, qdss_tracedata_a, _, _, _),
+	PINGROUP(8, qup_se0, pwm1, audio_pri_mclk_out2, audio_pri_mclk_in2, _, cri_trng2, qdss_tracedata_a, _, _),
+	PINGROUP(9, qup_se0, led2, pwm1, _, cri_trng3, qdss_tracedata_a, _, _, _),
+	PINGROUP(10, pon_rx_los, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(11, pon_active_led, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(12, pon_tx_dis, qup_se2, pwm0, audio_pri_mclk_out0, audio_pri_mclk_in0, _, qrng_rosc0, qdss_tracedata_a, _),
+	PINGROUP(13, gpn_tx_dis, qup_se2, pwm0, audio_pri_mclk_out3, audio_pri_mclk_in3, _, qrng_rosc1, qdss_tracedata_a, _),
+	PINGROUP(14, pon_tx_burst, qup_se0, _, qrng_rosc2, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(15, pon_tx, qup_se0, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(16, pon_tx_sd, audio_sec_mclk_out1, audio_sec_mclk_in1, qdss_cti_trig_out_b0, _, _, _, _, _),
+	PINGROUP(17, pon_tx_fault, audio_sec_mclk_out0, audio_sec_mclk_in0, _, _, _, _, _, _),
+	PINGROUP(18, pps, pll_test, _, _, _, _, _, _, _),
+	PINGROUP(19, mux_tod_out, audio_pri_mclk_out1, audio_pri_mclk_in1, _, _, _, _, _, _),
+	PINGROUP(20, qup_se2, mdc_slv1, tsens_max, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(21, qup_se2, mdio_slv1, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(22, core_voltage_0, qup_se3, pwm3, _, _, _, _, _, _),
+	PINGROUP(23, led0, qup_se3, dbg_out_clk, qdss_traceclk_a, _, _, _, _, _),
+	PINGROUP(24, _, _, _, _, _, _, _, _, _),
+	PINGROUP(25, _, _, _, _, _, _, _, _, _),
+	PINGROUP(26, mdc_mst, led2, _, qdss_tracectl_a, _, _, _, _, _),
+	PINGROUP(27, mdio_mst, led1, _, _, _, _, _, _, _),
+	PINGROUP(28, pcie1_clk_req_n, qup_se1, _, _, qdss_cti_trig_out_a0, _, _, _, _),
+	PINGROUP(29, _, _, _, _, _, _, _, _, _),
+	PINGROUP(30, pcie1_wake, qup_se1, _, _, qdss_cti_trig_in_a0, _, _, _, _),
+	PINGROUP(31, pcie0_clk_req_n, mdc_slv0, _, qdss_cti_trig_out_a1, _, _, _, _, _),
+	PINGROUP(32, _, _, _, _, _, _, _, _, _),
+	PINGROUP(33, pcie0_wake, mdio_slv0, qdss_cti_trig_in_a1, _, _, _, _, _, _),
+	PINGROUP(34, audio_pri, atest_char_status0, qdss_cti_trig_in_b0, _, _, _, _, _, _),
+	PINGROUP(35, audio_pri, rx_los2, atest_char_status1, qdss_cti_trig_out_b1, _, _, _, _, _),
+	PINGROUP(36, audio_pri, _, rx_los1, atest_char_status2, _, _, _, _, _),
+	PINGROUP(37, audio_pri, rx_los0, atest_char_status3, _, qdss_cti_trig_in_b1, _, _, _, _),
+	PINGROUP(38, qup_se1, led2, gcc_plltest_bypassnl, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(39, qup_se1, led1, led0, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(40, qup_se4, rx_los2, audio_sec, gcc_plltest_resetn, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(41, qup_se4, rx_los1, audio_sec, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(42, qup_se4, rx_los0, audio_sec, atest_tic_en, _, _, _, _, _),
+	PINGROUP(43, qup_se4, audio_sec, _, _, _, _, _, _, _),
+	PINGROUP(44, resout, _, _, _, _, _, _, _, _),
+	PINGROUP(45, pon_mux_sel, _, _, _, _, _, _, _, _),
+	PINGROUP(46, dg_out, atest_char_start, _, _, _, _, _, _, _),
+	PINGROUP(47, gpn_rx_los, mdc_slv2, qup_se5, _, _, _, _, _, _),
+	PINGROUP(48, pon_rx, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(49, gpn_tx_fault, mdio_slv2, qup_se5, audio_sec_mclk_out2, audio_sec_mclk_in2, _, _, _, _),
+	PINGROUP(50, gpn_tx_sd, qup_se5, audio_sec_mclk_out3, audio_sec_mclk_in3, _, _, _, _, _),
+	PINGROUP(51, gpn_tx_burst, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(52, qup_se2, qup_se5, qup_se4, qup_se5_l1, _, _, _, _, _),
+	PINGROUP(53, qup_se2, qup_se4, qup_se5_l1, _, _, _, _, _, _),
+};
+
+static const char *ipq5210_get_function_name(struct udevice *dev, uint selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq5210_get_pin_name(struct udevice *dev, uint selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq5210_get_function_mux(unsigned int pin, uint selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq5210_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq5210_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54, /* There are no special pins */
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq5210_get_function_name,
+	.get_function_mux = ipq5210_get_function_mux,
+	.get_pin_name = ipq5210_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq5210-tlmm", .data = (ulong)&ipq5210_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq5210) = {
+	.name		= "pinctrl_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

