Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6340BC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDB0811E1;
	Tue, 25 Feb 2025 00:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lc/+/BWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E0280F98; Tue, 25 Feb 2025 00:08:09 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2CF80F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d1987cce10so39791755ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438484; x=1741043284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPqq8WYaPj6J2IwBDMowPX92na6feXUAfjpPv3BrLRw=;
 b=lc/+/BWHhFVJOSdtICnQklzallqkeFs/bGFmS2Y85KVRzsEEwtwzUEhO0BFlHGy8mV
 lVwaJjqzxvBhMBt40sh6+Kte391de4jKK6v7u0UA27V8mJqG6Jz+ey5VmYJgLBm9vdCe
 FIQL6G7bq5/WDU+siM6WZ9iP42oav7pq0fHpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438484; x=1741043284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPqq8WYaPj6J2IwBDMowPX92na6feXUAfjpPv3BrLRw=;
 b=bjsUYEFShH2cL4Oo2uOwv99lJGONDbAJFBhHOV403J1t1WORx/wvqZhQmI9aC1kM1w
 s6HgtHOBG7FxKDlmsYkI2vcLe68FcrnPoUDCZHcvfMP6Q7PPgbLHZr3Lsu3nvw/l8LGo
 vBAQsmc4pejajkD2Z5/DT6TFnzdUGu26UnrElZw44z/Jy9W3GyLC/KafGYXK8LKKLVt6
 p+CL08v5GZXt2wSVyslHoiwMf71T6wBjvq6o9a4wQEZLTO0km0HA+PhccNFFQTW59WFi
 3VcIIP4AghaREhr2tA0f9O1g4/Qd4MUYKqBiMj8qD1ogwOxd1+ntg6tHqT9fqoSoyn0k
 jvyg==
X-Gm-Message-State: AOJu0YyFLf5s599f4yjI1rxCOFHMZ/HGQaL1uq/Vz6k3ax0/2HEmquFj
 as0BJeY4tlHUZGUNB+nItbZcK/ughk0GkUV+zlaIdkq9Ws6k9ImI/iPNvbadl05GWSdZY6XmrAk
 =
X-Gm-Gg: ASbGncvvz7JCUiLBkDDZ2D+o4ZW6iNbgt30IqplOsGyH9UGCmmuAKexwLQM2SQ2+bkj
 qy74u5XbpS+A+34rDQhlJ/kIQo/SBp7/ICxNArr1WnVjm1yk5WdE0hZxpRQT571ihSI0fxXcACV
 WsAc/watsFu3tl6ZrYPMNtiYwdxr0jCFLJGpLEpjA078/s9O29aKTSYQyP/iS3ZrGHBoA9MXjCo
 1DNInq4WnTnj8opGdnlGX4wXsliMZdwifoiO/LsBbDMe5nG8dzOLHvDRsLsdEAQ+u1h7C2PqZJm
 P6GFRHhZ1DppS+vjBEbun5OSTSTt3f1r4U5TOqiXv0gmo03yy97jJAFEkHL06Ls=
X-Google-Smtp-Source: AGHT+IGHuENz4NSG2YP3MtyNHiMYnYsoBcaBZ+4DIs/SSPItUKJyfRJV3Nh4u0OHC1KyNa9T9uFUxQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d2:aa73:7b65 with SMTP id
 e9e14a558f8ab-3d2cae699b6mr137167905ab.6.1740438484667; 
 Mon, 24 Feb 2025 15:08:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 32/44] x86: qemu: Use the new e820 API
Date: Mon, 24 Feb 2025 16:06:21 -0700
Message-ID: <20250224230640.2665206-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

