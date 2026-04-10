Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E44F44852
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB93A8414B;
	Fri, 10 Apr 2026 14:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sh5qMGsr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLB1l5Gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63CD84106; Fri, 10 Apr 2026 11:12:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27983DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6l2pD1432467
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4UjnG8rBdYkoUV2bMCzHdZ4wMOxlH3wUhbD
 Yfhe+u3s=; b=Sh5qMGsrV5eGLBA+hutCxg1xpICS/hPIgPEjv8mpY40sVU7ZKgx
 n2VuGULLsfViAM4UnfEiGxAZahWQ1MfHqa+/ZG2pibB5lHWzZHf74hwCpiQb0sQZ
 BodxKkgtqaShzixS2fIhZw2f1TxGHjfc9TBMtJsDuUSQzZTmEuwUEu72iXPx+f1P
 WrFuh2r88z06ZpG0WLuktUJx/tZ4QYI2f9OLuc03A6DQffWWOKRB3oYFKInrGol6
 7HOgZvhu49+lafUh2nhI5Kx4tYuQCx3X5UzzPqoN3jLVWDDjGEpoxE0T47M2IAXm
 vfjNLHvee+tjDzoU8LV4stoOYnw6cibRohA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckfbk6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so2125115a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812332; x=1776417132; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4UjnG8rBdYkoUV2bMCzHdZ4wMOxlH3wUhbDYfhe+u3s=;
 b=BLB1l5GmQCN64CRdT1bWd1auX8CXloVNMwG0DTdXr0HDyNThOcm7sOQnZkoV91tboB
 66dMzF53ZgHUDs7XBLFx0C/zwxGATTQuwEL/oA/aSLGi4eUQICqtKeyE3p12D23xxSTA
 28JnhrPYs4PUXoYy1FPrYR9Z2aEJEBp6uua/sP898zHqgZxVBAwsJYW6URc/ri/NmwsT
 dIBAN2JwJgTwWLZMHF5nIRdISD9qlo9LoVV4gjHnn+Xqwbxu0pUFAky8LICe7Qo0FPaE
 NGnVVmpj36Vj+4ujAp+LcYAGfLejmNC44JMo3uFD1jpdePjPUwjuPHWMNVL0d6cb77uM
 SoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812332; x=1776417132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4UjnG8rBdYkoUV2bMCzHdZ4wMOxlH3wUhbDYfhe+u3s=;
 b=tMzvwS21EDtPUTs3r+LEfPzp1Qg1p0CZ7MADXYIFvxP8vkIA/1mFf09zdNpDECS80k
 CqXdI4gkewaJpb6u0eMmLSheMZAUwxQHlqImnKBzrsFIpCf2Ui5JnzJpNVrQtJb9GQY6
 6YI81Ty7qr5mWaHR+5bBCHtnJJZGhLYD+obZtiHpJGjB9l/2UxlnszkU8zsel3pZjg9t
 0Alfaq3kYec7KjiIysUm+e32nX2Ak2aUmLZmkCtIdsvX6zaMfe9a6NniC0xRtHeTnumV
 hgOkiHoAa9h3BFojbCKpoctXHu9Ct08FivDBtFTa+vBp89UJsvHuDMxwN8tNo+yCcWA2
 EOnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzFrfmJ/qaZLpUDXIwohxs1gdvT/P6QQZg9isDU+2DkzGFp+gfp8NAOa2HCZr02sUdnXmaDjg=@lists.denx.de
X-Gm-Message-State: AOJu0YyprYQw5brv3ZP0XOn2nJVsaXPrmW6FmeLtXheuXkKz2NB6QMxQ
 byZBTlpJIP89A7gS9FdFLj5Vac8I1kGfx0GbJtCjDQaMIsTslAZ9KbjfI1MLk+jHgC4wtie5ZHn
 4L/5qlqpdYAVm8VZpSLD5tvYthtgU4O8mbfV32rT61dcVKyIhy1IaRHO8
X-Gm-Gg: AeBDietvyKpOI+sgK2WlQsEA8qbYS+G85UnW9ZjBpsH7ESn2+YW310W0oQy0LfYDWqw
 ckx1qSUsKJ/vx4ldFJ1SZgleeVukS1+jHjDyxe+ZzTuGHG3bGZABuh08Q5H4umRR/jGwaYZ4JfQ
 POIHXZszH4NDCTPSLohjdlT5AXau7f3INSBX190kK2YW8abKXdJ2tRCorQtqR5kRUSr1PsgT7/v
 Ebn3ZyLR/Aw1Ec4DEIFRWGO5yGcUk1LYolZU+JzZAY0GDbZZFeaPgjMK31zc+wFD1P/jMKkpR+U
 RC8W1APhuEd/5dR6N7nGrYxE0R7r5Rhgx0cw6ZIV5gzibCrg6tHuuidjrf6p6sJgwg/zyQ1+6j9
 kz1jTPCW0rWeMG5jIeWLh+yAL/x+v46QgiFMu2NRALRRi2gXMrROGTWBDmXtHG3U6TIuLsvVrTU
 G+lJQn8WctQF628xM9EWUBk1wslNKT6vVAzJAPiFqQjVoUfwg60uI=
X-Received: by 2002:a17:90b:134f:b0:35b:952c:43ab with SMTP id
 98e67ed59e1d1-35e4300f8fbmr1739929a91.4.1775812331736; 
 Fri, 10 Apr 2026 02:12:11 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:35b:952c:43ab with SMTP id
 98e67ed59e1d1-35e4300f8fbmr1739864a91.4.1775812331194; 
 Fri, 10 Apr 2026 02:12:11 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:12:10 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/9] Qualcomm IPQ5210 SoC bringup
Date: Fri, 10 Apr 2026 14:41:45 +0530
Message-Id: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/fpBosP c=1 sm=1 tr=0 ts=69d8beec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SolYCalVlJeV7SCorRQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfXxoR8VenxNrci
 73cvJ6su6PJORDXfftGIn2sQFbtD4plJJoNzrJgrXc/X2NgIo9m5tSUgVxOAN7gpxUtfiPH7n2r
 9XyQxrA1sQj5grmjd8XY6OfDJn+kwWBUQhf6GtDlK5H9QRJq477m0QtWv6HZdB765sXqEczyeX7
 TPim5ZbhLQIlPI1w1jocM9eBoIz9yVk1POec7a/pQ/9qyHRYmBYptj7UKYJo0BuzGZg9ZxvCjKH
 rJeC86CIeSlaaDWPzvxU3LxmWX27a04T+qUN+Tl5TRHwtDV4c+2/Sic7oBeyc6iqXY3lu+EPSQ6
 /YoKUp/d75mSMI9L+hsVgSXpX4y7jLmyTRYsuQUOq4KLNX0uc/0M56rsfLTATMSOi6lvYmuLA8A
 vbcauTI+6RvobbtMI60I67Vd+ofrOwCnlvRGFQ847+9Q6D+Q6n85sUG9G/T+T/Umy4kypQaPU78
 7FTEsLGYtTSY7lghwUQ==
X-Proofpoint-ORIG-GUID: 6i7QpInGHCIakQVFUE8iEAdZZzFwGArQ
X-Proofpoint-GUID: 6i7QpInGHCIakQVFUE8iEAdZZzFwGArQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100081
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

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
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       |  15 +
 arch/arm/mach-snapdragon/Kconfig              |   6 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  14 +
 arch/arm/mach-snapdragon/spl.c                | 701 ++++++++++++++++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 106 +++
 doc/board/qualcomm/rdp.rst                    |  69 ++
 drivers/Makefile                              |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5210.c              |  97 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/qcom_geni-minicore.c             | 102 +++
 drivers/misc/qcom_geni.c                      |  90 ++-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 +++++++++
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   2 +
 include/soc/qcom/qup-fw-load.h                |  15 +
 scripts/Makefile.xpl                          |  21 +
 24 files changed, 1618 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c

-- 
2.34.1

