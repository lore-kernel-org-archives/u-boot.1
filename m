Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3FBE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA98B80391;
	Wed, 11 Dec 2024 14:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NYBUNRKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217C78033A; Wed, 11 Dec 2024 14:55:00 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B719480296
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a761a622dcso41757475ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925296; x=1734530096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+rWJ50hzSuTHueLl65HW7iB4Qq7gPY8hiC9K/rIDUg=;
 b=NYBUNRKYoIazAQIjZblgMuTHsDBu0+70vyyM4pUISlFH4G8VMYc1P0N73J7xVLcNBV
 iBXLRfQmxlAQiTZWirTLp5yKWfkYj1NtAm2a9XoKxTwYSbsqgfPzUF2CS1YuPM61lO9h
 vfTgRke263NbNCROKqIRIZSc1qxMlADI7ChoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925296; x=1734530096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+rWJ50hzSuTHueLl65HW7iB4Qq7gPY8hiC9K/rIDUg=;
 b=vFH/kdNh9an7TilaMFfW8e5Ug5yh8DPeKliJKtSYXztf1viN+5m9lVpcEtLC34bdM1
 LhAg5tQu2KaO97IkvgUhUUVP4o3g85+ZvEjrHtgl8f9mpO32YwzECw8GsPQlMBmBuAIp
 KmvUmFoWuCgZytX9QubBuAS1hZUChpfB8Xvx3IovR67XNEO42HrubrSAwTzPDb/m5RAz
 jmbyXkRx3i/bV8pYkCzpet5dPjIhmq5qoemqQKhuJwReiLEioWb/RMabHfc8hMlWXBaH
 e4jcfrAtN6QvIFWi7k/14TnpJ4Q5byY9aC1HDB1jmnZI+pmqXvOwIgAhi2qd0lF4+foz
 RTCw==
X-Gm-Message-State: AOJu0Yw/ORCJ4ulDQ8gTyMiEkJvGFNSxQ/AvFiyy5fSS1WrAgnMo0EaY
 Jj20c377MKhkPsgivVEGr4knHsy7Nh4Vh8ouBeNAO/+qAcdnFQkwG+ppcRNlTQlfPtrqIwlngYA
 =
X-Gm-Gg: ASbGnctS7r5OaInG4CIpjF5+L2Snv/64tCYq+JBl+2nxXW0u+dmLRiv1M2AsFaL9/o1
 pPalRpvXMkNvhjn9NBVb2bvXKQnvVclXmOSne3yvIh+vW0pnx3gGSGeOnVP3cCmbfNCnBh7H+8n
 Tng2rMiTq6zehkaUrOcFPXO+EiAyI6gU4IyDjPlv+4IZpN5Ck5fycRVRLSOfI+XddbgI32cMOlT
 zrl7vYN54EDkJywcMcohyn50eKkiSeypKOT3FJ/X+lMwYPS1xcQxnv+vbdx5KjhSonl8xUdqmrk
 QrgrbLzhDi70408=
X-Google-Smtp-Source: AGHT+IEbP9clVPwv892lAbizUd86UNNHWS38WV4OkkLEfBKgREq+vybaM+2vRs9H42zSj6qRIhnfYw==
X-Received: by 2002:a05:6e02:1c05:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3aa0ac2f0famr29562825ab.24.1733925296002; 
 Wed, 11 Dec 2024 05:54:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
Date: Wed, 11 Dec 2024 06:54:12 -0700
Message-Id: <20241211135418.563803-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

This cannot work since the code is not present in the emulated memory.
In any case, sandbox cannot make use of the runtime code.

For now, just drop it from sandbox. We can always adjust things to copy
it into memory, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 0f149f99c7d..6475b94f951 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -767,16 +767,22 @@ static void add_u_boot_and_runtime(void)
 	runtime_mask = SZ_64K - 1;
 #endif
 
-	/*
-	 * Add Runtime Services. We mark surrounding boottime code as runtime as
-	 * well to fulfill the runtime alignment constraints but avoid padding.
-	 */
-	runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
-	runtime_end = (uintptr_t)__efi_runtime_stop;
-	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
-	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(runtime_start, runtime_pages,
-			      EFI_RUNTIME_SERVICES_CODE, false);
+	if (!IS_ENABLED(CONFIG_SANDBOX)) {
+		/*
+		 * Add Runtime Services. We mark surrounding boottime code as
+		 * runtime as well to fulfill the runtime alignment constraints
+		 * but avoid padding.
+		 *
+		 * This is not enabled for sandbox, since we cannot map the
+		 * sandbox code into emulated SDRAM
+		 */
+		runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
+		runtime_end = (uintptr_t)__efi_runtime_stop;
+		runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
+		runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
+		efi_add_memory_map_pg(runtime_start, runtime_pages,
+				      EFI_RUNTIME_SERVICES_CODE, false);
+	}
 }
 
 int efi_memory_init(void)
-- 
2.34.1

