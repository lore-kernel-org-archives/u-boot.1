Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6976BD2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B02188D7E;
	Wed, 16 Oct 2024 08:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DFIwQcBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C1C088D9B; Wed, 16 Oct 2024 08:12:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C93688DDC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99ffeea60bso487402866b.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059175; x=1729663975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=DFIwQcBA/9eegewvrXSOpsNh4/g6JKMOad0WKwRjx9DnT3PmvR3jrGYv+5/aqeRuv6
 VqyQ/oC7pQZeMSiQsAWAMkDYZZjxA+XSs4wHyRjJZTF+slj1GQ6+1zAFyLlbFWUMzNdX
 vVE57E4sfAhrdVEsBXqSf4UnquX+ShOtpIxiJUk9DXLlJypq34Fpssx0wMJZrE2JXfG6
 ql2AjckmeR/n/VcBdhqtIvcvC7xrqOBJQHXL88kbz9I8QGrNfsUboyqS8nE28LTY9eeD
 n6fe2m3lnXmFUTZCfc+uhPAXEQUNHzgAOOqHhIR5ME0DyJRSW4Q9o+7F53Vo6vhMCzrB
 R8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059175; x=1729663975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=kZsHmO4DwHKZ1gXI8cxGbBXLkW1dJwwpn4FSrlM0MdpcpvNeNSaCwCvyY/SToTRYX1
 TK5YI68rxrLXVsJK7yxJi5q6/tbh2CvzHJUk/oOUtwDZEKbfGCgMfWi9e+0qSnRuvMOh
 xRvWaQXRVMQNErTu7H5AoEGvIy4TWUfdKQ7SfbKEO2BLRLKVhFJCaiIxEqip/RdneZA4
 lQD6eH2wlB2Agu+EXfVfnTUMWhH229FeAoeObOtmoUWUYZHqz5Rp3qzRc+0zs2fVdtq8
 Jw+htXmkOaW7OsBF1xN0XPS99VuhrO6y5Se2I0yTyMWAJ8HgqM6UkgdT2f1bzs78s/y0
 ukGg==
X-Gm-Message-State: AOJu0Yz9ir4LKDqJhi92ip2pcggt4L94+80hDBAecnZz2RJRzpgLa0+Y
 5lTstZY2m1br0sbaTq2s2fpFcmyZ368TZx0i6XxN8Z/dwxGqECI+mptIJR7vfz0KbNxhDarxhxh
 i
X-Google-Smtp-Source: AGHT+IE8sGulARrMFfLkp2PMoXTLnD1AYslGD65xJUxU9Esbbvag739rnE7hN3rnyOb4KPzLDkT/Uw==
X-Received: by 2002:a17:907:3f1f:b0:a99:ed2e:3875 with SMTP id
 a640c23a62f3a-a99ed2e5250mr1171476166b.42.1729059175497; 
 Tue, 15 Oct 2024 23:12:55 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:12:55 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 12/37] acpi: Move function prototype
Date: Wed, 16 Oct 2024 08:03:58 +0200
Message-ID: <20241016060523.888804-13-patrick.rudolph@9elements.com>
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

