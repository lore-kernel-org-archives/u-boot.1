Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CD5C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 18:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8360C82F30;
	Wed,  2 Jul 2025 20:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eA8RKJL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB4A81FEE; Wed,  2 Jul 2025 20:02:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A6F82F30
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 20:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BJA2S010779
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 18:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=49jXLDdKpAh
 xF8MXrEX9h7rNj+kvf1FkgUJcrW2Dvo0=; b=eA8RKJL5FjjA8QDk6QiNzVtWfGo
 z1wzfsx9iYAPwjy2Aw9t4/VlAAQMHlJgP54pRWK5Wm4I5PCmq3oqpgRID58l2OPc
 Hf8rUro6ZTiTpE6twd2IURelg+C0/RPEYGrLRkteVbrJtPnpZQHMvi1MrNsRQf/W
 Pi43X5vyg6s5phnTu6iApcd1NBJItpKj9Y6fp5qhVTn8r+RqU3XUDWkJKek7/fYb
 vJuGKxLlXUjBRqVC/dDZKSaseaQt61aRHCKFvhZLhYzRhkOajn/ioXLCMnID/Bjh
 2731oqxxiX8YAAaaegUujF6559XUYS6Ri5nx4iMA0UsyfubkxRdX8Sc/B2w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mw30amgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 18:01:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2349fe994a9so36530505ad.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 11:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751479317; x=1752084117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49jXLDdKpAhxF8MXrEX9h7rNj+kvf1FkgUJcrW2Dvo0=;
 b=xQ0JzEUjJ28ggyolB4D6dcRwmkNwrtFsDk3Fi0QtoT8VOmyt5jko6VhzjRgF9Cw3gB
 5fBNKmhMR2r3pIdrEzt7bbwmosA0EyWqBiVQjC0grdciFQdozQdhfLfi94eMeoGTak+Y
 /zyuyjv2g/NYFBac0zvA1D5HnKtzQoFTjQ6cADHWX/HH21YeaGaJrx5DGKYpNIuCxax2
 vyiDiFEBbz0kUO49SV13LKwIE+46EK2maDNhl1pmklk5qtd/O1GbOqFFy5wslm7nxT2/
 JG6LZq+gjUgA6dDi8UZS25/xWs06y8nWSKUhlcGgfjN7LBLZ40KRl8jqwHFXvdrrlbBC
 RUMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIxm2eHKq2l1dtJMl7YG69VwU4kcMnYSKcH+CoEU6LQ4J7cynz3EHZhmFHTwjQFZ+ypEjAMaE=@lists.denx.de
X-Gm-Message-State: AOJu0YyrDDhRhoSRHZ/3FDsprUZad8zKyYuf4SHRDS7fgYDRSqQe0JZY
 U+q/1MaRR8ceO6cuPkQ6h5pq76g8HQADIcWh5H5ZJPbrqd42wuuH0t3qVssJ+H8ln1ITLVay3Ew
 tfkp0jgLCGEt4Nc5KmQHy41gFxfHX4QA22g/vLLvCySzmgEXJNtBeuT3I
X-Gm-Gg: ASbGncv6sw5Q76jkSB+3mqfjpAYWSpVO+GniQKTFyZcQGBIdFd3rbOQMWPw62VYvKg8
 744inrToHvHX706W8C+j/Kh97rfoNeklE0fDxNU+wdtH32kDsoOI7aaVkVJY+EKIhQKzBy8OztO
 ZJdGmjtWPWt1Djjy+iHlQ9xd6AZWirWudR4/QBt255Myyyjbui4ZLIKDkwlUs4TOGufPoyRmqih
 gAnD5nBQHNeAWOELRbNKmh/l9HzzkIlAOveONsCmlp455vgWwRtHw7//PVNJ9Loth8yBiH0roAG
 hLHGKp+BuhNvV/53/b9naxtvVfCniwpo/nfYp4HbNFGmhuPsRl3EHczVUC0LgIfn5S5ULGNlQKy
 Gogz4tjMIU+Xu3u2J0g2pgWqkHKXSMvmB2k9sBjWyfw==
X-Received: by 2002:a17:903:2b04:b0:234:8c52:1f9b with SMTP id
 d9443c01a7336-23c6e5706b7mr63805595ad.43.1751479316674; 
 Wed, 02 Jul 2025 11:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMC7Fr2xfNPb5s5Zvn1xp9PXHGPQLR7pGcP+OfA6PA4MX/eg2i3Q8fxEyEngVg/lfserc7Tw==
X-Received: by 2002:a17:903:2b04:b0:234:8c52:1f9b with SMTP id
 d9443c01a7336-23c6e5706b7mr63805065ad.43.1751479316207; 
 Wed, 02 Jul 2025 11:01:56 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e39besm143315345ad.13.2025.07.02.11.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 11:01:55 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 3/4] mach-snapdragon: fixup power-domains
Date: Wed,  2 Jul 2025 23:31:32 +0530
Message-Id: <20250702180133.1889709-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CY4I5Krl c=1 sm=1 tr=0 ts=68657415 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wbMr1Ebaa0m4whefL-8A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 2ElkyqVd3PaRv6cAGxClQf4X9NDyTx14
X-Proofpoint-GUID: 2ElkyqVd3PaRv6cAGxClQf4X9NDyTx14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0OSBTYWx0ZWRfX/7e6uxukwMAL
 41AsxxQVBpQHTiHPTzTEI74suBrEsCgaTXD/ZdXgdakdlR3r3m4YGU+hC0MEKFYkGP+GyOkecG8
 0AMk3jWuiZ0jhQ/q+t/vRXvmZ/BUD/japthiO4GCRxfWcLz8FOS8SP4+Y5qqSXd0IgU0jVGB0iG
 LK5Gh+96uZjYzuncyR9WtcQpLR5pzYZspJIDme7hcf/tfN0qUp5D3KZ+mgrAAAT2OeP9n8+Ldv5
 HNijnlc9H/OZjIhOjPmvFTT0SjAaK0pmrcp+vjW1vk1naxBOu5oMv2EIWyBEWfR0vf144lDcquc
 RxIsF6BjcTNFxDvV/BFCVgzL0ocouSCiccxwA7VCf7KOjpPRmBfq0A+3n+8TLZuBNGoVzmvam7v
 twi9byKRTYueBh1pHrs/zL8xtPdIzca07cvaOdkq7Ny67UCfWLcbgnVESAZprk0a0HZV2jds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020149
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

RPMH power domain properties were initially removed from the
device tree due to the absence of driver support. Support for
SA8775P_MMCX and SA8775P_MMCX_AO has now been added in the RPMH
Power Domain Driver for the SA8775P platform.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done

v2:
- Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
---
 arch/arm/mach-snapdragon/of_fixup.c | 32 +----------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index b398c6b7b9f..e36c541ac42 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -19,6 +19,7 @@
 #define pr_fmt(fmt) "of_fixup: " fmt
 
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <event.h>
@@ -129,36 +130,6 @@ static void fixup_usb_nodes(struct device_node *root)
 	}
 }
 
-/* Remove all references to the rpmhpd device */
-static void fixup_power_domains(struct device_node *root)
-{
-	struct device_node *pd = NULL, *np = NULL;
-	struct property *prop;
-	const __be32 *val;
-
-	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
-	for_each_of_allnodes_from(root, pd) {
-		if (pd->name && !strcmp("power-controller", pd->name))
-			break;
-	}
-
-	/* Sanity check that this is indeed a power domain controller */
-	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
-		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
-		return;
-	}
-
-	/* Remove all references to the power domain controller */
-	for_each_of_allnodes_from(root, np) {
-		if (!(prop = of_find_property(np, "power-domains", NULL)))
-			continue;
-
-		val = prop->value;
-		if (val[0] == cpu_to_fdt32(pd->phandle))
-			of_remove_property(np, prop);
-	}
-}
-
 #define time_call(func, ...) \
 	do { \
 		u64 start = timer_get_us(); \
@@ -171,7 +142,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 	struct device_node *root = event->data.of_live_built.root;
 
 	time_call(fixup_usb_nodes, root);
-	time_call(fixup_power_domains, root);
 
 	return 0;
 }
-- 
2.34.1

