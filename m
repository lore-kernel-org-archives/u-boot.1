Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F622C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA9B80BAE;
	Sat,  8 Feb 2025 18:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TL/4Zf/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB26980B98; Sat,  8 Feb 2025 18:12:34 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F677808AF
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d05b672ee6so9198745ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034751; x=1739639551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqTWw/kfeZ3ZIo2xkuCOuy8edDul1NdxRcMgzweS18k=;
 b=TL/4Zf/ixTty/Wln0NHSaiebIRZLDpIoFTz+F6RInDmHjbqg5L2kjh9UMuq08bVJ+x
 nB+70KytG2kUQqSH7ZDpPbah6kt2KL8fABbXbO9HZvfMWHt42YygpUGA8yQQ98dxp/Dx
 f+KcA5hTZEvGNEMbYhCUJs2DhrN+1hnM9G4zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034751; x=1739639551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqTWw/kfeZ3ZIo2xkuCOuy8edDul1NdxRcMgzweS18k=;
 b=imN/UEFIzQxo3NR+5RExWSkb8EfVwYRasTJVF12H86gETGz9CArf6I/S2EpsCIRBTU
 VH9vTwcpa5eeEXr1ckgzezmokpIFgE6YBmdCu4oJHJuQa1Yop/3mtEjFM2p+88J6jxrJ
 uTku2ZgzcNIkC/DVEnTmcaHNSrBQjoIGMQA1hVRxGehbbaZIlc6Z0W4uKUYWlAftGQUT
 jwPmQSlmCt9uw4ke1slDFb64pHCEcO4N1UN9p/pgZk4cSltGToP7QgEcjbUg4+Owr93A
 fmkp7WnY0e2j/hK3MfXm2Ue47kr4kx3XwpBIbUi0YLFtYR3fXKsDSfYkL4/0TCynSoAt
 vihg==
X-Gm-Message-State: AOJu0YxBoxWVGfh096GHf8NTFQxZn36Z1FGljElv2s/6akO01Srv9+IA
 tVJqfcI86EXk5nzr8qL1taEhnqJEl71HsQWlNdo/pj250nyT8+3ZXF/TCFLal5iS6OcddkwZe/Q
 =
X-Gm-Gg: ASbGncvrdjan1VjeMRccZhxPSxcCysdFv3bGKqjCFwoFhymvwI/WV0PqkgstXdVimqT
 BrxcmUz/HZcksBRnQ/FeMvzhfBg/roir7QILNGiwG+hJkXGwZzFWC8o6ZC7ptk9gWqMmxTw9GBX
 plc05azUVSeTdgAPWW4+c7V8XJXGYgJ8PFSbCzlp+rtALG72AfN/o/s/n+V8vYeJGcaEAvp+9TZ
 /cDs/Xgw/hgKXCNoYfvKktnZrr1wNaxH6vD7iCFT/acE3eaidIRH6V4TzeHR7gklR/gkzDDLKaw
 B0WM408vxUF6QXIWqNdAl4pF93ugFhxjn7P+QHK+EGk5Jq09sdag
X-Google-Smtp-Source: AGHT+IHCXEfM6CB+sX1znPXtYrVx1ZmSkUemlcFP9sKj5zhixVxvo8KxPVYQvR4nlaQLDuJJVCHdJg==
X-Received: by 2002:a05:6e02:12ce:b0:3cf:c07d:e9a with SMTP id
 e9e14a558f8ab-3d05a58d185mr87418195ab.4.1739034750697; 
 Sat, 08 Feb 2025 09:12:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/29] efi: Tidy up setup of global_data
Date: Sat,  8 Feb 2025 10:11:31 -0700
Message-ID: <20250208171154.1305761-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

