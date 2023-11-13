Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18DAC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06AD3870F2;
	Mon, 13 Nov 2023 17:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgGuZDjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914C5870F3; Mon, 13 Nov 2023 17:11:26 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770AE870B4
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6c398717726so3813185b3a.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699891882; x=1700496682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=As+P8aWnSmUx1RkKDoxBDun5TIwbeSq8i67vCuxBC2E=;
 b=OgGuZDjKmkj8ePYaFx2wTIEVy2Ds8ZPCROTK0j2cOiIQq7Mfo0K8omAS+j0qb6S6Ek
 yQv/BdA7LkCCAsaq7GziyRHx6C7kWxOx4DAcGW0jTpGUuMQ1Kiuc9YSU4tPigAb1KHl3
 ++OHk1DrLSwNxcShmjt4Y3t2k4kdG7BzNGkvaWrQYmHJcqhUIcAGw/mkyfIx+0rZunHb
 406VqDVFP+7yDsvWdGJz+xoFh46avid2iPvvfNDKK8XIbANS8eqLbe5GzIshpr/nkDL2
 x90A4PGRt8JVWnR/NqkX/Wyi1+cc4Yo5Gy0TAWCehEhULMbvOVRljqk0iVcs2KDwkDNU
 PClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891882; x=1700496682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=As+P8aWnSmUx1RkKDoxBDun5TIwbeSq8i67vCuxBC2E=;
 b=Og9Z/ZS4ZQXKG0VaNgotFKBEtqs4mK7dVuig5iI7/9LRF9kFVHNRaAb5r61D24zo3h
 oMLTtYb8Pc7zL/ayqfBSqp/XhjbOJQ3lnH3kF7HhZu6MCunL/16ZyTYFyHLAS0zMVH9q
 1TvkKFUXrlJCO1DFqfWVoD+aRvycC+8XEuAP9Up8zKC0CJvzIjL3TKa/l6lEy57jW1lR
 +/6dmMTYx8AeduCrXHNWMROEHh7PTQWKPq1o1rvt3SAocY4R9cWZerVt5KWiAXa9T3Ba
 a16eBvEf3H8YkfWfNodaIxDR6WT0f6B4aPcIMe+/cj71R/UHX8NJOivf6JXP9LU03k+j
 dEhw==
X-Gm-Message-State: AOJu0Yxw1RzqJAqvYgQR7kIaw/FjOhbQN+8qNkDu5NdDSCyLP44WkSP7
 Ja/3WLWRVeYh5gq6FWLsRhyDA9oAGjAu9Oqg
X-Google-Smtp-Source: AGHT+IGgpFKCHDFUN7e3pUSxIHvbM3eypXObhagldAjI+EhBN8I57Xpqls//bfGqj7E8ERoVTNIeWw==
X-Received: by 2002:a05:6a00:2450:b0:6bd:8c4a:ab9c with SMTP id
 d16-20020a056a00245000b006bd8c4aab9cmr6000893pfj.4.1699891882091; 
 Mon, 13 Nov 2023 08:11:22 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a056a000d4a00b006b725b2158bsm3984661pfv.41.2023.11.13.08.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 08:11:21 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: u-boot@lists.denx.de
Cc: Weizhao Ouyang <o451686892@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RESEND PATCH v2] efi_loader: Fix UEFI variable error handling
Date: Mon, 13 Nov 2023 16:10:31 +0000
Message-Id: <20231113161031.138304-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Try to catch error the earlier way.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 lib/efi_loader/efi_var_file.c | 4 +++-
 lib/efi_loader/efi_variable.c | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd83..fe1c462f17 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -192,8 +192,10 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
 				      var->length, data, 0, NULL,
 				      var->time);
-		if (ret != EFI_SUCCESS)
+		if (ret != EFI_SUCCESS) {
 			log_err("Failed to set EFI variable %ls\n", var->name);
+			return ret;
+		}
 	}
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6..2b2ca8c090 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -350,8 +350,6 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 
 	if (var_type == EFI_AUTH_VAR_PK)
 		ret = efi_init_secure_state();
-	else
-		ret = EFI_SUCCESS;
 
 	/*
 	 * Write non-volatile EFI variables to file
-- 
2.39.2

