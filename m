Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F9CF8A16F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB608407E;
	Thu, 16 Apr 2026 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NrBqw4at";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMlMmpfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2E0841D5; Thu, 16 Apr 2026 07:39:50 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B036483C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1FGii3733617
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=2bNhNFrYDkVjFXm2p0Im0TVoRMha6UJHPW8
 FzFhJipg=; b=NrBqw4atwSTIudGIdUGghW3hoW8fiFVOZgHVaHeghQemy8NmLhf
 D5Uwh2EAQt35hYtByUMcv2F80KkCnX/LMDtrglcvOJPf6/5+9ZnlFCn0TtJfsq8k
 WetJ1BtOex19XHQd7lhYQVwcSNWC6wPRI39PvkWCZYIkv+uMDqvAG1DdlhqIdCs5
 Qm3qyosHccE5mfBES+rmalZCXbapaZzDaPi6xe14KCjrxtO/Uogb1PCVOtMUyqBm
 tU4FKoEnp/SbQHAebbClWsDRH5czxM96NNhG1J7bQdq8Y4pjpi3rU8tIIBM0jVZo
 p/FyLHff5h62j3XPQgGONy9PzOpkzl3HSZQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwjjb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:39:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f07078ff0so4602998b3a.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776317985; x=1776922785; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2bNhNFrYDkVjFXm2p0Im0TVoRMha6UJHPW8FzFhJipg=;
 b=RMlMmpfjBz7bmK0mpLedkvDzSTmCLnZPwuers/LnGuo+T4GSzEwtNeCIQ42gjWA6dS
 Qxu3JhNH3AeLklHnnBZZdFIJ0c9M91HsnYQlCKuaAvKZ1GR3ZY/HunOtGtDgLV8lSFWL
 1A71qkRGG4GHKyX50Qehx5ADeqpeGsDpib/TSdxg6WGrsERcIIcmdIGkM10OdY7KFKFf
 nsrv6FxcAZipVADdrQzpFJxRyWcDlkT5TPuQa3VHtUzW8sZDBBvbPEzEPVpGecxgvUU1
 3yd93CKOSkveHZMyKlEud95LkicQ6pJ7yd2eCKnMELKqTOSagOdDn74LHo6HT7HEQxt4
 iwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776317985; x=1776922785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bNhNFrYDkVjFXm2p0Im0TVoRMha6UJHPW8FzFhJipg=;
 b=cKkRz8Ub/YtOEyg8yTo9VnVeVl/RQMSp3Rfbog0NM5MOkswg1yKLzhAq1rnnn+SO1O
 +Ga3IZ2bLDgEkJBtNJFVOTv06HJWlclZBht9tgBQJ9vL/PKkDkcP2ucbrLFA7ZASlSNn
 IyJltSuWjSHiI9DWPlpHggWrDZYqad7H/zfS/8W/xyWtwjnGdihU2r9VeaE/mJlt3Kkz
 fJ9RQhg43r911pX+yrrSfiv1jKQt+O6NujCCirzESX9u5LyorSO2MiMJeI4BD/3qVSqw
 UMW7bK8lc66+jUT+WsEYY4gdbwY4s0gncSVStnLRWxybY2odtGiLGlKrSvkE97b0xdLl
 GB5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/k8QofFJtwAHeqA5hkiD/PlYQRl6f3+GsBnNmRhFKccI9N6z1ptUj0I5hGoVU6kqBWAP8QBIs=@lists.denx.de
X-Gm-Message-State: AOJu0YxTN5rM5goZZ5FTLUYy72mZ7YWsLTgXWTT2RawsFARz2GzyJBeG
 Ys50cyYWhyy0eqaKD9ss2OJLCsazFTAtSMiV8sFyTJ7Ao2F1Ka0MJicdeKKSeVtObaUfzglAP3U
 OkYIJ2ohVqcANl7zikZfaZm4OQUi0QVKjqA1PADtiK39vbgbedsCeO/mA
X-Gm-Gg: AeBDieuicnYn0vbhrx371B+288JOPLWb4/UL4MruPiht5sfrd7N2X7Sw7GCRqEB1Vvd
 RNjMF+ZjAxDSd90SFXyx5aWRT86Mi1Zt8w7Yz2PiuXxyAl4u1+oAz1Faq4pqEnLLQxAXmqI+5Jl
 br8oRvZCKBqvWwxviyIIEvDZ0E3VY8Wa3+5ZMjvQVmS3pq90gMEU3JSh0ACs5S/nIwBEkkCaZP6
 cvoahePbYYCsPJENQ1R0Qgt7AQcoTa/pu21Hp+xzMRkdgTSsLdipToBy2m0zEsGWg7Pj8kR41bs
 JD3Z86c+LEHvc/uSyeMV2kQxdl4alQU7HeXyAYWVSwoP037CCrKPAalxD4FFJbGNQKJl0CwA22l
 HwqgFi6N9vJzrz2Hl5jmReLalUKTS7BwX83GPc0KYWtfDqTjOwwV6iehHFtywxV3vL1QJ+oqS18
 BhEy9OQxkfFum/kdgJkyW0z7B1Jd2beu8QdSUCohj39NRppDyuRSA=
X-Received: by 2002:a05:6a00:348a:b0:82f:bd8:70eb with SMTP id
 d2e1a72fcca58-82f0c2c210emr24464049b3a.21.1776317984999; 
 Wed, 15 Apr 2026 22:39:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:348a:b0:82f:bd8:70eb with SMTP id
 d2e1a72fcca58-82f0c2c210emr24464011b3a.21.1776317984505; 
 Wed, 15 Apr 2026 22:39:44 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:39:44 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 00/10] Qualcomm IPQ5210 SoC bringup
Date: Thu, 16 Apr 2026 11:09:18 +0530
Message-Id: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZXCbqYqKJk9Qc5mK6MajpUI0Z-VLj2J7
X-Proofpoint-GUID: ZXCbqYqKJk9Qc5mK6MajpUI0Z-VLj2J7
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e07621 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SolYCalVlJeV7SCorRQA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX6TOpa4P5boOS
 gqsQxcpwSNLw99LCX0/P2IOzi6WCUOyecQZg+9Be3hAONRigCMvlu3Sfrq327pdBWb8MHuPnbCi
 +vS2g2+eiJ00dIZuI3wbNDy+yGtRbfDmj5hyemr43Dgu/7P4+/AMLkuV6CxCkhsfPywfJJ6nQrt
 GVseleFB2NKMjJyoOI2KiHZWLXieRzn3UfsGy/fT+uPWmT5wZpqEr8RofPUI73fI5z+lc5PLg8h
 4UFrMZnnUOTkQ9IzXwekSfYP7TmUG8VpvmOBbn/dWvlIaCGp9YDeEtQsuvlDFGvjnzFVrzeCwMv
 BDkjmdykOvu89OoCpytCoUvhb+z+/1d9SRxU0QPNcGD9MSjzxaJOu0x2stl5k6V85sKPlqkzlE/
 nqoCpJYA3ANekHDlAG6f1bcI9t60ohAxBKboThPwZ6xmesIe8hPwuJ60Ybzh7WMu8UjZ2+VRFYH
 RD3kGVLZKRi3CZ/Uf6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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

Add pinctrl, clock drivers and SPL to support the IPPQ5210 SoC in U-Boot.

The relevant DT files are available in linux-next [1].

Working features, as tested on RDP504:
	* Serial console
	* UART
	* MMC
	* Boot sequence transitions from Boot ROM to U-Boot SPL, proprietary
	  binaries (a.k.a QCLib) load and execute as appropriate and eventual
	  jump to U-Boot.
	* The QCLib handles
		- DDR initialization
		- Clock setup

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq5210-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq5210-gcc.h

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

Varadarajan Narayanan (10):
  dts: ipq5210-rdp504-u-boot: add override dtsi
  clk/qcom: add initial clock driver for ipq5210
  pinctrl: qcom: Add ipq5210 pinctrl driver
  misc: qcom_geni: Add minicore support
  spl: Include SMEM driver in SPL
  mach-snapdragon: Add initial support for IPQ5210 SPL
  mach-snapdragon: spl: Update SMEM with boot details
  mach-snapdragon: Add commands to create wrapper ELF
  configs: add qcom_ipq5210_mmc_defconfig
  doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                              |   5 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       |  15 +
 arch/arm/mach-snapdragon/Kconfig              |   7 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  18 +
 arch/arm/mach-snapdragon/spl.c                | 705 ++++++++++++++++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 106 +++
 doc/board/qualcomm/rdp.rst                    |  70 ++
 drivers/Makefile                              |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5210.c              |  97 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/qcom_geni-minicore.c             | 102 +++
 drivers/misc/qcom_geni.c                      |  94 ++-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 +++++++++
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   2 +
 include/soc/qcom/qup-fw-load.h                |  15 +
 scripts/Makefile.xpl                          |  24 +
 24 files changed, 1635 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c

-- 
2.34.1

