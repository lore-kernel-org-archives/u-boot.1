Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3CFCFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18AE3892E5;
	Fri, 11 Oct 2024 12:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bbsI5l11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDEB892E5; Fri, 11 Oct 2024 12:34:49 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94D789327
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so265584166b.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642886; x=1729247686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=bbsI5l110TVu78NaRj+a9eTAzr/ItsR5u9mPQ1Sa7R0l1qgApdG973sbNFUERJHUN8
 z3/LTjop8AqGxDL6DeyWwYs7LEpzNaBHFpeQDGu0WPqOrRGcmPJBDEQA6d8Tv/l8IACO
 gktBR1eMfT8LLCHOMuL/e+iIOvGzTEYvS4KwNBkAAYeouj0OJri32RURZaXBU/H5s0Rf
 rBLZram86JH3RvN9DQ5vkL2Z+79ziYaRuIHor1AVQsR7Lbjhxkj5QmWMBe4SQl9ZveeV
 r4myc2qyG4rzyuBcc/zi1VVGYNIg0KwelwI0Ip8o+5hRuUxk2k7XWRaYz5mc5gCaVSQr
 EpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642886; x=1729247686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=P2jT1gEoZXD+e4csSkELo321aKLX2E0FIoOWkrmvXLja4g0/IgiSqnF6A/0uBi5peX
 8W45BZwXCZtFOJiY3C8i7/e3XrzVquzki6h0wy6QwfmDVXVtg7DtLYGQYEj1oN3KsGtt
 cWahc7nTCQ80KHXYaiRoahIyF+aBdIUxfmRj9PMf+g/bPbDIANilsnJB3rzUsEW0r2rb
 7Myz69wn/Vgawy6EZ+rDH+TXIKq9QLj0jBKO0kYwpRKYrIfjB8AN14ldHZnJXuXK7lYr
 XWdiPYKMDDDRn2HadqsoGxDiwLc5snT1nNsDRpOeCZByZj3vhSJm0NF+aXJpnCYVp+vq
 si+A==
X-Gm-Message-State: AOJu0YxI3GBfa6TtyW6u37qyHc6ttNa+9vi6lUxyr8xU0fZHzxteV11h
 vwWPG4KLf2WiSJHcElyUwxJx7/oSgFKV4QLrogdBlheg3DsN6f5OvmL0ionbLFHpzAsQw1wvl/T
 bQtE=
X-Google-Smtp-Source: AGHT+IEh3+HpYNcQxvovrdfaQAXpd7KOm7G0UZMzvavH8hQ7EbT6I1O8a8GOr+DiC8VSnrKBWXt5/g==
X-Received: by 2002:a17:907:360c:b0:a99:4162:4e42 with SMTP id
 a640c23a62f3a-a99b93fa0b8mr165043766b.37.1728642886204; 
 Fri, 11 Oct 2024 03:34:46 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:45 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 12/37] acpi: Move function prototype
Date: Fri, 11 Oct 2024 12:22:53 +0200
Message-ID: <20241011102419.12523-13-patrick.rudolph@9elements.com>
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

Allow other architectures to use acpi_create_mcfg_mmconfig as well
by moving the function prototype to common code.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/x86/include/asm/acpi_table.h |  2 --
 include/acpi/acpi_table.h         | 13 +++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 3254bbc380..ff60384e62 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -31,8 +31,6 @@ int acpi_create_madt_irqoverride(struct acpi_madt_irqoverride *irqoverride,
 				 u8 bus, u8 source, u32 gsirq, u16 flags);
 int acpi_create_madt_lapic_nmi(struct acpi_madt_lapic_nmi *lapic_nmi,
 			       u8 cpu, u16 flags, u8 lint);
-int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
-			      u16 seg_nr, u8 start, u8 end);
 
 /**
  * acpi_write_hpet() - Write out a HPET table
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 5a30465ad2..07c5f65d75 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -994,6 +994,19 @@ int acpi_get_table_revision(enum acpi_tables table);
  */
 int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar_flags flags);
 
+/**
+ * acpi_create_mcfg_mmconfig() - Create a MCFG table entry
+ *
+ * @mmconfig: Place to put the table
+ * @base: Base address of the ECAM space
+ * @seg_nr: PCI segment number
+ * @start: PCI bus start number
+ * @end: PCI bus end number
+ * Return: size of data written in bytes
+ */
+int acpi_create_mcfg_mmconfig(struct acpi_mcfg_mmconfig *mmconfig, u32 base,
+			      u16 seg_nr, u8 start, u8 end);
+
 /**
  * acpi_create_dbg2() - Create a DBG2 table
  *
-- 
2.46.2

