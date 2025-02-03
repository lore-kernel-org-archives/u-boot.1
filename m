Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC58C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3D3807D7;
	Mon,  3 Feb 2025 18:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RLQop4Oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6F4800B3; Mon,  3 Feb 2025 18:43:47 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE2F805DA
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb790888c6so1287247b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604624; x=1739209424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsKvCyqxwZwcI6wHy0FpWevzXxxxPV8SH7MKKyqlnyI=;
 b=RLQop4Oini4Wr0+rOowRvfzNE1HYuSLtPtfqzUZ2kD6YloQjuWd0npDYMlSM+gWhST
 lyBhZBFUNFW5rz0TAPu3LoQtaAjs1dYKLbm/aK2kKBsJTJFhl62GTChlVfda9J9KIawJ
 OsA2CQtlL65/vxTDnAOxHP0AZEDPoilSuhB/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604624; x=1739209424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsKvCyqxwZwcI6wHy0FpWevzXxxxPV8SH7MKKyqlnyI=;
 b=qsum6txnQls6NueN7Q5S17uusnoE6rHg/s7Aoc/KJ9h3Low+w+RGa/xtu0WKdsm4jH
 +hONxSoCJcw2n0KB0p9KeGq2JjNfjhCtENY36SS22xojKn6/SeuuvD6ERZbYhN5Ii5dQ
 g7TbmMALAqjQ5v/7ILVXha9VgB6vJp+obrdRUE3m62BOZvvFoJtv/vBER4s2f1FUyMkd
 4RY5XgeKq1V5rBjHXWaZBK06IJmc0dX0c4FacWk1YKn96tsIzbZAUMk/72hOnoIbosGo
 /gjdYDfD3GWdHG9kRcNGn37X09UyvzGkwOGyDAfXOp1E9i7+mIAl38IT+HGPZG1AP5Ro
 Urvg==
X-Gm-Message-State: AOJu0YzD3LDXWI8gZPVWR9at3qAQnx9j8lw85gKdDflW1NpCjNVuH4sk
 eKqn6HiIjTp7CXhe9k2am6EP23v1bc0Oii+AJr0bLQzZ52SQHm6YYjewuX44z/kbsXsTBEJBCOs
 =
X-Gm-Gg: ASbGncvbFXRLFoShPvOroe+qk7XKvO0d0uGJvSkVCiYp8+zExH+dV09Vz/FFvKwV5Te
 XclNDIFyXTEDI06bZmESpeSi5Ztvp6l2dohCzhgNXUQ1jCq397Bx7WsU5VNHV5VM+PqomkaXK8o
 CV1C3pqGi6J4FFpRuSTXGijgbivRU37Db4/4xLFKAwsAafbiRcn03Q789m9QoIMRocbyKQWpRX/
 n7tMzZcs59vNpxxfW5zrk+UR6JosryoC2sKTCY7j1Vz44nRCJTN1Cyd5fo/5IZNxPoDb5vQdXg5
 NBQUDBRmIz9PqbQp1P2YvvXqeZcQYIcNCFGLFvn3qkYGCTRpajpq
X-Google-Smtp-Source: AGHT+IHycMxklgXXfuxCRDA7a6zqSvH2joA4nquW/MAdxUufmMrJ1S5tgTL/yR9NxvzjIGgW/QhhyQ==
X-Received: by 2002:a05:6808:3985:b0:3f0:81fc:f620 with SMTP id
 5614622812f47-3f3239f4d35mr17986403b6e.2.1738604624036; 
 Mon, 03 Feb 2025 09:43:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/32] efi: Tidy up setup of global_data
Date: Mon,  3 Feb 2025 10:42:06 -0700
Message-ID: <20250203174245.1331464-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Use the available functions for setting and getting the global_data
pointer so that EFI-startup can operate on ARM as well as x86.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi/efi_app.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
index ff8b62a1e1a..1aa43b511b3 100644
--- a/lib/efi/efi_app.c
+++ b/lib/efi/efi_app.c
@@ -77,6 +77,7 @@ int efi_get_mmap(struct efi_mem_desc **descp, int *sizep, uint *keyp,
 static efi_status_t setup_memory(struct efi_priv *priv)
 {
 	struct efi_boot_services *boot = priv->boot;
+	struct global_data *ptr;
 	efi_physical_addr_t addr;
 	efi_status_t ret;
 	int pages;
@@ -86,10 +87,12 @@ static efi_status_t setup_memory(struct efi_priv *priv)
 	 * are very few assignments to global_data in U-Boot and this makes
 	 * it easier to find them.
 	 */
-	global_data_ptr = efi_malloc(priv, sizeof(struct global_data), &ret);
-	if (!global_data_ptr)
+	ptr = efi_malloc(priv, sizeof(*ptr), &ret);
+	if (!ptr)
 		return ret;
-	memset(gd, '\0', sizeof(*gd));
+	memset(ptr, '\0', sizeof(*ptr));
+
+	set_gd(ptr);
 
 	gd->malloc_base = (ulong)efi_malloc(priv, CONFIG_VAL(SYS_MALLOC_F_LEN),
 					    &ret);
@@ -138,8 +141,8 @@ static void free_memory(struct efi_priv *priv)
 		boot->free_pages(priv->ram_base, gd->ram_size >> 12);
 
 	efi_free(priv, (void *)gd->malloc_base);
-	efi_free(priv, gd);
-	global_data_ptr = NULL;
+	efi_free(priv, (void *)gd);
+	set_gd((void *)NULL);
 }
 
 static void scan_tables(struct efi_system_table *sys_table)
-- 
2.43.0

