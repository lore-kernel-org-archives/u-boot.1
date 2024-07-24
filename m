Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADE8C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA39889D5;
	Wed, 24 Jul 2024 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lJ/kumNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB986889C8; Wed, 24 Jul 2024 17:09:55 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE03889D1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-397ba4f7387so29036885ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833791; x=1722438591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHV+H6GBJLzLH2rNEhDoNrXutE7fhloiyyl/xe1MzYc=;
 b=lJ/kumNfb97iQ3XAwW2GfMNTrlVsys43vVtaj+82L3KLzp8uf44lfnvy4VmakVO0Ev
 X3X7F2rEXg0H3SpQLIF7/KolHu823Zoy8WJspTYSvkCkp3k1kEEkXNZWm2Vg7m7k78kN
 6f2CJEkOA7prENNyu7+CRNaLWYZtyiNUVQLpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833791; x=1722438591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHV+H6GBJLzLH2rNEhDoNrXutE7fhloiyyl/xe1MzYc=;
 b=sS0QsG4+1E6DyyVz+FgRCX+0c3aoXQS/UGb0AXOfEQOZ/SB4kW9AXYyY9qc8USBsjl
 CaNg5hBcf7+x0iK24IFjX5eif2eiPPvOY8JHCbv/Dm98Cr9DcLeU813pfofPdjeMvEeu
 kYWqMuJr8IsnM1TAa3yWlY1BtFXXKht5m5ezL3ojQGCgNm/rXLH8Juz+XN/hMXwgE86n
 8pO11iLGYX9RsgMWNvyeqYc/EeiD6URNv/Q0L55mE4wrzQ4itxx5+AJ0lEdScGjz2uzU
 dgEVkSaCCwkyY+05zT+Q1rVVg7+gnHBopygpExp/ULj8r1Bo6QCaHCufK/vsitVctjCA
 Sa6Q==
X-Gm-Message-State: AOJu0Yx4UaZjm/OFMRKNnYAyDbhV1omDJbdYzT2XFxAQeYuovV4Rg3Kz
 iJQ7hMDcnmzJNnG0ZTL2CKdQLvj2paeKsuz4IiIEC6FHFJvQMaWaKI/lAXGVJdD25hlV8ShDbHQ
 =
X-Google-Smtp-Source: AGHT+IELKmkV8VPtgrwOJwnGQWeZervQjhIL6bPXwj2ka0WYq3LX0/7l3bbyQV8X9w8qu8jnCEn4iw==
X-Received: by 2002:a92:c262:0:b0:39a:1b0a:f0a9 with SMTP id
 e9e14a558f8ab-39a1b0afda0mr20352995ab.23.1721833791503; 
 Wed, 24 Jul 2024 08:09:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 16/35] global_data: Use less space for environment fields
Date: Wed, 24 Jul 2024 09:09:03 -0600
Message-Id: <20240724150922.2343249-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Use shorter types for some of these fields to save space. Reorder to put
fields with like alignment together.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 14 +++++++-------
 include/env_internal.h            |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index d8be0654a87..0904fcf77fc 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -113,21 +113,21 @@ struct global_data {
 	 */
 	unsigned long env_addr;
 	/**
-	 * @env_valid: environment is valid
+	 * @env_has_init: bit mask indicating environment locations
 	 *
-	 * See &enum env_valid
+	 * &enum env_location defines which bit relates to which location
 	 */
-	unsigned long env_valid;
+	unsigned short env_has_init;
 	/**
-	 * @env_has_init: bit mask indicating environment locations
+	 * @env_valid: environment is valid
 	 *
-	 * &enum env_location defines which bit relates to which location
+	 * See &enum env_valid
 	 */
-	unsigned long env_has_init;
+	unsigned char env_valid;
 	/**
 	 * @env_load_prio: priority of the loaded environment
 	 */
-	int env_load_prio;
+	char env_load_prio;
 	/**
 	 * @ram_base: base address of RAM used by U-Boot
 	 */
diff --git a/include/env_internal.h b/include/env_internal.h
index cbd1ef3e914..2a66a98b97e 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -101,6 +101,7 @@ extern const char default_environment[];
 #include <env_flags.h>
 #include <search.h>
 
+/* this is stored as bits in gd->env_has_init so is limited to 16 entries */
 enum env_location {
 	ENVL_UNKNOWN,
 	ENVL_EEPROM,
-- 
2.34.1

