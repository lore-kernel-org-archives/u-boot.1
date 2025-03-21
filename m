Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AB5C36001
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163DA810FE;
	Sat, 22 Mar 2025 00:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wXdibR2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D35F81D5D; Sat, 22 Mar 2025 00:21:56 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E331F81B4B
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95F843FCE1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599302;
 bh=F7xZr0hIJKIZ5NJ5I6RODdWqFxePxIErW3fz5295T+8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wXdibR2lijDJ8Q640eTAt9owsbFl5mVceyqAMrjFvR0FxOHnMkMFPeR20WYnpXw9C
 hJw1T54qdVEnlJlV0DP9vEo2XwMfujDZ85dvvK/AChS2+LL98zAgF2mTRrn+w7TlUh
 FnJbFZBFbuy9+nai2wqeWaJJ7PESjmgvsR6nnzyDC9972tcT7TKcbS5V2Zb+tfdyzy
 xLPkXZSS1dG3GcFM4qBHRzh7E+KGPiAujK43uW9+0lj2PP9pJj3nzf6HbsYHviw/+I
 HZeJf2ZsUtWkxAvy9ZZQdw1VJvge8zlPW1zkPe8L6Fc+ZvVI4FpH39o/HfUXyLyULy
 WhktwJYR2X0WQ==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso146750866b.3
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599298; x=1743204098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7xZr0hIJKIZ5NJ5I6RODdWqFxePxIErW3fz5295T+8=;
 b=CxAp/h94v3ow5sQL7evbsqRPfJUn0sYK6uU2i6xEyrVb17M+b+E9FBfOdbK8V9lZJY
 4bi7vNVxNcTkjp/+cWMoviOd+iVa7Q21Nb1VCWMWs24O1KcwqwJ7K+HY/aDM/oQL60qL
 2Y+p35aBhSlwOyMhSi+69xAeldtLzvp8QuglBbp3clHHYVevfmOUAOUQRq5N9agNMrd/
 z162iQE59vatH4d8ebF843nTFJvILSN72/C27vwdvktGQHS/qCVLcVk+CF00RqU/Q/1K
 Lwj67atHi2ytuK4DLfKvSs+UOWgBxDAyps9v4nmhMGUJrvt8APe3MlfPQ8IuiNiWyGR5
 Lcuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbR5yzxLGsA4Dq7bfnAlfnSG9BkpBPBW6jt652HT8LsYvj6JEGMjOW4duaJ93T3psik7+lvjc=@lists.denx.de
X-Gm-Message-State: AOJu0YyeRv4KvSJ6JDpT5mRS5qS6sVPxgU9vBo3YKlgds3QpPjGtNsX0
 e2XsOHITxOknA+YjduPXIXtFrq+SsrUrR30s3OJmTPaLBjWGnJSE3mDjbLbPTIaGLj7RTOqheg9
 FLHKLTht6Ove7mNxjWfvPiG/qK1uhAWKMN15eCTMku1bMCAmcoALS6+eIgLsRP9qX7oM=
X-Gm-Gg: ASbGnctShY9a0cNXHVYcnpCVYNA30ODn5ndc4DnjzeTxogFRQ/+ngdN9HIwAmYQ/6kv
 ibXH8wlOVNvvaNMd99t4d3oElWDhiPjCrT3ZPg6Gc9IoF/KMJ9b19NKUQBUYTIFudjlgRRmoyBn
 lbg1oiFFyMyhPYaKsM4lB7+RVbJ7DCjKDaeVPy2ur8FPYNA65tVoNF0q5iHR2c2O5EOVb9lSoX5
 4z6PNrgwvlSMuJSJ84Wkr59NzET8kamrVdFXnvlp9hQ4CJJb8GIV2qfwWmpgKEno0jfP21Juejg
 vHcpmWtL+8q4ub6iYu89Wi9v2YKFuJOq7YzyrFgxFwNmIrJNKuiOPhqqL8ScOM7UJqAMR8/v7T+
 qnVCYVZS/0szZ06Lqow==
X-Received: by 2002:a17:907:3dab:b0:ac3:3cfc:a59a with SMTP id
 a640c23a62f3a-ac3f26b18e4mr433643566b.45.1742599298321; 
 Fri, 21 Mar 2025 16:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD8Iu4n29iFDvl52ejGPMolL0IIs7lnosrA0DENLvB5/2wX+qUXW79p20qhUdi0i+4wVbJ1Q==
X-Received: by 2002:a17:907:3dab:b0:ac3:3cfc:a59a with SMTP id
 a640c23a62f3a-ac3f26b18e4mr433641166b.45.1742599297908; 
 Fri, 21 Mar 2025 16:21:37 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/5] x86/acpi: simplify updating header checksum
Date: Sat, 22 Mar 2025 00:21:18 +0100
Message-ID: <20250321232121.251800-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
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

Use acpi_update_checksum() for updating ACPI table header checksum.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/cpu/apollolake/hostbridge.c |  2 +-
 arch/x86/lib/acpi_nhlt.c             |  2 +-
 arch/x86/lib/acpi_table.c            | 11 ++++-------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/cpu/apollolake/hostbridge.c b/arch/x86/cpu/apollolake/hostbridge.c
index 039236df02d..284f16cfd91 100644
--- a/arch/x86/cpu/apollolake/hostbridge.c
+++ b/arch/x86/cpu/apollolake/hostbridge.c
@@ -298,7 +298,7 @@ static int apl_acpi_hb_write_tables(const struct udevice *dev,
 
 	/* (Re)calculate length and checksum */
 	header->length = ctx->current - (void *)dmar;
-	header->checksum = table_compute_checksum((void *)dmar, header->length);
+	acpi_update_checksum(header);
 
 	acpi_align(ctx);
 	acpi_add_table(ctx, dmar);
diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
index 880ef31df7d..8aae5fa5af7 100644
--- a/arch/x86/lib/acpi_nhlt.c
+++ b/arch/x86/lib/acpi_nhlt.c
@@ -414,7 +414,7 @@ int nhlt_serialise_oem_overrides(struct acpi_ctx *ctx, struct nhlt *nhlt,
 	cur.start = (void *)header;
 	nhlt_serialise_endpoints(nhlt, &cur);
 
-	header->checksum = table_compute_checksum(header, sz);
+	acpi_update_checksum(header);
 	nhlt_free_resources(nhlt);
 	assert(cur.buf - cur.start == sz);
 
diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
index 3186e48d63b..b13292c4150 100644
--- a/arch/x86/lib/acpi_table.c
+++ b/arch/x86/lib/acpi_table.c
@@ -173,7 +173,7 @@ int acpi_write_tcpa(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	/* (Re)calculate length and checksum */
 	current = (u32)tcpa + sizeof(struct acpi_tcpa);
 	header->length = current - (u32)tcpa;
-	header->checksum = table_compute_checksum(tcpa, header->length);
+	acpi_update_checksum(header);
 
 	acpi_inc(ctx, tcpa->header.length);
 	acpi_add_table(ctx, tcpa);
@@ -242,7 +242,7 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
 	tpm2->lasa = nomap_to_sysmem(lasa);
 
 	/* Calculate checksum. */
-	header->checksum = table_compute_checksum(tpm2, header->length);
+	acpi_update_checksum(header);
 
 	acpi_inc(ctx, tpm2->header.length);
 	acpi_add_table(ctx, tpm2);
@@ -279,9 +279,7 @@ int acpi_write_gnvs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 		 * patched the GNVS address. Set the checksum to zero since it
 		 * is part of the region being checksummed.
 		 */
-		ctx->dsdt->checksum = 0;
-		ctx->dsdt->checksum = table_compute_checksum((void *)ctx->dsdt,
-							     ctx->dsdt->length);
+		acpi_update_checksum(ctx->dsdt);
 	}
 
 	/* Fill in platform-specific global NVS variables */
@@ -330,8 +328,7 @@ static int acpi_create_hpet(struct acpi_hpet *hpet)
 	hpet->number = 0;
 	hpet->min_tick = 0; /* HPET_MIN_TICKS */
 
-	header->checksum = table_compute_checksum(hpet,
-						  sizeof(struct acpi_hpet));
+	acpi_update_checksum(header);
 
 	return 0;
 }
-- 
2.48.1

