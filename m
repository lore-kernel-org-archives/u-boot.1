Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F90CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC9A892B8;
	Wed, 23 Oct 2024 15:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gzTcIb5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEFE88E0A; Wed, 23 Oct 2024 15:28:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD5D892AA
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so642264f8f.1
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690117; x=1730294917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=gzTcIb5HmVejCyy9H9cHETExwLUXWQvzsCSHOxsxQCtXi9bsN6Ms3OzhaiQ8cyKZy2
 2eT1UmTd5ru0CaunEt+f9ix7w2521ggvOjBqW7UGLZCVToLc9rVi0FmhZPigNil477l3
 I0sjMwYsriTpcLUhNkeHJfVSuCw2pV5ehDWkNJMXENIUR2x69nrdG9EGJuQzalVvrsBr
 TEHk5APJEdAC3xDn6Xey4V7QuNGY9KZkJNJkIOnHmdXAgZw6fwIPec6BH0fi+ZUGNtCH
 iXVKZ3nnr5AjZagnXdmXzxasfxQN4PQPX/VbNmvxlvY0IIgli59uVaOqDxqSEg0NjmrD
 omkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690117; x=1730294917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rx79IlqaDN610Drjv1umSL9YAKOmzuPC7ZlaY5AwTmw=;
 b=jiKAHKui0lF/mUJ33hLFH8n7+a3jIH90U1CvkUTRafyKl77kbeS6tKWiBryx67eFun
 P3GZHmHch+Ola2KoXTAP561abcNyfZbq6jY7ZxpaCG5avXAfZQAhcDrKXisKvgtJ+9ph
 iN78XjtZekMhOqjhn++efnHojWP6rPNLUslrJr9ijKu9A67EpP6lSXqdn0HJl06mKyq7
 KJoyxT2IU+1bpilIK0KnIm6kSIHmTZTGnT0a1L3DlPsyb99qHq6w08wljYk8rn49sMhU
 STyraJoxzLyyxm/3ptTxmrtLItss2VsWnTeaoF7sGHDFCxM/ZJWxaOW8TTYiSQt0da9f
 w3bw==
X-Gm-Message-State: AOJu0YxVSYeVizz05rKWJ9qlh1kkGZmSjI1J8Urh2/feGaDTeNLTeaNO
 vkQPie3acDpSAj0wZhZHNgkCET3XYB+kchhARQsanSe8VDkoU3aO/vX51KMKDc6FVG58sTU9O7r
 E
X-Google-Smtp-Source: AGHT+IFHa9+1CdQnzojYx70q6ooqBNfRuDipXjf0OXJghbO7HUKaN4cDSZ+hMUSyOddtD0jJh5k4hg==
X-Received: by 2002:adf:fe03:0:b0:37d:3f81:153f with SMTP id
 ffacd0b85a97d-37efc5f0b29mr1677197f8f.17.1729690117189; 
 Wed, 23 Oct 2024 06:28:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 04/37] acpi: Fix typo
Date: Wed, 23 Oct 2024 15:19:47 +0200
Message-ID: <20241023132116.970117-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

