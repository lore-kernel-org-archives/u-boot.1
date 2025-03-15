Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AD1C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE6E980ECC;
	Sat, 15 Mar 2025 15:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmwVGiEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0800A80756; Sat, 15 Mar 2025 15:28:46 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A4281F3A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so3404445e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048923; x=1742653723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVO6GhuXDNJ9tbJDJgRgsARj0G2ErxzvhtMxJE4R+i8=;
 b=EmwVGiEmypYEcFgLWLnxnV4m+BvsiAy+CDt0KjPyVgQPiGtHnBVLMT2o+ghQI5PqHH
 j1KBJ0u6yN2k/pI18XSsTiyTxs1ewPGjyPGn/cA9YJ47TUMfWlWsNWMropJhptxvE3Ko
 PVK6oBxtqFMvSBvcAhF05Ujo4+Uas74hwBR2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048923; x=1742653723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVO6GhuXDNJ9tbJDJgRgsARj0G2ErxzvhtMxJE4R+i8=;
 b=koT9zHJ5iUb2Usqs2VJDiN4R2ewpmbACCXcVEPks2l/s5uL5KomPx99IpKtU135/ER
 hoQEy6nG7BRoxTOtsnXSS40Bnn4crNepS4CtT7oVTM/VmneoyyHpc9kttTrxDmBnJfYf
 CGdzZGKD/J9Jiiv4M9eBYkMGBREOXm6mqzEIyoDuhzNp6fjTAUaj/4jSJ35Qy1/uiBUB
 s/IuRf7yjimi71J7JpQim5F/U6Kh8jI6TLOhBSqxXNeujIfOSKt6+VRSA6sbQYGZJcw5
 p5CYo44krXpDgMYwVARZE5g7+IepSmwItNK3oTLMPmgTAzQ4HQz3gohRqb8xCVH8zwd+
 AlIw==
X-Gm-Message-State: AOJu0YzaOE12asAh86sn8o2TAPp1AMoGdhxD3lYWfWz3MSokqskI5iI1
 LiGIpAg1qOxLTVuAEJon0LtTzjkuYyHfXYlSmG6hZW6Ba9+FrroBBoilamQgNa1qGNWenQb9b/h
 /lA==
X-Gm-Gg: ASbGnctDOWKvS5ab8YBBK5EnJ1wSqYH9z74F1nw3+wryiTG7bLNp27pT/Od6+NgN8Ai
 +bmwlsYmvduSdwPPG3MF9l8xq1I/BWif6/dyXSJxlXtvgulUcZ+EfINprGTfW0SkYAD3vL26wY/
 UefTqMg6m0ICaxGqDXs+T7FGBIJXnvT1XuTfDT1ejXRzvYLE69hGhHlqB4rb20vKWpJm3lf8lDK
 BdNuA5AbKLkqZFNhgwLC0nT6q61N69n0rDy+elQnb9gVGntp5DyqVcE2t3C9ka9E8ad1Ng3Udd6
 Qg0QbUE5OZrxU08zCuOAl8EnFc9Pto3p7hid6P1rwA==
X-Google-Smtp-Source: AGHT+IGzD9rKeZcluerb/N/IUA/PSMpb6xUPzuwwbHU1QVcAyIBwyb+y9VziZ0v1UZ6EW/ExDNNksQ==
X-Received: by 2002:a05:600c:3b87:b0:43b:ca8c:fca3 with SMTP id
 5b1f17b1804b1-43d1f235e79mr80542055e9.11.1742048922732; 
 Sat, 15 Mar 2025 07:28:42 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 42/46] sandbox: acpi: Correct mapping in FADT
Date: Sat, 15 Mar 2025 14:26:02 +0000
Message-ID: <20250315142643.2600605-43-sjg@chromium.org>
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

The values in the FADT are pointers so should not go through sandbox's
normal addr<->pointer mapping. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Split out the command change into a separate patch

Changes in v3:
- Add new patch to correct mapping in FADT

 lib/acpi/acpi_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 150f75027a5..3805b61159e 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -255,8 +255,8 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header->creator_revision = 1;
 	fadt->minor_revision = 2;
 
-	fadt->x_firmware_ctrl = map_to_sysmem(ctx->facs);
-	fadt->x_dsdt = map_to_sysmem(ctx->dsdt);
+	fadt->x_firmware_ctrl = nomap_to_sysmem(ctx->facs);
+	fadt->x_dsdt = nomap_to_sysmem(ctx->dsdt);
 
 	if (fadt->x_firmware_ctrl < 0x100000000ULL)
 		fadt->firmware_ctrl = fadt->x_firmware_ctrl;
-- 
2.43.0

