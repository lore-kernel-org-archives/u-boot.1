Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD59DE6749B
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766FF83F64;
	Mon, 22 Dec 2025 12:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gjfFczPm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgJaFGeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E7183C28; Mon, 22 Dec 2025 12:49:17 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770BB83F63
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM8Bnrk080674
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0R2AKUkzpyd
 y3jiv8jGiNRW+CG3CNAa7pdYvt5XCpSs=; b=gjfFczPmSX6ku4VAbR7fBcsjd8j
 p7aFwqVz63KkdFb/m8NZfSIOLcs4ivkgei9DTL+xIDTH4SIg1B0EWOKyyeGfsrXw
 BEtMQs/ELDzw7dgHC9SDjw2P6mAVWoIbv+x4GTjC0LPezLGBzlSvxg1382AX09RS
 +9JTWmoYrqvlBlQ/a3COUGcNva4wb86pRR9NRPunBDIuSM9MJ2vdTtJ8rsYo2voY
 WZqomHTMgpAL6Lke7RuqsHa8bFLOmdTBBJxOYe32uE8S2AmBj9mzqzer0tysdPNJ
 aLzW/biNeEvtc0N2dgxyX/OdHNXwPJiAz73CqzvRhg6GeG6PXpHY5y9fIfg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mracv44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0fe4ade9eso40968685ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404153; x=1767008953; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0R2AKUkzpydy3jiv8jGiNRW+CG3CNAa7pdYvt5XCpSs=;
 b=CgJaFGeS/YAdKMB3tHuz8zjrA3ozQMwgNNEXaeAmc8B+4T9cNTT+ldo8AOQtPFugtv
 tjzbqgKPWhHHk4MM39zNOXny9vzgp5Bvte7WEJJuzlzXRl68MlJ5GXvDtSm/hfpUKlGy
 678ZvJMkihi+4lnayxnXQ8kGwUG5nODy7ytEwRrzmTAyNRoBZyExZWgacffO1WjTbBF9
 oza67uXL9LXcsyTXvLrdXHMJgIwhCoYTcE8O2YW2P21SBx5dpVUJJA/2LceYAojHiiaC
 JXwRPsnNAAUXsAnmx/d6+GCO7Ah1akDUSg0SLhoPzHPPUsn7ngmy1i3UFugoXydsoWH7
 g/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404153; x=1767008953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0R2AKUkzpydy3jiv8jGiNRW+CG3CNAa7pdYvt5XCpSs=;
 b=w9Cxxmw8Q3MSwTw6krm8zVylvubXsMKX/uaMHlIF847bCWmtfG2AxHxTYMxr19XXaa
 WwfKxCd8rsVOPxWPkAwH0GiNNUuKoXbmbNkWqelgJaCSYZu12mC6ql1RLsZy61w1h4Hq
 TOztAerhehqS/5VCsYAwx0zdTdUcsHhFEAmJ+cWLH1riIxH97pEIk3gP8PIwqzAaWELp
 Qe+zQy4LCEAe3JZ4gXXPSho2gk8ffnyGCQJhu81FOrVg36wZ5VVWHL9MmMj1URx7MGG9
 J3txbhvumDA0AwZ16w2pxRN5y5mtBrcZz1lI3LJYUR9l2q9NITkyPU0PBmoITTri39x3
 Loww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmSg/3Wl7QfPwi0XQ1O3Y2xTnfZrFPTPInuPiAqVA6Tfk3Jf4j3MNTEqov9MI9H3ehZPGWijc=@lists.denx.de
X-Gm-Message-State: AOJu0YwhCR5BupbuXQte2pLIVJC9s/1a0M1KZmQ1PeZOXlwll2WmJCau
 LIVy4/r+QxWuhytVEtG1Lkzom/tYYgwRM1Gm2nKB4p6VKhIu/P3gdGWwLKdgVWCKk5XX/um5OIv
 MYfjnLAgOVzXk4yhm6tA86tFR5trlDprD511GeN7snR+eP0i/9XCTH/9x
X-Gm-Gg: AY/fxX5iNJbexjqaZf7AY34KtpPVArhcKh5UUvIAOLIUuErbHXOZPqkIgf9ze1frZcx
 PeKHxUeCSk4ySYKaeT318kCQZVWmCTe5MmkIbo9ghfqhuA/3b4OVXm8Pp5+Y8EWbRrDJccKGM86
 FVBLxyHOUnrgTVUuKU8ULWOaRrn1sKkbo6kclFnBKTHWptfXqVpfu1Drt9KYc/XcMwGMpuLOx9t
 OhJDf1Oze1+h2Fi5KUY2bdBI+ypAdg/52xcKHzfwNQvX1OgFBL8X17vgIPXfx7aRo4oeQ9sPZcV
 v6fPWyN/vssnqkH11qYD5m/naQV0tHWP0vTPLFl9KVWJ0Eg7m9uRuammcvSbxY9nKc+RoJxqMfU
 YzLCD75p97QahV12E2Erk8H9MUAjCQGfB2daFMmuXzpQCMegrZQFxAF4CQVbnJd9EBt5zg0jEMm
 MOBeJHY2qiHXJ4V8R37k1y5V8gbNt4
X-Received: by 2002:a17:903:15ce:b0:2a0:dabc:1388 with SMTP id
 d9443c01a7336-2a2f28367d8mr96576185ad.28.1766404152529; 
 Mon, 22 Dec 2025 03:49:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0qpX4Rhj3MsIhurzBjOP03WtZXm/2eLmi+47m9OEBVRurEDwmEWzwtnYN106Gu92DP5Hq1g==
X-Received: by 2002:a17:903:15ce:b0:2a0:dabc:1388 with SMTP id
 d9443c01a7336-2a2f28367d8mr96575855ad.28.1766404152038; 
 Mon, 22 Dec 2025 03:49:12 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm94875935ad.78.2025.12.22.03.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:49:11 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v7 3/4] mach-snapdragon: fixup power-domains
Date: Mon, 22 Dec 2025 17:18:22 +0530
Message-Id: <20251222114823.2146775-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pdd-mbPMBA6HWGCF3rFIcgH2qfYrJ5Pv
X-Proofpoint-GUID: Pdd-mbPMBA6HWGCF3rFIcgH2qfYrJ5Pv
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=69493039 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YokXgKr-R4hWQjJdTE8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX6sP3RGKSqV5b
 2U9H67MhMwBE27XukeOU64VxvNpTNiEpBpvRg4YO4WtFKy46pwBUud778P354WIXCiei4nom+mh
 EpPJKqRkCkVp/DuRwpl7/S3HJ9srLYt8bmXrMCWgClN1hh/e2YyHc799bWDUqsJznGGk2U983Z9
 7SghddbkHyV6hSQxbrs/XM7M759wrcCxAebyRorHXxgTWlKI2M93Z888ZrTymMn3L/22oQAp3u3
 yyRqxrGVN/W/V7PQNnKzGbpl9ILywa8oR/YCkerMx845tmy2oW2ot6iuQltO8sK8hjifLGcqxH8
 W9eGuWj2OvEqYv5Lgx4gf9DlUE79o2gC3uB4H93oVPdvL6Vj7RJp+ukx6DVAUTDmc2o6nuFqhCh
 yNeQM1cRw6ttPnqV0HZi6ZgVj16Do+ttlhiYVtjUUMUa6ImhZVz//H5H4PFaLhPp6oOtQ2hhRcq
 tvm+pIQeQuXER27fEyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220106
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
device tree due to the absence of driver support. Since RPMH
power domain driver is added now, the fixups are removed.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v7:
- No changes to this patch in v7

v6:
- No changes to this patch in v6

v5:
- No changes to this patch in v5

v4:
- Reverted the inclusion of qcom-rpmpd.h header in pervious versions.

v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done

v2:
- Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
---
 arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..93c16821e54 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node *root)
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
@@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 	struct device_node *root = event->data.of_live_built.root;
 
 	time_call(fixup_usb_nodes, root);
-	time_call(fixup_power_domains, root);
 
 	return 0;
 }
-- 
2.34.1

