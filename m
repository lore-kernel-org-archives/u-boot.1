Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0FCD0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB634893DB;
	Fri, 11 Oct 2024 23:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fn8LTNrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53173893E7; Fri, 11 Oct 2024 23:23:45 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3199893D2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a3a7b80447so9456165ab.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681821; x=1729286621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZxLV9LPSThnc3VwGw32siFmYdhXdn2Qt1S+C96Ee24=;
 b=Fn8LTNrE20mEs0AsoMIgvFbY7WGjpTf92E87BYtHjBCAFmCFlCAjJZPc9ZINR9UJTb
 3TnEf0+d2MwMkqWbXmo0+llEH4m7YF9hQpu5uw9IsX0mySYUAUzzWUdqWI9FEqKMpFAf
 Gj3Csmj4teFqMHR7S6HNgNM/IZhZNH0eQa+w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681821; x=1729286621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZxLV9LPSThnc3VwGw32siFmYdhXdn2Qt1S+C96Ee24=;
 b=tW4faUU63Z73hbgDPfJvTLlN+MTaO4KSq3GE/xYmsvPw94Ai4+pUuFYMMt5i2R6bH4
 V8U1qdW5G5GWpafUx9Rij6zy+XIU6P4+fxnzjABbkdZZDPD/k1OujtVPFKCJw6dVR04O
 kknaKDkReHSOHFMCLNu0tt38RILAQdENN0bkHyPZ5DEfpWn4YEm7DnvMl/ir/89sTrvX
 6r04Xd07vvfN9R/TWBrhLOFWV8TMWp4PRJcdTtSwx68u1VCteDhoAKkHqNwYX/n81L5d
 dwqvZXdNW+27nqh4+pEDToHfjNskmplbNjC6I6AtJy8uKoXMlCBuxug44OAhd6TgYZMS
 7fLQ==
X-Gm-Message-State: AOJu0YxJ3LSHGSKLaZQGEwhX5FABSZZJxgU1tKcxehDuLbzk3eifbflN
 1ubdsjx8+4LMgQg0liYSH7foEMxyXTcLRu/3ktIHpnR6piZcVrGab7yuwMU8slaRPEEszdHULKF
 fdQ==
X-Google-Smtp-Source: AGHT+IGCF2eEr55+X/Xap3ZqZ181vMdEiQg5n8KEZVVVMiVyEQOhAZdKxcSGx+O3TvUpxkSB3XlHdg==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:9159:1561 with SMTP id
 e9e14a558f8ab-3a3b5f233e1mr47109715ab.2.1728681821597; 
 Fri, 11 Oct 2024 14:23:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v4 4/5] efi: Reserve some memory for initial use
Date: Fri, 11 Oct 2024 15:21:25 -0600
Message-Id: <20241011212126.747741-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011212126.747741-1-sjg@chromium.org>
References: <20241011212126.747741-1-sjg@chromium.org>
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
index d6c15e2c406..20705be14dd 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -443,6 +443,12 @@ struct global_data {
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
index 50cb2f3898b..9cc33397371 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -24,6 +24,12 @@ DECLARE_GLOBAL_DATA_PTR;
 /* Magic number identifying memory allocated from pool */
 #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
 
+/*
+ * Amount of memory to reserve for EFI before relocation. This must be a
+ * multiple of EFI_PAGE_SIZE
+ */
+#define EFI_EARLY_REGION_SIZE	SZ_256K
+
 efi_uintn_t efi_memory_map_key;
 
 struct efi_mem_list {
@@ -944,3 +950,18 @@ int efi_memory_init(void)
 
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
index e282c67335c..e36fc6a1586 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -20,5 +20,6 @@ EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
+EVT_RESERVE           reserve_efi_region              .*lib/efi_loader/efi_memory.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.34.1

