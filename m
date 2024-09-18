Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA8CCDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D63B88F30;
	Wed, 18 Sep 2024 17:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="CSelD2Lk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD2A88F60; Wed, 18 Sep 2024 17:22:24 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37CF88F4D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso838098666b.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672941; x=1727277741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBKI20UqWOu+gFyYtfKa72Efvzi7J22WBbFfW2GsCBs=;
 b=CSelD2LkVyIaqMpLrgjsf6uGI5uYh2TwJNPak2bAgiwRqMAfws5V+nS+8JCsRARjy3
 p2vUv8tSAUXBJcA7rsi47iYvHgxx7C8dFh/1aLDA6SqQr4+PRSFhGEwlIl0dgzD2Lwzm
 ic0juwgd46MM53q/XqYDDVTpSb3cjvd5TIQu/RBBeKlpmoE1aVsOB71q2+rPcF3hMQmx
 BLGiJDXBuwvEF8+1+O100Fptvfcm9uU3wJB93AEy70VbkbA2Ku+pF/T7x4WBjQhtIN2m
 UKRAKlfa0wc1IIXrGACaWe1b7NDG7OcuJLmw6uaJLPzM6yv30GkEJZot8+Ou4pL0s+cv
 lWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672941; x=1727277741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBKI20UqWOu+gFyYtfKa72Efvzi7J22WBbFfW2GsCBs=;
 b=i2ceQaXAEjO8rdCwaWlP0Uo4jv2FmsRvUgFj6T59x1crBc/KfDY+BcBPcuXz/tnANY
 V7Qw8LmJ9xhn1IgH9knBYskFqdCGVKh2EZ5xohK3MQQIEJY8pAz5uxLKFnpzGUO+weah
 FptCMbIcGp1lKOuLkRnOwums7jW0RdyImGrzKY+DtvssT0akTqX2+IwyBHLegyGnVbYi
 GBTYJ+pUxfz3AUXHD8PhTJqV7CChLcUOhyYulYkI0quEJdU3yPpnIrMChm4+rLWpvKK3
 3jTBcGwr6EATFCv1GCX8tEGr2S4G3+cXBa/3mOssd1uG+egUD3NEYmIRD62WqNeqjwn6
 V/8Q==
X-Gm-Message-State: AOJu0Yyc2b3r0kq34QKCD/oPmZb5P+8uLeUQqNYypYFzFm4T1G41AO+w
 GZDt9m5hxJYI6JaCU28Y2WsLnu4xuLreqRx/yUg5tj1bfg+7kzojbIVZffxORgLjqrFuud9s4ZK
 5
X-Google-Smtp-Source: AGHT+IGbaHZCsfJ6grKjGxGi39qBYKfWgJ/p7t+QAA+J227Wi3ep8CcTGiviGQizoDcmcR060mTwyQ==
X-Received: by 2002:a17:907:e28f:b0:a8d:2ab2:c99e with SMTP id
 a640c23a62f3a-a9029730615mr2390292266b.55.1726672941097; 
 Wed, 18 Sep 2024 08:22:21 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:20 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/35] acpi: Move function prototype
Date: Wed, 18 Sep 2024 17:20:16 +0200
Message-ID: <20240918152136.3395170-13-patrick.rudolph@9elements.com>
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
2.46.0

