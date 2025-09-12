Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27249CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6BA83322;
	Sat, 13 Sep 2025 00:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SpscXVet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06696833F9; Sat, 13 Sep 2025 00:58:26 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF92F830A0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-62189987b54so1394418eaf.3
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757717902; x=1758322702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SCqp5IxluAxJXanNldSwEp2zy0lUPk8xAejmq+XpiAM=;
 b=SpscXVetab/sDcmld7j2aYyxr9OfTHGIigVgl43llnndYUfPVA1Yaa+K2XfUsMrG6k
 c16OVm304Q1o1Yzz3JrVk4HkuxPW4sjFf8t0bYWgkqU4kQt6wqBmbMoSscUwBJ+mi68r
 3FlVk6kUB07GprOOMqXeEOGbU/DiIqeKuGnyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757717902; x=1758322702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SCqp5IxluAxJXanNldSwEp2zy0lUPk8xAejmq+XpiAM=;
 b=DGFbyLiHo37q7DWFFFJJQktnZR1BxL4oeR2ufUJ/pkvkuRfc9kSeJTNlHR6jtW4OaO
 ppV5bG+YsDVzZlwid0w2o71rsh9V/lma2lZJanIdwjWeszXpdhbRSmvasOWv50U9Tcdq
 ggW7arzW8U9T9tgpLC6721DtfDW/Nu9spmEAepgYQR1mT9Fmjb4G+cvIKzmv4JjY1bo+
 1+eDnW9unzKdqiZ4Nop1HjqJQ/V0kMQPbsGaYOLOvFA9NZ+3hMFicqFr+vDAJqOaOO/4
 wXODGMP1xqO91wp85D9DJ/TiE6fx5cruNYl1BIthM1E/AYZxHyB9z3VFi+kXwpU7hJwn
 Tq2g==
X-Gm-Message-State: AOJu0YyP4J2DWgqsnFWwPY2Y0+ppQPp/rmPiifQJd2Rwx+4YqlZ5qEcm
 RWksuBZiEdvC8s38Y8vERbnCW4bYopWRZiP0ageEljRZXn2EZZPzMLFFBEcodS3AFrItKDt5Q2J
 oyEe8zAk=
X-Gm-Gg: ASbGncugEVyREpcsGEjFUC4vsoOtoq37sZLdzgqkiIjwtnnfYiZ7fmkhFe1bL6/B6uf
 hMrvzB7UBu2szq92WKKVslDy+KQJ0UScUX8/H0XCXWTnlMNuR2v+rkgRxZU65Y0HnVE/GOkt9TH
 3PbNoPU1jjlDDidwIbN7PCw62IO9B42HGAelgCUNzn7anDTf7y87klUa2l5JxWm3+ftsgSkLGzq
 BJv/XqzwEkkhkZpoS2FXvf1kjDdRzrsw2w8Mtm6sAij/VywwJZj9WP4DycZdeIn2vqLyZB2IwKX
 IoiLWsMixFQvp02OiB1wj4wU7loahMAmu6JNdg20ZKXo8WHeq98L4oRMZOEDKdiUVlt5YCD/k+c
 aiebRGyKwx3nKT9o13fUlKlyl10nnmt7mXbu1YNhhKks0y5ATjYiVgxnfM4p2QGeSmO7taQ==
X-Google-Smtp-Source: AGHT+IFBIGNBz9YHl6QBefHFhRLhoPfgN/q56YzWgP0WR/9Q1k0vAKunVbk0fhGDh6UYdpcxubxd/g==
X-Received: by 2002:a05:6870:2e06:b0:31d:8edc:3d1a with SMTP id
 586e51a60fabf-32e5477e076mr1984455fac.7.1757717902451; 
 Fri, 12 Sep 2025 15:58:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d3002ac48sm1517098fac.0.2025.09.12.15.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:58:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] Revert "sandbox: replace deprecated getenv() with env_get()"
Date: Fri, 12 Sep 2025 16:58:20 -0600
Message-ID: <20250912225820.4144317-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

While testing changes, I missed that Gitlab had failed CI with pytest
failures due to this change.

This reverts commit 4c822970d366415e717730606734e815993a70bb.

Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/cpu/os.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index adb6b5869469..f5c9a8aecf2e 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -35,7 +35,6 @@
 #include <asm/state.h>
 #include <os.h>
 #include <rtc_def.h>
-#include <env.h>
 
 /* Environment variable for time offset */
 #define ENV_TIME_OFFSET "UBOOT_SB_TIME_OFFSET"
@@ -284,7 +283,7 @@ int os_unmap(void *buf, int size)
 
 int os_persistent_file(char *buf, int maxsize, const char *fname)
 {
-	const char *dirname = env_get("U_BOOT_PERSISTENT_DATA_DIR");
+	const char *dirname = getenv("U_BOOT_PERSISTENT_DATA_DIR");
 	char *ptr;
 	int len;
 
@@ -1015,7 +1014,7 @@ long os_get_time_offset(void)
 {
 	const char *offset;
 
-	offset = env_get(ENV_TIME_OFFSET);
+	offset = getenv(ENV_TIME_OFFSET);
 	if (offset)
 		return strtol(offset, NULL, 0);
 	return 0;
@@ -1133,7 +1132,7 @@ static void *fuzzer_thread(void * ptr)
 	const char *fuzz_test;
 
 	/* Find which test to run from an environment variable. */
-	fuzz_test = env_get("UBOOT_SB_FUZZ_TEST");
+	fuzz_test = getenv("UBOOT_SB_FUZZ_TEST");
 	if (!fuzz_test)
 		os_abort();
 
-- 
2.43.0

