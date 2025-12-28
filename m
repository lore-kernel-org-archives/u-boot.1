Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8B8E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA0583A9F;
	Sun, 28 Dec 2025 16:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lcdRpUMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7569983B21; Sun, 28 Dec 2025 16:18:36 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A36183A8C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b79e7112398so1482861066b.3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935114; x=1767539914;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhmMxxr1x0XNjGMnJ9VY+5ttKFr1CekD4DbcXhJyhT0=;
 b=lcdRpUMcIVKD2+I7PNFS+fHmzWQJOABDpgzwkKXw4oncW1sy9IR2uau8aZr49799MT
 IG9F+k9YzeyO213YbAgVmX4PqDPyqubjXkMh2hWcf7COMGbNbDbVIu+1cD5qLFrL5yjy
 h1AeqOgidvsFh9w8mdoUYEbuPCWzAHiyH2mW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935114; x=1767539914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KhmMxxr1x0XNjGMnJ9VY+5ttKFr1CekD4DbcXhJyhT0=;
 b=Ha74Sux/x67YvN3x/JO9Ncy+9oP6N9FdY5Mb9F6yGFYVI4B4m9K+VwIbWG6Jo7h+Xi
 vlwKIncpYB6v6CBA8bnPkknlQXmIxFbCT3kR9KtjSBlVahbCjpFaqiooij+X5g9US7sy
 l7lICyp+uAqfsIoxt4/K2+VdkugaNnJECgl9Kimq7z/zyVAqOYf7rN4nhEUUze4id4/6
 ExhxYL6A57TPr97F9QAfi7ChPfPVCL66p6+CagB4WoIsRkE6+Hmkj9eWbfiN3Zmp/975
 sSkDINs1J3bvXpAS31f8gQ90u3hVPs1cEIVw1U1lvSdwYtm4BESsQcTTGkibAplondir
 UAlA==
X-Gm-Message-State: AOJu0YwuESMePfejDDAsDtvkniUzMdZIF+IlvYfgN/K3NMurHkTjMS8J
 XCZEjIImohMKmwipExfcGt6o9OsI3EBiAGkNkCXwtObLBjcoWwgeK4jPDq8ACokduLXOiytyGsd
 wfoIw
X-Gm-Gg: AY/fxX5TWJqLjnGtSaThlMQm6Rlh4DhSzoCfOaxihE9j+lMvRdzssFJb0EJaCZu4X+3
 2rBVhQJmPFDrSOpXo5g3jkjslO67zgz0MEUl1mTTHtqltgOymPM2/ULliUQcPJEdCAJuEncYO8j
 G4/5XiPvNV4Lz99PwC1Fj/juAutLHP0OrpWBtVsxgbA00xbaBuYXXhuugEJDu5qSYqW9pishEVm
 u4rlJi7HyF0INPLbR0j7Dwf7sVR0q8TVWuJHRznZebbXX6QTucVTlIJq9I5+6MV5ffpHe/lq0Pm
 jmYAwCUyM0YQqbIQpifSACvMjBwBlE8ynVxS04SmtZjD6pVi6tVhlVYbsg9Iocyx9aSMVBzN31I
 F1ZUpWQHJOm4sQoF+ApOnnolJCyTYY4wCTfipB5x4ndhkv7oTQUqlXEBOPAD0BgYbJZBll/4snO
 Yq4inLXlGgs8sQlv+qUeaKJhQw9W+Ym8uEyKudTmQW65l/FkdD2jg6BBtziaIkc48trjKd978Ln
 VT0IlrqdLJCZy868VIBa/grP6kGL4WTooyczazkWp5XIG25SlZAcaylAplB7gePyqIc3rejmbVn
 YS4mL8aMxXoBok+x2GsqDA==
X-Google-Smtp-Source: AGHT+IEsC5gQfXGfAPRXHK0a7bJGze8LqjncygKlQ2of/uCe7Jb3RZAucMjPBs8NIU431bkJCF03rw==
X-Received: by 2002:a17:907:7f1c:b0:b83:976:50f9 with SMTP id
 a640c23a62f3a-b83097652a7mr1283225766b.61.1766935113743; 
 Sun, 28 Dec 2025 07:18:33 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] fwu: use FWU_MAX_STATE_BANKS for bank_state array
Date: Sun, 28 Dec 2025 16:17:53 +0100
Message-ID: <20251228151824.25667-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
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

Replace the hardcoded size of the bank_state array with
FWU_MAX_STATE_BANKS to improve readability and ensure consistency
between the structure definition and code that relies on it,
including the mkfwumdata tool.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/fwu_mdata.h | 5 ++++-
 tools/mkfwumdata.c  | 5 +----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/fwu_mdata.h b/include/fwu_mdata.h
index 43b3487c4a23..b84a9987f769 100644
--- a/include/fwu_mdata.h
+++ b/include/fwu_mdata.h
@@ -94,6 +94,9 @@ struct fwu_mdata {
 } __packed;
 
 #else /* CONFIG_FWU_MDATA_V1 */
+
+#define FWU_MAX_STATE_BANKS			4
+
 /**
  * struct fwu_mdata - FWU metadata structure for multi-bank updates
  * @crc32: crc32 value for the FWU metadata
@@ -120,7 +123,7 @@ struct fwu_mdata {
 	uint32_t metadata_size;
 	uint16_t desc_offset;
 	uint16_t reserved1;
-	uint8_t  bank_state[4];
+	uint8_t  bank_state[FWU_MAX_STATE_BANKS];
 	uint32_t reserved2;
 
 	// struct fwu_fw_store_desc fw_desc;
diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index 0d1697622e6a..c2fd3d4232f5 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -30,9 +30,6 @@ typedef uint64_t u64;
 #define CONFIG_FWU_NUM_BANKS		0
 #define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
 
-/* version 2 supports maximum of 4 banks */
-#define MAX_BANKS_V2			4
-
 #include <fwu_mdata.h>
 
 static const char *opts_short = "b:i:a:p:v:V:gh";
@@ -292,7 +289,7 @@ static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
 	mdata->metadata_size = mobj->size;
 	mdata->desc_offset = sizeof(struct fwu_mdata);
 
-	for (i = 0; i < MAX_BANKS_V2; i++)
+	for (i = 0; i < FWU_MAX_STATE_BANKS; i++)
 		mdata->bank_state[i] = i < mobj->banks ?
 			FWU_BANK_ACCEPTED : FWU_BANK_INVALID;
 
-- 
2.43.0

