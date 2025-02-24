Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FDCC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF388141A;
	Tue, 25 Feb 2025 00:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="murMTIre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A1281417; Tue, 25 Feb 2025 00:08:28 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DF380F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so15795195ab.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438505; x=1741043305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pUdcbInZWADVRM8WDQeM+X0Yt7SpBo3vtpfXTe4ENo=;
 b=murMTIrexJX1YRl1M2Ym8PROwkPBk1aO2e8+e2JDroJRrprLU+GGEgFSoW8BGGaWDh
 MjeZGX7FzfQkv4asWC4c+8si/iI+c866k6hAOkWGnGub5e9F3HYVAfQ7SjACuHw5cQaY
 5EvSN/MQVzRsBPkzZN7lBwE27hKDmAE747UUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438505; x=1741043305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pUdcbInZWADVRM8WDQeM+X0Yt7SpBo3vtpfXTe4ENo=;
 b=LkPrl2g+MtyB+Nd59JaUZxw0eMtL7r5Wcg4wH7NYPEQbB1e/NXkJNxBND1Q40CDuIN
 fUtvjNEIbgHJZnl/N7TEIe5sZwtcuSAPKUfpgNZhdWVrOxZzzjryjg1Fr03DxPOkZp7f
 adWJTiJDftkuPK8J9jbCWUm0UDfgSOYQzOLhDghqVWDOCiC102M6HM9i/aj9Q+bpfcxX
 YTpqXhAP8K2C+aJuyXAs6q0bGqYBergEu77chS0MvUoPHNFqyUL92I2CaHpjioP8SD4j
 NuchgTVF760FFYxZkv2Y6rgVsV3YbBylFC/8p96KlBdH/lcEyxn3ylolC48/P8ud+mNJ
 wDyg==
X-Gm-Message-State: AOJu0Yx9TsnmyZvLsFHUyp7gT3TSMyjb9g/30Ki4xJmiPYMlKS4LLdXb
 /5N/RD68RBdcE11bfKiEbzBfV+/y6MIl6yqNUfucMs4rqloU7USLLuNk61Q9ohNtE63nm7WW9Do
 =
X-Gm-Gg: ASbGncsBbtxXtqc/EzuNh+zUpWscYb2BpRkmsYbLgbU2xCqAYLHVpzZ0ipNS9xd2qBj
 ki8rRek/IEaiEcZIJVqR2btQFcmO7awF9HxV6MCWLHVB8lKHH7XNqT+EbC0EisxdxVZKgP7nCcJ
 8VvXZnVDl1+Y7hffB5D3Rz+nZrtugWr2QZB1zFJ19iDUCj88kiEt+wYlN672VBjlpJ2r4wwv+Dw
 F6y0tkhuE9OypTiQn6ialb+aIXna5O7lr/JeyCq3e0/KcdtWUBk5rStWIEpMVprT/VZm9dHtAD6
 C93dqbMOIZTcPbrxJjRvua48RJ0356YET7IJHiFHN5oYNF/EbciFr+FUcdrh4qg=
X-Google-Smtp-Source: AGHT+IHGSwXlM++sGYV+WjtmfJhQitruFPgMflk9Bf9rB0aV7bh2Kp0n9I5vTjgPQ/y6cMYb4cDtoA==
X-Received: by 2002:a05:6e02:b2a:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3d2fc0ea5camr16166975ab.12.1740438504739; 
 Mon, 24 Feb 2025 15:08:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 41/44] test: acpi: Correct memory leaks
Date: Mon, 24 Feb 2025 16:06:30 -0700
Message-ID: <20250224230640.2665206-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Free the memory used in tests to avoid a leak. Also unmap the addresses
for sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to correct memory leaks in the ACPI test

 test/dm/acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 39a26bbb492..f98f9d1e74b 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -309,6 +309,8 @@ static int dm_test_acpi_write_tables(struct unit_test_state *uts)
 	}
 	ut_asserteq(0, ctx.rsdt->entry[3]);
 	ut_asserteq(0, ctx.xsdt->entry[3]);
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -386,6 +388,8 @@ static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
 
 	ut_asserteq(nomap_to_sysmem(rsdt), rsdp->rsdt_address);
 	ut_asserteq(nomap_to_sysmem(xsdt), rsdp->xsdt_address);
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -428,6 +432,8 @@ static int dm_test_acpi_cmd_list(struct unit_test_state *uts)
 	ut_assert_nextline("DMAR  %16lx  %5zx  v01 U-BOOT U-BOOTBL %x INTL 0",
 			   addr, sizeof(struct acpi_dmar), OEM_REVISION);
 	ut_assert_console_end();
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -458,6 +464,8 @@ static int dm_test_acpi_cmd_dump(struct unit_test_state *uts)
 	ut_assert_nextline("DMAR @ %16lx", addr);
 	ut_assert_nextlines_are_dump(0x30);
 	ut_assert_console_end();
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -642,6 +650,8 @@ static int dm_test_acpi_cmd_items(struct unit_test_state *uts)
 	ut_assert_nextlines_are_dump(2);
 	ut_assert_nextline("%s", "");
 	ut_assert_console_end();
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -679,6 +689,8 @@ static int dm_test_acpi_cmd_set(struct unit_test_state *uts)
 	ut_asserteq(addr, gd_acpi_start());
 
 	ut_assert_console_end();
+	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -774,6 +786,7 @@ static int dm_test_acpi_find_table(struct unit_test_state *uts)
 
 	/* Restore previous ACPI tables */
 	gd_set_acpi_start(acpi_start);
+	unmap_sysmem(buf);
 	free(buf);
 
 	return 0;
-- 
2.43.0

