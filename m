Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D43C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FA588842;
	Sat, 13 Jul 2024 09:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cm7i+WMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD22F8885C; Sat, 13 Jul 2024 09:03:59 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A16F88837
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso21888435e9.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854236; x=1721459036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PKOtJvOy1CA0WG0eRA456jvZ0IzOCNqYobg25Ql9zY=;
 b=Cm7i+WMZtUPJjB7IoP+s2k1kRqNsITNeRqH17wPBe4aoe65QsasOsZWDWCFw66jnBz
 p+SqPTEmRGqcLMz8fSJ7MCxPetUath5xW6qBzG3Gf3yxn+X3u0rUCntPCb+cLOecPrq3
 C13/KGXvUh+UjaSXHlt4zUbekxTMhcxKLlwXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854236; x=1721459036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PKOtJvOy1CA0WG0eRA456jvZ0IzOCNqYobg25Ql9zY=;
 b=FZyygddkXigsQQzWuBtudc8PXty1m0ZWeWT+wrGjO/aRF1H/ytWRI24HTjy2qBj59R
 HVXL28IEUZULv8/JP9g1TXMvfu3Y5iFZ/ut+/xJwwVXk1ChgLaUHFebxoOJakQQIxe8h
 mQQQwYrx6V4Mnf57rCGonwUVNIcDLpuEpM0yzj+fHnqwUHJTamS1U7RT/nW3e599Dl9k
 1tmyD9Om8wzM1LNWZTrXkHWadXiSEUn3YvjNW2mZP5bDQVJyJu8xWGerC8ze8E8og4Yj
 4wkWshgopYAicj5PNtpKGblTf9ospk5073D39BYHkuI8fOARtodmZ77Q//uMhOPSpHOW
 ZTOw==
X-Gm-Message-State: AOJu0Yyn4s9VIrsJ0s8wPhZe2zyqI+GfT8kabjBiwwmCMetzb01ZkV7B
 IJEwCtNAK92OxdIag3Qaw/6oDn4BrtcOMKquIJ9IbUx5Gam4/evMA7MIDQpmLlGyFIQmMCZt/x8
 =
X-Google-Smtp-Source: AGHT+IGqZ0EEh20nDMVjeQJX41gjfT7eX4eTRMssZDhxUWmmFh6AG6W6I/CwcpjsOnVCXAk7eSOPpA==
X-Received: by 2002:a05:600c:19cc:b0:426:706c:a55a with SMTP id
 5b1f17b1804b1-4279d9f287amr45990635e9.2.1720854235700; 
 Sat, 13 Jul 2024 00:03:55 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/21] upl: Plumb in universal payload to the init process
Date: Sat, 13 Jul 2024 08:00:50 +0100
Message-Id: <20240713070055.2172883-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Read the UPL early in boot so that it is available. For now none of the
information is used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig     | 12 +++++++++++-
 common/board_f.c | 22 ++++++++++++++++++++++
 common/board_r.c |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 3b7c8dd663c..e0bbfcede8a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -737,7 +737,9 @@ config UPL_READ
 	help
 	  Provides support for decoding a UPL-format payload into a C structure
 	  which can be used elsewhere in U-Boot. This is just the reading
-	  implementation, useful for trying it out.
+	  implementation, useful for trying it out. See UPL_IN for how
+	  to tell U-Boot to actually read it on startup and use it for memory
+	  and device information, etc.
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
@@ -748,6 +750,14 @@ config UPL_WRITE
 	  for how to tell U-Boot SPL to actually write it before jumping to
 	  the next phase.
 
+config UPL_IN
+	bool "upl - Read the UPL handoff on startup"
+	select UPL_READ
+	help
+	  Read an SPL handoff when U-Boot starts and use it to provide
+	  devices, memory layout, etc. required by U-Boot. This allows U-Boot
+	  to function as a payload in the meaning of the specification.
+
 if SPL
 
 config SPL_UPL
diff --git a/common/board_f.c b/common/board_f.c
index 212ffb3090b..d0187c50b49 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -40,6 +40,7 @@
 #include <sysreset.h>
 #include <timer.h>
 #include <trace.h>
+#include <upl.h>
 #include <video.h>
 #include <watchdog.h>
 #include <asm/cache.h>
@@ -862,6 +863,26 @@ __weak int clear_bss(void)
 	return 0;
 }
 
+static int initf_upl(void)
+{
+	struct upl *upl;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_UPL_IN) || !(gd->flags & GD_FLG_UPL))
+		return 0;
+
+	upl = malloc(sizeof(struct upl));
+	if (upl)
+		ret = upl_read_handoff(upl, oftree_default());
+	if (ret) {
+		printf("UPL handoff: read failure (err=%dE)\n", ret);
+		return ret;
+	}
+	gd_set_upl(upl);
+
+	return 0;
+}
+
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
 #ifdef CONFIG_OF_CONTROL
@@ -871,6 +892,7 @@ static const init_fnc_t init_sequence_f[] = {
 	trace_early_init,
 #endif
 	initf_malloc,
+	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
diff --git a/common/board_r.c b/common/board_r.c
index d4ba245ac69..f445803d7a4 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -521,6 +521,8 @@ static int dm_announce(void)
 		       uclass_count);
 		if (CONFIG_IS_ENABLED(OF_REAL))
 			printf(", devicetree: %s", fdtdec_get_srcname());
+		if (CONFIG_IS_ENABLED(UPL))
+			printf(", universal payload active");
 		printf("\n");
 		if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE) &&
 		    (gd->fdt_src == FDTSRC_SEPARATE ||
-- 
2.34.1

