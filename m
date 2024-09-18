Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E5CDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F29088DDA;
	Wed, 18 Sep 2024 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Jx+nfjVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F77D88D9F; Wed, 18 Sep 2024 17:22:08 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A61B88CCA
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso8642769e87.2
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672926; x=1727277726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty3pISRwyVUFKzN6AV+o1jhF3tqF577Jx2Jy943PdvE=;
 b=Jx+nfjVP7+Vh58occwxOFca+JlYAjBy89lZf8cE1o1soORUOxKh/SvFwfIYj6HKBT6
 L1stTZMt+AHvumdKDDBj+XVEw9WXov5+0n92bPJqTAxWuPUQ7P5fwyKFzUbI203yh+p7
 fpB5hMn1z/cgXcsYowbX42CKHMUut57C3dvVg44UwpYUnRseSfS2CmW2QDGC6vwP7had
 kG/TDlTtPJAKZRUCCjNTbCUC+4eC+TKeRV6TCgpp4g7q/axG1kwe8Qj8SKa3K38NF5Bj
 HgouG7nMTzpIhmyX8Qs4bVduWDGVzAN9WKKc0VUPN9OXxIHNCLXbUppxzxRUWkIKSdqe
 WSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672926; x=1727277726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ty3pISRwyVUFKzN6AV+o1jhF3tqF577Jx2Jy943PdvE=;
 b=FRCOoqFmTb9J5lWuoiS691S0Mbjtz7JFs7mixBLGfJAIT3YK7jN1nFaEefHhGxtP9l
 5Ey68GdikvPc3ropRpYwARxbByb4S+h03FwsioOXTbKdTqFMT1MBe/i31tIpJWd6ehon
 sn9xvJypPwqqRrq+jqQm/5en4s6/W50RV6KWxAu9uUbSb6c090ocRI8gxfYZt+zDaPpA
 ySMvscyWMdSezqzsqHmOUMLT6LQYSH6pIvLPjC2+XhzjHV/SQ0ai6sEFHT2R7hfb/L+G
 mBUYhhJrJSeLVQAIAH0aC+JG6MkfJSmlcYVyMrJ4A3qEYhB3ISxXQNotxhhnVRsBMxpN
 FxfA==
X-Gm-Message-State: AOJu0YzRMktRr7R98UlsvcH/0QoHkRQ4RQIs/TOhoifhcqM53NH4zf/V
 YRWXiSumILzjuTaq04n8s/8woEQ/hUiFZjYEXJA35KGd6oQKmj7eeg8Zvo7Rwz/owvEPLUTEGaF
 M
X-Google-Smtp-Source: AGHT+IFGcOevraV876YOoJm6T18PhFddnISK8kk/eaLaIg7BM9s6ComWIPSVy3hYSXGKcfEZbsowmg==
X-Received: by 2002:a05:6512:33d6:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-5367fec8c9bmr13303802e87.14.1726672925533; 
 Wed, 18 Sep 2024 08:22:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:05 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/35] acpi: Fix typo
Date: Wed, 18 Sep 2024 17:20:08 +0200
Message-ID: <20240918152136.3395170-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
2.46.0

