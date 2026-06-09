Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2165ECD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 09:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599E083FF5;
	Tue,  9 Jun 2026 11:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjJ9r37c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YmcTpOtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94FD8405A; Tue,  9 Jun 2026 11:19:46 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6283FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 11:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rTNZ1517810
 for <u-boot@lists.denx.de>; Tue, 9 Jun 2026 09:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CVxZ9MSPRgU
 Nn1eHRozf0KjpmA5TVokEa8FIFbkmk1I=; b=MjJ9r37cDKMa9lXZ+We0NpFaXRH
 zpA2xqg73jGVcKKVhBDIp9fzXiBmtQau2OEYCj6HNntUl0JmmK+ZZexeKTye1lYa
 LSo675Tu6vb06UAceltXGQaQh6z9D+Nlnl1B8noqqrrfaxp/0nRFtw6BCwZUKSe3
 +9q+p4PqAQZSvs10KfT2dl1RQ5UMYOO/SiwKM8qERXFdAtjxSHK9FIRvgO4tMBA8
 sFntQHi8crMG9J1pELgCeg6wY1NAFd9lyseT1SAiCC3v92wp8bO/VQxrSQr4WSdP
 FddX1S5spUNbn0bEz0a8m9U2Ko9tpa/B83XY69Xe+AADitVmPoHVd0z1Oyg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr8d4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:19:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d98b828c8so6947626a91.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780996781; x=1781601581; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVxZ9MSPRgUNn1eHRozf0KjpmA5TVokEa8FIFbkmk1I=;
 b=YmcTpOtTBSX75M2cV9eDFxKKvv7A+QevjY+MrSuGeka1q3Q9+aLQkd8IaDR67CoGXw
 IJO63JHlnIOfJDghTEDcT6T23p0S59ZoyPl/g0fjYfErXqnmOSUJTF11FWxqSpuI052/
 gWwb2VGHTy0/sb0wv0B9QI+wWGwC4gnzeVo27j2BaNKwiOPPa1Mm4ySCjoiEKXaiWhkg
 wCi8G/DQlfmWFYmk7knovkToAjCGMc00ztcn7G8LGXAQceaSquJo/+OLf6SPK178cYOh
 pej/gfiI1oa0KIYBUv8pyGMUKlbrPfthPKOrj58Qt8eKFdpXpgJ02rSVXJIe3HCkc7+h
 eTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996781; x=1781601581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CVxZ9MSPRgUNn1eHRozf0KjpmA5TVokEa8FIFbkmk1I=;
 b=Q30kvL4/xBlL5Y/3siRIhh3x2DYdwAU/ja+pM/Dz6cUbHDskdl7uMT3Ow4rGQozRJ5
 w/qq8edX11WzwmRHt9ygVTWf5M310kmLqAEbpvQ4RL/MlYD4vaKPjW9TPTieDZ5VWOEx
 cA4Prp8HslSmGF6QVicBWfGaNLLQD/vN1TJooovPJMkiruZJG5cN9If/efKHZeU1DVAS
 mCNU6ffWC525emv4/0VglHYBi9WArSPJQ9g7QLheVY8qFlx4AO/E8k6sCJlFjy3XMe6D
 bnXXkCnUeVEJQS/BWAAKy6x9376FNn1QKj6kTQt1Td1ZlqPR6OKnqJngX8lndtOiuQ1l
 RZqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2vj81Xv388e9YzBVCCOHQzjexNBu/SMNKr8SrmXvvBfCjSS3XSiySF2heVWeFM8JGocWkxwM=@lists.denx.de
X-Gm-Message-State: AOJu0YxOI6e3CHEIKVFbJMkrAursjE+R29RZgNLRI5IA7Wk7TASIjH7Z
 xgRiCt3yHuUvsVchzO1tj6UJbIMisom/Zyb804p+Uex3xuG5sIaelOuPGh1lT3qi59jAepIsrPL
 QytTiWiE2xHc918Ar8r4vXBh86dFSnZu24jcAvbGUzELswCJ/lVU1HN9CegK9CclD
X-Gm-Gg: Acq92OFOlRlxO6rYMHnX2POlIlC6u2L4XAGvhBVLH/tZv1SsHRwCtQtA6Kz43dXpsTC
 rKFHVSghPMprbxkuMD9zyHjiTeYV7kgNOO0s6J4U0XtiLl314xIAPvMpDEA45lva15/bRTJHNXI
 IUk3Yrk04Vl3nAT0Sb8P9lsXb+8f9IEJZw1T6dlRQSuQLbTrjFExdN8gJUxOe9X9jlw9JpFb50s
 MJCv95x96nJ8LkxTsAMnULe+TXN34fj87mr/vOvfBjXHl2GC7SbTKv2rzzHDlglZrkXNLwhwmFq
 HXqCHshl5zaJxlVj0yMRtOvFpFE9ASvqZ3/m9xiAyeyOF+0ky0VbAy903AcOPDaGFl8BoeUjjQU
 a6Lw9nynSS2XSr42fDqhMRU2VE+cwwrvSCnMmh8qhUI5ZOvpd4K3ArN0w0ilgzoPAdcr7QCncRB
 7ZiStc+QgeWvRRD/6sM+DNOuHdB0zJqcyK9rzxpaq8Iipnh1KNXBY3
X-Received: by 2002:a17:90b:57ef:b0:366:52fe:e749 with SMTP id
 98e67ed59e1d1-370ee82fe8dmr20397080a91.5.1780996781389; 
 Tue, 09 Jun 2026 02:19:41 -0700 (PDT)
X-Received: by 2002:a17:90b:57ef:b0:366:52fe:e749 with SMTP id
 98e67ed59e1d1-370ee82fe8dmr20397057a91.5.1780996780956; 
 Tue, 09 Jun 2026 02:19:40 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf90a32sm22851397a91.1.2026.06.09.02.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:19:40 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: funderscore@postmarketos.org
Cc: adrian@mainlining.org, aswin.murugan@oss.qualcomm.com,
 badhrinath.s@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 casey.connolly@linaro.org, danila@jiaxyga.com,
 david.wronek@mainlining.org, jh80.chung@samsung.com,
 luca.weiss@fairphone.com, lukma@denx.de,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quic_varada@quicinc.com,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Tue,  9 Jun 2026 14:49:24 +0530
Message-Id: <20260609091928.1564605-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tg62gv.1na72fsokrnbj@postmarketos.org>
References: <tg62gv.1na72fsokrnbj@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mF1Nh_9bna36zTRHmgVVaM2xlfDVGJ-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NiBTYWx0ZWRfXy7Hp/VpA1IFX
 v/TnAiZEsWuDJ7Mv6zOBkmt7Jw7FjqWW0/dwvo/7HS4jw6EAmQvC3p209fVjGL69j2qqOMjdv5t
 dsKPET2INUMUq3J5Ih/sLeitHA0d9FRMK59+RKb3sF5SuBCTfYPrY4YrUwTsYjEFG6h3pVqqmYo
 8C6mF/A14GzvyOsbDfABWeRfV51gtL0LLBErQtAZWympcKFTlRjY9haB9p9XEojkZlWvi8xl94e
 vGzpzLXwrg/UD6oG5RN8IliZ1goSlRXySNApAuXKEM3mprBacBphwv4cJK5qBg+geoGmubFGMur
 QsOtvuTn4soRee2ewnyHWlVTS9mxBQGmweoF+wXRZRcrcU3rEqnfw19xezB3RGzYVqirK/SvmYA
 q9tKvCKc4BMXlW/+GqKftwHWYIcvW81wOxzH8S83FC2ExpnSL0mHlctH95sQbVVYOGaiax3iaoe
 qmkgQcNOd55T4VIf1QA==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27daae cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=qJ7kAIfgyDNI0tkLrOAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mF1Nh_9bna36zTRHmgVVaM2xlfDVGJ-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090086
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

Changes in v2:
- Fix SPDX license identifiers to GPL-2.0-only across multiple patches
- Address review comment from Ferass

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

