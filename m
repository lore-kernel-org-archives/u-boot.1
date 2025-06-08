Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D2DC61CE8
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CFC826AA;
	Sun,  8 Jun 2025 09:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z03EXAln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABD6826AA; Sun,  8 Jun 2025 09:54:43 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AB1826AA
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58BB33F746
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749369279;
 bh=RwFa/TszI0UFQdopPx/zbI/vr3RYmAo4NoDzIP58BS8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Z03EXAlno4Tk069sSAZykSXYhIZXoyUelzo98aUSxiHXk+UZswTP3XP9zdJDb7nyJ
 veAROvub9xGyUYMKYlmC7zm9x4/X8TEv/N+MAJzuElDp9l4krkCI+C6KS0w4NraPGC
 vp+nWdrj9GmHuJwSm1BYWXlKddvrfNYEPu1dcojacIs4fOklYUXAwjLgva6HUjExC3
 yAobA2F9rJF7+Ysa0U+SwlBulKex3J9rVw/1TDsdLsoljjLJR9NU7KUzOi9AWmP9Nf
 jH5TsnwaGpOYE9a6DGzKZIB2RvPP97BQm6jjDthvK710CA4zS1pNCxL1MMdR024ris
 Yw/p/vTkFQsbg==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-607e8a00059so277065a12.0
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749369279; x=1749974079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwFa/TszI0UFQdopPx/zbI/vr3RYmAo4NoDzIP58BS8=;
 b=mIPvDXxRd3duaLKRByWuVATshZz3ctYp5dixseoG46RACpHIjl4NnppQXcOqFTOgDX
 xYFA9vkWiv5gADntFhgvIDyIJTrK/teV0yh6NRF2q/Dy/GbaGHNixja9ht+CywcPQDjZ
 T1+O7EDvBhRo0N65RTQCEi7/+oH1E9k2ovWRbNCQ/Y9e2dzTZ9BtVaUeTu+TO/sceFkY
 6+Xbqugb/KPqlqsOjN5c3arD4eJxCq+i6+GiIFlyRccSCWAc6GM9o/2MXxvwXJEH7VsY
 fnr2wLcK3J60g1kFUw1Az6oN9+iC7g0GisHUJPHoi4wQ4WbVLgR5zqqmiOofQfq7JOqQ
 qVeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVM0OG6/m4mzOGb6yu87rIhw6uWuRauVoJcHZXVJoDVUesDjBaxtaiZ2sekgjHOdSRXg2vpts=@lists.denx.de
X-Gm-Message-State: AOJu0Yye3+bH7f+npcAk1IVjeF6shPQP2nGtyJogNK35jmOkGpF89dxF
 IQq6fhgAuZnV8BiSY6yKa7q1oHNMNEKUDPePM0e3LTTVaVdocK+H6JwgFM2PSMBYi7vwQ1NgJ6l
 XKRBF+L9GD/iaYqw26RL3eLth7PGf8BQ0vi2wROEi67yR3WBxWEQcHIQhmtEfm3GBNwv9gew=
X-Gm-Gg: ASbGncunaUbJhnA+zKu9FN6uD8QcJeiA4Nq/XgfgdhtmHxInuPJL7/wuSeg4haJabSH
 CpQiPQz1K++57YS+4sYeqmDPakqS+K+n3dt4gB2hP6+Z9OLYojMoIz7fKIkhOT5Y46mdxFMsP/T
 XUDot6OPqsU0nE84WYcWRznABeSQfK3Q/6/JU8w63u6Yhl6GNwwT0/c9N5CQ2Lk1dKKKRSGco4U
 b0gzzU919MV7xzGXEtrjFwADJrs6FbvHEpINw8CqM9L55L/wPwqIm9gm92uyUp5qJTfyPRvbJvN
 vjsRjfc0TCv5FZ3N3ElpP1ywhMnyvzJnjPThBn/cghUv9ezge06NIFrAj0Cx757/5l8B3vTJLdf
 Me1VyXOWOPY6Xbw==
X-Received: by 2002:a17:906:7950:b0:ade:198c:4b6f with SMTP id
 a640c23a62f3a-ade1aa0fd7bmr807563966b.1.1749369278919; 
 Sun, 08 Jun 2025 00:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBnadFORakzRP5ck6MXPxh7WqjhQLq3Xb1qicF8/nxw5b+C4x/Mx4YnFKGozAMoxku03xltA==
X-Received: by 2002:a17:906:7950:b0:ade:198c:4b6f with SMTP id
 a640c23a62f3a-ade1aa0fd7bmr807561866b.1.1749369278539; 
 Sun, 08 Jun 2025 00:54:38 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade34ea5adesm270956066b.80.2025.06.08.00.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:54:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/3] sandbox: align LMB memory
Date: Sun,  8 Jun 2025 09:54:27 +0200
Message-ID: <20250608075428.32631-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
References: <20250608075428.32631-1-heinrich.schuchardt@canonical.com>
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

To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
memory.

On the sandbox LMB uses addresses relative to the start of a page aligned
RAM buffer allocated with mmap(). This leads to a mismatch of alignment
between EFI which uses pointers and LMB which uses phys_addr_t.

Ensure that the RAM buffer used for LMB is 4 MiB aligned.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rename define CFG_SYS_SDRAM_ALIGN to SB_SDRAM_ALIGN
---
 arch/sandbox/cpu/state.c         | 6 ++++--
 arch/sandbox/include/asm/state.h | 1 +
 include/configs/sandbox.h        | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index 49236db99c2..6a15c8b0a18 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -480,7 +480,9 @@ int state_init(void)
 	state = &main_state;
 
 	state->ram_size = CFG_SYS_SDRAM_SIZE;
-	state->ram_buf = os_malloc(state->ram_size);
+	state->mmap_addr = os_malloc(state->ram_size + SB_SDRAM_ALIGN);
+	state->ram_buf = (uint8_t *)ALIGN((uintptr_t)state->mmap_addr,
+					  SB_SDRAM_ALIGN);
 	if (!state->ram_buf) {
 		printf("Out of memory\n");
 		os_exit(1);
@@ -533,7 +535,7 @@ int state_uninit(void)
 		trace_set_enabled(0);
 
 	os_free(state->state_fdt);
-	os_free(state->ram_buf);
+	os_free(state->mmap_addr);
 	memset(state, '\0', sizeof(*state));
 
 	return 0;
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index dc21a623106..9dea0980bfc 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -75,6 +75,7 @@ struct sandbox_state {
 	char **argv;			/* Command line arguments */
 	const char *jumped_fname;	/* Jumped from previous U-Boot */
 	const char *prog_fname;		/* U-Boot executable filename */
+	uint8_t *mmap_addr;		/* Memory allocated via mmap */
 	uint8_t *ram_buf;		/* Emulated RAM buffer */
 	unsigned long ram_size;		/* Size of RAM buffer */
 	const char *ram_buf_fname;	/* Filename to use for RAM buffer */
diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
index db2ac7f83bb..44d4960d487 100644
--- a/include/configs/sandbox.h
+++ b/include/configs/sandbox.h
@@ -14,6 +14,8 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define CFG_SYS_SDRAM_SIZE \
 		(SB_TO_UL(CONFIG_SANDBOX_RAM_SIZE_MB) << 20)
+/** define SB_SDRAM_ALIGN - Alignment of emulated RAM */
+#define SB_SDRAM_ALIGN			0x400000
 
 #define CFG_SYS_BAUDRATE_TABLE	{4800, 9600, 19200, 38400, 57600,\
 					115200}
-- 
2.48.1

