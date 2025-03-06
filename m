Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA30DC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7D981A10;
	Thu,  6 Mar 2025 17:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDBXo+Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A2D81DCA; Thu,  6 Mar 2025 17:06:03 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4EB81D52
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d1a428471fso6554615ab.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277159; x=1741881959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=IDBXo+LbiaMxw3OnDj/CWu18TeAsVlz5W4tNZPxPTMcRb9EZK2wz1gH58ANwOPEQfN
 lLV+ggHZ5KjWcTRuG5pSD9QnoWiv+1RsZqfgOdW7O3pAAIA1IKICrGYmKxgouKLgXOc/
 q2r2eQ9DZUFEXKbr++7IatgTXw09c04FogU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277159; x=1741881959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=jaBNoRktrAT7+g6X1DmDecxSwK3x6rS8tJx7VeO3MhL/rqu7op7SyzuJHFzkMnsChA
 /IsOKShRWcCpSgle9Ekmi3596W4JhMKwU6taNKzSd8wukCOumVdGJLHzO9g38Y5VkN9E
 dw4E+XmGi4h0J+GFuIO6cNEJHPqnKJAG6GluV6Aibm6E+JUtYr1YIa1CTwqP8Tmr3zDa
 BlrUdNX8jqjW/otTHrgTHkCw0m4cKDEPnyHza5CCELfUaYkbq5ux9d8i/FXIGGX2oSDF
 etjGJgbOotJuZ/AdCNqU5h/TVmWIlsgMA5scYivkZAB1QviIywlgb30/GeRaYZ9zEpAG
 n1LQ==
X-Gm-Message-State: AOJu0YxZWpoCMTsKPSIq5GGlccZfLrtHawFJLTsMNzg2Oe1jB8KyVtv/
 8t9zzChm82GaiEu7D98HB/cSiFpwTcElhryYkb7jjTwDjvbQz/OJriWlBjJbQaz5sPIQHU7Qlbc
 =
X-Gm-Gg: ASbGncsm++AqTqYHYBr9fS/AQIqmLFjngIF0oOskW/wi+xNN2i6pWiDw1bvyjNbwwRh
 KORwp+B1vYOH/NR6+E1ycFTidyeFZNJy3usv1Jnc2UaHSWJrwSfTp7qIsu/xZwEkTOphVJjdmdx
 Sghmnfsk5uAJRXT5G/A8sQEVPIxKQ8sqyv/MC0jPjrhIdhvBWslDx+/VhCSe2PY8vwOqwpYqbv8
 wLJxiLHKCTPLealOg1ozjduKMseF34X66+3H3FTbBYOYjbA4MzJ60RHQQvWafBaIcCqIiYcyS8F
 lPRrprVZ69/sm9U3RmzfNMl5AX3T7+2Ko5qVVMZseuA9iWw2NvbG7NtFpWJRRvrq9t+245ICDW+
 yElYcFg==
X-Google-Smtp-Source: AGHT+IFVrNhma8uIsT77632739na8ad17f1vpP9I5ULeUIufeQtRgBbCD/r5f5pfbzXHknwO/BWWFg==
X-Received: by 2002:a05:6e02:1c0e:b0:3d3:f4fc:a291 with SMTP id
 e9e14a558f8ab-3d44193e19fmr390085ab.19.1741277159017; 
 Thu, 06 Mar 2025 08:05:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 34/47] x86: qemu: Use the new e820 API
Date: Thu,  6 Mar 2025 09:04:01 -0700
Message-ID: <20250306160428.3041057-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

