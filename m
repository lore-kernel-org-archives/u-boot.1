Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A3BE7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A1480730;
	Mon, 23 Dec 2024 15:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RDLnNOr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A53580771; Mon, 23 Dec 2024 15:49:01 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CD080730
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d884e8341bso30471186d6.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965337; x=1735570137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA4bRXHpTlUiA/sjarTwlVmTFN4dNXhUiDJjvTP4O7M=;
 b=RDLnNOr3Rx+c2w8r/oM3+PWMskabrcETiEX9p9TgKI4V3hZs3+YHiEQRUHm0v8uUNW
 Pz1CNz475BD27kIQ45Sm83tCfFcJ8PigZZvgiMYQamyefitRJlNkMaCuTQu5HbbojAvW
 Q1ZPjEcB9xMF+9dW+4+IwR1lM2QA4W7fSDC09wfGWAs0sa5SW6QE/Ol0TunFOhaQIvMz
 RBfxb4JY4uC7j1m8BFB+Tnq6hCt49LC4ZN9ikkUChyFL9g4oRofPXc8+9JLIazm88CUH
 KFgMo946yrSLC+U75ngdE08GzNpq6KTZpckZBsAaFKAB6GLRisS4uvsRJHGen6vOKYXw
 O90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965337; x=1735570137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA4bRXHpTlUiA/sjarTwlVmTFN4dNXhUiDJjvTP4O7M=;
 b=E2PrdGavTM9MFHxmH0X52RRo6a0a3f4pc0hdjtOzQjdQbWfqeTb2Gfzi910ZLCXx+l
 S/+wmGqX7VazxU8J8/z7wtEQ594BYhacqL1WoCJSc9IKhmrgxReiQTLYBDsVGEHWQxCn
 bZjzr0Qh8C0hf3xl109yQrmaEezPbG7CIzmJTmjRsN8fp637eM29zp+bVHXgnFBPqn1R
 wl+MedhOh+nyRi9xqXOuLVFS7OVPXtHpwLNJ91oSXtxgv4uc4iwV3y5qLI+pb3vOkEQN
 SovLJs9cEutXNFAmnvZt6w0BBQBkvFY6NXM0ARguwaz0LHDKF50qFl8EV+fytymenhhW
 8gZw==
X-Gm-Message-State: AOJu0YwjV1LngFDSV7CDmK4EX7spmT0bv+bVHjKN0pSgOZBxeiTmRpEI
 UISfuCrwnFVwYJWciL9wwN0JSOcTDmuUAtbMkro2L3mo6tukdNfarVwb1+mj0h1+USzLOFXB4IW
 D
X-Gm-Gg: ASbGncvlnIWQlFyrjtRdqPwhytv5Hasa3hvrTgyOrCWtSRuZ/cPh2n6X2wccek0qm9D
 Q+7v8+ySw7QiaNanPm2OLQp2MwJmpxrzZRosTxsJ7nVMwf9z5aLLd0JhOui1r0OFDe+vTwnmjVA
 11q4cpligmaNX2m1iW42lEH1GA724d3OC+I/vfPIHMtoZm8OdgseIEATnPqtrAC04nvFF4mcfG0
 UbTml5DVy78Jhk3psyrI9dUoqs6V2VJKYwFCjIJ9UUR8EABG8h2wR3cH33tJQNBbEE5GOerEvH4
 cbIiEom1bjFKDIptbZDlABndCq1rbfU/WZr4mbsWuhb5rqsP2ZgbyQk=
X-Google-Smtp-Source: AGHT+IG7jUUZvZsWfupWw4iPESWj/AbS2tzASF6KnFkEQIwNXmaVmdkdnfjiUMGD7e7SQMQGRfda4g==
X-Received: by 2002:a05:6214:5f11:b0:6d8:9ab7:adcc with SMTP id
 6a1803df08f44-6dd2334b26cmr210420676d6.22.1734965337242; 
 Mon, 23 Dec 2024 06:48:57 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:56 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 10/11] tpm: Don't replay an EventLog if tcg2_log_parse() fails
Date: Mon, 23 Dec 2024 06:47:32 -0800
Message-Id: <20241223144737.554992-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

We used to stop replaying an EventLog if parsing failed, but that got
lost in commit 97707f12fdab ("tpm: Support boot measurements").

When an EventLog is passed yo us from a previous bootloader, we want to
validate it as much as we can and make sure the defined PCR banks of
the log exist in our TPM and firmware so we can replay it if needed or
use it as-in, in case the PCRs are already extended.

So let's add the checks back and while at it simplify the logic of
rejecting an EventLog.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/tpm_tcg2.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 72969923a9..64563d7871 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -360,7 +360,6 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	u16 len;
 	int rc;
 	u32 i;
-	u16 j;
 
 	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
 		return 0;
@@ -399,40 +398,51 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	if (evsz != calc_size)
 		return 0;
 
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
-
+	/*
+	 * Go through the algorithms the EventLog contains.  If the EventLog
+	 * algorithms don't match the active TPM ones exit and report the
+	 * erroneous banks.
+	 * We've already checked that U-Boot supports all the enabled TPM
+	 * algorithms, so just check the EvenLog against the TPM active ones.
+	 */
 	digest_list.count = 0;
 	log_active = 0;
-
 	for (i = 0; i < count; ++i) {
 		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
 		mask = tcg2_algorithm_to_mask(algo);
 
-		if (!(active & mask))
-			return 0;
-
 		switch (algo) {
 		case TPM2_ALG_SHA1:
 		case TPM2_ALG_SHA256:
 		case TPM2_ALG_SHA384:
 		case TPM2_ALG_SHA512:
 			len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
-			if (tpm2_algorithm_to_len(algo) != len)
-				return 0;
+			if (tpm2_algorithm_to_len(algo) != len) {
+				log_err("EventLog invalid algorithm length\n");
+				return -1;
+			}
 			digest_list.digests[digest_list.count++].hash_alg = algo;
 			break;
 		default:
-			return 0;
+			/*
+			 * We can ignore this if the TPM PCRs is not extended
+			 * by the previous bootloader. But for now just exit
+			 */
+			log_err("EventLog has unsupported algorithm 0x%x\n",
+				algo);
+			return -1;
 		}
-
 		log_active |= mask;
 	}
 
-	/* Ensure the previous firmware extended all the PCRs. */
-	if (log_active != active)
-		return 0;
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+	/* If the EventLog and active algorithms don't match exit */
+	if (log_active != active) {
+		log_err("EventLog doesn't contain all active PCR banks\n");
+		return -1;
+	}
 
 	/* Read PCR0 to check if previous firmware extended the PCRs or not. */
 	rc = tcg2_pcr_read(dev, 0, &digest_list);
@@ -440,17 +450,13 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 		return rc;
 
 	for (i = 0; i < digest_list.count; ++i) {
-		len = tpm2_algorithm_to_len(digest_list.digests[i].hash_alg);
-		for (j = 0; j < len; ++j) {
-			if (digest_list.digests[i].digest.sha512[j])
-				break;
-		}
+		u8 hash_buf[TPM2_SHA512_DIGEST_SIZE] = { 0 };
+		u16 hash_alg = digest_list.digests[i].hash_alg;
 
-		/* PCR is non-zero; it has been extended, so skip extending. */
-		if (j != len) {
+		if (memcmp((u8 *)&digest_list.digests[i].digest, hash_buf,
+			   tpm2_algorithm_to_len(hash_alg)))
 			digest_list.count = 0;
-			break;
-		}
+
 	}
 
 	return tcg2_replay_eventlog(elog, dev, &digest_list,
-- 
2.25.1

