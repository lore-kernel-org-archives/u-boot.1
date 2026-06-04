Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D23CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCF98490E;
	Thu,  4 Jun 2026 14:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QPWT+AH3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eenIBAvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182BC8486D; Thu,  4 Jun 2026 11:31:56 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A6084868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6544ZiQ11039436
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fFEbfsUKz6aIGVF6RuiauaYLy62tNAdwSCZ
 gyvsXXi0=; b=QPWT+AH3hBLOHo+aeec0IUvtIsD6aSpbv3Fd1TsQyFI/+kcTFGj
 PEKPS6IOT4JMVgaO95h654CWEX3OpFmqTWj72oUBPZnrjeru7T0HuhBnzcBM/Aed
 dMQEkR62Uun846lGWiQWB4yQ/m0sz09sBKd4XnaeT+iy7YS4rTvYzLQo4+bPlm2W
 Hw9YOUCHziX4GK38Iyz52fll1ot6d0BsyqoiCvk3/5K0kBSaCllvoVxS3haHg1dw
 CM9PHc4j8cyhv3nGl41Bhlp1mvbCYv15q8/sWuXZybR1uyW+Buyz771+5e2YZm9R
 DVKFX6Y6mMERizaLWYSGw1OWtURKFBP74Vw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejtj8jnq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:31:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c850ff84ddfso681767a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565510; x=1781170310; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFEbfsUKz6aIGVF6RuiauaYLy62tNAdwSCZgyvsXXi0=;
 b=eenIBAvJRljpBT3g3vCzCl7WDNEtFfDurSHyRQYRBsCE/yhik4pN+AQConmGrCo7Pt
 ZMBhw3SUCYMcia3GJA34NKNbQ3iN8Kxg/tzY8+Ft2PIZ5PifVE8a8BIxATQUEWH0r2by
 p65RJm/LzBGDxBUJSk3miNOGBMgyROTxH+rVuWfC/X8Ooq+IuJXWIEv/vXJ0g9SInvh4
 3toxuC5JllK81dB1JaESF7VyFKKfypF+2BtayPd7HRC+cvVsaQYNUZP0BPW8npvNxuql
 gLAd0yvZzcP6CTxHwyXvVFuH2zLBjA9VPshnJG5JF8OZ1gkAhPV8EvS31hdycoae9Bd9
 pyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565510; x=1781170310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFEbfsUKz6aIGVF6RuiauaYLy62tNAdwSCZgyvsXXi0=;
 b=dNRdnWuv/rz2ceW+IzFlkt646GZhnIt5MjExwlCHB4omLUX2BBSn6j9JumITdnlHOV
 TNge1ULWNhzzHy/zTT3uYooXIr5xvA56idJN/bFv1dQL++oT36hMMPkw3V3/p9yQPj+1
 sEDDZonchVJfgg96Dv/flXHcRsfWXaEJc5H7xRBzcYutLYef8mOpr7II8UiwXv2HpcsY
 s1HF0QIS8k+2WP4/ljBqpTOVXsITiSbbOs5lpoTY/V30ZsCDx3QfV/knDyPjvll6JWes
 IT9dGLA9e6kaN+y2RRyNsoWoTDLkuZitxsQSyPuZmViKvzo47LE+FNNF0UTshapOOFsi
 YXgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/f7pSLJKzfDK0+3if6RbY7Pmex8GKlzif5Fe0Oz5YryjdnQS6HVe3al//U57w8juZUxpc2LPU=@lists.denx.de
X-Gm-Message-State: AOJu0YwjLRxOjAR3Asvb919LzxjtV8qJzf7mRpFY105GjV6EfWfFXgeQ
 bC/nPmRtcHfivJ3hfFOoaIU9toTgjbrgc4mtC+ON2tA446DPOdZVafaHyEQvJ6+dCVXmasd7Gyu
 jx6xKjH/c53u04Wuo8ipgIeMLbMFIrdWiG4Y2yxdgZU9uJhl4+oNisuCA
X-Gm-Gg: Acq92OEszfxjvtG09ZACFyoYXg359AkSFTvMToGw97cIiQPCApg4LbOXOBUUK2/ft2D
 UxVl7u1TJmXj6eiP6OCsklt4qsiLsAMAuXlgJjG3pIrtCsUEasX4HJk1t2siDhMl/PErmKuLY4a
 9CwPai7zuiQWrcG50Eap/zN43HNSwZ9PiWF/PLF/wXxmGefDuMJ5e2Mi5iCoGxL1YHW393GVCF2
 xtCzdGI+lzLp9uuzOZQ16gx6hABw3I7W6+oEdzcEbH6b07Z1hQFxQsaDhTcPFa5F0KdszsVf+V7
 rZDh9D4DPu3a72tgwBAEjttsmXOUkbdDZKIb7wvvDHjfhO2VV7SWIQNfMyQ9e9Xf5a038qRlOTQ
 +KP1Bh2Wg2jNtPFkgtkIlPl+IVtMNQfBRmXPrk9I0ZPOI4y8kQyTkFeukiim4Qc+b3SXFxoth8d
 l1HUe3EucwsxoelHUcSK5asEb7PailpLkgOUPGDTBR6KfEOHK/dcigE5za3f9D4g==
X-Received: by 2002:a05:6a21:48f:b0:39c:4e62:b838 with SMTP id
 adf61e73a8af0-3b4976676bcmr8373534637.17.1780565510401; 
 Thu, 04 Jun 2026 02:31:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:48f:b0:39c:4e62:b838 with SMTP id
 adf61e73a8af0-3b4976676bcmr8373464637.17.1780565509930; 
 Thu, 04 Jun 2026 02:31:49 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:31:49 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 00/13] Qualcomm IPQ5210 SoC bringup
Date: Thu,  4 Jun 2026 15:01:19 +0530
Message-Id: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KzwayZONs4cqF2ajpF4_9dAMy1PArKel
X-Proofpoint-GUID: KzwayZONs4cqF2ajpF4_9dAMy1PArKel
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX5PmZvXMX/JG5
 mOAwiQgpur4pHqNs6KFl1fBea7rynjgJDdZCm38AePnsN+434trsPIwOJRxUOSGIszR/t4czyUa
 RPcKqJMvDMq+CTKOucPCToK+9XiOf0ZcLP5q0iPngipSHrsz7+DuMwLJu6b2ojUWDune/ZzDA96
 YT5cFjaVVIk7+V/9VxnOkBaLeMBFs+uQ/1AXczgwg/RibU0TJpREBxU4ASIJ/Sbnr0xnvGIcSOP
 CynEpc+6sDuA2PagirQMB0CLuijn+LpfcoRjgDLf4MuDlIT4k9Yl6cbAk+33MvG6aZt6RchMuWG
 to2Y2ZPgbUhq6WsXHXYs+ON2XurYzs/AfmxoTopCjfGZz+0zfEHdZZ0M1H+Kn/zv5kzvdKW7MMT
 jiU1Dx8VoB24nqjlGIzHENvJwIssoH3YhC5vzRiw1+H3r4Sm6T05wTXbO77HpaVlxFDiofhH49G
 PgAHb3A956aKOEtJxqA==
X-Authority-Analysis: v=2.4 cv=f4p4wuyM c=1 sm=1 tr=0 ts=6a214607 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dPlMJ1MxyGK80te7rCEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)

v3:	- Move stack range
	- Split spl.c patch
	- Move documentation towards the end of the series
	- Pick couple of R-b
	- https://lore.kernel.org/u-boot/20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com/

v2:	- Add QCOM_GENI_MINICORE config option
	- Move minicore register settings to separate file and include
	  if QCOM_GENI_MINICORE is enabled
	- Remove bootph-all from override dts and moved them to kernel
	  DT - https://lore.kernel.org/linux-arm-msm/20260409-add_bootph-v1-1-cb2b5093f7d7@oss.qualcomm.com/T/#u
	- https://lore.kernel.org/u-boot/20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com/

v1: https://lore.kernel.org/u-boot/20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com/

Varadarajan Narayanan (13):
  binman: Ignore noload segments for image numbering
  binman: qcom: Add type definitions for Qualcomm binaries
  dts: ipq5210-rdp504-u-boot: add override dtsi
  clk/qcom: add initial clock driver for ipq5210
  pinctrl: qcom: Add ipq5210 pinctrl driver
  misc: qcom_geni: Add minicore support
  mach-snapdragon: Add PBL shared data defines
  spl: Include SMEM driver in SPL
  mach-snapdragon: Add initial support for IPQ5210 SPL
  mach-snapdragon: spl: Update SMEM with boot details
  mach-snapdragon: Add commands to create wrapper ELF
  configs: add qcom_ipq5210_mmc_defconfig
  doc: board/qualcomm: Update RDP build instructions

 arch/arm/Kconfig                              |   5 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       | 128 +++
 arch/arm/mach-snapdragon/Kconfig              |   7 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  18 +
 arch/arm/mach-snapdragon/qcom-priv.h          |  52 ++
 arch/arm/mach-snapdragon/spl.c                | 749 ++++++++++++++++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 106 +++
 doc/board/qualcomm/rdp.rst                    |  83 +-
 drivers/Makefile                              |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5210.c              |  98 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/qcom_geni-minicore.c             | 102 +++
 drivers/misc/qcom_geni.c                      | 100 ++-
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 ++++++++
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   5 +
 include/soc/qcom/qup-fw-load.h                |  12 +
 scripts/Makefile.xpl                          |  24 +
 tools/binman/elf.py                           |   4 +-
 tools/binman/etype/qcom_appsbl.py             |  18 +
 tools/binman/etype/qcom_config.py             |  21 +
 tools/binman/etype/qcom_lib.py                |  21 +
 29 files changed, 1926 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c
 create mode 100644 tools/binman/etype/qcom_appsbl.py
 create mode 100644 tools/binman/etype/qcom_config.py
 create mode 100644 tools/binman/etype/qcom_lib.py

-- 
2.34.1

