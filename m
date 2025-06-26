Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FF0C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1551682DA1;
	Thu, 26 Jun 2025 13:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zlqgq3uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888D1801BE; Thu, 26 Jun 2025 13:25:24 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FA882D83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9UrYM020258
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TIi+3NM7R61
 kzabIwZjeLmmTffb8AGbtzJWEFJ0LiAk=; b=Zlqgq3uhA5tMYc105fkNaB+b4AA
 +eg9wfvIOltXTOzfpDMGXbk02c72mEm2Is1IRGQ/R09Gk1sssrhn0+itlxBRY7sz
 bDfs8jJ9axIsUtWnfpjfDeNIlXaWVDj/qdaopanWG/vGeKrtVoZ0pw5Vea/ZrmYH
 /pwwUvxPUwnfWD+D7EN0Jjr1FO0C195anvjWNF1PMI52UAO3FVRLflnOpknQiPwU
 dLfczC4yjCTvdJGnvY4jDcWelLNspX1Pd9cKxLsRmK+wGUQzMclW/hWId23qHwZs
 ialCkp4Afu5cxTMxwBAjTMWKzxLhg60kQEXH5ELftdp80ne5nv6LDsUq55w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7tdd1ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23507382e64so8648145ad.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937113; x=1751541913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIi+3NM7R61kzabIwZjeLmmTffb8AGbtzJWEFJ0LiAk=;
 b=NxUAbwAhR1+SKxyIBxGkiVBbm4C0F7a8KdoA7QWuiskYDADXc2yEaoQj2qZEi7Sip+
 mgVsm1Blhogf+C7DU/kvVBJoUwVH+PRYInqKTjr1rAsI2CTZKggdY91qCZTJ0LU9V0Lt
 v9aIhRAB0ZyfvMnYbPPmZ3FLiWizvsM1BbJtkh/H0wYFu8zsKrMWKmo6r0591daFKAJg
 7vzI+4tcxIlYgvA8BFY7RxC9dOZhWVP+JBEWi/wssneLRdnUq/VHyViAbJScXUiYgSS7
 g9H7VfdqSfDtTEyu8ALMzzDmIUSczEV3vFlz9m04mn8GH0+88eJ5UOvPZea3AHQ/0F5n
 +BjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjTJ+ymiFX4IDzxkr7dMY8xsnTxZ1vXYYpBUoTMSd4P5UQLwFsDrwkEQz1wVrqRINDcNYVilM=@lists.denx.de
X-Gm-Message-State: AOJu0YyK0TJql10meV37efaKtr+NxegznaOppP7aTYk9xbI88ejznD3E
 vH27Y1tjGsv0x5Vc4Tt8MuPXC20z8+zbd7XEn9hAnCKz5FCaHY5kr8tzRnZEm/WgXGdinTHsYll
 bzPZXQHwNJp/rEKyBs6QaWFTdfkjrbvm010qsr9trgANwrJuVxjRYOg5o
X-Gm-Gg: ASbGncvXJZodpUkngQ9jmwc3fzT+leZjxgu2e2S9Lp10iNwCrWR3QaN45rILdbyLjQT
 SojNq8hskCwMmBPT+1c/97O8Sxx6sqgGDEf9vXEpDstsgY4uIIjXYjSNLmCMaEaK639aXYruXHB
 ppKWseKcZG59dSJPfFvWop2oWE3AiiWS2TJHEORnlAEDO0S/Z9sfZs3duAHzmWPyhWVBszTaATv
 l9AD2yOsBU7sy+SiWRdiUWHbpDK8bji+NSMYVr+huJnf5MAR/3vhbP/bfLJSnGIFVewwJIhSOtg
 PzgxZPH4dv40T608IdZrAn7AUPd5VoZNhGw9h4WujWl0EN1ZEPkh2yAf6aTQYwwFVUPvzC5/QTc
 E4fRnzqhDYA65WHzhPGyT/iJrd5EKiL1daYWitnUL1g==
X-Received: by 2002:a17:903:8cd:b0:236:6f43:7047 with SMTP id
 d9443c01a7336-23823f87ed4mr99217775ad.9.1750937113035; 
 Thu, 26 Jun 2025 04:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrpg9hn0CUX7tdxfjKXIlIXzd8+6neN3owWxFZ74fsDYwfS2/uIwQJsRzJ6lsulHAO/FbRHg==
X-Received: by 2002:a17:903:8cd:b0:236:6f43:7047 with SMTP id
 d9443c01a7336-23823f87ed4mr99217475ad.9.1750937112632; 
 Thu, 26 Jun 2025 04:25:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867b438sm154528185ad.176.2025.06.26.04.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 04:25:12 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/4] mach-snapdragon: fixup power-domains
Date: Thu, 26 Jun 2025 16:54:40 +0530
Message-Id: <20250626112441.143064-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685d2e20 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=pg4SMgD1MiDI7PK-kdgA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5NiBTYWx0ZWRfX2SOuqniTbebt
 bTGNuy3zQPfdbhYxnfPSb2ewpegpNLplxK836wyFZzLcKCvTO1bvgj5WuIh7eQs8wRHl+JZEWKY
 RXNgx98SInxUZPCAXvuFnNkxLnYm0Om9appyXZcF3HYmPh25WN8kqYhLE9xGEdboXQaHT2gh8WA
 znuaGlWf1OUxPmTa42IsDf3ANLY+DAwkCSfhWPFMDdXsa36g4JK1rWQWSY6qGjE11qxV5HPXUuB
 Cbhl8MRnrNYZpN23+Tt7h9RnasT6lMPDiLc3Py92gjQCr8ibXHuaE0qE1zD/Al8wOSt7GKaWjTT
 up0ITv+OEeSZDi0Jyhh5AJhg1NslgBPVd0NMRN+WKWwuc+npXoDoHt/PKrUWer0qlW6cmDTi5ze
 R746M7pqaOOc/WY8IQGHrLpWpaxMpaD3ztlLIUYscUK/tx++VEU1/w1lQeZIS30Fl7nqCwqO
X-Proofpoint-GUID: dg590fjpbuRqV_Y2jelAql7YaOlzEiQQ
X-Proofpoint-ORIG-GUID: dg590fjpbuRqV_Y2jelAql7YaOlzEiQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260096
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

Earlier, all of the RPMH power domain properties were initially
removed from the device tree due to the absence of driver support.
Since support for SA8775P_MMCX and SA8775P_MMCX_AO has now been
added in the RPMH Power Domain Driver for the SA8775P platform,
remove only SA8775P_CX entries.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig    | 7 +++++++
 arch/arm/mach-snapdragon/of_fixup.c | 6 ++++++
 2 files changed, 13 insertions(+)

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
index b398c6b7b9f..456261eeae2 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -19,6 +19,7 @@
 #define pr_fmt(fmt) "of_fixup: " fmt
 
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <event.h>
@@ -155,6 +156,11 @@ static void fixup_power_domains(struct device_node *root)
 
 		val = prop->value;
 		if (val[0] == cpu_to_fdt32(pd->phandle))
+			/* Check if the rpmh power domain is SA8775P_CX and remove it */
+			if (IS_ENABLED(CONFIG_OF_LIVE_SA8775P) &&
+			    (val[1] != cpu_to_fdt32(SA8775P_CX))
+					continue;
+
 			of_remove_property(np, prop);
 	}
 }
-- 
2.34.1

