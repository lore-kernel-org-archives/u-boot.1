Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663A3EDF150
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7E8183DCB;
	Fri, 13 Feb 2026 12:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jG55QEsp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIT7/3SO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791F583E16; Fri, 13 Feb 2026 12:11:11 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAE283CBD
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DAQJHJ2095055
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lLdiD412hzP
 NndXDkS9/FX88GZl8WrTb12/SqN1ICp4=; b=jG55QEspUbyAu914LVYfbCY1YfC
 1x64zB2wXSYuYSEJ+XfIz+vcoYqlP3u/8gs1YjHjUcl/cyt5GfEV3BdoXbSaK0qx
 aRaEgfqJGnah8V5od4kZPR3s7JavJfYOxOuSDVQMCeZuNkXZP6rqUIgHJKNOiwLY
 HmpfbsoqRgN6GO9pQaRNAjFzhDJPnDDA2Y0DMOEkAc6bxfPPmq7FO07FeeKQSrNp
 OoCNwDMxteTojQsLhYgLrtfD9ONKtGtensmhddf+ZoRs7hBWf/FmUXAmUh9tDK6X
 Rksb1AVa8vlKJxK/Jnly6qzXNOFywPLPyuY4BCjV92c9TGMFQhSOpxjbwmg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y3cvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aadeb3dee4so33030915ad.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770981067; x=1771585867; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLdiD412hzPNndXDkS9/FX88GZl8WrTb12/SqN1ICp4=;
 b=GIT7/3SO9vCNPrfPku0+G2TPh/PoxCHamZzf+B/Rq+QHEW0LfG9eYdPX6SlCi1E+FT
 2RbTKk5j8NCQVjatoaGoOu2aH+4YJr4I0RX+QKfkpehCZDG72JNANlXzznBi/VHCjdGA
 lkoty5EhbRn6975PikKdzD17UUcdfw3V/GoTjPRsKUFivsNrUUsIn+3uu0eGiO6actfw
 3+028N1fQAfEN0P3skayqDWhXiY06mKLOff5QbZaYUfILZULUg1sdUq98spJrw1K9BZA
 wBthWmtwpAL6NuIB020VWMpzNjVw7XjeMzQB/byqJ+yFkxCRx83fYsESPtiWoLChEVnx
 lmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981067; x=1771585867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLdiD412hzPNndXDkS9/FX88GZl8WrTb12/SqN1ICp4=;
 b=jBBIOPXVaT+MsHI92JdYdjUjPrESKz6wtj5XMes9xsfi8T+VXSf9CMrDantUhMyvb7
 Qml9qlISQ9SmBA23fuTa8zJHUAY/LJfB3IYESZGLBdtI18GOy/X3Y94otBz6+ZJYTROx
 gncSKosH8vK9oYhdDh8De73fn42XqQAvj5GjUEqiuPnw2vWFcHd7vzDXdjca15gNHTCu
 N9udfx/PCB/Vd0vIo3VLxqWwY9Cnjs1Qo/i2zEWxww2dacBhI2i1577hlbpJc154DuHU
 tVyZDS79XmCdDBes2Xwtz87JtaBWO76q6y3FisgCrmnReubfxU5oyYLGRTucPokocs2V
 XJUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCNfwjjlGlja4b4Ay6qoLLrunz9jK6zYo9gEayDNYDF+2usnu5pFqQak/GM6/mAXh1NdtJBB8=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ96LnR16DWFAfJok7SC/TtnwgW3Rpnq8kIZ1+9WCqrdyskYau
 TvMxtTAtTlp4axlAppK7T2EYDL5rOT1c/zrMtF5SG6jmw7oRQ6bRYC3xBu4nq9jbFSrCs0g++qD
 BLY2QT8gwuZAkcoabbnR5KSKX1Vtq7a38DKoTxFtZdhIrdSBUAvpJunOD
X-Gm-Gg: AZuq6aI3SzHTUhBCxPB6hDJLUCg4JTG/mC7PGSU0rOV9VE99+fhoWmwasZgsgkgqtGF
 0Kgw37H+SL+xkQXj7V2gqGgnCj8j7CJ88q9FGiisq0BA4jZiCkB8NL3a6o4uErbNnAc906KeRes
 o495cc3zTD/mULuzrss9Twnc6NaUhWCO9UcxZoqQ7agD5azzL1mNqmU3ODDjtWcEG6wHijhckRN
 JSNZKPf27xFK+/BaQkxrQmdHLSh2261dDF80hPObl8GMIurJacHSFIiHyrCv3cyrFnQwKZlXpL3
 k9+RjbOP9CmH/BT9fpDDgFJZxyogs45w8QMe740xd7dWKCzlOzwdurl36ebnXlID2db4yvmR9eC
 0j13ZU0taz/v0PBKN70lzeDIXtrepqgehwNvNyocXXajNyLpanbDh5cZ7tBBaphXRQGiaOjJUIT
 jWyT9c07TXjnlQSdSYdQhzs4nBBGSIFtUlBUdkJSZh
X-Received: by 2002:a17:903:2f44:b0:2aa:d04b:73af with SMTP id
 d9443c01a7336-2ab4d02e6cbmr22296785ad.30.1770981066465; 
 Fri, 13 Feb 2026 03:11:06 -0800 (PST)
X-Received: by 2002:a17:903:2f44:b0:2aa:d04b:73af with SMTP id
 d9443c01a7336-2ab4d02e6cbmr22296445ad.30.1770981066013; 
 Fri, 13 Feb 2026 03:11:06 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cc57sm12364399a91.13.2026.02.13.03.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:11:05 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v8 3/4] mach-snapdragon: Remove RPMH power domain DT fixup code
Date: Fri, 13 Feb 2026 16:40:08 +0530
Message-Id: <20260213111009.1254360-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698f06cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=_-ijzF4UVTTsGAM8JkwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NiBTYWx0ZWRfX5AqB8SP0y7l3
 o9i6ZyQGuNtaWR3RW/xXIdQX0PrG/045g3WTQxC5f32cJ0IS590ql7e6FDCQiY8h8sMaYDzDtHD
 SdEhd1nPqn7rqTzWobjbqEASuP6obYB1d1qWMtDtW/lFoC2pjD9E7TCKUXtuMhoWMW3aZFHEpIa
 A7Yf4/rqjqfvu8uTllKB1dVdBmHVzN35XE2OnymVPq142al6xm2Ocpht+WLX6OnhMYIVWCtRpMu
 pEDLE+R2PGQlQjUhkzjb3jAJ+mpOk9UhKy8yvktR30XleMYjbgpfR/cSTSMQCkW8SBnnMpeHeC/
 Xf6KR14ZIiHra/aPRDF0swLYYpAFhMeRa5G7qEtIte9Cuf3LJgb+MoYRLmP48HKdQSEC6XIdDsX
 OcPIMS1bSEiR/QCnYR3nSG/3K+fhsSg5cCtXVqZjD92c9gLI/rPphDEYxquCyOKdTTVZqsJftgb
 vxyN6vSVA2LHw7/eY1g==
X-Proofpoint-GUID: fCNe9YeatluBpiN2-diILaR0SkAfcCll
X-Proofpoint-ORIG-GUID: fCNe9YeatluBpiN2-diILaR0SkAfcCll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130086
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

Remove the device tree fixup code that was stripping power-domains
properties from device tree nodes. This fixup was a temporary
workaround needed when RPMH power domain driver support was not
available in U-Boot.

Now that RPMH power domain driver support has been added, the power
domain properties can be preserved in the device tree, allowing proper
power domain management. If a suitable power domain driver is not found
for the power-controller node, it will be handled with a warning in
dev_power_domain_ctrl().

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v8:
- Changed commit message

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
index 5b6076ea8e5..286541c8edc 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -134,36 +134,6 @@ static void fixup_usb_nodes(struct device_node *root)
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
@@ -176,7 +146,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 	struct device_node *root = event->data.of_live_built.root;
 
 	time_call(fixup_usb_nodes, root);
-	time_call(fixup_power_domains, root);
 
 	return 0;
 }
-- 
2.34.1

