Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACE3C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1632588BB0;
	Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BrVH/uLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3074088AF2; Thu, 15 Aug 2024 22:26:03 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0193A88B89
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so46994339f.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753552; x=1724358352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=BrVH/uLtsNItxhVUCUxPSeVzCKikdj8U4l/McvlGlRSGMc8JCfR3xakymGeTMbQlYl
 QnpV4w6/ID2NESAGBzZMYS2pLRGy9tBfvbX2IXt/deeaiyFxOsS59ZdiZKUAOEdQpTMk
 Yr74fdd1VY0vWrHpWVSUw6ZWU/HUwDfwZXLa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753552; x=1724358352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=CTzB652p4eLzZKaYRGLSmhZe6La2p/8R9NxGT9JFtN1NwcwdH9u2vjEALhAEcDt2Mi
 C3b3s64pB7/ZVqQ869LdxB5LNGj5ANFqeJWSkfewBz6FILxiLZ15AewxPcn4FP8ddleB
 FqtaEw4USTGXoh98+APxmbuwav1GGKicDd1K33kbZYyACW8W8Az/NVzX/4Hcpuaykfwx
 /MJSRHIuIZdB+rDnowYLkGi6uq54Cnnts7U+660OxfVty+hMeJndJs1WFpFg8QUo/ADp
 ovDma9dJ8O+yEHL2hMOgDYJOl5GHrd+rfwbLAsGkVz4ZZOiwu9HYS45xeHa2R12nhoX7
 j+Ow==
X-Gm-Message-State: AOJu0YwDiDOVNG9h5lJHfqzXz1Xe6YVk/X6/6ExFHLLPK70gJBdRG7e4
 ugMRh/cA2HHOeA8ZYFWTxW9QoUM+PichGLEo2lFRGgoVyAeKOpECnElHBfQQyj5iN4vOmUVYbS0
 tGw==
X-Google-Smtp-Source: AGHT+IEFw+nXfx3UsblvuWoNmgk8Q+O2Gql9hslbVfBW79hK76hjcBtEONOW0gqYTquYL3D6Lg3fFg==
X-Received: by 2002:a05:6e02:1a41:b0:39a:ebcd:f2fa with SMTP id
 e9e14a558f8ab-39d26d64460mr10468705ab.20.1723753552432; 
 Thu, 15 Aug 2024 13:25:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 13/24] sandbox: Change the range used for memory-mapping
 tags
Date: Thu, 15 Aug 2024 14:25:24 -0600
Message-Id: <20240815202535.767869-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

