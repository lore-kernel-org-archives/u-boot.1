Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B645D1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3F089011;
	Mon, 14 Oct 2024 15:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="AAieTaIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FDA890B3; Mon, 14 Oct 2024 15:12:18 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593EF89048
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so2325683f8f.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911531; x=1729516331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=AAieTaIuWRRe2WLoiL2AF1ob6Cci0bGfV9vO4K1QFVhadl0DdEOsy/r5OVQPfGjJsf
 NB9I1KhmdRxF6k8THAZEZuZ/IJR3avhvL4KuC9j+Mzif6iXbMYK3FeiDJmmV3OLQ8PTW
 3AlZRXxOCwNJB6hAtdcpISokf93Pb83ld/+SwxNaNifwyb5HXXKcDJkepPIssiJ3rURC
 egNPuGoIEq1oxouO9ZmZ9eqdnJ4Z2/wuT0TLjEEOYrIe2Cnfpz03pbtbkCUzfm7vaM6w
 HU/aQ0Yo08z2M5cOAmjWe+LCvNg3c0RqMxCAcrCuCJV+F6e8c9jNtMfPzFH94ZcAfA6h
 XaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911531; x=1729516331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=Ym5JSydiy+8gkbKxamRyzydTOUi0CCgH0DJjLygxEdTK6U0YtRhUTURwku/Wj4WDxc
 AwZiq16nh0wbZnZLUWL4gHxTLoW6oQL/OD4/xbiPtM0mKhycSnWhhaaHSeLbxctY5htt
 9pGAR1KRvGz/CiHp8iGIMibxy9G3ot1fHuf18dRVcKz8RYeiPdQD1kDlNwAJq+dOJUKO
 fwepG49KetpO3E3xrHbTJxqmitePcaHbgfb6uOL0lTM7BQO9BqUr6LfL6lF0nFDoZ+lA
 xoraDuEnmF871Tpf/ULDRAyjDrMiJn69qMqpxI6tHJL0246brySuTK0YQSiQ7UNNpeRr
 +JJQ==
X-Gm-Message-State: AOJu0YwvBZSfnjqzVH2hhNBQByGwvrPrhS0SW/yi6U55HhnD17tTaEcV
 R8sgox6gzBBdxD4oEXcZGSGx5Qg7Z30CNcafGmsFYSE+UD+/GUr0TPiL5SOEsWJ9wtuAyY0cXV8
 u
X-Google-Smtp-Source: AGHT+IH2EiRnkUgYT32T/dMo+NYnxF/8nSK6ctotBBtof2XC5G7I9WWr7V4k+wMio5WP/sMstKam9Q==
X-Received: by 2002:adf:a11a:0:b0:37d:47b3:7b82 with SMTP id
 ffacd0b85a97d-37d5530a1a0mr6759337f8f.57.1728911531185; 
 Mon, 14 Oct 2024 06:12:11 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 04/37] acpi: Fix typo
Date: Mon, 14 Oct 2024 15:10:20 +0200
Message-ID: <20241014131152.267405-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

