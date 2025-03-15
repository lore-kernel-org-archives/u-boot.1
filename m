Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57565C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0858192A;
	Sat, 15 Mar 2025 15:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VNi9oK3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBFC81FBC; Sat, 15 Mar 2025 15:28:50 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0048192A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso7474465e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048927; x=1742653727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe7yAsxzpjkDRgKzWndrAc1J88UCl+LoCaUUTPaTjL8=;
 b=VNi9oK3dK4PaS1I71y738bKbfiuy4NlGSl8N+BaHarfXvIlBhndFl5wm95+MRibqvc
 0P4C8N4NWSaZhoaX0oxbgZChnykp8sCD2xazPOpKQdZaLSJji8vfhEFOq0hJTTh5eW4X
 enxASLP8kHf1fpvUENG9+5jJeERmwPqp7DfZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048927; x=1742653727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe7yAsxzpjkDRgKzWndrAc1J88UCl+LoCaUUTPaTjL8=;
 b=k+ksY+8cpR6smFdkMtzgVA/lZirMEFkNcrNAEw4xIIcgraURVfY8xp8y2+HKzT/wfK
 hPUyr2Ru/qpwyEKodc5Ndi6iBPL5SJMPiu1YDv9vp3tZudH8Muq258Gx6QpoCAEeYS/f
 Jt+Q9aN3MK1sI9wnsvDV0rRMS1rVxWcVcs9ipSyf8oTEwpgFT5+JLMQPcGbaVtlar5wl
 vQAkUqyMwnfZQSNtetWTA9VsQP1Ehk9gYzd6nC00RR9Bb6HoZy5g9Um++2q6I3uc4+OJ
 Xzwmda93TFN7mfEOXfYnoe62i8kdk4BQ8D+sAhmv/gh6rONPN0yTAsbeEpaO/0Xi16Q+
 WTKQ==
X-Gm-Message-State: AOJu0YxGf4eDBtsKyCRVOv+hY/Qciq8617OkPxjPDGiQ/Jpnspz3Im9q
 TaFBHbfzks9isJgHdEFGpaJ4utk5fHPXcR2c7GbujkI6OXf41GdNv/41q9HoRp6ACCamjxKOKR4
 uJw==
X-Gm-Gg: ASbGncunkG58RDlXxeyef2VhhmofOnfDbiD4Slo+9NIs5OH/n1Eyu++2aUdQkBqrUKD
 znshZ7nlBjAPWyYJUteiRWD8RNxk1YXW48VFpS6qDxUVcRpIDUcvAk/O1XqNce23OMadE2D5HC8
 hHHKMoRUfIHkgYaAf3/nbmkJRi+ljqoBwlY1+PW9SlMZdIDrxpFvmAjTUpHtBJhEVFYHSI1D9oX
 MjAAf3w0QLeMV9QJLnzckymz4Qor7+1cwZJz3Xt3cUUV8P/TPH9bjbRO+iLQdssoEYjJlNRdP1y
 9HCc16bp4t2mNujJ3/KOKSkDlcjXoUg7iPMBWasSUQ==
X-Google-Smtp-Source: AGHT+IFVkfKEz0NKmkuFQclC+zb+xLub1LmsL2rWyEKeQ0gBSLZuB9M8aH38wH2k5N4oMAzmFhPIng==
X-Received: by 2002:a05:600c:3b04:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d258068cfmr26693945e9.8.1742048927606; 
 Sat, 15 Mar 2025 07:28:47 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 44/46] test: acpi: Correct memory leaks
Date: Sat, 15 Mar 2025 14:26:04 +0000
Message-ID: <20250315142643.2600605-45-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

