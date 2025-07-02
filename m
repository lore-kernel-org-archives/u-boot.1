Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3CC77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 17:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2C482ADA;
	Wed,  2 Jul 2025 19:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jE9PrFib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A61E82F6A; Wed,  2 Jul 2025 19:14:10 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CD582F08
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562E5WLa001269
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 17:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g18wdyz5I3H
 Qf85daMwBITcDei/+UXXK4eVCNbAuqIs=; b=jE9PrFibNRwhS5qKWuz9oxFVdeH
 rtPrKSDLHVrqUxvrm9FwWrW8OdMSYWS1FLxtOCnhgf27X0TuhDYbKvmR9Ck0XGme
 Fn0Ay3Httfq0P3NVo2VmmreUfrHNZNXWdTqNNHh/qGWz2vQKLrEgiJRa1I5uJsdn
 TZxs1U9j0+Ji6naSHxZR+itKIwqtUg18V1QaAL7nKvMWOGwlLvkHBYf3Iiw4+XD5
 IOE/Ja6orhtHz/h+U3fO9qXUHT//bFu1onmQHhFMoWPfYhZp5NeukcgsNWgRjkNj
 I6giKXNSL8VEpZKaXbtvukjXoYHl4KWrcHRmEWdlGy7FtgapjaLd7gA2cjw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9neta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:14:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-74943a7cd9aso7093973b3a.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476439; x=1752081239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g18wdyz5I3HQf85daMwBITcDei/+UXXK4eVCNbAuqIs=;
 b=YYWm8h7w3tOgECL1yUDi++gpc1G1wMkki3PYHywfu2+oXfUPXMGh/RwKL6udmS+mxa
 2KSfg/hMdp0G5owjJxafQxgKHRm1kMXyGRHXp52oS5X3VBoWT6qjT7YQrZkGHFV7sHV4
 NktzKuOv+ua/7/PgMdT26Yg1hDGo21Psn/ecaH9ht6Mpbv0ONQT1g79DAXlfK4O1+T0/
 6YVO/12RX/Vpyz1PTkUq3vVubGLy5EsrIxEsTLXDFnhnX4mYBzxPBsHMgqPp7Yzb6FLZ
 grUTKQh6YVqoPynUyLIVD3lTgzP0bWvyOHIL3RI9sC0TKr2WgR0/YunRociQ3uuLLK5N
 XPFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa/X/JfyMb2s092j5Jl7ebdqt7CIbJPG3rrQ8sx1bLguq/+3H08iiPTCgDzeIy1vFAIftSt0s=@lists.denx.de
X-Gm-Message-State: AOJu0YxHzVwZKjh7fFFUNLItUFdUe8NYUrXusTU+tFrtw00/jbE8yTof
 UZLn9bsEoy6PwH4Z5sf8XNjJL7wEezHO9clJedgB+ufR8AX82TSekD6PTtu7IUnVdPHv318GHO4
 3SJdOuYk2OiQex1tJM0Eb05UzJ5IJhGHEYgBPyydyF6s0UB5qbekKdZis
X-Gm-Gg: ASbGncuD/z2s7+V8e/ib+f7fR5G1ddWdtj0li1drpT2q00mPN8ooW3i5NCuYdOqwBKZ
 26yEDi8jBnohrWKERIuLiISyMkLNscRqdIGwsPYkyyEBdnPKIKFVxtbbVGR754AW763Bel9H+39
 WjxY3bQBVDo7Drm74BmPjiAUgsdtuSIf4fxQi6kYqSnVrDFWdGOHxd2tnzE6umQ4Q2qESOf+8lt
 T3Hjo+5/RYxuuOMXgU9x/kCVYgLyGMX3+d5sA3YL/8YWWYlJ3DfM+763Ng+7o868Jfbqjb2EErx
 bOR7rY8knUg5LnWJboOAPxZyBAYZP/cexnUIUAnNgOp8mpR8lm5MDmZ4qUv3kFvSetoGOZmEjMg
 EztpoPpO/+fQeorwDreBXCi9jfRcILDy3Rk6xioWrEw==
X-Received: by 2002:a05:6a00:3e11:b0:746:3200:5f8 with SMTP id
 d2e1a72fcca58-74b51512bb5mr4915626b3a.22.1751476438902; 
 Wed, 02 Jul 2025 10:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUkhTjg1xzVPH5WtzamFdd6lRltUs9HH0w0Hxm3ggjfnQDeXKqSL/fWK0C9iilfxbddqlSw==
X-Received: by 2002:a05:6a00:3e11:b0:746:3200:5f8 with SMTP id
 d2e1a72fcca58-74b51512bb5mr4915580b3a.22.1751476438452; 
 Wed, 02 Jul 2025 10:13:58 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5837sm15144873b3a.116.2025.07.02.10.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:58 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 3/4] mach-snapdragon: fixup power-domains
Date: Wed,  2 Jul 2025 22:43:34 +0530
Message-Id: <20250702171335.1811080-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
References: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=686568d8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wbMr1Ebaa0m4whefL-8A:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: PcQqaiCBfv7MOJn4Xj5XD8KFRDQROs2a
X-Proofpoint-GUID: PcQqaiCBfv7MOJn4Xj5XD8KFRDQROs2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfX6Uk4L37no1TW
 /IJ/TMePjsk8kJNKIegSMeM8nmmGTvk1sMy+jDpJQFuAflQ5dbzgncx1jdomORwwUD77T4ZNjbp
 8sUh7Ch0BDadfD18GQOw0YWAOnj3SU9k/ScLreITqU8VrWPrZWyVudXvDKS3xSNElLRZuiphcF9
 ZV9Dz/dJ3bRNYiWnufq5+CFfQ+4otRT+x0H73MUWvOuM7bRFxJ9/XApyplCJUD2gzCYHf/2IQMM
 xyrUn5Jkae8/fRqnZCH2rgLrP+1s+7sSsRCARAZ/wpw+3SJjhoRYA9EoaKbOLGyQw1WhkW3Cx78
 3cFdEWjBaoTa946Wqso0b3d6zUatVO2iDrcC0SOf/AZwnwHUuUeu5skH6XBHAQRVICBM5wq1ja8
 VesH6WKqGSnnSbsLhjNq+6oepsmUykYhnCs8NykmQcoFJsBjlHXPpn/o+NUNaK38r7hS28A/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020141
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
v2:
- Power domain fixups have been removed since they are now managed by qcom-rpmhpd driver
---
 arch/arm/mach-snapdragon/Kconfig    |  7 +++++++
 arch/arm/mach-snapdragon/of_fixup.c | 32 +----------------------------
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..28e564889bc 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -1,5 +1,12 @@
 if ARCH_SNAPDRAGON
 
+config OF_LIVE_SA8775P
+	bool "Enable OF LIVE SA8775P"
+	select OF_LIVE
+	help
+	  Say Y here to enable support for OF LIVE fixups
+	  on the Snapdragon SA8775 SoC.
+
 config SYS_SOC
 	default "snapdragon"
 
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

