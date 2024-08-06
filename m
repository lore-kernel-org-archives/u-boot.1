Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35529C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B561088AA5;
	Tue,  6 Aug 2024 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oW0dWqly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8560D88A79; Tue,  6 Aug 2024 14:59:42 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FD787B30
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39b38295008so2284695ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949170; x=1723553970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=oW0dWqly8OVHtP8fSm4zt5EWtjscbKU+ofyILjpKVk+DtHq8oazaLeBvOp0g6c141m
 1lx0Q+rSdf+bAAYjEJ1hQcXKDhHg0BGQGPZuIVsphBhJKyXn8FHzLg0r3HOGXZo90m+f
 C4tcUVAS9APp2L0niq6EgXT8CzbNMyIDGTGno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949170; x=1723553970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=vA9F5xsdi5HJXfgsq+GhG5/4HFnmPw0fgM3V44HyF1bZFvPPwNvPFBwunsrYxuAtzx
 AB0bCVSuRUUMMzl0jNbpKQTSsSb5tzpQIQXymvwCzeqKl1nzhGQU2pNUDbnSZdPzDKWN
 pwnoomclFrUPCmnvMm3+V29w7zT5tZHOma1f9urZcKAR/3kyQzkADEcjFVx0ZqjtgKVB
 ciTojgJER9K1RX8p7+tmbKsyzEpX6REQlhRa7mVjmr5rx1OxWq2XGa80RVRE0LFzHmKW
 m8NnVL+v4fucOvRR2e7gDetEbHpnTwzqMlK2QUtL4QA0VtNjWtJUHcL+HANPC3/Ldrv/
 TR9g==
X-Gm-Message-State: AOJu0YwmdZ3KuUNwh433PTguDUDwZGFaGocg020ai86wjS6wbDfQJg+A
 86haFDyYU3lu9eeHAUnENbR6OXuxBRtuERI+zl6F6UDkvVCkRrrxQdpqiEPgLH0Z2pYJyA2yg1k
 =
X-Google-Smtp-Source: AGHT+IEZsqU3EmikQDNryAYeEPLUb/hUXxRD0nUpTpjyzhbgExdpbK+Tu9xYf9F5ciozKZBnWjiRWw==
X-Received: by 2002:a92:cd8e:0:b0:39b:3649:1b68 with SMTP id
 e9e14a558f8ab-39b36491d25mr146243235ab.13.1722949170282; 
 Tue, 06 Aug 2024 05:59:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH v2 13/39] sandbox: Change the range used for memory-mapping
 tags
Date: Tue,  6 Aug 2024 06:58:24 -0600
Message-Id: <20240806125850.2316956-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

