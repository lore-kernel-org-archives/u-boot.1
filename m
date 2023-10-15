Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72D3CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09AE686F16;
	Sun, 15 Oct 2023 08:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bbl9R0j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCEF86DF5; Sun, 15 Oct 2023 08:53:36 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DFC86F82
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7bbcc099fso43562837b3.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352675; x=1697957475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5jie/1oEQRfU5RgB7exxwq+S6EA9EIjPdFKQ/83sz4=;
 b=Bbl9R0j5IM+t6+29RKjIUpcs8ith1cunn6JvkoyEB3by1l+7irl2HHwATGuZP5Gcg+
 bDXxNd8wHdLSWcyfamI14MfL47lwxl2O4KGMEuA3YUCbtaUeawhvaxt1iSipLKh5Q/Xj
 6OohFSR6JJKlNQGCF7A/PTHAMhvcwectVXbpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352675; x=1697957475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5jie/1oEQRfU5RgB7exxwq+S6EA9EIjPdFKQ/83sz4=;
 b=kyKMkMwKJhoe1kOFziVohA4QxdIeNQYavotOGlT44G6FLFX5OCiEhGywnIwM4E4cJi
 0MoGT1uIARcA1lt0SCU7wx+C36MYgo09xmbaauPKjzYKxo7qM1b0jBmzxymrNf4WK8lh
 nOHgqnTyNCFVsPnVmvPHMaUTVaRb5IUQVG4wyYIQd1zRcWF4j404VoY9dJ6o/Xiaxr07
 fksyFB5/kPfp1cosAj7aLKT5wDxE5oxKfvllJDT8jHeUpRr8tiCkVA3DQSxwC3RUv+hv
 Yw4Kswu17ZDW2GDnb3zxdVHR2aPcEH8v+WexJSd0nrlpESY8jnK2pi4O05sF8VPJJuJo
 0FvA==
X-Gm-Message-State: AOJu0YxtiuxA1D23fn2oiAJWzKPkryl1SGw5AG7sxuh7WTjcMCGlJbWx
 DD1FfVxnwhPZ0RXR/2hntuxE1aAIihInYwdQrYlOIw==
X-Google-Smtp-Source: AGHT+IGxLT6M3OBYiGy9W3zG/bOYlpLPfJ6woFF8evS5XbjoUUJsFNAgr3VDePHKNK1YfHlxggcUHQ==
X-Received: by 2002:a92:c885:0:b0:357:5e06:a49b with SMTP id
 w5-20020a92c885000000b003575e06a49bmr6569265ilo.2.1697337916458; 
 Sat, 14 Oct 2023 19:45:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/6] smbios: Move the rest of the SMBIOS2 code
Date: Sat, 14 Oct 2023 20:45:04 -0600
Message-ID: <20231015024511.3995580-3-sjg@chromium.org>
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

Move all of this logic into the else clause, since it will not be used
for SMBIOS3

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/smbios.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 96f67cd6ad7b..c7a557bc9b7b 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -464,9 +464,8 @@ static struct smbios_write_method smbios_write_funcs[] = {
 ulong write_smbios_table(ulong addr)
 {
 	ofnode parent_node = ofnode_null();
-	struct smbios_entry *se;
+	ulong table_addr, start_addr;
 	struct smbios_ctx ctx;
-	ulong table_addr;
 	ulong tables;
 	int len = 0;
 	int max_struct_size = 0;
@@ -486,9 +485,7 @@ ulong write_smbios_table(ulong addr)
 
 	/* 16 byte align the table address */
 	addr = ALIGN(addr, 16);
-
-	se = map_sysmem(addr, sizeof(struct smbios_entry));
-	memset(se, 0, sizeof(struct smbios_entry));
+	start_addr = addr;
 
 	addr += sizeof(struct smbios_entry);
 	addr = ALIGN(addr, 16);
@@ -523,8 +520,11 @@ ulong write_smbios_table(ulong addr)
 		printf("WARNING: SMBIOS table_address overflow %llx\n",
 		       (unsigned long long)table_addr);
 		addr = 0;
-		goto out;
 	} else {
+		struct smbios_entry *se;
+
+		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+		memset(se, '\0', sizeof(struct smbios_entry));
 		memcpy(se->anchor, "_SM_", 4);
 		se->length = sizeof(struct smbios_entry);
 		se->major_ver = SMBIOS_MAJOR_VER;
@@ -545,9 +545,8 @@ ulong write_smbios_table(ulong addr)
 								   isize);
 		se->checksum = table_compute_checksum(se,
 					      sizeof(struct smbios_entry));
+		unmap_sysmem(se);
 	}
-out:
-	unmap_sysmem(se);
 
 	return addr;
 }
-- 
2.42.0.655.g421f12c284-goog

