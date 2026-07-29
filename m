Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A828C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 06:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42DBE607F2;
	Wed, 29 Jul 2026 06:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IlOhyZFw1vPF; Wed, 29 Jul 2026 06:01:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 371EF60768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304878;
	bh=6gQhqd2BNeg07cLQ/l0IyHmtL548El/21D2n1+XrDhI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OuYEtxcPNoERMl07Lw+HykIZXrD/MJCAta8PZ7WvM9BL0bU8+Gc7b3kVY6NLl5j+p
	 aNfBfnOPFv4+RCA132fZKupd0SiLsAm1odlBahiShLZVnxRvbmLyUyZkFH+F/BjpzS
	 yb7i9Tj/0izv7k1Omtp64lB8gNObkE98jyNFdxdwsr49B+vnVexSfjJYufIgVUpduS
	 stBKdmHLSLwziGpfyFaieDk5o+jU5hex73iVpeZLv2xQSfglIZ/QB1QTkpsuwh71/k
	 Hz3uOw5GMSAj7WeCpqvfH3+AmzRdzbTRFN9oGuN9u5P8aWU80THXheODWKZFaN+pKs
	 NLZQ0jcOrTzNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 371EF60768;
	Wed, 29 Jul 2026 06:01:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC1DC26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E12460768
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9_1nghY3Vjg for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 06:01:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D27F6073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D27F6073C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D27F6073C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74DE8494B; Wed, 29 Jul 2026 08:01:12 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACCD8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:01:10 +0200 (CEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T5gWX32055167
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:08 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbm1g1xy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so645983a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 23:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304867; x=1785909667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6gQhqd2BNeg07cLQ/l0IyHmtL548El/21D2n1+XrDhI=;
 b=VHWa/OoNwtDMcikqsm1st0bft68sVzickqRW3w1fv0WKyWOBJ+N2O/ESSc0Xx/qov8
 l4HScvHlnHah3iGb4zfs77c+zhrd8982nExVJM6UEdwf5HJGXnJJoQJrn2IBYXgoI+fH
 5CyWYyriS7P/urimuRQe7KALy0G8p5MGXGeZutH36uFP0dczjJx9uahkJJ5HjYxnVCe1
 +RxhDYQtfi4NF8bY9+GzoX59ZiNqkZn8y6VIUkQkuV5Y1jYRb2VY+KCAOTvCrw5vU5Ej
 lfijc3LhyEwhKXEKIrurdHkpIhyabhZ7zz8NSKCKFYkKtw+rqOgvdRDaGi3ePJPy9ZrK
 4r3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWgEIVgc1sZR2yuPKvNmDxgdJ831vIFlTkHtCVo3YbQ6zxiuyx6/qAUVbKchlLKR/FZSuZiiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0t8yS9fYv6eh+4rUsW/td+uUWNtsj12h/gDqLOcwBMF1BaL8v
 gHbgTwuKoj8FH7ZfYZseCmTSslhMkupkeBi7Ew+/QAhyqHWU5qQXRoFPTX1XNHmLnaoX5Ny+DtJ
 dMyYSFRNnXCQTTUHOgdg9Gs3iTqkKsN2cssvDExpkaMDrsjBbZ5/b1/wO
X-Gm-Gg: AR+sD115cKoh7kUvlUfP/GCLCSp6OZwM3wUvfdMyxZK/7ahb/5TLBzWkzu4/vwc5rc+
 DvUTDcti1FojzlQUwkSiqSjD/ycpu4gfRai7m6NzMJr+ml1X7D/vmy+y/AAOufXZ3SEeJwkO+5p
 /bvrH/Rz0pcDL+0gJmTA5IFC0k5CKL01ic82Ski3rwvtLRMsUihH4GVQzI5D4fqp/6TQFXk2eU8
 hqYxmf9c1YVCojA6irex1AiZNMy52ndskQTC/hYcWyQyq5n9bYfQzNYRByAYPSzcVxkgQ+X80ay
 05nZGPF7/XkgZznQlCczpeJalBAzD8W+flWJKiqoRWWizsUYKfUUMIy0m/es53Ao8m8YkABvXsn
 mi4dsf6NEjnEojg1rjpSnH0jLfFi3FTf8WsPVYg9A2wfkWJZKfQebcEkhxjT5WrEkbn8zbvUkK9
 jPko+GAqa+dXsOa+PGbHSk
X-Received: by 2002:a05:6a21:d8a:b0:3b4:c9d5:cd5b with SMTP id
 adf61e73a8af0-3c8aafa3d94mr6746571637.13.1785304866970; 
 Tue, 28 Jul 2026 23:01:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:d8a:b0:3b4:c9d5:cd5b with SMTP id
 adf61e73a8af0-3c8aafa3d94mr6746528637.13.1785304866549; 
 Tue, 28 Jul 2026 23:01:06 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm6868367eec.30.2026.07.28.23.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:01:06 -0700 (PDT)
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Wed, 29 Jul 2026 11:30:52 +0530
Message-Id: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX4Zjvdolp6JCW
 dLmnrBOqAT2ry1pFhtEVb7aPLNGicZTUznQruL/jHFLP2JbDKB6erGCmFx0WIFkJ4vOCyxlMXhl
 sTQIWVNb9Zp4ybwRGEetcOkXtYzo8N/b3242NTrtwEr6EiiHYKCLLKGRxIIWX3aqdaCyYdbkl0o
 AhN0GDZop4U1xSqyB28d/nOApw5o9b4UlatcU1kSPHaqkOD92TuDQ8Hh8YSqkd7V1iAGFMqyAyz
 nSEfABqKBFMidxAEL7kuXZ8AT+EduKaS9z1I02x3uBKSNoehhypYGKQqAb7ZVZMckOArwedC8aW
 MV6Mag36SuTBM6kWDRWCwEYMnQaYEYmuyMoOb5oyVXk7eOCjFZdmxXHWPWxdR7S1R2nFcKW4wI+
 wEiL5hONzcHV5Le9QNfBS7958bi46SushHNk3Q7onpHAskcJaVXxojhcd2a+i4PBizHZXpUk4tE
 OZ6tQAfNqURAXm1w9cw==
X-Proofpoint-GUID: kCG98i6p2j63m5XFSPl6UnBAZqJgFHZw
X-Authority-Analysis: v=2.4 cv=R7Az39RX c=1 sm=1 tr=0 ts=6a699723 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=AckDw2-rnu9HBJosMKEA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: kCG98i6p2j63m5XFSPl6UnBAZqJgFHZw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX3eR0VX4Och4i
 tjVRJSaKzTuGVLzrTxZ1kT+SDr/bJ8J1APvww2PTDVaYVEGAA8Yx3LSAn1j3RuHO+cTg9yd91h6
 rhSpWVmdO4/4MPeozzmoO3WDZzhUTwg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290046
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6gQhqd2BNeg07cLQ/l0IyHmtL548El/21D2
 n1+XrDhI=; b=UApl8d668ee8PPxbW36OUcAV+xZ3rVs1YdTxYtKnjHBmWWgW2PG
 ShTFgXs0YZxt9com77TsfPH1m5F6pIfg2OJYKzfRVLJ52vZ4tgUh5T0ow3mvVKP/
 EgGcoLhqnc6EJuCViDyavBUoKSQAnKdIzgM1w+Cl7aoXucRX08B/bPG20XEWP6pc
 IJi3OgjQOCuRwrW9APOok8bLs2rBviLXmPW0SUkzKuWflJ9/GlEpIHgAS8HEHUp7
 YBl6cDgpDe1FT6DNtFJOTSDYmVVCfeIju2cU/tAL83kkGkiaDQtyISRl+5JmXR47
 Qr93GbU0Ms9vtRf8I1GN878Iv6Lu+UZV2pg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785304867; x=1785909667; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6gQhqd2BNeg07cLQ/l0IyHmtL548El/21D2n1+XrDhI=;
 b=hoYMgES03+4JW4nXF7Je8ruh2zLa9+SnXcW0GqEPDxMW3wupb6KRlgemdFJUWPmkec
 tXEKmFDSbIrZ64BF3PgPvrToA+BbGG5mTzPzWynzOpUAVQk+OEIyBiXa8zuAAHaxMEc3
 Qn8goPm85vU2p+pFlJ7iYYtglgOGSab6pE2Bnewhr3AdUaxeC15A2FajQTQiodS/tolU
 qX2o0HbdDCf437JQ83ho7vEHcInkiJbcF4JCN8rZbozMT1dBk1TOqSD8AIYJVEHfubm+
 /ZdEeu2YKC53RdFo49Fn79JjcRIZsA5o6evT5S0GMLJcX7sA3HUd5CMYP7W1U048HINQ
 WgjQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UApl8d66; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hoYMgES0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UApl8d66";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="hoYMgES0"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
- Link to v1 https://lore.kernel.org/u-boot/20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com/

Changes in v3:
- Removed the sdhc node from this patch as requested. The SDHC-related changes will be upstreamed
  separately by the kernel team.
- For the defconfigs, the common IPQ settings have been moved to qcom_ipqdefconfig, while
  qcom_ipq9650_mmc_defconfig contains only board-specific options.
- Link to v2 https://lore.kernel.org/u-boot/20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com/

Changes in v4:
- Renamed qcom_ipqdefconfig to qcom_ipq.config
- Removed optional DEBUG_UART configs
- Link to v3 https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Changes in v5:
- Replaced deprecated GATE_CLK with GATE_CLK_POLLED in clock driver
- Return qcom_gate_clk_en() result directly in ipq9650_enable()
- Link to v4 https://marc.info/?l=u-boot&m=178471712422519&w=2

Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  15 +
 configs/qcom_ipq.config                 |  37 ++
 configs/qcom_ipq9650_mmc_defconfig      |  18 +
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  93 +++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 9 files changed, 611 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

