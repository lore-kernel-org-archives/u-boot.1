Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B8FCA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AA788BD4;
	Mon,  2 Sep 2024 00:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gm8ohrs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C3B88B6E; Mon,  2 Sep 2024 00:27:06 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EB988C01
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82a316f8ae1so76001939f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229621; x=1725834421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=gm8ohrs0imD/6RCMRFBuCfJfnDBqWNh0v+aFBMZoaymL92PFKpPXbAdcsqMipFsPHP
 kbaj3dESa9flKYGK9ICuJJymvMxGuRkSvjn5Er6IIXy33qg7w6vN3USw3qZEHPNCRGE+
 uGLG/i1m4JDtny7Y4rEWlGA3fV5dH0jZTYFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229621; x=1725834421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbRvL/gv9suH73qyXpX8t6OBHblwSrVMWu3bD+fTzdk=;
 b=BSKJHmd8HLyDVKpY6aoRjsjz2nZ1+CTmBceXsaZFoM9llCGV+Zds/419xWQhj3Z1nA
 aKxHcCwnlZ+r//Dgrz+LX761JCR1D6ok2COZWzg0mza90DK4QENpYxEwaG7mRFQG/TES
 +5OAxbEt+UQN/79b3+ukimVjJMBOtFyIQjeO4WwM+y+jj5md3hN2z4ovCfykQzKtfXVA
 isaTBt7Pp9z8+Cj85A8Z1k6sTT/KJ3WufaECviy8fC4H9gpoHexoW3TkPEfOVwA/Ra5K
 BquoDjYijI9+aq7SEcmA9IMRRgAwJv54iqlAspNbW3aBiCEO5o0otE+sAZkak68jEAYA
 Nkvw==
X-Gm-Message-State: AOJu0YweK5HISG2vG19jE/PnWlrf8XTpIG1e7+tbYT958gWLcjc+/Nge
 J16Qr5xO6D9UoXACEQGX4cY+YCJNaUDc1BgW7/2lJX1YBjl0hdf6G4LDAOJD88qNthZAAeXTEjY
 =
X-Google-Smtp-Source: AGHT+IFa+s04Llf/UR3ZFBSK/o6IBO99x8FYuIPWwZ/n+l7CszRYTG976tooqmloW8+lYGFUZWhXRA==
X-Received: by 2002:a05:6602:154b:b0:82a:48c5:4d04 with SMTP id
 ca18e2360f4ac-82a48c54f94mr281314639f.6.1725229621235; 
 Sun, 01 Sep 2024 15:27:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/23] sandbox: Change the range used for memory-mapping
 tags
Date: Sun,  1 Sep 2024 16:26:23 -0600
Message-Id: <20240901222634.460873-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

