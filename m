Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01CCC77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 17:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5502082EB8;
	Wed,  2 Jul 2025 19:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+F3T1mP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3689982F35; Wed,  2 Jul 2025 19:14:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13AC782A76
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562G1Rcp024893
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 17:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IJbX6jMalUh
 TL1Njo3ZyqhYbeOmC+BvAIcsgug+JQxY=; b=d+F3T1mPAcOYCJjOFqHmioNUaJk
 XRT3vnlzImgTCk6MQBGQAA858m9uOOcIYiWC+kU5jMu97/CuhUbog2otMzbc+DLp
 SmYyxT9FzU+h/83BziFVVe9JFAMMR/M55d1xNunkkaUmqpTZgr+i/NnWYQOCW0Os
 27LRmULgk8gpRNT7rqu7cYMjKe4VtkV9QAxkqnTaI0VmjFjSM1V1IJ+AlyIFwf21
 G0YeqgFYkp0YaoK+zc/KbqL1LdAesl1u6wNAydXOpHDGqdH4an8UtykKPs1J60Ef
 GWtrj+gq3FAbpM9z1CbbBE3SSHYsp6UP1Lv/fXWO0iWOs6jyU5KTTUF+G9w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j80258qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:14:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-748f30d56d1so3634049b3a.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476443; x=1752081243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJbX6jMalUhTL1Njo3ZyqhYbeOmC+BvAIcsgug+JQxY=;
 b=O8En3tO9I91AfR/GCiBMTJt5GFav167KpjhWTf/u6H9apcODqdxBgqkhHoN81aum2+
 qA3j7YMcGHtCPDVL94WjHq6xmmBC5irvY0dGaCrUOKI9M1QigZ75ehllZw2mGS6FdCVt
 kmPeHQoOxAymMXuu4FNdtFtFFvVA+y17Att6wQFFX61UM65pIwavcTRkHHQ1N4OpsH2b
 T4V6BhRzkswB1mgGRTfokJ30qbOqoixC7fY08IhNqDOcWXbP+lq5DjhHnXDAkhMdVYjI
 LYGmuq71r81G/9moFPJATRzdjpw9Bim/g6hK2Vmgfb2dZWlxmExhuupjhqQs2NnolPyx
 6DDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGiLjQlx3Xe5XvYGxF5IfS3HqPWZ8MNA/AF+nvvYDtzVtQtxbz5YM1JfwrerykDe+aXvB6Jks=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5/mZxHrjni9qNF8Dj9iMi9+fVpNe7PppIxlzszvK1RUku48Cq
 Cb44Ck3o6fLSLqbKympx39U2sXyuNthKDMn40Tt1HBYj1oR+RpUQ7KySrdfT6iEFEpaJYOs0vH7
 yqC3BzjzBU1vwSFAQ4rHDC497MVpiSnE7yUz5d1BNhYilz9RjgoSNV4Ly
X-Gm-Gg: ASbGncuqVyLMQmJxSrzUeYxVmkF8ut5a9V1GFbbShhijWRb6cdlzO2zCF5MU1EFwPET
 D4s5oo5ZYYBtLDOd+olzu+qMjOLdmAHF9HNv8Mg8MO5N6b7u1gQX6vaNhR4U+oUfaOwL1z1qzq2
 7UiGYPgiB6FyoqhBigSQwQvPVQsw7Yl2Yr+tvq9bn/GxgO6ggFiMcDlmAYGIwS8LiV/QOkbLq3A
 SMxmOfQ+XG2ofTDB4kGAz9Eb5T7OXrJmJYW7/5RbJ6GtNfQ3nU1+jW/SXulcnaOagx75pMdIyuM
 xin2h3uieMYVMHByVPZiofT+LMhZt2xN4129zWjh9bbpQrXisXy+olXIkeqMqauK2w3elcRpX5R
 0CUywZLnXzmYAUKR/ZKCirrhcyuukD+i87BazbcxzZA==
X-Received: by 2002:a05:6a00:c96:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-74b50f9e78fmr4835595b3a.24.1751476443462; 
 Wed, 02 Jul 2025 10:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOQR/0iLnS0qhlFp9fiY5dEBEyRQYPqD/1JqmTFZyg2q5TREi97+FkRo/8ldTEbrIdYJM8g==
X-Received: by 2002:a05:6a00:c96:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-74b50f9e78fmr4835566b3a.24.1751476443082; 
 Wed, 02 Jul 2025 10:14:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5837sm15144873b3a.116.2025.07.02.10.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:14:02 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 4/4] configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN
 config
Date: Wed,  2 Jul 2025 22:43:35 +0530
Message-Id: <20250702171335.1811080-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
References: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sSqBsG4BSShfLXRkKJ9Xx9OmkyNDF-Vt
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=686568dc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vgDa02g56znhz43FR6YA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: sSqBsG4BSShfLXRkKJ9Xx9OmkyNDF-Vt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfX3yTZb3gvcYah
 hn4omLRsHpWeWXO+u7Ou4u3fhYeki3aYLjxHib/Okf9zjhvCs1m7h/lkc9E/PB8miZNojuSPIQL
 PLwtvcIoM5I7KvAJbpAINwU5WPy0rpP5osWJnwOwzuo6fvo85/lojD42l0Ls8qdspI3B5mlWeNq
 meY9T8hmdRGkbkDwKIuKoDWnmVfq5/bwqPIpyBOXUcoNPo25pp97Qch+VMS2oJvxOGLCEVYYilJ
 bPSyZgP0xbtCFR+0pVZpbRdqmqRoLHAXU6VgT4iiZ4hMOCNWOo7EputtpaQVkCVXdau/rZzeYYI
 ckvJeoV0ZqEXpOaVsA1CYh/0h41im0gUmp/Tp/LDBDXBsiLZBYxXgx/sz+eAsi9nW4gMVkHq8jx
 49tpDAtAUuo5FMcodahko4gI783t9ncD84OO4+xdD+8hVsf6m6I+mYxWzLCKpYAyX1uM2q+G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=883 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020141
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

Enable QCOM_POWER_DOMAIN & OF_LIVE_SA8775P config for qcs9100

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig    | 1 +
 configs/qcs9100_defconfig | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..f7780c06454 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -123,6 +123,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d25398..19bc1cab0e3 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -11,6 +11,8 @@ CONFIG_DEBUG_UART_BASE=0xA8C000
 CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=14745600
 
+CONFIG_OF_LIVE_SA8775P=y
+
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
-- 
2.34.1

