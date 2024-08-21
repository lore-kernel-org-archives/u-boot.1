Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74A8C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1203B88E34;
	Wed, 21 Aug 2024 18:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OptKdl+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A67A88E42; Wed, 21 Aug 2024 18:19:54 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A45C88E1C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70944d76a04so586524a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257191; x=1724861991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paxL6+/fLzeatYUKLWXsPwickojGLO/T76acZF/VKJA=;
 b=OptKdl+Xf/rjk9jzesPsSSqHODbJflriYC/KRT84k1J4t96kSS9lcceT51Q1nERmOM
 MqjcgqNAf0o9zMGSYNUnKuq/SwU+u6TiOfIQM+grWZCNtLOCinlAqevKRkl5uIxl/VXp
 XIxP9aBpWH1MzaoB7dJIcooJRhKPgqm7uxBKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257191; x=1724861991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paxL6+/fLzeatYUKLWXsPwickojGLO/T76acZF/VKJA=;
 b=D8OXSuVi2oVo4gl2ygvzG49tWUtNAwhWhD/8KpeYqlJ7YDNfLvT/sPm/kEe5AJipHe
 EqrLNWcsqW/PQLYt+mdn6q7/4yuDCjdj2gjcxFf40WG8yHRBDKjdbJzV0oApqoZqZQoC
 gFoef9aFlStogQ+FPZTwiXlsdsmz5RpF1tnsnm/IpkPrc81vlfDhuHs1nFcrRdaxXjAK
 b9P3IqYKL2RQU8kP9lbACz19JrJFq0BeqlBZrPMfLAkY6jaGoWtSXVO0AvE1IJB8CpPS
 O6/U9DMDCw4oJ8K4rIrPjf0EjQFXAJjOgxJ62o7ui2pUPjMl2o+85orIe7Fk+BgcIFNY
 VGjg==
X-Gm-Message-State: AOJu0Ywma3PeMa9jyJSkK/vlRNRnXEwuH2Ci4eHsjdAWdWeMs7c5xSs+
 9i0/hQBSNx2i/Qm/wDrHb3Xi4Ll/3hWJSYxCEMaz5BHEuwnILXzY7bOzpJllnxStzzv0oQLUZ4o
 =
X-Google-Smtp-Source: AGHT+IGqS7t7bFKSYnaZH5Cjjf2cFSO1gcAZB3Oa+tMWVOGjwnj7fiarqxGNFYh1bpRGrobOt1u5qA==
X-Received: by 2002:a05:6830:71aa:b0:703:66eb:ef8 with SMTP id
 46e09a7af769-70e01b63a27mr74552a34.5.1724257190745; 
 Wed, 21 Aug 2024 09:19:50 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/35] global_data: Use less space for environment fields
Date: Wed, 21 Aug 2024 10:19:08 -0600
Message-Id: <20240821161927.695717-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

 include/asm-generic/global_data.h | 14 +++++++-------
 include/env_internal.h            |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 86e8d654a28..1252b8acefa 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -114,21 +114,21 @@ struct global_data {
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
index 0a267e35592..c1c0727e4d0 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -100,6 +100,7 @@ extern const char default_environment[];
 #include <env_flags.h>
 #include <search.h>
 
+/* this is stored as bits in gd->env_has_init so is limited to 16 entries */
 enum env_location {
 	ENVL_UNKNOWN,
 	ENVL_EEPROM,
-- 
2.34.1

