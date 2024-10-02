Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E86ECF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD0788F8A;
	Wed,  2 Oct 2024 11:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="V3vRgTWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791A088F9B; Wed,  2 Oct 2024 11:51:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6993E88F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so62686015e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862694; x=1728467494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=V3vRgTWq6n6UeDtc/pd30Gp6fdeCLUxmp6MaF9SkuLmBwP+YRd3JBxsExaeSrkz/ke
 skaUlNiBukeHm/GSnjXpTQKxU7a/yYCKxH8wafZR4d77YWSFaNDIDPL117CJ4I6x44nY
 8xeSO/3SJqAIM5ciAkUOndWmXbEL3NUilxiyKEC+TfXs9jkyyXfQBhYDuHITrpQYYcdG
 WiKrBctFTjGD7KeaK9WaQYTCxGxJl2XBTF7TpQtJ+ppCAbdA+FKrV0TIlidOSDbtn3Ql
 pKWuPDG79ibDmZBfSHFZDsVliZfmodEuhoBnH8kNGRIq2uspzd0K6O+zFkVnQJqiqeDp
 XWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862694; x=1728467494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=hLwlbJk7bhEGSHeYwlfl1axK+bvNNhhtGlcx9XAYVx1G914YhbZXBB0Ii2clN24nMp
 7QBUhUsguUjKL7dTONw88YrQVFuy3mGKUv3j1LbbGmhWIaFmGsYscppP7elhqo0wOarS
 nc0fEXxNE4GuAq957vQOBD5ArXG+6oOS+J9SdY//3jZCwZBajo45LW6Po82O7khaR/Y/
 lj/Fd+5LPrfi361ICxXlniciVY9eSHdSIF3kZAKRbhXUsmerYM01tdzLyFIT2JxbkgP8
 NdmZjrKCgkKY5rVhZ2AHF6lBQY8lnqWCSHljudMLKgq1W4VWJXLS+S1pGPdh2MIG3yjw
 iQOQ==
X-Gm-Message-State: AOJu0Yw8fEIQtbQOM92QLb6t/ipTpdQdK5voEpEeI3ZiVzgjkCbTNeg7
 792MgZgI+ceLYI0j45/AMiu9ak1lH5/1j8z8GizEuTmbZhZcyB8hH91QZlgosFVwiYfG/X9J56J
 Y
X-Google-Smtp-Source: AGHT+IFIVy+Ok10SBfN1EVQpcsUAtlSGreQMmTOA5db6lszpDq+mAnIlfOGx/OnnF+7yZxqXeNP2WQ==
X-Received: by 2002:a5d:64e8:0:b0:37c:d275:9ede with SMTP id
 ffacd0b85a97d-37cfb9cfbedmr1898878f8f.26.1727862693818; 
 Wed, 02 Oct 2024 02:51:33 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:33 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 04/37] acpi: Fix typo
Date: Wed,  2 Oct 2024 11:46:55 +0200
Message-ID: <20241002094832.24933-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Rename ACPI tables MADR to MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index c356df72ba..a1bdab7305 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -386,20 +386,20 @@ struct __packed acpi_madt_lapic_nmi {
 	u8 lint;		/* Local APIC LINT# */
 };
 
-/* flags for acpi_madr_gicc flags word */
+/* flags for acpi_madt_gicc flags word */
 enum {
-	ACPI_MADRF_ENABLED	= BIT(0),
-	ACPI_MADRF_PERF		= BIT(1),
-	ACPI_MADRF_VGIC		= BIT(2),
+	ACPI_MADTF_ENABLED	= BIT(0),
+	ACPI_MADTF_PERF		= BIT(1),
+	ACPI_MADTF_VGIC		= BIT(2),
 };
 
 /**
- * struct __packed acpi_madr_gicc - GIC CPU interface (type 0xb)
+ * struct __packed acpi_madt_gicc - GIC CPU interface (type 0xb)
  *
  * This holds information about the Generic Interrupt Controller (GIC) CPU
  * interface. See ACPI Spec v6.3 section 5.2.12.14
  */
-struct acpi_madr_gicc {
+struct acpi_madt_gicc {
 	u8 type;
 	u8 length;
 	u16 reserved;
@@ -421,12 +421,12 @@ struct acpi_madr_gicc {
 } __packed;
 
 /**
- * struct __packed acpi_madr_gicc - GIC distributor (type 0xc)
+ * struct __packed acpi_madt_gicc - GIC distributor (type 0xc)
  *
  * This holds information about the Generic Interrupt Controller (GIC)
  * Distributor interface. See ACPI Spec v6.3 section 5.2.12.15
  */
-struct acpi_madr_gicd {
+struct acpi_madt_gicd {
 	u8 type;
 	u8 length;
 	u16 reserved;
-- 
2.46.2

