Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782B0E7718D
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1FC80352;
	Tue, 24 Dec 2024 17:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="isKcK670";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3F680352; Tue, 24 Dec 2024 17:02:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A06801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d88cb85987so43222856d6.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056131; x=1735660931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuO4ssy8cSq34X/hITvl0QT65bRxCl3Upur/XNNIJOE=;
 b=isKcK670Hmh0V4zHCwsFojhunlOT7ENpPMQUgyqq4cbheMXfJhQaCa1m1kAzekAYda
 hpAHHmsoIF/pYxFqRJTAlsKd/7JbRYHbjbTQHkQq7p4xZkDQ8spgeSZEASeJd1z7KvqF
 bj6y2F09QS+S81rG7z+BwUDO1zLdPDA/HC6O0GHgP/TA3PTxjGDoeguHPWJvPJptEAWQ
 CsbTm2xYFO7h7EDwuVIGiGaCnWccy4TnyHMFFj1dqGUBnMnl2apNWcBcoAIoPTFTWHaT
 UgQ42xslEyWJhlSrF1Oxx+0DZ+twWAZDkRSdXRoo6MqaH1g8h1uK2rgdxtbZg60IHW3U
 kmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056131; x=1735660931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuO4ssy8cSq34X/hITvl0QT65bRxCl3Upur/XNNIJOE=;
 b=ttTc5tDL5DmFgXfF6+l51+Hc088X+UjUeJYZfr2oFtsdVM5V4DrmppaRWEoaavyJmo
 b21dR/tHxsI+zp0bDBTpPF/3eBJfXalv/R2TBJ8NEvQQy1dsGJ0ZV2lQrcsCGuwwqb4B
 KtYBvDE2cQDl+yhQuxy989/aJVLXCYeASS0wCvbICYwyY7W3I/jhVc1CizJp/uX1z8mo
 qBPpfK1i9rwP6RdkPhNNPA2cUYQLXCLM+tLeyQ5n4MsWruDFP77lmycRG9isF0FKFTx8
 N76raUlcPp+u78VDIhtPIlHzsEziGD3kekMGAIzsKhVds3ILtrDcHpqnvFkWZl6UwXkI
 7ynQ==
X-Gm-Message-State: AOJu0Yz3smvGcCxsZRgbUUoe3b17eiygra2KDUjC3fGQK5TXWsYI+tW3
 t6RFGs5ztGeNI1ErDudD6NQgyYutQ2G880Ycp326Ib+rH059tjedv1Db9cTEt48JxHsoKA9AvOB
 h
X-Gm-Gg: ASbGnctPvMGWykHme9PM4tsazzDjt7mOPh5G7x5fRD4fudi7OQl1kIWKrAMqhmn1WN7
 PpoAm7JtI7NM3ymSQKlz7mcz8Lwsi/BJGJi24RAH/3J4mQxBuBG7Nfi6PmNMKsmb+zcYxIBE0Mk
 puowBO3ApOj+yEkB62UZzrz8igQ0bYNCWGJS2RyOOeLBBJ44mF13NWoU86FdcWmOXrebkyUsvvh
 W9NVX+7zmCSBSmvuEfFIWdakIwURzsrcqAULasDXGhe71x4dyzH4KtgrDl5c6g7nNtl71qWOjca
 SFCzI84Og4bPaUGw8+tH/da33BUt84kZJF1UnbcaclI2QAH7CiPEU/I=
X-Google-Smtp-Source: AGHT+IEWFdeG8XoQEwxkvcHvfBVJq8R9Z86pNOqIyIpZUWEkuz79ou/Y+NtoL3Zpj9ej3zLulSqsKQ==
X-Received: by 2002:a05:6214:460a:b0:6d8:88c2:af5f with SMTP id
 6a1803df08f44-6dd23580fd0mr275672856d6.1.1735056131288; 
 Tue, 24 Dec 2024 08:02:11 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:02:10 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 06/11] tpm: Don't create an EventLog if algorithms are
 misconfigured
Date: Tue, 24 Dec 2024 08:01:08 -0800
Message-Id: <20241224160118.675977-7-raymond.mao@linaro.org>
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

We already check the active banks vs what U-Boot was compiled with when
trying to extend a PCR and we refuse to do so if the TPM active ones
don't match the ones U-Boot supports.

Do the same thing for the EventLog creation since extending will fail
anyway and print a message so the user can figure out the missing
algorithms.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 include/tpm-v2.h |  7 +++++++
 lib/tpm-v2.c     | 23 +++++++++++++++++++++++
 lib/tpm_tcg2.c   | 27 ++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index c49eadda26..6b3f2175b7 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -770,4 +770,11 @@ bool tpm2_check_active_banks(struct udevice *dev);
  */
 bool tpm2_is_active_bank(struct tpms_pcr_selection *selection);
 
+/**
+ * tpm2_print_active_banks() - Print the active TPM PCRs
+ *
+ * @dev: TPM device
+ */
+void tpm2_print_active_banks(struct udevice *dev);
+
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 96c164f2a5..bac6fd9101 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -926,3 +926,26 @@ bool tpm2_check_active_banks(struct udevice *dev)
 
 	return true;
 }
+
+void tpm2_print_active_banks(struct udevice *dev)
+{
+	struct tpml_pcr_selection pcrs;
+	size_t i;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &pcrs);
+	if (rc) {
+		log_err("Can't retrieve active PCRs\n");
+		return;
+	}
+
+	for (i = 0; i < pcrs.count; i++) {
+		if (tpm2_is_active_bank(&pcrs.selection[i])) {
+			const char *str;
+
+			str = tpm2_algorithm_name(pcrs.selection[i].hash);
+			if (str)
+				log_info("%s\n", str);
+		}
+	}
+}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 99671804e3..e77a904129 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -567,11 +567,36 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 			    bool ignore_existing_log)
 {
 	struct tcg2_event_log log;
-	int rc;
+	int rc, i;
 
 	elog->log_position = 0;
 	elog->found = false;
 
+	/*
+	 * Make sure U-Boot is compiled with all the active PCRs
+	 * since we are about to create an EventLog and we won't
+	 * measure anything if the PCR banks don't match
+	 */
+	if (!tpm2_check_active_banks(dev)) {
+		log_err("Cannot create EventLog\n");
+		log_err("Mismatch between U-Boot and TPM hash algos\n");
+		log_info("TPM:\n");
+		tpm2_print_active_banks(dev);
+		log_info("U-Boot:\n");
+		for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+			const struct digest_info *algo = &hash_algo_list[i];
+			const char *str;
+
+			if (!algo->supported)
+				continue;
+
+			str = tpm2_algorithm_name(algo->hash_alg);
+			if (str)
+				log_info("%s\n", str);
+		}
+		return -EINVAL;
+	}
+
 	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
 	if (!rc) {
 		log.log_position = 0;
-- 
2.25.1

