Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FA9C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 08:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB348082A;
	Sun, 16 Mar 2025 09:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="TVmYAat7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCAE803DF; Sun, 16 Mar 2025 09:33:31 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD418186D
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 09:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so4999766a12.3
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1742114008; x=1742718808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IUXapQQ6tmhz7dglYEIRWsut8iEaVmVT9YYKzC7zD8=;
 b=TVmYAat7J/m4CqbtRIM5mMUXIGyGV+/y3/6ZBKRf7MepTUZm8W9+zyI3tNCgYfgS5M
 +YWQgHgpYfqHze74jwzre3q5xDaBDLyN0CqU+f3cClqdWE37uYTe7hhKlTpyoWYgxj88
 IlXbWQCycapnfBGzBFeS4Vj7dhHv+pn9FuMSrTEy412o9SHFMywA0FNER4Gx644uugFl
 6bFSiGTdWkxMdsqF/0kqh4+OP0vBUToF6QEe+f+tl6DeOZnmMfJt7A/bvTcp+m6hiyEa
 WncTylvBPXKqmUz26eYuQQJJQRJfhiHCA7bU6o8XU8YqcdqwwhDDC0JwLSU3RWyCyELf
 PIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742114008; x=1742718808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IUXapQQ6tmhz7dglYEIRWsut8iEaVmVT9YYKzC7zD8=;
 b=XU1FuugK6p3gk0zgpzEUP282+ThK1X5qSRB8OTs3jPSIVG4QOZ8I32udyPNKeWciPb
 iRsFqb+mcybc1DJkPTPHcJX4Qx0sBXFglTe6S1If5PeG4uOCnJsSf34PuSRDgiNvcXJd
 4waJislUKD6d/ILiwT/5T8xb+GKQJNEnFe1NPuCsEhn/NhqQD6wIkRfx4s9Jo5OeIfiG
 k19wHLVNSX1LwOgdFzyj+/80vMb8oI7vwWDwNxJKRLqxBNR5eVqWfbO3F4zSfopcaD5B
 RLuyLkkewuIJdSCrgfapzUmBbt1wD7XmfH62zX8adCAvKXb0hBJHDHtMaG3KuMLjVMCp
 ELQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vL29z/dDBaEtF1TEHotm59u2wYyKGd8g8Wh/GHfaT/6MDtlnoGEIBf+m64dZVDXS4QXTyjQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyorz/fM+NfJEwp5I0N/gudlHS56URzY2FAvx+CHl85NZq7Lph3
 XCgHUvhVueWEHZIC+gO7vzSC64gCH/2DNrDvL7lVuLVfo0pgEYb5ynmnPIXu7kE=
X-Gm-Gg: ASbGncsLrMmlF2HAd1JM/OlkQsyXQ1kYkwAkN00FthmZ8r4JjC6QqLmeR64B7caRi/X
 V1CkQ1KNbuUPCjnR5H+k90k8QN4ib4QLMTDlbrTyQwnspaXS1O/2KtHKt3EMlKPOHU46TscSpHS
 SG9fVQ1j2IVKWeDr0nvrnoaING2N4z20ebM6wNo/lZnEAIGFYDr1yxoSJHZOOuI5vT+l2g7aDxb
 JhqHPnvB3xPEa2jbC9uHzrIINLAey7JBHq0qc+lG58MfCkFk1Rlg3T32iKyfL6pk8GjSTgMyehM
 KjHM6xynFngl6IlLe9cY2ByXLaH4Gfl9AOpqNHfqp/52qKUlY2w/x1SFGHxSbrMYfXFmXMumabK
 qakFAdKuZqI47kT38NNjy8eXZNUdImqNJ8QUzTAr8LE4=
X-Google-Smtp-Source: AGHT+IF3+Xgu7Offnhvx2cnRYw4ekUutAfPCm+NSxPISjo+97KwddFoGpaL6KOxOL4NdfJtxHI84eA==
X-Received: by 2002:a05:6402:40d1:b0:5e5:bde4:755f with SMTP id
 4fb4d7f45d1cf-5e89f448d34mr8108944a12.14.1742114008349; 
 Sun, 16 Mar 2025 01:33:28 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e816ad38f3sm4335232a12.63.2025.03.16.01.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 01:33:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 5/5] test: acpi: Add IORT tests
Date: Sun, 16 Mar 2025 09:32:56 +0100
Message-ID: <20250316083300.2692377-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
References: <20250316083300.2692377-1-patrick.rudolph@9elements.com>
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

Add tests for IORT table generation:
- SMMU_V3 node
- RC node

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 test/dm/acpigen.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/test/dm/acpigen.c b/test/dm/acpigen.c
index 23c16bd9866..ee9517f9c29 100644
--- a/test/dm/acpigen.c
+++ b/test/dm/acpigen.c
@@ -1742,3 +1742,118 @@ static int dm_test_acpi_write_tsd_package(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_acpi_write_tsd_package, 0);
+
+static int dm_test_acpi_iort_smmu_v3(struct unit_test_state *uts)
+{
+	struct acpi_ctx *ctx;
+	int smmu_offset;
+	u8 *ptr;
+
+	ut_assertok(alloc_context(&ctx));
+	ctx->tab_start = ctx->current;
+	acpi_inc(ctx, sizeof(struct acpi_table_iort));
+
+	ptr = acpigen_get_current(ctx);
+
+	smmu_offset = acpi_iort_add_smmu_v3(ctx,
+					    0xaabbccddeeffULL, // Base address
+					    1, // Flags
+					    0xffeeddccaabbULL,  // VATOS address
+					    0,  // SMMUv3 Model
+					    3, // Event
+					    4, // Pri
+					    5, // Gerror
+					    6, // Sync
+					    7,  // Proximity domain
+					    8,  // DevIDMappingIndex
+					    0,
+					    NULL);
+	ut_assert(smmu_offset);
+
+	ut_asserteq(ACPI_IORT_NODE_SMMU_V3, ptr[0]);
+	ut_asserteq(68, get_unaligned((u16 *)(ptr + 1)));
+	ut_asserteq(0, get_unaligned((u16 *)(ptr + 4)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 8)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 12)));
+
+	ut_asserteq_64(0xaabbccddeeffULL, get_unaligned((u64 *)(ptr + 16)));
+	ut_asserteq(1, get_unaligned((u32 *)(ptr + 24)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 28)));
+	ut_asserteq_64(0xffeeddccaabbULL, get_unaligned((u64 *)(ptr + 32)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 40)));
+	ut_asserteq(3, get_unaligned((u32 *)(ptr + 44)));
+	ut_asserteq(4, get_unaligned((u32 *)(ptr + 48)));
+	ut_asserteq(5, get_unaligned((u32 *)(ptr + 52)));
+	ut_asserteq(6, get_unaligned((u32 *)(ptr + 56)));
+	ut_asserteq(7, get_unaligned((u32 *)(ptr + 60)));
+	ut_asserteq(8, get_unaligned((u32 *)(ptr + 64)));
+
+	free_context(&ctx);
+
+	return 0;
+}
+DM_TEST(dm_test_acpi_iort_smmu_v3, 0);
+
+static int dm_test_acpi_iort_rc(struct unit_test_state *uts)
+{
+	struct acpi_ctx *ctx;
+	int its_group_offset, offset;
+	u8 *ptr;
+
+	ut_assertok(alloc_context(&ctx));
+	ctx->tab_start = ctx->current;
+	acpi_inc(ctx, sizeof(struct acpi_table_iort));
+
+	u32 identifiers[] = { 0 };
+
+	its_group_offset = acpi_iort_add_its_group(ctx, ARRAY_SIZE(identifiers),
+						   identifiers);
+
+	ptr = acpigen_get_current(ctx);
+
+	struct acpi_iort_id_mapping map_rc[] = {
+		{0, 0xfff, 0, its_group_offset, 0},
+		{0x1000, 0xffff, 0x1000, its_group_offset, 0}
+	};
+
+	offset = acpi_iort_add_rc(ctx,
+				  0xaabbccddeeffULL, // Mem Access Properties
+				  2, // ATS attributes
+				  3, // PCI segment
+				  4, // Memory address size limit
+				  ARRAY_SIZE(map_rc),
+				  map_rc);
+
+	ut_assert(offset);
+	ut_asserteq(ACPI_IORT_NODE_PCI_ROOT_COMPLEX, ptr[0]);
+	ut_asserteq(36 + ARRAY_SIZE(map_rc) * sizeof(struct acpi_iort_id_mapping),
+		    get_unaligned((u16 *)(ptr + 1)));
+	ut_asserteq(0, get_unaligned((u16 *)(ptr + 4)));
+	ut_asserteq(2, get_unaligned((u32 *)(ptr + 8)));
+	ut_asserteq(36, get_unaligned((u32 *)(ptr + 12)));
+
+	ut_asserteq_64(0xaabbccddeeffULL, get_unaligned((u64 *)(ptr + 16)));
+	ut_asserteq(2, get_unaligned((u32 *)(ptr + 24)));
+	ut_asserteq(3, get_unaligned((u32 *)(ptr + 28)));
+	ut_asserteq(4, ptr[32]);
+	ut_asserteq(0, ptr[33]);
+	ut_asserteq(0, ptr[34]);
+	ut_asserteq(0, ptr[35]);
+
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 36)));
+	ut_asserteq(0xfff, get_unaligned((u32 *)(ptr + 40)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 44)));
+	ut_asserteq(its_group_offset, get_unaligned((u32 *)(ptr + 48)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 52)));
+
+	ut_asserteq(0x1000, get_unaligned((u32 *)(ptr + 56)));
+	ut_asserteq(0xffff, get_unaligned((u32 *)(ptr + 60)));
+	ut_asserteq(0x1000, get_unaligned((u32 *)(ptr + 64)));
+	ut_asserteq(its_group_offset, get_unaligned((u32 *)(ptr + 68)));
+	ut_asserteq(0, get_unaligned((u32 *)(ptr + 72)));
+
+	free_context(&ctx);
+
+	return 0;
+}
+DM_TEST(dm_test_acpi_iort_rc, 0);
\ No newline at end of file
-- 
2.48.1

