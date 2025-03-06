Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1129DC28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E599A81E18;
	Thu,  6 Mar 2025 17:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e23GM5Yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF49E81E5D; Thu,  6 Mar 2025 17:06:26 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB5E805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85add719f7aso24913639f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277182; x=1741881982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe7yAsxzpjkDRgKzWndrAc1J88UCl+LoCaUUTPaTjL8=;
 b=e23GM5YyK9hd+k9lT9cbIg5h8hsKIoyQ4NjrBM9wuWmwafPHeq/6kKappBg0FxQfG6
 PLa7oXJsQSq9qVd4f1/A5N7L26COa7cO9TvHBy4CUvSL1rhuLC7L332/LHJNx4OOXRG4
 G8DWe5OhPJ5PsPaX+zuBFbrX7LC/f1ZJlH+Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277182; x=1741881982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe7yAsxzpjkDRgKzWndrAc1J88UCl+LoCaUUTPaTjL8=;
 b=R4Sk9KpiVaSP7x+fCaFOIUfdnxYGduDUZ1/cN+NK+3JFZBp/wuUoPo9ysKbjOIdJA9
 9B9gu2BEgroEfY5y+jaBJA0GruRBZ4OFITtw0F+8g0wo8Fx98cs8TnfOkKo3ydTpRhnL
 l5qLwFlRP1hgzPM5Px0oPZiihw4aLINGTK20WgW00PFkcPujJ7f9K4U515llnCMu41gF
 dZBcc/Sqmo4DlCydQqT+idATk1SPKDRO1w3tf7PReFyq/s43MX4HtHzNHg0H+Aol9NkK
 w+F2jH0ttakkGD3yPnzh5GNmfTLSuJ8Ek8rnXATjOX2Sb3F2/p3bSiPGYbfgijROG1B5
 MoQA==
X-Gm-Message-State: AOJu0Ywv0izYCO6ZBRIFQu52Uub+cpj/oPnla6ZlTLc0gyEQGKsB9xXf
 i6Cxo3kvbNJlns1qQ/QUMAmdB6MVrD/egcnX7dIJdwKPK9eAd+ihBmtdASmZNsifpu5WAT5KDD8
 =
X-Gm-Gg: ASbGnctaqYwAnX8/d3Tg4loLiGX3x4eHNynOnnEoXkurkkaD73qPJ//NCRtFHXfOpTK
 NhRGwP8jJmLe2f03m0pNp34wiFl405F3l0Lm1DpV0JXr4amU9AtcFncVWqX74w4yBqdmBc25lbV
 YwDE9frlw03L2Fvo+FGvstxFGvu8tSeKHCAKrxz6wrwbmX0dJtSQdip4kcRFQHkJiXp8vnNoSgB
 i5P20uISkoMZkKJJKmrHtNM0LMN8WCRMswIywukjHxTQTwNmbHNI6yyvOU50B2zfYN3rltxeHEq
 TMiEVqqewao56s5cG6YtbYJ8mnTxtbsCzKewvlxW5Am9/MacQ1t/9pZHE1+qHHNkLm1WbCPdtvf
 dcN/g2w==
X-Google-Smtp-Source: AGHT+IG8vdCqlV5lzi9wIcdnogU/9je/k8yv79XUAWPQy5mVgeg+QSkx9hELMEiIYA5UMN8xjdpZRA==
X-Received: by 2002:a05:6602:c87:b0:85a:ebe4:e150 with SMTP id
 ca18e2360f4ac-85affb8956emr876930039f.10.1741277182419; 
 Thu, 06 Mar 2025 08:06:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 44/47] test: acpi: Correct memory leaks
Date: Thu,  6 Mar 2025 09:04:11 -0700
Message-ID: <20250306160428.3041057-45-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

(no changes since v3)

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

