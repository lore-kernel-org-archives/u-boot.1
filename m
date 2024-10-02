Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5295CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2878900A;
	Wed,  2 Oct 2024 11:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="PBMA+DKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B219388F75; Wed,  2 Oct 2024 11:51:59 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B49598900A
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ccebd7f0dso3352458f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862717; x=1728467517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=PBMA+DKRK02S+7xS1qLCClVVoiDG5xsRt5K1dkGDSppF34qyB/cFSb5jZmyDoZH/jc
 kFRWW8pIlPdA3EItEC2kJf8zFBh+LisuSAVxYwkSHiShXgvG0B/MOLFZqkCD58KX320W
 zBwGU688a9n9aosOWK2CguN/jbwv07zbXAc+e4beRan3vT1u+rk7lBVgxUeiWWEUvoHw
 VJyBifSSOVoUPzbZ2wFvbSlAb0iEaYXbcndMrUk5d9bO3ogR561cEcL7BDtHg0Pw/fAl
 Z3zZSYfhIpv4TXzrIb65jgsyFYjFyO8Xoy6ecmkEBTbKSzKeFG21TgAF4MEz8sfVxOVx
 2izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862717; x=1728467517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=O1Q4G1msEF9yeJFpHqY1uAt86PszYDHaj+u44aNneVKoZg0xHb/lxW+IgSFLHyLrSu
 axvb7J1vPIT6n/kdo3xhRvFXwUmZsIx1BR6Y8h3Q/JL11vL31tQH8+BI7W+1ghHY8Kc0
 tey6t0NPJ8thrP8eYGwNmI5WDHPTb82DFCvazRS5u8Qg8JRVlm8mey+PO2K11EY4RALi
 Hhq/jbPgCopMTtFAHiUN9yhoX2d1h/OoVmrpIKp6FWCYJE/XXCmtEB4rc/HjF9gjoBu3
 wDQr8BQX+Jq8CV48d4FqlETVScwvehS63GPDWU0y52yIOb62AnLc2hpjQKMhosKPGFFL
 ZcOg==
X-Gm-Message-State: AOJu0Yw7HCfLgQzEcc7v2wp40k8PjJpZt2zoqLOBd8lFH495/WCvSBOo
 iqC5bGu89Ie8kegFtRXSlrkYfgkj0q2MpFnODLuO3TpWkdSD6V/CV9L9UnWMM0gdOohlRgRiP1J
 8
X-Google-Smtp-Source: AGHT+IF8tlRMvh2zVXf0TpTmw0EnqpQ/no2Mhs1LUnhQtXGj4YnIb9kWOGb27VeGxd830zlkJIDGmg==
X-Received: by 2002:adf:e447:0:b0:37c:d1b6:a261 with SMTP id
 ffacd0b85a97d-37cfba2138cmr1596502f8f.59.1727862717067; 
 Wed, 02 Oct 2024 02:51:57 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:56 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 12/37] acpi: Move function prototype
Date: Wed,  2 Oct 2024 11:47:03 +0200
Message-ID: <20241002094832.24933-13-patrick.rudolph@9elements.com>
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

