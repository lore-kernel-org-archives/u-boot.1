Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8445FC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644FA88A24;
	Sun, 11 Aug 2024 16:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OlNRdebX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38DC888A39; Sun, 11 Aug 2024 16:52:45 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19329884DB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39b3e12754eso11984845ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387962; x=1723992762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=OlNRdebXIZGjGuggVKIyQ0LmbziTwuNpT9kcVzC3kzsVQpiGTY34AO2zODIp2FVIQ2
 cxZJKgdhUl2J0Ni9NpFY5YxTvQQW4SPGRW/DDybPKAivS41nMJ1uXI+zauuYsHhGTNYT
 cHdry9vnY4AEJtoRZiIDJJ+SyjSVDZS0rs0Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387962; x=1723992762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=WGDhuNC3GFtCrU1RsvGTSYf8zZSWAJD4DWrQdQmjjnEkW2WV1/rKem+tv/jjnrFAXL
 K93eLlIYJM1X73eq0BMjxrUdKZeejpFC+xOJyn4Eza5Ou8OhPL+9jCbAeo4Zqvbn5qv6
 PAyWRL5hRfGtTVsLL8Vgba6YVBq6zp9snI77JuEOQI5ghnHjFuouVqK+YzaqEJAhQxhr
 GoVhzzcmTk5q57ONg5KIhiQGTqhBcrtgY3mnBL3c5Fx4JT13cU322olXFAME2y6lwaSp
 WhBTP8oC9fadFV/xIEpIi7Krwn/CsXWmo3AE7DCQcq6boxblx32tAckrP2VgImpvlObB
 GFyA==
X-Gm-Message-State: AOJu0YwL7HccarYNIGWS7wjTFmyht5faeRFcqx655TS5JvB21LQAlsN2
 82Idbk2xso6Exg8akvYQk9jYcqGBkAaMEXugNJfuuvDzyuNngSsmPE5grhKJE6K2c+LIqimqqiE
 =
X-Google-Smtp-Source: AGHT+IEjgyRDz9c+U8GflToj9GlJcemXd65bmvbPVWlrgprFHuWziK1e1VMmML3rn7SDniDgpkPQ5g==
X-Received: by 2002:a05:6e02:194f:b0:39a:e9c4:6baf with SMTP id
 e9e14a558f8ab-39b86f73f80mr83977485ab.26.1723387961746; 
 Sun, 11 Aug 2024 07:52:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 13/40] sandbox: Change the range used for memory-mapping
 tags
Date: Sun, 11 Aug 2024 08:51:42 -0600
Message-Id: <20240811145209.4191404-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Sandbox keeps a table of addresses which map to pointers which are
outside its emulated DRAM. The current range from 10000000 conflicts
with the PCI range, meaning that if PCI mapping is on, that particular
address can be decoded by PCI instead of the table.

Fix this by moving the range up to the top of memory. Update the docs
while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/state.c     |  9 +++++----
 doc/arch/sandbox/sandbox.rst | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index a9ca79e76d2..49236db99c2 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -373,12 +373,13 @@ void state_reset_for_test(struct sandbox_state *state)
 	memset(state->spi, '\0', sizeof(state->spi));
 
 	/*
-	 * Set up the memory tag list. Use the top of emulated SDRAM for the
-	 * first tag number, since that address offset is outside the legal
-	 * range, and can be assumed to be a tag.
+	 * Set up the memory tag list. We could use the top of emulated SDRAM
+	 * for the first tag number, since that address offset is outside the
+	 * legal SDRAM range, but PCI can have address there. So use a very
+	 * large address instead
 	 */
 	INIT_LIST_HEAD(&state->mapmem_head);
-	state->next_tag = state->ram_size;
+	state->next_tag = 0xff000000;
 }
 
 bool autoboot_keyed(void)
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 5f8db126657..1515f93c84b 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -655,14 +655,17 @@ Memory Map
 Sandbox has its own emulated memory starting at 0. Here are some of the things
 that are mapped into that memory:
 
-=======   ========================   ===============================
+========  ========================   ===============================
 Addr      Config                     Usage
-=======   ========================   ===============================
-    100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-   b000   CONFIG_BLOBLIST_ADDR       Blob list
-  10000   CFG_MALLOC_F_ADDR          Early memory allocation
-  f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
- 100000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
+========  ========================   ===============================
+     100  CONFIG_SYS_FDT_LOAD_ADDR   Device tree
+    b000  CONFIG_BLOBLIST_ADDR       Blob list
+   10000  CFG_MALLOC_F_ADDR          Early memory allocation
+   f0000  CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
+  100000  CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
                                      as the SPL load buffer in spl_test_load().
- 200000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
-=======   ========================   ===============================
+  200000  CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
+10000000                             PCI address space (see test.dts)
+
+ff000000                             Memory-mapping tags start here
+========  ========================   ===============================
-- 
2.34.1

