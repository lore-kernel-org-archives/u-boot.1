Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F1C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B08382E40;
	Thu, 26 Jun 2025 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPLfSkXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8FCF82E67; Thu, 26 Jun 2025 13:25:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B6482E40
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9wsUA031214
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=y26ZgbZtg68dicEJ0t/JveM0eP+Ge4r8jBu
 7xy/oQ4o=; b=nPLfSkXbImjdf5QqaJH4qZlOPitTyQfEwd/hwA8PF4DzmYCxfpS
 NNmjLT7qLyvkwMLWdZ7pskm0SvXraVhV4cwvigDxPN5uFDZ9Lo1TTCgX6ru2jM9O
 r45NVFuZ4nNggnx0Awkezk0lMR6PgmwXrAr0zDlGEYCyqZDs65ktUbeePOTrIqOD
 4HEt2oqso15eQYFQdCeVmg0MOPjDqrZGDNDLpMSdaasA35vVWp4E9h+pZMbm2Kvh
 SXk3VNXaLOgG+HKoUSak5qw9+2BOtHFMMDP54b5RabK07FQSX9FgmGn0vJWC/aPK
 R/LCytdp78bnO0ITglhxHHoz1Bjp3P/AskQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b42yvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2356ce66d7cso15158365ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937099; x=1751541899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y26ZgbZtg68dicEJ0t/JveM0eP+Ge4r8jBu7xy/oQ4o=;
 b=o+jsBcGEHCamSameOjuczWKAH4yn0qwIkHzGhSCGZr9m7928/Nt2DldXxRabBLGpoM
 ZbJif3qpESy4crYHRGYTWyLujxwXYEZrLPhyQZlfAfQecY2ORBf9viVnMmy6SAlOHn5c
 WwfvkCN24yigxVLHkIeEoU0xGNxNiqn/ox2DYvZNs3Sshy7wXleqNsv+IkKO7W0IDisY
 7+qRf4RTVOVlAS8CkJ96+mNRT4cM9Pe6lPtC1v5QBJlC9IQTbU4GRxdnf9xhZ3S9D8+9
 iKlYkPrYLcbpM/O61cQS8YEvcWUNDWuciBVFbaObMXcQXGvTjkcn2EolcOwqATWiRiTK
 fNyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6SuVm5uL3ZlgrnB5ZVympnYHy4GW31JiaUaYtA+jkqcd6cgjHfRCS25IK6SbTOHoBCjtbf4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwttRg1ZMjyaZQ2MP4nUfpWbRQ2mRRT8mGaF3JLCywPaGI8NhMr
 J4ypJw2lr3+b5CZTM8JzFid+ix0jofEvMGhZ2sIAJETyPvmARucgxeZaWcwU4KwQJokB/olSRNd
 Ec6mV1zKfsrP02W9uyRSwi6sAFEfoQSlS1qc0kbYuKeugG345a5vvtACx
X-Gm-Gg: ASbGncuXbN7nNkeMzr+xpTZSeUyyOCTZp17A1llHwJz5P4N+ROlLNIVDjN1wuvUGSQy
 XPY4tBqMJRXOuSwOBjXywBz7/Mfv3nfbzaOanSrwWK1sDrVcJOSygLFRc1/c7JM/Fc6vGBuc1KF
 BVbQSe9fTSTz872JKBrYVxXLHKxHr4RuzKS5EROSwADz6pZO/hHUj6jML4/BXe43/Jer7JwdP/U
 YrDjltIkFs6cXAm7nW/f0ciMDHbImnp8R8g9182TzZNXeztOqdT0/b9OP9U2aYwda5XyEbjXKT0
 GTRuoNo1ou4Ux5LL8uiETHo3M5PNsvz2KuHomOjpCqHxOaRkv3bHc3xxGoNPY+/6I+bjMKiXa9w
 D9S1WnEgsDKPMyfiUFQBrNb3nIDdkNHZRSCemB7XjqA==
X-Received: by 2002:a17:902:e84a:b0:235:15f5:cc30 with SMTP id
 d9443c01a7336-23823fd2404mr126780885ad.16.1750937099260; 
 Thu, 26 Jun 2025 04:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlEtZqzUc0muO/uIjbF1oLG3r5xtvMvuNipf9Z2U4NQC4JFuJa+4w+zUz+oVKiQky+ZtmjgA==
X-Received: by 2002:a17:902:e84a:b0:235:15f5:cc30 with SMTP id
 d9443c01a7336-23823fd2404mr126780355ad.16.1750937098812; 
 Thu, 26 Jun 2025 04:24:58 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867b438sm154528185ad.176.2025.06.26.04.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 04:24:58 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Added QCOM RPMH Power Domain Driver
Date: Thu, 26 Jun 2025 16:54:37 +0530
Message-Id: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5NiBTYWx0ZWRfX7sbBTFYkzl4Y
 5wscSdbolBFR32GsTv3q0IUkl9DluCD3E5GZ+iKwDv4ySjVpJiRQDolV/qrqdDdU8zH0vsKITN1
 5Os9Jr5w9pOiA46AL8GspLigNMMG00VTw4EL+wB6pADWE06klFKi1vphpqB6W+AwCNjI4n6ZSFc
 0rLTx94kYPXFCdt07baxjh2zXw2qOAIFBZSK29YqvGqIBO9BWghuQDsuJWjTDgAgafYuDNLnoUH
 oBSd3oe0BZFRXRf6EicPp/haRkwEemuTK92HcXHuLBBsaKNFbE9KO4Un1fV/gwFW2QxtoMvze5e
 WH483pDqhJX69kF7k7+W9NgSmPXKDTKzFhGXMumTz0iww53fFA1RY3I66wh68+ruZSt2wPIODu9
 ojWs/TkGnv+N3cMFiywsJk34Y9Nig33REohhbYoJac66BeQmB7uxoy0P3Cm0TKy3gJRLVHnf
X-Proofpoint-ORIG-GUID: R4Y4JrhQAOyCcmpSdHYJNJplHKnMWIWQ
X-Proofpoint-GUID: R4Y4JrhQAOyCcmpSdHYJNJplHKnMWIWQ
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685d2e22 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=GXGHb5lZ-4y_vtRE1oYA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=570 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260096
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

This patch series adds support for the Qualcomm RPMH power domain
driver, responsible for managing power domains on Qualcomm SoCs.
The driver is ported from the Linux kernel and adapted for
U-Boot to enable proper power domain control on SA8775P platform.

Aswin Murugan (4):
  power-domain: Add QCOM RPMH Power Domain Driver Support
  soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
    functions
  mach-snapdragon: fixup power-domains
  configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN config

 arch/arm/mach-snapdragon/Kconfig    |   7 +
 arch/arm/mach-snapdragon/of_fixup.c |   6 +
 configs/qcom_defconfig              |   1 +
 configs/qcs9100_defconfig           |   2 +
 drivers/power/domain/Kconfig        |   8 +
 drivers/power/domain/Makefile       |   1 +
 drivers/power/domain/qcom-rpmhpd.c  | 271 ++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c           |  45 +++++
 include/soc/qcom/cmd-db.h           |   2 +
 9 files changed, 343 insertions(+)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

