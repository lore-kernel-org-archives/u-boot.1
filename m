Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E0DC3ABCB
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D938129F;
	Wed, 14 May 2025 06:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUOR3nec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9DB82162; Wed, 14 May 2025 06:42:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0581580107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E1nCDA012565
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6OESsXh2WXPyoYETWGdvQIChtqjQ5T8GAhw
 A2XuPtAU=; b=UUOR3necfnWA5IQ3PDtWV23h2a0MER/IOY6w/lSJ/aw7KdVrRY/
 io5Ju+F7hsFh+IvpI4ZCYrZTwmj7oNFtl5dMH6U76uwBU3OhhlH4oHe1d7SBukOZ
 0CEG/ryQSCJO3whu2cHN6VzvuArMb02ccz86DpRr0sEy6D1ALgO6IxP9DJWj3f8s
 V3cO+iPEkRXU/MXE4g5gIJVWOAdbU7dnDGqsiXGcJYA2XrD6otvy1YIp0zKOFTwn
 TEsKwB0PBddUS3uzkZ/fcHP6gC/CuzEMKhjREo2qpajIZH9rOKAWzF+UUOfdD6Cl
 66XbiFaouYexr9mEH/53o2JmxU7hU/BGk/Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcp9bvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-742512d307bso4968987b3a.3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197743; x=1747802543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6OESsXh2WXPyoYETWGdvQIChtqjQ5T8GAhwA2XuPtAU=;
 b=YiitUL09ldb5zLTDM4cqDu4UDusPp3t0wjTfdww2vgc/A8MsrTNvI74xVzuoEywVJG
 wld77Ig0U362vAxJjmqeLyF0pKHVfZsWMzlCbnZNw9it851Ht0NSbawthwDorBi9lsFS
 38h15WNqbG0ct9kZek2/ol0HW1eKPf3XSRuYh53tBNDTL0YCq4MKW2N+beHuRJj2UGVb
 1VE+x+CBt6yNUyW6aHsljRkgqK6GDjGufHrdIdwv9Q77N+ll71xUpZcIOK/h8keZwLfl
 sjBKDUlDWQvUR9mugCi/vXof920huJB2MlkFS7tgq8OsdjsqzhhUm31H/MERC07eB+Jk
 V0Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBiKHuv8WPxr3dasb4EDLJ+7YGUj1bo0IOy0gNFUIhius05yCoaOgKFWL5S7Tft6dGeIFLQu4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz/Ze5CPm+NL7Wi9LLiUTN+iY4C4YrcIyKLhJid10crHA/cmtV
 Z2eOPAgAOemP8uAODlUVU+loRid/s2k7E0aJJ7BIifuToFGvzs5qhhAZrG59cPTiq+44VNcV+2r
 H/nBRigx8HAD2hdo96HwRPHukPHXlto03c+deriAgLxOXpPM4QQ80
X-Gm-Gg: ASbGncsbr41anapKRxRskZJ43I6YRPvW1ZkJhVVML2NiPsHrmS6PPVrkQhA8WX3aQZf
 Fwr7wdl4qDFBtVEkexkH5c/lDzNdo269X2gaaM8rlvY4dF85QiGj28CXaDsc5wX/pGx8TokA/QX
 pHNyMjuyOxXw6R35+01/NYD2O4m/wwA0EirXx6nWhROEKH5NKOEdGA2KJDtTWbTCv7UVlkEL2lD
 T974/YbKjv62OSVDdtjGaBnCyJzuQ4W6yZznAQAYgxNqVPO2uB25GeY++tvYCQjB8YS59BKWoK4
 sKjnoAgE4+g0LYgnHEoM284gEr8hM5cVBRXgFQzys11HfY9jPangz24cEnkKcTkVERFLCi3ySk8
 7iC1rOUY1+eWRGdbs/YPlxS+UWee/XSt5k1p50X0X
X-Received: by 2002:a05:6a20:d045:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-215ff1b63admr2488337637.38.1747197743247; 
 Tue, 13 May 2025 21:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+nYZUt0SiUvTg89qjwpoIGlZjILXr+hNfI48Ylddfm69g1X+V9Uev2Q6PlQO5XNHYWR6oOQ==
X-Received: by 2002:a05:6a20:d045:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-215ff1b63admr2488288637.38.1747197742817; 
 Tue, 13 May 2025 21:42:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
Date: Wed, 14 May 2025 10:12:06 +0530
Message-Id: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Mbd0by9at4Cy56ZZJD4uBPNIUh0zAHV
X-Proofpoint-ORIG-GUID: 2Mbd0by9at4Cy56ZZJD4uBPNIUh0zAHV
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68241f30 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=plaP86i05TW429YolQ4A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX3XTVwmOtJz0F
 RtHKlZpkw03hlGiJDPlwo23q4CszI3D5OykSG0z9YrSeM7gWc5jF+EGEXDvIabFAjioS9buRWUd
 pEnU5eVKisEJOlKRKUct2CExKZ5cKtpjkAkKvzwzC2K0nQH/k1KAEBNb2Esv/Kkl+Ni1m62+KIa
 L5dy31H/MRhB5ZSxE5yLX+YVHXbCnRMWKRHm7yvCngfnTHGHSjkrXQb3pQYwCJHDX2WEuG/2tfJ
 Osfpc5fAjD4opZ/tLrbxf0AqpiGhFyK/KER/Oqt0e4PdahoQuXczBb8RaUSAKW988rcPMG+XQ/H
 TfKG4v3jo4gAWSYVDze9BrOE9gcl5sOyLXiBWm6U5X5C+AWXR0k+VkeLTqk2cAONdN+s+QhHVpr
 t2AkupmPtxy/Q3zgtFiT7EBPobY0MnAVwWDmwcWK/vwo+1V5X8/b+WbLh/BK8gPMxfoopP1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140039
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
for the Qualcomm Dragonwing QCS8300 SoC based IQ8 Series Platform.
For information on supported boards and build instructions please
refer to doc/board/qualcomm/dragonwing.rst file.

Please see [1] for SoC related details

1 - https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added documentation file for Qualcomm Dragonwing
  series (doc/board/qualcomm/dragonwing.rst)
- Removed direct changes done to dts/upstream subtree
  (in dts/upstream/include/dt-bindings/power/qcom-rpmpd.h)
- Took care of alphabetical order in drivers/clk/qcom/Kconfig
  and drivers/clk/qcom/Makefile
- Took care of alphabetical order in configs/qcom_defconfig
- Renamed "configs/qcs8300_defconfig" to"configs/qcom_qcs8300_defconfig"
- Link to v1: https://lore.kernel.org/u-boot/20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com/ 

---


Balaji Selvanathan (6):
  doc: board: qualcomm: document Dragonwing board building/flashing
  dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
  clk/qcom: qcs8300: Add GCC clock driver for QCS8300
  phy: qcom: Enable QMP UFS PHY driver for QCS8300
  qcom_defconfig: Enable QCS8300 clock driver
  configs: add qcs8300_defconfig

 arch/arm/dts/qcs8300-ride-u-boot.dtsi |  19 ++++
 configs/qcom_defconfig                |   1 +
 configs/qcom_qcs8300_defconfig        |  21 ++++
 doc/board/qualcomm/dragonwing.rst     |  41 ++++++++
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-qcs8300.c      | 146 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
 8 files changed, 238 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs8300_defconfig
 create mode 100644 doc/board/qualcomm/dragonwing.rst
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

-- 
2.34.1

