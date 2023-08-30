Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68030C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E004E865AA;
	Wed, 30 Aug 2023 20:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bz4KhDwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA3886547; Wed, 30 Aug 2023 20:06:19 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1904D8654D
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso1910339f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418759; x=1694023559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOA5pixR/dcYMieiAbzYbNxHyKmRIXkW5w4F4GRKQa8=;
 b=Bz4KhDwW0wb8V63Wqpvo3KEq/6nQS8uMb+UPztXkZ4YKVvMPa0pcbWvtxOdPw51FgP
 KdSaGDvzjm6zflIJ9kYsmfVxoIQgwmipFUZ0qIo9POtigaUTnxXYjOTbE+D/px5kiHf5
 VOKCKrjvtq9nrBKpJ00fcPgZNzFciobUCkXw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418759; x=1694023559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOA5pixR/dcYMieiAbzYbNxHyKmRIXkW5w4F4GRKQa8=;
 b=XXfOBZBXFnd8h/qlFZsRT4xwbOBf+Bbj/xpwx0vEmxKSRVbNJHHaS8RP2FLq84dJQN
 ooOpxGH3zw+NNgC6oe4YnwF1nHEElWN7heuhNgfv6ZHIxgP49RPE4Ju/hRiNlc/S2v70
 iB9Vw43cCBtYjqkVlCQT0FKskwtoXCiUMyj5I9bVTn6XGgzzAZegHqr8JJCpfJCYShGY
 7AtR7+0c2TZKD/2DREeLrMy70WLs+9oP0Uz96A2OOysLBb+mVETA7l8Wzx0i56oqbiKW
 m1DBXZSdujG0zzR4ZMzIjCtahg+yvKLeN2AkPSlGz12530gFxpd1QZc+NTjbpY0qB1AG
 IslQ==
X-Gm-Message-State: AOJu0YzuJGny+aIYTwne6QTjnUTQCogW4FkmE0E53vemfyQHwRSfOm+z
 JWJgf8i4AzPJwZwXhOzT0Y3Ry2XSOxIFzpFoMaQ=
X-Google-Smtp-Source: AGHT+IGS4VqJIXxGv+IJFqi3UfvQB6anPALF/4bOc3mJLCKXhXbeuOBRGu8lAfuEcUaIFczZQd2Y5g==
X-Received: by 2002:a5e:8406:0:b0:792:881d:c6ab with SMTP id
 h6-20020a5e8406000000b00792881dc6abmr3270087ioj.18.1693418759781; 
 Wed, 30 Aug 2023 11:05:59 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 25/32] sandbox: Move reading the RAM buffer into a better place
Date: Wed, 30 Aug 2023 12:04:56 -0600
Message-ID: <20230830180524.315916-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 arch/sandbox/cpu/start.c | 19 +++++++++++--------
 arch/sandbox/cpu/state.c |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 234652872ec..d4c4d071aef 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -277,17 +277,9 @@ SANDBOX_CMDLINE_OPT_SHORT(program, 'p', 1, "U-Boot program name");
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
@@ -517,6 +509,17 @@ int sandbox_main(int argc, char *argv[])
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
index d67834988fd..fcc0028ff4a 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

