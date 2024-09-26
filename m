Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C90FCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A120988D65;
	Thu, 26 Sep 2024 10:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="aP/EkbVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747D888D63; Thu, 26 Sep 2024 10:02:46 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3D788D65
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c874f6f119so719894a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337761; x=1727942561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBKI20UqWOu+gFyYtfKa72Efvzi7J22WBbFfW2GsCBs=;
 b=aP/EkbVLzV/LY6NuzibF6F4ueN4+h16vAzdF+AFiVdNPVP/aQ2k3lq3GFZwCro8KoO
 YRRwdKMl67EQZckHCA2E8ltvuiaIJSFQYr+95+a1Gt5d7kH3EydOBTAJF+/hdDzLPKBN
 l96s7uybSsMMFCujCnTTWinqhkApBauhq43CYB0rsV3snncEBpkVkKCr+WvSsRG99a/N
 Q0Q8IydC9YfuAuzTiWw9UMRg3Z2rIsOM3c5pE9suWfm+r81/NUBTNcYA/8EaVME85Xa+
 FVANkXzp7tYtcS+uGK+kcHmNG/vvs4dyGRfdJ6zbSBCrdbR/WSu+geUQ0Xg/WWriEylp
 DmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337761; x=1727942561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBKI20UqWOu+gFyYtfKa72Efvzi7J22WBbFfW2GsCBs=;
 b=q7vWA3/Y4XDT/R48xhYa9w38qSksJwLWN8KLveDbr0ebqWP/6OYc8pr55WF4wbATku
 Bqyw4t4ZFVZYQliZPgqtc6zs3SFTSmM/cwo1ZGb28/qEqUoHEob4YMbUd3Pre92fhEZD
 Zy0gI3WllEE6GhTSCRhDNEyeoSRigDu9NqrG2DNkakpreizt/XRDXYh5M7YcePZKcNbG
 bXuq/s3asRF2PVExyMea5VeidAwyY6wO2lAk/s2uyEHZI5OMng6PWn7Pv5rTv3eQhRnD
 Q/xiY26Wl9y5rFXkUwDkfoxbRM7CbFypIwWbcKtCCc8Ntjw7xWcaOhxjPJOiFYmACTjg
 xrLQ==
X-Gm-Message-State: AOJu0YzLoUwULDoB0B+mT3oP/44k2BwhOa+z5T7GGgLsytTsiW2PLleH
 scbnAxJl7SRKKYaiJr4mTacdgtrgViuQYjTYhKsQwDHBtj+t7e7ObiqHAcDP16038Ea/SIVnvLU
 g
X-Google-Smtp-Source: AGHT+IHl6Ag9h8q/zkalrHiWqzLekQmmRW4tuOhdAR6jrj45SwE4xnZg+G5fskSt3lCvdeEZF7qMnA==
X-Received: by 2002:a05:6402:34d1:b0:5c2:6090:4047 with SMTP id
 4fb4d7f45d1cf-5c72061b4a3mr4224849a12.8.1727337760725; 
 Thu, 26 Sep 2024 01:02:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 12/36] acpi: Move function prototype
Date: Thu, 26 Sep 2024 09:59:00 +0200
Message-ID: <20240926080021.148031-13-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

