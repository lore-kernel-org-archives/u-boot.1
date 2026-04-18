Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A40F436B1
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A39783BC8;
	Sat, 18 Apr 2026 08:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfmyG8Et";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OpXs25rK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868DB841C2; Sat, 18 Apr 2026 08:35:33 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9E383B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4UBS1296182
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6UaKx1OlirAlFdMAfaWY9c
 ybEUWzcM4OFwx4jvgXIlg=; b=GfmyG8EtQDFMOuMfyU0N05bQTQoi2e+UexkweI
 Yg+q7U/og8efy9mhMY0watDThIxC33Mxp2CPZm5KgbstD/AYCfg5JdrJ313R8BlM
 89+kz+z7lU8Y0GxdhhxI6ty5Ti0AoKWRYHWnKLw25vWFfZtxOI2oi3t9K5mJ7EuD
 EM8Udm39qnwag5Shtosze6UKszzuq2zeBaEckUokpgZm2p6d1R9B7CT5nALmXWPB
 /xtGOIBANRzGDDTFZ9lbWfMIaUSq4efDSM7QpWxP2Fz31m47eKb3273eoTZdxZxa
 2EjFRFH7Zy3YOTlUI0wvt77gMH2cQQWrQcJ2MKh+kujBuQCA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr0cxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da4795b3cso2983010a91.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776494128; x=1777098928; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6UaKx1OlirAlFdMAfaWY9cybEUWzcM4OFwx4jvgXIlg=;
 b=OpXs25rKIKL+x5PkoaLY5mCx+LzCg1buknCwuBchg3XX6ypO1w27TBdPpNItcjuRgG
 hdg3YoW9EH8kLPn9t8oT3c8HXRTLqdxrud8sXyByCqrxXohLX4igrwBWptyBW1p0K7SC
 i6JB7CkZlkBLXgaJdRZB1A36O9AmqoXnvQ2DrUbY2J9XwaIaeSNvomBNp9ins2r3LYv0
 mspazHGagpQQuC3o3VsOqIjR9Y+g1IxoMhpSVba5l1KAeoZbUf2n7RMDMLjR11LF/+0T
 aA31H8vj9mEO6FnGhtzwvgbiGswqNTXD3qL6eiKFx6O/8pl7WFb3lDJumFdA0T7X2zev
 8MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776494128; x=1777098928;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UaKx1OlirAlFdMAfaWY9cybEUWzcM4OFwx4jvgXIlg=;
 b=HMmX7oVZCfOcYiBEHMqNr1HvLlH4KXGSGYS6YQdz+UN3+sUS/geqxHQfMNXfjkmZdN
 BjX1FHMtZRXi2twqA0aHYVLudYhOK4ZShHeXgrIhSjXkefBQXbxjHm+KbodUEeqtOZ4p
 WBo4+nXfPF760IyCeeZhwSF3uMygkiNEn38KHazFzlvJz1QhlXDvyy/73Bib2Ub9xas0
 8vH8KMtxjiEnBYE2E114wGH7KxtFAkzlbAFIsIa2rNzonkF2kl0OhBYiaywe0ByzDaNm
 p8CvbYsGrzKzLSMY/CaqtjM8HACUcahqc2u9vKythhDCOgLftjIKMylXE7gq9K/Nfcv/
 LNQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vR5YfhGtGvpeWUibXIsGu3ywOzsApZKJUr8M5qZwInikVnZteE1Ho/89F2YixqAMcKGbEzuU=@lists.denx.de
X-Gm-Message-State: AOJu0YxL4xHaom+BZ8T0/GUkBz1j0xJRHIUvs4QBZp9mMDIqtBcVO5iX
 QNtxcfKYkOgiO22/xz/rOHhIOhCNpHI6rkUlv8/088bjxfco0ALJOVoxKP22yD19TMZbYCWeOZV
 /iSXSY2fHJX4uv2FTY5ySzaT/hOWcgY7mvhnclOT9V1nQeYqZaIQVWlfz
X-Gm-Gg: AeBDievHKQu5qT8N4MBItU0CnFN/qxIOuaMFLeL0546VGKUYA6dgOp4rPdYgENRcHA0
 R9nv+ByQkwxidhyFR4gzNlPR93LqRrwhI9lQZHrUprfAn/SUxQsRecPZT8sBPlpbvbNV0jHgqlM
 24y1OyUmDkcQ/dp8+D5glAgXKHRgEt/pcwyIJcMoGxsg34KjFGJLf/7xnEdp0rJAiU57hr39Iww
 M2D4CtUqTpJT8sCzGD2aig80RD2UM4WzJdk6wHn9QQtIWShVzPyQGgD5h0AU5E67tnpwthGJuw2
 n+eqrR0G7pthsZFpNEKgYEwxW21nUrEjUEGQN3/fWD322JNh8Join7P2UTiXHdIIOdIRNdzxdhQ
 qrj7VHodF3utJdiaJoz/HShReLOB8+o3L4u7+XAhlwz7Em8XWdxUziPa0yHMcDSx44fA382gIlZ
 E2kEat3OGRBO4qJiKzzSEDqb4k8E/KshnonJZnN0OVkrhXfFp/wncMiB4rFBy+
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id
 98e67ed59e1d1-361403b18c9mr6448628a91.3.1776494128225; 
 Fri, 17 Apr 2026 23:35:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5185:b0:35f:b7f5:9b3 with SMTP id
 98e67ed59e1d1-361403b18c9mr6448593a91.3.1776494127740; 
 Fri, 17 Apr 2026 23:35:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20d33sm40542345ad.63.2026.04.17.23.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:35:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/5] Enable USB3 Super-Speed support for QCM6490/SC7280
Date: Sat, 18 Apr 2026 12:05:18 +0530
Message-Id: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYm42kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ML3ez8lMzE7PjiYl0TS0sToxRjIxPLNAMloPqCotS0zAqwWdGxtbU
 A8PhMa1sAAAA=
X-Change-ID: 20260418-kodiak_ss-49942d3249f0
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776494121; l=3363;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=67yZLILWpRqUI5QgGIjNCX65IplaybmNk3Kj5SvFHkE=;
 b=194XdJXG8/MYlOIs28oUh76Z5LiPz4wBIxMoxVYhO5t9LCsz1LmrcZOUTDBIiQXDT7nV2orIR
 tOdLpz7WzFKC9HWMUR6N41LXnEE/FvfJ6554IYo+gwJsG4JpVlfQ2GN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA1OSBTYWx0ZWRfX8RjaWR3ifJ1h
 67q0ntCMbIe5lwzSGUzw641O+EDzE/Mj4rGqFZeaG2/EPhXGqIIID9T4DSK8jOdNQB2nEXrXuhr
 ysZuttEowoXfPHo3EbUVJTU5d8+2l+p1MWp9GbJ3axBlcdTmcd8GVDRsr7tQSS5dQFJZPtPnI8D
 ZkBc2ciDxSfkhjfuUqaRzPXdA3ezB4wQxkK3OtHrIqPQ5wDYIr4vim2JpMJYPdSb7ujZKuutN+k
 +Q/tlQqtXRhrSXSlZVa7GV+oXNyqAZt3uC5exPLMKinDbsAG8xsv/TbpvnM9pr1R/ezB51qnm3n
 aghYoGVMd2V+ftf7nILXQtdIi3xKbwn/nCWYOTEniOfw+NUreaxMZSeqIYeb/YZT/zlWRiHpbun
 CUVqTluVyO8YVIzmfqBfjX4Ptidz3FUm450aFJfBifqwm99loySwdHjKrzTd9eGBywYX5MEawhC
 zmYw10tuwqqtU2nLelA==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e32630 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RpT4HE000SVOpj3xW48A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HVyZh_-0-3VjJ8TRaF3wj-JVYhv6_DoT
X-Proofpoint-GUID: HVyZh_-0-3VjJ8TRaF3wj-JVYhv6_DoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180059
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

Patch 1 adds the necessary clock support.
Patch 2 implements the QMP Combo PHY driver, ported from upstream Linux
Patch 3 adds logic to skip USB High-Speed fixup if Super Speed PHY
driver support is available.
Patch 4 adds the necessary defconfig.
Patch 5 updates the Maintainers file.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- In patch 3, instead of automatically detect if SSPHY driver is
  available at runtime (which adds computational overhead), instead
  just skip HS fixup based on usb node compatible string.   
- Link to v3: https://lore.kernel.org/u-boot/20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com/#t

Changes in v3:
- Corrected regulator names in drivers/phy/qcom/phy-qcom-qmp-combo.c
- Made regulators mandatory in phy probe;
  if regulator not present, now probe fails
- Removed support to manually disable the USB HS fixup via Kconfig.
- Instead added code to automatically detect if
  SSPHY driver is available and do HS fixup only if SSPHY driver is
  not available.
- Link to v2: https://lore.kernel.org/u-boot/20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com/

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

---
Balaji Selvanathan (5):
      drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
      drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
      arm: mach-snapdragon: Skip USB fixup for qcom,sc7280-dwc3
      configs: qcm6490: Enable super-speed USB support
      MAINTAINERS: Add entry for Qualcomm PHY drivers

 MAINTAINERS                                |   1 +
 arch/arm/mach-snapdragon/of_fixup.c        |  54 ++-
 configs/qcm6490_defconfig                  |   2 +
 drivers/clk/qcom/clock-sc7280.c            |   1 +
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 644 +++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 +++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 11 files changed, 825 insertions(+), 17 deletions(-)
---
base-commit: 30429c8bd2f18d33862cc41fe520f7459fa4bfbd
change-id: 20260418-kodiak_ss-49942d3249f0

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

