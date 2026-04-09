Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4637F31E46
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F17283DC9;
	Thu,  9 Apr 2026 17:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMoxVxWv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdWWotHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C738412A; Thu,  9 Apr 2026 17:45:36 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4949684167
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Cxm0a1729916
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 15:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eWSzslYQaDWI+xDwoh+RQc
 d3SWZCwgps27yjqClyHio=; b=aMoxVxWvWZIM0a4lLjsOvddCNPJmAfyDa7jJz+
 ja49KL77QuxBE9ZmojQHVpBULD8v4sz4fWH2YThP9aC1XdhlZ+7Q5PuudErm+J0n
 JupVPDbMNXAfGFmQOylo3tJBRJ4h0YBerasGe95Kie/rMWs+AMTI+BWpzUjIUQc0
 S7ms6ahi/HDfOtZUu5JattPinTsnw+LIwNa8V/pv+EV2ghyG+QFLNfirNXslfoGp
 Aq97uFQAN+YOI10cJff3XVKL/OIIyfB2lcYQcARQIWcpC+Oq3t+BtZMyr8BPmnpB
 K5i7xif5+VJEQMq5seAyaF8rMAe7wTp8USbc5VHEG4Dj6reQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxgmp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 15:45:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c4664f75fso961408b3a.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775749529; x=1776354329; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eWSzslYQaDWI+xDwoh+RQcd3SWZCwgps27yjqClyHio=;
 b=TdWWotHQ7ZhHrAn0/nPH9y/OIM5pF9A2zWAE5odx8+xr+TFrTqdVQDQ54GPClbQYuY
 73q/GZMx9pv2g60bfrNjOIPUZtELoCKD59o6xvxAdUHPDGojJzuv96nB7l7/JrBhLrX5
 TYVSTI4PwWA/EcG97IqB2MuHeADQmgyGTU1znG53ptvT4H1O4MUqOrOe/DNUe+fcIeq2
 CI0RAwSeVUqxgaiagBRuSPOEiNN5q8LbPEat/qynd1l/cvKuswBZteq8zbsez9hFGjL1
 ZTyuwPXxmmujkUQtMJN0SrGaf12h/o6t6HfbayPIRl3oVW78GfxxIz6+AvZgPrVw+O+X
 XzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749529; x=1776354329;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWSzslYQaDWI+xDwoh+RQcd3SWZCwgps27yjqClyHio=;
 b=inJkjdYGK8goNFASO6jH1wGCFMHwlNRS+IhHwTEAdlnipxVmcObYJMZxCXmgAczIDW
 Pso/kFEytAI/VYU3KxwhTqKaEIjMUsmra3t56vvcsi1/poJJHlQg8el3+HjvZyejeme3
 SFUpC2egojHuwxSF9+sMZHjraLoNX7588N9SkkeIr6w6fVOLxKQ+1SecmBm4xmC+JAHu
 0se+YWkZrPkeuyCnAjJg4ESVsAD5MKnys0CauUXbuU6YbKFLPKegqg3FukEt0nUHZUQF
 rc4Myih6pTAj7aD7W/k6qMqM9WBtgtn0DNRW89KZKK1Q5frtBLAnM8bYdVy9AIjjwEON
 07Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX48/jqusvjOSG2F/yAjpmJQ/CbNW0lGjje5NMLv5na4Aw4MXm49+nL4bZ9XlZzVZfdjMqpnjE=@lists.denx.de
X-Gm-Message-State: AOJu0YxupsBTCGQghpwqWCVUl1M/B1AX+ikAk1RG5hFb98LuBqBnv3cB
 Z+rcNnWT/vr9YMcusiKA8f3AL6/UcaoJ+KLa/TlOrM+8W9nZ9demcXrPiAiekuRtgmuCP+aKk32
 Ejhlmv8Eok4DDX+fs6A/SQjujIgDteUbNT2Dz26ZdQcDMlLejcLnQG7t4rY/z0u5o
X-Gm-Gg: AeBDietDLg+OXsKtrfKB4T5N3pjT6wnujp4l3tIa291LET8e7HEJMyVP4JrTkveRVIv
 W1oD1uu/h5feS4B2IkAWBEw4/8FuGyrCegBIAuOBHpCw0SDxyenjFlZROraQYcaoim2tSwNK1n/
 XOepl8yK8aT45bdmyfELcrrqEz3IVxVXo90h/PoqXyc4orFc9uXOVFX85PP3OaBHYpVi1rQCp2y
 WgUJGlBLwYkSFYRAPFHuHnmZJLWyC9o8uSPCzq5SZWybi8v4ViGavmf+wvWpGxGrVUQPY7U2NC1
 64piPF5ZcLyF+8cyakTQBlixKdJBNPjcfU0uXGUQYRfT1fZHhHhvjkx6yzvSkACfXyGYL1+dkzv
 NIWUkKv1rsg18m0bacuOqSX2Ai+Vepn+UwFxBS3xZuj5GQyCC8wJlPILCCYX53KkjGt57chim+r
 UOclTAEvlGC4yukOY5YoZpVsENPJkQ7HoVszF7e0w+MARSWzPCrw==
X-Received: by 2002:a05:6a00:14cc:b0:82c:e4b4:b056 with SMTP id
 d2e1a72fcca58-82d0db9115cmr25672540b3a.43.1775749528893; 
 Thu, 09 Apr 2026 08:45:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:14cc:b0:82c:e4b4:b056 with SMTP id
 d2e1a72fcca58-82d0db9115cmr25672483b3a.43.1775749528223; 
 Thu, 09 Apr 2026 08:45:28 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2443dsm30653777b3a.4.2026.04.09.08.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:45:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 21:15:23 +0530
Subject: [PATCH] soc: qcom: cmd-db: Add optional support for device
 programmer flows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJLJ12kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3eTclJQkXWNLk8S0RAMDYwtDCyWg2oKi1LTMCrA50bG1tQDXfOt
 GVwAAAA==
X-Change-ID: 20260409-cmddb-394afa003818
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775749525; l=2755;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=i4id6wWSmVD7yXxJSQPHk4NenYihEIwXMm5c7P9jiBo=;
 b=e+sWMBha5m6Q43H2a1wPVc1DAAd2T2iK96dc7Mts8bSr0vxkRBjB0eNDXrZyceA1g3O1ZvShv
 uWAyLECMk7/DmrTlaoQnilBpv2IC/EZQfpTUywxsQLvh895pj9L5IqZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: PLDdia-cOC9dcrkXE2rH17WE_KgN6FQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0NCBTYWx0ZWRfXxAFL4h4UmzXk
 6Y/2Elwu/N2b9Oi1NK47HzVD1OrLFVj9nzZ/G4io31j+r9apXZylWL3oHZk7C9sTlw46+w1Hd3V
 ZaYPdHC+TOfQd2+S+2RA3dTjqAGCdkwDc5RvZYvmNdDmGR/pXLxTSjOplto9w66XAnmimrLNAsv
 M0dXZbyTQrDf+gzw6hyl63CqvyqJYIeSvMM560vqhshKok/tdMtHrL5sA/PdSdJwUfMf9dUoeFc
 8al/4Zt3Bvioq940i45uctGY1t67SHO3osseZm+ww0c31MLAwPT/F09tY9+XlW5N3uyMZakf587
 jdDTzm4Qn6iJxNQVaQ9g2CvjkV3iBqo+A4XzCWmLUuvec/AZQiIRlvAl8dN5uEUaYrcki2EydLb
 aZ2xsXI39dD13w8FsQQ4oLT3Sm6DWchOc80jIwZyGagFmfzm9poh6EAiNuRNmwulP1RZ9oH/Sh5
 CB0bwulJdjdhOjYtmuQ==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d7c99a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=T12rikTJy4dLEMnsOkQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: PLDdia-cOC9dcrkXE2rH17WE_KgN6FQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090144
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

Add QCOM_COMMAND_DB_OPTIONAL Kconfig option to allow the Command DB
driver to bind successfully even when CMD DB data is missing or has
an invalid magic number.

This is required for device programmer flows where U-Boot runs
without AOP (Always On Processor) being invoked. Since AOP is
responsible for populating CMD DB data, device programmer scenarios
lack valid CMD DB and would otherwise fail to boot.

Normal boot flows should keep this disabled
as they require valid CMD DB data populated by AOP.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
 drivers/soc/qcom/cmd-db.c | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 8243805e46a..239d87e044f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
+config QCOM_COMMAND_DB_OPTIONAL
+	bool "Allow operation without Command DB data"
+	depends on QCOM_COMMAND_DB
+	help
+	  Allow the Command DB driver to bind successfully even when CMD DB
+	  data is not populated or has an invalid magic number.
+
+	  This is useful for platforms where CMD DB is not populated by
+
+	  When enabled, missing CMD DB will generate warnings but allow boot
+	  to continue. Consumer drivers must handle cmd_db API failures
+	  gracefully by checking return values.
+
+	  If unsure, say N. Most production Qualcomm platforms require
+	  valid CMD DB data.
+
 config QCOM_RPMH
 	bool "Qualcomm RPMh support"
 	depends on QCOM_COMMAND_DB
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..b4682d811f7 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
+#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL
+		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
+			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
+			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
+		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
+			    __func__);
+		cmd_db_header = NULL;
+		return 0;
+#else
 		log_err("%s: Invalid Command DB Magic\n", __func__);
 		return -EINVAL;
+#endif
 	}
 
 	return 0;

---
base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
change-id: 20260409-cmddb-394afa003818

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

