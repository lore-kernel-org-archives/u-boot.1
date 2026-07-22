Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A46C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31CB54073D;
	Wed, 22 Jul 2026 07:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rc7imxPWhNPc; Wed, 22 Jul 2026 07:42:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36AA340758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706179;
	bh=i1k4ezI6ZzA0kcxZ9OE/XmLJMTWTSiVRzpxk8OzO99w=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ViOok/TH3t9z8HtOCxWQ5o9LdGProKiIgKq+NE7XGfwek/xSJss0lFYdiUGEw96js
	 fvjPBS+6r4WM6gHzhlq/s/EdT8PCZYDItEIBswCdBLpNQQJlauMLMibCvJkf5jDnOr
	 wHByVdhrNzruVjiAmOYwG7vws3hnUCHLcBtRfgicQRfTLiSyKb4J5nFny6KEkXCRY9
	 WnrDzFFt7tltpbiTm7AMU4F6NvxygJpCkahUmUon+b1/4yaqb+cvOCyp+PejaGDhaV
	 LivMX8oL5lmZhxGOTXt1uCsbpNpf1QnCQlv3V4YBvLVm07RIaA1Im1u/gieevQxDFb
	 UcQ/pmg/PLY6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36AA340758;
	Wed, 22 Jul 2026 07:42:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7551342A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66D6480DB3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lianhKJeCDcm for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 36F4680CBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36F4680CBF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36F4680CBF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:56 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M548gY4046136
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:54 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6daxgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so124171325ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706173; x=1785310973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i1k4ezI6ZzA0kcxZ9OE/XmLJMTWTSiVRzpxk8OzO99w=;
 b=lc5nujEruPhcCqu0L9WYcIddafI2LCFy4MHshRduG3c2qxED15bjplgpC4NFI6bZ+I
 ZkTHeUfLVz0anoKeGbuGBqWV35XD76fe5yEgWqeQRz6xblPlZV59JdaBEOgtuK6YniIS
 xMu6hWCsJMlAvQfVVXgP43eylgrJIjWqi39waklUHbPeqbJGVDq82xpjjjTIVFtaark5
 XCxXLDKL9A3mpYuLlbPBB3dm+2832CvNTRntc0PbhdWOHAhvB3/aFmTICf0loB8RJlya
 jItv/EQbXeYO8yEocRI9jtMgSxB6PC0YthzDI1tNKXtiG71jahLCUY/0r4n6GIw803lW
 FSVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3jloasm6ygBHEepMTetltbd6Mqy22Hf5swiHjaPmWG/CCLXp+MXg8CffEm2xjq878/TfCgzI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzzDcI1LAZ9Ublb/vCm74/4OFWixwdqWSDgO5YCKP3rM5jY23aZ
 7K+sdlAFOLUBWRJGaZmX+pUDGosH0EPQEN771aHfZEg82MpZ0We/ew6teekQRpcHw3K0ijMA1z1
 LKUE5iztHXEhi4pVSrSD+5fsRMrsK8iulWWyaMDRiw0MSQS11HS50PtSzk2RGlBHlTCfA0zc=
X-Gm-Gg: AR+sD12w1tAEfvMZjbTjPquZLgLOHBDCQH5PGM5xpTh9QL4iofsVzm4NlXoQnSCZ5IQ
 7FeJO3Xg+wmv9XwcSl1BFQAJADzNf30shhXg+goSnWTyx/q+t6QjZstzN3du3rIopYnXyzyqI0z
 VaTl++XAbL+8+APYKBk/z3yX++89N3PNxzF2/VpPsVY6/pw4C7DcH4zGwFAfbubrm1dMTSoQkQT
 QH6OuqIXD4pI6ftx6UZJVo8NNRfmS14xozPycJ8LYtaB2Gff1dxGBnxQRBpOmJ2Ahets42/eNI1
 YfxUaWM3KUx29I9ZrRnVJMPy5Hnp6sPp9NXlTClP0I06iJarwu7CQyHUKAVPZRIZt6gZ7Gshm4r
 4bxqNapfhnZ/aEsawV+y89gMmLiQajXdBuDsNvzSebZ+cV1GUhxHOfvsLzn4Qqlm4vqCozYpQck
 yuOZIc3BPdUmukXg5qE3CO8XVj7dXUvQ==
X-Received: by 2002:a17:903:2287:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2cf348366bfmr225348615ad.3.1784706173388; 
 Wed, 22 Jul 2026 00:42:53 -0700 (PDT)
X-Received: by 2002:a17:903:2287:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2cf348366bfmr225348345ad.3.1784706172874; 
 Wed, 22 Jul 2026 00:42:52 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:52 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:20 +0530
Subject: [PATCH v8 09/15] mach-snapdragon: spl: Add DDR initialization support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-9-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXwMc9oouOCkgg
 IDBjlJ1uyjaIUMDwhmlBIHu0WY7sPhtVub9WJR037ZL/vACiePPyrGt55SLGQllFnojDrGD0FjS
 MQVSWCoWeGyIKBBdtRAC2YOmcCaBuZ4=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a60747e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=oD0DQqhpZ6C1r4bS0y4A:9
 a=Svgtu5OVSw2QrOgt:21 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXx0hxTTqNlZ8h
 Jomll14N9krxUVAyAJ5SjstWQpo0v4aTpyJHsTQ335CasERhw4uRcBZnw6BaaEEQ+OfgetqLI7Y
 lxGQTu5IPJPPFbXVOl0c/HyTDnhxDdwyTjh9INT6o3kwWAF2jlr+SoyUj2c5CzZcaqbTRZGIcvS
 DphXat2znlMYt3J5EcVeFt+96VOJgcsJJxZ/8lZTvA+rTEGwLNyXFbt9D/aFxi4m8IUcy76bNb9
 BtkJmL9eXlmRKLBqw03GPE1ZtfxArtSSKtVR3AtiG1M8N951fDFd2ie2XMhX14TADihezgE0eO5
 695whsFs+wF31y3bt6ijMxn++gpeZcfSrUwy7T6SR3XF6llfskdgUWglQjd4mmLmicHsj8rBo7w
 AxFPOYRZHx4e6QNqPYkNCD1xm/SW0z9oJwLN3+VWpGyXMWbjTBmPRzgamr6h+g9B74oNXOgE1Vx
 aaF5ILRLis1zkz+HF/g==
X-Proofpoint-GUID: uyK_Uz99mvy2vR2z3Ze6mh25xmNK9oDn
X-Proofpoint-ORIG-GUID: uyK_Uz99mvy2vR2z3Ze6mh25xmNK9oDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i1k4ezI6ZzA0kcxZ9OE/XmLJMTWTSiVRzpxk8OzO99w=; b=FZzKrGrF00JYhuFy
 IMpfA5gIUasfZBgXQWROp45G5JTu8xu2sDBIP7Ns517WDN5GEJzawNLm2O0efqJN
 h/yichaHcjDuguYPoLdukkeRlszZTupxm2bmmz5Dns9yJXmFCTQoHGlH6wKE17e7
 W0Vfh8TgEE+Y2cnJGQ2rA0EEC0VjwI+DF17IXWpxk7O+8I78dsUxkEWQ8G9ANMv4
 +XZfFcwXkcpbqD8W3tfngJ7EnCWG8YKi/+bLnLZLfZfC1QqgWKhYC5G+lCi6HsQK
 CYVUjgcVMGWb/NHpbaE8AW+HZMe4oFUrqSzVtkcOFA3zJZwBbOT3Q86JUa3Nddqk
 ySlFQA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706173; x=1785310973;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i1k4ezI6ZzA0kcxZ9OE/XmLJMTWTSiVRzpxk8OzO99w=;
 b=UUecmVlnS44TrccTQyepprQM8pZ3ZJsq404G1/9CbPdr5ltdZy2YMpIRB2dO6Aocwv
 ghwrnZT69SRPHkVwtUPeQvbKgWMmUgS+iZWq/KycQdoFqyfpaJKmLwiEFkdN6g3HpvTi
 hN08HfZ/Q6QFJpy2msGFbK/X8+9r058UASVOTKpR6AebXSaEmYYUAWJaEAvzv5fp9BQI
 W8p7+WYKzDaFGx9XI/WrcJpi8x5prJaGieiSxmNdrxFlBYOcz1vfOM7KJEc24W5Y65EL
 UKUBuewcR8cbL5Dju7AbnNESRBis/Y4lc9ftvjaL33D7wv5us7Ebjxsay+jRgY622E5V
 oVcg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FZzKrGrF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UUecmVln
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The U-Boot SPL loads the next stage FIT image into internal SRAM. The
binaries are 'external' in this FIT image. The SPL has to load the DDR init
binary, i.e. qclib and the DDR parameters i.e. qcconfig used by qclib and
invoke the qclib. SPL and qclib exchange information using the interface
table described in doc/board/qualcomm/interface-table.rst.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/fit-handler.c | 324 +++++++++++++++++++++++++++++++++
 2 files changed, 325 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..f82ffe8f9d1 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += fit-handler.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/fit-handler.c b/arch/arm/mach-snapdragon/fit-handler.c
new file mode 100644
index 00000000000..b43ca8d4064
--- /dev/null
+++ b/arch/arm/mach-snapdragon/fit-handler.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <init.h>
+#include <image.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/sections.h>
+#include <soc/qcom/smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include "qcom-priv.h"
+#include <mach/spl.h>
+
+#define QCOM_SPL_TCSR_REG_ADDR		0x195c100
+#define QCOM_SPL_DLOAD_MASK		BIT(4)
+#define QCOM_SPL_DLOAD_SHFT		0x4
+
+#define QCOM_SPL_IS_DLOAD_BIT_SET	((readl(QCOM_SPL_TCSR_REG_ADDR) & \
+					QCOM_SPL_DLOAD_MASK) >> \
+					QCOM_SPL_DLOAD_SHFT)
+
+#define MAGIC_KEY			"QCLIB_CB"
+#define MAX_ENTRIES			0xF
+#define IF_TABLE_VERSION		0x1
+#define QCCONFIG			"qc_config"
+#define QCSDI				"qcsdi"
+
+/**
+ * struct interface_table_entry - Meta data for blobs in QCLIB interface
+ * @entry_name:	Name of the data blob (e.g., "dcb_settings").
+ * @address:	Address of the data blob.
+ * @size:	Size of the data blob.
+ * @attributes:	Attributes for the blob (e.g., save to storage).
+ */
+struct interface_table_entry {
+	char entry_name[24];
+	u64 address;
+	u32 size;
+	u32 attributes;
+};
+
+/**
+ * struct interface_table - QCLIB Interface table header
+ * @magic_key:		Magic key for validation ("QCLIB_CB").
+ * @version:		Interface table version.
+ * @num_entries:	Number of valid entries.
+ * @max_entries:	Maximum allowable entries.
+ * @global_attributes:	Flags for global attributes (e.g., SDI path).
+ * @reserved1:		Reserved for future use.
+ * @reserved2:		Reserved for future use.
+ * @if_table_entries:	Array of interface table entries.
+ */
+struct interface_table {
+	char magic_key[8];
+	u32 version;
+	u32 num_entries;
+	u32 max_entries;
+	u32 global_attributes;
+	u32 reserved1;
+	u32 reserved2;
+	struct interface_table_entry if_table_entries[MAX_ENTRIES];
+};
+
+/**
+ * qcom_spl_jump_img_entry_t - Type definition for image entry point functions.
+ * @arg1:	First argument passed to the entry point.
+ * @arg2:	Second argument passed to the entry point.
+ */
+typedef void (*qcom_spl_jump_img_entry_t)(void *arg1, void *arg2);
+
+/*
+ * Global QCSDI address populated by qclib_post_process_from_spl
+ * Placed in .data section to ensure it persists
+ */
+static u64 g_qcsdi_address __section(".data");
+
+/**
+ * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
+ * @fit:	 Pointer to the FIT image blob.
+ * @node:	 Node ID within the FIT image.
+ * @entry_point: Pointer to store the retrieved entry point.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
+					    u64 *entry_point)
+{
+	int ret;
+
+	if (!fit) {
+		pr_err("FIT image blob is NULL\n");
+		return -EINVAL;
+	}
+	if (node <= 0) {
+		pr_err("Invalid FIT node ID %d\n", node);
+		return -EINVAL;
+	}
+	if (!entry_point) {
+		pr_err("Entry point pointer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
+	if (ret) {
+		pr_debug("No entry point for node %d, trying load address\n",
+			 node);
+		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
+		if (ret)
+			pr_err("No load address for node %d (%d)\n", node, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
+ * @if_tbl:	Pointer to the QCLIB interface table.
+ * @name:	Name of the entry to find.
+ * @entry:	Pointer to a buffer where the found entry will be copied.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+					    char *name,
+					    struct interface_table_entry *entry)
+{
+	uint uc_index;
+
+	if (!if_tbl) {
+		pr_err("Invalid interface table\n");
+		return -EINVAL;
+	}
+	if (!name) {
+		pr_err("Invalid name\n");
+		return -EINVAL;
+	}
+	if (!entry) {
+		pr_err("Invalid entry pointer\n");
+		return -EINVAL;
+	}
+
+	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
+		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
+			memcpy(entry,
+			       &if_tbl->if_table_entries[uc_index],
+			       sizeof(struct interface_table_entry));
+			return 0;
+		}
+	}
+	pr_err("Interface table entry '%s' not found\n", name);
+
+	return -ENOENT;
+}
+
+/**
+ * qclib_post_process_from_spl() - Post-process QCLIB image from SPL FIT address
+ *
+ * This function performs the same operations as qclib_post_process() but
+ * takes no arguments. It gets the FIT image from CONFIG_SPL_LOAD_FIT_ADDRESS
+ * and finds the qcom-lib-1 node automatically.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qclib_post_process_from_spl(void)
+{
+	int ret;
+	int entry_idx;
+	int images_node;
+	int qcconfig_node;
+	int qclib_node;
+	const void *fit;
+	struct interface_table if_tbl;
+	struct interface_table_entry qcsdi_entry;
+	qcom_spl_jump_img_entry_t qclib_entry;
+	u64 entry_point;
+
+	/* Get FIT image from SPL load address */
+	fit = spl_get_load_buffer(0, 0);
+
+	pr_debug("QCLIB post-processing from SPL: fit=%p\n", fit);
+
+	/*
+	 * Find "images" node in FIT (get it once and reuse)
+	 */
+	images_node = fdt_subnode_offset(fit, 0, "images");
+	if (images_node < 0) {
+		pr_err("Failed to find images node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Find "qcconfig_1" image node
+	 */
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcconfig_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Find "qcom-lib-1" image node
+	 */
+	qclib_node = fdt_subnode_offset(fit, images_node, "qclib_1");
+	if (qclib_node < 0) {
+		pr_err("Failed to find qclib_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * Initialize the local interface table
+	 */
+	memset(&if_tbl, 0, sizeof(struct interface_table));
+	memcpy(if_tbl.magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
+
+	if_tbl.version = IF_TABLE_VERSION;
+	if_tbl.num_entries = 0;
+	if_tbl.max_entries = MAX_ENTRIES;
+
+	/*
+	 * Add QCCONFIG entry to the interface table
+	 */
+	entry_idx = 0;
+	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
+	       QCCONFIG, strlen(QCCONFIG));
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
+					       qcconfig_node,
+					       &if_tbl.if_table_entries[entry_idx].address);
+	if (ret) {
+		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
+		return ret;
+	}
+	if_tbl.if_table_entries[entry_idx].attributes = 0;
+	if_tbl.num_entries = entry_idx + 1;
+
+	/*
+	 * Add QCSDI entry to the interface table
+	 */
+	entry_idx++;
+	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
+	       QCSDI, strlen(QCSDI));
+
+	if_tbl.if_table_entries[entry_idx].address = 0;
+	if_tbl.if_table_entries[entry_idx].attributes = 0;
+	if_tbl.num_entries = entry_idx + 1;
+
+	/*
+	 * Get qcom-lib-1 entry point
+	 */
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
+					       qclib_node,
+					       &entry_point);
+	if (ret) {
+		pr_err("Failed to get qclib_1 entry point (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_entry = (qcom_spl_jump_img_entry_t)entry_point;
+
+	pr_info("Jumping to qclib_1 at 0x%llx\n", entry_point);
+	qclib_entry(&if_tbl, NULL);
+
+	/* Parse the interface table to extract QCSDI address */
+	ret = qcom_spl_get_iftbl_entry_by_name(&if_tbl, QCSDI, &qcsdi_entry);
+	if (ret) {
+		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
+		return ret;
+	}
+
+	g_qcsdi_address = qcsdi_entry.address;
+	pr_info("QCSDI address: 0x%llx\n", g_qcsdi_address);
+
+	return 0;
+}
+
+/**
+ * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
+ * @bl32_entry:	Entry point for BL32 (OP-TEE).
+ * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
+ * @fdt_addr:	Address of the Device Tree Blob (FDT).
+ *
+ * Return: Pointer to the populated BL31 parameters structure.
+ */
+struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
+					      uintptr_t bl33_entry,
+					      uintptr_t fdt_addr)
+{
+	struct bl_params *bl_params;
+	struct bl_params_node *node;
+
+	/*
+	 * Populate the bl31 params with default values.
+	 */
+	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
+							fdt_addr);
+
+	/*
+	 * Fixup the bl31 params based on platform requirements.
+	 */
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL31_IMAGE_ID) {
+			/*
+			 * Pass QCSDI address to BL31 via arg0
+			 * This address was populated by qclib_post_process()
+			 */
+			if (g_qcsdi_address == 0)
+				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
+
+			node->ep_info->args.arg0 = g_qcsdi_address;
+			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", g_qcsdi_address);
+		}
+	}
+
+	return bl_params;
+}

-- 
2.34.1

