Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46097C3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C6982E20;
	Wed, 21 May 2025 05:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieJQqRxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8848682D59; Wed, 21 May 2025 05:53:57 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AAD382DF2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGdjqg024573
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ueUjEJlI8t4
 Ig4iXfWkj5okHNXzr8xxZJBLQ6Wfcvqg=; b=ieJQqRxIHOiF66wP/Amc4dsZiVU
 mIUGsjCOfECbUDESRhfaCONI4tB7Q5CmZ4IduXREWmjj+jOd4hpfWuaNa+N1Q/Fe
 NQqOH/oi0tybFYR5WVDI40nV5gqdYx6l06BIQLvVkP3VYVlAt9MIeQLBZEVIubmi
 MGwRMEDdGTuaYAU/38o7pSZBI6BvcoV+xRRL1YTULaaruadYxOETjuXtUguHeS37
 FHv55aDgBNuBDCAubR7xpM1nId2BVXAd1Pt25qtp/pm19JFMN34HGrXsFXAp/baM
 hbg+tY062dnpKVZ+ViM8fvb//5eAgHKAI1KYc/xS2FPNkAsGonMpSjqEvkQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf31dpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b26e120e300so5970279a12.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799633; x=1748404433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ueUjEJlI8t4Ig4iXfWkj5okHNXzr8xxZJBLQ6Wfcvqg=;
 b=Y2Y0AAs9r0T9Liy8RPuuuWUCiG3ENo0wNbLZvS9Fpo8v2GV2hf2IEaAoNTF5qb+LTs
 qKFH6XCqscOh6wPsFkPSDvDch+4wl2j3Zr1r5gRTxWSVa8cp986VswWjPiy7titUGlo4
 1bBYqXW5QMcX4XR8ZBOpg6RzsIFBv7cjP7jPQdrdzuw0G4nAeVzsWZDKnHOzqdDXd6fD
 m793n+58tT1jLlH84+mammU8KwysQsgDUdEIRhq4+FvCKW2ZybP4EJjX+KY8dIcrKh8L
 5R8jJ9L8dpsc5gsl3EHMclxoq+hsnOxcnSrrDJcqZogzAgWz5FJ6z+TfJdBz8hueQJYG
 CUFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxl6l6xCJ90jZ98GnyAcYPXMx/VnINN/YgSTGseSVhtCytUcLbW/qX6Eo/N16ZpYDMZqABFfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwSwx8G/58YwwKiGyrlIJ/GtfG9pHUOEO4xA8+9pbSYNQl0xWXl
 IpkwKfrFjL5p7myVcj1+UHQK423VvtWc7+3g1PSlL5PAa28ih2dP+XthI6MKU4b068poMFHpHMB
 aSu9pKBE09+IH1Xw6b74o8+Ez8yor7rBVw49LN9g9mEu9sDOnIe+qKGym
X-Gm-Gg: ASbGncsA/g8iKx3PMW4CvgVppjREZK7qLl4LuEev8rCdOgjKnxHt0BEow1tlrZhLZlE
 6dq1Fqizf2iA5PqXuYYavGJSDuZcTZfi9bUZgaaBecZfab2qZJJp945ciq+Bz74KKROxJLxVM6V
 OVy6M2QlQYayTBOMkqG/It7Y6HFjwB361EYK8OeogkwDnRjJPLk3eIz0OWWGgdB7xk0UhzCt3G3
 Y69h5cDXwkLqOWhue1u7QAbUtt5QHoYAVpOQm1PP7mo4RrouSBRqolYAtq65tg4KSrnzv6kfEoo
 dUuMgqrPbAUINphza3F9EfqxQyBoe1ziKWKXoDMqyiAPnUJL+FaI087cUcvCuYim+wuzOVoRENk
 zk8BeMXP7uXqrYYPDNerskZBsNdgFRZs=
X-Received: by 2002:a05:6a21:1349:b0:1f5:87dc:a315 with SMTP id
 adf61e73a8af0-2162189eee9mr28569791637.12.1747799632755; 
 Tue, 20 May 2025 20:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qlsMxgSOLeYW03dHbxXXJY71UsH+4IzwX4bdXtuNHEI9+RUAuBqzGSzfST8Vp1zBbWIa8A==
X-Received: by 2002:a05:6a21:1349:b0:1f5:87dc:a315 with SMTP id
 adf61e73a8af0-2162189eee9mr28569766637.12.1747799632393; 
 Tue, 20 May 2025 20:53:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:52 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 4/5] qcom_defconfig: Enable QCS615 clock driver
Date: Wed, 21 May 2025 09:23:23 +0530
Message-Id: <20250521035324.1182833-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yMwgpBLB18g0-IiWj32N_h5Mf6U5K-eC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfX7ntq/CzVX14R
 3jDdTF8QaB0LUECp0N8la+MJ1ltcBzJZtNcX/jS294lCrrgOwzGe8GubvL7mFzfoRtbeYc3gXUX
 D/2P5V1p4RMj4fhLZSVDteHTBZ3OK6bl8US7j92BvqFwbUBiMeoayScPzV9+7BEvF4MjQwp8BW9
 fBIA6WyWGPO8K8vNNQqF8vHa5VY9mboDj1e0+e20BCu/XZq/ulH4v4RLKdzL2L+ESoVGS7+ho1E
 Xbb45I8N+KVQ1lXnjj2Oa8wyyksn62T+Yw6H3oNpJkq5dwwUSe1YilTNTo2TQWzVx2remhjLrMO
 B/pbiORfBopuxc2Y08nTSVetdl0PmITeTq+zb92CS3r/aeiF0rjOkjiG9vdjjEUEJRyEM6m5lsd
 AiQP6xb+1XUn0qVNoJcnoftneGyjuo0+GEfpDCTAt6yns5WZnL3jpPjXb/KZ/AdeOS56F4fb
X-Proofpoint-GUID: yMwgpBLB18g0-IiWj32N_h5Mf6U5K-eC
X-Authority-Analysis: v=2.4 cv=a9kw9VSF c=1 sm=1 tr=0 ts=682d4e51 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Z22XvwZFbGG9hQITJ7MA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=766 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210035
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

Enable the QCS615 clock driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..8510828824f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS615=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

