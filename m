Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA7FE7718E
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C097D80435;
	Tue, 24 Dec 2024 17:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KW7gYCoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2B2807A7; Tue, 24 Dec 2024 17:03:31 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D8D80352
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd01781b56so59343996d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056208; x=1735661008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAvA3mshwMDIE2JTbsGU2Gtir9eGqQna61gDRPthwZs=;
 b=KW7gYCoMsB+q91gnUaMgKJQtHyb3rayeL17b2I/I7VKkoPkF94q/YzIStTEDuzLH9O
 zqOsivDgn4IspTMeOTZIWzjaxewUHzL2lRi0zsVbC9/A1ax+J8xZsjU4m04VrSOaljFb
 3ZQLJCPhA3WAwCZDSP4Um4OuutRlu8ufKsexcfWbnNKCM1PkwqQQa9bltC9ZuqiTTVGh
 OEMaOFJHj+FPvwGMdSN3xqP6Efsps/SIUJfqwXbHnZsycc1vox4jcvSR1gTl0bZKbKWB
 aIeSohkCkLEQzVWsHYH+Zaqnb7LbjDVvbToyx9w7oSrACX3tud4Fl6lUJ+k7tJZtu67u
 5XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056208; x=1735661008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAvA3mshwMDIE2JTbsGU2Gtir9eGqQna61gDRPthwZs=;
 b=g+xzX8V3w1MH0xhckxRn+nPaRLwy0hQLifDFR+AccxAJHlcbjvabREUpkFfruGbfjN
 to87whRSRDwkOGV4LuEDtr5/kcjxxEWUA5fRv4wpRbNa8JSF339d+u1I+z7LmXRl8aaP
 53N5KysPSREAcNE4hOQxtGa7Spa1d82Ow/ZigKKXjIIXQFHk9w7JBjf2s5AYKF741Hhz
 /ngjtxhkZNkf2z4iLxBDWOWI2FnWAXfq+mCaQ1kRrUIGRA3zJ3Sl4e25H9F5l0RX327i
 PvPs4cceC67PW4ZI+R4hhDXTgwAscrPZxxJ5ZnpJaT8C+ryh3gjB25gAZp74Zu9ou7Fp
 1zSA==
X-Gm-Message-State: AOJu0Yzn1tzLYsoghVHw36QP8tePoyrBuf20YjDTWbbWoGIULsqJ8Ocz
 8E1ucdxRwPsn6K6/JyCVnLoFF2LtwZyJvDcSBr/tnHcLxSiAROWA9ApWSsanvdOmf/U8ob6iWYK
 G
X-Gm-Gg: ASbGncu0MA2Ld1BkF7hOtXU8z1qG87awpURpLiHCAh/ItOo4YmcVAWHpMpETsqGCUpB
 thLgQexydchTyu9X8M+NQhH4XrMO4jRPIqdX7Li2oQ6hsbSlxtKCBNUhRw+eREoNq6CjsoWj7Su
 bIjFBtYQIdFxaaJwhbYywUnU7GaolO2WTjk+49W2IaFsazZsgu2ACCW0PNuYlLKv0/O01hYMfV3
 YUJfX2976/WbMZ0FpjcLylV1XI8u0Vd6fP9qqBLm4Sb+GmkeBu7RqVu2t22RDIruROdRRHpO8xK
 K1QSDZC4Cu/CRhc5mgoc8aiPGdn1bH8XKjLaqCl4qMysmrkGEv+s4EY=
X-Google-Smtp-Source: AGHT+IEzOzebzWRlWVxv19ChK6jRQzMrRBkV+WJ6BVWVOsVwMAq0WvLosnvOmr7TjJWAsknPwHaO6A==
X-Received: by 2002:a05:6214:401c:b0:6d8:9a85:5b4d with SMTP id
 6a1803df08f44-6dd2332ed93mr321298706d6.5.1735056207558; 
 Tue, 24 Dec 2024 08:03:27 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:03:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 10/11] tpm: Don't replay an EventLog if tcg2_log_parse()
 fails
Date: Tue, 24 Dec 2024 08:01:12 -0800
Message-Id: <20241224160118.675977-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
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
Changes in v2
- None.

 lib/tpm_tcg2.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 6c72688b80..37818fcc85 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -359,7 +359,6 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	u16 len;
 	int rc;
 	u32 i;
-	u16 j;
 
 	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
 		return 0;
@@ -398,40 +397,51 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
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
@@ -439,17 +449,13 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
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

