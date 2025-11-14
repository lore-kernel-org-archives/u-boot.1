Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB3CDE006
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 06:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725E183E83;
	Fri, 14 Nov 2025 07:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KmVRtgfN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LcDQpdu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAAC483EB7; Fri, 14 Nov 2025 07:38:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB9C83E76
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AE41H3C2263213
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fiQmfva3QgWumBbwjiR+LARBxiEEmSiRE3A
 r1VCaJYE=; b=KmVRtgfNonGc3H0PNPBX3QokZY6wwpd8HLe04F20Ro3VRPiy6Co
 3UObX0Ch8+jOYcY78BbCioFjM69GFVtiXHmTaCSy4eohp+BtdCVo14Rz3WqqeLYm
 5G+Df734hNuPVL1JSI2cbYnCFWTGvKTDWJdhSwKTHjyPj8+eF7Ly3F3tMzeFUkk4
 En2cBPN4MmgOmAprckZxnAv5/m2ZH1VKAXLOPfy3NS84gEOBxqYSiJ3thkST/53Q
 bPhnN1OOyzfXk1fJLlKuapL7ZcUm+PTrpl8a/au3exSY9D45XF/7NxM1tF/1/+QY
 dnqhwzHGXO/qbKmdzPlDbJJkhTTqJyzDm2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adw1j0bpq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:38:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-343806688cbso2518992a91.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763102292; x=1763707092; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fiQmfva3QgWumBbwjiR+LARBxiEEmSiRE3Ar1VCaJYE=;
 b=LcDQpdu/5rnXi3lp3DXhXh0fZwezrO6di7aMEllbWfP8X00ZPaiCsbK8/AAJ2ninhC
 uRkonwsSJKSifg9CZqscd3ERe2oiYsnrhaOG2yX967CgCq1JAbBJTFoM9VZYA6wjTcGp
 06MiuO6NPbnAKcbfTv98i1sJ3Fe4V62wwjdLWXV4aG/GJvqPL8Jo8RHAKCPjEvcUSGrZ
 XYMLPjdXzHQ1ZszEyB5aF0ByUQhZ9Z6Fz4jvMcBsCrO/k9+T2fQMB/SOfgs78oAnJSnb
 I9Eq3NM2JAnAD8fk9heZtDG+LOz0LzQnTLqlMHlivQ371KaS4/R56ro5WQRiVV+OJ6bn
 QTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102292; x=1763707092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiQmfva3QgWumBbwjiR+LARBxiEEmSiRE3Ar1VCaJYE=;
 b=BMDZ9+BPFk1jcwteOzD0rmTkbNm48qcyIbnwqvpuvPGQNRGkBtd1jUtIQ9FfHmBijw
 eG1rIHnxVM57KV27sdOgMzElweNWXf5OTOllU757N+IFu3Et7D8TOJfxq23XHD2DWrya
 dNhhVUehnwN+PRhourM4ONY2qtf1png0cFc82tSCMCxl9v7VDJ7gR3VJW7Rwdxq2cQcv
 /U/cW2MlyV7Ijw1USjGnOWWgmx3mKGOrXDfcLmuYJpIw9+YZE7ihBEMIpyKXekTDPNuB
 X3C0+hrk6tFTL3OQhJlvnLRHpWE1LCUBkGnD/ZNRuMolOYsiAlF28FfQ/fLnOHa33RQ9
 NCbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5MQHHQ5R7/XZqL0P87MMHn9+K8n+rbEd4mxOoi0bmELJtOH5BN3x83WLUFzNpWhPSjO0C5JU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUxyjhPI1S5GZ/Det9QkD0aYh+LttE0d2zUGKO8rYy/viOZVgo
 ueNM+QVaF+DiiCCKuGBv9VM+G5x4v//KgEuJM3kPemfUr6/FXmrLhvMTqb7cd//t8RbhWyDsRqy
 hZo9+PmgXPq4OARJ0CP2qyP+W6z7aZopofhYCmXJp4i/I19e6rwb4Ttw+
X-Gm-Gg: ASbGncsREQEGMDFuA7cqWofipcP4950jKVtFsVZStus7HRWVxI94RG6+YN0e3XXn6gq
 7RdXUsiEI0FzWYHke9gcv2ym4NQm+c5kGAB9n9ZAHXfJctU5CxBJDLO7354jHANfaRSecuBXRfT
 b0HPZj/1bVu+VCusEKpVxQ4I1y/NYkf01DFZ5aWEF4ixq8+51MZmlzPO5lAsEw72UrTldbsquIh
 BaPguxLmZE4xfuaEaXZlmPxD5fO2Ld0pTrXJxiUzKyV6K/Dx5jtIIhE4nY7/HbD7ZQEr1+OthTC
 zFTLuDtu1Ldg47eppWoQnK4Mi3RiEnizEgER/MZS0mmuLw7u0BtEepjGYBwjB3Hrpd6cr4T301p
 VK79YGGhrEUzK27A26peh/5V3/zWrqP6dO/RhgRx5P6700H8LhO/toAJrh6TEmCLCQeGfv3a/WP
 sg+n/HXZc4fvn9MH9G1SVrPlkDkUsuubwWTggx2g==
X-Received: by 2002:a17:90b:3bd0:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-343fa63784fmr2237071a91.18.1763102291969; 
 Thu, 13 Nov 2025 22:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Ar6gIxRq/OzPUWlQ2SsVpXsFuvmzRSA2qW2RYR7X1jKHWNRGmDwBilukJGhlSh97NfwKYQ==
X-Received: by 2002:a17:90b:3bd0:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-343fa63784fmr2237038a91.18.1763102291432; 
 Thu, 13 Nov 2025 22:38:11 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343eac7fc34sm2706559a91.1.2025.11.13.22.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 22:38:11 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/3] Enable USB High-Speed support for QCS615
Date: Fri, 14 Nov 2025 12:08:01 +0530
Message-Id: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=6916ce54 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VU-rvD8WSPbzTW42ELsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA1MCBTYWx0ZWRfX/GG+NnEuGwQx
 j+Sxt6Ag5A3AV0QH3nnWS+/jPrBhSclcqnRLpl7qvzhAZRzMBfedN5+9thdYoCafmRCGa9GW0Oa
 mQfBE4smAFrqHyXJGd8bVg8mLFvDeKZBHTfGI5N/+Y3QDHCvfDh7QFrwpE1c9/SQOKLHhnAzlGA
 FHBhvOC5Vf7w66lu9CJu/BGseK1C3iQdqciJ5B75DzVJ7xINxFsWodiPqd433Nbr8UMqOstYaYt
 ni/ptUhY2vG+596x6ELwt+i9eUm0hYT2r3QIaypEMKXVc6KpZR/yoKI95C/2gj+vpU1P5mur4z5
 v0JxhbtCl03g6I0wwegwaX/NgYzARP9bY528yD6c8lOR4nRCUL7mlVksU4vwzcH+qVywBpo5yI2
 R6PhuiQ2jeZzzktJaJC497yacoKnyw==
X-Proofpoint-ORIG-GUID: UDDYpvt1TDSOsdn29xih9DpigHA1U9c-
X-Proofpoint-GUID: UDDYpvt1TDSOsdn29xih9DpigHA1U9c-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140050
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

This series enables USB High-Speed functionality on QCS615 by
fixing clock configuration and adding QUSB2 PHY support.

Balaji Selvanathan (3):
  arm: dts: qcs615-ride: Remove unsupported USB clock reference
  clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
  phy: qcom: qusb2: Add QCS615 QUSB2 PHY support

 arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++
 drivers/clk/qcom/clock-qcs615.c      |  1 +
 drivers/phy/qcom/phy-qcom-qusb2.c    | 38 ++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

-- 
2.34.1
