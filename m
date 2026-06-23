Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A8CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D114849F0;
	Tue, 23 Jun 2026 08:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLSA64l0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eB8ePefr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDE1849C5; Tue, 23 Jun 2026 08:48:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BDD848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6d7Pe3376094
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=AewPms7ok9UeYWmUo6SGaogbE+AVgGoboNo
 iaQq+MJM=; b=mLSA64l04nz1/eA4tuX4o9K8+WqAu3dbmU4AFai4ulA95J0ILfN
 wKB3gDVngDo3dDo4A40hGWRM6CBrHJ3i/owGZ7vGRBtCJRlCQOJWGOjl5rppX0NG
 BYkqLK07nNPOu+DpxhqmsS7XSsslbYi6gwznjPqv1OurN4jrqToLSKzjsCf1Lf8X
 DCEAyzcCWnLYtQHHrXGc7iJ936Jm+H9arK6BKdQ7R1X94hg2uha3x1c6f4NgRrAh
 gSCh7+19IePh1/BB8VfC1PI2FSC9Kz2ZfkRuBuye+yHHQkZtTAPnHiP+epZQEKqz
 GyLWb2rFq31UD6tTAFFuwUGYT2ZTu4KIN7w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yebaym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:48:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37d378386d0so561321a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197302; x=1782802102; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AewPms7ok9UeYWmUo6SGaogbE+AVgGoboNoiaQq+MJM=;
 b=eB8ePefrrdTh1VajWYTFhy5ALWgmXuVnhlts7AhLGNzP39FD7ij8yDDmLQsP8HOxiY
 cC/JcDz3P5Tn203CV9xi4EVbK8llgN3woMbpgi8DPk1CwwMdN6wpWBOl1wvhx8V69tBO
 UBX4kaMTMwi8Rnr4WJ4x3/1r5feSYRvplsd6gvQ/0lts4VwGQiBDv72fIOBAtf7xWOCJ
 72tE7fY+/iV3P7PnIVYMPva48tyDWeQHfjgyn6Ny/0yEsEJNEp7ldSr22fWjG9fl2hEo
 ndcMRcV2QI38cpdB6XuOB74hNfiNrX4bGFTFn1cjmWRwGjeE/cbfN8daTuK4CqjR0deS
 4n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197302; x=1782802102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AewPms7ok9UeYWmUo6SGaogbE+AVgGoboNoiaQq+MJM=;
 b=V+UhWDlWSRon6wqM/Co3PWIeTCQRnUHADb5PtokVMruh4+7VdztqqZEG1NXL57ogzX
 UJ+MkeiyprpOMdNlsswn6ljxf0883W/Vy+QpOpPjmOnmOb93BBwj0L0InkzE54VTpNxg
 unOfbpysp5ZjEQJQZTCuGbRhGJe+CA6j2BDrFziFFQ7qt9JUGI+JczwKouHVamo3FNFb
 j0QzV4ARhqrNOwGAATX7fGO+HbX7h/LKjDpTRMFe8hfaVv5gL75/ntM10CPRdJxn3pha
 PPIlL8qa2MQGO0c3e9RAvQVlUxyBtvxqGqVMsiH5XcbkdO1V/rVN6Xe5laHgqV7BorKV
 wkEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0G06RVBd+lXriW1S6YsiPpZf2E6SgIFP2Xxd3Xa5/hpLW1kzmxg+s/iaPnYHQmUHdqlgbREQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwiENvMGrW1NNlJZcQb5ObJoFXDK55vTHB29YQFiM++gAbGmOQr
 qFtO67joFWgZgVlnyxaECEQ4y+DlrEyB87FHQkc1gwudsmJanYKfcNWRa5g1RbzgAKUjYbA4M7j
 zIEmfxB4i+nR1BhAfBY8uI3QnV3mZ+QvYgItUoipmCkPWKIt0Rx+Gme98
X-Gm-Gg: AfdE7cktbagSdHIDSkd7GWEIBzD6ypo0amoQhU53dEuhJXjN11RS5lOakg/NRME/wkO
 xD3mHeivYpSGN+8Wgy67M/12UKlbCSJTQmqXgRyKA4VdHN3Qf+RdTWZPC34ZVqoBhOhziNxQdc5
 8KqY68zK33o7i6d45Ltz3YpluvQTtY5Iya1A9S3Zk/d5J3hUChkkVK/23yzLHxAjnuETdy3nA66
 hhd5O0YWJ+EJnlPl41Yscwi/+kJtxJiokmarh+XqSfPxl6QbM9OAH8EPvFDmTb1d6HldlTILYLd
 7SRhpiBzYPfOz4WoI8s2DcEixnYgZEeun29FSv6+sOi2M0ZrIW/OU0g0+rgnBcgLnF+Bog2xjd3
 DSxQQClWK2lBlI29IznWwfcK+Y+0hzyaiASZ5w8C3kERaY7KILDutSz9AmjOsg1sFXkEiSL4l4S
 TnDI/4eqDSCW47dKvON8UYm5AAk1NdatmTh1C4FFYG
X-Received: by 2002:a17:90b:2544:b0:36d:630a:c4e4 with SMTP id
 98e67ed59e1d1-37dcd6cb687mr1877092a91.3.1782197301534; 
 Mon, 22 Jun 2026 23:48:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2544:b0:36d:630a:c4e4 with SMTP id
 98e67ed59e1d1-37dcd6cb687mr1877037a91.3.1782197301022; 
 Mon, 22 Jun 2026 23:48:21 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:48:19 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 00/11] Qualcomm IPQ5210 SoC bringup
Date: Tue, 23 Jun 2026 12:17:53 +0530
Message-Id: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: byqwGSv3euQmNn7ZjU_mlYNp76IPmvzD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX2SYlhetMAbFj
 S4LiqNCFndo2/VjiFJL7kUImo0aXdhFVVvJTnMchultEIf/x1RxLaNxUVNKUTkgMb9GARWdauP7
 zUu5oWpMGdEyx9eN1gvRLPuwm+sQVxQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX7O+LA2nnKqPD
 Pqy66sDq0DYvC5M5iuGT4mWHWFtSGkCsnB9keygYnR9AYndAXa1TyGhTNj0Cjg7jOSa6whGuPTs
 cyGmtf2C2YCqq/1H0Y3oHpDJZ3P7Uyt6OWJrdn7nbfF39WrECBniSyrd5p9g90J5sU10TmqJwJ2
 MerrFeuo8NROlgldnhNwyvDEFiJqZtmoHHjbUe5OfxcMkoC3vuxnl52l6xXUaKYT/V6UZSQmECp
 mcVSvqbMEejNtU9ASQOIkHO/iBbEmuMbmcGMlrWHPNW2ymv3s6oO95oHt7tdRPKodCXnjw7MfrU
 bH9a39WhXaY1nCz/SkCzWwUO0BfQI1VzCE9qIEX5ymv09XE/RmDxG8/gsqyZMLSv/Blzu3vkjEf
 sjXhSHj62ZtlzwwmcfmrmwzjooI4kVBG7ukurSNq9az9aUNjaBwKQE/CDscyFZfzxvWoFY7sWQT
 rWGhfznnFKMfOQT6ieA==
X-Proofpoint-GUID: byqwGSv3euQmNn7ZjU_mlYNp76IPmvzD
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3a2c36 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HXgu0fstwBZNvnSC70MA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230051
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now

v5:	- Reorganize SPL related code into common and SoC specific functions
	  to allow SoCs to customize according to their boot flow
	- Fix documentation related build errors
	- Please see the patches for specific changes
	- https://lore.kernel.org/u-boot/20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com/

v4:	- Add binman based image creation support instead of special scripts
	- Identify boot media based on PBL shared info instead of CONFIG_xxx
	- Address v3 feedback (see individual patch for details)
	- https://lore.kernel.org/u-boot/20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com/

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

Varadarajan Narayanan (11):
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
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi       |  15 +
 arch/arm/mach-snapdragon/Kconfig              |   7 +
 arch/arm/mach-snapdragon/Makefile             |   3 +
 arch/arm/mach-snapdragon/include/mach/pbl.h   |  58 ++
 arch/arm/mach-snapdragon/include/mach/spl.h   |  14 +
 .../mach-snapdragon/ipq5210-spl-wrap-elf.lds  |  18 +
 arch/arm/mach-snapdragon/spl.c                | 615 ++++++++++++++++++
 board/qualcomm/ipq5210/Makefile               |   3 +
 board/qualcomm/ipq5210/spl-ipq5210.c          | 159 +++++
 common/spl/Kconfig                            |   8 +
 configs/qcom_ipq5210_mmc_defconfig            | 107 +++
 doc/board/qualcomm/rdp.rst                    |  98 ++-
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
 drivers/pinctrl/qcom/pinctrl-ipq5210.c        | 349 ++++++++++
 include/configs/ipq5210.h                     |  11 +
 include/smem.h                                |   3 +
 include/soc/qcom/geni-se.h                    |   5 +
 include/soc/qcom/qup-fw-load.h                |  12 +
 scripts/Makefile.xpl                          |  24 +
 29 files changed, 1821 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/include/mach/pbl.h
 create mode 100644 arch/arm/mach-snapdragon/include/mach/spl.h
 create mode 100644 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
 create mode 100644 arch/arm/mach-snapdragon/spl.c
 create mode 100644 board/qualcomm/ipq5210/Makefile
 create mode 100644 board/qualcomm/ipq5210/spl-ipq5210.c
 create mode 100644 configs/qcom_ipq5210_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5210.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c
 create mode 100644 include/configs/ipq5210.h

-- 
2.34.1

