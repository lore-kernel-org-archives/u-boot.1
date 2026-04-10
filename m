Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825AF44857
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D4F84206;
	Fri, 10 Apr 2026 14:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZxNCIaB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpXjEZHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866EA84105; Fri, 10 Apr 2026 11:13:31 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64AA783DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5LWFe2698258
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8RHhlGfkCyg
 3wVy5D2YQsSQAsJseuqrsdDjJcZLKUgM=; b=JZxNCIaB7vX8bIDzFyYHUBvgJI9
 SZzsWgLvaQtDB8a/igQnJSDZCItQCSsN03Q/uWIcTcQe85Wf0x3d64hagMIkXPQa
 3titCOAWUd8XnMt72+uIelJzrz2GEkWZmjbPFlqhUOm+8ih3herJqGhgBtqn/JsP
 BGbs5V1hvg9yelmgKok55YG+lyfzeZfRe9RWup0hvCG9Tq2k1hUtW2X4Gj20NBs2
 8Zm13+6ztLMCRSDWE0OUseIp9q47xB9bjIZrmiwxtCG2h2XlbRAkp1eSkrMU9U+O
 PJy5C2xRq4zMusZ6mJK7NYsdsczoKRgID0OmVOSFjzuUCYrJfh+6rbCYZAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tg1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:13:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso4244870a91.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812402; x=1776417202; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8RHhlGfkCyg3wVy5D2YQsSQAsJseuqrsdDjJcZLKUgM=;
 b=cpXjEZHvcjwn34JyZE5i4KtHgcTbtVEGAMaDu/IUGP56c2Eh2judF1kNPjj6gpQfp9
 vEQHVOTfNz2cyxSC5vLFPZ8RU/DX2LY3ZZW5MADqt7do0IXHXnRhJ/BMKG2EvStXK10+
 bnUeM/bDeuxTgTQ1zQRrDHnHuK3sY6/86jZDs3qieXajuI49Jq2bsq4j6LBrzoDe0JVl
 rnFT30OOYl0yAJ9/rWLZ2VbBVHe+E65z+3KoHXTRrDAA2Ic6NTQt4hLVHTPcCFZ5nuAj
 rkNBVWThgy/jMhiS1sjH8xyQd7uPclyFEp/rB/oWOltDZJguKeVgYplCGD1XqZBDU8RP
 nrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812402; x=1776417202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8RHhlGfkCyg3wVy5D2YQsSQAsJseuqrsdDjJcZLKUgM=;
 b=P/3brOhR1RyDjOvP7Xvqb13sS9PVaXH3bmyoI67Z7PpnPucg13Fz0RO2+bpznFbHsr
 kF79AoUSW9t7nMnLZzGU9vb4b402C9a9G7U6zm80Mq1ywym+qi2S2lf/6vnes7+tm+IM
 8S5UkCFu6t+UN484FDQGpj6qDYm/cvBLXvoyqbUONAGh/wK8xw8dHngy1TEoFT5PWFOA
 Rj20XKsEzHDJaLbwGn3nOOEcHzu8n97Yimftmp6E9gZIg75GBEzR5Y+zc3RL0C5ihblD
 xcNhUOqKgjAxZqU+fv4SieiQiJz92qnKtm9Taa66e3rkGpY8AqvXfrYzPGhGpgqoVLde
 vk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy7JMcseF2M72j9nYcCQ/pDHjE1SzlGvSX9s0qETEy/EKv/QmDMXX41oYUKOa0FHlRBoACVn4=@lists.denx.de
X-Gm-Message-State: AOJu0YwK81O/3AmVZTk101zYD7tM63iaJulhywW2PPz5aLGX1QxHit9p
 uxkc/0QQe+kGugOrEVVMaklfLjHY/imgOMh6e54qQPYyc4ndiJyloUwX+O230XCqBf0RUiIYK3/
 SdH4CNAxF7ja9BJN9suwqkqr/s5TOcVQ114KlFSWu5+bdcvTX9KapPjiy
X-Gm-Gg: AeBDies3rm/6exlL+dhzCWbQ7/YYdIcNQdXcXQ4ZOH2HuqudtN8TqtEnkCjqXhCbeVz
 HANUVqorlNKDY00zXs4R17kRJ9p1xbaOIuRqGfPBuRhLC4lNjt0nu7/CAprkpAjRktKHv1/6czp
 nOfqIFqf02uscX528O3tqf9CVUunOSkCfZx37OS/rBftFqizX5Fw0nZc1UOAl9bmTIFQpXyXQzH
 ug71anBOLyXbc/sIv4wDSt+ZHjMxyOk2e7WcSpon+5hwFevY8nbYFk26l1mwxqgJp64vZO8Q62p
 nVgFiF8P9FEL4K+s+ZNYHeIb8oRoyaZMvgNAeVhfxvP0I/J2F3kpxnUnOUFAMzTPH5tNB0N445h
 WNWOO9CVNg4hkazWdrttEWSzNZtp5vS8k+n9tpin/ChVb3enohdFmQAtonsEpsYrGjkthpcYrN6
 6Ll0NKVODYOuAJ6PAS7yYQkpenS5isVeeBcNQMLKpUBaM/UqAl6uw=
X-Received: by 2002:a17:90b:3e84:b0:359:fd9a:c513 with SMTP id
 98e67ed59e1d1-35e42857738mr2863818a91.24.1775812402418; 
 Fri, 10 Apr 2026 02:13:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3e84:b0:359:fd9a:c513 with SMTP id
 98e67ed59e1d1-35e42857738mr2863754a91.24.1775812401861; 
 Fri, 10 Apr 2026 02:13:21 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:13:21 -0700 (PDT)
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
Subject: [PATCH v2 6/9] spl: Include SMEM driver in SPL
Date: Fri, 10 Apr 2026 14:41:51 +0530
Message-Id: <20260410091154.1001021-7-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX5i7UxUhBvt43
 VBYumVfr/OtFIguiOSQj1nmyIoOllIxzqC2dOyCeVHkGwRfM2cfrCPsnXlW6JbrU312DQyEzUZd
 heFdHT7zUxdcMWnA0wb+gbEsFU5P6wO9ChuqwGeZAoL54lLo6GtS6bQt1qrnj9k1Z44yDfzDwrx
 U6+5aIfuVhVPiSF2OuCSe6z3VGkw/9lnWcNsLdlwcVTnWnmYzTlucSgCxmOdZdXyLHlXFCsIO9Z
 3sgfjBia3xXTr/GWGE7wu+eNpSysu2LmcNsS+f3yjJ87oBBAMp8O7Ulj+ByQVdS/rlEEnUrQX67
 7i4+z/wAHAKyuRb8tnSIt38lrYpJxS5Fx6r/1/NyXs8d6pnfuWXJCl4ko+WpRuihBwQy3xOR4J1
 OAK3uSJTaSo/rkUrNzfuAojXj7Y6hoTUVs83Hjh52lNkuAqRIXIUvKZW0ST41ryGTwJKcLSJMoh
 VlPXeo0wKGuGbSG636Q==
X-Proofpoint-ORIG-GUID: OhqdCDfILY0Y6_ZGFY2uM0eeZcwgotDT
X-Proofpoint-GUID: OhqdCDfILY0Y6_ZGFY2uM0eeZcwgotDT
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8bf33 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=urvU1upnej4-CWmsP9sA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index a21b71ad5d1..97c4e8236a4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1384,6 +1384,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..ead082450ca 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif
-- 
2.34.1

