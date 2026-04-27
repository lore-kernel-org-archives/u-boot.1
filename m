Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5615FFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB54884150;
	Mon, 27 Apr 2026 11:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+Sz7xyQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ang/H+8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392D983693; Mon, 27 Apr 2026 11:26:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AC884310
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TNeO4055027
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y2ll+jyYRTcJO4356ZCROQG/yx5dhCTv1S+8XMEfXfM=; b=F+Sz7xyQDBYNF/Ys
 M3JGwT0+LtSBEsttnYcWmPCSUmuy71gXVDiSuZvR8/BgibmA7ocSt+BOEIC/ouui
 eNs8BClBNnZPMNYop55/KetJQreLMuls5B8LFK+Sa6C02chGBriYHaH6n3AfmEFv
 QI2R0E08tiIqJKm4SoZCp+IGkJysXg3abcQNjXypcx5ce6XPdQDvbd7a8MowHg8Q
 lSBBVKb9ghq2PjGWNSuKpAm2meFVn9qhT5zmK9VByIsJY5IYyG32laGQjjfB2p8U
 slmPN/QscGUhOfWKsJlEiEuekRgxFXvjdp4Wfq53liA469WIklN6V6WyOlf7C0qN
 23Tj2Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxdfn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f74bcfb86so12119270b3a.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777282011; x=1777886811; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y2ll+jyYRTcJO4356ZCROQG/yx5dhCTv1S+8XMEfXfM=;
 b=ang/H+8CuDGQCR5F57ohod3THcOiL/rt2tM5xnm7wAN08ov2FQheySp8DVJpRH6mwz
 0yYZ1vsUZCv3Qb9pHAnnXvlBYxYmGTzY3+Gif9nCg3NfkyX47/2miRb9sYO0ZeM8h4+Z
 E0eyIwmOH6Bsyqy2gn+uH45KiUNMvPRQMycWK6l7D+5SWUvaCEliQbJkpSzOM8DFOkud
 X38k0j9MmslKCocM9stNrWmr8ucNFZg49l4E4p8R0o386J2ijR5tr37jALCguCPfUxcV
 W9A0Ns6bwDyz8yuQ6Rotr6WSETbtFDQ/dIw4P8yK2YK6y1jONhRnAWNZF2pzMERKGKmV
 5i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282011; x=1777886811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y2ll+jyYRTcJO4356ZCROQG/yx5dhCTv1S+8XMEfXfM=;
 b=rkUxtH4iBukZ4OYmEGTzdal7koD21PYctBZiptqVLMINcnPeTA51WNeaiJGiQw6iDF
 mvt0anzehLlV+g/aHzMQ+m93Fh66CW+WK69Bu0BlpUQP0DpGaF3AGhgexu6E7A5p4uyL
 mhCH903yK97pe+2DZzhohtbuZZW5qQR/GI6rOFxRf+qAuG4HWXHIyRejb+fjI+TmoDQr
 SLlQ6S3qzv8o6CXK8/+haB+DewpgdbhvmgRD6gqPizn/rw28684rpJ4MpXc2Asg+jgxl
 0O7HMedHKdFbKSI59fyBcN00UfhBVOYitxP1+ebiGdykX2pW2XSjG5w2hsv9dvbyJ72y
 773g==
X-Gm-Message-State: AOJu0YyffW7Dr+zfLzQ3bl9VjcfcTQF4+gPTYkVeEJZD2PNssiFIg5Ub
 mmWJzbmY71jKbT6I6PqJK0ih/sgBvUXAbbbkVRMjBuNzGTTiKyuUKqOQ7vfyvy+WBMLYBaDmaRq
 P23+rqq6sBIMABdYldqSVUJlvmGMnZ6nDzLWGOJHOpA7N0ojyEKzhSHauG4hdrVE9
X-Gm-Gg: AeBDietr0lktBLGmdO2W538unxra3nggEqRxF+EvkKIpB3Gd9kdtlHGtEcftZVaF8va
 9BecA/TEZvFiLmDDnNbHCgpil0pFgtLj0hE3HY/yJFiB5TgD+aKKOGCpR0SJFtrLe3c36aYJqvj
 d213/LwFg+/Mxq4fAYXjZUJW4GDIqcsyfSXvjNhRs3z7F5Br6R0II7nkfmy0oNmadMjabmz3phE
 p+erFXHWDrikDAhjmDOhYhlTTQRmXqf2DaQmN2DGVvnk1wYQ0wqFrFUZm+M93L7vwbwH/G1xo1k
 ai1y3c58WDL2R+SMH5Rv7gJvVMqqde+4eefHtzMwU4Qiv5OBJQrJANn1XdfffPLlAUvsP92CO1o
 8SqSCAStbN6ips23vBfQk3tZQm1g+xA4ifQraUwsqJWZk/fZmU5Rn4IXTWh1iezEIMW6MycuDIS
 zLW2h+TOnFjcKZovMH4X0M0WnjTQfBzhDKXjZJgONZDYfuQikgaosp0Z3yzGoH
X-Received: by 2002:a05:6a00:90a7:b0:82c:24d5:21cb with SMTP id
 d2e1a72fcca58-82f8c82ef00mr44756604b3a.8.1777282011401; 
 Mon, 27 Apr 2026 02:26:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a7:b0:82c:24d5:21cb with SMTP id
 d2e1a72fcca58-82f8c82ef00mr44756566b3a.8.1777282010940; 
 Mon, 27 Apr 2026 02:26:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:11 +0530
Subject: [PATCH v2 7/7] ufs: qcom: Remove redundant POST_CHANGE clock setup
 call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=845;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=27ndi8dA5o3w63gpRCQ/THHAHTQ6PkRdoD4vXiAl+98=;
 b=i8A9ojLvHfCl9BDcoPvsmavYHhvtTqhSn2v8raXhM2FVswkua2Rq0zCagu6WIc0YESM5Ab++H
 u3vD0tLMY6JBum+ktcNjswOqVeedrX1o838GwFb2G+JQXm0fkrGRjlb
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 8i0-Z5Yj3zWQ0KOOncJUDgp-9wy5un2v
X-Proofpoint-ORIG-GUID: 8i0-Z5Yj3zWQ0KOOncJUDgp-9wy5un2v
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ef2bdc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VQLkC2b7TEkL_dtqzYUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX/zOcAmH/CJ1Z
 D7D8CwmB7Zu4jzho6ATRs1iNul+qy7fCKsAqOpA+vq1bnn3/iBFdxciABNoMvDZ61YVD80wXTwh
 P68QJIUyITfemZ+/mG8TSBuALl1uKEE3RZ+ZDJWNMhcbthkXTAdzLVjqPCOJlesaIi3Gy1LBRTg
 08b+fXjQ7B7L/Ol1ddL7/w36n52b2zQ1HLzFW6FRKAg3B24jH3DJ+JCcmATGZzQBACnjxu8b+fM
 BVfOVGy/rWi0Xt97XmaI9r5kJXbyhQq4nNPdSH00G6qPYm95XwginFBodEaVyfai4WEUXJZBaFn
 aVrNvAXU2sKiy31Xdp1yRcYaNfn2n+p6tV9caqDxqquyYXnqlTd0xWucvp1kmYxLBENwzPBQyLk
 H77fjxWz46VvcCA3wZKrGikPrHNIku+wdTcnQ1ps0HuQRzK9/rsk9qzfK+0aIoMm5kUcCXaikud
 jaKxGNvZ7pV4VQYrRTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

The ufs_qcom_init() function was calling ufs_qcom_setup_clocks() with
POST_CHANGE twice. The first call after setting PA_TXHSADAPTTYPE
correctly enables the device reference clock. The second call after
ufs_qcom_advertise_quirks() is redundant as the clock is already
enabled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
 drivers/ufs/ufs-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index ae33f62fbee..f5f5a6eb110 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -605,7 +605,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		 priv->hw_ver.step);
 
 	ufs_qcom_advertise_quirks(hba);
-	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
 	return 0;
 }

-- 
2.34.1

