Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B095D2ED11
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA08839DF;
	Tue, 20 Jan 2026 05:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZpj/PGS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEfh99CU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95A48389A; Tue, 20 Jan 2026 05:26:06 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE60F8063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JG2Tt11904955
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=RNsCnIifwx+lJd8XAnHSD0NAcR0ruXSRa5i
 OP2IZVnQ=; b=cZpj/PGSKmVEFJ6hoX7n+x1rlrFUxk1W+UtgwRinjBXl9zQot5c
 KBeIRW1pD7nRcl6pF0yuHImoWxg/aqymoM/z57d/50KZeGX7tvbDsW+Wr35yTlLM
 fPUem3401XTMkSmsWCuvwDL8/SLb+UAdXCf6X4krDpfb6jzNrJmOCFmpdJQwHZj1
 oSBRUX00sR2k2V9s5RxAhOAaDaeifwTPbhvmFPujoIgY2HwAJFjCDTM/EAQiWZpK
 LINWzn4VGVEjcdRrvVOGF5PNxD9ecw7MfW3po1AP3oPkslG7Lwx5ogFrfrfHmdhw
 fnC99iykv99Neu0SoJkugXwA4rdKSEXU4NQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmuaypk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:26:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a13be531b2so47274425ad.2
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768883159; x=1769487959; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNsCnIifwx+lJd8XAnHSD0NAcR0ruXSRa5iOP2IZVnQ=;
 b=LEfh99CUy3ZdrsC2pd7HxB6clZECzel4U+8pjTG9qM+oKX4ECRpTGPfeu7Aa54Sy0g
 54WpwvjYLH5xvOsfyPuMxzOxhleZJRnwQdj14nMWbZHZMMeiZ4ymSa9/bQcO2JQ3+LXy
 GBvhd5QUetdi4k29TXBJiAK7z0FybzEK7H4fRJZqNcqxIXIk1lfz0Kk48YD39E/8zN84
 0A5Es5EvIlae/Dvccxfd4Q27PZcZds7EHIgZaK0UX/Zub2HLbpEGNo35vI6TzAbrohO9
 EPg+8vLeAe82SiM1/iwVxpN1e0BEsNs7o7/0gt/At4wagZRsm61hfdvYvtSdsabw1WGf
 NFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768883159; x=1769487959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNsCnIifwx+lJd8XAnHSD0NAcR0ruXSRa5iOP2IZVnQ=;
 b=mh5L9n4iEnvrAqvVlWarUAFL6YnijL/ZeqKdjlJYLujONE82OthjUCLhiLGpg5LYpb
 uhqgcq6Pxeja/hL+B5lz/6x5KwA0J+6G0qdYdUtiz4gMAXZUKKYldNOvUJd79pgenYzC
 D7hufJaKr/8gIh7N7uiyjfvAWg6Ux6sJ2L7zVgGIRNyNOAEdo2X4lLzkGpzN51KYpB2A
 OW7fln6R+ApOK1kU4m8ymeQHSbYd5cmGWSBYE5m3wNVE8o1eZkk7Ru9t8OemhTKEVG92
 i+3IwV1BKB1tBM00NoRvVVkBkETdDytUkZ2H4gCx0uw/la3wCefCuVpQb8OKC8fAtBd7
 soCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb3OdGdQwasOewlmsh60jrNsV20h5+zj2hup20slezs+DXNaW5iMx6Nu2sTBYogM3WVTPVQ8I=@lists.denx.de
X-Gm-Message-State: AOJu0YzciLfcJ54MA/5SE4q66HjvTspNO7YNm1LYsgmFwYd/g/1n/PTe
 qIXkxoSgbQgLkOaKn1CKv4/uTcc3ON8Ccm0MtdU5g5RDDNkJjehGpAxxgiJJNop/kT+WvCsJxDq
 3iZmslzEiOI98ueVkim1oIIEe/znrdLtkx013i13pdMeOUZsNI/Uqzct+
X-Gm-Gg: AZuq6aJEFE4v16/wEAdHxwcjWxQ3aEAp2hP1gQczB+zFPk3V8gXRDPXN/0NFt/EPWDL
 ccXAsU656UL0gm7iBJo0ktY2oG6oCR2RgWBmLriLpvk9HdzGl11xRYntYwPiD3qcck7YkoM14Ni
 4fErgrk8cLqx6GpEnUW7QtMh/YrOpF5hauZ9w71bPPzi6qV46uYp0S/n/kaI6O6NS/7hkNvrbBC
 438SPp3SlVZ07SgHD2egRD0Cl0Q+MOlGmyKb3H3819EwNujt5WrqcBqHYCG+/07UstphFuZ5k3L
 99NT1iyx5ANxwb4tSTa/qam6E+yMYeXVrIKgo6O6ym0aCF+R6XxsFCIBFNbWnpzp0N0OrcqNmMF
 gjJP3sRBakoHcvqZsAfYpAZqR+SXKFSk1i8CI5zKxlkBuZ0mvVk8TeqKM999/7z8wDfklNELToi
 vJRFbM4A0ns8eaK5dBfs++koSrhjMWGI/fZJtTtQ==
X-Received: by 2002:a17:903:15c7:b0:2a1:243:94a5 with SMTP id
 d9443c01a7336-2a7177d43d6mr124990515ad.47.1768883159018; 
 Mon, 19 Jan 2026 20:25:59 -0800 (PST)
X-Received: by 2002:a17:903:15c7:b0:2a1:243:94a5 with SMTP id
 d9443c01a7336-2a7177d43d6mr124990305ad.47.1768883158535; 
 Mon, 19 Jan 2026 20:25:58 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eeefasm107929825ad.43.2026.01.19.20.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 20:25:58 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 alexeymin@postmarketos.org, nathbappai@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v2 0/3] Enable USB High-Speed support for QCS615
Date: Tue, 20 Jan 2026 09:55:48 +0530
Message-Id: <20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzNCBTYWx0ZWRfXyQPkNrut/r9H
 WjNo98ewgJEJQq/OUDIHluwED7t3UI6THPUNMseombgvtDwAYf3DifoA3rtnEE/B8RQ0rLaQaNY
 sFXGlWU/xbgfVZ3z5IV7PhVbTLpZ6dwGUNtp9mNTm2eefS0X48C1nTwqeyVxTgwk5H/HiHdmsLj
 fXHUt+mUfrURVx+Mi7pCmO2PpiDyRhc80lxufh6ZvDkJsMx8qx9Ns4qxauij71F+3fhcQ+Fvtar
 yoc/MJh7vbPYE/jy9dJ20tGy287826PQ+QdtIAiqi4GuPb+NbblkRIcrYBQsh17//Hm8fOh/TOl
 XSKzzcjYoX6WK+BdLRRED93UcQn2644cnlbsx6LmsUHcapFW+BTUssjU88KMWzo253BR3gsVBEk
 t88lsCe39cZQiaqTT2qI2V7dylTFkvB6hKP8SZKQLlfotpEdsHTxRHbN3O6N3XyA2ExTS4hfkud
 N15F8gIjPgQ4L78vWAA==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696f03d8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P1fMdDPJ5jww-FhAG4MA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: eUQF7auiEnzszQWc_j4T3_18kEKxFcbv
X-Proofpoint-GUID: eUQF7auiEnzszQWc_j4T3_18kEKxFcbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200034
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
---
Changes in v2:
- Updated to the reference commit for the QCS615 QUSB2 PHY support
- Link to v1: https://lore.kernel.org/u-boot/20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com/

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

