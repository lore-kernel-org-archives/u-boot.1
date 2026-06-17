Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B4CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE39848D1;
	Wed, 17 Jun 2026 09:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VJEIt0vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A9B84994; Wed, 17 Jun 2026 09:49:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B6B8493F
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so42378485e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682566; x=1782287366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+azyrCPWO6dz78lmrhuArYC/cJcFBbT/d/RvZwz0zw=;
 b=VJEIt0vtCqU82dD+QSiM1MrlDpPOw5THbrwLr6SlSkSG3vm1HPwU8e4C0Fs820GQvX
 lhheAcVWALfXfIGKG2GrzDiJN4JaN2p3zfNwUjTd9KnFpcEgTeOMkB/LmlbkybEkvLvr
 2jXEqxuCIZr8dTDjj95n+CB5IQa6V8Usv5gGdw3UG5ToPwqQ0haSzuuZYdAql0Lb6nGH
 m8EuAT+7cRJHFF3gxfI6oXEHKxKz+ieET7r6PQ3k5wGCLPUcMZ+dWFXI/++b+hoesNu0
 Svj10d7z8wGth83Roak2StRLRz0tEhywrdRWRoXMw8lPpE7Q9h02PGxGvOuUhIAnMpAQ
 a0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682566; x=1782287366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B+azyrCPWO6dz78lmrhuArYC/cJcFBbT/d/RvZwz0zw=;
 b=n2MgbtEkiEBalzQHv9pEQa0x2vNkRWcTSjgECLAemubO7FsVfCtxPVBwScFuAH3iXJ
 if4gbq1A713oivZCCNvE0NBx0sB2ZhFLjb9JyQfaEz5SC9F7o/lP0+gZbwlm8TVxc0sm
 B6vGuZ2tUiZ+BgyfNsFd6JRoANTysbZLOe6rON9PTbkCDJuak4cVV/BmoaseEMiQLWHZ
 FCxW2jIZ6z+bl0TDUOBtG+VZA0Y5hiG3CTBrMzXtR+KmdNkCDIqK60/j87LgNs1JHOXk
 bp2u6El946DcBFResKUR8TGw+/3MbBLPjBWe4nul31X9EtIpHqB3eD5LiYlYKzLLVI4L
 VH5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PivN+PjQXDRoEzljebzafIVQtA+CC5/ACdd3rL0XJeNQkN+oGJhdDbyIyiEABxy+j2vr4i4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyAGl7Ffk9/JkIY6xKK4mv6rdSOsf+BNZX3SHCmsOMjOMgABxX0
 HsIpSceZi/ft+HGaZRQrng2e5O5iF7+9+GFKHZt2nCmYCXljKh8OSxluPd2ns4DyBLQ=
X-Gm-Gg: Acq92OErO9gJevzDcTLccDq2x5W1a7F1J7kax8/Ims5F3HrPxWTMyGjbO9pkjJee3O1
 ht+l0Jk+fXD3tEBZg24/zFdd+NpDMn6HlCbJmTVEAGfg8zvEeoTgDc2N5rszCP81IzrdDTMGQqY
 1hfbpZzWGvWowEf1Zdxhs6SHt5jsLvGA4rDAQECmwLOwGxxB0TaPNAs/ZxAQYSXXE1PHcYMRv0x
 WKmEIjQb9N7aXO7fDao3saZwpzYYRrtjLpxhHMOys/A9piCvlCh3qcdXHTSxrVRQhS/aiPYPZLV
 3MkJ5HHbt5Pg7zRfUfRZnb/UuMDR3JJyRFX37nDyxYA4P7x6tiBFRbOYzFqUM/Y5L76Y/GgsWBK
 mfkQ82slnsgLqjkrTTGg69K2UYkX2qRV25/rTAItgJshB9QcXRcmQdP43SoGROhWPw2SaWVz1/M
 TxwaMnVNVvkWuVn2Z0M6+inS3nsZPni/GWJ6KlZzWl/GjM6tSunvyJ2PG3vVvXI5CdPHZOIdkNV
 ppkrZiwuZrZ8gOdT7FHFupNOLyIlQ5O4c2aX8w6Wk5C7uCFvqJqvggCA30OJIpuUSpLpY0I2I1p
 6nCY1h3tBlbZaxCB2u0U3Mm+cqDzeBecmh5aNmo+UKIxmbYb8KsBFf4ng01OvQA4Pm/SN3cQ2rd
 4jbjcqsTPkQEh7XZ/FlmlzHXcS0OJJ+JPJvLYeYonLJmx+jV1ep/StxwaEZzA1aHDRWepLUkjOB
 EENqUOkGjlxVQLfkBQU4iLUTn1fbFeWHJFqpw948ZzVpwdYZbr25YSgqiKGjzvHRHx0B5Uzomds
 pYyn57bmhj3w4EH0g==
X-Received: by 2002:a05:600c:19cf:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-492333a54a4mr39655485e9.5.1781682566593; 
 Wed, 17 Jun 2026 00:49:26 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:26 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v7 3/7] common: Clean up setup_dest_addr()
Date: Wed, 17 Jun 2026 10:48:21 +0300
Message-ID: <20260617074846.84362-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Right now the function does
- Re-adjust the ram_size based on Kconfig options
- Set ram_top
- Set the relocation address

It also does not set the ram_size in case ram_top grew
from it's initial value. But ram_top and ram_size should
always be changed together.

So let's make things a bit cleaner and move the ram calculations
in their own INITCALL

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index e169ed930911..b3e633418e1b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -336,15 +336,9 @@ static int setup_ram_base(void)
 	return 0;
 }
 
-static int setup_dest_addr(void)
+static int setup_ram_config(void)
 {
-	int ret;
-
 	debug("Monitor len: %08x\n", gd->mon_len);
-	/*
-	 * Ram is setup, size stored in gd !!
-	 */
-	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
 #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
@@ -360,8 +354,19 @@ static int setup_dest_addr(void)
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+
+	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
+	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
+
+	return 0;
+}
+
+static int setup_dest_addr(void)
+{
+	int ret;
+
 	gd->relocaddr = gd->ram_top;
-	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
+	debug("Reloc addr: %08llX\n", (unsigned long long)gd->relocaddr);
 
 	ret = arch_setup_dest_addr();
 	if (ret)
@@ -983,6 +988,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.43.0

