Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCE8CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D9F83DEC;
	Mon, 24 Nov 2025 16:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hbB2CmoX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TUf6XnOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2644B83E3A; Mon, 24 Nov 2025 16:55:20 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C9883B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOCmAJY193729
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=dXGNumX/KihstL4b+2CqeLOHw3KtP/opkk/
 w3IlsEzY=; b=hbB2CmoXuA7nwgApiQgvTTURrEZVx4fAt86v5FZ1AMcaGjMD2ih
 o/SJeDtXjdjrdmoYhncpuM5LyFmaGv7jpA8aTSjzMuPNFbidYWyhD2D5qjUP9Da5
 8UC4w0rMKTFjeYwfcsQBZloUnJOYf4pMrDPEeUkpC25m+kbhV74oYl6BaDnwDNlH
 U7kXaHIL7Q6dYNbAchbuhPiWo8u4wANMllSnQ6tan3KBFzLJ5GlXQ14A1RCfBKas
 vpF4PDqJCNuuThxy4xzgHUp5II1emTZjjOy04QEYutgxJtiSity8odlqWKQSNmuY
 I+q1PwTP+NfbQrEYhYZDIfpz244H8jNdOvw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amqpe0ga2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b9321b9312so9457102b3a.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999715; x=1764604515; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dXGNumX/KihstL4b+2CqeLOHw3KtP/opkk/w3IlsEzY=;
 b=TUf6XnOKa88FwQ9iwC6B3JKMPgR7ecd8ZKZaRgqc6MvDHEAfZeLqA6quWrreENJ1Ox
 JGPBiLbE8SaYZOYNKKF4PN4V7lnk0cYkOhQpquNK5Fn25q/MK5d9uL7RGDPOawxMB6iN
 qGPztP4BTQUsbGRsJOOo3h+Qh6AWEy4E79aLqcuR0RFCt5YBDnlc92Q+ntzwp/JomMJp
 U68CqYeu9DmnH74onBNc/7bk+Zw0PLi7fp/jVsAHIV8XrZZEJ4kH38KAsEze1O8/9D/j
 fOHFSz/w86CCsZ3rkr78YY+ZCi31c+JSCJJIciXOn1d8tUDwwcDUphJ4sbYNwfPPhXXp
 zUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999715; x=1764604515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXGNumX/KihstL4b+2CqeLOHw3KtP/opkk/w3IlsEzY=;
 b=rT7qAo4mrY8/PsJXUX+MPb5IxK3tnWcAMbuWKPheVT1/hiR4BiylLzZqSJNWUVDzci
 r2JPyoXHRdDoJptEjVk4130KjKyuO6QAActDaPa+ee1BVeRWB5d+r8SRjU3Wmr7CqFt6
 AgXLfDl1Vp2XLFhd7Lp4p8q3nWw9UhHuAkXLDjO1QdqqVxQLkelW0RiD4K/K44miu971
 q7I9ZMrjszmmStBm9CRW2oClxsaUmpi57nmAvFdQhjwSRe531nKDTOPH/eyTf7IuF64i
 5Z1xft46zPU915DdgjvEh8s+o/oSHDSYL6YI511xzAD1e53+/T9QX8qGhgw53I/roWGF
 lQ7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKJcYvaQVYbsmyeUovjV6kiw39t9u81OZy0N56pdqF7IiDZrk/a3otd1ZY4oT/i6YTTkOYwCg=@lists.denx.de
X-Gm-Message-State: AOJu0YxaXUSOoaaIggAUGQ29MKDaa745CRdgBADZRsDNUTVsy1mzsNPn
 +jrLfQ0oyPQVV8YDJF5Xm9M1Y6qfcpU2UE7O0KdmkWGsX6fvWaY/yINMRITCLXNRXeoT8JBejSc
 lBo9TStgWXgWzvcRjybbz/AMX4I4hMXUzt2b9PIH8w7lGlpWqFKdkzF5D
X-Gm-Gg: ASbGncvf0NC1ss4AoOE99q6q4NT1N46p965G8Fap6qD5sJwlKkjJIuiFlP5upldfbSP
 /Zaeb1YK08tzYQmg7v23dcPVn9gthdcU4h80l3qYfZOxzviOGVTJBU1MF1zo8oRp8c1vgEgl9sn
 iaEBoPnwSDyiah0bR3IAdYwiRpEnB+YpsTEs1ZVlFIdVI2Ad/9mAICj3TVanbb/lP9CyWf41x2E
 R8rtXg2eEJ1XfbBpAMbYpgRBzRNZtQu7irHSJKsnNYW7sr09tP1z9HQThlCw7nh/0uHEEogt5hQ
 fDo8qilNdrPGt5+NaeSMUJMMn5hvvEu6s/DSXjo8iz5e43awsVILZyfhz0Svc7XNc3Qcfcd9VLk
 9D257ncDoTzcalxdEjagCkx2IgraLnEDLxqM3VCWHjMMgYpeU9MNSuXe0Y3nATaFsTDvq1jTHmI
 UIc7mtoMghCTCQwuW6KArrePbFGEAj90d+Jvm0PQ==
X-Received: by 2002:a05:6a00:23d6:b0:782:7052:5167 with SMTP id
 d2e1a72fcca58-7c58beb743bmr14369199b3a.6.1763999714619; 
 Mon, 24 Nov 2025 07:55:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjbvCoA+WFZ80+LA8J3/OwyHhx+dFzCV+B8fgbnh0qJDPcU46VqDRlNZo9vWLGKGaBAiXQzg==
X-Received: by 2002:a05:6a00:23d6:b0:782:7052:5167 with SMTP id
 d2e1a72fcca58-7c58beb743bmr14369103b3a.6.1763999714037; 
 Mon, 24 Nov 2025 07:55:14 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:13 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/7] Enable USB3 Super-Speed support for QCM6490/SC7280
Date: Mon, 24 Nov 2025 21:24:56 +0530
Message-Id: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfXwPajycYCoweh
 NWapDXbolmbmArGwSxeFmHsIEsds6p+YaVBF2piA079h/z77vrhBnYn/n3+IyQO23X2+eAjZRcW
 8MFe8HuhwBezEkV+P/zUlngX2Lh4dxa3dcwJGPgtmr6L2/RgQYn5/S0gufSBtM67FKTm9hz6czJ
 zbf39kop4jtahnR8AX0ow0OPepgQziShT5PEfDsymxpgjOYRZ4h2ZLbHarP/66ZXbcuJkJ5eOif
 qLh8hjw7y4zp8UuSwK/awGqmbVBx9dqD4dybno29nlQ9i7UV86lEvcQiQ3odEiRZw1SdPg/mvj2
 u7Tb3Lu80yv7R2lVuK0Og9JEkRKriLnOKdLQgElxpeDnZG9tSiQnTWiLZWoqIi5JWfGT9PK42kh
 NijVeMj1ykeFwlxMyxAG/RkUUpT4Kg==
X-Authority-Analysis: v=2.4 cv=OYuVzxTY c=1 sm=1 tr=0 ts=69247fe3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V6pe9Ag7if0Pk3vUvJMA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: sIWpxuUCeqVDYLkDr8PYAEMWP1F1Eaqs
X-Proofpoint-ORIG-GUID: sIWpxuUCeqVDYLkDr8PYAEMWP1F1Eaqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

This series enables USB3 Super-Speed functionality on QCM6490 and SC7280
platforms by adding support for the QMP USB3-DP Combo PHY. The combo PHY
is a dual-mode PHY that can operate in either USB3 or DisplayPort mode,
and this implementation focuses on USB3 mode to enable Super-Speed USB
support.

The series adds the necessary clock support, implements the
QMP Combo PHY driver ported from upstream Linux, and makes USB speed
fixup configurable.
---
Changes in v2:
- Gave correct commit id for reference linux implementation for
  adding mdelay in drivers/usb/dwc3/core.c
- In drivers/phy/qcom/phy-qcom-qmp-combo.c:
	- Added pipe clock disable in qmp_combo_power_off sequence
	- Added all required clocks except pipe clock
          in qmp_combo_phy_clk_l
	- All clocks except pipe clock are enabled and disabled
	  seperate from pipe clock
	- Added support for regulator power supplies
	- Added a minimal xlate to only return the USB3 phy
- Added "drivers/phy/qcom" to ARM SNAPDRAGON section in MAINTAINERS file
- Link to v1: https://lore.kernel.org/u-boot/20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com/
--- 

Balaji Selvanathan (7):
  drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
  drivers: usb: dwc3: Add delay after core soft reset
  drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
  arch: arm: mach-snapdragon: Make USB speed fixup configurable
  arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY clocks
  configs: qcm6490: Enable super-speed USB support
  MAINTAINERS: Add entry for Qualcomm PHY drivers

 MAINTAINERS                                |   1 +
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi   |   8 +
 arch/arm/mach-snapdragon/Kconfig           |  10 +
 arch/arm/mach-snapdragon/of_fixup.c        |   4 +
 configs/qcm6490_defconfig                  |   5 +
 drivers/clk/qcom/clock-sc7280.c            |   1 +
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 642 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 drivers/usb/dwc3/core.c                    |   2 +
 14 files changed, 813 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

-- 
2.34.1

