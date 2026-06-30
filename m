Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D390AC43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D56184A52;
	Tue, 30 Jun 2026 14:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kyrpou82";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrfTNBh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D3984A73; Tue, 30 Jun 2026 10:09:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269F284A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CJRb1073825
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6L0VgREXXOVq9zxoJrUvj9
 eaE50wzqF8zG2MPYTVhGw=; b=kyrpou82DBXWXXVJrfaOQFHOySo9cfKpop2ljg
 e7v74vU+43xL0xg/36fTuRuKAOWfmCSZ1KXapHN2fdb3v5LAa6gwD1+JjLzV2bfJ
 wnO4ZrkVs2B9PSZ6jrttQoYRHjX9+16hqbgL2gdnDJ2OQjj2w35LaDN7whVdWzUT
 iGmJhgY+lYWX/GTyOqCmpM1nUCsTayF0Dwb1xTgkISJNUHZFooxlEXoSiLlACeJs
 tMQD9AKOOj55DnjG4/4S1YAkKY6AJ9WXekTj+hOjTsFPrArNHmt738FzhgE8esYQ
 A0+zxN08knVqwU164mm4uY16kFsY9ISzsbkRJUomFo4acLfA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k2b2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:08:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ba395b047so474465eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782806936; x=1783411736; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6L0VgREXXOVq9zxoJrUvj9eaE50wzqF8zG2MPYTVhGw=;
 b=YrfTNBh66v0NDnU/KV1KLt+TQCg00JX8+Inq/wb40XtZ1yUPbKc1+lZZgnWshHZmrk
 oxXUqHRHfUIemXzD1Dz71yfoOVElXEuxc95f3hgnlTJeNWvnS+unRnngg2r9HcK2gw20
 T+2+SRx8Q1ujMtVy13/4xqjAQHCqzFKMhG3uSW1vA6LtaYL0pM+/9oMI++yr5ta6Zq7s
 HMSzQGSX0JgoIZZ1UsS6aepNfULzublnAQbHvV2Vm9XBVe5rISbUGp2eSS4Kg9JVEUE2
 Vt85jk9ZUEmXSjlmbHDYpoSqGfp1AjS6nShxKgif/AS3YQq3Ygmnlr9dBlM/WZP4t3K+
 jvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806936; x=1783411736;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6L0VgREXXOVq9zxoJrUvj9eaE50wzqF8zG2MPYTVhGw=;
 b=o6dVAV3WmWtO62hPbIjAD6XLvEz6AO24pAlgR0fK/drGPV1LrubeNpB8nkjGcHRRbH
 e1tJxk632coHSnenVWcErdBTHF6qZqJurhLFvrxE9mCmPnhLy0mby5DoalWeHYZj3V0y
 vY8gASMS+1n2JlR6eCezBsze+LqWGd69xkVW2ZcOWvlkB0KKVaw/OkRTw/e/Yk0XUXPL
 6LJaNxWmx5IIFVx1b+PNAnGciaog+bL5QvjK2QqoFByVicT6g/3ZF50wgo6hO1NrEgPo
 c6wJyf+0zCoxzJ19bkts+L95uQHJFrmpiVCEYSCAXIxJuwGEV6d8AmWdBLUnvVEpqFvs
 78rA==
X-Gm-Message-State: AOJu0YwKKq4WoDHYk1m54A3wbkfbwH0eeqtzlzn9XKen6dbLrMYOSSUb
 X88dGAVS55DYz6ZQqfrEhlm6cAdCZjuRKIzOEWDpcgtT366juaj0p72fNq5GmSFi1Hf+O+r/RVe
 gzyZmBfJvl9gNNjGXhTZA+1xoAbJY7lFoynGDEPq3bPvGan/Ggrn9oHss
X-Gm-Gg: AfdE7cltIiaaUUu41N0NHb5wV2sj6aCvxAGm+GTBiE/GBZNCsj911j9UYhLm2Os6vyt
 wf7vAzt5Z6qzgg27hgraWqh6AFXLQDaOUVjU3fVkF1am2yjrLZ8A67N/ue0NpJuhLH3y5aCsJCc
 YfSHaOWe5uGhdUBmpY9AU9obLbD53OfKa84xL8E5Z2NX5r3hUQivJzbAg56mw1+kP1eFo3ofol3
 lhBuHfAd/uJXjVwVvKzGMA5G0LECidUyZPeyP9jXvYTSEfAw31oKW5GEN4PunHm7BLui40im+6D
 K/P2To29gsuJWDufTgXwB2F9+yusu5CA6vWKdkev4mg845jNkyjPjU108LqD8A1XAxQT72da1qt
 G/51tjkUmqeDOoFjOPyOFufFuqBnSn9B2/xdHbpFPAdF9Aw9EpYGZJDVV6DoyOeoixxPiUi7WAZ
 UKkF3TLe8VBRFHIlifwLzBwmYhVEGoPa7V46K2Mxco
X-Received: by 2002:a05:7300:2141:b0:30c:a9a:ee57 with SMTP id
 5a478bee46e88-30ee12264e2mr1788487eec.15.1782806936472; 
 Tue, 30 Jun 2026 01:08:56 -0700 (PDT)
X-Received: by 2002:a05:7300:2141:b0:30c:a9a:ee57 with SMTP id
 5a478bee46e88-30ee12264e2mr1788439eec.15.1782806935931; 
 Tue, 30 Jun 2026 01:08:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:08:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v7 00/11] Qualcomm IPQ5210 SoC bringup
Date: Tue, 30 Jun 2026 13:38:22 +0530
Message-Id: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZ5Q2oC/yWM0QrCMBAEfyXcs4EjByn2V6QPMd3ogW01qSKU/
 ruHfZzdYTZqqIpGvduo4qNNl9mgOznK9zTf4HU0psAhchT2Rb8e48OzcAdESCyJzH5W2PUvXYa
 DK15vC67HSNfU4PMyTbr2LkmRs2QOudCw7z8hBJQViAAAAA==
X-Change-ID: 20260630-fix-edl-0307ee6e36fa
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXxD9LIU7JTTqz
 oiG83+1L+HJBjTu5OjJ3n9uFVFgUWtK0Fe29Mq7uIb8XjXyq4PFe1l58+zXPaV8SNNP1X+TXnU2
 0xmyk8QqBqi7nf74GWly/qgb2+xgsjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXyN13GaaDddCc
 XLfXRLRmGmxCgDgEQvJKWrH6gSzLMB8nY8Rl+jxFzNRVEsmi/xWB6cwLtpSflowUzzMaoMIrC6T
 vBG1Nhe2mXV+hXk0elcaF1sMGAt34BZgMgzXun/QmHi5naKHL4W1n0hmx9k6mbsSfmoGP/kJcDb
 qlhc0sqAj0eJ1SqThWuwjeveve/l0qmxUZU8Y7z7EnG/VAYwSv9Z8UaYqr3InEAtc60x7TmwDP7
 PoTTWfD/svVrEhUOPAB2o27MtCpV2Y3xz8gCbAt6G29CQfvvJSJmpGhEYCXVolfixrkVLmzMz+D
 xkStZW4zn8JtVsOx+Tt/x+pBg7joSmE+RwMUQ6O/fRGSeMJXZ+Qo409BNcmN5wikVoGGEY/+K02
 4JR1SOQy1KhPhHTRFNwOCusLcf3b7is5EH4QybqOzfDSvw03cqlCOvjaTUqfYDjOx8GO7bLIkMX
 FV6YO4sXAVWr9ZoD3zg==
X-Proofpoint-ORIG-GUID: wZP_SeSN4sW6Oj9kUmA31L8F642I7HoQ
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a437999 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dPNsX5gIhjezB8oIaqsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: wZP_SeSN4sW6Oj9kUmA31L8F642I7HoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

v7:	- Fix inadvertant typo in doc/board/qualcomm/rdp.rst
	- Pick multiple R-b tags
	- No code changes

v6:	- Move binman related changes to separate series, so that the
	  SPL changes can move forward.
	- Restore v3 build steps for now
	- https://lore.kernel.org/u-boot/20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com/

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

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
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

 arch/arm/Kconfig                                  |   5 +-
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi           |  15 +
 arch/arm/mach-snapdragon/Kconfig                  |   7 +
 arch/arm/mach-snapdragon/Makefile                 |   3 +
 arch/arm/mach-snapdragon/include/mach/pbl.h       |  58 ++
 arch/arm/mach-snapdragon/include/mach/spl.h       |  14 +
 arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds |  18 +
 arch/arm/mach-snapdragon/spl.c                    | 615 ++++++++++++++++++++++
 board/qualcomm/ipq5210/Makefile                   |   3 +
 board/qualcomm/ipq5210/spl-ipq5210.c              | 159 ++++++
 common/spl/Kconfig                                |   8 +
 configs/qcom_ipq5210_mmc_defconfig                | 107 ++++
 doc/board/qualcomm/rdp.rst                        |  96 +++-
 drivers/Makefile                                  |   1 +
 drivers/clk/qcom/Kconfig                          |   8 +
 drivers/clk/qcom/Makefile                         |   1 +
 drivers/clk/qcom/clock-ipq5210.c                  |  98 ++++
 drivers/misc/Kconfig                              |   6 +
 drivers/misc/Makefile                             |   1 +
 drivers/misc/qcom_geni-minicore.c                 | 102 ++++
 drivers/misc/qcom_geni.c                          | 100 +++-
 drivers/pinctrl/qcom/Kconfig                      |   8 +
 drivers/pinctrl/qcom/Makefile                     |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c            | 349 ++++++++++++
 include/configs/ipq5210.h                         |  11 +
 include/smem.h                                    |   3 +
 include/soc/qcom/geni-se.h                        |   5 +
 include/soc/qcom/qup-fw-load.h                    |  12 +
 scripts/Makefile.xpl                              |  24 +
 29 files changed, 1820 insertions(+), 18 deletions(-)
---
base-commit: a3f393c02cf10f44310c6ddf3dedf354c2e877a0
change-id: 20260630-fix-edl-0307ee6e36fa

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

