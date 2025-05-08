Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B94DC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED6082A5E;
	Thu,  8 May 2025 14:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vn6Er0s/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6928283E; Thu,  8 May 2025 13:36:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595ED82153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5488lOo4019182
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iu4TWgGG12iEZHyNBDc4s/R12P46i8zrrY8
 zf/Xdpqc=; b=Vn6Er0s/Ub2/XCql8erZN22xxmpY/AEDlLhnkVumHhz3wmCQQzX
 kAKHruaYbGi9vCB5enOQdhwfSgp1isY9fKGcihAWX/k7wejDkS96JRBXtNFHTqHi
 VNARqAuIs1hk4kRo101PWzF396n/7FPwmquJv7ToPiYuu2NM/CrxbEW70/MIlirz
 HubJoNl9iZ7/I8JRzJs33cZrQkqxLFROw3mmbom9VTS8QHS00yv4bmbBhr+lnYEb
 NJR12XqwKYkflJ6L6G4LvzInDNrQnI5xMiT6fIjeMbJmtX2qfDFSNlq+Qr4csPwt
 jvPjrbe86AQCkF2IXZpkv2Yin82QHahsThw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gsdj0gv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:36:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-30c14d46b55so1056533a91.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746704213; x=1747309013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iu4TWgGG12iEZHyNBDc4s/R12P46i8zrrY8zf/Xdpqc=;
 b=Rn+FfBh/ePBq98PuxlU9FX9OMU/Tanb0lfF5Zq0Vv71WIIpo7046RvQAe+MjkoyNG4
 3K2EHCXAQyegsOr/6+7AXFHsMEvYtIBKSLDxeSXOaPiBU3HfdrwXz1jbeHi22ZepWW+r
 5J1u9EyIp5gOK623gD0cUWnuOn1a8yNZnB5C1uVHhxqDHsZ6k70TNSwTt5CfYxxtgqCm
 NG7Lft3+1dVvY/Xlyb6bKNGbDegvyH6F9ebY6gqbg8F5xZKnPC+x4wKClOF5q6EPx+Rq
 KkSgMOef340qYjeXrd6n8GPoLq44vUDk0Moya84Y9vXFc68puwi3CBmbVEb9QH0XYBJq
 g+sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEcek1FKKcvKyLSm+ZrJgs9SfC51BDYvurB0FNwXtbsL4wOXuHf59v1ApUK+RUUXM9rE4BFBs=@lists.denx.de
X-Gm-Message-State: AOJu0YxQ5EaO5OWi7m9SfUVUoSpcgauyrN61wd0SQ02MIHJfd/SGIKVd
 UsMTGaBggFZf8kLCR7nfEomyL2qRGmVXk8hpuLOhFRwWKpVXqPZrVmI1j90O7Daiz9rXiIB7wNS
 SzHPmW5kpq1/qGf3j/tYq9Jp90akO+7mMckWaZJFALGwp4O3gKA0P
X-Gm-Gg: ASbGncvKfWS2dq5A35FiFfce7lcpra/Q4qTYOho8TOpDVJXTa7WkeckLkWt2wgX9QLS
 VhhqHM/PPSMrPP20eAv93nRkSWG17g7aDM2pk1pIsqx1gm6bMPK+ioe+jBnVPqihm5QfzFUVNbH
 gH6YSmSCqt6NF6kXrkzyb/GLSWLriwtRSKHxKPH2HNTMa90dP05OxbT7sIC8lRwExzA2WZweRXP
 Bd0ZRkSiKGySS9SYkX4pUp0tvjMrfTJh7jNcOkZeU9USOq03qzLwfveR0NgBK0KNhXhEJV2YjiD
 W73Lgb3oWsrRgmAGvu0kyw9coO5mKNEK2J7mVYsj4nRAHc/wLLsqHI7iextZNQNRvWG3mTGj8yU
 BxjlOl1KHzsw8nsFiQZWv1Ft/b6gaix4=
X-Received: by 2002:a17:90b:1c01:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-30b3a667767mr4416723a91.15.1746704213625; 
 Thu, 08 May 2025 04:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqtEcnRJXeOBT7p900qWPGI898gqV022TCzMVtv+uPN+2eGFspTf9WVab1vRViCfDhznHm6w==
X-Received: by 2002:a17:90b:1c01:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-30b3a667767mr4416687a91.15.1746704213176; 
 Thu, 08 May 2025 04:36:53 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d52f15sm1978129a91.24.2025.05.08.04.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:36:52 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] gpio: msm_gpio: return correct value for gpio read
Date: Thu,  8 May 2025 17:06:46 +0530
Message-Id: <20250508113646.1462518-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMAP+eqC c=1 sm=1 tr=0 ts=681c9756 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=EwatljUV73X555SnQDYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NiBTYWx0ZWRfXw+qVVJwZpn9C
 18wu+NS+9g/rasSUQWPBRryzi/wuhAAuznpcYKD6OpGC+jqhFGJv4l0Eyhq306+xs3B6CKRo4qr
 NB9FpzTiGk6lvBfW6JK9li6fQMn+rF21nln3L3tOkYIl5Jriuxw/clM3Ccm5oylR5v7LE0BWR5J
 Esb6JiNs6fwTkVIdXVjYmUW3zi0tfv67s7K5aVvVBxrhAGfQGMnSBHkAabqbPchvV2aTfTrGmo7
 k6reXiT9Cg2RHK2A/GFKT+rpd6Cla+a7PN3IFxfZl3qLSdBJHLCzbQ7653FR414M1er3iiXPade
 7eoqdlRkcnRy7kocbzRupTk2uvLqaqjxJjJvLzZ2lKRMl2GLRTdiSc7Ob3jGVxKLvNHHYVYppyc
 JHKVICsIf+EVenQGVlCxSH6XXt+AcFII+cCRPy5gjpKQYZJ+sSvsYGCpNtufMDo2F4f3SzQl
X-Proofpoint-GUID: 2Bq91EdsmB1KJDVkJ84lsSCWsTH2x0dk
X-Proofpoint-ORIG-GUID: 2Bq91EdsmB1KJDVkJ84lsSCWsTH2x0dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080096
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

In the current implementation, the GPIO read operation considers
both the input and outbut bits (bits 0 and 1). It should only consider
the state of input bit, i.e bit 0. To address this, mask input bit
alone and read it.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/gpio/msm_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 6783fc756f4..7de332c66ae 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -202,7 +202,7 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 	if (qcom_is_special_pin(priv->pin_data, gpio))
 		return msm_gpio_get_value_special(priv, gpio);
 
-	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
+	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) & BIT(GPIO_IN));
 }
 
 static int msm_gpio_get_function_special(struct msm_gpio_bank *priv,
-- 
2.34.1

