Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F96CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D6486F5E;
	Sun, 15 Oct 2023 08:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RdBIohic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E5886611; Sun, 15 Oct 2023 08:43:23 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F6886F6E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bc2c2f13dso2027961eaf.2
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352101; x=1697956901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcWzjxJi357B468UjABrocKKgZNtx89Lgh1nYgUQIR8=;
 b=RdBIohicoKiEtQPM5tbcwi9tjiz8hSCwYUym9Yzy5wdgS+eaWAUrxHKX2zFeEVwl7N
 ZtXMiakDwLZpnNUrWuVzG01ZbBXOIdA0vry0XRXtxS26/5+Y6Ji4h/hL+B9FDr9EVRDQ
 ufyKsPVPsrvtUcyUzN86YpVvbwxHyY9194rc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352101; x=1697956901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcWzjxJi357B468UjABrocKKgZNtx89Lgh1nYgUQIR8=;
 b=vHnoDM3ezRAHRAgPEGVGbQv9yg4hpOpRTOXzlz4ZFNt/Z3JPLkwEfZZY90OU0oEfTH
 XSvalFNnVQhKycC8EvAJmxHpIGFNY3u2idbMnJyjRTpSHv5T2ky5SKZyKv5sbYnqE9NU
 +2EKu6M4vsMvEVyB+jlDn2Dw2PjF2wNVJFBmngYZ704ZK/uoias4CjC/sixVV8y8/zkb
 1cBSrI3/YxQR1B3h5fhvDix5IZ72akGbT+A4J+rG4qXpdLCel5aoMKoU/ozFnMpI8hIq
 XvAqYDyuQu77ZTg43al7gjthDNASWt9+ZAh6xlna9KjwpA/xUiUtBpwY4mcEWkjPoZvF
 sKOw==
X-Gm-Message-State: AOJu0YxohwA5C+TdF8yif/BXKb2UwtLqnee4XHwdV5kKR4BofUoFV8bX
 jEisFYKYNNpuwBM6h178Yes5dsl5CfxZEdcqJnoNgQ==
X-Google-Smtp-Source: AGHT+IEneptN+nAex44Aa1Gyl4j+ISUhCgCCtkXrPfUFca/PPZlBgtijk7kIIMAfSKGiYzcPVL9VSQ==
X-Received: by 2002:a05:6e02:1c4d:b0:34b:ac73:eb97 with SMTP id
 d13-20020a056e021c4d00b0034bac73eb97mr40554381ilg.14.1697337915787; 
 Sat, 14 Oct 2023 19:45:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/6] smbios: Refactor 32-bit code into an else statement
Date: Sat, 14 Oct 2023 20:45:03 -0600
Message-ID: <20231015024511.3995580-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231015024511.3995580-1-sjg@chromium.org>
References: <20231015024511.3995580-1-sjg@chromium.org>
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

In preparation for adding support for SMBIOS3 move this code into an
else statement. There is no functional change.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/smbios.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index d7f4999e8b2a..96f67cd6ad7b 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -509,14 +509,6 @@ ulong write_smbios_table(ulong addr)
 		len += tmp;
 	}
 
-	memcpy(se->anchor, "_SM_", 4);
-	se->length = sizeof(struct smbios_entry);
-	se->major_ver = SMBIOS_MAJOR_VER;
-	se->minor_ver = SMBIOS_MINOR_VER;
-	se->max_struct_size = max_struct_size;
-	memcpy(se->intermediate_anchor, "_DMI_", 5);
-	se->struct_table_length = len;
-
 	/*
 	 * We must use a pointer here so things work correctly on sandbox. The
 	 * user of this table is not aware of the mapping of addresses to
@@ -532,16 +524,28 @@ ulong write_smbios_table(ulong addr)
 		       (unsigned long long)table_addr);
 		addr = 0;
 		goto out;
+	} else {
+		memcpy(se->anchor, "_SM_", 4);
+		se->length = sizeof(struct smbios_entry);
+		se->major_ver = SMBIOS_MAJOR_VER;
+		se->minor_ver = SMBIOS_MINOR_VER;
+		se->max_struct_size = max_struct_size;
+		memcpy(se->intermediate_anchor, "_DMI_", 5);
+		se->struct_table_length = len;
+
+		se->struct_table_address = table_addr;
+
+		se->struct_count = handle;
+
+		/* calculate checksums */
+		istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
+		isize = sizeof(struct smbios_entry) -
+			SMBIOS_INTERMEDIATE_OFFSET;
+		se->intermediate_checksum = table_compute_checksum(istart,
+								   isize);
+		se->checksum = table_compute_checksum(se,
+					      sizeof(struct smbios_entry));
 	}
-	se->struct_table_address = table_addr;
-
-	se->struct_count = handle;
-
-	/* calculate checksums */
-	istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
-	isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
-	se->intermediate_checksum = table_compute_checksum(istart, isize);
-	se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
 out:
 	unmap_sysmem(se);
 
-- 
2.42.0.655.g421f12c284-goog

