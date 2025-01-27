Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299C2C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D169A8164D;
	Mon, 27 Jan 2025 15:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HcTbv2KL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7789881658; Mon, 27 Jan 2025 15:59:31 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1449281276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467a3f1e667so27398801cf.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989967; x=1738594767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPk9hti6U2nb/FQuWp3zk+r8Y+eUVxWb32Ww6HdYpBA=;
 b=HcTbv2KLzp4Pmnh5xr0owXF+3qS+BmEOklP+0YIz7HArywRctIRGw5hYcHBnRPcr/r
 IeGMIWED4aGO2m8aPZgtdGk4LgflwV6vXOxjcdeUVucJJy+3wjp7OrnMpvE6UTqfm8oK
 Laekbv9z2JMdeGqzoooTSaNB+WVEQAaDsF3qmHF4kt3nkFu87XLopQxqpW/WSbbRN6E+
 JQW0pBcV5ffbg1/peMjiqnK8RGCR0JfU0+ZEBiBaloMof+PjEOPC/Lf7/hN4bw+T3FZC
 ovm1dDc+3POzZa77Nmdu89A7wqpMHZWhLHqqu/Krve2/bdoBmDtGUcmAUlUpnKEN0sGF
 46Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989967; x=1738594767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPk9hti6U2nb/FQuWp3zk+r8Y+eUVxWb32Ww6HdYpBA=;
 b=scDRtYn4ASUuDQGmRdTgL4lHafm9deo2ACkG5jgZl++acbSw158WgOlR4nj88lcH7z
 cLsoMk+zwI5lh9YDSxd3sm5GyyYKm9JpOBHI/XkLzRDn4eO2MmuMmk+HAspfHzTl2PPb
 O9zanxvz6tJzrEJBZKkr0sA1J5FUkWaOM5rtb578lmFzNSPH/i//XQ4gFobEzL/LuQ2o
 tM+yGZSlR50domUP8F+nbRBhaY+6P9y+kZQXxQQfMSOgqSV9/ADB0IBMDlEqbUsCTYvY
 4942cZyMB4AcQjlU4XwSdYzG27CTxHDJb0YOf3d2ebUEdtG/lm6qGuKea4Z9FRdDeoYf
 F2tg==
X-Gm-Message-State: AOJu0YxMm5dbV+0+O8l8fa2yjJzh1KF6Cke9ZKvxsFQgf/N/dDtwNxUA
 jbvisiTobx3OzNbPDgZOnt+QE8pkmPoelJpH3PS+WIAYhlPzMR4Wv/6v5uyeeAu1sQH0ELkIFY4
 VhAU=
X-Gm-Gg: ASbGncv0fBRl+D/xPYRw63/Zy5LsQ0mMP8AFxbsWlV4vtg7nJE2TlBk7gdsrxvekc0w
 7vj+qQalxoViOxGAhlC0fD1KpfvI0Zn9S9uPziCydYjfgUUsGhdaxj1d/iLk9JbNAaXcKrwqTG8
 U4mwTf0rcR02AMcmCrtxGQR9+8AtWwV5P9T13UwNljy7xgZ+4jpox4DHOzNtMs1TfB+Z6MaYMZk
 gIWnVG9meWLDVVUePmGETJTsNf3ASx9gsa1EL5f3wAuGjuG9TqOaUp6aCMGTxq+Jpr2FqbgXGGi
 B9BH8QVfICOadI7hry07Y6JllqOdcaOjt+RQ0fsJkBxLCtv+BiGwFSvww8S/gqsysihf0PY8m+y
 mINM=
X-Google-Smtp-Source: AGHT+IEvhBfhQ8OxDSlfuoiHykRT0VjpsqfNae3A+5+QKo0xhCQQbdJgm6aCEaHx+jAOLqGoBlnLgA==
X-Received: by 2002:ac8:7d52:0:b0:467:70ce:75e9 with SMTP id
 d75a77b69052e-46e12a96eacmr585111601cf.23.1737989967427; 
 Mon, 27 Jan 2025 06:59:27 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:26 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 4/6] tpm: add PCR allocate into the eventlog handling
Date: Mon, 27 Jan 2025 06:58:49 -0800
Message-Id: <20250127145855.645845-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127145855.645845-1-raymond.mao@linaro.org>
References: <20250127145855.645845-1-raymond.mao@linaro.org>
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

Get eventlog bank mask when parsing the eventlog from previous
boot stage and invoke PCR allocate function based on it.
PCR allocate will be proceeded if any dismatches observed among
the active, supportted and eventlog bank masks to re-configurate
the TPM with the proper algorithms and reboot the system.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
changes in v2
- Replaced with the renamed API by patch 3/6.
changes in v3
- None.

 lib/tpm_tcg2.c | 52 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index adb32a14f0..c314b401d0 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -359,12 +359,12 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
 	return 0;
 }
 
-static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
+static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog,
+			  u32 *log_active)
 {
 	struct tpml_digest_values digest_list;
 	struct tcg_efi_spec_id_event *event;
 	struct tcg_pcr_event *log;
-	u32 log_active;
 	u32 calc_size;
 	u32 active;
 	u32 count;
@@ -375,6 +375,8 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	int rc;
 	u32 i;
 
+	*log_active = 0;
+
 	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
 		return 0;
 
@@ -420,7 +422,6 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	 * algorithms, so just check the EvenLog against the TPM active ones.
 	 */
 	digest_list.count = 0;
-	log_active = 0;
 	for (i = 0; i < count; ++i) {
 		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
 		mask = tcg2_algorithm_to_mask(algo);
@@ -446,17 +447,15 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 				algo);
 			return -1;
 		}
-		log_active |= mask;
+		*log_active |= mask;
 	}
 
 	rc = tcg2_get_active_pcr_banks(dev, &active);
 	if (rc)
 		return rc;
 	/* If the EventLog and active algorithms don't match exit */
-	if (log_active != active) {
-		log_err("EventLog doesn't contain all active PCR banks\n");
-		return -1;
-	}
+	if (*log_active != active)
+		return -ERESTARTSYS;
 
 	/* Read PCR0 to check if previous firmware extended the PCRs or not. */
 	rc = tcg2_pcr_read(dev, 0, &digest_list);
@@ -553,43 +552,21 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 			    bool ignore_existing_log)
 {
 	struct tcg2_event_log log;
-	int rc, i;
+	int rc;
+	u32 log_active = 0;
 
 	elog->log_position = 0;
 	elog->found = false;
 
-	/*
-	 * Make sure U-Boot is compiled with all the active PCRs
-	 * since we are about to create an EventLog and we won't
-	 * measure anything if the PCR banks don't match
-	 */
-	if (!tpm2_check_active_banks(dev)) {
-		log_err("Cannot create EventLog\n");
-		log_err("Mismatch between U-Boot and TPM hash algos\n");
-		log_info("TPM:\n");
-		tpm2_print_active_banks(dev);
-		log_info("U-Boot:\n");
-		for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
-			const struct digest_info *algo = &hash_algo_list[i];
-			const char *str;
-
-			if (!algo->supported)
-				continue;
-
-			str = tpm2_algorithm_name(algo->hash_alg);
-			if (str)
-				log_info("%s\n", str);
-		}
-		return -EINVAL;
-	}
-
 	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
 	if (!rc) {
 		log.log_position = 0;
 		log.found = false;
 
 		if (!ignore_existing_log) {
-			rc = tcg2_log_parse(dev, &log);
+			rc = tcg2_log_parse(dev, &log, &log_active);
+			if (rc == -ERESTARTSYS && log_active)
+				goto pcr_allocate;
 			if (rc)
 				return rc;
 		}
@@ -616,6 +593,11 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		elog->found = log.found;
 	}
 
+pcr_allocate:
+	rc = tpm2_activate_banks(dev, log_active);
+	if (rc)
+		return rc;
+
 	/*
 	 * Initialize the log buffer if no log was discovered and the buffer is
 	 * valid. User's can pass in their own buffer as a fallback if no
-- 
2.25.1

