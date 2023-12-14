Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721FB87B2A;
	Thu, 14 Dec 2023 17:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WnplycoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E1487AE7; Thu, 14 Dec 2023 17:52:01 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E5687AF9
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b35d476d61so303854339f.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572717; x=1703177517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRr8b7Poc/WKtouA47TVAoXD1yJDjkgBDbJ32AjogI4=;
 b=WnplycoKGira+zxG8RhWpomoMp5lgVEJKZLZJJx3uoGcDw25a9H0Qt1VN+6ZMzFc5e
 rx3sdDiAIORMHUH5skVYb7fAxbSXapSVxE8hzEt8UbMDL9L/SEmXyW3XQNFgFNBS0pHC
 JdhCDHK/EgdLubIhjmH5iGhYIO3GkfvXg87nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572717; x=1703177517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRr8b7Poc/WKtouA47TVAoXD1yJDjkgBDbJ32AjogI4=;
 b=Ls0L3E+wVuWcQrbZV10kS6hMD7hxA8tI2+nq0wtmFHHoZRbl3iIUdG4p4p5jRklkRF
 1xMXNAPVLPninPhrxoRDVA3AwAu2X66WVN1z9TAwraGY/k4nE/ovvJInYiqxep9TGrMm
 ou3iR2yEibl2IF1bb6hnvxRu/fKkboevFCi5LKnpYnkUIuw1pu2VdtlifKVkGUhhyBP8
 zDs9wbIneoVmOnR19nzMrJhGWH5/jrI+5Y2dIQvAgShp63F01UuWD7ddpYXTe/WtiOKd
 2eUIBW0RKSbQYUag01wWHxl391S+ZAfLPiOPpmOlJjc9b/dF7qsos420RSW88Qc7fB8s
 x3Sw==
X-Gm-Message-State: AOJu0YzFUNbRGNMjB3GI3PWVoWNyx6S6Kp3OmXd7gPBxbGdeTMH2Ls/2
 Ljabu5i8vhWq4/6ANFAC/YG7I1pn9+1UUj7BYgs1kg==
X-Google-Smtp-Source: AGHT+IHhIgsL5CRvwnmtQlv0+w+3yPSKjal/BaHEYmv6jB8wIW4s8pSTrEbLIT3TL3dPjyBbAEHIZw==
X-Received: by 2002:a05:6e02:20e2:b0:35e:6c7c:b369 with SMTP id
 q2-20020a056e0220e200b0035e6c7cb369mr13633667ilv.16.1702572717274; 
 Thu, 14 Dec 2023 08:51:57 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 16/21] bootm: Tidy up boot_selected_os()
Date: Thu, 14 Dec 2023 09:50:25 -0700
Message-ID: <20231214165112.2182274-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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
---

(no changes since v1)

 boot/bootm.c    |  6 ++----
 boot/bootm_os.c | 11 +++--------
 include/bootm.h |  3 +--
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index bd208c0493ca..f9f0c9782e42 100644
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
index 45109f96695d..d0749dc5257a 100644
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

