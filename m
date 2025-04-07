Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D30C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C463182DB4;
	Mon,  7 Apr 2025 14:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HW+Vxkb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3F582E52; Mon,  7 Apr 2025 14:05:49 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7BB82B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqK6028163
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 12:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=y6UpHSCEK2O
 tt8JM3U2DnvHkxFmvbWtm5Icj6Jcmxv8=; b=HW+Vxkb1G2/LSimKM3pNfk7yD28
 1lAWlaqLKyu6/v9HL8vqd4AY+0lv/LmPQ6NwF4Jd/OKBemqGU7R+VNpeT7kIE6Py
 wz5x5eisbLU3qRE/J6ttD83rMfGVvUNwjtEYqCko5ruOzPV36OJNV5J8WRQcGGs2
 a14uhEUEn8CdT/1W2Sebvl3vJFWNg2Cx9+js8xawDiIXZgHKE94xtwwrQ0O06boh
 e2NKG6b2NC7/KkXHIbZk4ESxGHesW3XI9jfRJZDV9pzNV8AsQfDEiDTqhgLbFyoq
 lDDsiRkn2/mILt3m3pc0sVA68uwSQPfebaacUvZg6SWZkk2w4SobEDa3F/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyv5tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:05:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c549ea7166so691616985a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027545; x=1744632345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6UpHSCEK2Ott8JM3U2DnvHkxFmvbWtm5Icj6Jcmxv8=;
 b=FIcpyd9gyh9W8ryHsIS/mjfuhTGVCQHKbinnzOcLNZA1ANqgAwmRia8hNcO+fC//hd
 osbeKtBb9L/F7XGiX6kXCCrPGWe48k1lK+w5Ot+QFlexfL0j5wnnX7ywtKnzWQH0Em5+
 frFrSWZDskfmYxYUkM5aPeKQfWzx9U03tIttkkl/idV/cR2GXXmKy+X8UwRfa9Lhgf+W
 s0XksmZQz4Mknd3pDxRGz/P3wyMag+QLDyC6rMJJifSdzhuDFz62FyyIOG0Jy7iH+wvs
 QmpUMoZ6c+fiSSvKl/s7DjmYD04ejqeivUhAMz9ZczmqFNrJsb8WNfVMXKrkX9m0R9SA
 61TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrWaanPnd74IJau7COQKJh0zT1lA6TK1SMheI5PmwXj+9ttwiC21a1UblNYM7SieZd0TJhp0c=@lists.denx.de
X-Gm-Message-State: AOJu0Ywv8hQ2+E/74FIM7xPzjFQBvOb0ZyDAToz3iHnLHdzRNP8E5tuQ
 bm/d4R7WBVinIBIN9PPoPzx4y8KIkoUzRlrBCMPtwQ4wN4jEycajIVjpTnk9oyWdBtdBoXnXb9r
 q1FRxyMIhV7wNuiPwaopyYpmoGyD4aGqDgBRgz8iaqn6rks4JGOtq
X-Gm-Gg: ASbGncs3B9qDuyNFzNCU7S8gQOFB2vWyCne4Vx9ttaMOYDZVqObH9YwU6pcq+alqGX0
 gXUCjLY6jrANLK9uGeX157+Ktq73/QbEcxMG/Q1KGL+wblb5ieUez21a/YKxpzqtVhL78JxOYUD
 o0wlx+bwkDG756l1++67YsUx0gNpBUD3RfjQGokKmOkFwomDqKvPloirdHnCra4WGt3IQpgs7HC
 5oNKRT0aJfeFEi0mhYnV5d6Z/iJgWJwo3mVTxYniYFG1rXmEvb0ons+Eht52BkvOKkK19B7GdYo
 h3+yaLO/IdOVEJ5Nj+jwcUix9/l6D07QDoheOfa7GzHIcrYmR42RD7oqhrxc1h2gtPQsBQ==
X-Received: by 2002:a05:620a:4586:b0:7c5:5cc3:91fa with SMTP id
 af79cd13be357-7c774e176a6mr1677240785a.46.1744027544823; 
 Mon, 07 Apr 2025 05:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHutP2r7jhhPfByVg2pHMW/iKHe0TgmI4cDBX8R17yC8LBxwLdCToe2PRQ0HNOzojejXbin+w==
X-Received: by 2002:a05:620a:4586:b0:7c5:5cc3:91fa with SMTP id
 af79cd13be357-7c774e176a6mr1677237485a.46.1744027544485; 
 Mon, 07 Apr 2025 05:05:44 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm11753374f8f.100.2025.04.07.05.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:05:43 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
Date: Mon,  7 Apr 2025 14:05:34 +0200
Message-Id: <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FrjItgkrg8GXtuJ_7IoApJJSpgNRxfxN
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f3bf99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6QLEz_f4mGzVno9vzIgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FrjItgkrg8GXtuJ_7IoApJJSpgNRxfxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
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

Select the right clock for sdhci.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

