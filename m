Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D661CD13DD
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D276D83CB9;
	Wed, 12 Nov 2025 17:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmPEjSpS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RQq/p56q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECA483CD3; Wed, 12 Nov 2025 17:48:30 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D67B83CB8
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACGZ49h721907
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fZflsiF9A0AlOAqdHx5+509I0OU+LQaeoGH
 iQVxorJc=; b=jmPEjSpS3SU8NDVl4515w3Ue7bYCCCgiEMBIgsXcEtkj2g3schM
 4Rzvxk5dglsNPwm0QgxkdY18aOO4ylDuwOGCveoTlzYgPtGrwdOaT3lfCfIATf3o
 wgbrG8bkXNVcA2f5MNaq7N0T48y5rHDMF+RnFqWCfGgUJhsZPXGNaNOLDa+GgkAk
 CJLOeUSWULbORrMxWdVKpmHUsUyso8lmmwkI0n2t/2EvNrduzHbM41lHZwwKv+zL
 SZ9PeVNkCrawciyKiT8wMToJbDycN3iLYLRPA7/bpw6v3KD9gaNz08kZRue0xRvH
 7hGj/8WvHpr+GGJ6Oe0r+6+7ksBYD49kvkg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1scq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:48:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b63038a6350so777330a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762966106; x=1763570906; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZflsiF9A0AlOAqdHx5+509I0OU+LQaeoGHiQVxorJc=;
 b=RQq/p56q0hwE1Az3Hej1KDZqjzM7Q5LnpPH1tpjogL/34SDi07f84OPf8UF6KR3oW5
 4vxLu5MzR0Kp3uscMdJGvPgg95jdIamUKz7nc7BvnfUK/efgTVAARD3vQ8oX+fJV9ikl
 u/ZGZEoUdI/65IUzKP281651LeCtL/MMK8bPPWPZ0ZR5PVVUWRsw5H3uGrPp877BuXLz
 IrTBBLJQSnGCpmCRdYMEl7giE+sdeab0obv9H46AJV9+9fBrh/H8Ap3MzLr0UIqNSFB1
 1Bu+bZAEg8jvqivABALuB0dWX9/VnXapteVhbSinyB9z2iG3C/X13iOYpNCuGDbCVFWc
 4Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966106; x=1763570906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZflsiF9A0AlOAqdHx5+509I0OU+LQaeoGHiQVxorJc=;
 b=MI9L7li1po8JWaLwnRvFDAwA+ZQtlB1t5/7dN2wND3WS7WNZJzq73rQGZLuTvNJVfL
 uE+JXj1bgwiT0Q0xgq1o+7BoNoU+Dpg/rE2wfeL68hHn/DkcKp5cBe8bTHBcPz0uIwRO
 1GOThW8BiseinzL5kuROkbBgQr8h4dI1NNCndVT74yWhsGF4FtlaVC9Fs07NPoT7fovE
 8bb/7gbXasJCdUZZlntDbkJMZeyqWWHTo0+oebTu3wRMSbHZwiMSVa6YKlXsq71iT/2r
 rbCbxSFTFmnl6THLn5/kBr523J8OeLcDwihtSl66g4Xw40y8Cogi5CGHoonBJQF38OSi
 LCJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfitksQC0xg1DiKnS5iikYDTa2caIi19lGSnQOOCwO/4EYn0bs07dxjvLjhhGwFpGeXP+DYWk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9tQApRdA0HziYMo+FVN/tEgTyN26TNy9fEhysposhuxdvZDgQ
 GzfephLqOCD0m/TsTF4mgX9KvxYzF2d4DZ7p/KvgFb562GPXF+8gtKBoQyENRZ8l8Xuscn0Z6N5
 6ifJU6ukDE0pDa/W6vFiRSsTS11hfHSwq8OT2H1uBcRLpp9PQn9ejpBwn
X-Gm-Gg: ASbGncuQOSix+o/vCtpShB71rwGqP3IGmeSm59Z7J8xrbIVLaheQwfEyvf4/3XgO3js
 sAtFN2OKl292ACkbnWR+KToznFBLhPOAiHW2AN17jRcA2f3u5ivpSZ1Cuo70vlc+8VcOAu5jvfq
 D7gAtMkl1nwlabyHZFTTiFrm76J7e0+b656y33h7jc8hQtwCMs6dkb+4A7aHsibF2Sl3GS6kTza
 tz6IXNs6qJcDcm9oxKqaXo0cjZ0cGm1w/OypzyN10iFwOIgoCOXfTtJqfVkLpiBNUYG0N9KRUBu
 slsJmTDrgyNtuVz1/nad/yAHuhrynEhbq4/W/ZGzhP2zqg1/bg74k7tPKLouxYU50sO12s/KPIJ
 kKdSdxaAdQ1oQ4xzyQv2+lNlzSSuiuE4DPhbEEQQwo6fcbknuITix9gOh4HeOvVT9sXAHA7DwUA
 wl5dnYJ3DRTJdvslaiCA==
X-Received: by 2002:a17:90b:3b46:b0:343:747e:2ca4 with SMTP id
 98e67ed59e1d1-343eac5ac34mr58651a91.9.1762966106027; 
 Wed, 12 Nov 2025 08:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe8POY44POyg1jYVpgXW1dCXQZPK+fPrQCak8NyRhEfDxEykRJp1cJWAT4/YrZePa3fTfBVg==
X-Received: by 2002:a17:90b:3b46:b0:343:747e:2ca4 with SMTP id
 98e67ed59e1d1-343eac5ac34mr58629a91.9.1762966105506; 
 Wed, 12 Nov 2025 08:48:25 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e07b6dacsm3175770a91.14.2025.11.12.08.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:48:25 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 sajattack@postmarketos.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 david.wronek@mainlining.org, adrian@mainlining.org,
 luca.weiss@fairphone.com, alexeymin@minlexx.ru, danila@jiaxyga.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Added pinctrl driver for QCS615 SoC
Date: Wed, 12 Nov 2025 22:17:56 +0530
Message-Id: <20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IORVYPlpwAIPi7v_oHdqG5NNyd1K6Omd
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=6914ba5a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jNbT8L2NLLtQtfHZ_s0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: IORVYPlpwAIPi7v_oHdqG5NNyd1K6Omd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzNSBTYWx0ZWRfX/zphPFQrUtxB
 omvFBf7oKb8C2d+P+srjWTMoSqiFMmU67FRAYkZxHQ2J9J2xhSn2ImU9SamQZ6buwGsdha9074u
 a4/nnWPwvp+aEosyk4upBU5SRj7iUvQfzeNZirdEC9vkZ20c+xdJ85S5jInWs//3nAilGAlJJrB
 kmRLY0K0KE0jIezY9aQj1W653Y5aJkYaTXNOPxDLSC2zdohk7JHhfTeHAYDu1YVd1DbfLYg6F1Z
 k4l5sXi//KGJ0uozI2eZ5W2WgWdcjqm8VtGLFrpjkOCEA2NIM4Dr3o5CK4ZO62EBp7iHmuZ6lAt
 mUQ7D6AlY1IcVN7G96+NqdpP4kgU0hc168IHcbwdTyXPsyBvGWgWQUXxePQSu7/xFnfhClOIkUN
 pjsCmAKMjjRdsVBN771aTAT89ql3RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120135
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

This patch series introduces pinctrl support for the Qualcomm QCS615 SoC
in U-Boot. The changes include:

1. Adding a dedicated pinctrl driver for QCS615, based on existing
   U-Boot and Linux implementations.
2. Enabling the pinctrl driver in qcom_defconfig to ensure it is built
   for QCS615 platforms.

These patches are intended to provide proper pin configuration and
control for QCS615-based boards

Aswin Murugan (2):
  pinctrl: qcom: add driver for QCS615 SoC
  qcom_defconfig: enable pinctrl for QCS615

 configs/qcom_defconfig                |   1 +
 drivers/pinctrl/qcom/Kconfig          |   7 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs615.c | 466 ++++++++++++++++++++++++++
 4 files changed, 475 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs615.c

-- 
2.34.1

