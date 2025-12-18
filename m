Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC4AD68BDD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF4A83C61;
	Thu, 18 Dec 2025 07:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="obfxCwZy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5TuYURN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A447083C61; Thu, 18 Dec 2025 07:16:13 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2366D83B55
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YZhU813774
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DEhk/+YzOU/LNWo+IqynUdR4CMW/263cx8m
 eS2pz/ok=; b=obfxCwZyLInDh+p3gogjfFH8k7fgo8pUFs8eixbZg5Z71vGpUVx
 7GWS5dkXbf8cAsEhhZL1Ej2HdcU/Ig24osfTXnDgbPpE2wn4RFkzGPQLN3wWe5WS
 s7F5NeDbATRkOwYuuWt7K3QQPguzEePrxc2xvpVWW2H33UJ+C7DMYFTHjNptJdto
 S4xW8KC20Y4ujNUwvHSWgrYoqE06ZYAFzPfZuGrsm5Ab7tekHbGHT0kJcEP9OeWu
 014OXzp6ps1a0Pulvu3Q2OVHg2TL/nuw4zdyREJgKVgp6/UlqmsnyR8iFwKa/iNR
 pICOltVvi7F7k6NpL6YXQcc4MGCxXRnWIOA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v79v25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ba265ee0e34so375827a12.2
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038568; x=1766643368; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DEhk/+YzOU/LNWo+IqynUdR4CMW/263cx8meS2pz/ok=;
 b=R5TuYURNOb54GolByjot7AvZjnsGdoqs/nhn4V9NAftd7Hn8+SyaGZBvy+LKbscwxu
 pzFRwhuqP/DJeOnZGi0gjwRUG0OTvozSMsolP5lNekk4ko1a6iHJ/qMgZ/NY0908To0x
 KY3l90S2fPypUWCg85Ul2VVOJAEAmb3I+SlocuoUyo+vN3jbposvgmw3Dsg1AcYkngzo
 cDYJ/pQFrxBPaMw9qlj5/kQcHWhUDNf4NIo27/y7uO6IatdwOApMusOAMj16BPtUfgdU
 4TaUw+amRUmQbpGcpFdQDOz301j8QmnPGhll9CX338M9poa1pF1dMrNNu6Pv11HBVsY5
 MS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038568; x=1766643368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEhk/+YzOU/LNWo+IqynUdR4CMW/263cx8meS2pz/ok=;
 b=VZj1WtSbJGq/F+30gulzHLnRpOythxoklh64JMOXGKSRrgzBnwQ82EXb3Q6eJZYpf2
 H1D2JGBOF7pJk/mZ4B6Hb3g/JS4Hkc9RVqhby6DJwSZ4dkBtfwRvX8L6lojhTvHtRQlb
 O9qjtNreJJfQimGLHGyJCiGH8N09Ei3qmxbyXFuyem2KMxPZKPHW8dgpdMpza3gUtkyw
 H2TbAlZu/waFt7FaBF8Hc91gZfMqj/AqbRGf7M6YFYSBTgQz9RtISRsyk6JeVrtYvPnv
 dewCy2ZMO1ysSTV4BoV8NIQuAc++1DWOsgac/sOZwWJIjpWZ9BwY2tDC8pTk39ve/mMG
 QhDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK5KkwfbKLnAEsynuY+zEbA6Dh57TVszDZg4MMj3mpZzQbkB6lK0GZLG8uKLZmjmmTF806NRA=@lists.denx.de
X-Gm-Message-State: AOJu0YyA8fsmbYzPiR5QkBXO5PiPRbahauu028INwGmyjqZ/hY02dVhh
 TdD9NklFFF5Gb8Zdo7Q3EhCPLQFAeuogjMyo7fuWfdQm7koe9adV2nWcGxqyAaMhM3nHM7itmNY
 +8S1ReR507BYoxa5bo0bqIXx5jZNBSmtfIrNv7YqTGZKczNkRjMNemrL1
X-Gm-Gg: AY/fxX48iCrR+GBHKMjIoN9rTRevZ5HIjI3zThtjlFcZL4bwZUEyJ7j0mY68hALZU1j
 bzfOtshee5zSlEoP0nIsxJz/3lwfgUoBQJf6meSo7X8LVliEU+7pLOo6XGsnFsVZz622kd7WkZS
 KEzTZR3f2bnP+uXT3OwbahSVQXzh7gvNdkxmvhkjg6aMDAuevh8ETeBj7uQv0EI8IdKZmIpVWf4
 dNl+/trNKZ0KZgJNLUS6m930pZd90m72TBDI4z2fqteZxf8aUeFAT3RxqCukoCzeJxBSRMXyvO7
 al4gQ0T5I9SL9CobeTtxc+ay1PVfm/dukTTkqkEsvFRgeUdBUU70fXepP3ERbDnXcWzbF24aJcW
 kzZBA6OphCc4Uuae2TLsPDohoHVv95tYKzRkyYtsIEUVag+Y/UN9jhPTemPhkcCEdgmakX3AJ49
 O+TcLoP+CH92ig/QjcwjUeBduJh0sPXghlun3o9WQ=
X-Received: by 2002:a05:6a20:3d84:b0:340:aead:3c with SMTP id
 adf61e73a8af0-369afa035admr18578071637.37.1766038568508; 
 Wed, 17 Dec 2025 22:16:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIXnd8o4sgSn0j0uOt4xEaThPUR/4JvVMZzfS/QLZYx4Brv9HDvawkow+1ao5zqs9zAtVlkA==
X-Received: by 2002:a05:6a20:3d84:b0:340:aead:3c with SMTP id
 adf61e73a8af0-369afa035admr18578037637.37.1766038568023; 
 Wed, 17 Dec 2025 22:16:08 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:07 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 0/6] Enable fastboot support for IPQ9574 based boards
Date: Thu, 18 Dec 2025 11:45:51 +0530
Message-Id: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8jh1CVr87KSqhAk4lBk9Y8zmWsTlbEU-
X-Proofpoint-GUID: 8jh1CVr87KSqhAk4lBk9Y8zmWsTlbEU-
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=69439c29 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dPqUMevFqatbuXeUEX0A:9
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX+WltNKUw6MoM
 UZ7UzuGM6/Bl57z5Q86tRW560zqO/lFkiG+QWip69GWLHXtlkLpmkiLS1qFxya3t8/KFTm5RZJ4
 1gnSzrx7XPP74FRso14lNVMOePPrgEFo7HPsEkt57x/ceJtwTGl/+L65ba/48EKI24hqTr8QmzS
 IpunnJ7G4/jAKqnmSHBQlIqkY+Mv/XgV1pz9U5NkLfoyODL5tdIw47RzQZJ9OuQ6psrP/hJ4svK
 1pgyutspSTHHxNFfvqf3eQYpNjh4orJmT4ro5Q3s09RYTKDbnbZ0gfJYhdD5lf0Jw7h2dsi9CIJ
 CEmJfKKxusadPoc/6ahRa8tTKTdQNOi0wheUYD6lFBIk2Ex5DFTfk5IiftTucKrUw6ul1GEx4ru
 1EmHAoq9yCzUpQm87AuVUsqLyLjFfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180049
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

This series enables MMC based fastboot flashing for IPQ9574 boards.
For this the following are added/enabled
	* USB2 & USB3 phys support
	* USB Gadget support, Fastboot-MMC related configs
	* Flashing related documentation

v2: Resend of https://lore.kernel.org/u-boot/20250715101538.4072985-1-quic_varada@quicinc.com/#t
    Rebased to latest top of tree
    Updated author and Signed-off-by email id from quicinc.com to oss.qualcomm.com

Varadarajan Narayanan (6):
  clk/qcom: Add USB related clocks for IPQ9574
  phy: Add IPQ9574 support to Qualcomm QUSB2 phy
  phy: qcom: Add QMP USB PHY driver
  configs: ipq9574: Enable fastboot support
  dts: ipq9574-rdp433-u-boot: Enable USB device mode and MMC
  doc: board/qualcomm: Update RDP flashing instructions

 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi       |    6 +
 configs/qcom_ipq9574_mmc_defconfig            |   22 +-
 doc/board/qualcomm/rdp.rst                    |   14 +
 drivers/clk/qcom/clock-ipq9574.c              |   28 +
 drivers/phy/qcom/Kconfig                      |    8 +
 drivers/phy/qcom/Makefile                     |    1 +
 drivers/phy/qcom/phy-qcom-qmp-common.h        |   62 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h   |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |   34 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h    |   36 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h    |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h    |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h        |   32 +
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v7.h    |   87 +
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h   |   78 +
 drivers/phy/qcom/phy-qcom-qmp-usb.c           | 2114 +++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h               |   15 +
 drivers/phy/qcom/phy-qcom-qusb2.c             |   42 +
 18 files changed, 2629 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb.c


base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
-- 
2.34.1

