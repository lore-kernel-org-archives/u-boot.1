Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEACC282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 06:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15DE88122F;
	Sun,  9 Mar 2025 07:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2qMTQyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C184981335; Sun,  9 Mar 2025 07:32:00 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DDB81101
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 07:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so1898013a12.1
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741501917; x=1742106717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BueZoKAlsBuHXJlqKxHoFkSZF/xH9r9pbfT5RpwgsrA=;
 b=Y2qMTQyBh+vG/OR1OenD+as/2DIC3f19lJPpwGtEHBAn6BYx6EODyjj6GFTcAlajpQ
 4upIgQqQcUMCEj1cI6sJ4kWl2rWMJAr+eJNbono3TLFO7jbZRwcjgP4dxP7nWYLBv4Rq
 80oesvndmJfbXzbW374cAXgo4KKaGFf5xowmi9fjecsLKuur7zI9sGU/akGgrXd0GiCS
 19N/AmX1/6vj3VPkXJvq8Ccp8pq4CwGzL4uoti9Tm4kR+fzJE90OmnTD6WSxLq0H87eU
 K9SkV/6kKdfyU1fRoBahvkwjqgq0Z8UeTZUefLcNY62STxaan/OtXMRW4bz17PkfJpyW
 cXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741501917; x=1742106717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BueZoKAlsBuHXJlqKxHoFkSZF/xH9r9pbfT5RpwgsrA=;
 b=jNYtVSRNG2VK4Y2jYJeKEgC/LpLTvbr9VUn4jsaDPX17YFyI3hWa06Be0VOm3Bny/x
 /IeIK00+o5OaUPE7HanMgyQVyt3ePotL9JT7+e2tmz3yMMvMci86B+Kz0zIzWkIwjlF4
 HAgMBbkMn690z3MUg9iAiye0sZJ+5/7DcAcyaNvERe1yazd+ZYRf6zwPnJK19hEGYlD3
 q3WO1BK3RAIYgjJ90vjx3WGIov6oYPYaYjj6oK94Ok84IBfPsTSs4fR1qz3F/QFZ92bH
 rt6rRXuPZciKS15rhC6OL8CaVJnSFwnxNUgAXQPo4k6YSPvebMBFYu8XOx8vxahROoF5
 G4Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpp9bZFr9s29wK32TtKrO7mAHfvCo9asAliMJdZKExCiNf8Ov9d7BCMCQhdwrI/CLQxayzbxY=@lists.denx.de
X-Gm-Message-State: AOJu0YzWvoAa853FXJ6aaBr2XlDPDMAL5qg3nrDHs/YCVJfN9jfUthgQ
 LbI7YYC4T2+yA3FIQLxm7cSwroz9DccFsEG1Q+IcfPkD2XnGpCK0
X-Gm-Gg: ASbGncuH3lONBlzMXxWSlAezxdo+BBjKZHLF9P1lL+T76RtVL6f/tHXhSKtAbAS4gKX
 9GT5PzzAGeKAaS7i9vTyykvsTVUL9VwkliWzvgL1pd0k23yAQW9tdWwV1JBzV4aFumO8Bnx+lyV
 BtSTSrluVUK9xe0K2V0tI3fzMpU9BAVhyaUwilyS3lO92d8FQanvf0isQz9uZ94+nlaBL9CiIS/
 pRr3NlxT35kaQX3dB7g51u2nBF90xyW4seIZFKT7NcEgxvoKt9Rp08KG+HMdjGY/VHFGwCvmSol
 6coFRylu1ZBz0rSc6b22KpDpVHbIt2+xsfzGKZSMau00e8WtB5BvQfWqyHdxAfqx
X-Google-Smtp-Source: AGHT+IEpauUzy1DzEkjD40U/W3Gc3OkGrGojbrbJFfXcnarULonDTm8fzj054kPoTgG+82MUqJS83g==
X-Received: by 2002:a17:907:7213:b0:abf:3f82:1218 with SMTP id
 a640c23a62f3a-ac252fba0fdmr988506066b.46.1741501916999; 
 Sat, 08 Mar 2025 22:31:56 -0800 (PST)
Received: from localhost.localdomain ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239438fd1sm552978766b.18.2025.03.08.22.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 22:31:56 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: macromorgan@hotmail.com, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] sunxi: H616: dram: Improve address wrapping detection
Date: Sun,  9 Mar 2025 07:31:43 +0100
Message-ID: <20250309063143.62859-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309063143.62859-1-jernej.skrabec@gmail.com>
References: <20250309063143.62859-1-jernej.skrabec@gmail.com>
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

It turns out that checking just one write is not enough. Due to
unexplained reasons scan procedure detected double the size. By making
16 dword writes and comparisons that never happens.

New procedure is also inverted. Instead of writing two different values
to base address and some offset and then reading both and comparing
values, simplify this by writing pattern at the base address and then
search for this pattern at some offset.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 58 +++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 6f84e59e39cd..1e21f5dd451f 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1360,38 +1360,92 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
 	panic("This DRAM setup is currently not supported.\n");
 }
 
+static void mctl_write_pattern(void)
+{
+	unsigned int i;
+	u32 *ptr, val;
+
+	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
+	for (i = 0; i < 16; ptr++, i++) {
+		if (i & 1)
+			val = ~(ulong)ptr;
+		else
+			val = (ulong)ptr;
+		writel(val, ptr);
+	}
+}
+
+static bool mctl_check_pattern(ulong offset)
+{
+	unsigned int i;
+	u32 *ptr, val;
+
+	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
+	for (i = 0; i < 16; ptr++, i++) {
+		if (i & 1)
+			val = ~(ulong)ptr;
+		else
+			val = (ulong)ptr;
+		if (val != *(ptr + offset / 4))
+			return false;
+	}
+
+	return true;
+}
+
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
 	unsigned int shift, cols, rows;
+	u32 buffer[16];
 
 	/* max. config for columns, but not rows */
 	config->cols = 11;
 	config->rows = 13;
 	mctl_core_init(para, config);
 
+	/*
+	 * Store content so it can be restored later. This is important
+	 * if controller was already initialized and holds any data
+	 * which is important for restoring system.
+	 */
+	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
+
+	mctl_write_pattern();
+
 	shift = config->bus_full_width + 1;
 
 	/* detect column address bits */
 	for (cols = 8; cols < 11; cols++) {
-		if (mctl_mem_matches(1ULL << (cols + shift)))
+		if (mctl_check_pattern(1ULL << (cols + shift)))
 			break;
 	}
 	debug("detected %u columns\n", cols);
 
+	/* restore data */
+	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
+
 	/* reconfigure to make sure that all active rows are accessible */
 	config->cols = 8;
 	config->rows = 17;
 	mctl_core_init(para, config);
 
+	/* store data again as it might be moved */
+	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
+
+	mctl_write_pattern();
+
 	/* detect row address bits */
 	shift = config->bus_full_width + 4 + config->cols;
 	for (rows = 13; rows < 17; rows++) {
-		if (mctl_mem_matches(1ULL << (rows + shift)))
+		if (mctl_check_pattern(1ULL << (rows + shift)))
 			break;
 	}
 	debug("detected %u rows\n", rows);
 
+	/* restore data again */
+	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
+
 	config->cols = cols;
 	config->rows = rows;
 }
-- 
2.48.1

