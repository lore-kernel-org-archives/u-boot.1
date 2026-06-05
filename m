Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A69CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFFF8493A;
	Fri,  5 Jun 2026 14:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZnVDufap";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5qBg11y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D808486D; Fri,  5 Jun 2026 11:48:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94338486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6559mDJf3016242
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 09:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=whm/0BCVu0djRnDgZdnRam5VLPaYnl6T478
 P7ZEwD1o=; b=ZnVDufaplGFls9U3IvI3a0zazPSXeGAu7ufKBTtL/BKxAbJwyH/
 QiCZH0ydlZg3yveWxb8IAaUzzlKsm0q34y3CEoIJkiimpGJE0Ov5YZp1dgwGwjpt
 enV3sFSbmssjYXk2qX6ZStcMuga4W+DxdSWwFW9HlA3PrV/V1y7G/CW84jy6E7Oz
 BvhgdO8WPZn8izgpPPRj0xnrmLqq8e2ZbRXNyabJqGr/ZUJzV3XOXBKIfyB6SU/k
 Efsg/iHi0Wi1e4pEpytAUYTzr9KyrY8PLNJih3ZEUgs+ZxSkD8ulSCX+cYGR9lGu
 ZG9b7YMP2ykZU37BjIpJRLTylHVE6k5uLhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekv56g007-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:48:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d8719bae6so1563287a91.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780652892; x=1781257692; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=whm/0BCVu0djRnDgZdnRam5VLPaYnl6T478P7ZEwD1o=;
 b=M5qBg11yGkBV9757M46rrnmuN8CyYWvpoQnECIAMQkJNqLp7LpywvHRfyhkB82PEQ4
 sKUFKkzYovMUg06AO7OIOKlbfzNWzDi1humY0XIYpX1SbVUMzkMM3QAfue+cdV5KFLb7
 QJKVudTYXhAhdxYSeMIbMsM8kAk8DbYSpXso49413YxLTNOcrJ0ojVNUW0AWydlZfLxP
 bw63Ndi9BHvDqBd10z4EAYxlkZOfyTdQVaBBo3TzQJqi5FS3CUpOKR574uZLuIt3s+Sk
 1B9NdTiPvwD/h6UUSSaPQuhT/+yjdVtOE3QHBUue5vo2FLHaoUJ5WKk9GPUZRIhdY5GG
 a3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652892; x=1781257692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whm/0BCVu0djRnDgZdnRam5VLPaYnl6T478P7ZEwD1o=;
 b=hEpfxKy6k1ozDFsUMgPGBIh2kb1y+kYc5GNCF4nEmhTiwCu1JzC4SdvLM7DwgsDlCI
 Q8PQQIiqQleNd927JlAeP3SzPxQ7OVLbpLwM4x/W8StDDDAlKyy+JbKSKAPkwChC+63I
 AMkBqXYPWuaLp0c+ipWOAiyW8nLnHYN+XC+i+7dI/PmmdKBOpi8FkKsjLfBOBh2Rde1i
 11JE1YtMHhlHMdrZH23fiWj+J4vRbpbCgHY6gLamAmUXchJSzpNs/q7Grr6zlBcyOojy
 Tyi98sfe19XDGzIzE4l6kjPIfOuRQg+u7DcHlyWlS/d2dk7DOar85LAnFgurpKtLYDj0
 6kDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PX3ZKmKywvbVryrDolRRpK13Z8JMoIQcPOg59IIqAC+hSfe7J/0FFDt9cU3qpLjrd30ww19U=@lists.denx.de
X-Gm-Message-State: AOJu0YxUgt7ajJOnc428B1TFCVwTyBE1H2UtepKeArCewnqVT+35+c75
 VDrCBwb5Bd9U7Ams4qBiT8mJQlJ3TK5HsBk8/Z3dkD1ogWrJRWFbKKFQhCQX0nEr3i+LFW0pc1a
 J9PAySHqGHVMyik/VsL3JIORGf7kLxwyKnHzHFCUK3GsPTOmjJYnZbTti
X-Gm-Gg: Acq92OFQMQ5XHhZ0xRlCI8pJcfaIvXJsFIF1kL0YQrw/1MKxhPb6QadyxBNL0t3H3+h
 uTw4HXLyjIpuHePoZS6nZDQG4k8ICeodRg3y4HgGhjf7ueKhT/BsqYGJVuof9eZimpuXw9266g6
 SKiiQXfpCGikclhP/ElfHMzBYHAT9qavBk2R14QIE+LdIdxkn/9k85sa2vHkUEZ+cAYYMS8lDlP
 LtU2lM/lZjNI3iIORES1laZADK/JcmhnlnbQz+Q1G5Rx17/9qaqi4DK/TM0n678/RMwcPlcxEHl
 oLlmIaOvTO94aZ1Vi0xvLmeYFAE7b5TQEq1KAp2exWfqOmjCkVRaTFEACK20LAtKBUSupuqHuP+
 EjDtnCL/5tCT4o5vathWlqsV8PXwYj16UWbI/AFygjxSjn07z0JBa4s6W2qYnil3rtt0c7oAzq1
 RYULikrwl2WJpDOZKHeDgMcstPo2NcFh8C9qo+c6TZOSVfXS8uSIFL
X-Received: by 2002:a17:90a:e70f:b0:368:6a6e:94dd with SMTP id
 98e67ed59e1d1-370f0f43e7dmr3376796a91.24.1780652892174; 
 Fri, 05 Jun 2026 02:48:12 -0700 (PDT)
X-Received: by 2002:a17:90a:e70f:b0:368:6a6e:94dd with SMTP id
 98e67ed59e1d1-370f0f43e7dmr3376748a91.24.1780652891698; 
 Fri, 05 Jun 2026 02:48:11 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm6208237a91.9.2026.06.05.02.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:10 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Fri,  5 Jun 2026 15:17:57 +0530
Message-Id: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5NCBTYWx0ZWRfXxPe7OlX21W2D
 RUtvynZ0Dk4ytotxRpjFPZft/kwxpRr22t96NsFvrqe0/OReY/yMSjiYbR6kRY3PG1xSBWg9yJA
 0MYXv6m12UKZk2xmOtSygCSgdVr5iBueEHTr9xx9AdoePoaHP5tbEnTXVHAxnc3oW9xnR2f3KSy
 GyiZpaFlgCp0Aq+xDgHxa0mrDL2r9YBaoo9dK3fB+bXFT4rEAEBNq4FEqG7TaRaSNRS1yrdAJWW
 eJlNaXQdHR+ueK4mgBMt7D5jPSmLXqgAgIaM9HayR5LQhJQX5/wI+O20+2c9U6TkKzY8TSL40yj
 oyHRnFloZkCx7LWKlD/qcuXIXrlbIvN8VHKI3ftHudAHuuWe3rbZY6xyYSC56Up7xB40pwJ0f3P
 oj+BTXV1VIKUI+MlEo+/+Kk/h45OQG9rYUgA/PqRV7hPznjUlOPa6HvtIe7DN4LinXGzz0YEk0E
 TgWzI/EWtyz5vw1rHjQ==
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a229b5d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=qJ7kAIfgyDNI0tkLrOAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: opvUw09gJfM96VCOjbtCWqf-08w_Rpzl
X-Proofpoint-GUID: opvUw09gJfM96VCOjbtCWqf-08w_Rpzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050094
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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

This patch series adds U-Boot support for the Qualcomm IPQ9650 SoC

This series enables:
- Clock control via GCC
- Pin multiplexing via TLMM
- eMMC boot support via SDHCI
- Serial console via GENI UART

The relevant DT files are available in linux-next [1].

Testing:
- Successfully boots to U-Boot prompt on IPQ9650 RDP488 board
- Serial console functional at 115200 baud
- eMMC detection and read/write operations verified

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq9650-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq9650-gcc.h

Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  29 ++
 configs/qcom_ipq9650_mmc_defconfig      |  57 ++++
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  95 ++++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 8 files changed, 629 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

