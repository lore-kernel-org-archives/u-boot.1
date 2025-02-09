Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00E5C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB20480AE5;
	Sun,  9 Feb 2025 03:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bVTNF3Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E91809D4; Sun,  9 Feb 2025 03:02:25 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE9980934
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8551fae84c0so15509639f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066534; x=1739671334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GxPO5by47JdR6tUb09HUbCR28SjxV/XtSDiR5ZKSho=;
 b=bVTNF3WjIqx3SuwAo6bXaxwgS9Dwn58fpsFNGISDK+RHUFDQ3qvaHEK1cYkaT46a4M
 o1Cx1dKUvFOgdjYRYrOGoZaT0XgycwrTwd7tsYndpHwuBSCtJtJYKW/VEX61dQtQHi28
 /HvVdAjRNqlqcuuQhkfAjzSbNFmz94Vl7LLmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066534; x=1739671334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GxPO5by47JdR6tUb09HUbCR28SjxV/XtSDiR5ZKSho=;
 b=veup9Pfed2cRO0M/v2SvqxsoT9TzR+p8hU9uWUOjYM+N76P5L7AVfz113gXSaB8Mxt
 vrGIxTxPQh/Jrc2aau6eobTH23cKHsMBK9+qO9Yr9/FRedsqbzBMXm75IdvbK8ak4zL/
 +MKO80KYVJtoBMpuEZOzydlTHTmPHqTaRXqJw4a+3ei8QRiTz2n9Exr40ex1cQYjgn+f
 aY2WV61s5f2G8d8+g5gd9N8plITon3Smi5DmzDegS/eH6n7U/DILABHCV/IzqOCAINwT
 Y+jsvouBUJG3BB9/gfTnltU7B9/44VufLhO2JV+I7pX9xqMzF8SVA485xLjw4uP3zzHZ
 Is7w==
X-Gm-Message-State: AOJu0Yz4KBmhbfNQ7GoGept0YX/n5ZTBqsaymPLAUgWSXzgrswkNHqlW
 ZWj9VOW3V9GAQjOhe4sVASyfBec0hV1DL1U5cfUfcFp64hhi4SjERB9dDRDw2ROKKg9ZMTIt7T4
 =
X-Gm-Gg: ASbGncuVnGXI0O4dV0lGuBs4z0z/5emv0uh/sd4YaTQqg6iIYNc0t8OAV+2bWZkfImP
 2PcpkJcKlfq/ANRrsn1T3/jhSPZpjj4r0OPcTJgcvOVYbQcJrb4BdQUWCJ1Eo16FZm51iaZ7jJ+
 xsqVIiwrHv+JnzK0kyMXC7safW7UrW97lqJHmNsjtOOGnAa2FZmMeF9DrnHcrSsgn9EauzZGPoc
 u3IUjBho9wdjpW8dLJ+NghrDS7+pKk6GakPLWMHKJVJeX4qfWzdu3UasY8ZBkGuH0RVsrB/DJva
 uE8WxKbcgdhrnKP7cSvIxIKj2H/4JonYBNgU8m90e4+PL+Bl9+ch
X-Google-Smtp-Source: AGHT+IE2XgrxXXKMol9mNKjChTtoo+L6RGlcsE9oEXxaoJM+gU2CKAVeiIGcumjvc1ijOKuZ+wYQqg==
X-Received: by 2002:a05:6602:4895:b0:83a:b74c:800e with SMTP id
 ca18e2360f4ac-854fd90748dmr849894139f.12.1739066533800; 
 Sat, 08 Feb 2025 18:02:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/29] efi: Tidy up setup of global_data
Date: Sat,  8 Feb 2025 19:01:10 -0700
Message-ID: <20250209020136.4108987-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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
pointer so that EFI-startup can operate on 64-bit ARM as well as x86.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

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

