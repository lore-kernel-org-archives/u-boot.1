Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C11D2503B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE3583B0B;
	Mon, 12 Jan 2026 08:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOwU0RV8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GcD01hrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41C883B72; Mon, 12 Jan 2026 08:02:34 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0829839A8
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60BMvWYX202098
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 07:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=g/v3kNeUR4rIQEzpl9shYNdHXl+PIeEHOLF
 chOJJllQ=; b=eOwU0RV8cIlD9v1/aRXGaOjxxW2jidl8V4nVJsKwzgdtlFdN3es
 A65mNQxXl/NdD4ko4ErVgUVH7arLZN+Iiz1PbncpX4vhBQ3Uef9f4wUBv2A9MELR
 kNQwzXH8GibXTQp+DqvBns6h9DHbUFVlCN2OMPjI3ZDM/7/teofCdjiYuW1oGR74
 VN/8ET1ZLIE8nuS9rMYVPFFcyhls8ch1yb6trmbonHn7nTZ8UDg9LtzBmrzJMGh/
 Oywojv2BBAYAH0FhyCbfyQgpuOXW2Y64wqB6K7H99jEfbd3LlLKDPnzkEpUGhe5+
 Grr55S6gCKIU7gUYyUNY/h7hrpWe0SizfeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bm8kysx4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 07:02:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7dd05696910so4580736b3a.2
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768201345; x=1768806145; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g/v3kNeUR4rIQEzpl9shYNdHXl+PIeEHOLFchOJJllQ=;
 b=GcD01hrTSIqqW37yzlgkY13FAF+SN15WrjwOgZomovkTFJZGxOOYRE8ODTfn/9LxaM
 SPOcSoPE9Hh0h4Ii3t1LnF01WgNYFl+4orf92a2qTG3E4kJHveifZAP3k+t7CBD+QScT
 h/x9LqzEXkmUhXXP/2J57Xpuc5Sb+tY4K+E+5t5pyavaOoCRv1CmcvIrVnLVZbwrP351
 hFuyAFLDzHQFcbQS00MTXjt+eJa8IEV2fcMUcZoQHdOrQtlSasnIc8pBjsw9dD/E3pGL
 t5kuuiD0C6hS36uTGD3K2J/RXsYRSCUaxpJlD95yoja6zlMu8W15k9FymMx/m6lMRRWU
 sZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768201345; x=1768806145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/v3kNeUR4rIQEzpl9shYNdHXl+PIeEHOLFchOJJllQ=;
 b=xPovaKA1dHzfDunyQ74BfzDgvvoUa1ZTZRn0uXnpHlBQxRGy68NsVT6xkxG+/Z8+UT
 QNJtRkOCqTno/QLPRXq7s0Fo9y9MdWaaCKuNKfALhCkSrgIA88Z3tL+1RTZHHLDdqKl5
 mlPHtRlGwIC8/MF7tkqgMxAHBww7gynuxKvdF8S1iAl1fPpi1tks6IkmGvvxMlEXeKYc
 Kp6NNunpwO0RZLcgQC+jERqPojV7dQ0cB992x0ybkRpmWt6QKlRgCx6Lv6S3IAeUTIwN
 9+RuXLpYmNuKh2Ef81YzmcrvJEVIkhpSkevVjgyqEDk4JBmXRfboA9F5hL5/AyGrCLbJ
 5kaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfmMbIBR70+PL/rWwH+CrJzpoHPar3LlUVRonzUshYbqCkuetxn0I8/MxTWy761aL1KWTfCHM=@lists.denx.de
X-Gm-Message-State: AOJu0YylJpia1EZGtz8nIlXbmM13uhp+kvoFUhWKH9YLCtjTIA9Ugd7P
 OdY4mKkqT+aictK4kMmipzC/DdQO9mRMHWk7f695bMugNNiUKsasOpPMQaOlklNhyYFHsvaqrEF
 Vle1pHDBYM6yajdh1PIcj3R9MXi1VrC04Wv/lBv3TH4jops7Se+DXQtTr
X-Gm-Gg: AY/fxX5rDrnGi5wwS+qjtkm13G1FDxzDyNBbHmclUH1155fiBZN8ews3139/cf+wHiQ
 YHYTgPym5k/OFI79shNQyOYhSy4tWs6vrGibSz+LDotn/NMrkV2Y7FetnRw+Im7jXQLsVQgoH03
 +Abwxw2qb66diHTvQboIS0HOXwZr2g/AuQVklvyiaKbeMS5hgPrNihqaxbCqwNQYX3qHEImDHao
 qubQoaAJYwOpnGRdbColoLcQBXntLW+WmhIsfaj74YAJR8jeMLh1kSE3eV5gzqnnbmnCKQkhqFb
 camRN4t7OvIOO8pRd6N5ki9SVzHmU/p6pqYY0glnFqTHGaVJ9QfQS8xNmkIJWaoWgcd5B5maHyI
 GpVYL0nwmAvYKaznf1z9d3dVoaW3Wq9Zn3UjattAyk5W/IjyG/wDrTXOiAsHqO3lkAZNHrp1hRg
 JPlhufWtlMMklckk4+5uEm+uUv+qmCNJz8Ai5mVw==
X-Received: by 2002:a05:6a00:4c89:b0:7fb:f87d:a0aa with SMTP id
 d2e1a72fcca58-81b80ac5726mr13312266b3a.52.1768201345166; 
 Sun, 11 Jan 2026 23:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbRTdXd9VYLKBpuHt3Vdu695V2BsB5XGLy3hQiku9gH/4Ozv7hea8r4Z0TuGhsyKqv5Yef5A==
X-Received: by 2002:a05:6a00:4c89:b0:7fb:f87d:a0aa with SMTP id
 d2e1a72fcca58-81b80ac5726mr13312247b3a.52.1768201344677; 
 Sun, 11 Jan 2026 23:02:24 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f4049dfc5sm5217325b3a.51.2026.01.11.23.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 23:02:24 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] configs: qcm6490,
 qcs615: Enable PSCI-based system reset support
Date: Mon, 12 Jan 2026 12:32:19 +0530
Message-Id: <20260112070219.2193004-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qjwtSsWw_j9MlyxHO51w3IadVLTKWQZt
X-Authority-Analysis: v=2.4 cv=ZuDg6t7G c=1 sm=1 tr=0 ts=69649c82 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=1nkCH7ab_aS42RC2sOcA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qjwtSsWw_j9MlyxHO51w3IadVLTKWQZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1MyBTYWx0ZWRfXxQf+x7J0XYM0
 mzbDzMXLmjHf73f+0lnjRzPjjn+SzmrK8bEWRz10gPPtR4TUJpQmAzTQv3FQ5Nhpx2z76VtdYK+
 vRZgZUXsttmkGfTE03MT+8AiAST4WbmjIh6gnXfpV6VcuRuH6TVngKEmhRxjD5dFX8xEnnVrrRE
 QuoyoDoM9YBIDmKkzdkIYzeGN32PVx2E8lN7PHeo/P9LlCcd7VB+62K8HiYjA+QYDzFWvqhGCiT
 MwQGKbGPCk+DT7ASPvj1q1Kfn+WlE+WBwn3544YqGqbMzGMCnZccxYURfYRD1HmPDO35/sOzqpI
 12PLUXccUa+jvQUk/1+ZAN2uV3xhm2jHbg9rdu0lWiscHLHLWSg5HlMCcytbl+KZ4XeN7NgwM5Z
 7Q6uuXsZ3cpYij7fgPpYAs+nv0FN2xvhhHuS8ETAvVHDGfbbCTvFA2q3avuzF20tm5dJ+5q9v+H
 lGqcUHXetOSO01CTcHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120053
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Enable CONFIG_SYSRESET and CONFIG_SYSRESET_QCOM_PSCI for qcm6490 and
qcs615 platforms to support system reset functionality through PSCI
(Power State Coordination Interface). This allows proper system reset
operations on these Qualcomm platforms.

This patch is based on the already submitted patch:
https://lore.kernel.org/u-boot/20250613051957.3159564-4-quic_varada@quicinc.com/

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig     | 3 +++
 configs/qcom_qcs615_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..8d70ae8cede 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,6 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_QCOM_PSCI=y
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 2468267b955..7a8f231aabc 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -20,3 +20,6 @@ CONFIG_REMAKE_ELF=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
+
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_QCOM_PSCI=y
-- 
2.34.1

