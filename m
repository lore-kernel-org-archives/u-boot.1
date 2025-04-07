Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59546C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4C982D0C;
	Mon,  7 Apr 2025 10:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J77h0xXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0BD82CFD; Mon,  7 Apr 2025 10:19:40 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B44B82C87
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766NuM008957
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZhnhHGWfbH6
 xSs7Nc3nPJgzcbUkUO/D76DGSxSi+R4I=; b=J77h0xXyVpOiQwa5Xw4mgAG8e/K
 OFtWbqTlTli6ARiZI+J/xAgTXzklbttQMrHNhKPHnjZuu9HwRAJhK3fL6im9r73+
 agHdAlPKulZknrgKPPBfeMdJ36+q1yz2dNdqkG4kyX+KNd+keGZuHUp+JhLgzjYU
 qT+2AK91dP2YpbTiivVWC+RHuclcsljM6G/fQKl9Jk/+YJT5Gc7sbn8dfDinai8z
 aI5L+t41/Nv8R6xzfSgvbWT5j4iSKw+A6UCAM/lLvz3be1aNgirIqW6j0KzVbfG/
 yNLSnfGxVFkxxWUQ1CRmQHW9mwjFm68BVQcnrElu72wixvVxcVgPfP5polg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrbed3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5e28d0cc0so729391785a.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013976; x=1744618776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhnhHGWfbH6xSs7Nc3nPJgzcbUkUO/D76DGSxSi+R4I=;
 b=qOUok2Met+n18MAIjZa3IDx1RJ4o0NrsQEorqq03xduJDqOtrZczV9dcJkDEJJRMfo
 9v3mrbIxqwTbPDphwOhPiFryKDmzeOExMijtDnFoyu1n7eQlhn2ZLXPFSKnsfrp+qQpE
 38TABFhc8laMphJjqrOzmq9npPHxYlsHJU0y4biwjmziVieGTLsWt78ij/E4C6VlTmsQ
 XFUgJaGgo/PE3Ecbr8Up1/nUZrgrpPqpX2p0zDxzXCfoTwUQDeFuPJyJeuoSbtLjZSoy
 TX0U8e3AJXUKuVH1nkC3wXHhurr5xsXdUTrISMhEOBfBuve/xFmBUJp1zxyr37+iz8HQ
 3uLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGCg5i64SFCjTDJZAuuIxNZ3cWnaJJ22VP1/IL5ptuYcsxd3EpwMZ6wdweHO5HNYlIZwL1nQo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7tV6EoiVOM4zx4/71OKvpwvwuebNFzduT1+gyiFl28u4ZLOSN
 jmoZfOU3vuLrmbYZP3MgCQyp/fYEUaie/qDuZ4fKXDmofdRZlKeIgcCPJna/jnqNCpIZUO/mso5
 CWQXgnL3XVXVo9185feoLOkMZdL151sVYe6LeAOTTygRFvtiO71Jg
X-Gm-Gg: ASbGnct2dXffcY/HWLYB5mXOpwgx6xjyKyR2DbtR6rhCMkSm2/IUqBs8upjng8Mw3i7
 ugjDF3MmPwfYG+Ctcb/q9/xBBQjGghYiYDRAJr1IZgnzWCy7GDeMe2LgSwNgzrvSblmEtwuRYpv
 Mv6cUQ3R2GJN8Gq//kuGN5GtQQqbQSC+XSw1RN59lotmzDAtmB4uijXTJgPwvGFwQaR9nIcCDso
 hhlnF/3mQ4rlwTQwsHHgAq9LlkeVsjIWlHB6H4A2PS51pI+AyMHGUXwPYuMXPDNtVr0Eesz2Cyx
 nPIqQcsd+51Nnnnnfot5ITQcUEn6wHhT1AqRx8ZnG9A5PhSkJZh8wHy7PIZzpHhvj4PB7g==
X-Received: by 2002:a05:620a:1aa6:b0:7c5:5909:18f3 with SMTP id
 af79cd13be357-7c774e165b1mr1692873885a.37.1744013976081; 
 Mon, 07 Apr 2025 01:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0hBmazdqPLlex751gUw97VwmTeiSFMvCZCkdGQXzzCxczzIkAqlma3B4Zu+2rzyt/trJCkg==
X-Received: by 2002:a05:620a:1aa6:b0:7c5:5909:18f3 with SMTP id
 af79cd13be357-7c774e165b1mr1692872185a.37.1744013975779; 
 Mon, 07 Apr 2025 01:19:35 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:35 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
Date: Mon,  7 Apr 2025 10:19:23 +0200
Message-Id: <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ny6E7N7_kVRG_oXMs5p8WLoQMu3aT4Ic
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f38a98 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=l6OA150-fj_NnAz7gf0A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ny6E7N7_kVRG_oXMs5p8WLoQMu3aT4Ic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
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

Some boards do not require all clocks to be available (i.e:
dragonboard820c).

This change provides a fallback to the core clock when the bulk cant be
retrived.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 27bb7052fca..8081330bd25 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -9,6 +9,7 @@
 
 #include <clk.h>
 #include <dm.h>
+#include <dm/devres.h>
 #include <malloc.h>
 #include <sdhci.h>
 #include <wait_bit.h>
@@ -56,6 +57,17 @@ struct msm_sdhc_variant_info {
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static int get_core_clock(struct udevice *dev, struct clk_bulk *bulk)
+{
+	bulk->count = 1;
+
+	bulk->clks = devm_kcalloc(dev, 1, sizeof(struct clk), GFP_KERNEL);
+	if (!bulk->clks)
+		return -ENOMEM;
+
+	return clk_get_by_name(dev, "core", &bulk->clks[0]);
+}
+
 static int msm_sdc_clk_init(struct udevice *dev)
 {
 	struct msm_sdhc *prv = dev_get_priv(dev);
@@ -73,8 +85,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
 
 	ret = clk_get_bulk(dev, &prv->clks);
 	if (ret) {
-		log_warning("Couldn't get mmc clocks: %d\n", ret);
-		return ret;
+		log_warning("Bulk clocks not available (%d), trying core clock\n", ret);
+
+		/* Sometimes not all clocks are needed - chainloading uboot */
+		ret = get_core_clock(dev, &prv->clks);
+		if (ret) {
+			log_warning("Core clock not available:(%d)\n", ret);
+			return ret;
+		}
+		n_clks = 1;
 	}
 
 	ret = clk_enable_bulk(&prv->clks);
@@ -83,6 +102,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
 		return ret;
 	}
 
+	if (n_clks == 1)
+		goto set_rate;
+
 	/* If clock-names is unspecified, then the first clock is the core clock */
 	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
 		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
@@ -105,6 +127,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
 		return -EINVAL;
 	}
 
+set_rate:
 	/* The clock is already enabled by the clk_bulk above */
 	clk_rate = clk_set_rate(&prv->clks.clks[i], clk_rate);
 	/* If we get a rate of 0 then something has probably gone wrong. */
-- 
2.34.1

