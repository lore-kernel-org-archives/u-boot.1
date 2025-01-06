Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C83E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06B5805F4;
	Mon,  6 Jan 2025 15:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GIEFDYR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C19780703; Mon,  6 Jan 2025 15:34:03 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABB88071F
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a777958043so57473365ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174037; x=1736778837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJuod2133Yb2DU1mqa9LOfnKWrza8l1PhGx5HiujCGI=;
 b=GIEFDYR1BIJd/0L0KEKybnoHUB9h+djEkaeUHm+0TlLV60auCVcvWG5f8lpU7asv+G
 yIOQX5otnIZ1EzsB9/dYrhuv8Z+lUDlowte+Fe+hbyuzYgJXQZupWUoW9zVrZ7msYtfm
 YYlmAlZUkOIB55bIhZWsMYQYCPSrpiXa64N2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174037; x=1736778837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJuod2133Yb2DU1mqa9LOfnKWrza8l1PhGx5HiujCGI=;
 b=ubkh4iDqGsqFw5/a+32uzcHuqY63aWCCn+nF6wweNE0k1bjCZ7bJ75b5tOSjbfmxDq
 tra+xnOeerP6N7+BoO7h3UJnhFeOcBNYel/RAWw9jDauGCfLbhkgJbMpNN94heBMnRuG
 QzGrxNbPE5Dsg7VUKYny5vzfahJCdnnNgFYwJuwlCD0Nc40s8W5jNmpC58j+7PKG1uN5
 XgqDU2xlbp/jhXBZP74E6w2U9JBYjNa9JTv6w/3gFCJ2U5bckU0f3d/FPFT/IPfEsEP6
 KtRYx92/avXzHq5j5uzouDx+lUMhGwR3fVP9JnUD63jCcR8gvzF5fujvZW7+B4j/2V+H
 89fA==
X-Gm-Message-State: AOJu0YzIscwEUlaCzv6sbAyQ1tjyvCBgWX3JhCGR+bANFxgyXwkIJ2Co
 cyV3SRHc2poznTR47HbQxTglQU8Se1nbxKP3cg1xNEhAp1CvzBIVw+ZXlPWUEy8r/6L6AK61TGg
 =
X-Gm-Gg: ASbGncttSRPenUvnYs/50+8A7JmdUcihJ8N3qUtu23RqKaImGuo6GoB54S3OlkR7g5a
 uv6s1U09aeff+lK5ihSDbIPOU5Fpc5j9F0cenMolWpVSE61DE4pPZEW/S2s5eDkeAxuRc91zE35
 H8gZCM8rjuVHNkWCI/HACTjmJb2Q0ErdJkHtjn3zfvQGh3w9GxJ7tnu97QX3eqfcSKHCWWlTzYT
 KLtfjoXmJLmYDqxVr3j0JPvwNSHCrTzyIWKQZCCsWFYPt2R0F0t3DrdjKKw0UvL37QgESropZFg
 7AWW4OoID7RFW+MVqw==
X-Google-Smtp-Source: AGHT+IFVAqTkkC0PT2iRSgadXSIQnz6SizZbokKJZtQn1W1FjIvje8ODWylmhpmFYme4hKxnOSaEmg==
X-Received: by 2002:a05:6e02:3042:b0:3a7:fd5a:8b8a with SMTP id
 e9e14a558f8ab-3c2d2d4f1abmr551147505ab.12.1736174037639; 
 Mon, 06 Jan 2025 06:33:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/33] x86: Move tables to use SZ macros
Date: Mon,  6 Jan 2025 07:32:24 -0700
Message-Id: <20250106143229.3023771-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Update the tables to use linux/sizes rather than open-coped values.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
- Add new patch to move x86 tables to use SZ macros

 arch/x86/lib/tables.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5fc7dc75377..9e4f21ae5ad 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -16,6 +16,7 @@
 #include <asm/tables.h>
 #include <asm/coreboot_tables.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -59,10 +60,10 @@ static struct table_info table_list[] = {
 	 * that the calculation of gd->table_end works properly
 	 */
 #ifdef CONFIG_GENERATE_ACPI_TABLE
-	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, 0x10000, 0x1000},
+	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, SZ_64K, SZ_4K},
 #endif
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, 0x1000, 0x100},
+	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, SZ_256},
 #endif
 };
 
-- 
2.34.1

