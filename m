Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBF4D0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A218388D;
	Tue, 13 Jan 2026 11:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OOllXMm7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Is0DojHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD25838BB; Tue, 13 Jan 2026 11:39:11 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B41B8004F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D5hKDw3817041
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vJgGTdwM5OX
 FR6s6Wu3GOD/F4gJVCjIbOKQW6AKobdI=; b=OOllXMm7ixV5MdkAnnLb6mHXlyE
 64YpmjzMgSnkiaz/c+JPWo+W2X/55l4scPbMq3gFNEt9s43n/dAiNyQ8K3rW1L+J
 22JQegOS2csButQHBDjdDz0jeANJlPrKDzklv1F7vi0f68AaWpR6oRJzhHlvYiMO
 lxAW4PhAO3KssN9xuVNRQpt6AxGxqyz3044/q4Ewso9m6zEzrhBPTlmfKv26NiEB
 XxMJsRHESXdkm9Xq5nKXjRFY5WHDvtOIkt4UyKZtw0UTFerKQc232w3vaAeLEpBK
 e8MQaeND6SYTg1pYt8XqGofQQjJRFDaNjdRNB8mkh9rzWJh5iBfJ7T+kNxQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng55rxm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0f47c0e60so38735195ad.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300744; x=1768905544; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vJgGTdwM5OXFR6s6Wu3GOD/F4gJVCjIbOKQW6AKobdI=;
 b=Is0DojHlD9R4XjOx7AMLYBEuW6Sifj4pUX7N4PJ/lsEDNL+YMKQaTKEUokH5ooa7o9
 8F3qzF+iGYdQqpMUW/PZP9I85WV2HKV1bs6lELT8aD5Txv1j9/DyZpcdCEqvoyREo9wz
 4NOrgnO/OQFQNDIq3hOf2slhZq+wxCH3yzotYJ1eZJZ6wCMBKgS1fQ+G5vtZA6YuS7Gj
 4zGmWKrr/G+aPjmKVH6ZwiruX0mfby/QVNIPfSuC1PJ8AYt2WoqBL7ZlwVrhTAk71RFt
 6BXf+PNTuLoAja+OzVQU1F9mcjPYQ4ANjWJjvbHSoECh2sUdSychrCIIo4nJqZmfihAD
 wUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300744; x=1768905544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vJgGTdwM5OXFR6s6Wu3GOD/F4gJVCjIbOKQW6AKobdI=;
 b=jXTAgUAV7B+WWXNn9IKxIblCd04hctgbvt2i0aU/zacQIBeelNTRD6cUij01hURxY0
 z1Nt9dvem7cWDXgbarUK9+XO8KsPNiIEa+bDbq3IIz+rvcBHMQIoXV88JeCowAPiLEwq
 jvkcwwGXQ9ydrMrMJpcvAfG+tQLZl/n47TeU6AiRq6Httx1sFHAjTuGo2b2s15xRzRTl
 5nuOX+u6iwEIHGE6Kn+B+/T+AB6v7zwwOsiaAYxOQxq2e8J3/ZMRbbncfS8KNTr9tfNU
 tWWjVwkAS6qfvAMdcDxbT3bPZExm1sl/5KlzK58bF8EIpJ6g4iI5QSYnKSIR5TaAzhuk
 LLDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXTrivfyrTtMND4NpNky1qWNPAQBSnAEqNWklPnJhcHy2Mq9spudFXrb0ig9BVXQ6Pf1bZvj8=@lists.denx.de
X-Gm-Message-State: AOJu0YzzBcUAh5byFcQ5zJhAYtlG5HV37VuimHInLBUWp2YDSA3kvSog
 /y4ZB8XK2NpGYFhkA+7WONaCV5VV+kM289fOWC49iVNtVPLF2akj3PlcP6Yppf1Ye4Q0+xLKc8i
 HjYU0ltSbO+odfzh2+WB973Y2HHeolrCMwXVebDCEFupOQqEspSYtf5wj
X-Gm-Gg: AY/fxX6sPTmFOUYWROTErb2KSismJP5aZ0wOnNquqB6ueAyT+MrSnTwZKfbwHp5b51k
 NIjxsoPJmIS+XBkJDBdtFL4y9bNU+o1z6l1A9jj7IWQ8X/2pl3aTE081pA1g2e8lX1riZRKvFEw
 IBbNLTVWLPlPTQyacuuaEn/uYp/RCcCWdSbpBBrrYxWt5505/GtXKbDXjIenT4N845kpFy4xBlX
 iL0mU748Q/875SUGaib6Ms+C+Ik8EQOn4Jbz6pGU1tjPN7tBaTZXy8ZeRwuxzGXKDrpxyuQOznz
 qzTds0Hsz5lJ68KEBXRuSF3Bk2zmw9iiHWmzsZ2e3rq64qbyjU1zawLvfhKHnpmSjwuz8fa1NeE
 2tc45OO1gRWMO2YE/UEdzkR6mgQjJUCL+L3AV4+kgenV64fYWT4bKFaZgFIM5XWqMH0xOXXsPve
 GPgJ1ZNfI/myXRkm48knzmBQfseL6F7Y/M+uggTWA=
X-Received: by 2002:a17:902:f54e:b0:294:f310:5218 with SMTP id
 d9443c01a7336-2a3ee346d6dmr204304555ad.0.1768300743671; 
 Tue, 13 Jan 2026 02:39:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY0b72siIckOgs62M97wCWUteHXYHkOkAYviMzMyPh0O9ld76sazNSkGuZhNQ6MRuZRizcnQ==
X-Received: by 2002:a17:902:f54e:b0:294:f310:5218 with SMTP id
 d9443c01a7336-2a3ee346d6dmr204304235ad.0.1768300743195; 
 Tue, 13 Jan 2026 02:39:03 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:39:02 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 4/5] cmd: boot: Add '-edl' option to reset command
 documentation
Date: Tue, 13 Jan 2026 16:08:39 +0530
Message-Id: <20260113103840.1948029-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: T5H1jiitKMOJxLBubpFC4_XR-sYyScyz
X-Proofpoint-ORIG-GUID: T5H1jiitKMOJxLBubpFC4_XR-sYyScyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX10y8HjzQsUwW
 nQNlAr0291OBgVaGvxF8AzyrkKW2l7YFXIaw634DKHe27j7AfrvU/R/qYlzM18ODbjJGvNPddtY
 gyLRnFvA5H+pWLrpdTzmhecBeUUWr5q3co11de1V4PRi9ZMid2OgRA+MZqSoEsqDai9KGqQvrR0
 ouzWNJ5oOLgDOxp6mZkUpjzordk75pLqO5/J7X8bCxl7JZE9inBVH04bzddfBFnG2XQuw34q1s7
 2m2TpGf164J+CYV5Qt6KwJ4j2uY1aqk0RraK/ilYEVIdBym7U71okigHzPNi45KIii/i5rCvjJq
 TdVcrbE0o1fpTkYadfYoYndeyTzvmIi1O9ClG6dGHiFlRd0enBavuSAz8HQlQhltP3fo6uS9yfQ
 nS7WLANH0H6Dhgt9pCbbckpYENTPsGrZrYqrhDWC02hvp9we6rsQVut9LyqyPPzWT8VLLVFQMkp
 YtAju9y7VAD4QwCwBIA==
X-Authority-Analysis: v=2.4 cv=IIsPywvG c=1 sm=1 tr=0 ts=696620c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Mf8A1FuHfXW03_C84bMA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130090
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

