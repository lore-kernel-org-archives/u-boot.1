Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF7AFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA4784662;
	Tue, 28 Apr 2026 09:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQTrzsKo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IOy2e8Du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9F584656; Tue, 28 Apr 2026 09:32:49 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBD584605
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S42xL51329580
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=; b=LQTrzsKoFah6IAEo
 IJLZGJfh4jb2UQOl889Lod8ZOwNeiIsL7iiFVlxiQf0ynFN5ML03mCeaBK87J1Oj
 cNt1w90O/BfwxEUWgcbLiU2JfCBJdGG0eSJiHgBdiSmHbUmLpiJ6ETdjPVRXtfzp
 LWbEe90G97t/LGVUc+1HXarepq1M+NTn9KEaY4VpOp0KsmJf+nFYi5xW6DZStyrX
 /xW3Mz52QdStX7iqEX8zW8JJWarUEc/hqXq/I1LtB0LrRDT/YaQOQjtR9PJ3q9zk
 vFqFTQB6MFOHQuLnio5Hwnnbz/E/+ItJGGOBs7T8riwfv4tEzhG0hjdPsR09u/R0
 BUijiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhagq9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ed279eedso76643705ad.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361564; x=1777966364; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
 b=IOy2e8Duv239lTnKrdCE/9sksWfsil1BS4TgCUbjnXhMVi62YDqGBNJFbNaULCL82T
 L2t+NnZ9dX19GgFbMVZ5OETjo/IHAmO10cJ+5YJ2+oBkOvkcGTZHr7f2xJDEL5YnN9u5
 P7oBMZPtBLBTAPttplrLSnttNitUfhF/jw7NyPWRaYc4Frqp2hCR6HObRug68s6iwm13
 ydLUv1e/sfJMq8lYM/5ajSbaeOqAH9ade3m0TCeglHYT4IDFRD1otVX2aC8X5MU017rS
 qs4Qc95h57HQQ/UC60M+4KoEwDyxY5OobAIdYK0nyjq22uxYC/pkAyIO6cgYI9Xex33G
 C0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361564; x=1777966364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gw2CCvz0qPRbZYu10q0wXudEGMpcTESOWCBnDmUFIfU=;
 b=eb4JhbEc4niwXHPkko1KFjPJJl5b8q8/1gyCYEbD9aG8VifWJX0lhQSMjlORqtD20S
 XocyzQ7IxNPBcAd5jqUIb5vRkaGF3iYVSNgISiGKOafge5V3Qv2VC00ySh+nvMb/gufn
 C9RU7qOeSS7aWG70WymGTkBM5iWd4pnyhU7j/n2BvJA76TP8fHINuqpunOUDn7IYdT6e
 6ONhSaoUgtZmGW901aRC0qfNFklhqG32tA5MH3v1xuIAMLG8fbYgSzaeVhXvnCYCLF/i
 l/nHLVtVSbwJ9DVFxiff7gdJTOP0NyRHdXsMcBRW9Qcu3cU/A9yDsaoD3vIUgTr2eism
 pPYA==
X-Gm-Message-State: AOJu0YxwAMQwBvvGql6RKkVoRmvUAMui+3X+NST0mGwzRISzpxarhUvU
 vZwsygyQQ48nkhFp2bjM/ueeE8VewHzxi1edNGLMdHJsWsLm4/p0ZJylhJFv2COvwTFUr/3ZdiB
 eraq8cNBXGn3Lcd1Bnm7vbtlaK0AlIj0Xx5vO7Sp0CA3wXfzlBETRWt3W
X-Gm-Gg: AeBDieu+wJT47cTjOTR995/Ga09FbSeiM+KWn99e7d9z+epnuHd6AckpyySuPhnwXFX
 lAa4RSGlIGlL2OujWLxdHEpJGDH6XgbwZkWSehH/OK7ZMyXjmW9sAKY5OLu1DtKeBHHsNy8tsgt
 B+y9go+dCjXZRjDJ8CJY7mdijy064SGcy4d8pO9wiJNx/EZJbJ2cOy99HSk+NJlTZ6jBYJblx1g
 vAJrWMlX+Y76oXjYKS4tiw+m1EVIQkbc3FLUkAyj2RLSHmN8FrMCzfb7vnOHBETHqRn/XaVHlbp
 BXTTLTr5RwsB/6Wj1VjQEzo8YW6jl1u0ZfsxJWUJKL5Cu99/5fiJsWYIMwkiiIbcssTmg4yundb
 iBEqo80JzXf6KTfdg9oIRQyooDYslTOZ2mPbfkmMw2aaRD5ooMTtKdZPIpj/qU1bIsPrGapTkIw
 v86oR6KCnLb4apymJrjBoqFJSrFyBNoemXyhcZDC/Qd/dAi7aZKIMGl3jqBhzF
X-Received: by 2002:a17:902:f70d:b0:2b4:5309:2c14 with SMTP id
 d9443c01a7336-2b97c482bc7mr21062905ad.31.1777361564385; 
 Tue, 28 Apr 2026 00:32:44 -0700 (PDT)
X-Received: by 2002:a17:902:f70d:b0:2b4:5309:2c14 with SMTP id
 d9443c01a7336-2b97c482bc7mr21062645ad.31.1777361563868; 
 Tue, 28 Apr 2026 00:32:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:48 +0530
Subject: [PATCH v4 6/8] env: scsi: Implement partition type GUID lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-6-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=3571;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=gyxq1cM7icXJKBWHSmqo+dS93WscLISnfug6uY5QpIE=;
 b=S7WSEH1y1o2o//k63PNGrl7s/7niDTNhnpgclFtRZO9xtJMpiDcn5CKVKV5abfOHdSNqJKxuW
 2irtBFBf2mYCQQ/IGg6BIvvLnnKzdqIPkrMgNhwphCfhGjYKj/W8uGy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX03QvLUeTd3ZE
 kTzSLsek50kakSQNOgDoPsiQ5b/k3fSYUtK8vPUAl66ostzS44jyEXWbcvC0RbgfEFKd9cn0ydK
 kXHWS6h8hGWkTa2wEWM7spBXVMmzP3t7niRZFd0Noq4R9mBw4dRPccjA7gy2nzxfw1Sdmrcs+vT
 aanF6YV2lOG3j3oIQ6nrqb5RZ+jPhDNoOJeKt1Mb48PUQnB/ygKIGcO8EWiUY8mSSk0LpPF7yko
 k0R4S7S+5CIUaWRRYOwDOg6gxt8SScsnxVK2osy6Ej8xpeGRI5jAQCynHd8+wGPAT38UG0+EhIn
 45a29cgjBaKBSB8h1ELEGKDmVZE2KLaOYj5xMSvd3Z55GXBs9s/qsR2LkihQoBxkojUhIw5w9aq
 eoX3+Gv2gWu8r3SpMrxojbyt93fb4Van2mH9usa1Kk2zaJvwYgR+u0Q86qXZ1iszSuj3TfkYdOL
 ih5RcdGZe1uIWJlyPCQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0629d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=9j1fX5knQuk3s5Zjpq8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PH52JT52HO130PX_NfqddmCcRGAG-Xz5
X-Proofpoint-ORIG-GUID: PH52JT52HO130PX_NfqddmCcRGAG-Xz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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

Update env/scsi.c to support the new partition selection methods
introduced in the Kconfig. Replace runtime string checks with
compile-time preprocessor conditionals.

Implement support for all three partition selection methods:
- TYPE_GUID: Uses scsi_get_blk_by_type_guid()
- UUID: Uses scsi_get_blk_by_uuid()
- HW: Uses blk_get_device_part_str()

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Has only changes related to Refactor env_scsi_get_part and
  env_scsi_load functions based on the choice configs

Changes in v3:
- Introduce a new choice config: ENV_SCSI_PART_USE_HW for
  ENV_SCSI_HW_PARTITION
- Refactor env_scsi_get_part and env_scsi_load functions based
  on the choice configs

Changes in v2:
- Introduce a Kconfig choice config to select between UUID-based
and type GUID-based partition lookup methods.
---
 env/scsi.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/env/scsi.c b/env/scsi.c
index 91a6c430302..b170f4ee0c7 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -41,14 +41,17 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 		is_scsi_scanned = true;
 	}
 
-	if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0') {
-		if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
-					    &ep->blk, &ep->part, true))
-			return NULL;
-	} else {
-		if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
-			return NULL;
-	}
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+	if (scsi_get_blk_by_type_guid(CONFIG_ENV_SCSI_PART_TYPE_GUID, &ep->blk, &ep->part))
+		return NULL;
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
+		return NULL;
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+	if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
+				    &ep->blk, &ep->part, true))
+		return NULL;
+#endif
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -95,20 +98,24 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default("partition type " CONFIG_ENV_SCSI_PART_TYPE_GUID " not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
+#endif
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
-		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
-			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
-		else
-			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
-
+#if defined(CONFIG_ENV_SCSI_PART_USE_TYPE_GUID)
+		env_set_default("partition type " CONFIG_ENV_SCSI_PART_TYPE_GUID " read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_UUID)
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
+#elif defined(CONFIG_ENV_SCSI_PART_USE_HW)
+		env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
+#endif
 		return -EIO;
 	}
 

-- 
2.34.1

