Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1FFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6A582FB8;
	Mon,  7 Apr 2025 19:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVncCLj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFAE82F9E; Mon,  7 Apr 2025 19:56:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF8D82F1D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dlqQ028092
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 17:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fa7ALh7XeKZ
 XkOcIRfG9Qkj7/k2V6YTiKep+DR+b/Oc=; b=gVncCLj6hSfDC02sAVFfahWYrTa
 6rcXzBaUORcYuwCHu3TehgTCQlCJcq4UgCpaz0Fbg3VURbhwlr55WISRR4hJWemX
 taau2WWzr5wQUHmtqsuHrocfibWrFGNkC8xtmfINC6utHvlVKuUfOgez+nzHCMKR
 5k+aqIIbw6U8tjrumVtjy/5ixCyU6L6cbAdu7jEtgqOpGIsLvU0aoaDoqLenJuht
 Z8sIJ/SH1URO7pmVURsvAgIVDAA8lnVkHp9ExpsO/CIkAq1gGsuIGJo7QJn7dLPq
 Dbrxbwyg06iHVPmIkRRAOsPEx9UNkDnLNfvq2vevw9MpMfS8v73h7xs2KNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyw34q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:56:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c760637fe5so827860685a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744048589; x=1744653389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa7ALh7XeKZXkOcIRfG9Qkj7/k2V6YTiKep+DR+b/Oc=;
 b=fY8y4FBdhRwxTzyuYVvbM+XIi6t1MU1N/M13EWL3hNujAK8Jdz3jjeDxq9rFghtnIU
 eJDP1iK/EQo+oetVK2XVXqE0PZ8A6X1+p+nw0VKd8iJRlQ3rFIzyaOPQ9L943zJrTM2d
 gL/Ao2nAglJY/fodNPu63QXuWg2kfGLjrurt/XuenbmfeB0QKsO1P1ytZ00NVf5TfBRl
 dxXAinjCukavt7PtEdskHMH/3eJCean60DZIsf/yzioNBJyoKtDR3B58X9LJ3aSFfW/P
 Y0/5dPTdYdEuYzgl89ogi0D8bo7NqqTaV0UsDVd4n+1K8F3+kXj21b8TnRPpfa8AJF+Y
 E0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMnuvTeq0VPKmYhAaPyXXeoMekHdNS8wsi7e0X80mHI9x2jzj4jSutvHjePV1xCDdiiIYQ290=@lists.denx.de
X-Gm-Message-State: AOJu0YwhiWwocCQUhliJKBu4GqhO6bhCE+w0HY6oyEWpg43lZ3lDlDnG
 +gTA/6xIrd28dDAJaxJorhDHAsQk9CsLw3O6tPl5DzX3AyofRYUo/WCzlM6RaVyp2M8PTLpYFF+
 1Hn6dZD808q9t12CbYnBBrS0B4OzRwWvSddsJfdPC6gvKHH/WubjJ
X-Gm-Gg: ASbGncvW535O3coEWXmOqi81JepeEwWWDGi0xu5qEEgtFRw6BGG87Xbshn06nT4RssW
 hIg/zVjF/gYeAXZRM1af+UpCrYnV9WD0qpxyP6oXO6cTUUuVE1UBgqpY4x+8num484SDo2WONch
 X4VsRhAT/rEi1y7Hu8Mg+ANoZAf+a7Thase393GxdIDkB+8XAEwjrc8vKirV9u0aNDvLw7tvhlk
 sVLnXzODAusmMM4aDthfLtbpGyoTlSz9bRi0aAMf7v6oPZT7Ma4r03VUogdz3PRuLjePE056rbb
 1N5iGiMiPOTjEDMJJnveV9qrS3L8OlqEBG8vcXxbwZxOvG2/lGtF06FxLOiyf4Dq0CA=
X-Received: by 2002:a05:620a:269b:b0:7c3:c9f9:3936 with SMTP id
 af79cd13be357-7c77dd61aabmr1306538785a.20.1744048589090; 
 Mon, 07 Apr 2025 10:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvra/g2A3/qG2+U5rfe5+0yczRWg4641KJ561hf4to4EtYeJ9FyUaXBMHTVLV3xKrJqn0oZQ==
X-Received: by 2002:a05:620a:269b:b0:7c3:c9f9:3936 with SMTP id
 af79cd13be357-7c77dd61aabmr1306536685a.20.1744048588805; 
 Mon, 07 Apr 2025 10:56:28 -0700 (PDT)
Received: from trex.. (65.red-79-144-193.dynamicip.rima-tde.net.
 [79.144.193.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm139346005e9.3.2025.04.07.10.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:56:28 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
Date: Mon,  7 Apr 2025 19:56:15 +0200
Message-Id: <20250407175617.3494506-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nIiTpob_IlhIx8PZSyL0oP1Py2BOwgUc
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f411cd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=K4l/FCcx7sfGu+4G7WjjoA==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6QLEz_f4mGzVno9vzIgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nIiTpob_IlhIx8PZSyL0oP1Py2BOwgUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070125
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

Select the right clock for sdhci.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8096.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index bc00826a5e8..551f52d5197 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
-	case GCC_SDCC1_APPS_CLK: /* SDC1 */
+	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, rate);
 		break;
 	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
-- 
2.34.1

