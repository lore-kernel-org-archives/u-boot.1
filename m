Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E44CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE97888E0A;
	Wed, 23 Oct 2024 15:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Ctvsfd9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4FA89322; Wed, 23 Oct 2024 15:28:54 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9245892CF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so4714654f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690131; x=1730294931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=Ctvsfd9+caWhqiFEJJc5mKbW5APOCspijOWVHkXgOa/+ToBfO7hhl2SEVbG4MczaSY
 NnoBEjtNbGrfQPieoTkYTWVfUU1rxunf5FQOvXPZrsLCIhsAK+1C7xRFkmnqRzwYtoJQ
 vJTFiByTuLId5xe95Us5pHbMYYHBX6FBXI1MGG83qqkQ5CCSi9rpC8PkvkPf2dpwCVjP
 XVvrYqsdDELr0wseK0WZhAMJodolt2j1Kk4e/jksO2LZHw70+dAs0ZGjpP3ZDEFPJy3i
 /doNhsT82pxlIXMe3zCUtg8Sdibv3t/G9bId4seDKsKIgnclLfyYtGHtyDcanvUdL9Wg
 vQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690131; x=1730294931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=fPorQ9YD1krRfrthr5blZtB0uh36O1Ui8RBbTC/8hdpx2gssArOirVJKjjB3dqtAI1
 bzCJ2/fuNz+paRxfcvjdY4WqZChbsR0fYb5ZjWlt6UP6Sb+QcreKCV6yr6KEojnb/er2
 kVHLk1IAh6caZ+pslEMJ1dVwSNeTF7KRSQ6OO5O7KL5yW0H6ylnnffWn2PhDHNrJ6dlL
 f577uMbd2Fu2waBVXSNBFWynoi/H6OCTY/fahzpE7Mpw+htUx0KoEiKoItAm6/1EnbkL
 gh5DFNL8nDpdGCejOdHGb0wqA1zg+WeCleNh6imXeWZOQOli4tPlqB5fNTASNiG8696L
 pw/Q==
X-Gm-Message-State: AOJu0Yztgi9mB9Pllmbk2pJaAi9qowQ56LgykdJxHfPs2+uHwVhEDZId
 NtydO7XCHWBD8Hgpcu0g3QtRwvHPg7ha1QS9P6KkFykcJAVZERPjcrqNToFp1oLN+ZUqQp/1L+D
 M
X-Google-Smtp-Source: AGHT+IERwc4vJPT4/iOiV8D3ihgc5G8dAbZvSbnqxBfoqLCakPDwPwObs+7havOrAWVPHbvNcosZpA==
X-Received: by 2002:adf:eed2:0:b0:37c:d179:2f77 with SMTP id
 ffacd0b85a97d-37efcee59f4mr1772533f8f.12.1729690131206; 
 Wed, 23 Oct 2024 06:28:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:50 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 12/37] acpi: Move function prototype
Date: Wed, 23 Oct 2024 15:19:55 +0200
Message-ID: <20241023132116.970117-13-patrick.rudolph@9elements.com>
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

