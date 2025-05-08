Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D35C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36598294C;
	Thu,  8 May 2025 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DwR+97XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7118828A2; Thu,  8 May 2025 13:20:22 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2018C8291D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484W6O2024935
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=h4zvqI1FqgAXSERiudguzM3GSezc6V/gKUG
 ke7rzx1k=; b=DwR+97XWEU5qqKcsxcxayvs9I9E1iWZaO5QPMRG4vRtlQnpS91Z
 LsH2hwwJM3ZCSgJdRSMNeW8cEJDV4GUjOD7yjafgAdCM4Rc1v/1nxapSg3R3VjV5
 4YkTqfXIoK7lcCX7Q3o4lovYh7ucchDvIBZDy+FclzwdadH9F8ANdOl2h8WXwItm
 bMOot5AX77GQSjP6f0f7V62hLrClVVb9j+i3K7lkWYNnqu+RegtSIKryIyp4EXmB
 xdiID+j+dCGg5xV3j4/wcMFLf+H8wkjrlpbi563YNiMKsf7N2eg9HiamIFtpJv/a
 7ce9WIXjecPg5Nmk1YMl5BeuoV5T0jpMDRA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp1142j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e913e1cf4aso23374116d6.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703214; x=1747308014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4zvqI1FqgAXSERiudguzM3GSezc6V/gKUGke7rzx1k=;
 b=V5Ds+Ba1mb8BxsbcwJMkuq33BxTJM7aUdifaeWchJ2MM3Vy9RKR0V7KXJEm3nN5lNR
 bfWbjmJklVwrHZjG++6X41VSWA+EI8XkTeMIyk3ZYByZ76QECIxAMA3J/GtphaZ3tSWf
 lvD8IOERqSSUYOa+o7A9Nobr5bj6dWzRkyd5Hg81DTr5YGgDYULt/76DXWwr42/1xVrJ
 IX5NzzbLyjg8deP+5An8Qd9Y+5Wpg2nNRdMv0DbayjGgP/8ObfJjIfXRAr5xvBYlvn06
 6KhMHCUrAYatzcWNwjGooGtblbZ62qHPuKlMk0NkFyn9nhuygYeYObR1xahjoJqPub6w
 EtjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7o9mCb5Q13/ZgSivIPfV6XBhDsOfIyicxHLEJOSioGmIaXJSjecHB2uLS7BLIwtF6eTL4dAk=@lists.denx.de
X-Gm-Message-State: AOJu0YwcWRbMjg7nvxlumZOJWiEpN66MgqImC++l1fpaPThIGCHFIdVG
 lzCXx2HR/2LOexHbM6fak4/gW/MwyQ8K8zQPE8JkO96shcBX9nDGZXyXhul6kMDUJg6Kgf1bN3R
 wQJAbhDdUd4M/mTHy9t7xxy/pwFtr1UgBkreQEdl1qROIRBEQHpdbyJmwna4X8FI=
X-Gm-Gg: ASbGncvw/vuRnX8ZSa4KbstA+L003StLnv5NvzTpe9HiStF6CArMNcpXWHqjo9SGcgj
 2jLPswaVoAFhPtCFxZ8J4QfcYjQQTUQiGu9pubvpDhoAkOOsbn5yCz7IxDute2wsS/2Yspq0aPM
 4vuA4+kYEBtgX4vYJI94VJlAPfGAoIsdCMs4J8pjBx7nCENk9xS+TWSjA+90/h5rzIJM8gC7uFP
 ePlsD2j/eA2QcM6q4E+HFeeyzu1dIfreWvONe66+E+LtuYDt2RlYBn47MZnMYWTP1gvzY4Emcxg
 vj8g9B0cVHnF0vPhhOhwKrDcYQms78MJoWjCH+UcbKItmCwZeAJJc9N3bzRMKbQ45X4aKGdSHIk
 uRmKI7vNn4NeLAyUjT2OomlfIDRXWwOTloPBR3dsw
X-Received: by 2002:a05:6214:5291:b0:6e8:ec85:831c with SMTP id
 6a1803df08f44-6f542ae54fdmr145031446d6.35.1746703213748; 
 Thu, 08 May 2025 04:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzh6YA2cdrQFOt8aWaAlb8kNpGRRookk9WMVmVOwulJYoyOZ77BWGDUnG4ANvlRQ5bFx/QjA==
X-Received: by 2002:a17:902:e849:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22e5ede7eb5mr108724085ad.36.1746703202576; 
 Thu, 08 May 2025 04:20:02 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:01 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
Date: Thu,  8 May 2025 16:49:46 +0530
Message-Id: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX0U9emXdAC/5B
 2UsL4mcpKBC/xGNEYroJWUoS2IXyTyvyESG+z5EbqGrmBe9apSPAPZv7cItnyjbWveyyPAuPgwX
 GFeEJBev5C0ZRxduPYS0PxhhJ35M8RMeYSjMJqPrJ4c3asJCxSuUWGzgbEEF+u5KaDcOib+MUXM
 +Xe2tO5larwh5hIhUwDgoesTsDl+WENDWV0NPyuN/BeIib8fsjwLk36PHf2RtVTi8RYdQa+npO5
 BvQkKIXEeN8wI+RzjRsM/Gs7ZjdqqyJA9Ir6nUGnusbfbmpp3pLw7xDLs1XIGfthPUKaiw30haV
 Qo9y3tEKhkJQn4XIqfihW1j96lymt2/MDABn6iDYgE8p0wLuEc32RjgUCNe1sdYlSgdKfZ43tCl
 aThg8pFzOEE9riwuYW0UcgJEylXCV1172tGgD+alXa7UfNdxQFn90qBSUJm/SoBYyQU+JV10
X-Proofpoint-GUID: kfjP32Yn7n8uTR2RESL9tGxRi84iLc55
X-Proofpoint-ORIG-GUID: kfjP32Yn7n8uTR2RESL9tGxRi84iLc55
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681c9372 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=j3wMfxWsTgYEQxlLYbIA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080094
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

These patches introduce the initial support code needed
for the QTI QCS8300 SoC based IQ8 Series Platform.

Please see [1] for SoC related details

Thanks
Balaji

1 - https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf

Balaji Selvanathan (6):
  dt-bindings: power: rpmpd: Add QCS8300 Power Domain Indexes
  dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
  clk/qcom: qcs8300: Add GCC clock driver for QCS8300
  phy: qcom: Enable QMP UFS PHY driver for QCS8300
  qcom_defconfig: Enable QCS8300 clock driver
  configs: add qcs8300_defconfig

 arch/arm/dts/qcs8300-ride-u-boot.dtsi         |  19 +++
 configs/qcom_defconfig                        |   1 +
 configs/qcs8300_defconfig                     |  21 +++
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-qcs8300.c              | 146 ++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |   1 +
 .../include/dt-bindings/power/qcom-rpmpd.h    |  19 +++
 8 files changed, 216 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 configs/qcs8300_defconfig
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

-- 
2.34.1

