Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA716CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A4086BE7;
	Sun, 24 Sep 2023 21:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fXvQ/dtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C7886ACF; Sun, 24 Sep 2023 21:26:28 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8026A86BD1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so123827239f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583576; x=1696188376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNgyPfEDnrgql0TYpgBywuNZ9ggHpU7BSYJxBpnKIYg=;
 b=fXvQ/dtupA+CU3O31Y7ptFXjW+3bevECMzpPl4K7FjiRlIhYVienYIKfQom9px9kxm
 lsGQrTJ0L4kfrSHidP8pHO1sbMeUa4C50huAHg7itFzrPbS4ReVkymqj4qtdrByVvJu0
 N3DW3/ceJSSIVGKp+M2reSViNK5xpThqJ9f5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583576; x=1696188376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNgyPfEDnrgql0TYpgBywuNZ9ggHpU7BSYJxBpnKIYg=;
 b=OoUxyvKaiRrMgzLzJT3VU1x4JA7zvOG7pGiObss9+9tna6aX0ocKzCioj4ifD1VfuJ
 5fN15NwZKpZK6c2yq7kzB97VMz+czmiOH+i9vFTMiGINUYQULyMiuX+MYRvcetu/vX5d
 T55C7rp0S90lpsG0DUJBbllldfn2qtuIQjzAigvvHNC7thmyIUqqCFXcvAR3By9Gb93g
 lGP8jIzFtTxjk5Ui2obs23Is7IlDubv+6tAXLtarR7HYCG2gLFlTshH1M4AFYA0ZmL0F
 tdbRb/Lh1P+MMAc5Vo1MceQ4Yt891iwIjvnIOZ445js4T6iqNuHGwHgjuAcNc9pngNPs
 LpYA==
X-Gm-Message-State: AOJu0YzRvDu0Pmqs5PqYTuvttIwQVRfNdRrhVpbYWFeb40BcOnPAOaYM
 H8TxulP96YDXHJi2LauPGY+PlQDeDDxMMh0NDwA=
X-Google-Smtp-Source: AGHT+IGqmKvFZz3mJk7pGAr9rMVg9RGeF5NfdOx+6KxKJfa9aLTzd/2ikBkPBOMP2tF1LL5jHdY4SA==
X-Received: by 2002:a5d:84c5:0:b0:798:134a:44b with SMTP id
 z5-20020a5d84c5000000b00798134a044bmr5571776ior.21.1695583576167; 
 Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 31/38] sandbox: Move reading the RAM buffer into a better
 place
Date: Sun, 24 Sep 2023 13:25:16 -0600
Message-ID: <20230924192536.1812799-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

