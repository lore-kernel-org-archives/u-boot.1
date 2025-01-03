Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31003E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D429E8036D;
	Fri,  3 Jan 2025 12:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xYnW5RnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3046F8034E; Fri,  3 Jan 2025 12:13:41 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1647E80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so82842115e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735902818; x=1736507618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqMtU8J8RTjUYL2gkNXl4sjSogDVUkn/i1sjdMFI5vU=;
 b=xYnW5RnT5EVcjSnXpC85d4PgAjl0+VfL4LDMwLYApdb7bsZ5Ay8GbugVzlCVyeSzno
 j8wo+9VE9jsOGnuWxUDVsIH/uzncbK2YpsMIXfQgi6vZvvj2zP4ei/2v/kDptRwQz01i
 oXPgMlLMuWriTEm+UXL0UFiTis65GE592Q0ODhmqgSiaE6B8Llxf/c3+iZ5ZnOyoH+ru
 c/f1tDdUis5ERjmPtbCr8qtw1EY7lD/SbhOIPA7mXAzdETC5WgIMFHqJbJxNWGOPcsLb
 1fiPluQjdagGtj2CjSiz8SOM7DlPZJEIfO6zf5jQu6xKZVt1xGj9P6OB6nQlH3oPCO4q
 Ky6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735902818; x=1736507618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqMtU8J8RTjUYL2gkNXl4sjSogDVUkn/i1sjdMFI5vU=;
 b=G4aVzJoFDvCuUISqAvqU5G1OGRMt3jwkQht+M7nUUtBqLzGQbr9SMXKxwC2D6PBr7p
 LLBSohTrL7baHvBgSidoi9ODnpeTQ9YPMKxJlLtgMQhGAJXX7iZAPIfCnXyF43B1cGFo
 fpUVcBs+mfVbAKy5mrNj8ztyalNGVtKd2pW0lHOdRmkvCFnu7tSA9M09MYKHdxVptT/G
 PQjNuTQeaHH3DcFMgL8ddr8IMayCVUr/wH/uX1jyAIDbGdIDtEJ+41fi3P0Zv8AeRbyS
 FbJ7725JfFhbT9eLo5fn0assBmaMsb9QkRF8WSdDeuqM3Lw4L4FYBpNYBcysNv5E6ORe
 zDlQ==
X-Gm-Message-State: AOJu0Yz52NHz5corhO/pzwVwgSa3NJx39rks2rIElIFl0Gr894YFSxTk
 P7w9I60qgOd4u5JrSUjIpxK6a6aepHrwqkqf+pwzLoUkaf+tE2cikOL0khNFu9sDmCNZsMzrMxC
 FvKA=
X-Gm-Gg: ASbGncvrCmCIoItm0FHqqMq32esPJpRJIytBGABUyz6jVkKRZ63QagLv/TjJ12Gz6ej
 VOYLjKtrf+WCN37ID7qeMrdpUMQbMyYAi43Plif+LWNkmnxT/AN4rhQKcJHXqUQicLm6km/USFr
 CZr1ZMt7jFxx85k/KcssKx5LdNHJVycr0Dogr+uuyy7gU5is2dvJdQVswCDpfCQ7p4EIYphNIJT
 BIhVNq0tsizVTqaDtIWK9TVIMLnkAInWj+oD08RgsCyN1hPrVc7vNDw7B4xIqDK1g==
X-Google-Smtp-Source: AGHT+IGnqijkMFUA9Sfzt6PUNcAmDOQhzogGHrPAOi0S39h6r79SdJitNn/RztmjpWDf2TVR2SkxVg==
X-Received: by 2002:a05:600c:6a87:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-4366fb8a411mr415625465e9.16.1735902818315; 
 Fri, 03 Jan 2025 03:13:38 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm513138075e9.0.2025.01.03.03.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 03:13:38 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v3 3/5] board_init_f_r(): use static calls
Date: Fri,  3 Jan 2025 12:13:15 +0100
Message-ID: <18e378cd3cd3b9d5dd99d39d997d67b04921f182.1735896540.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735896540.git.jerome.forissier@linaro.org>
References: <cover.1735896540.git.jerome.forissier@linaro.org>
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

Replace the init_sequence_f_r function array by direct calls.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_f.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index c2446ba344d..bd04a6eedcd 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1020,8 +1020,8 @@ void board_init_f(ulong boot_flags)
 /*
  * For now this code is only used on x86.
  *
- * init_sequence_f_r is the list of init functions which are run when
- * U-Boot is executing from Flash with a semi-limited 'C' environment.
+ * Run init functions which are run when U-Boot is executing from Flash with a
+ * semi-limited 'C' environment.
  * The following limitations must be considered when implementing an
  * '_f_r' function:
  *  - 'static' variables are read-only
@@ -1034,18 +1034,14 @@ void board_init_f(ulong boot_flags)
  * NOTE: At present only x86 uses this route, but it is intended that
  * all archs will move to this when generic relocation is implemented.
  */
-static const init_fnc_t init_sequence_f_r[] = {
-#if !CONFIG_IS_ENABLED(X86_64)
-	init_cache_f_r,
-#endif
-
-	NULL,
-};
+static void initcall_run_f_r(void)
+{
+	CONFIG_IS_ENABLED(X86_64, (INITCALL(init_cache_f_r);))
+}
 
 void board_init_f_r(void)
 {
-	if (initcall_run_list(init_sequence_f_r))
-		hang();
+	initcall_run_f_r();
 
 	/*
 	 * The pre-relocation drivers may be using memory that has now gone
-- 
2.43.0

