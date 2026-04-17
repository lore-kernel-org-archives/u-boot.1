Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0EFF43698
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81618426C;
	Fri, 17 Apr 2026 14:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PipsTlBU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmumDhnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0714B8426C; Fri, 17 Apr 2026 14:11:43 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA1983B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H8G5r4065678
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JjJVNGIsvYp
 3PvPwE5tlRYGCsGF4HKUr9InaaY5Jr04=; b=PipsTlBU1JWYtA6ZsIeay8Klva3
 srqQGdplAjuhJFa7xvcI7RU/c5hsp6iWQtMx72Gv7/2GCX5JTcCAfWbvc27WD4AP
 2UTJTTqzs51u+tIMUisfjgWiZzBHsqFPvZ9/dyvlSy1Lc+CRpeW/W7zV5pOSfxXy
 59mct4fq7t/OytnMf3gbwinzAdYhbRQQa2DCsgp3tMhlgiUh4ykVWJHJTXB9wKf9
 xqZv6UWgWUktXFb9CvujZdyyy96n32ZeESVjsHY9ZTemWo5BE6pfICldu/Fvcw8Y
 QYr68LcR2D/4OVQSbzAMnzaoZcDukAhymXBCZKjU6XzVRuzrglZ8y/wGKoQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk3af3p79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70dd30025fso787278a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427898; x=1777032698; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JjJVNGIsvYp3PvPwE5tlRYGCsGF4HKUr9InaaY5Jr04=;
 b=XmumDhnIqa26VpbUrFds4Rc5wIWfRT0ca/oceNLr7Yly0Air+pH9qR6z4ISRIbcVJ3
 PGvho3CqgMIUxUy9Sc7EpGA7qS29THilRkd6X//Es56FpXJU+qGiUuCO3gAu7xmtpcwF
 zNRD6E8qwXcDIiz0A3P4LzDFq3ipSBIgzp8LEXzTiracipJAiagfhbaYiqj9jkduwnni
 Y2HovEphS8PJ1RdjW2EKX5yXF4bdlUPdUuYZPIrRNBH82Q9kg5OhYEiPX6nHVvF1Xpp6
 VZo7wA7RWyjJyZNJDRsg8zEvtK3weC3JBtylUmVrGFqzTXQfqNjeA2ge/Ohj7hp6pbNs
 4m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427898; x=1777032698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JjJVNGIsvYp3PvPwE5tlRYGCsGF4HKUr9InaaY5Jr04=;
 b=VfZZ2kDxlQGlnfO6hWxwm6nz9nIeg9/dqZ0NrQa9ttshlvEl3naG6Q4Dd6qMeJ+XBs
 d7Uicbx4mCYngbKoL+evxombtw93mFDxHswQ1EVEbiY4XpmyPdFTtaSbfVaerS/x0IEm
 K2PAaEsfbH2DlBVUt08w7ER2XeMrdUtZTdmkkMw83YEUa9OD7H5gRAGJnjyYR/GIUurT
 yqRbg7zMAAaELjQNfESJ21o4f4B4MTfOYNVglTueSDWJ7Ish71N9zwGNMmo/3KWXLiVP
 beADdYfDhX+PI8ED2yxW9DWWtMHhei/hle9ej3SaXPrvsxrlXpJwJeVfTfAy5wTQZ3g7
 8BOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+83baozuD740IqWGTwMqo/GEuBhB4dGEz6gVmyTTBs4NPp8c79BNJXAIaleJyhLrzGTZx1l08=@lists.denx.de
X-Gm-Message-State: AOJu0YzVT70Inp+9kj3KCNtBJq23cIMoXnyhh1ErhKWy1Z2/abu1lLRm
 z7gvo/H5Uqk+fDfQeHL2Yzt9AP2VUUrtyDtl6jZ/6Sgol3574plPA6ZSKD2ZG08tNJSqESZw86m
 9hZaZRDNd/dntxUOWj1XrVUY0eXtdaVEZRnlO9Qp1U1ZbJG6WumV7TC3C
X-Gm-Gg: AeBDiesCzq54swtzfXxR9Q/+SNIXeXz+R4vxq3N/bbJq+fJzu/WbyDggvB0dFXPmLy1
 lzmLP6KXE8E2xwd2uHrffgl+oytyHxCSBV4X4gjM+TbKNxkPjZjwGNgUyMz+ZyRp/A0BStCmquw
 rZo3fazP4WHP3r8lSAdnPFF3yqYFUfIPt1ROtP2ZD6lPIb1XnzkL5Q12hfKiiK+AcEo5yHONU4O
 lxLSzh7cA9qCQDBTNwmW58VdMyZ80jyuq6u+0lAySxIfhTCmA9gV+MfLxWUG+TtuBhZh8ICINSc
 3MvNgLkPsl/eDCCDH6s0XjEB2Nrobt4OnRZ4b8e06H3jpIUoXNwyDOJ2SGbLVxgCWH91864MbmK
 mYwCl8st6RLXfZ3yU66ovrYXn0K4qXFLIiBGJGK8K9agXDYwPB7V2uRbnD3fZ7QE6ZGL3+2Q6VR
 5enImpit7UM/p1MvBzkw4uAYZ1PGwJQG7xmrtx2Jop5PpwW/9zyMc=
X-Received: by 2002:a05:6a00:2ea8:b0:82d:603f:f3a with SMTP id
 d2e1a72fcca58-82f8c8c7bcfmr2606884b3a.24.1776427898193; 
 Fri, 17 Apr 2026 05:11:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea8:b0:82d:603f:f3a with SMTP id
 d2e1a72fcca58-82f8c8c7bcfmr2606823b3a.24.1776427897566; 
 Fri, 17 Apr 2026 05:11:37 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:11:36 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 7/7] mach-snapdragon: Reorder header includes
Date: Fri, 17 Apr 2026 17:39:51 +0530
Message-Id: <20260417120951.3454249-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfX/BkviiMCx+KY
 Hb/DWaDDlNtGKpD9oJHVHUsaSqhdSYVx1ZSbm08aXi6JlMqhQ28eeXIsMEALelGnUDqQBL3Y3Dc
 EGxwIB+C54QgNegqh82RcGmjaFEfeUoXMJQsDT2Ks2SPjeQx0xBHM6DWzj67Nnfs1qI/O3LOpAs
 P7reL6YJ1T9+Uog0HvgIajKOGMCf29tzvRNt8EvfNtAT8D0CFpwtSCrZYqZ4x9Thegit5Dmp2WL
 +8Pa7BpVkn/rrGM6/ukeFEsGEOTOX0GAG8+kyDSSlne7pZ+v/XfuBYvYfv9iAduAf4AsrQOzSXP
 rc9ZrB57dN0wndqNnZFT7ZZ8Cn1ABjMYeGnBXQV+TmyKcpqI+Ja8mS9WvObOB5Cd40ZoiYHbtB/
 +b/+GjtbjczMWE0BFWM8NNB8PYtBo/5sdiA6XMvYvsliBPAUktybz/RzWG27erYer1l5yo73kU4
 eiQzotozdZZr+PIe4zQ==
X-Proofpoint-ORIG-GUID: CNoioxn_WsY0PcwNbGd8i4sk6J2WBYIN
X-Proofpoint-GUID: CNoioxn_WsY0PcwNbGd8i4sk6J2WBYIN
X-Authority-Analysis: v=2.4 cv=DfInbPtW c=1 sm=1 tr=0 ts=69e2237a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=2zDxopu0hkaln4iHHt8A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170122
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

Rearrange the header include order for better readability and consistency.
No functional change intended.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 6a482ed186e..82bbbb8cba3 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -9,6 +9,16 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
 
+#include <env.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <lmb.h>
+#include <malloc.h>
+#include <power/regulator.h>
+#include <smem.h>
+#include <sort.h>
+#include <time.h>
+#include <usb.h>
 #include <asm/armv8/mmu.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -16,24 +26,13 @@
 #include <asm/system.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
-#include <dm/uclass.h>
-#include <dm/uclass-internal.h>
 #include <dm/read.h>
-#include <power/regulator.h>
-#include <env.h>
-#include <fdt_support.h>
-#include <init.h>
+#include <dm/uclass-internal.h>
+#include <dm/uclass.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
-#include <lmb.h>
-#include <malloc.h>
-#include <fdt_support.h>
-#include <usb.h>
-#include <smem.h>
-#include <sort.h>
-#include <time.h>
 
 #include "qcom_fit_multidtb.h"
 #include "qcom-priv.h"
-- 
2.34.1

