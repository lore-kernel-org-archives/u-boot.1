Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C145E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4803180831;
	Tue, 24 Dec 2024 17:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KN8L4Ni1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC72807DE; Tue, 24 Dec 2024 17:02:35 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28C0801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d91653e9d7so44495236d6.1
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056150; x=1735660950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f+1zk888DmInzSB52Q94w0za4Cy2rrga3HxC6WEDSU=;
 b=KN8L4Ni1bqIuM0cb7h7XRMrPFyh9X7y2k6Q0/z6dDzyFqR6FMMTzeZA3WgDwm53G4f
 6CL6ySUkTxgCEs0Esa1b2i18P8t7xvCE7YDZn18qMmKlkdHQaYZnjp3ZNkYPOv0TH7e1
 o16HsxkPe4u/tLmFRGZqYxvGwEP3mrislq1hYJPUjyFxL4PCEglw8NttBqUHLaZWFAwI
 UXutNWa3Gikr3ymMoi36ZloVqRB/DFk1Wfs2sr1RsmXp8NlU+Lc69qsa0T0JffkLnBEw
 7aYgPe1uVuvTl92cVctefRRMD0MhHPnhzYa9O/Ri1JYoNQx2D6qxrSWBRT6Pez/bIGwS
 aZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056150; x=1735660950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6f+1zk888DmInzSB52Q94w0za4Cy2rrga3HxC6WEDSU=;
 b=TJho/kzP/9kUnnpclNbJD28rEWWjQEaX9G0I3GpXOZ3qWIEkrNdgxhPhbGRMESePL6
 6GIwYwJNgH7cBgqNksEeRixW7DvKlCWum7AtHJbb+u3gIBEkGP9h2VUFqEzjdOQCQ3ys
 MBp3wWd0Ka697cGa+AqO21cZHc1MT4nAhRFQLP5q6dkMvkF1UGVghZpwd0DTA1t0mVOC
 Yt0LXonC8dunQB7bdjjAphuukbO7+hceHY1VjoJvN6aukmDziNQXgqRYejq9rOK1Ht49
 siDeceecK/2U6t5gWs3l1pq7Xzw2LI2KmOjrwE2NNd5l8EDAj3zkLiQ0XzXZssco2awd
 LfwA==
X-Gm-Message-State: AOJu0YzF9gVy9GW+vKyxCU/rySqSuihwPpP+rjruDl+IoeWMohm8n1i6
 cal09gxsliAMVxFDg0sx9q3cNot6ZSo+3uYtbhkO8Uwg30ZuzTrONn9UfT5INeT/JpinpbAdNqb
 i
X-Gm-Gg: ASbGncvslnC3jHso6JfCW6/NkCChrSCAqpNYfO2LTTZ0OQQMFmhfca1PA1yNAaPnX53
 7XPiPBUlc2Irvh6ABv3XTrcwg4WP3UCE4UXgzzNoNuq/sqfWMvOYjNi8DjjGItL6KEHtZES5XtY
 CxCXf1WM2HZROMj4tkklML6onn/BWlELsS5ipKFSyt0uKm8KB6gAlcY/lngpfSLuOwULKyonyCw
 +dV5yPKr72g4aQGttgJojLTQkjtw5CpeFtvnGx/8I5qwNcUUvSfAp/JcV7QnVHIeLwfANRaCWau
 k3lGYDR09sKV4u8vnfg1TkcA7z61cSRXYsa9Cnp2FiatGRuhbFFNBQY=
X-Google-Smtp-Source: AGHT+IEAOk4qprEtaIpX9xtdodU/1PLmQokzRgkZ3OEwP+s7dzhexA+2NQxZHvj8v5XkXSN2Npj4tA==
X-Received: by 2002:ad4:5ba5:0:b0:6d8:a84b:b50d with SMTP id
 6a1803df08f44-6dd2339ff8cmr236448426d6.33.1735056150363; 
 Tue, 24 Dec 2024 08:02:30 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:02:29 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 09/11] tpm: Simplify tcg2_log_init()
Date: Tue, 24 Dec 2024 08:01:11 -0800
Message-Id: <20241224160118.675977-10-raymond.mao@linaro.org>
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

A previous patch is storing the active PCR banks on the TPM private
data. Instead of parsing them on the fly use the stored values.
This allows us to simplify our checks during the log creation and
parsing.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 lib/tpm_tcg2.c | 42 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 9e63204f24..6c72688b80 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -207,37 +207,17 @@ static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
 
 static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 {
+	struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
 	struct tcg_efi_spec_id_event *ev;
 	struct tcg_pcr_event *log;
 	u32 event_size;
 	u32 count = 0;
 	u32 log_size;
-	u32 active;
 	size_t i;
 	u16 len;
-	int rc;
-
-	rc = tcg2_get_active_pcr_banks(dev, &active);
-	if (rc)
-		return rc;
 
+	count = priv->active_bank_count;
 	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		switch (hash_algo_list[i].hash_alg) {
-		case TPM2_ALG_SHA1:
-		case TPM2_ALG_SHA256:
-		case TPM2_ALG_SHA384:
-		case TPM2_ALG_SHA512:
-			count++;
-			break;
-		default:
-			continue;
-		}
-	}
-
 	event_size += 1 +
 		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count);
 	log_size = offsetof(struct tcg_pcr_event, event) + event_size;
@@ -264,19 +244,11 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
 	ev->uintn_size = sizeof(size_t) / sizeof(u32);
 	put_unaligned_le32(count, &ev->number_of_algorithms);
 
-	count = 0;
-	for (i = 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
-		if (!(active & hash_algo_list[i].hash_mask))
-			continue;
-
-		len = hash_algo_list[i].hash_len;
-		if (!len)
-			continue;
-
-		put_unaligned_le16(hash_algo_list[i].hash_alg,
-				   &ev->digest_sizes[count].algorithm_id);
-		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
-		count++;
+	for (i = 0; i < count; ++i) {
+		len = tpm2_algorithm_to_len(priv->active_banks[i]);
+		put_unaligned_le16(priv->active_banks[i],
+				   &ev->digest_sizes[i].algorithm_id);
+		put_unaligned_le16(len, &ev->digest_sizes[i].digest_size);
 	}
 
 	*((u8 *)ev + (event_size - 1)) = 0;
-- 
2.25.1

