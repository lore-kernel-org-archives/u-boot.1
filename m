Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B54C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 03:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0052982D6B;
	Wed, 21 May 2025 05:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCBehx4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A7682E17; Wed, 21 May 2025 05:53:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8164682D59
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 05:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGeK2Q028361
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=epAxql11hU+dA3Pok5KC0Vuhvl/9555h3B3
 FtxE+ZSs=; b=SCBehx4hiHBDMVnBcd8meuPvx+woRtgtWwS+164BmGjESmUFeOM
 IjIENk76n+9HmOOGoxfeGhWqklqYaUgUIE+ZWtH/IedYkYzP791Z9pujFN9902ak
 chVya9ld5zEgV5+FriDklYcL8ro3faJ/7EqkwZ4s5gd6/uakvLcSj+ZbQDe/lHxG
 EKYXJNTFE81TkvxfJfD9KADzRJkszAgUsgWkNrPd1vAChJ/U8Ygum+W4lqiaNQsD
 Cpdl6dwH1jHP+gx5/aiRTn1Ptf1jRU0dfWYIkEjR1c0ZEH+ykOxsZvlAE5yrvvW8
 UwogFyAz/kCPzXRcgeUoGAGjv0m9laJUDMA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf99cgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 03:53:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b26cdc70befso4152253a12.1
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 20:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747799614; x=1748404414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=epAxql11hU+dA3Pok5KC0Vuhvl/9555h3B3FtxE+ZSs=;
 b=YWFBTiaT92IMahGsPC2nbdXe0k3pTJB9s6MIRQrEgQUMP217NG3FHsgm3pqJdN9osY
 Elt/FNmwW8qO7WjSLPvufmvKUkIwsTIetGvcJBjFO1bxEf1gaBc0y36UqKviA+oFEJrM
 7EW7AmnviyMjHPMjH8t7i/021K+4pq533pmPdZIaCSppCj6LUNN5Q7nV/kQbohJ68T6K
 drSwNbuVqJNZS8W9b9R9ixV0FEik0Fd/uITB4yFBLGkOZjOQj+U/gskK5312iNrFQEXI
 nU+ulOPZVl9WkRq0TviISLuRko3RIbTYqv+XDi9PXXXwtyPIES/S3NsK1gdKpitbWQlU
 j9Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC9MnxOiOQBJz8ZjNK/K26I7Fz3sPx03mIalQxf2MXH6qbHnLLDRX24EVeD3wB+/flNitOdDc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0BAy56mZ9ymak68Dr6VvkSDDA3Q06tMY6KCypHMHW8t1ILO1j
 VFgF4njkFxkg/sw0KkJqUy/lmBMZayelxaZgR+wUtT7qBa/jnRCurk8iasW54Sa5VBXe70bijn0
 A4xNKn2qhcvRc5Ak+fj2Px5PK62Lo7E01KIEHY620fTsU6jATjKYrHKzT
X-Gm-Gg: ASbGncuK60U8zMulkeJWkrugfYiYrRT24vLLmGBhvVBYLHHAPgsTM6A5dWBJM6Tmj1l
 Ni3pjTbomZ/DtqAZPiUcBSmHo6EtG4ODcImRF11i6MF/YLSjh/P2xQ762F1NfPCJlz7EgAig1XC
 QDK3CI3U85WARbG+ekZ/aBKEQA2SvX2bHTJaJvkSM4aDRFdoKRpPo0KaMGSItgkAuQ/A4DdzUcL
 4p2tKlk3XiEtb4UiZ67M5Va+YZ9O5ntV1MPPw1ScoI+5DvZzYQT43hePO55Fngl0yXpP1E1IPRW
 NLRkUcss/+a9JvvK/rBRsF9JcT8a4tH9GlZLgkt/D9w23SaIiKPvHfzxXAHsbjmdOIvQKSYsFdP
 dOEapL5QPYhMNJijtm6MKEXtZoAu1qb0=
X-Received: by 2002:a05:6a20:3d83:b0:215:dfd0:fd21 with SMTP id
 adf61e73a8af0-21621a13e89mr33894699637.34.1747799614459; 
 Tue, 20 May 2025 20:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGtxrXgB0C5FstntvBPZvEPi8rOgPbrEYsbeQV8GFItGhfuWCltD0fHoq0/yIf9HqXyL5eMg==
X-Received: by 2002:a05:6a20:3d83:b0:215:dfd0:fd21 with SMTP id
 adf61e73a8af0-21621a13e89mr33894663637.34.1747799614056; 
 Tue, 20 May 2025 20:53:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97395adsm8601675b3a.75.2025.05.20.20.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 20:53:33 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/5] Introduce support for QCS615 SoC based Platform
Date: Wed, 21 May 2025 09:23:19 +0530
Message-Id: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b6SFTQtX2OOzufjXhDm5ZdsBASjYWEDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAzNSBTYWx0ZWRfX5dskRumoxPUJ
 0oC44DHLJhfqNdiuT+4IVbUOGsFfmoQn1IiDZ9kKy6Sp1oO1Vap9YDkOU5Ub7zZCNlMxIzOUavw
 Vt+MzuvXDAxxqWySAG0/ZGYuWzbr/BGwIN5bBwa+aMfsYbXV6yAtKipPLJoEVUMpS6r2G1J/gDG
 LkDKAvhN/F5O4jgzQMCEVsAjwjlsYAkRLfVchu6PkOJCOxJZ+KMR4OjTyj8qrYdhHq3nvDHI4vb
 23XusmLGj5ELl7lFWrU8P3CC+M2OFxj5hTLZxFdNyKtVfhkhE7Q+Cs9QuPtK4S3xVwodWfohyxa
 t9vu3fPcDhf8HX0bCvwHPu+dwJADjcRzLmSqBWctl1xVuj1Oho1jIxrHztQ9X5CSP3SBnBLD4vL
 z4DqstzKHB1/weNtTs+utp7KuNhmcVaanKUUiz9B75pSvGXtqMACeNFS2xJbPre0fgXjU9DJ
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682d4e50 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=jGVH8e3uw6g5-2lgv-cA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: b6SFTQtX2OOzufjXhDm5ZdsBASjYWEDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210035
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
for the Qualcomm QCS615 SoC IQ6 based Platform.

Please see [1] for SoC related details

Thanks
Aswin

1 - https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Replaced the "1" with BIT(0) in drivers/clk/qcom/clock-qcs615.c
- Link to v1: https://lore.kernel.org/u-boot/20250513110213.330495-1-aswin.murugan@oss.qualcomm.com/
---

Aswin Murugan (5):
  dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
  phy: qcom: Enable QMP UFS PHY driver for QCS615
  clk/qcom: qcs615: Add GCC clock driver for QCS615
  qcom_defconfig: Enable QCS615 clock driver
  configs: add qcs615_defconfig

 arch/arm/dts/qcs615-ride-u-boot.dtsi |  14 +++
 configs/qcom_defconfig               |   1 +
 configs/qcom_qcs615_defconfig        |  22 ++++
 drivers/clk/qcom/Kconfig             |   8 ++
 drivers/clk/qcom/Makefile            |   1 +
 drivers/clk/qcom/clock-qcs615.c      | 163 +++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c  | 127 +++++++++++++++++++++
 7 files changed, 336 insertions(+)
 create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs615_defconfig
 create mode 100644 drivers/clk/qcom/clock-qcs615.c

-- 
2.34.1

