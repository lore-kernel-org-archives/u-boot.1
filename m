Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A793D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 914B189119;
	Mon, 14 Oct 2024 15:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="IPgdKJZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5C4890FE; Mon, 14 Oct 2024 15:12:29 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D13089121
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d4ba20075so2783566f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911546; x=1729516346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=IPgdKJZ3hbmy098zavEb4FkBVTtDZdKdpAriwSjckqDy4ai06nRBHICUvbp5ejInyj
 d962ROBzMSujRVfz4g9kl4KkhBCYxNvVn+LrYUKPHeF69eRIRajDwsTO3JDQfNkrf21K
 D1BXyU52SCf7uKCI6WHU8/topOwDewVXqd7MpIM2bcnOVkmDY68aVgSz2JaHY+/UEOVA
 tKRtQhLnbsqjbMKJ4BHMNBrr1+Cnmeep7xDmB24tfejJUkmPXVN537JXnDyy1Frq54yx
 ijWEsbjh+GKUH2NDc5k0RP/eB0bRjj4eLCNzNrsSjSfF/Yiy/78rWPNI75pflh3Gg0+w
 fFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911546; x=1729516346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDa+/YrR+N5qsr6z5pqYueAQI9MWGaiXzTeTyLorhcc=;
 b=i+s8zm+y1H7dRGe7vQoF2udJOKIXjutUe4DJjAJO9M5ffkuv84WS2Xodw5lXcEjxGD
 iCHpGmOUJlJOp8HXWS6QQ6yPCLRJARLRad21L72MNN26H//MefXNisDw4Cty/I2T7K4L
 3KsgXuXO4dS7KABbBCbAk9bfO9Xgiy3j6GN5ys+Ohz+qA+d6AIWN3VG1ur/ppkwuesOa
 2EKLe9ObviY5RMeBQS4DRQGDb3PfwK2G4Qs/wcqy54LhwB0WIzM08PXUm8XUkF86Q7rl
 G0GvCLY5TFHYcVzZNRtFZM2mbS/qFerYscR68lbrSBDlr3IgnKKxt6VFA5h62hhUbzf9
 WTEw==
X-Gm-Message-State: AOJu0Yx6A/LDDxjLE+FHt6XeZWbhroTHt41zDJSEog9I/WkUiSWJhg5e
 gMl7PoztVJ07saDbA1yCKpCXridLLO3rbiffFwppxPYR7eo/M0O9cekBphtIn3xlLXhrZ9vIoWg
 M
X-Google-Smtp-Source: AGHT+IEc06VO8oBxIWSBFdrkxegPW6pH4/3u9C60Dd1pYrrzwv5SlFlBe5YPVfANvPovUJnHHDNoAg==
X-Received: by 2002:a5d:4bd0:0:b0:37d:524e:9431 with SMTP id
 ffacd0b85a97d-37d552d3820mr7034044f8f.57.1728911545775; 
 Mon, 14 Oct 2024 06:12:25 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:25 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 12/37] acpi: Move function prototype
Date: Mon, 14 Oct 2024 15:10:28 +0200
Message-ID: <20241014131152.267405-13-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

