Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E2E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8113680761;
	Mon, 23 Dec 2024 15:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GXlnAubS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A40280758; Mon, 23 Dec 2024 15:48:05 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CEA806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so6420576d6.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965281; x=1735570081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ws668TMTDz964Zlj4dYkLtGKdxvu+tpxcZhOqiDXJk=;
 b=GXlnAubS1PZMx2UR8LCxdAki1V5dGYiG9TiiSPuF42t1nXjZSixsGHS2kYqxS1i7ts
 Ewo+yhPGBfecQCqM8EYBPi6oVrGD5Nk6BQgtTrN14MCm1mwFRNJ3tthxwoeqftvx3/9D
 GMJ1+altXtdA9Q0pTC9Qrh7VIRdaMhXJbg1bRlQGAGt7r99K07XsH7kbHt6fWXIJbf4N
 PvE6W1Tb9L6nwqu/hJGtn9g+Sg5GRc3x+/0PnM7f14AEyRVhXMx2WYgJd2oD3qi0vfVW
 4Zd8fjmwdIln+skCkZa9SagoxCGpiPgre5JVNfNW68huLEn6QjWe7vWH4khaTfdoLN/x
 vXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965281; x=1735570081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ws668TMTDz964Zlj4dYkLtGKdxvu+tpxcZhOqiDXJk=;
 b=MyyqamqL1KIfPg/RC4tO4EziNV0nzW0ttnRbTL98ks5GcVR9E1iGPH2oqqvt3HnbUk
 r/Men0g6XauqvtEqVN5c0k1BVtrtICN3HNBk3T39b0P3n2USQAvBaTRyLzGAzL3iX4pf
 rxvXAUCBSji+orDkm0rnQKt7yMO4m34tWRzGzgyxgY+Bo1i+v+/zdIU8Lc9e1KcYy46a
 VQXp/Lm7yiXOkkdEujbdJIoLFMrgbP0BC7cGU4amVvdNcYU5mtPA+C35sHVqBqRs3BmV
 AKUVNeFHVK4DYi2mBq3QDSf4isxPb+OC8slPz9ji5aG2JkEnkwmjTJu8FtjKuIrqtLmL
 ap9w==
X-Gm-Message-State: AOJu0Ywg5Og/TXH534hjnOTFfWop9Mdx1KoS4sYFfKYTOro6Dgp+s46B
 gaQ8O4RPmbBBwoXEOk+K1Cwx50rdeQQ8ImsbMKCNzv+vcE9ufIMSTa21T7Ky6NcOzQnarft4dI1
 6
X-Gm-Gg: ASbGnctDsfBKIM/LCyBZhesoi/Er+XHK/s2wfcbnM/ac0AV/jfQwARdKpCIJQiU3ois
 iUYKP8PX7sSujYje/T/hSnquHnK1l71H9pGWGj7P9On/ihWzzYnlgI/Q3pMd3iGOaSii7lx40X7
 LDd0iETAmENFsFrNxKOAaKOV3LhSVAGY/MChnmxR1MbAOdxeGBBZBTrrV4faD7nB8htKM27UG+v
 iAsd4zGT7IDgRQ0c73VReExDcKI+RVef9iD+N54BQr2BgxJEPaABW55KJ61Zwgg5jF7eEuG+FmN
 2flX+89lyUFauDoIaeNyj50jrg1sAQmMTGMd57NOsQvWzthOw4gmCkA=
X-Google-Smtp-Source: AGHT+IE5Z0uuWdUJCpOd/do6HrN0JZB6hPZjPUlBdQNFCzX3062yth0RTu7NXSrouR1nT3zdpvFv2A==
X-Received: by 2002:ad4:5b83:0:b0:6d8:8256:41d4 with SMTP id
 6a1803df08f44-6dd233320fcmr204904346d6.19.1734965281693; 
 Mon, 23 Dec 2024 06:48:01 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:01 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 02/11] tpm: Rename tpm2_is_active_pcr()
Date: Mon, 23 Dec 2024 06:47:24 -0800
Message-Id: <20241223144737.554992-3-raymond.mao@linaro.org>
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

This function is checking for active PCR banks, so rename it
to something that's easier to read and closer to what the function
does.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm-v2.h | 6 +++---
 lib/tpm-v2.c     | 4 ++--
 lib/tpm_tcg2.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 4fd19c52fd..8c43f4fd9b 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -740,12 +740,12 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
 bool tpm2_allow_extend(struct udevice *dev);
 
 /**
- * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
- *			  supports the algorithm add it on the active ones
+ * tpm2_is_active_bank() - check the pcr_select. If at least one of the PCRs
+ *			   supports the algorithm add it on the active ones
  *
  * @selection: PCR selection structure
  * Return: True if the algorithm is active
  */
-bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection);
+bool tpm2_is_active_bank(struct tpms_pcr_selection *selection);
 
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index ad2b5ab0c3..cb636414de 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -847,7 +847,7 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 	return 0;
 }
 
-bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection)
+bool tpm2_is_active_bank(struct tpms_pcr_selection *selection)
 {
 	int i;
 
@@ -907,7 +907,7 @@ bool tpm2_allow_extend(struct udevice *dev)
 		return false;
 
 	for (i = 0; i < pcrs.count; i++) {
-		if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
+		if (tpm2_is_active_bank(&pcrs.selection[i]) &&
 		    !tpm2_algorithm_to_len(pcrs.selection[i].hash))
 			return false;
 	}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index acaf0acb88..dc5a0644fd 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -44,7 +44,7 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 
 		if (hash_mask) {
 			*supported_pcr |= hash_mask;
-			if (tpm2_is_active_pcr(&pcrs.selection[i]))
+			if (tpm2_is_active_bank(&pcrs.selection[i]))
 				*active_pcr |= hash_mask;
 		} else {
 			printf("%s: unknown algorithm %x\n", __func__,
-- 
2.25.1

