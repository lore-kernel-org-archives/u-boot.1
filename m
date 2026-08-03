Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBC2C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E053C405D9;
	Mon,  3 Aug 2026 15:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ftq5fWfbFWFe; Mon,  3 Aug 2026 15:50:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A67EA4058A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772210;
	bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BJ+V6pI+oeL/aNmr9fBJg34HpwRXWYBkr6G/NvaVtOgz4ewEcIxtYrpF3RWbxEBQO
	 64YmWXYyhi8ZjCahZFCE6GXDF5wDIaZHfA3GMfsY69/FISgKlvPPiVkFTQQ1fX+JVh
	 wRkQ5KjqujYWM1pVNRjoaKRyeep/FO284JbsvVZfzGCY2sqQJpQFH30tJ7PUGnV8J1
	 YOdxjuk/iNyNNU6SVpVE4+QgnOEHmpBMhPZ7FP+eqJqZ5r+2aFpc2Z28To1mML0x3V
	 zRccHyKlqvmvMfvyNFqRHUX+QCfGzlphUyNoEZVFq5ec/gLlKVQbuydM6vcP15eqiC
	 nmLp9Cs3oZ14Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A67EA4058A;
	Mon,  3 Aug 2026 15:50:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B54F83A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A688B60632
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOib0pdiwN8o for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:50:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AC9CB6062D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC9CB6062D
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC9CB6062D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:08 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBtl6636321
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:50:07 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp4r27xy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:50:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso4499590a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772206; x=1786377006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
 b=c6nz+drBJP9r8UkEebhTDIC5mR4Md9VR4udYI355CL0DQ4+Gn2YCxxkp/1eJwdeQV1
 Wh/gcYKqrdg408rPTDoUgKsq9LFrbRgC4dMrx6HsFhv/BPBaLazSjfC/60h+XFncv+hz
 BlMPf5lscOU3FZEpi+87TAc5saDsKeBay8Vfbg0HRVc5Sda0jAF4UEcW48XQciUSOEes
 vPHQX78qYn8hqoZugyDShjb7zoX8wtrIRqNoYb53WwanhrckuxBx/y5HqF2Fl5pSV0p8
 sUA/2hxlEXiQC7AYch09ndn2FIqnuuel7InzICRJMOUnNCOkiT38rrXQOCcGfooOh1kF
 xDGQ==
X-Gm-Message-State: AOJu0YzFctJSTZ1zQLc9FYddHP+OQ+4lTvRNfo0geT89iACd34jweV/i
 EvUjN0zrRtBIpSrIaAwEOyghYsFNrnys3tYmq6Qe/Ea7cOk3xguyAERl/hrW7//PgvevKtXK1Bf
 6b4JMP/ThgVm9T0sNr81AI1wRB7rmxsvyVE0f7TPoZNYcdDft/el0FrRotjPB8UgZ28lW/tFbiv
 5DEZ4=
X-Gm-Gg: AR+sD13atYFhT+81vrgLn6JpmFly177jknF5r9QXKFFSIgfNpzQ069cogGmQksyJMsJ
 Z6HsPm8hEOtGvoVxz1T5WPtGSsjJuQR4AAGLS7as0UcWIWwxGJYVRf6+wCeI1WwAgDBRFSbadqY
 2TdpJK7tHxPgk+rUML5MMq/0+UfsQH5zKi801FbLYG7IDXa/cN4jX7flRgWjvgP8eunZegTaUFp
 ctV1V/giRX5OlOjTPZipDZqeVeG4JsUosgZlEMF1rj0Kc4xJIWfC98m5Dryg+TWAEtqQ5D5Z2ev
 FmGAv4ycJi6IClslRWGLH/OoJ3hRFWdiLMRlVrjf6yCUiTtHj+wWS2UZLuvObn57M+og7ph+v1g
 lRHAzW0TKCqFuMAOHS0vDihDeswwu1XzExFMl5Sk6BtpLe4R8SNQo2Sz1hc6Dnaz8jkPNIR5RsP
 ctE3nNBFU1motETT918GvfDfK3IpxK
X-Received: by 2002:a05:6a20:93a1:b0:3c4:2cf9:2896 with SMTP id
 adf61e73a8af0-3c92a8af306mr10978520637.45.1785772206273; 
 Mon, 03 Aug 2026 08:50:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:93a1:b0:3c4:2cf9:2896 with SMTP id
 adf61e73a8af0-3c92a8af306mr10978489637.45.1785772205774; 
 Mon, 03 Aug 2026 08:50:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:50:05 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:32 +0530
Subject: [PATCH v5 6/8] arch: arm: dts: remove Lemans EVK override DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-6-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=1380;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7uNHodD3zCjNMDFWQCvIZeqNbmqWpPLlBx1nho0cur0=;
 b=AptU7zQ9xZJfexOyukd+/BszRaZGq/6qJSCHbXra/VcJ0qI6zecNz2CWWoLy5Q1UcUQQMTW5b
 IrABJCz99bSCasFYoPO2b5MtZSrfbIMKc3WXL9AWfwIw5n/sZHtRJay
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=X9Ri7mTe c=1 sm=1 tr=0 ts=6a70b8af cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XLvrpU4Gv7iqI8mavlCfalUj2jyP8_1y
X-Proofpoint-GUID: XLvrpU4Gv7iqI8mavlCfalUj2jyP8_1y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXyIyPamkaoZGm
 8Jopjkymo6qahPmGaIikqcJQwZidWYtJ/ahtY0UsZmPiAK7uFB3c1Pf1mBReTUQBoUjAfjDfFw0
 8fTZpj7WQjRn8a5tUMTJElvye9rGUfo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX9AUDVDuWZShN
 84X0LTVhtQqCfP9TXjeEczyBwHwNsoznDVLu3je48VGF1Ws7nkisVvxWTTW/YPrsJr4siBg666V
 FMjkrsMkXGn03MXMEeRpAib5aG5BsZiCyowfkdv6B/N9hFjPsb3tWJJp+eDNtuhh0EFaQhyAQai
 U3GmP/al6DzyhEsBGnL66+Sh/Sfnx/P7S320qg9I43THSbADpSS1LMvAB3nNnAMK4ao/mO9hpES
 VqxyPlh8tDm1ICu/EobldVbqpiftfmflcik9hC990X9oC7N6sGyZKUSJ09B+nrvbmF3i3AWkeEL
 hb95WGtVTmE0OZejD/TN1i8qe21pTMbtzH98Ao1cXGhZ3HPL5Hw/oKDjSnZNCiqiIKiuIeWgxvz
 OrFM4eeddxsRJGlDVpb3LCYDASOpGfL+VrFTp1xMRnvEmlFNU5mTi4MZidEa6U0VTM8PDkYg2y0
 vkYeIuYPnwAnmeIENZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=; b=LVa08RZnLB4aUcK5
 J/d5RWgmVyFEjTCeE2P/PiqGxTPjC/fYEGCmmNgzHTUuhQYRxBjzbiLQPy1qp1Mm
 2178D/PXscLyQMSanQolU9Jq11qgeaJ9vR95AxncnazUn52kyGCRQMML76hnqGyY
 xHPUwreZlnxettWZVK/3TIzUrCSaMidwkCk0VgRrHejQPa0ZQFwp4l6gv1rg+f8t
 vtOKMKPZW7gL+OO9qkjcbYfI9ZVi1B6gE6txf4vYUdnX6kzmr+ZGWg4yuLBeQ6F0
 F/RfGaCwtmsWkWr85qfM1PI5XV4xztS514D+4RpGievTLx6cxFgVhhW9C1jFw2aU
 1AtrNw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772206; x=1786377006;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGpKCijzyiyvXYMn371RAueDZrKlIZo/LzwFtQNF8Bs=;
 b=gGdW0xWa0xIq1N1T2ikfameVKJmZ54Hn31mTF3HciAuQH/OfYgoLZqqvRwxPn1RuPl
 qqsBijSueNkHNjqXzK53aceo/fhQjTMvKnN0/V/QP8H1gq5BNK5D6i2pWsWlCOkzHk9n
 V1qe6AQj48miiyC1GYlyXFMx3XjK6slWi/y0SjK3yIvLficBfNfBGNAKwUJQy0FlpHU0
 MH8iW7PMvnMsJRg2HGQW6WfIkaXMgnL+6v90o5F2ORdn2AgJqC2QlzDqtA1QIUZSpH9h
 4cmiQ/qn/895iV0PGFDH2vX3vnPmJvha+1dmKYiF0mcP+8b0rFeZn3Ysd6/f7nS72hPP
 l2Tw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LVa08RZn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gGdW0xWa
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

