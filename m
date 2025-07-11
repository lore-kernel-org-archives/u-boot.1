Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039BEC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A47882998;
	Fri, 11 Jul 2025 16:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqmnDjTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD41B82C7F; Fri, 11 Jul 2025 16:39:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B113800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAbiHa004135
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0y0x3rpCSmC
 H4eYcOWwv74dRYOa1TTAXT64CLFLDEbc=; b=NqmnDjTWbsDyOHj/q8vq4FxJuZf
 ye8n50j1sMc1cE07KRfwzbWBB8LMAUOSnDUw2sdW4yGWJDrSR4whT9TlA/agnO6p
 cQJZ3uTWbInyPecThjhDwLvJc23fuJ9XI95ucvzJUb/O5RDrsCt0zvWrTYREQOMs
 x/FW8LJaV1CB6xjFGGp2aNMp01OFBkQQVDk9Iqvuc031rW1m0HlSl3hz4S7PTqb8
 aPwpjHD9AZ5sReBchRlYNuGW7BdhiTGTdwm1hcu19Jn4q4dnUXp3HgMrWJEBgZAa
 SFhhk6CuK46Lqy3F7YvRbMEZZqB4BiKGWVn/qx8rytgj2RAbipEC1f8aDaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp0yvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e3f93687so32907005ad.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244755; x=1752849555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0y0x3rpCSmCH4eYcOWwv74dRYOa1TTAXT64CLFLDEbc=;
 b=OS2b6dUMy7bY8fPW6UnlNUTpdXlNIbL6uWa6L54ZTa2vY0qIkpE+J5Vw7XHbPJIzMH
 bfM6Oqv8eDXdX0xoo7XXtWnd6q4kP1rDfKGvFDNPQ4hfMI9F1xma7sBgZhquiTSHdx+T
 mZ188LqTSpyn3wOxfoJmtFB+ma8TBdsMhlOKiu/wmWEZJ6+TYh2rmUn1mJ5eG7eczk5X
 ZrAmF9miNpbrrwYhzH8IIsDoLhMWFczVnuX26wWiXW1WbAOYsqQXp29ZoZY2xxBOr03g
 8m8taSykWJvSxfdjnaGDJXZUJFY+rMIrLT6p/xeZW/42X8gJ4c8e0B22Ew5Q/EUUR8ns
 F9vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YfHhEJUo4R69iGrfIFqcvns2SG7o63jjdAwm8c4XTnhVpbGI7Kiw9JtA6pKBqs/6FMaT7Fk=@lists.denx.de
X-Gm-Message-State: AOJu0YwTG3ZvnNRx47SEvoKFLKvVc16vuu20l946NdHsJ6MYTsxZUlzq
 CP8kMWJWRfNZQ7qU/iH/oBYOZDSMEQoWnR7tW1mNj5NxKl69eJv2nKYCkT+5SYVzTdK6oH8/RlR
 tIncT2NVL7E3TYlJCodKXPydgqOEZeJ1iQSmj35uUqBa+Dm4/KLmPY99F
X-Gm-Gg: ASbGncu0RYR2H7Nk8QkfIJPTStUicoPbRMoIRZdOyuUIFZ+cor5jFj5S60mFZ3UAz6w
 VEk8F2Xnq3blylojDS7rQAAXpi8k8k8kA/mGcFm9dUCO0k2MBdJ1x/Px6sachqiQfhu3iHpV7/j
 kLuuBTemBAYVEN0FmAQdfwIw3QFNvl9xl22erWAzIqP7q4XKlP19WXCSzf3ws3kvPHtd/7WQwVm
 p5wCd7C39pkvdI7omtoh9hgHRyMnk9YTboAcQYhUqmHoMBmZNI53PmP+6CAdJKk4X/FKhfRETHp
 zO86MlLxqUcO13DVUS7i431DUXSaD/N4APE6h+5ks3gKWob05a8TXIJNcaDWgoeJMRjroTWkdOD
 /99HYNDarCcHnnmBKgrBugwzWxmRcIBf3XWjyCNH1Ncmu5lC0r62kMA/0RxI=
X-Received: by 2002:a17:903:3b85:b0:234:8ec1:4aec with SMTP id
 d9443c01a7336-23dede2e164mr42851245ad.6.1752244754768; 
 Fri, 11 Jul 2025 07:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGig+gLHayLK7K049neKk7YHlMfMS6a2FrVPCR+dI+pVvGWpkU5mTJJzpsJaFQRtCcNrGwuw==
X-Received: by 2002:a17:903:3b85:b0:234:8ec1:4aec with SMTP id
 d9443c01a7336-23dede2e164mr42850865ad.6.1752244754286; 
 Fri, 11 Jul 2025 07:39:14 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ad948sm54234675ad.61.2025.07.11.07.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:39:13 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 3/4] mach-snapdragon: fixup power-domains
Date: Fri, 11 Jul 2025 20:08:50 +0530
Message-Id: <20250711143851.1490617-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfX5nF/7cmKgV2S
 onLrgCmYvcsBV9W54ikwkSB1/ZlQGhGhhl/owTZaTmi8kJ1Llb3U82aNLUz6AR3CGCfm9OBmwta
 9Ovtsed7x0Xqu/vaB+2LSHtiebzzJrZGjwBF86Pr/U0tf4r0iURbgeLy1TU6H2CBGSy+BzoDc3y
 ZGnQpZoZi3kVsXnbys7E4gB2ZZYl5QaCGqimEATMUJF5NCslMPD6WhwxJPWCCiITNEpWPdT1UBY
 RsW1f+7JXbOiaQo5WAi7otuO1JvIdyKj0ZMYk29fnFskGznVotNqwjDr5y1T3HIRcz/trvVjvfT
 l+vlpG22ys4DNs0fi4Ld8rjYveXbIi07fEighmMUuwwbMaMA+8bWKjFxpc3ousbzzz+0jfGfX+0
 ZwHTM1dK9wU2LTcGIC3VLRWTPorvdbTK8elRWgyU74PFIWieRIMdiOCpMKmkzCOXiP2arrFZ
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=68712213 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=YokXgKr-R4hWQjJdTE8A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: pmtfv_Cbu5jZyNg13Ma2A_6AontJVs3t
X-Proofpoint-GUID: pmtfv_Cbu5jZyNg13Ma2A_6AontJVs3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110104
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

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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
index 328c7812f30..9e8c5340f75 100644
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

