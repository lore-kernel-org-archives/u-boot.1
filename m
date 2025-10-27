Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD69CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A395C83826;
	Mon, 27 Oct 2025 12:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTP/983t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49F283826; Mon, 27 Oct 2025 12:34:12 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A5580107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R7p6lP888691
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KNyFUDlFN9v
 WYSKQPmeA9v/QM8zQ+TLNLQpOqG0qwpg=; b=DTP/983tVFNKAfaEJc1bYWES9Ou
 Ur1dnm8+abx6L4u1H9GQeGefVT+ucDTB4ybJuXPiZYGl4mPZRx5Qqdrg2WixyzGC
 46Lj50nQB6M0cyyk+0m10O4F6n24i1ZZPQ37eWQmPPY2ga4Gu3x6GUF+EWSqN23i
 qGjIwk8X2TbYnQc28zLamB/f+4oVhnblN6CBUgXSKb+JqC6C2ZIwxrKg8BP9bvcL
 PSvj8ceKy2sy/izwzRfIpffHnb5EdmfBdsqRriWvozGmwgg2PetuduE/RZDhpidx
 bVri7CYkQi/NvGpwhCM9paKyhiPEYXE7q+1ulx839dPk5U8O0BO83ZNHN6g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnb4eyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-286a252bfbfso108301435ad.3
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564848; x=1762169648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNyFUDlFN9vWYSKQPmeA9v/QM8zQ+TLNLQpOqG0qwpg=;
 b=oEQrj6dP0799j7zDiaF10yqedF0fMnNkWL8n1YSyntDxFUM0OTN47fNRb3Eh1Lackk
 10pqr5+LHPe/a8y7XNVXVbA1PbvY+41pI9QDHiB1Ai6+M5nN+ceMlVzVU1jzhpFpVB2M
 x6/aP/sx1uarJB4b9ytXa24CTKbXl4+4o5igBpEBAkGdIXmS0b0EXw50FZDmvnOvOoLD
 zgdYoMrxH0IdfjASm56uqGPHXObpTEH/H5twhcJrruDlj5ObbnG9hbiG7nhV/CwFPdjQ
 Pgb0oJzWla6zpaTLJfP7jDI0PsHYPJ4B0IHjnt28ztB0d7nKVWWcfOXPwjIA/U1lxriX
 8YTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg9bkgcfavBRk6/L25TxPEJba7locmNblLaW8tH0oQBl9UPrj7GpBN/PITo/f43uTJc/oLFCg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4WaXkIjvzJ6BI+Elf2adSNI8nhVkVm6kTEjmrfkxCpAfqbN0t
 qlwP3ubfhQ3+1Yr+DUviZRaErwi90ERd94HbJb6e7/KQxmAMYMjoAVPONOCcGIDOmHWmXxNBCbC
 2hYGlPvhDBcz5dYGg6hcsO1NwxGsd1qK4oGuWT3lyVNRPMdnC7NRu9Tm2
X-Gm-Gg: ASbGnctYiSx5YLZ5Y/JJBRDYTam/G08ZatJjL66vq9h+V3ZAy9HgiZgjqq456D5CsWc
 vjuhX70yUQ5FBhak5bTwUEkmTpVb4yItp81iNOl59isqzuwOzkaj7bu0OmRhDOaZTVrEueH4dBR
 YWNRnYyxVotliTeFx9h5EEOvgNSzwGMtIU8vie2C1loSj6tHfwcPs8SETiXDIyvas9QljktMLpR
 LpzET2JPZaH+Mk1P3Ek94R21ww3bv4iVosuuCpvcAUSSjCVVJPYtjZrTbHJ5jaUajl2t+HW3ZUe
 qBeEu/4jAO9iedpXW7QCL9mPswd7XKhWbc4fFKBYlncjfjCz7Gx+SdBuguDllNxz4cJi4PJ0ZRM
 DhkOPeeYomIPB10pMuGiS2psPld1wAYcSfUhFixQWDe14P7ZGIpxKc9sYTZVRXWKsfER7VscRr1
 d4qFLfeuSY
X-Received: by 2002:a17:903:2348:b0:294:9813:4509 with SMTP id
 d9443c01a7336-29498134745mr81622035ad.53.1761564848052; 
 Mon, 27 Oct 2025 04:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0CFeF0b8yDRlqUtgPGif5Q4wCgaBAFYrorTbvztsMuBo3OPmXFzPFvp44zyax+x688nZ2Q==
X-Received: by 2002:a17:903:2348:b0:294:9813:4509 with SMTP id
 d9443c01a7336-29498134745mr81621585ad.53.1761564847525; 
 Mon, 27 Oct 2025 04:34:07 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf4aa5sm78497825ad.13.2025.10.27.04.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:34:07 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v5 3/4] mach-snapdragon: fixup power-domains
Date: Mon, 27 Oct 2025 17:03:11 +0530
Message-Id: <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sj_bnymR54KfPE9bb2BditMWq1dh_Sxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfXz1MaiKhCDi7a
 bAD0lq1TL+9i+B3PYJumsFTIwWcMXHpuVratGv/1/4iYMDZOJ0IuA3g2SdqtBOXIdSFS9vua6DE
 migFU/MU8ZJu/8YAAp8xixK6TWGpyCN9OAx3oaILNl+GHAY1Gz739/pOIk/tQtZAUw3aOOC+wAy
 Bu8F2xHvtcG/wTGWeyRuPdk9YtahVwBBiSEc/Tm0zMBCAUL/OmgmvOO8fH+6oHOICfG84fn17PY
 RqavSSPjW/9At9ZaoOD4mhQgfFMhkLINUjYRi3EuyxOtJvRirU+va1yuT5RmDp30GRIHXMjc7lg
 RohTyvQDGsLwhfj/O+BHogvgQxEf4YVLXfHSrI7i5HUxcDQORiA+cBjsTTTlgrIOX6/lwv0+SnK
 Q6zB8R2YIAAG6F1NPr/bA625zk0r8A==
X-Authority-Analysis: v=2.4 cv=AJoZt3K7 c=1 sm=1 tr=0 ts=68ff58b0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=YokXgKr-R4hWQjJdTE8A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: sj_bnymR54KfPE9bb2BditMWq1dh_Sxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270108
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

RPMH power domain properties were initially removed from the
device tree due to the absence of driver support. Since RPMH
power domain driver is added now, the fixups are removed.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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

