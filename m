Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DB3CD5BC5
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A800A83E21;
	Thu, 13 Nov 2025 12:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0ayXT4S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5T01bcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D3DE83E1B; Thu, 13 Nov 2025 12:35:10 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4433383E20
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD6hjSL3801856
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Bp/915YfoG0
 4tkSif5DfKe61oM647JN5owrHUlulCh0=; b=f0ayXT4SPbQ1JIGSsc+MRTPaIVR
 0mBs/mHkjDYLE+wQlvLOikgJDBGF1NeclJ+3Pk9DYAFJstHTCi21mLmtsEJIb0l3
 ELmYm/d8Qg3KXVd2SsP/fKAUYrrABIv4krahRehDIJ24IjDvgO4FaxGQ5ucqPtrB
 f3sGvh1atNT7DX6+F1UQw19cPgtbgo2euVb/o8JO1xM7uEwa3MOOJdHpuVpn3Wu8
 1OzdECb9q+lr5a8XKWrvk3H+haU7Ll0hM7xOMopkJzpV114ImckQBc0WRxD6zwoP
 OmQcFIqMsj8ZlxP/DFzwniTxY7MAbWs1fh8ha6xtb8UmBL4p2lTdszKEv7w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaam8v8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-295592eb5dbso8669855ad.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763033706; x=1763638506; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bp/915YfoG04tkSif5DfKe61oM647JN5owrHUlulCh0=;
 b=I5T01bczqP5Y99WdwMIXjt1ahL8TLU794z0QOAW1Xj1iKQxsdb4zoCEVGWHyBXfF9P
 wvIdFr1hSeo2NajxR6KEpzRC6ldFn5wYy20aO6QsIBfFmWyhnhLqLoHNThtScUaK8tFU
 FBFmS0d0UmUd7i2rJjuXd3IHW92amo7KgesKjisDex/TCw5IBGRpZ/4F51komIC/junV
 1lDGPd2bx7R+0D+T1qYWCpvZI6915gwT2jOob1fl3edz2WjZ+W42ZKsG/HIPOHGffThw
 LADe+mJDYbOC0/XyP29ptz2EIYPO5LiJ8X9beY7V1GoRn/A6imbZTXiSpN5FD2E752qA
 dzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033706; x=1763638506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bp/915YfoG04tkSif5DfKe61oM647JN5owrHUlulCh0=;
 b=FAJcg4TD6QRwSLG2BPL3u5pNOcOWxT9am/EF6rvU0TzZwj3v6Y2TwTYQsKbiVZPDgN
 unPUb+jRac3LvvzdhDoa+CZuH6XreLD6gZ9e4DbfsokxYfEOH5gW22hOor6MXQVc2pL1
 3p1zErVPRmW/EILMhmX9DPyflFesA6UOXx6sQSQ5BdF+C2g8LbOPKB9cUg/Vi+SUNVgr
 Z/+Rmm07ljhHtkG/1Aq54Ttf5iEZpVk0HvInNzXWO33OFsCXJo/kqgLlEstKSmWe2EIe
 5UybDovvwBf8MJ6LVIh9WpHuCJaxpbLZ9Q88F7YaUWfn65SS8YxTg9y891J+XEbevMEP
 TN+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQAoVa3HAONk7SwlF8cQT1CO5EJzHOQzch7CqwUXf0CSw07TAoKkmISmRl/6trcRZToHxkdls=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjq7tl7t/KaCsWUmHJ/rjJ8l51g0L3uD63D/1p5CPbp8v71tI9
 WwSpLIWsV2g2X+hFSyGeqAMr3l4TkFyeq0w99GNTMUwB1BW0H0RD2RWhv4zK8OhgZlyqWLGtFfm
 lKpSqmq5FBTula5HxTWKmtuy7r/fl043lOyNK+EMKEi2JnqdcGUzWHjO8
X-Gm-Gg: ASbGnctNVL6/ols5qP18Jkf2fyxLBaylmUlsByag8OgvXHR50aryGZrNbYx+0n1y3IE
 ShM4JCvRXf/BVaAZcTb+Z6Q5A/V+BlBIZOoYhcU2f5Lxiusql6eNubf3bNp0vQzOdRDy1AQ6t5p
 N/Wy4T52qQeKQBjFHNtxNIs/dMzeHIs+1uLscPqb054gb6Ln7GLZJgASg32kmAdQqUkx9oiT8dQ
 zrSzM70DFabHxVtcjFRfqJ2A+BCCHlxa+m8Q/lBy4iAiYa3T6xtTP81VneKT7/Y97nh6zLVhzst
 cF2VhMICam4bnzLP5M08sByJCgdqQPDMDUMMoCfoWWb6ON5l0DI0medNr2zoQWwyfNupBZ9UV95
 FkZa+2akAa2avEzQjhuwB/M5HF6P2S8lAhuWqjD8oq1U+eKoKGRJKhDfvUMeTxoB3fbNoyZm4te
 hbFqFNyWHxJNxoBW2+mw==
X-Received: by 2002:a17:903:3c46:b0:295:560a:e474 with SMTP id
 d9443c01a7336-2984edacbedmr77294595ad.32.1763033705767; 
 Thu, 13 Nov 2025 03:35:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJDjoDaCRAqGWOVdtb5FMx4V18cFFJ9QVL3QuiLw6njR2MDqkTMzPYkHFTg889Hzl0j9zFvg==
X-Received: by 2002:a17:903:3c46:b0:295:560a:e474 with SMTP id
 d9443c01a7336-2984edacbedmr77294215ad.32.1763033705307; 
 Thu, 13 Nov 2025 03:35:05 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:35:05 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 4/5] mach-snapdragon: fixup power-domains
Date: Thu, 13 Nov 2025 17:04:26 +0530
Message-Id: <20251113113427.2218045-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfX+doo2TfOk7d3
 KdR0ldcLPs+eivuaxc0ZQLR6nO8QXNlWNkNaGk6Hi/13fchxiUd0Mg0P0jBE9WnkyaZ2Hz4z2CE
 SvkSRxU56ZNYhcvR15fyvXB/QZGmGOqAMB18dZoMD27G7gZyHKhumAo2uj34xXu/8RzIZTRc9wR
 Tyl8zYdEZ3mEa/FJwJ+XrE9v3t5LRJ/xzrFB8Lxu4dFSXEmBK4WlY2BKlI4UEI9TnjkcqYUWm7u
 UejELDvdRLUf842fOa/aIcOy6uesc/gzJZ/YP1bj5yJB31tjU4pHF88V1kh55nr/TwHKRIj3jjv
 N9GY/tuswxEY54rVWm837+d3mYIFJd9tzsd7y613eFPmhfk4flaYSj1HPoYpWJsOkB0PTfxrXUP
 BcBvdfc0ENTp1XEe1Ksr0O76IB3tfA==
X-Authority-Analysis: v=2.4 cv=d4f4CBjE c=1 sm=1 tr=0 ts=6915c26a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YokXgKr-R4hWQjJdTE8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: xxvYhi-Sj43j_T7VZdQvRFsWNVGeihVz
X-Proofpoint-GUID: xxvYhi-Sj43j_T7VZdQvRFsWNVGeihVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130086
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

