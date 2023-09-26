Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2865AE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415C286E98;
	Tue, 26 Sep 2023 16:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ILvJH6+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A1586E3B; Tue, 26 Sep 2023 16:16:04 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706B386E49
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79fe612beabso23166839f.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737757; x=1696342557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNgyPfEDnrgql0TYpgBywuNZ9ggHpU7BSYJxBpnKIYg=;
 b=ILvJH6+ljqzQmRCDNWu5vp41hvN+mb9JeJmk8D5QAtJTTWPo7ME9wTQvNoCOZqx99C
 NOvEWqJ+kt42bAhN6SZSXT7WntYMHIJBIK6asON7aVWX5I8594liuC3ig/Vq5WNLhBEy
 SCN2ZRaTC+pcyjDO3uufV856fT5W4P1ILSJI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737757; x=1696342557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNgyPfEDnrgql0TYpgBywuNZ9ggHpU7BSYJxBpnKIYg=;
 b=RB7r+9c0yqtZb1roapYpgA0u6kfxk6D6pHlxL8TdE9mYrGaVRUWmJ6xyD7HcdumWDw
 5mFRE1uF6AyA21/yLgSSPDZLZDXTXWDNHkY3stC19VDZ1NWKoTMugPwqm4BabQs376ca
 rmFu96cNIRJqWv5vX+VYQfBQXwRqT+CMwYCh2S4EUmFvPnplr4GfjVGeSaJCcvXoANnF
 Ho7U0+IUkKM8wqv2qT9t9u9H2urCkEl4laFxOBwiuYashx+qM2pvb/5nMWhXZvA4rQGU
 BLjNRCGw3lXFECY1+KaaCRkEsyMFyf/XUN6gAgtSMB7JfeHqpqs9OmS55AA2tBKsH0PM
 SUTw==
X-Gm-Message-State: AOJu0YxPIqKnGzYlf193TRlKUW9TdMiWWcCMltKWKgL4qaVCALcbgzBl
 qpc7oqA831ZXR7Mp6rcnBrWb4TJTpsgvN0RwOk0=
X-Google-Smtp-Source: AGHT+IGmsKAkRxOEJAJLKc3zRYodDfotzJwrTqjbY4BqiQ6DePgWs3xz4EPqoc/sFlswo0dSqmBTig==
X-Received: by 2002:a5d:930b:0:b0:790:f866:d717 with SMTP id
 l11-20020a5d930b000000b00790f866d717mr10625284ion.10.1695737757047; 
 Tue, 26 Sep 2023 07:15:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 33/44] sandbox: Move reading the RAM buffer into a better
 place
Date: Tue, 26 Sep 2023 08:14:47 -0600
Message-ID: <20230926141514.2101787-34-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

This should not happen in the argument-parsing function. Move it to the
main program.

Add some debugging for reading/writing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 19 +++++++++++--------
 arch/sandbox/cpu/state.c |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index bbd9e77afed9..8582f05162fa 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -272,17 +272,9 @@ SANDBOX_CMDLINE_OPT_SHORT(program, 'p', 1, "U-Boot program name");
 static int sandbox_cmdline_cb_memory(struct sandbox_state *state,
 				     const char *arg)
 {
-	int err;
-
 	/* For now assume we always want to write it */
 	state->write_ram_buf = true;
 	state->ram_buf_fname = arg;
-
-	err = os_read_ram_buf(arg);
-	if (err) {
-		printf("Failed to read RAM buffer '%s': %d\n", arg, err);
-		return err;
-	}
 	state->ram_buf_read = true;
 
 	return 0;
@@ -512,6 +504,17 @@ int sandbox_main(int argc, char *argv[])
 	if (os_parse_args(state, argc, argv))
 		return 1;
 
+	if (state->ram_buf_fname) {
+		ret = os_read_ram_buf(state->ram_buf_fname);
+		if (ret) {
+			printf("Failed to read RAM buffer '%s': %d\n",
+			       state->ram_buf_fname, ret);
+		} else {
+			state->ram_buf_read = true;
+			log_debug("Read RAM buffer from '%s'\n", state->ram_buf_fname);
+		}
+	}
+
 	/* Remove old memory file if required */
 	if (state->ram_buf_rm && state->ram_buf_fname) {
 		os_unlink(state->ram_buf_fname);
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index d67834988fd4..fcc0028ff4a2 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -513,6 +513,7 @@ int state_uninit(void)
 			printf("Failed to write RAM buffer\n");
 			return err;
 		}
+		log_debug("Wrote RAM to file '%s'\n", state->ram_buf_fname);
 	}
 
 	if (state->write_state) {
-- 
2.42.0.515.g380fc7ccd1-goog

