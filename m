Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFABC38147
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F1D87C9D;
	Sat, 16 Dec 2023 04:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aJQ+UTus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E49987C11; Sat, 16 Dec 2023 04:15:26 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C3387C69
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35d718382b7so5508355ab.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696522; x=1703301322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4z0C3ODXLlsaBmBn4ZpZJPR0UfhhYXFJuo+1Vp8kLQ=;
 b=aJQ+UTuslKtLE+QfFsRWcDbcQa/3SBV5JouDFVYyvauzANGTNz04ZaeC8u1Kee0BT2
 xP50VBoZ+eBifjE9pgNE2a1f2XIa9Uzu12vsP53LVtaxrO0AWKLsR6StBoH6IJK2qoCi
 1JgyyX+8EfG8YPHI6yObCHifSHjYMhXyaqdw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696522; x=1703301322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4z0C3ODXLlsaBmBn4ZpZJPR0UfhhYXFJuo+1Vp8kLQ=;
 b=BkY9yDpoGyXQpZnYb7lCzPgvGJR19Zf2svjNvBBIr5C+JSgdtRkPVZljsDZ0WZUdMG
 GcR8WNPcLy8wFllbKFRWFJ5kHOrtyi6lSyYXIN4NckzLPRX08bvZbeV5PmEnqukfL/YV
 a31smfBVJyqaMvU2JaHvypnkHfn9DZBvO310I4tR4k3yEyOK9J4xo8R8Gw80M0dGAe4j
 3/1sV4ylKU5R9AuQB6ghpNAn9C+nrO5z9jV5KrDqB3YMHfhEvjFVB7XWZNGOfNqpr+as
 5Lc73lkyB7g7fU68VM1x6afBGaOuzJRXTvBi3L2ImPpzwkdfBkCgxqZii5jZ3Lch6gxV
 5Uxg==
X-Gm-Message-State: AOJu0YzXHKZ28csu2Rjubq0zrMv6MoZN6GTeKABTGG+9u8Bwch5GCTAt
 abf1/3sWwVediB49UVO5VxQvjE8rXj9l5IwVwLEFUA==
X-Google-Smtp-Source: AGHT+IGb71vixC7tvF5p3RvDTtDS+5pDkNCGy8qdxcC3koiqR4BYDFxOEKfETBjAM+GVZh70RA1emA==
X-Received: by 2002:a05:6e02:310e:b0:35f:9bad:cf0d with SMTP id
 bg14-20020a056e02310e00b0035f9badcf0dmr1231171ilb.28.1702696522149; 
 Fri, 15 Dec 2023 19:15:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 16/22] bootm: Tidy up boot_selected_os()
Date: Fri, 15 Dec 2023 20:14:20 -0700
Message-ID: <20231216031446.2222362-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

Use struct bootm_info with this function, to avoiding needing to
create a new one.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c    |  6 ++----
 boot/bootm_os.c | 11 +++--------
 include/bootm.h |  3 +--
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f009e9ace652..66b7e350aa86 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1092,8 +1092,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_OS_FAKE_GO)) {
 		char *cmd_list = env_get("fakegocmd");
 
-		ret = boot_selected_os(bmi->argc, bmi->argv,
-				       BOOTM_STATE_OS_FAKE_GO, images, boot_fn);
+		ret = boot_selected_os(BOOTM_STATE_OS_FAKE_GO, bmi, boot_fn);
 		if (!ret && cmd_list)
 			ret = run_command_list(cmd_list, -1, 0);
 	}
@@ -1107,8 +1106,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 
 	/* Now run the OS! We hope this doesn't return */
 	if (!ret && (states & BOOTM_STATE_OS_GO))
-		ret = boot_selected_os(bmi->argc, bmi->argv, BOOTM_STATE_OS_GO,
-				       images, boot_fn);
+		ret = boot_selected_os(BOOTM_STATE_OS_GO, bmi, boot_fn);
 
 	/* Deal with any fallout */
 err:
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 4f547b1b1148..47a5fd78fb6a 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -566,20 +566,15 @@ __weak void board_preboot_os(void)
 	/* please define board specific board_preboot_os() */
 }
 
-int boot_selected_os(int argc, char *const argv[], int state,
-		     struct bootm_headers *images, boot_os_fn *boot_fn)
+int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
 {
-	struct bootm_info bmi;
 	arch_preboot_os();
 	board_preboot_os();
 
-	bmi.argc = argc;
-	bmi.argv = argv;
-	bmi.images = images;
-	boot_fn(state, &bmi);
+	boot_fn(state, bmi);
 
 	/* Stand-alone may return when 'autostart' is 'no' */
-	if (images->os.type == IH_TYPE_STANDALONE ||
+	if (bmi->images->os.type == IH_TYPE_STANDALONE ||
 	    IS_ENABLED(CONFIG_SANDBOX) ||
 	    state == BOOTM_STATE_OS_FAKE_GO) /* We expect to return */
 		return 0;
diff --git a/include/bootm.h b/include/bootm.h
index dbf883bb08ad..628d3d3e83ff 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -91,8 +91,7 @@ boot_os_fn *bootm_os_get_boot_func(int os);
 int bootm_host_load_images(const void *fit, int cfg_noffset);
 #endif
 
-int boot_selected_os(int argc, char *const argv[], int state,
-		     struct bootm_headers *images, boot_os_fn *boot_fn);
+int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn);
 
 ulong bootm_disable_interrupts(void);
 
-- 
2.43.0.472.g3155946c3a-goog

