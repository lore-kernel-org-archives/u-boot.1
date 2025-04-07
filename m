Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AADC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E4C82E52;
	Mon,  7 Apr 2025 14:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZygDB2/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293F082E52; Mon,  7 Apr 2025 14:05:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D253182DB4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dopo009998
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 12:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rSzHV0BnBV1
 rEBh9za4CvAlheUEemuTxEvHsPTwsPWA=; b=ZygDB2/wm460UMwjpSExsrOBZVi
 u3BiMGRaWO5wSOJ8jRJc+VWkXplo1s6vB4Jjoof26tEamP1vD6PCjn2QpgcwxSmI
 Kr/YJuQirlNQg/kIJfj3J1i8dFQLj3Z1dTHAwlmUuefPvoer5p4i5v4IsOQbDvWO
 f+xqPZz+2NWuWNnKwYidisA4upODXjwGFWWXusKqwmfKSbSTo/JbGVhShm68OZF0
 YV55Xa71BdGFVgOEmAbtkMV+kCiFb5jlKMjKc1RWHYMx589f+eSD6SKZ6lg8vjv8
 qjX2KMM3QJGJ4J2AZbnqz1Q0etSSXC+51NWKjg4zbIqiZz+VIh5yYdH9MLQ==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm436u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:05:44 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d5da4fb5e0so44198325ab.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027544; x=1744632344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSzHV0BnBV1rEBh9za4CvAlheUEemuTxEvHsPTwsPWA=;
 b=XlX15DTHp5qIe/zvGihDDvw02qr59qPxNkxbAGOF/4xt9i3Y26cOlQxi0qo0Tv4gVA
 12wqLU945Wjs0oRTeVeYvzBCU0Fib85Jrtcot5OCrhRNM7IroNxw4vfmG4KZECRH4ajO
 tr0neeTu7VGyVGnAVS9dUSFN4jjKEyewYmP5KLPNxp0FEDijkCzF5Pp6uRx6+RqRiXVc
 dOILRWH6KFRzqY1U51BT+5sODv7h6D8l6UVgZTUjn33UOseY8svJsJ+UlIX1tRZ0Nee+
 Cv7JPeCjpdmoBSOpWrWb2xMbDN0xLoecLy49H8Bqn0fTLvyhUO+OiVqFeUBCz6yLckXg
 39gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjKVchgPy9IyN1jJ0hkWv+W+X3zjR+XW/QuITfJwRMrgG8NWli/rMxceTvqZE5/ruHAIZJ6is=@lists.denx.de
X-Gm-Message-State: AOJu0YyhVLwxoFV6Pd/ZfbPKCocB1PrWFcDr4ID1n3MJWIR4clDmsmqh
 z2/Dd0N/uSweqihfrgaL/uX/CNC4zlFC46kxI2uurELXXtKwuLli9yZmd7ezlFaB0pqfFeOu/M/
 2oOEmQpgW8zJxHaNDxHgj6CQJvUG85YwYEeOncwA5CriyVhvwP3Cm
X-Gm-Gg: ASbGncuqw57xTiyT994hIl1tqHLRQqcqrV999gu8WxioKYfkP9KyiOlAY1jjl0wLd1a
 kktNRNoh7tc5ucjD8QDcXy9+pneOLB0+a0epsAKpjRdxDfv5yPPlrKVBceGqE2QrBkHz0bZ7N94
 pxQrcEDdd4j0cPGdoI2MN5EXqeBCICxhZsKxa5rS2rzvsWDV5UMZJtP0HMcqw9Vh2U7BqpQNu4a
 TuQYdUrBl/2OYws9jM9rRaUOvS0o/4iDOBzGUYcZUDcC9IUC+30p6040k7aNTkpUI1nhZQaPASD
 xt+pRclsLNXIzfnOKBDaCPM7wd2bIHgZ/vStKgII9lvfYzlAIpK8WoN40N2OwDJkZo+T4w==
X-Received: by 2002:a05:6e02:1a0e:b0:3d6:cb9b:cbd6 with SMTP id
 e9e14a558f8ab-3d6e3f195edmr126211145ab.13.1744027543738; 
 Mon, 07 Apr 2025 05:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOONswVV3alrAZqU8RD+IB/Rj9P6LDBeohpwduviLCSa8Y1xklgMOJP4Dxtd6xXu6Vg01dXA==
X-Received: by 2002:a05:6e02:1a0e:b0:3d6:cb9b:cbd6 with SMTP id
 e9e14a558f8ab-3d6e3f195edmr126210665ab.13.1744027543234; 
 Mon, 07 Apr 2025 05:05:43 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm11753374f8f.100.2025.04.07.05.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:05:42 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 2/5] clk/qcom: apq8096: fix set rate for the uart clock
Date: Mon,  7 Apr 2025 14:05:33 +0200
Message-Id: <20250407120536.236003-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OoMnAzrk3BU87R3ZJuYFNV1hdPSXxkqp
X-Proofpoint-ORIG-GUID: OoMnAzrk3BU87R3ZJuYFNV1hdPSXxkqp
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f3bf98 cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VxBHH_N8Pzh9LFQFIGIA:9
 a=HaQ4K6lYObfyUnnIi04v:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070086
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

The function should return a valid rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-apq8096.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index c77d69128b0..bc00826a5e8 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -87,7 +87,8 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 		return clk_init_sdc(priv, rate);
 		break;
 	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
-		return clk_init_uart(priv);
+		clk_init_uart(priv);
+		return 7372800;
 	default:
 		return 0;
 	}
-- 
2.34.1

