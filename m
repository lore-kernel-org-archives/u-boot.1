Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA74CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC2289305;
	Fri, 11 Oct 2024 12:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="hYFHIb83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FDD890F7; Fri, 11 Oct 2024 12:34:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2592F890F7
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c920611a86so2471443a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642871; x=1729247671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=hYFHIb83um1pPVC8znrreXXzL2D6YvR0ufgMNPHodxy0GfPeI3DuoD98m1SLfwBMjq
 JiwnVpq7jfeHJ/UTCA7yhq57fnB2dOPLcQFm3l7OVOsPDBxomZbV9n/AAo32MDCZoRRX
 3NiJ/iO8lQsxx4/uATQCzAyyI0FHIepHfoqFESGXgZLjWmcU0CHlr0DAKuf4UTbR2ujs
 d9ALa0swSpb43pg9Stv1FO94KJX1E7AwZuw8uU1aDHacnkgvTITtTgFo/rXkA2DdlmkB
 ldNb6wh3LtYm49ArVWbvkKod9Ss+Ef2e3806ty4oFMIlfjbuPh3e2WjRLF9V1vu79oa4
 j0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642871; x=1729247671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=rfexEYTDe5qzFYxFXId/3q5C0/lySTAN9jAmOOMzyriUzd+BDKj1pDXhRxp3YLBJnh
 i2JgbhUFIMPXhMc28+Mt3IV1ANg4RqqboQPBNsn6hodupy6D8R0HvrJggqdk125Dytiq
 u/0UpydSMZ7eJwsmtJco5ipjKustqTP2CD1w6vvrLAIjqoV6G8K6zfKY43p5W5n4Kprd
 aHv6IKkVsLLD/fp9mR5GPTbR9VfBYV217ksMoC/6CAigu+JYsg/OK/L9n6E6XffCOBn1
 c1tLDmbsIQ/dzaPti6vHsKbyb8DWjPUVjtOS5TNiGoYRc1TrCMzHIs4YuCZbIyeAt5O+
 1QSw==
X-Gm-Message-State: AOJu0Yze+6zpEk/CAQz9iKavugV/G8BQswMQdwIeh+LzueJ8pKnneICb
 hDRV5rXsWSA7E7kc+pl25p98RGrzNgq7YX948RI+kg5DudMIDdVvDfhPOPzY+MPesWU7QKw01ZX
 gf2U=
X-Google-Smtp-Source: AGHT+IFdk2OIs00j5ryxE7o/Qpd2YF/kHl1gyK25JDptp90FFms7+XhNgnxMy/Ji+hePpB+kQSuAYA==
X-Received: by 2002:a17:906:cac9:b0:a99:7869:a1e3 with SMTP id
 a640c23a62f3a-a99b96ad6a9mr189593666b.40.1728642871551; 
 Fri, 11 Oct 2024 03:34:31 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:31 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 04/37] acpi: Fix typo
Date: Fri, 11 Oct 2024 12:22:45 +0200
Message-ID: <20241011102419.12523-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

