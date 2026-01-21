Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA60D262B0
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E877D83AB7;
	Wed, 21 Jan 2026 07:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yj/EWRiN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TP2L7cos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABDF82A9E; Wed, 21 Jan 2026 07:39:49 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F4683AB7
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L2XgwJ825361
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzGLSXqbT8z
 69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=; b=Yj/EWRiNPZjLX2anRhRBDN/Ss1r
 s2RKrlrulj7GWOBbTaYskERlz8/NpvyZKM+pYTLg16seZJE7ncazcxiFUPVM9PQq
 GBQ24Tz2o0kEe2HJmeaDxOzAnoRL+YMk/Ixuhz9+T39CIIywL+ZcXAb1GgD3I++Y
 G4E6yh6bDCcJokbqaRoP4yOaY40ZP4VhCE7dVTDwvHNKpKxev+D4j1mySDApkl7K
 ctgA9RfFWQlphwjmsJIT9XYnFkJ7R/yvkfvCxAXBT7IhZkEhinqsFe0X93cE7QE/
 ls0Lu84hKujfiuaqmDNy5wAdmIYQx1BrnBAss+KCExk2WGNk/MLQW2++oLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e2h5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f25e494c2so8787635ad.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977585; x=1769582385; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzGLSXqbT8z69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=;
 b=TP2L7cosVmB4yQb2nwZCIdFy95EnZTh5iIMb3HenNln6DHQ78Le5jKNzxwl0oYalm4
 9LchkLf3mgQ1lAFXuNyFKc9SVnkzsBq17RG5huHVUEkNUQsJEn54mbUS6YfGCio4j/DR
 p/68fsZsDg6T54sOq4NPKnKT3urdAa98qHh/MND6EBu6GJmfHJNs44uUiY9kbbH2lQK5
 KhO1iS2hpz1YfPCprxRiap4583ECsADQSeNQX1ILc78oB0fwO28yTs5ghHQ4g0YNu/n2
 swfIM/EBo3HwLDvKwlWuN3spRimGTtKK2/E0+7w2PHQF1H8iUhzcaIqFds8LR4XwnqeC
 +c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977585; x=1769582385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzGLSXqbT8z69Hf1/36j2DkRicklfRFY1LAZVUn+Bog=;
 b=rk/4CfJFg8JYPfNzpioxaWPI122L3zwCsmtxRm9WF9paVMX9MN9bhaZmaQ4RAAHb9k
 ENxWbZ5yqp5YYtQgwHykIZeyKCDk1mq5si/gs9xDBbjD/iad4bvgtuEoH7NmdO4Jw4Lw
 MKuemgd0VioOUOHhnpTNB0LGZYaFKKoOpB88tNJxuFfoxoVjesD7tvbdv+oQlQUVtYev
 e/TNsfQ0qWvjjcVeuQWIrLJgaoIvYiTBtBXnbQFRd/AK5wostZfZatbVq+I0TbvvnUN2
 oGCC5cjCTnolPg6WP/xGblIQmiXkec9P3nxvka3cNLhbswwqMR7TG7JKmDtmnq6kdzQh
 MwUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3tEHBu/DCkmbuFy0gVBAXDaIprASUhnLKVBJy1XQL161s9RhUNYUJ73b6mmwM40ofV92M1E=@lists.denx.de
X-Gm-Message-State: AOJu0YyF69Be+6Dms1xaqRd6wrlAgWIJk/v7HJHZQtID2fOYwzYxfzst
 T/aKbDIf6QN5s36Mm+2Dfc7lCkRdO2a5kAwAGXc6Osyx/JN/t4HUfmOJO7S7yPU+1imEO+RcLVi
 ms4xyG0e4ZsbTqhQySVH+dxtZRofCwoYVMoHuAdNioYuqbrziJ9B+2O59
X-Gm-Gg: AZuq6aIS2YFmHeATWdnUGelHhslEk34Dq0esR+OwIRFjL552BYGsJkJ+d1bnJ6SJ8DC
 ZyHRlW0YfZX56ZdpzWbcvy95vbL2rYjet7ueiZa8hWOn1c37qORSb0K4ogtij0nWJzWE0VvIo1l
 gwGJGJZwLCBeaOhTOd7swIZ1tsDWJbhjYTlrTkTId/3Oi9bGuC8/bGeyV/Y467nbb8NzoM+EDE6
 8Pqn/rwhDyZsx5SV3DMs3S/8NfO/O6sM5Xno4yVXBDaQn28IjDmDZRmaMIQTiIMosMPnJ0uZH5g
 vp3ZrQofIYAY2civ8VjP5uYTiOc20u1jn7rBUljFBan2fSEDO1CiGIaf0EekLmpzsgDAjBLn8qS
 fBJdbaIt76tmB8Azetw6XIqYwLJvH/+rV3K3tsEuq9FuSdZiQ/zUIRwOkTchaY1e4ZA1n4k8REW
 FDHCBRd9QdQ7B8T8O76NaEZ8PLEEHWhq2A/mbcJKY=
X-Received: by 2002:a17:902:d48d:b0:29a:69d:acdc with SMTP id
 d9443c01a7336-2a71781fd8emr138624025ad.25.1768977584897; 
 Tue, 20 Jan 2026 22:39:44 -0800 (PST)
X-Received: by 2002:a17:902:d48d:b0:29a:69d:acdc with SMTP id
 d9443c01a7336-2a71781fd8emr138623825ad.25.1768977584431; 
 Tue, 20 Jan 2026 22:39:44 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:44 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 4/5] cmd: boot: Add '-edl' option to reset command
 documentation
Date: Wed, 21 Jan 2026 12:09:19 +0530
Message-Id: <20260121063920.1500293-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=697074b1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Mf8A1FuHfXW03_C84bMA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WJlpXmWfPeYJWnUmw8SBkWDOkrPYWxNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfXyWbjCOb0p1Hd
 12eNjarOUqy6nrfnkzTNy7EF757Uxb6pZpbwSHac5pNQF1d2SKqxq32zbwbQF/Wydu/ItXSwvyy
 ZLIZjqG0/vJhe5lNUlAz4+LYVRzgD7svymlV0lzXZZJft5Tm5qMRYdExKHkk0kCAJEWRefWPdFQ
 +Kdv3m0rDnwyErwxQK/x1cvJHu8Ub0rv//DuQvufmPSwl5srZ73+T1cVqa0htvCLqJjGzbevbgg
 eI1Q5TVDsuDlWlFG3rZW9uO/EMiqt6lo5PCfCMIKj9k6TNJLzSlNPIL0572KOkHZ9L5KaFkMTPe
 Rv1dMSPKtsxKiGUWpsst1guehYUNXQmBSsLKDPhxpPiN1JgHkoqpelWYWgyXNkZleSAer0YzTVn
 kPPVhhM6eYA6A2VDYDa/sN8Zlb/w/9+8P01CErYPh+u5g+c3fuSVkq6lpOlH0EvLBKtOYxxlN2X
 kXD7ny1FMtLSWc5xidA==
X-Proofpoint-GUID: WJlpXmWfPeYJWnUmw8SBkWDOkrPYWxNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053
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

Add help text about '-edl' option to reset command definition and
related documentation.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 cmd/boot.c              | 3 +++
 doc/usage/cmd/reset.rst | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/cmd/boot.c b/cmd/boot.c
index 23496cafdf5..d80f9d8c05d 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,6 +60,9 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
+#ifdef CONFIG_SYSRESET_QCOM_PSCI
+	"reset -edl - Boot to Emergency DownLoad mode\n"
+#endif
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 126db21cdb8..366b17eea16 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -22,6 +22,8 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
 
+-edl
+    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
 
 Return value
 ------------
-- 
2.34.1

