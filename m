Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34CEC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1111181DF6;
	Sat, 15 Mar 2025 15:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bsoFCijO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FA881E92; Sat, 15 Mar 2025 15:28:24 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA7E80F91
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso6663435e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048901; x=1742653701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=bsoFCijOwboKtrn4BX/xOTK/8AkBOLoS2CunVe/YxmgnEcyUhT9XNTe3XV0i0BDtll
 Sw6vzdotd7MZMgN+gIgtdX2ipOpyIRlCV9AEbsDyAyJs3k5i/rZmqNNfmcFTeFzzZTBl
 yl74P4zM0WBnHjcXKsokBwF3iREuXTSRZVEbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048901; x=1742653701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=uOMD5NlSnINu4Sa049IDUl0qXqhgw9RYThjDKXfVMfmJpmJEQcqWFscHoWLH7goVoz
 to7D7wAH7zlB/Z3gNwJPfADWvLPuliurOfgP92DOzTYoy9u3kCaJH3sJjqVZdA2lfOay
 oHOyGGDm5JtFCi9pg+UCeTyjSKLyRh7i5MXaiqjNvrs9CpEFJu+sn4BD6IkTUlFsRFbe
 T0oQkGM7kokz57hOHFaqVj7pFhQVTIz07CV4vsuxlgShAifLQnbvyQI0HGodYP5K54+r
 8EMWOfw2HZJxh6hkidT8XB0VcoqZlsBuJceJ+uXJNqDJbDimhwnS5NsbGOLKXpSrMgjq
 QTXw==
X-Gm-Message-State: AOJu0YycWrzFthEFHISmdtnlTIRxhR+XaPlp5X7DH4MZNzBT9cBNP2G8
 gbMCItMlgKqJj4jng3D9cMQfMi9bquWhvWfN0XPH9ou0FGVQ2no7a3oQOMj5Z+DJVLHW0jLeqPy
 log==
X-Gm-Gg: ASbGncvj2b1/po0wRatTzSXoMmXgBsIPLUyWQ6b7jcshNbNTCndXHVoWl23JzbdK+WG
 utPk5n5TbbJ72NmRo1lK42G7xqj86yu1cpM/Zyvfl+3Da75IVKPNYbbML0Vfp2NbQRJ2YJpISrx
 RUYxsKzUsZ18Q3mQKW1VxrC8sy3Uuy8Tx2Yx3Ub4Vdke87091vUXTJFxPjwiYmSmKOTiHjfrf7b
 3elAoK0ucMwXLYQ6iYia9U4tMH5M63vY2nXrBmmOZOLnRRZniXX5CWeta52rKmTfjx1XZxt+ZuY
 6fm6BtM91OLkuWc3/9JSXxBoElPDkj/d3J1PptdZfw==
X-Google-Smtp-Source: AGHT+IEr/rk4+ZqxB/vjG33oC+nkbbgb4MWMhTWMbsM1Uzr/n7zqJ4nmA0F9IvDYTmQerbiybDabKw==
X-Received: by 2002:a05:600c:1c03:b0:43d:db5:7b21 with SMTP id
 5b1f17b1804b1-43d1ed00187mr78758145e9.28.1742048901501; 
 Sat, 15 Mar 2025 07:28:21 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 34/46] x86: qemu: Use the new e820 API
Date: Sat, 15 Mar 2025 14:25:54 +0000
Message-ID: <20250315142643.2600605-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Move over to use this API before making the code even more complicated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to use the new e820 API

 arch/x86/cpu/qemu/e820.c | 48 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/x86/cpu/qemu/e820.c b/arch/x86/cpu/qemu/e820.c
index 17a04f86479..2b0ad179489 100644
--- a/arch/x86/cpu/qemu/e820.c
+++ b/arch/x86/cpu/qemu/e820.c
@@ -19,51 +19,27 @@ unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *entries)
 {
 	u64 high_mem_size;
-	int n = 0;
+	struct e820_ctx ctx;
 
-	entries[n].addr = 0;
-	entries[n].size = ISA_START_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
+	e820_init(&ctx, entries, max_entries);
 
-	entries[n].addr = ISA_START_ADDRESS;
-	entries[n].size = ISA_END_ADDRESS - ISA_START_ADDRESS;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_next(&ctx, E820_RAM, ISA_START_ADDRESS);
+	e820_next(&ctx, E820_RESERVED, ISA_END_ADDRESS);
 
 	/*
 	 * since we use memalign(malloc) to allocate high memory for
 	 * storing ACPI tables, we need to reserve them in e820 tables,
 	 * otherwise kernel will reclaim them and data will be corrupted
 	 */
-	entries[n].addr = ISA_END_ADDRESS;
-	entries[n].size = gd->relocaddr - TOTAL_MALLOC_LEN - ISA_END_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
-
-	/* for simplicity, reserve entire malloc space */
-	entries[n].addr = gd->relocaddr - TOTAL_MALLOC_LEN;
-	entries[n].size = TOTAL_MALLOC_LEN;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = gd->relocaddr;
-	entries[n].size = qemu_get_low_memory_size() - gd->relocaddr;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = CONFIG_PCIE_ECAM_BASE;
-	entries[n].size = CONFIG_PCIE_ECAM_SIZE;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_to_addr(&ctx, E820_RAM, gd->relocaddr - TOTAL_MALLOC_LEN);
+	e820_next(&ctx, E820_RESERVED, TOTAL_MALLOC_LEN);
+	e820_to_addr(&ctx, E820_RAM, qemu_get_low_memory_size());
+	e820_add(&ctx, E820_RESERVED, CONFIG_PCIE_ECAM_BASE,
+		 CONFIG_PCIE_ECAM_SIZE);
 
 	high_mem_size = qemu_get_high_memory_size();
-	if (high_mem_size) {
-		entries[n].addr = SZ_4G;
-		entries[n].size = high_mem_size;
-		entries[n].type = E820_RAM;
-		n++;
-	}
+	if (high_mem_size)
+		e820_add(&ctx, E820_RAM, SZ_4G, high_mem_size);
 
-	return n;
+	return e820_finish(&ctx);
 }
-- 
2.43.0

