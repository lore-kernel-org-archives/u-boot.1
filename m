Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC2CC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 15:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11EE880E8D;
	Mon, 27 Jul 2026 15:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5V0yXc5vuLkF; Mon, 27 Jul 2026 15:56:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0B4A80E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785167806;
	bh=yCHdwySDAr39LXvTcQYiTci9fA/mJ/MIHNKHg59B4eM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dkXiJlLgh9Xz8UbfUoSLd6Vx4ARFBGaH9x44udnv2bWrCQSAdTZ9GMunICY/KxeFa
	 OD/EPPCYLIfdmeiygSt02hjsCoEEiPoUBEffUHPF9oPs4B6kVEqlOJF9F3QkxoZHcs
	 d+BriZ+4X1jhxxg9riajx97/VmgskeayALJO4RwBbmq+yMAPaIcsNmmS9DHlSGz5PA
	 yiQb4XufjVxCvT7YWiCHLrGFWsKeGiLFQG5A7j0VypSm/fUHkGhiuzmSqbCVJ3VtHf
	 2eH1naSqBPTIzBjRG0uw2KI5uJxwhoZfc6Izzx27DQfaa+NDF7KycKmo0Pv/qfHm2/
	 PKiweuHtlZ3fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0B4A80E87;
	Mon, 27 Jul 2026 15:56:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 34D78194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26B924071C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Vhs8-XGmfGU for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 15:56:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0455A4072F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0455A4072F
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0455A4072F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDmCVA3823751
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:43 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsmdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:56:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so1958842a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167803; x=1785772603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCHdwySDAr39LXvTcQYiTci9fA/mJ/MIHNKHg59B4eM=;
 b=HWk9sHMRGHLve2+OrAqI70vK3RddZr644Ks6wq5c7j1WIQ11y3XQZWJWHmZJSAisE0
 T8h/Y4MMkDF/q+5Pk2aNzGAucBP5+ZHy8gql/6vfWf6WKhr6486aIu2mLzE3RKcxbGwH
 UBQab2bCUSq6Awdpgaxd8bz8Q2AnhU/ulkOSjZuqjagRcAjcEaYzPXzvSPJdjpCvCEb1
 B81od2yoYLohNv5kpHkkQpXmF+mINXYwnoEc7tGy5vluoui4heRgR4gnVCzcWBWeIXEO
 S0iJCIqSsGR7mNIbqnm+r4FNr5Uql46VzEMXM3oE+zCD3E6UEKfzQKrV9QUh2+ROGnPP
 hRKQ==
X-Gm-Message-State: AOJu0YwrIvlONP1yE26pq2KjX49KdN7aY+tJ+okDXQ8gB7KUaAhiXg2C
 qxFFvqWVXLtTsW7X/RTxUzitn5+WOKhHub+2ZJ38nGV/uzVysACJ2FbaI6ohcW6RhHbzRxoNU6t
 +tSuUfT6/fOzB8ntJ+OoWp3849nLdpK9YWj2/YL9dutIKjk8BLVsfaDNxMMAk83S6e/PPMGk=
X-Gm-Gg: AR+sD11usPB8/2wkiUQgmijawTW1rXF0G1OcVHm3nqRr6Ocp1fG3AqqDrN2bFSLM+gn
 tMIyRfufO3W1JzWhhOTqMDTxqTE+WDkas9wleR3P5yWCm0eI6BKH+fBfJQi7IsLNrxYnaG6eiyU
 HzWaVWaQGeCyOHpvX/aGq2rBB0sQxhvYxgmexicnDfqseowSL8z+Uo4WWjytEhkZUAMG6nug8RX
 ljCNDyWMgOSmy75D0tH0o/YVWC/vYRTMGAYPAUYdsfBIs7/a8zDaNkBj4r7HEnZ5AMJPN+1sIhP
 gjjziRH6RlQ7ZXtzT31ZDv8YM7r3Si9BPXY8fHEs3v4IGyj9LWElMDsrJkMkLwK7YcduxRrLUbr
 UtDzDme0ey2lmwoGthXhIrMEGdlBc3c0P5ygcBDGmK/APYJ25LTdvvTKiGnl25fr5a6F/aR2Bum
 yeLATRUr6Y8l1hbDWabVCDuikHbHdY
X-Received: by 2002:a05:6a21:730a:b0:3c0:9c1a:894d with SMTP id
 adf61e73a8af0-3c67e083437mr9034113637.69.1785167802670; 
 Mon, 27 Jul 2026 08:56:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:730a:b0:3c0:9c1a:894d with SMTP id
 adf61e73a8af0-3c67e083437mr9034070637.69.1785167802029; 
 Mon, 27 Jul 2026 08:56:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm33286941eec.11.2026.07.27.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:56:41 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:26:02 +0530
Subject: [PATCH 4/8] tools: mkeficapsule: Support signing in multi-payload
 capsules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mkeficapsule-v1-4-5b162866b092@oss.qualcomm.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167781; l=5281;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RAv7CR1kEv9RBWIxpT2f1jNfNmwomdgoYgbLmk+Rqz8=;
 b=5fcj/emA/W485yNdpW7GCQOneSPYNaMUTvZarcNjkafqeiuR67nrLfBE1f/XVIQLVYI3MySSe
 zo/dMfQpJGYBJxWYKHmnLIPF1+StteOP/eakbc+sIKRju8GZDy63Ol1
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 8cKruXyLs_kOVPkeZAhQgXxLHr0hdwMW
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a677fbb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=J2aJFOiPmoikAaJ_EHMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfXy9vzTDq7uTO9
 sfnTaHDvzbaoJHtowakLK2TMJ80we74XHrAm0nbzAOmeF7kqU65EslOGipQY5DJ93TnLz3KFswO
 DfY8pOXsEHshXRbzXqOLLorSkvxhmSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX1+x2YnITJHCb
 DlhL5pYHyTC+etGWddJazhvAbdJyiXqb1WcDh1TXFNQLuEPDpd1hOFDjpDskNnHkD47n/JY8qMT
 oKbeW6BFPUwWGy436SCJBlMxmcN5Xjj5AqMtMt499WWcAr5foCnhCh5lE8u0yKDqX/RMbEdyOU4
 NG7LIw0CWY+2y7D6Wytmq87PR50VwwdrlMZbNAJ4RwAnwScP0lIp5jigB5hI0QFN+c/VWk8OH0C
 WP1lX7M6MSRoakfSIZbtiMhvuW2GODU+zUfr1Yjn91Fe+15L9XLot4FicJDEubzbYPbrACCTbA7
 zL14baGe5DJnGNDBARHWHEiDeKuSvZ1LzijBR5sn17XzyWhitOAJNCt1xaW7SLUYnbUCV3T9BqW
 v3QJ9BQHGcEJMikFvYpcE+GLZOgZVSxGwGYL4g+nQzwaQvj2FihhnVLggFdRyd3ikCfEPUqi87d
 F/BG9fHNyr8oCesn5ng==
X-Proofpoint-GUID: 8cKruXyLs_kOVPkeZAhQgXxLHr0hdwMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270149
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yCHdwySDAr39LXvTcQYiTci9fA/mJ/MIHNKHg59B4eM=; b=Aj7+ldycvHfJ2rnZ
 vpD5n2lnY0fHdcShVqStW+RixO4e89vxwvG41tzQJuysxZs6bTaAIF1N0vG410XE
 5483hheR/XWQ7zhCQredexQx8kj7/mT2AbrUkaCMGVgjsdAjfy37QJu7o1OnqAkT
 gayiKKgusAcopJ0A02Q6fn8DIem111m43hHruoEgShrCfXnyL1iVFLUDuNrpVzCT
 e7nbu8U6nBxIfHlYLf2GKHZsGHvMsIiPmU3G9NlmU9yBqmU2Zv5gsRJ+EFyfmkSm
 Ee4E/2BKl3gtLQ1Yd4NgprsDCnKul2uPKK50iYZI2VJ3ZIrrbKQ/rbA/GYE7NFkZ
 VXhvdw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785167803; x=1785772603;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yCHdwySDAr39LXvTcQYiTci9fA/mJ/MIHNKHg59B4eM=;
 b=Blwp2LFz+UcgW8qKjMNVXw39D1wARWluTTNkrPbnc5bPV0wQdWbTDHL+JTmVAm9y8D
 tvoMOeUuyX0Tvjg7MjJh9Z6QQxQsC+GGC9GtU30FW/5yj+Rgll3HucLxqHVQZNS8Llum
 HjPP+X0kDBS45kQ/F6rSX8MlZ6FV7Y5pPi2m0Nmafj26MiwNmlwFbE12//kTkvj2eN2Y
 +tx8Gq9AiWbdLAJrK2RhkNZdR6AfUO7L+5ckVfwItY/mJYytPFOM7rLPpxdGyNq359eV
 RyCsZb/+nw/qrHS7pGIpfVQYF+1YNfK9Z6p05rhxn32lcoTyFLzp7wXyvgUpHtvfus9r
 GkAw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aj7+ldyc; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Blwp2LFz
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add signing support to create_multi_payload_fwbin(), which previously
rejected any payload with a private key and certificate. Per the UEFI
FMP capsule spec, signing is a per-image property, so each payload in
a multi-payload capsule can be signed independently.

Each signed payload gets its own authentication header and PKCS#7
signature written after its image header, reusing the existing
create_auth_data()/free_sig_data() helpers from the single-payload
path. Unsigned payloads in the same capsule are unaffected.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 tools/mkeficapsule.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 03a9a44e1bd..b08df37471d 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -731,7 +731,9 @@ static void print_guid(void *ptr)
  * @params_array: Array of capsule parameters for multiple payloads
  *
  * This function creates a UEFI capsule file with multiple payloads.
- * All payloads must be normal blob type capsules.
+ * All payloads must be normal blob type capsules. Each payload may
+ * optionally be signed independently by specifying a private key and
+ * certificate file in its capsule parameters.
  *
  * Return:
  * * 0  - on success
@@ -743,6 +745,7 @@ int create_multi_payload_fwbin(char *path,
 	struct efi_capsule_header header;
 	struct efi_firmware_management_capsule_header capsule;
 	struct efi_firmware_management_capsule_image_header *image_headers;
+	struct auth_context *auth_contexts;
 	FILE *f = NULL;
 	uint8_t **payload_data = NULL;
 	off_t *payload_sizes = NULL;
@@ -758,10 +761,6 @@ int create_multi_payload_fwbin(char *path,
 			fprintf(stderr, "Multi-payload capsules only support normal blob type\n");
 			return -1;
 		}
-		if (params_array->params[i]->privkey_file || params_array->params[i]->cert_file) {
-			fprintf(stderr, "Multi-payload capsules do not support signing yet\n");
-			return -1;
-		}
 	}
 
 	/* Allocate arrays for payload data */
@@ -769,8 +768,10 @@ int create_multi_payload_fwbin(char *path,
 	payload_sizes = calloc(params_array->count, sizeof(off_t));
 	image_headers = calloc(params_array->count, sizeof(*image_headers));
 	offsets = calloc(params_array->count, sizeof(uint64_t));
+	auth_contexts = calloc(params_array->count, sizeof(*auth_contexts));
 
-	if (!payload_data || !payload_sizes || !image_headers || !offsets) {
+	if (!payload_data || !payload_sizes || !image_headers || !offsets ||
+	    !auth_contexts) {
 		fprintf(stderr, "Failed to allocate memory for multi-payload capsule\n");
 		goto err;
 	}
@@ -806,6 +807,21 @@ int create_multi_payload_fwbin(char *path,
 			payload_data[i] = new_data;
 			payload_sizes[i] += sizeof(payload_header);
 		}
+
+		/* Sign the payload if a private key and certificate are given */
+		if (params->privkey_file && params->cert_file) {
+			auth_contexts[i].key_file = params->privkey_file;
+			auth_contexts[i].cert_file = params->cert_file;
+			auth_contexts[i].auth.monotonic_count = params->monotonic_count;
+			auth_contexts[i].image_data = payload_data[i];
+			auth_contexts[i].image_size = payload_sizes[i];
+
+			if (create_auth_data(&auth_contexts[i])) {
+				fprintf(stderr, "Signing payload %s failed\n",
+					params->input_file);
+				goto err;
+			}
+		}
 	}
 
 	/* Calculate offsets for each image */
@@ -813,6 +829,8 @@ int create_multi_payload_fwbin(char *path,
 	for (i = 0; i < params_array->count; i++) {
 		offsets[i] = offset;
 		offset += sizeof(image_headers[i]) + payload_sizes[i];
+		if (auth_contexts[i].sig_size)
+			offset += sizeof(auth_contexts[i].auth) + auth_contexts[i].sig_size;
 	}
 
 	/* Calculate total capsule size */
@@ -866,12 +884,29 @@ int create_multi_payload_fwbin(char *path,
 		image_headers[i].update_vendor_code_size = 0;
 		image_headers[i].update_hardware_instance = params->hardware_instance;
 		image_headers[i].image_capsule_support = 0;
+		if (auth_contexts[i].sig_size) {
+			image_headers[i].update_image_size += sizeof(auth_contexts[i].auth)
+					+ auth_contexts[i].sig_size;
+			image_headers[i].image_capsule_support |= CAPSULE_SUPPORT_AUTHENTICATION;
+		}
 
 		/* Write image header */
 		if (write_capsule_file(f, &image_headers[i], sizeof(image_headers[i]),
 				       "FMP image header"))
 			goto err;
 
+		/* Write signature, if the payload is signed */
+		if (auth_contexts[i].sig_size) {
+			if (write_capsule_file(f, &auth_contexts[i].auth,
+					       sizeof(auth_contexts[i].auth),
+					       "Authentication header"))
+				goto err;
+
+			if (write_capsule_file(f, auth_contexts[i].sig_data,
+					       auth_contexts[i].sig_size, "Signature"))
+				goto err;
+		}
+
 		/* Write payload */
 		if (write_capsule_file(f, payload_data[i], payload_sizes[i], "Payload data"))
 			goto err;
@@ -892,6 +927,12 @@ err:
 		free(payload_data);
 	}
 
+	if (auth_contexts) {
+		for (i = 0; i < params_array->count; i++)
+			free_sig_data(&auth_contexts[i]);
+		free(auth_contexts);
+	}
+
 	free(payload_sizes);
 	free(image_headers);
 	free(offsets);

-- 
2.34.1

