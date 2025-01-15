Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C21C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772B78033D;
	Wed, 15 Jan 2025 21:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JybKHmVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEBF80214; Wed, 15 Jan 2025 21:02:37 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FE580714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b700c13edaso5764285a.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971353; x=1737576153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSaedYO0eEMcHcnFxYsqbxhfWt7c1YAyS/zkFgb3uC4=;
 b=JybKHmVrU7A52cMSaiUXcG7MwN4frsQM/Lcp764KzYYz1P+lkJtd6P9R3rC0Gk+6DM
 Vu/NiK/IFf0fVyuW3/mVmMxwzz1JPEn94pOud546qfpIKc3UzkQ6WE00KMb/Vp3jUBtL
 7R/VbJpRXnZq2YK8DCQEt4UR2Ww25wnm02IbWbFJZQrRAbFZFBB8MNnXUWh9/yxu+P8f
 ZHuABrtCT92Ksvlso+mOJOYzwwpG1so5F57lfWIbKmEBNjK5ImSnT8SmNpl9qOyt8DGP
 pqIadD6fJcAhWPAtDEFlCYqNm8ngPs7CHDzQ7hlmyaf0ptPKiy+vTMkQ3bFg2ISvZErB
 7s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971353; x=1737576153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSaedYO0eEMcHcnFxYsqbxhfWt7c1YAyS/zkFgb3uC4=;
 b=ihHMLTQtb6NOVdt/f1JEZ3Z3jKDPGEsFtdanXcq07j4NhVWjBeDFLuKszO8CKjSNfg
 OBdKmfM453aEcKiEaFVLFVvMdmGsT02XWpyQYqeGwUBHVmxOu7DtfyRYmLXk3hvW09YY
 4+m2+cJghg5mKBSOIPoT7mrX35SFGbcTHduDcjov57HUcUU9seN2h+QVQtLn0AD+ml0i
 5up+YZmphuwdk5WchI1HBwkNwLLRQ6yOw5o7A+MiZB0Zi2XKjPTTrcGdn/QH/ivz+av6
 iMAyoWsh4SSLGXqLecoih0QkVJJYPtE3FRN1aQJy0j1A9qLaChw7I6RGZKGjxUZ9/FxU
 Ugkg==
X-Gm-Message-State: AOJu0YwE1vciMXholbQKZ9JJ3aVlIKqdCmnvzqso5a/08ZVJVaUO0hLr
 HxYW1K3HSrVvr/iVc+lMzVIBaEjW6uoVJ9KlqScCImH6yMWifCERPfsLSG6dkPI88xdYi/I3dt2
 ngcg=
X-Gm-Gg: ASbGncv5qJHaBGpCCXmNVLTNNE6wPO8F8gOfQuxhf2A+DESpY+JE2XiHbYqRr1P8Cpd
 xWO1yOsn1bbTB2l9TZ379j5k1RV2kUoiwJ2s5fipMZlFMbGYlNFZvx+AgWKWWDKxTJaJIIv9Mrn
 7a8NH6TCVirmmvFs5WlKYj0KADyNdbAL80qVBuItMO45YTDAicMMUtcC3A24MJuCvhqAvvNtUjd
 pj3fG0Su0TgRFU37oJhkIU6rJrDFaAQf894pZwmD7koMDJ2d9C61q8/yuosRi6zS964ijeW5hPW
 DCY9qocbqpTL/9qbPsHmXniDsZY+Tt3TOJlWMXHhEQHbGIzzyIocffE=
X-Google-Smtp-Source: AGHT+IHAp7cAvvTEYpAUaD/+W3bQzaryG+W8Cc8Aa9MnFwG/5KcfVeTBWvIzkWhbQ2q4R8omPkht3Q==
X-Received: by 2002:a05:6214:5789:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6df9b0fbb4cmr475527556d6.0.1736971353304; 
 Wed, 15 Jan 2025 12:02:33 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 4/6] tpm: add PCR allocate into the eventlog handling
Date: Wed, 15 Jan 2025 12:01:38 -0800
Message-Id: <20250115200144.951530-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115200144.951530-1-raymond.mao@linaro.org>
References: <20250115200144.951530-1-raymond.mao@linaro.org>
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
---
 lib/tpm_tcg2.c | 52 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 2d9076f091..fd84045d8b 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -360,12 +360,12 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
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
@@ -376,6 +376,8 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	int rc;
 	u32 i;
 
+	*log_active = 0;
+
 	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
 		return 0;
 
@@ -421,7 +423,6 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
 	 * algorithms, so just check the EvenLog against the TPM active ones.
 	 */
 	digest_list.count = 0;
-	log_active = 0;
 	for (i = 0; i < count; ++i) {
 		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
 		mask = tcg2_algorithm_to_mask(algo);
@@ -447,17 +448,15 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
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
@@ -554,43 +553,21 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
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
@@ -617,6 +594,11 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		elog->found = log.found;
 	}
 
+pcr_allocate:
+	rc = tpm2_pcr_allocate(dev, log_active);
+	if (rc)
+		return rc;
+
 	if (elog->found)
 		return 0;
 
-- 
2.25.1

