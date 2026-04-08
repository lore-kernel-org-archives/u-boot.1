Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB091073C93
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29228412A;
	Wed,  8 Apr 2026 14:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aAL/KF3a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cIFQ1cKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE0F80433; Wed,  8 Apr 2026 11:11:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0BD80433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6383TwUS2411815
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tVZCz14PmlDpF2V4QAeutwBE+7gRQPaNma6
 mcZoNyIo=; b=aAL/KF3akC/flwdEVb8rsYeVQK2jpVUPYD+TMQu/D5HgYNZHGCJ
 REmpwIN52qGMERW/t+/nULg8sS45tuUyZZXlJkq43HcxHJ6lcQvZNwG6CiTJcq00
 /Bre3C7O80uHVrZksvXeWuxsuoBaxXYL3c3TyH9vsO4Vg2lLvICHRbH4OBiog0YQ
 qzDm+8MIg3hrWLJHUnchDQJmAMw8KuB4F233FTA1U/EyhfGgJgAX50OHO/D62W7s
 AZk0bs28LOg9wzGayQPQj8vXczF4Ie0mdB+HQnN/SHqyGDEl3fOztstDHx7wgcep
 q2CbKxUI1zZZBxkOpWUJgDCuS5qX/KQRlhg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vb0n6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:11:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2471321dcso167886925ad.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639511; x=1776244311; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tVZCz14PmlDpF2V4QAeutwBE+7gRQPaNma6mcZoNyIo=;
 b=cIFQ1cKUP1CzMXv06Jf/Bc/U6Pc/5GZGIezxg6c4OZMRA7vZlrxGYQ6qXxgy75x1BY
 NlIobZupXkUVB07wDCS+gnV/GmLTmlWvwP7TBn3x0TYKGmtEgDg1mInT54loadp2vimo
 HuQqn4X040W3dv2wUJ5J/7JjBWkfo9sJurdnvi5TsA4UfycJZbc1Jopwpj22B1qJQ4CN
 S6uLCyqvOXTq4tfM77mbBsUbH4SnPxw8SCZ+gPCD9wqFKjLwJSifiRP/anwvhLlWXvdI
 m6i3WOiFkAEwq+TTVjwijRtxGInlrDg9Awi1RzcFKFe8jk2kZcr72xA+0Iwowq6TxlJx
 1Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639511; x=1776244311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVZCz14PmlDpF2V4QAeutwBE+7gRQPaNma6mcZoNyIo=;
 b=o8F2FHen1TOcANuQhxCEIOw/5TamIapC8kanWLR2Njp2vCKoKg00TBmqDLXov4ewBr
 2+KfadPLzJSyBhaRx//GzCGxPsdjCcWGbMQCnfGlpry6RxuEYKFHnND7HORytu5g/eej
 p6Q4iwPM6FgKuw+5tK5bd9FdviFAflChjuRt16gRVkNNlUagxhgelcq5M7KxBbundn1o
 PtwLTFbrYiz5hbeJBawHSlyOmlgVe19cT+0gqnKmRjsyptBp6GTGmmZ7nWBnAbjz6QZf
 zDXC2EkH9oc+4Cag1jp1Ja0JQdqdFBF2BAkPP7jEL+HbH31r/dJFjvpkCoLf9fGv4BQH
 gzoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE9zRFU/bIuS/co4hXxWgPGiJ+WPRguGQBnjAIK0NJ7ZAXm/IhCXXWcZVBeLFZOCax032sKxE=@lists.denx.de
X-Gm-Message-State: AOJu0YzDUMNVofMLeOaasYdTruyKJyTHKjV6OxNG8Ms6Bb46tWMzB9Pv
 QesWyhtxHxFL9XHPAfyS/DzQqew7dgdgTbn5se+42lrS13h6r/7LRb7izN9pehiT7HOfBM8EMWE
 N76tmWLmZ6rfFJsEjnO+5pjnQJWKYfLaQz74eavYaIry+kpcf3mJxvpk1
X-Gm-Gg: AeBDievkG0EQZi+1IS1ppsDs+HdDhH9EYyPBk1iy1HrJv9yUu4Zoy0gbvbkHk7CqkjS
 N6H6HV7ex7SyyzuZwi98TJBsBB2BknPHYDqA4A9rdAh3I4o40VvFJ7BRvrdoBwYn4r5xOXKKDj4
 QJTd5Y9a8ROVscYN+X2fnwliRH0lHM2en47Ft3DvoA53xfakXND5N6Nl4MlaiXDzGN9C1qtXFxV
 Fy/I6hB6wUunCBKZNcsbzZ+w0N4Gy8+Fza42zossxi8L2RnZtOsBHYA8Rd1scoEY7oUMVX3fq7S
 SH5fb4ezxgREm8/t0UE5voV3PLjqqZXC2uJxnUS6RtN8nr/TOPTGykLe7/u2LftSIookAiyw2zc
 pM0ldvZdlaRqV4vwTiM0nWB6Qa3P+CovZsF3P7t3shSmiwjfjNBwJPCfT/qt0/U3sW3fIBkemOs
 3s8qlY26r5iqVwFUeHQKuiOhjRV8PLDiIQXyrEl4+GDH02ICVr1Bg=
X-Received: by 2002:a17:903:1ac3:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b281868e69mr224295425ad.17.1775639511111; 
 Wed, 08 Apr 2026 02:11:51 -0700 (PDT)
X-Received: by 2002:a17:903:1ac3:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b281868e69mr224295025ad.17.1775639510548; 
 Wed, 08 Apr 2026 02:11:50 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:11:50 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 0/9] Qualcomm IPQ5210 SoC bringup
Date: Wed,  8 Apr 2026 14:41:27 +0530
Message-Id: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX8Zwb9j+HN8Pd
 JYdGboJOPyjpmMg0/MedbyVaPslynRn9iaTaGEcuYHrhxVJa/Eg5XcBpLDiVJLoNsWOWzUT/m+I
 FvsIUDOdEcRRFjkAAXn3e+NZA16FG+NJclXfKZ7pzZj2Ka39mWzb0uHlXjxlRMF72USVRUhOzoF
 qfPrP/kk432nroax2m26ErfJ2fyoWZ/X7rE+VjmuG8diawRbhvUPJ0BTqTIPFkGngjDj2Rg1MxT
 IjaPfxMg+jsjkoFUfWc9ZvcJM4PsuYH9nJZDwKz+tELnQienFHVjSqzU+D8k32Yim4s+XRkrkGs
 zbOndIK0FvKag9kTgJAQ9iJC7BMcoGDWxrXGeIe84Ic/TESXmj5FOH0R676Y4IC3xUzsQ6Qbggr
 Ej2JZgZMZabFtoD0iXqcS5kaSteDSbGXffKL6JTVIKh+GaMvJ+6xxUGAwyqVF4f7qVaJP2su0ao
 LRUd5XsHYPzX9qDZJpA==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d61bd8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=WbRUV2wpVsxzjYTPSfMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: kKfk6Lc6AM8940OmMF9f0JHPyx3UhVGO
X-Proofpoint-GUID: kKfk6Lc6AM8940OmMF9f0JHPyx3UhVGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

Varadarajan Narayanan (9):
  dts: ipq5210-rdp504-u-boot: add override dtsi
  doc: board/qualcomm: Update RDP build instructions
  clk/qcom: add initial clock driver for ipq5210
  pinctrl: qcom: Add ipq5210 pinctrl driver
  misc: qcom_geni: Add minicore support
  spl: Include SMEM driver in SPL
  mach-snapdragon: Add initial support for IPQ5210 SPL
  mach-snapdragon: Add commands to create wrapper ELF
  configs: add qcom_ipq5210_mmc_defconfig

 arch/arm/Kconfig                              |   5 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       |  97 +++
 arch/arm/mach-snapdragon/Kconfig              |   6 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  14 +
 arch/arm/mach-snapdragon/spl.c                | 701 ++++++++++++++++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 105 +++
 doc/board/qualcomm/rdp.rst                    |  69 ++
 drivers/Makefile                              |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5210.c              |  97 +++
 drivers/misc/qcom_geni.c                      | 168 ++++-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 +++++++++
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   5 +
 include/soc/qcom/qup-fw-load.h                |  15 +
 scripts/Makefile.xpl                          |  21 +
 21 files changed, 1670 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c

-- 
2.34.1

