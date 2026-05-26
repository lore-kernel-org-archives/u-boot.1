Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF8CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E0C84702;
	Tue, 26 May 2026 15:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ag7puwe/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ECE48487C; Tue, 26 May 2026 15:10:12 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7591484873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69d8b7aeeecso1154588eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801009; x=1780405809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aQm0jbkc59Mkhftn/+JIYuXPYx0HrUJfAjibiC6duo=;
 b=ag7puwe/5+bOM9UBfwXRcsdvKutNBu6CpE1OSpu4bYwleyBdEYgnSkqDdGTdehANH1
 KyWH7DGWGvU5MjEu67mcq5PupuwMAVLSZgUmREpIbRpu5MorkDnQHbhI73jgEnwg1Xal
 BZMw5Y6x8VO95j+XtEYql5S9UM3imaaaUDeJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801009; x=1780405809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0aQm0jbkc59Mkhftn/+JIYuXPYx0HrUJfAjibiC6duo=;
 b=PamGdhUBJDGYEwMdBe9AVhLI9ybozUH/2pzdFp7PHDFQ6iTuJQEUE4YH2s9hHRnyVm
 8EdxB2HwiiC71HU9M9Ec3l4JnmR+1fBeQ5GHr5rfw5dZx5bUi3CcZ22IX7yMPrTODrz1
 AMt7aRIHi0qHRxYUm6CSiYPCs4zOBK1L6iY/eBFW6pTXKKMO3RFWogMRkZ4zfQ2gGVko
 jenTOYB7MOysBQKfDgdybLIQNxIwtAiB2J3Z2dixx4IQcp2iNFhrKAEHSRtVmDvxwg7t
 UpujRyzrrVGSckXNtBeRNMA0EMLzrKMfAgfZVPK5Jd7nMt7Z49BZIoQxnTflS9hAQ5fm
 2dlg==
X-Gm-Message-State: AOJu0YwEhMMKq5xgrwUhV3p3ARJMsYE/50SDEbORGHqhJQxove79kNc4
 4EtxHn/B2k2tOjBqsZC7PUJvXRpcyR7gAEDQcbqw1p4ectTG0RURTTzQJEeNKpB/C3KJ5TvQGcq
 hfLc5Y2ojmGM=
X-Gm-Gg: Acq92OEXsuBdaXlqLIOTZzql1O9sZviR5OANGdsp1l959CsNM3wNaP8iB5NmlVqLHc1
 xdv9AiPBLYsYz2xZg+/3yH7nnDvTQGkwpP7GCpjZ38HASDsLQGN+1dDrR1Y/aiD1hXFpllEWzQI
 4d1hyU8StoR5accbl5gdAwAGkcNQCUYVaddewoLWuEl5foGsbrNDkPQ2iNtl8xqJK9FBU3BypWB
 PdlFlTRCodjSUtHReypWiHGn26YPTDV4aOnaKIdTJgAbJV4biggxOWR2H3u32hZgV4CmXeRt+jy
 6FzGxmNa1ZAfjvKvee4V8C/R7Bl/mg6khlAab8l487CZOlZAaX5pBGc7VeafGyDkstd/ZfKPqmh
 2FJrupl2q3iePeD2+lCfOsPQgzXM8eoFNRQ4pOetDVO+J84XilNl8f1Vt8PRM9jCmIT9gXjqinV
 RrCbted0ZstBvFe2uVMg==
X-Received: by 2002:a4a:dd16:0:b0:696:1abe:a51 with SMTP id
 006d021491bc7-69d7ec7b532mr7408488eaf.49.1779801009184; 
 Tue, 26 May 2026 06:10:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/9] x86: Drop duplicate definition of zimage_dump()
Date: Tue, 26 May 2026 07:09:09 -0600
Message-ID: <20260526130931.2103552-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

This is now defined in bootm.h so drop the duplicate in the x86 code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/include/asm/zimage.h | 8 --------
 cmd/x86/zboot.c               | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 8b542605170..76b2a797ccf 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -71,14 +71,6 @@ struct zboot_state {
 
 extern struct zboot_state state;
 
-/**
- * zimage_dump() - Dump information about a zimage
- *
- * @base_ptr: Pointer to the boot parameters
- * @show_cmdline: true to show the kernel command line
- */
-void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
-
 /**
  * zboot_load() - Load a zimage
  *
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index ede6c1448cc..103b40a603c 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <bootm.h>
 #include <command.h>
 #include <env.h>
 #include <mapmem.h>
-- 
2.43.0

