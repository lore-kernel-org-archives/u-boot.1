Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CF4FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B36B84119;
	Mon, 27 Apr 2026 11:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h7ffcpwz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bloiIPsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACB184120; Mon, 27 Apr 2026 11:26:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0821183693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8T7JS2913800
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z+sKBwop1HMNLjsOouPy/i
 6isH5UtfIndqo8G8dptXw=; b=h7ffcpwzoGjbrf2jkr6X8RIej+2bSBMkR8tXMi
 XAXhDhuGj5xLjxGBOAgKlWL2jFEcNaas6diiLxQlUcsZV6H/NpHtMIzQ5QWFQ0ru
 ETCrbPDuCy5+F7kTLPTfgbxxoDkD0VXHWrfwh4xZQegB8PoSwRXI9CGTZ/jMO4wF
 5TgF+2W4DAEtah9GCBKFWLx2l6edRpXMr4mV+OohUjTepC7XLnAtRdWnUa9bmuck
 A9xkd35azQSHKSo/KEALQ836M15FOpaBmZ6LPkiofrzXXzVaZtg99Z7JRAMoPKKP
 rebq4jSTUk68EYtTB3i6TFdROhvQ+LSAEZySBWuM0FBt2K5Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xgtmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f2138a9e0so6148264b3a.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777281973; x=1777886773; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z+sKBwop1HMNLjsOouPy/i6isH5UtfIndqo8G8dptXw=;
 b=bloiIPsShhpGmKsKFGDeWQLiB722rpYA7B7ly25gKrT0xQtfwl4QLGKevyGzoVR6oS
 8XybOAeYxJqTVxuxRI7RJiOk4OKV9q+v/k0IBskWet9r8c4TdpZOjaV9+VibU2rj1Fn+
 Tb6+wk1yuJY6Ztsg0JheVFFq5432vP21pch+VBNucm3x2Gf9VOe7ff1dRs+2vEcawaNF
 jacktIwz7+rm060uxbO9jifUUczAxemwCrlYAetidWHRR6l4J1atUJw4odwudCB0iLFI
 i9qVx9K7DMr3jeEY9b3DsM7zuc0Ut9dcPQd7BO+l7Wg1ckW3fbGD1VGoEvxReoo2In9v
 +isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281973; x=1777886773;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+sKBwop1HMNLjsOouPy/i6isH5UtfIndqo8G8dptXw=;
 b=cp1Y4MgAWF263scqlRfxNwCQueHz+wBEKT9DUnUyaxGq986mcF7tSF74XJTpvcyWgU
 EoDL7SRrAkgIXRcSWrwQMu1j0mSaUqRnbJ+IOugqBVn1CmBX3xyNKYLVIaIthuylZlVD
 bY5P34TJcXzvM+DyXvb9r+DlGbRDBStQdnLKJmM11HILGMD9moriui+W2A6hHiRolN+U
 5UiW3F3PLuroL87hdsoNpfFniCG9Wul6Pfcx6K921toBREYUfRC/BMIqsYzMqA67Q7kq
 M8u6BuZh5IGe4aleKvX/5UjcpIKv1tI4VinHzh/DEGSR9t114Cv2c5yscoVQKRGlzqX/
 vQRg==
X-Gm-Message-State: AOJu0YyjlcfJbdwizM5pFzJqcXf+U+ibkvs81WjZxdbylDvLOGVu2uCn
 LEYLFCwynt9++1C2Fw3IpqIeMWEQu/FSK26iIKSpHpZNPYtZesViy5svu7zdw9z0jOL+gV6Q0FJ
 2yqFald4e/SRxxaXUfKzdWpQWO0n9ULq6gy2nGUTUnTrtOOoTtGcYXT8O
X-Gm-Gg: AeBDietVOHfK2A60UG2AGJ5kRvU5uG8T4m22VrRaKS6QJJRL3h+UkfHSAhEPmr1v3fC
 AeEr1bOo3ThimpMp2C/UmyyqfLirOGsCLpJo/n6/pcHMyv3+uUFcpQM2+wJnjQCPjFb35jnJYo1
 gyhLN0HvD2j15olELz3KfEpL2aKNA7z7Yy44THJ6UqtT5/ziG435ZXn4QG+YOULy9WjjfBRziVA
 qX767sB5T2CQBafNB4jSzXBOOJLfAZb7g3adkjCbSUtae9XqQLkeZioyTlyJEJVtbq6wFoZe9Th
 GB/HbsTMdYbE1MDFXj9fOSCTDiJYp76kozQvOUAJWQh7WNpBJ8U0hosWZAZv0gJ1bFR2AnLBn0v
 osVtRkGRWylm5BBSjR/9CU8xjvoLcJSqE358xuAtKtOz2h5PWlPhJSbjjAx/n+DHbak5/aFzrxs
 5Wy4jDiV1qATyFsXS/TQgSrkAQdoIS6YfW6TwPwEQMzih1TzduD5PRk0KiZa+1
X-Received: by 2002:a05:6a00:368c:b0:82f:6bd2:eac5 with SMTP id
 d2e1a72fcca58-82f8c7eee6bmr40556527b3a.2.1777281973327; 
 Mon, 27 Apr 2026 02:26:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:368c:b0:82f:6bd2:eac5 with SMTP id
 d2e1a72fcca58-82f8c7eee6bmr40556485b3a.2.1777281972847; 
 Mon, 27 Apr 2026 02:26:12 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/7] Add UFS clock support for Qualcomm SoCs
Date: Mon, 27 Apr 2026 14:56:04 +0530
Message-Id: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKwr72kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3dK04vjknGxdE8tkS0PzxLSkZLM0JaDqgqLUtMwKsEnRsbW1AJA
 8ka5ZAAAA
X-Change-ID: 20260427-ufs_clk-49c917afbc6f
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=1961;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RxDkIwrFduNp7ziglQy7GG4D7uqJyaba0dshrFxrtRI=;
 b=5azuzqCQh+6SP4OE29qcWyCcklSzcFyC0b1Kq2Dnjl7T5Vp3VgrJMpmohOLcbuMwcDs2DzpXh
 g/Gdp8Lf48vDCYoXl5cKvL8v9GXafaZFGlBLIFCmPDWVcAFQWxHkCwe
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: SlJUSrjQZ0RTXRkYY_CI5iWpVNKBObQr
X-Proofpoint-ORIG-GUID: SlJUSrjQZ0RTXRkYY_CI5iWpVNKBObQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfXy4UQgZtKgCD6
 Slijy4s2q2A5jAe8JVJtr+vZudBUCUIKwSJ2BGhO7yvqjpv83v/I0CjrVG8B5BDihUnj6EMfn90
 khqB21NHOiOXYoqu7LnQY9LWoEMpF2UCUcyOGIYWD1OfrLr4RdCvwubCN3yrGh8szg3FzFu72pL
 Y9kvJAGRPc1ojLEzlscLyNMjPQsWbrjBvl+UqVa3jByhy43bhCyOxdZ8aFY36sce/kCKb8xdDIH
 N1Pf7kB45CSKRuTCstPlVwRsisYUuiNMzhRZ19TNK0OMaNQapzgyv2PXUYIP9LHuk7iPIP2b+E/
 tzzJN8nYjCdjDJ3+pmMI+zu1IMrpfKkqqgRMQ5slKESc302q+xHlOYymZ9l0tjoYYb+Du31poRx
 AFxHB0l6oJ3SBYZTVKhIFBmIbzZnjvYfhTYWvQsqQQDK5U/e2M/WjmCXJ8h6SYt3V4sdZgkApIJ
 euEY/mdQkBa55dGHNRQ==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef2bb6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V3U1HHDMRsKDiLb_Of8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

This series adds UFS clock support for QCS615, SA8775P SoCs and
enables U-Boot to initialize UFS clocks independently.

Previously, U-Boot depended on earlier bootloader stages to
initialize UFS clocks. When these bootloaders failed to do so,
UFS registers became inaccessible, preventing UFS initialization.
This series removes that dependency by adding clock infrastructure
and enabling U-Boot to configure UFS clocks directly.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Sort compatibles in drivers/clk/clk-stub.c alphabetically 
- Remove duplicate sc7280 compatible which was already there
- Remove ufs_qcom_init_clks function and move the clock enabling and
  rate set codes to ufs_qcom_init
- Remove ufs_qcom_setup_clocks POST_CHANGE duplicate call
- Link to v1: https://lore.kernel.org/u-boot/20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com/

---
Balaji Selvanathan (7):
      clk: stub: Sort compatible strings alphabetically
      clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P
      clk: qcom: sa8775p: Add UFS clock support
      clk: qcom: qcs615: Add UFS clock support
      clk: qcom: sc7280: Add UFS clock support
      drivers: ufs: qcom: Initialize and enable clocks before hardware access
      ufs: qcom: Remove redundant POST_CHANGE clock setup call

 drivers/clk/clk-stub.c           |  6 ++--
 drivers/clk/qcom/clock-qcs615.c  | 63 +++++++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clock-sa8775p.c | 63 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sc7280.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.c           | 54 ++++++++++++++++++++++------------
 5 files changed, 217 insertions(+), 21 deletions(-)
---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260427-ufs_clk-49c917afbc6f

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

