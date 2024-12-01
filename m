Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D50D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFFB896E6;
	Sun,  1 Dec 2024 16:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fVFZ07Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741D88914D; Sun,  1 Dec 2024 16:28:45 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBFD8971F
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a7750318a2so24772685ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066914; x=1733671714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXe/Q3J5sVWhLKNCsv87QQ3az8P0CzvYXx2tqnMWTvs=;
 b=fVFZ07Rqtttsp/o0i1Zln4hWEV+cUJLZKYzOtG7L8pjBKHHwzzwO1FH2Pu+nNticuV
 aDjaSfYNTZLztszTa61lH+Dk7xOVQ61J4DQcC30851zfyVY57T4iGdF+X9QlkF2XDrt8
 qFRFB+/tBTZW9Rxq3qjuhbsP/fTLNXc3NQbBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066914; x=1733671714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXe/Q3J5sVWhLKNCsv87QQ3az8P0CzvYXx2tqnMWTvs=;
 b=CM0vgziYmucLpcKEJmBLwf0HayxlRn9OlUGVgHObqJdViCEU4HJqS9nRJ30qql9JAw
 +2Jge3vaOpSUqhVXVQqjcKPZT5Hmv2QsU6zrP07xfi1843vXMH8YWTbiTiA2tS/Y4/FI
 1q4pNYbEGtvNdKth7tVUBh1+bUNtspgDMHd3Y8WfrPzKn+RdHOCh0SvmYY4Z9K+vD2lY
 A9V8JrhAjw+gTPjraenUQ7xC6Ku5aadGHUNLhfl4ttbDTwoR4FxKjESZAyWeHuph/MKP
 wQEJjzbjWfesxf+2ACbZjQtFvpguLWladlEu5C4rZOsfTViHGGsdvV5O6M0Pe2RD8KRd
 f5cw==
X-Gm-Message-State: AOJu0Yynf5Jikn54JX5owMF5zFqw02sHqN1UMpEWK8STv+m5AWHbvvPX
 4GTwX4KcG2O+xhU9Rx6N/IIy2LCCiCxRirukDnpHVB6RZiTMPQMtNrj14dfnZxCfqaW8UGlpBl4
 =
X-Gm-Gg: ASbGnctE85t1ija8QzuK9NpZzdLyzKY0WRbyhqWamSVUQNkcaJIYoQcjftmDgjvosBE
 3Jg7H4ZractoTIOWc5FtaXZSqhFBrDrP8NpmSC3/rh8PNnWpvIzAA6irpTv56xUXiT5ESVtuSiU
 1kdYwgMRdHIKb7Oj3VKTc405/BGwl6rKzEJ+lvohelckahum8EAsP9aseTdIJzpY5xDLsNZt24r
 8mSWA4a6oykRza+NOKLz+/ZeAGLsFvUOu1Q0WT+BWYg
X-Google-Smtp-Source: AGHT+IGUZYrJlSRcnlt6fZrLwa+X6cOHMSgOlbGau3n7/Xz+yLFp6QjXWNy0PyZpAb3lxtalhZU/xw==
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a7c55d6a17mr200330385ab.19.1733066914033; 
 Sun, 01 Dec 2024 07:28:34 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH v5 8/9] efi: Reserve some memory for initial use
Date: Sun,  1 Dec 2024 08:28:10 -0700
Message-ID: <20241201152815.1668093-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

The 'point of cooperation' is where U-Boot starts allowing EFI to use
memory outside of the U-Boot region. Until that point, it is desirable
to keep more below U-Boot free for loading images.

Reserve a small region for this purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h |  6 ++++++
 lib/efi_loader/efi_memory.c       | 21 +++++++++++++++++++++
 test/py/tests/test_event_dump.py  |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 26277b93976..5df3cdd419d 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -442,6 +442,12 @@ struct global_data {
 	 */
 	struct upl *upl;
 #endif
+#if CONFIG_IS_ENABLED(EFI_LOADER)
+	/**
+	 * @efi_region: Start of EFI's early-memory region
+	 */
+	ulong efi_region;
+#endif
 };
 #ifndef DO_DEPS_ONLY
 static_assert(sizeof(struct global_data) == GD_SIZE);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 76cf908c2de..344656c4eb0 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -26,6 +26,12 @@ DECLARE_GLOBAL_DATA_PTR;
 /* Magic number identifying memory allocated from pool */
 #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
 
+/*
+ * Amount of memory to reserve for EFI before relocation. This must be a
+ * multiple of EFI_PAGE_SIZE
+ */
+#define EFI_EARLY_REGION_SIZE	SZ_256K
+
 efi_uintn_t efi_memory_map_key;
 
 /**
@@ -844,3 +850,18 @@ int efi_memory_init(void)
 
 	return 0;
 }
+
+static int reserve_efi_region(void)
+{
+	/*
+	 * Reserve some memory for EFI. Since pool allocations consume 4KB each
+	 * and there are three allocations, allow 16KB of memory, enough for
+	 * four. This can be increased as needed.
+	 */
+	gd->efi_region = ALIGN_DOWN(gd->start_addr_sp - EFI_EARLY_REGION_SIZE,
+				    SZ_4K);
+	gd->start_addr_sp = gd->efi_region;
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_RESERVE, reserve_efi_region);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index 45143c1c7d9..cc802583d3c 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -21,5 +21,6 @@ EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
 EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/acpi/acpi_table.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
+EVT_RESERVE           reserve_efi_region              .*lib/efi_loader/efi_memory.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.43.0

