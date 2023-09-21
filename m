Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C492CD493F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D58686C28;
	Thu, 21 Sep 2023 03:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mu0aR0r1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A668086DC9; Thu, 21 Sep 2023 03:58:22 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F5086DD0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f7e7342e3so16312739f.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261490; x=1695866290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WH0pfZ7q6XiUXUiacHLom9mZN27WJwyohswdJA40cio=;
 b=mu0aR0r1N+VAfc20hdvd/pupaMf0K22CX1U4XfpocSVt11tWLeXTSPFaCro7tz/pF0
 okHT0399D/DJc746BH2+nhe3mLcvPu1pf7Jvqh2Wuhesft8yrJ1cR1OOxdRW7SFiE2Wr
 Z4ny9Vx0lEmUdPwsvzb25o3J21Bse5Se0yp5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261490; x=1695866290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WH0pfZ7q6XiUXUiacHLom9mZN27WJwyohswdJA40cio=;
 b=BYW3fVeRYrbgCYS7zKFxl9xdLbm0DY16AuDm9zPRV+gfQIUfalwpezeRbDndzzVzwc
 jRdzEBr9J5OBSda0gQdxLsHxTcLYL5k+BYWu13/vcKEMr0/PppG7NsjB/AlN8M5njjS8
 5uicxmkuWWASPRk2C6IkX0Mw1DkaRgbC4ujURvu1EKNLOcaBf9IejDtdWmyko24wzwFG
 P1lOCFHl2Z8jYqlasKDG+4Kh4hS7049g62FAtyymEJi47jKIWS0OegSxRGgG0BqJBbzv
 9Jeoddp0dc326ILxw3wkluvNXLR/GbNoCoF6b1wap68Vuehmxow/6FGZd4dXsC5oLwhF
 AVDA==
X-Gm-Message-State: AOJu0YynxwKJ7Icv0aAjqoI8tGu6gW+LMjpRv2oHSV8pf12X20Ky+tps
 g5eoMYHA7rM4EsFloZNyFJZ5Y3obCdMFrQhqMOM=
X-Google-Smtp-Source: AGHT+IFGaLQOxMfD9EM0eDC/JZYRWoDzdyCuhUwx83TehhKqQuDdDZgCyWLt+A4+cVY48TL1zMlaQQ==
X-Received: by 2002:a05:6e02:1181:b0:34f:7665:c43c with SMTP id
 y1-20020a056e02118100b0034f7665c43cmr4087257ili.23.1695261490471; 
 Wed, 20 Sep 2023 18:58:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 25/32] sandbox: Move reading the RAM buffer into a better
 place
Date: Wed, 20 Sep 2023 19:57:14 -0600
Message-ID: <20230921015730.1511373-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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
index 1026898727f5..5dc4db8bf605 100644
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

