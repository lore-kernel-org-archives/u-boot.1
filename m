Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DBE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280C980690;
	Wed,  1 Jan 2025 23:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jWsvmLrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3702180690; Wed,  1 Jan 2025 23:16:45 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BEA8066C
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216728b1836so129068255ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769800; x=1736374600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkDMH5DTbz2285JVbKt9Y40WzPeFYumYZ+YV41WqSWc=;
 b=jWsvmLrYKt2Ds+ecrD07hYgKuGD9i5HyRPp4eUnIBEaOWVhG7vuY6psIebsrUjmUAP
 R9ykfFw/gxF2sj1dcj02PQpaIC0PKxu8mVN59JkfKjjC62s8QJq9Ywp9TMltTA59GyE/
 M3qR/bKd2T/SqcSJBH1ZIV1Lr/CDNGNUjJKpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769800; x=1736374600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkDMH5DTbz2285JVbKt9Y40WzPeFYumYZ+YV41WqSWc=;
 b=tEQuDC0L/w31UDuk+x4qn6v6CZ13jQsNK48/NEbyrQSTJrKZE5qtRKX6hWt9tgLa8A
 JOu32sdYpNIa+RF+f9Z8cpkrHt/SnGHZSY6A9UHXV890OQKhWbOh8mkwhoMvmwPxERCF
 Ki9vjEBfPbM4USWIV927pH/wzCWepBRXxtZucTbQjRZWnluL583dYqXSBzYKumNDowf+
 Vk7zjl9Nsciv0fIdq8Qe+eSqZX8PF/mqO+25QApZm414e9xIzsVzhUXiNDPlb3GenJqP
 NpuAsZut2I8u6aEBGYOIBNIKIeohP0MLO3ViXposcp/hI0n7wFSdMDGB5PWBXVAV92Xi
 9wiw==
X-Gm-Message-State: AOJu0YytVQigJiyyYwRRi1TsKVO9YvqL6xYasJ2UZshbhSsHa8EMCFye
 ChToK/jS7O5BkCeErwyx1JZ+DbGh3RbOW+E5u2imVhLlIXeLVoo1vcHlaMt2oVT5lo+bTVAoOws
 =
X-Gm-Gg: ASbGnctC8TknP59yZYIJEPq3EAVrUwKhe+kiNc8eg4JnkU9Efh3DCyj5bfglTnscteb
 Upy7OI76lz+QHHZP5ILMBraxUnmR+CoBK3xOcyAMyIc9KF55C9+VmGYFLe212B6Thb8TYaVCRQa
 Fjq51Mlj83KtPQlWBr0GAyA2Wyxcb/V4NFX7jOR9wlV2vxF+ZMO42bSqHVD77jpXjGhvD0YVYEY
 YxTUB1dk+acy1oTMzPklvdLQMHhygBEdzy77Fca2eSoLsb+klrrTVE=
X-Google-Smtp-Source: AGHT+IHUgCEGakagh7ndFc+IbY0vcrRHd2r4JsyY/BQ7JfiAnmnGoj3BecVS+zPOAECIuqiwmL3e1w==
X-Received: by 2002:a05:6a00:849:b0:725:c8ea:b30b with SMTP id
 d2e1a72fcca58-72abddbe6c8mr46087341b3a.11.1735769800467; 
 Wed, 01 Jan 2025 14:16:40 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 33/67] x86: Align the SMBIOS table to a 4K boundary
Date: Thu,  2 Jan 2025 11:09:19 +1300
Message-ID: <20250101221003.1944600-34-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This isn't strictly needed, but with UPL we use the reserved-memory
nodes to indicate where the SMBIOS table is. Tianocore requires 4KB
alignment on these regions, so it is easier to adjust the alignment
to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/tables.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5fc7dc75377..3978945a5ad 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -16,6 +16,7 @@
 #include <asm/tables.h>
 #include <asm/coreboot_tables.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -62,7 +63,11 @@ static struct table_info table_list[] = {
 	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
 #endif
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100},
+	/*
+	 * align this to a 4KB boundary, since UPL adds a reserved-memory node
+	 * for it
+	 */
+	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, 0x1000},
 #endif
 };
 
-- 
2.43.0

