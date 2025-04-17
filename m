Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0939AC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C18F83108;
	Thu, 17 Apr 2025 20:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oDywnccH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E3D830E4; Thu, 17 Apr 2025 20:17:05 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30ACF81E14
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d5e43e4725so2760135ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913821; x=1745518621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RS5XQn/RyCf37J6HIuCxoN9XpKDPzZvDAYlKSDHaHY=;
 b=oDywnccHi+9+z6vUs7oQBPCWmaBajjhQ2CUVFxz7ABxbnjhibsyNtyWAvTo059w33Q
 d+xxrefSZVQQk16uSd5wc4HnO4DmQrG4eVwm4DHxbIpIZRmzWc/uIn7SQSIs8sqjxgwz
 OS3gW3uM0ncF7IGubayeg71MppCHZybVYEhP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913821; x=1745518621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RS5XQn/RyCf37J6HIuCxoN9XpKDPzZvDAYlKSDHaHY=;
 b=VHhn6EHsMbEuTxXKrZLPfoKLpNy/F8mV+xXhkuQQQtpRrWwISQm7KTBxLUrQ+DGs9z
 xHaEOkGVfx/dTGuxUJWOsVXV8tXAT+tOOMhsn32m1B+GDV2Wv3esviRYLnD/Yom3pkQ5
 /UnmbZKzoTw+lg7x0ZYa5lmBrjXzOTTkAY7Ox7l03fIoxZpLqVAHTTHmhJUU3MExYXEd
 DvL1UuQgtPD31a/LMXGLIwO85HUM0ygumz8S7avxt474cXoopN8yK2/ZzMlGmLQd5BrD
 D02rM4oI51z753ZzqjOXfYJMP5nDtF3riG+bCC7tkz4qthwSl8etXZnRiIjix24Xr2Zw
 lFxg==
X-Gm-Message-State: AOJu0YzAS3AxxFn4QlEXpX5zAdj1trws2TwK+1D5WPaJ3EvZZNu3aLBX
 GElrnjgEXY1Ue55JtzG9HElk05kjVLrU+4ejrDGaqws0c//IX5NjHpKr/Dv1r9kb4ubKIuDLhek
 =
X-Gm-Gg: ASbGncvGMUqZtjU63uw1DsfSzTN2sbJTE5tDOg9MtmFOrglr4WLp5gWcVpLkXO4sgqn
 ntYJLEVNiNF6+G5JlP04XDWRyBt1VStbZLU67wb5BVQMk0C3cJk8skW8ux7A81aerJYhuc5GCmH
 5YnODG5YITTXyUWouQG2oiV7juSisrg+v5n81fEECQ0HKxE1aFD5BO7AvrdyUnAb25ambXpJZXs
 E8eHl6M3QtRgzJHmQizF/bHpQlf/y50I3Tq+lJ2UyrYbdAtJ9i/ecusYHSpQ912wDdH0c0/CxDs
 jyAhHZ1ySMWId0lteYsiVnBpjsXSq/Zw0I8ly2kR3THUApRVq+BYU5UHa7WiG3ZTnBijoKQtxE9
 r8g==
X-Google-Smtp-Source: AGHT+IGNvTglm2z5Egq7qFV0Zt+koL2AhjdD8NEQiIZ4dvS/ofM2I1lVSiMsVOQ/FGmppbz+iU04cw==
X-Received: by 2002:a05:6e02:214f:b0:3d8:1b0b:c92b with SMTP id
 e9e14a558f8ab-3d88ed7c360mr1339265ab.2.1744913821170; 
 Thu, 17 Apr 2025 11:17:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alex Shumsky <alexthreed@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 11/22] passage: spl: Support adding the dtb to the passage
 bloblist
Date: Thu, 17 Apr 2025 12:15:53 -0600
Message-ID: <20250417121601.v3.11.Id6acd05e6730b3301ddc62b415a155202ddba74b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

Add an option for SPL to add a devicetree to the passage bloblist, so
SPL can provide the devicetree to U-Boot.

Fix a few long lines while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase on -master
- Update the commit message to mention the long lines

 common/Kconfig   | 20 ++++++++++++++++++++
 common/spl/spl.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 include/spl.h    |  2 ++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index c6a8fa54363..1f908790139 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1243,6 +1243,26 @@ config SPL_PASSAGE_IN
 	  firmware phases to communicate state and settings to following
 	  phases.
 
+config SPL_PASSAGE_OUT
+	bool "Support the standard-passage protocol in SPL (out)"
+	depends on SPL_BLOBLIST
+	default y if PASSAGE_IN
+	help
+	  This enables a standard protocol for entering U-Boot, providing
+	  parameters in a bloblist and a devicetree. It allows the various
+	  firmware stages to communicate state and settings to following
+	  stages.
+
+config SPL_PASSAGE_ADD_DTB
+	bool "Add devicetree to the outgoing passage"
+	depends on SPL_PASSAGE_OUT
+	default y if SPL_PASSAGE_OUT && !SPL_PASSAGE_IN
+	help
+	  Add the devicetree into the bloblist in SPL (it is assumed to not
+	  already be there) so that the next phase (U-Boot) can find it.
+
+	  This option should be enabled in the phase that sets up the passage.
+
 source "common/spl/Kconfig"
 
 config IMAGE_SIGN_INFO
diff --git a/common/spl/spl.c b/common/spl/spl.c
index f14c68c46a5..6e38f118f48 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -66,6 +66,11 @@ binman_sym_declare(ulong, u_boot_vpl_any, size);
 
 #endif /* BINMAN_UBOOT_SYMBOLS */
 
+#if CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)
+binman_sym_declare(ulong, u_boot_dtb, image_pos);
+binman_sym_declare(ulong, u_boot_dtb, size);
+#endif
+
 /* Define board data structure */
 static struct bd_info bdata __attribute__ ((section(".data")));
 
@@ -412,7 +417,8 @@ static int setup_spl_handoff(void)
 {
 	struct spl_handoff *ho;
 
-	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			     sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 
@@ -429,7 +435,8 @@ static int write_spl_handoff(void)
 	struct spl_handoff *ho;
 	int ret;
 
-	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			   sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 	handoff_save_dram(ho);
@@ -446,6 +453,33 @@ static inline int write_spl_handoff(void) { return 0; }
 
 #endif /* HANDOFF */
 
+/**
+ * Write the devicetree for the next phase into the passage
+ *
+ * For now we assume the next phase is U-Boot proper
+ *
+ * @return 0 on success,  -ENOSPC if it is missing and could not be added due to
+ *	lack of space, or -ESPIPE it exists but has the wrong size
+ */
+static int passage_write_dtb(void)
+{
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ulong start = binman_sym(ulong, u_boot_dtb, image_pos);
+		ulong size = binman_sym(ulong, u_boot_dtb, size);
+		void *dtb;
+		int ret;
+
+		log_debug("passage: Adding control dtb size %lx\n", size);
+		ret = bloblist_ensure_size(BLOBLISTT_CONTROL_FDT, size, 0,
+					   (void **)&dtb);
+		if (ret)
+			return ret;
+		memcpy(dtb, map_sysmem(start, size), size);
+	}
+
+	return 0;
+}
+
 /**
  * get_bootstage_id() - Get the bootstage ID to emit
  *
@@ -835,6 +869,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			hang();
 		}
 	}
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ret = passage_write_dtb();
+		if (ret)
+			printf(PHASE_PROMPT "Write DTB failed (err=%d)\n", ret);
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..4fa97078a31 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -441,6 +441,8 @@ binman_sym_extern(ulong, u_boot_spl_any, image_pos);
 binman_sym_extern(ulong, u_boot_spl_any, size);
 binman_sym_extern(ulong, u_boot_vpl_any, image_pos);
 binman_sym_extern(ulong, u_boot_vpl_any, size);
+binman_sym_extern(ulong, u_boot_dtb, image_pos);
+binman_sym_extern(ulong, u_boot_dtb, size);
 
 /**
  * spl_get_image_pos() - get the image position of the next phase
-- 
2.43.0

