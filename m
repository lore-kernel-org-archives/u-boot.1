Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D000C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2753080717;
	Fri, 17 Jan 2025 17:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WfKgfRvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD1580762; Fri, 17 Jan 2025 17:41:07 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC6080756
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b7041273ddso169131185a.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132063; x=1737736863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEmhrdM2mDeOXb5DTq7Dn/XfZHixYS4PQkukVGYaI4U=;
 b=WfKgfRvLvr7A0LQ3Htxe68fuDQKC271jDxuhcQlE+xNC5L9V2bms0KHEU77BtnmxFs
 HstfJpAxaIwzG3lI6/6tBhIHVgvXy/ppRli3Th5TbZDfORTQPZCkHow3sqg7WdjMwCA2
 CP+2ZetFb/KTL7OCzoZ6Heczv68UI/MQijOeX2s0ShjDGoUoX1YWjYYCIhK2ty9Um3le
 wHg3iDqYAoTKzggnQUEzRD2lknVkNaqqpzZ4Hd7irYe3hYgXmdAgtGa2oOeWu3MTyJEn
 gf18dYOT6uPXCtxWzkfyIlIKwt+HV6I3MMs0LX+IhyvQc+XhTooSQ61F8tquUwi5kOu8
 3dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132063; x=1737736863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEmhrdM2mDeOXb5DTq7Dn/XfZHixYS4PQkukVGYaI4U=;
 b=hzaaKp13hHSDfeTym/PKIWXVENPvwXRI6WQCcR+xG0e6+8AZCK723NRa2vlv++c96P
 QiG/6SsENAoFhs+s/5O1hmOYSYMiWu4tZVF3+l6poSXsNzBgA+Biz9H5UnzaTPc964ux
 piCXVPutpdmBlXISeCI2ouB4/ilDqgmfnAfOFnJ+8t/Sb0YMpb7Cjou/wiF1Pl2WTEh8
 ZLgWXWbzpFwte9X87Ab4l9bRU6IUQGYOXrVDmIvpsu4tMUaO3+sPluJ8YZhBmG2o22ET
 gNsAVP7lNa/2LQW7HMWAogmeWEkBFoqvVYItL2Mjwd0QTyr5QU2cwOgg3GaPAYKapR/I
 AosA==
X-Gm-Message-State: AOJu0Yy5E+nncLtxsYC+DKaWkuODklbinb20D+FgC8Y1YYQabMUfB3RU
 QxHmb0M5bkRuavaTDoa/D8pa6lLEXTxAfJz7VwwEZm9dD74vO3bb1HWESiaZQyDpGRJ86K31Ax5
 Y4NM=
X-Gm-Gg: ASbGncubEAmwU7ipRTDhviqK9OtBNdhz7igmZMT/haQ8Y92W7w2gvf9mboaG/CduOZW
 O0KtuvGhv891CnCF8iCWzEnjOAAWjMPvLCn3hJE+sUMlYS9FEKcIRdz3axYFxRJGRpCVMWonom6
 LxyA1Ap304zv6hbWk5180jzPs/C+k938TYxZyRul3mMRwSCN0jTzgm8MC3PkyApNQP/a+HdN5+g
 PDnLRO7GnjUn/OoBo+0e/5IjuhqBJSU+QS4DDEhEA9okI5Co0XVun/nnYmUcnF5GGATYTLThbqe
 2Qcu1sSuLS7cXRwxYgBGvW5xr2LpDHjf5v/SFCcczLFvdr9YDHG3sA8=
X-Google-Smtp-Source: AGHT+IHDb9YM0HnEUPB6H5x4uv+5TaKmGx/XAK7iZQWHHLBku5FTVUWHqvXImqZ2rzTBVscdsVoWig==
X-Received: by 2002:a05:620a:4094:b0:7b6:db05:1435 with SMTP id
 af79cd13be357-7be6320c108mr603047285a.10.1737132063622; 
 Fri, 17 Jan 2025 08:41:03 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:41:03 -0800 (PST)
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
Subject: [PATCH v2 4/6] tpm: add PCR allocate into the eventlog handling
Date: Fri, 17 Jan 2025 08:40:27 -0800
Message-Id: <20250117164032.88942-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117164032.88942-1-raymond.mao@linaro.org>
References: <20250117164032.88942-1-raymond.mao@linaro.org>
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

 lib/tpm_tcg2.c | 52 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 6425bf143a..6ac4237484 100644
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
+	rc = tpm2_activate_banks(dev, log_active);
+	if (rc)
+		return rc;
+
 	/*
 	 * Initialize the log buffer if no log was discovered and the buffer is
 	 * valid. User's can pass in their own buffer as a fallback if no
-- 
2.25.1

