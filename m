Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270DCD37B6
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 08:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1384D864D7;
	Sat, 16 Sep 2023 10:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TizCIJug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBC686538; Sat, 16 Sep 2023 10:25:08 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E6E0862B6
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 10:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-404571cbb8dso29325165e9.3
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 01:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694852701; x=1695457501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=9tq2vHEeiO1F3TUExjOv1mbMVoQjoL8a94+M35YaAN8=;
 b=TizCIJug5LucuM0QGd0ZO5SzZ65I1IEE1ruzhsAaC+NZ/0sO/HWRzNuUiDDw9KaQFx
 3GeE0DBDPuDxZMqfM1YPzs9VSzIUfUqB9RwHnBEu/LlggSQtYMzMMJwzOfEh9uL+2ztA
 pjMbkErJNyNtnIfPgMhI61sQ9iHgl2rjT3jIdIuyAQBUzvYEAdn94Y1YNt6awjXYTexT
 FZeNqMVdVMg4vBC380YDi4Mhb/ZT4VLVIZ8bPm7t4ajBDtkfGBXXt2vpxkLNWHeP2pLm
 I+/HmueCUpaR8yg0F9870CSYgP05CASG95K/74Y7v0inmXD8oqKeoj+4lgc4RzRUDcqb
 ym4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694852701; x=1695457501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tq2vHEeiO1F3TUExjOv1mbMVoQjoL8a94+M35YaAN8=;
 b=nfh7V0U/+4t2CjCz/ePJbU87xQE8TSUdbQsodctRSYe5ZYJRp7udfx397Vh/78hBmI
 AAGVHvGuE34069A8d2FQhfp5DqXoF7qQ2yJtVfW1sO89uwwlVe+pkk5iTw3aXp3HIpPw
 UjiLTj164sMfhOhTOfWalIfo2Lf0w47M0LNrdPY4gsg0mNwtraEx6thHko4pfqrC04xO
 2tFqVM1fKROdOsPhIrc29GD2/WBL+L0bmEr3nNo0K1JANmeJbNAoCOe2zh75knBpSb+Z
 GKCT94JRQja0Hsn3bteDSnA5ADH/UD57FspTKc1mV9UPIVGRwuLsRDX4TjKeDK++dnL6
 RDCw==
X-Gm-Message-State: AOJu0YzKNfi4MKT6HF//Z9sM4O/fj8bRvze/EAJzpYLzdO1a6qARDrpv
 b2tXrLfqF36EbKxbmHXhi3eg0XV2s1Q=
X-Google-Smtp-Source: AGHT+IFpCDSJE2trC7Ohr+yzmFkADIUt26sF8sNp+FaekC8aYAVlzKlZ/wYeSr8vGEZ68awSLL9yiA==
X-Received: by 2002:a05:600c:210c:b0:401:b1c6:97e8 with SMTP id
 u12-20020a05600c210c00b00401b1c697e8mr3584049wml.36.1694852700674; 
 Sat, 16 Sep 2023 01:25:00 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.172.204])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c364600b003fe2bea77ccsm6687183wmq.5.2023.09.16.01.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:25:00 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 3/4] spl: atf: Fix potential but not occurring bug
Date: Sat, 16 Sep 2023 10:24:57 +0200
Message-Id: <20230916082457.583383-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Bug: function spl_fit_images_get_entry returns uninitialized variable
val if both fit_image_get_entry() and fit_image_get_load() fail (note
that both of them do not set val on failure). Fix: use val only if
entry or load address has been retrieved successfully.

Note: in real world a failure of fit_image_get_load() will make current
SPL flow to break on loading images, see spl_load_fit_image(), before
entering spl_invoke_atf().

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 common/spl/spl_atf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3d022ed4e7..0d8db2d14e 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -238,17 +238,16 @@ static int spl_fit_images_find(void *blob, int os)
 	return -FDT_ERR_NOTFOUND;
 }
 
-uintptr_t spl_fit_images_get_entry(void *blob, int node)
+void spl_fit_images_get_entry(void *blob, int node, uintptr_t *entry_p)
 {
 	ulong val;
-	int ret;
 
-	ret = fit_image_get_entry(blob, node, &val);
-	if (ret)
-		ret = fit_image_get_load(blob, node, &val);
+	if (fit_image_get_entry(blob, node, &val))
+		if (fit_image_get_load(blob, node, &val))
+			return;
 
 	debug("%s: entry point 0x%lx\n", __func__, val);
-	return val;
+	*entry_p = val;
 }
 
 void spl_invoke_atf(struct spl_image_info *spl_image)
@@ -266,7 +265,7 @@ void spl_invoke_atf(struct spl_image_info *spl_image)
 	 */
 	node = spl_fit_images_find(blob, IH_OS_TEE);
 	if (node >= 0)
-		bl32_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl32_entry);
 
 	/*
 	 * Find (in /fit-images) the U-Boot binary entry point address
@@ -277,7 +276,7 @@ void spl_invoke_atf(struct spl_image_info *spl_image)
 
 	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
 	if (node >= 0)
-		bl33_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl33_entry);
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
-- 
2.34.1

