Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31AFD2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9569888DA0;
	Wed, 16 Oct 2024 08:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="BwUq4dN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0A088D63; Wed, 16 Oct 2024 08:12:42 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CE888A4C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso258382266b.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059160; x=1729663960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=BwUq4dN4dhYZ5JRRDny22ZRHI2ygkfEUpajxsbMoL7GKWr9Ksd+vx/2E480cyxJBSN
 +FYKpmmbeC077qfLvXWb0KX2eqf9pHz/On3POeoxOdY1nwgB6KbcFJ9VM/wq7CrjQeVs
 s/mMGIALFn3WqlVAmET6rko6Tjduskk1S/zgqu6xC/4y/KN2jwBwhCaGCzBMYKbgD2hC
 Eur6Kxe4HcPg2Gec02OQXjpHrfvlh1v3D05zFvbzH1v7OuyEEhXmcoHztmGyYsRUbaL8
 83CbYe4kNa6GbndNNRF1/tkoOMUwxYnmtlSi8oFi4OGt1LJEPV/SaNZAkFkEAMAk5qXN
 gEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059160; x=1729663960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=wxX1Os8PorSTzLtJGj4xFVyC2plKZc8kyZh84//B+vmBSiKDvnOpGaEnOY+mS2cbrz
 ndkoxmxecQOierdswZzA+KPlqzfNqgRuCCF59YvB0wcVGggv1xuXUhWAS9f9BUV4IBv1
 Wkz1ht7bavTdbpAnte/AyOuGQErRRkiBg9GkPZsALLEF8FhidbOkx6MK1bHMHehLtAKg
 XY7V0CNo5dGgrTI70e8vFSWY5UJwF/NBakBlSYMIu2Y9h9bX2L7LVJZA2S4wpUPtqiKJ
 5k+AbGG5obujLb61zLbcJj/BIUr/QNaTnNFfr7DmrryyfUNgAy+iRTCtaplN9HlFeR9/
 +HQw==
X-Gm-Message-State: AOJu0YzkSFwFNN8Pe1XSr3kMpMADMaNvDMXqVfzaYpky+VDIDsp4umum
 p4WQMcnZ4R1izFmoGHPj1GIqEsexEf3GJCae3ArwteVa4JgKlmx0V1PsKV1vXflw/tCS+OXh7RK
 f
X-Google-Smtp-Source: AGHT+IGxlExnCyOaqKMvkQQNgmCfonUx/XFXadJbiKQNvqMur3NNxpz/3C18YlU6Wr+9DGe2x0HgFw==
X-Received: by 2002:a17:907:7d92:b0:a99:d217:6db7 with SMTP id
 a640c23a62f3a-a99e3b211a4mr1453445066b.6.1729059159819; 
 Tue, 15 Oct 2024 23:12:39 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:12:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 04/37] acpi: Fix typo
Date: Wed, 16 Oct 2024 08:03:50 +0200
Message-ID: <20241016060523.888804-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

