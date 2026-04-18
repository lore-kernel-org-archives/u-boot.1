Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BDEF436B1
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E94A84214;
	Sat, 18 Apr 2026 08:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+zkeoBl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bfWT9+pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 322218426E; Sat, 18 Apr 2026 08:35:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BB983B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4UD3v509322
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LYdujdbNX6xgU08cZN6jNQ5IhNJNx/TGNo1vrJrdoJI=; b=g+zkeoBlcLcomj64
 63iYp24PgXaLBCcGZ/XRkhdCd5VOmCj7ktPi87lhSOJ+TWUWbNRgEuqxBABIv4lB
 V9NADF4dbS9iHiW4k/BedHZSpexsUq5vIkl6YyeFusasjfAmuvc65HmfHGM6uzDq
 03QXsx8EBU/cOLQXHeH8japmuzTi3zdP99g249miJbzY5TngGpAtixIRw1scev3r
 BNf3HPmOKE7pGP/zd97ghpcLcTgLO+ucsxYOzZSM5fGErJXx06+Gj0CXtlK81rAj
 WU/F1fIFQYkau7IztzyagH3b4jbO7NLnDPGQJqzFl0zGGEmaAF0fVStSr1iQUP4U
 ARpAjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b7081j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:35:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so14701835ad.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776494148; x=1777098948; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LYdujdbNX6xgU08cZN6jNQ5IhNJNx/TGNo1vrJrdoJI=;
 b=bfWT9+plHoV4Vz6SglrNwGYRfXr8rmw5RcWT4KtE3upaz9vW4T2STHMObMx52mohsT
 YpRW2b3kLdSh1vmFZK8djv4L4AGIlluK2f84Y82nLWZ27dxPytuFEwbY5envPIS84Zxa
 sRCBvyEK7pp8NVVf9Hl0Fv9Yuv3uQgmYudy+mG9N59LFBpZSx0HIlFmmLVsX3DikQv/X
 IrkFJi2QhNsk4BA0s6IbdiK18K9EVnAz4SBjYKLwpC3D59R7SY+saUQKbkk4pA5bFLeB
 fqlJaoMmdiMTA8SNFqaf0ZHEsV35Qu+ZJXOW05KKK0OneJC7Lpt1yVaBGTJs0hWPKVAX
 XW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776494148; x=1777098948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LYdujdbNX6xgU08cZN6jNQ5IhNJNx/TGNo1vrJrdoJI=;
 b=VNRWC9BNFsbvBF3JGBreoLlqr978IRV+1QPtgYU/2srft3c1YsbQFsoBzZILsOTLx6
 t3ogwAwL7+ODY5QMERU1JzyCnq00bQPCvYxWXGGQFueAlvHoMealI7OMFUMbLP0c/d2E
 dLmrkRr4jtXtccmqsa4TceNyl12Valpq6KZakcS3OCBmZ/1PD1T9vCcEEuY0rVkK+Z6j
 PAsIQcF0tosY6p/ppVf62Byo7TWMaTh0iGCq5pQVcdQ3C9oywya/sXgtSJWwOAgF7wrS
 oSrcMh0Q++K/YMl+CLddmwXBCPpwnT8c7WTb12Be5uPOOWFGlN1oL/WB+u5+moTtY3hq
 nH1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rYUZ7aFTUc7Dj3t2QXHxzdrPX8QQbQ/aVM+rvM3My9nemPpnZMqwaR/Yu955id+yivFtW++w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv201ed7UUxGPgwLHMgZZRlEv78GEjlCbuNW3cW1buiGeHZGN7
 SaWD30TaXALjg9DyG/LPGjyCUqMV9tMnFSe2HaxLCvirXZXGFPc50zBuGU58IYDpKIxsXIt7DUd
 dyy66Q2cz+9BPXl8/W6fLgMedoe5gJmODYUIoe145G/BXAwDIEZ5+2T15
X-Gm-Gg: AeBDiev5Cwa8ONwqzHA6J3F6LnRanVL6pDmnV+bJTg7nfH0tM3vqTbURpnxqf7jHwc0
 dBlnwPz3q134lppNFTqBgBTWMMJ2/pPSuoXzrHYSiOXFuB9s3KS9FKKo9dGGoD9vLEs/zqNmwCQ
 enceyhu4UHKcc9lmUV8ncBcKTjrqO497KgztB4bZLyQiUT4ABz0bA/aLHyO/6oOq9vfbnLLA+lj
 g1HIFmVMOy7g0UBnBILV0KPkJQvFEtsqVNdvO6UjDkygkwnwP8cGKsu2LKVwiLi9CpDYfiHvDy3
 ptqKY45UoPZYveh993eP672kaVzE+aWEPSlEL0PoqIjWbw/ub5VCq/09YkW2FsK4Ovhr+tGv1Gi
 BwSSQMeyZTm7uAhpFmuVSIH5vgWPPhKDeSRz0iePbVCe/Ay0AZqH2F3jSbPYo7xFBoHRwFCNZDm
 qLtih4hXB3sYP1CWjEWWY7j1u6TQMXb7d38gMRadmOsJIncV+b0uHK7PSs3qN+
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5f9dbcd42mr56794895ad.3.1776494147996; 
 Fri, 17 Apr 2026 23:35:47 -0700 (PDT)
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id
 d9443c01a7336-2b5f9dbcd42mr56794635ad.3.1776494147502; 
 Fri, 17 Apr 2026 23:35:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20d33sm40542345ad.63.2026.04.17.23.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:35:47 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 12:05:21 +0530
Subject: [PATCH v4 3/5] arm: mach-snapdragon: Skip USB fixup for
 qcom,sc7280-dwc3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-kodiak_ss-v4-3-d381670c9d78@oss.qualcomm.com>
References: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
In-Reply-To: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776494121; l=4488;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=CVMBaaJG0GX0mjp2NpKxksSligi2n/nO3L4hb/akzWU=;
 b=Adkdy7CAH6JpjfcLn0vnnMsweRI9T5c8OF2ykDXUoC89P8h3ioUIw3p89rICEdjWPmMpq9Xh/
 CCoh4DX84piBrc3DPoHtQAaJQNEn4k8x9UTBrI7HGFRTArQ5DOCB28c
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e32645 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-p8zK5Xjo0VIsRuXoG0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA1OSBTYWx0ZWRfX6VvjBhD3mEFV
 oKJ4Kh+DSjFLAd5/FuDBgNmVp8pAHjJJU85ye+/HQ/oU6o2Z7YIFGxVA0TDfboYGe9PfF7qGYc9
 xH26a02nZx5p6Cn1ewQeUTzMU3s4of7IYMdVDOqU83ulTQ2OMwKkdUUZt/NgeIEpIoZlkSuP7OF
 uYNTounwH6ODw07a/F/SSikZ1J5SQWqwI4nKwIw8sXC11zIeOhgOKgzgGD33rGrpjGMPUl+Kasx
 7PR7JDDZO2PBTuN3BM4ccRtxCLl/KlEEMhCS/IMnRTfX0dWUo+UcFKcfFohFBux2XdIdc/VhZqJ
 f/obKdiwA2y3Az5qn8N2voAaDUZbrfQz0qhGhZnfCjZEn0w5rHI4BTV7BHbpH4GSNbNz010FQqH
 3VsCwnfKrp2jBIwSBghKN59Y0AhO0qmRE6Gz8anTcpxpAjZg3J/lbeWSsFy2Sg0hJ8rWIj5YXgh
 UJqa9GfwuOpHUs3/ogA==
X-Proofpoint-GUID: aUyQns4toQNlduUq-4aNPJxcTwijMhxj
X-Proofpoint-ORIG-GUID: aUyQns4toQNlduUq-4aNPJxcTwijMhxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180059
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

Currently we unconditionally limit USB to high-speed on all Qualcomm
platforms since most lack super-speed PHY drivers. The sc7280
platform has a working super-speed PHY driver in U-Boot and should
not have this restriction applied.

Add a static check for the "qcom,sc7280-dwc3" compatible string at
the start of fixup_qcom_dwc3() to skip the USB high-speed fixup for
sc7280. Add a log_warning() when the fixup is applied so developers
on other platforms with working super-speed USB know to add their
compatible to the skip list.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Instead of automatically detect if SSPHY driver is
  available at runtime (which adds computational overhead), instead
  just skip HS fixup based on usb node compatible string.
---
 arch/arm/mach-snapdragon/of_fixup.c | 54 +++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 5b6076ea8e5..6ce6f1061e9 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -27,11 +27,6 @@
 #include <stdlib.h>
 #include <time.h>
 
-/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
- * USB controllers. Rather than requiring source level DT changes, we fix up
- * DT here. This improves compatibility with upstream DT and simplifies the
- * porting process for new devices.
- */
 static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np, bool flat)
 {
 	struct device_node *dwc3;
@@ -39,7 +34,7 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 	const __be32 *phandles;
 	const char *second_phy_name;
 
-	debug("Fixing up %s\n", glue_np->name);
+	debug("Checking USB configuration for %s\n", glue_np->name);
 
 	/* New DT flattens the glue and controller into a single node. */
 	if (flat) {
@@ -54,30 +49,56 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 		}
 	}
 
-	/* Tell the glue driver to configure the wrapper for high-speed only operation */
-	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
-	if (ret) {
-		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
-		return ret;
-	}
-
 	phandles = of_get_property(dwc3, "phys", &len);
 	len /= sizeof(*phandles);
 	if (len == 1) {
 		log_debug("Only one phy, not a superspeed controller\n");
-		return 0;
+		goto apply_fixup;
 	}
 
-	/* Figure out if the superspeed phy is present and if so then which phy is it? */
+	/* Figure out if the superspeed phy is present */
 	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
 	if (ret == -ENODATA) {
 		log_debug("Only one phy, not a super-speed controller\n");
-		return 0;
+		goto apply_fixup;
 	} else if (ret) {
 		log_err("Failed to read second phy name: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * Skip the fixup for platforms with proper super-speed USB support
+	 * in U-Boot. Add the DWC3 glue compatible string to this list when
+	 * super-speed USB works on a new platform.
+	 */
+	static const char * const ss_capable[] = {
+		"qcom,sc7280-dwc3",
+		NULL
+	};
+	for (int i = 0; ss_capable[i]; i++) {
+		if (of_device_is_compatible(glue_np, ss_capable[i], NULL, NULL)) {
+			debug("Skipping USB fixup for %s\n", glue_np->name);
+			return 0;
+		}
+	}
+
+apply_fixup:
+	log_warning("Applying USB high-speed fixup to %s. If super-speed USB works on this platform, add the compatible to the skip list in %s\n",
+		    glue_np->name, __FILE__);
+
+	/* Tell the glue driver to configure the wrapper for high-speed only operation */
+	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
+	if (ret) {
+		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Single-PHY controllers only need qcom,select-utmi-as-pipe-clk.
+	 */
+	if (len == 1)
+		return 0;
+
 	/*
 	 * Determine which phy is the superspeed phy by checking the name of the second phy
 	 * since it is typically the superspeed one.
@@ -104,7 +125,6 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
 		return ret;
 	}
-
 	return 0;
 }
 

-- 
2.34.1

