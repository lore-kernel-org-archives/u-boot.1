Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7DCC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA54811DF;
	Tue, 25 Feb 2025 00:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nw3cx1p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC86881424; Tue, 25 Feb 2025 00:08:23 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9F880F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-855a8c1ffe9so147590039f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438500; x=1741043300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bw5qgqKg/u9S8XQ84nvlg8q2leT5NHEkyCUn+DyNDls=;
 b=nw3cx1p8w4vH8ZWECV0KAfqUT8mArhRfIfj024PRiULJWCrhNRgBZQVX885IUPxNnF
 Z1AsG3JXPclNJJ/02sQBzS5dEgvU6GICQc4iykqzJWHrGsg9cNcYBkWwFUoyOV7M6/Zj
 wROhSgB1wNQaFRRoUf9Dow3yl4JJNWs/9zG0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438500; x=1741043300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw5qgqKg/u9S8XQ84nvlg8q2leT5NHEkyCUn+DyNDls=;
 b=IrIhOWhVa75UwtGNt4xtpA7tFWO7trLs89oDO/4hdA2TyJ6gokAvcAFTEJa96smIa5
 T87tmt1uMY6PiF2q4bUhkiG3D7RoD8N2nNKJmSNB6txf79P3omkyysLfYJQyVBnWr+/G
 ShBnA5teFpZekV09tw0oM6sgT84CU6cPRLXkWxnJY9iTKmjcalu4u/IMyVOdHkeF0e2q
 aKJ1Js4RvOO4fNCqpwHvr5ZKXK7m1Sd4N1G1KWE9JzV3CI4nBj4/M5T3dJjUui7TWsih
 l5JG5AJtOq7KLGtE1GwOy1ZtFkwZ4jBFiX9u160bhHyjV/FBCeQC64UeDb7NEaPQ2m/P
 019Q==
X-Gm-Message-State: AOJu0YyKiPbLifSVfI7slkCm7cwerUoUE6LoWmped7uin8JHqzNFU//g
 OSSF8J3Vz+ds4hntS4fuWOGaIf4DUXkCE2/AyiOzpgdPw98Y8/2FweMBu6ClEeM30nKPCD3teJg
 =
X-Gm-Gg: ASbGncvHcS1bzFv/8ZF70PM/gor3UOsLpZqF8GnLSbdVv8NTS0S9nuX7l6o+rEaOnRW
 InuBIPHfNRmuYgNuvnvD8riRlQpVWXOL3HlD2lLLmEaynp0hZyGD7U62hTi3R183/ECrV1/ANq7
 9IGYrkZZmfOXIExBwOLfL3nyUmSAk5Dr8VOJvEvA0a9YRmH6TotQRZWiw1jlvl7vYIbfCF6y4c7
 wy4knQG4NMGS0C+AQRfXhLHaLcecJnwLR3AlxqT2pCTTGmh92t36RwsglTkXuYPoZFldBszPxfF
 mCGRawZl6JdCnMB3eNSnMr2ZmFV3i8dFzbLqa3VGhiIkJqqlpV4+kvpzxypp9Ew=
X-Google-Smtp-Source: AGHT+IE9iMqniszyxRaFmqDC6Twc3Xg9XDS84swUy3DlW7GkAbBG5nHizVPGTbd3NGG/pd95T7d0Jg==
X-Received: by 2002:a05:6e02:b2a:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3d2fc0ea5camr16164075ab.12.1740438499761; 
 Mon, 24 Feb 2025 15:08:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 39/44] sandbox: acpi: Correct mapping in FADT
Date: Mon, 24 Feb 2025 16:06:28 -0700
Message-ID: <20250224230640.2665206-40-sjg@chromium.org>
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

The values in the FADT are pointers so should not go through sandbox's
normal addr<->pointer mapping. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to correct mapping in FADT

 cmd/acpi.c            | 2 +-
 lib/acpi/acpi_table.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/acpi.c b/cmd/acpi.c
index 094d9d4e858..2273176f106 100644
--- a/cmd/acpi.c
+++ b/cmd/acpi.c
@@ -58,7 +58,7 @@ static void list_fadt(struct acpi_fadt *fadt)
 		dump_hdr(nomap_sysmem(fadt->x_dsdt, 0));
 	else if (fadt->dsdt)
 		dump_hdr(nomap_sysmem(fadt->dsdt, 0));
-	if (!IS_ENABLED(CONFIG_X86) &&
+	if (!IS_ENABLED(CONFIG_X86) && !IS_ENABLED(CONFIG_SANDBOX) &&
 	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
 		log_err("FADT not ACPI-hardware-reduced-compliant\n");
 	if (fadt->header.revision >= 3 && fadt->x_firmware_ctrl)
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

