Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85491C36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 23:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E83D81CFD;
	Sat, 22 Mar 2025 00:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="K/VBfYUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B1581B4B; Sat, 22 Mar 2025 00:21:56 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4088581D5A
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 00:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54BA53FCE9
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742599305;
 bh=v1D772RZ6j+Lr4yTtT8CrMcj8u7WxN5VJlKU94c4sCk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=K/VBfYUrpXBetB/hSgzQ9QrJR8dFhPR07aSAhpPGdlGQjuV5iClU5BlPGAqxp1nhi
 U0SibtJwRUfBlczGco9N6o7xcckhQajGwB5lQ9hNDVGtZPcS95REQUbnJH0StfsslV
 eShSKLjoSldE5/kRHHcRfFyH1ECP0usrB2je9jLAMroJ/hNmx2ZLkQdr7mfbslhyQ/
 CqQLtuMlhtk5ERtHO5bt8BBoXHBxuRj5IabaW82msjgDKpCZS5IFWwWNlqjeKJfP+A
 xnAELt5UGEtBkczVsWqgcqUKqswYNQr1ylHMQL7XFw+x+M5iCC4Xe/RwkcEPDCXfWf
 DcV0Vo/4H0RDw==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac2db121f95so201633266b.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 16:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742599303; x=1743204103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1D772RZ6j+Lr4yTtT8CrMcj8u7WxN5VJlKU94c4sCk=;
 b=WZMH3WGFkbnQPaCuhO+by8a4iXFwzp3Hbp4rw14w5XtN1xMA62OLclXJ9ppn7qYQ9W
 /m3ChQoK+wvRPRgTQEWV8fP8rAa5a2TKSvpTocdCGzAdTQv/ejvzmh2odD9HqlNERQr6
 VIIACqHLbLpKZHek3Nn8V1InfXNEtATCHDgfV/ZW6xdbkvePbWmaIgiHeQRlNv5moIxg
 /XANFGAkec5U4NgI4/KtPFFlBCsCso6vxJ5Guj3USw7rDFDWKcum1UbbCFNnmMiK51uJ
 RmCgyLV49oxB9yFgJLwky6uLP5Fx0Xus3jv5iaNt8yDW7+WuCK7QFptTBXv4F8yIFgck
 zhMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2NUZs+Ie4ppyv7NP+lmZJcowUWtYhrjfjMpiR1iWBvjZ03mY494OkfJwiWUIBwQJ9zpT2H9E=@lists.denx.de
X-Gm-Message-State: AOJu0YxyTvur0LaY3dAxMRKadj35dNNfHdmgc2WMiRhaSDmVpJVMaWni
 LYgaaldt6P+QlXJVBSVYvm6gHZbkim0mcS0RhOV20V9H7RKIxespn6I/gO6sfoN53UiY3ssspHT
 tzssogG4WQHfVLV9bNlLLw98Bi2XL9SNklRLV9n5Gk4wQE7SfIFXSxnkwZcqq/cFE8UY=
X-Gm-Gg: ASbGncuyMRqMCljS9qa+1jnvpBu/O+dcT0E5VFEm9tvmIw8wnZ4/G43+3fSo1F4D3cq
 GlgJSDr5WAMae7O2YtzC/6dnZMTy0sJZeVykuoGz1lnOovNvux7kY5n+0vi7J3Q9NC+Nk/xE0PD
 g9hAoRfX8UcR0I2G40ShhINs1o6yHqEzs7UFrw7J4r1jBi9PwrjE5P6cIEBNHxvL39rBaZLkCLR
 d19ON46b6kG4D0yAgDAyejszApTcWs5fp2y07nx1TRR81ndrFn4ksp1+m4Aow1t1KqRjY2zWqyF
 UG4FEzV4eyF1VL2fXU5407USLSfyxFMTBLJEqVxpxcJhrD4+LbRmYDTcVK+PNF/Hru7PpaCGGKs
 J4762th+A7Ed8ORr4NQ==
X-Received: by 2002:a17:907:6d28:b0:ac1:fa31:78cf with SMTP id
 a640c23a62f3a-ac3f250323emr449764066b.35.1742599302831; 
 Fri, 21 Mar 2025 16:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzyzYPy8KlLE3d+fSNJdYtV2YXWiV4CsbEYOsFJi98lC8MJcWBN/fQkzXZ33EFECcW70x0BA==
X-Received: by 2002:a17:907:6d28:b0:ac1:fa31:78cf with SMTP id
 a640c23a62f3a-ac3f250323emr449761866b.35.1742599302427; 
 Fri, 21 Mar 2025 16:21:42 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd3aa21sm231673866b.158.2025.03.21.16.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 16:21:40 -0700 (PDT)
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
Subject: [PATCH 5/5] arm: simplify updating ACPI table header checksum
Date: Sat, 22 Mar 2025 00:21:20 +0100
Message-ID: <20250321232121.251800-6-heinrich.schuchardt@canonical.com>
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

Use acpi_update_checksum() to update table header.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/mach-bcm283x/bcm2711_acpi.c | 4 ++--
 board/raspberrypi/rpi/rpi.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
index 79b283353cf..58f8ee232b9 100644
--- a/arch/arm/mach-bcm283x/bcm2711_acpi.c
+++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
@@ -81,7 +81,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
 	}
 
 	header->length = ctx->current - ctx->tab_start;
-	header->checksum = table_compute_checksum(header, header->length);
+	acpi_update_checksum(header);
 
 	acpi_inc(ctx, header->length);
 	acpi_add_table(ctx, header);
@@ -116,7 +116,7 @@ static int rpi_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	gtdt->el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
 	gtdt->cnt_read_base = 0xffffffffffffffff;
 
-	header->checksum = table_compute_checksum(header, header->length);
+	acpi_update_checksum(header);
 
 	acpi_add_table(ctx, gtdt);
 
diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 70d3c35499b..6ecd3eb120f 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -791,7 +791,7 @@ static int rpi_acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *e
 
 	/* (Re)calculate length and checksum */
 	ssdt->length = ctx->current - (void *)ssdt;
-	ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
+	acpi_update_checksum(ssdt);
 	log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
 
 	/* Drop the table if it is empty */
-- 
2.48.1

