Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047ADCE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9A988D43;
	Fri,  6 Sep 2024 09:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="L4n9eDjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C9288D50; Fri,  6 Sep 2024 09:22:51 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA1488D09
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a16c53d3cso234183566b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607367; x=1726212167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfOliAxNACwqtzLN+YV71ddOYzl0F5barnLhJ5reo8A=;
 b=L4n9eDjdmjyd/ANDZNtItm5J3mqi3lEw+5/anw0v6igirlYmzN2yzMTPpCCbL1ON/z
 K1HiwRtIDRl54V/UetZsFSh5i7mLJ5NWX1PV0aQdmMpauwMbBpCJ4+e9Edk8BPdr2KKI
 AG2NyVlvaOydeiNm+5GfjPslFxWx3bnUsZg5gSd7zN1fozl2TUpQEi6Cy62dyq9Cojqk
 RSNLzg9TNjaaSX5Xr6fO8QVUF1jqwOv6wEwDrnfsrcesNz9SfqwXItnZdh0Kl7Pc4atx
 2rVniTuqEim5LIUqzF90Ti4BaGmbNkAGYM+vQ0sjxq6M3Do4UmcLzOB4CrcPGnEZtCsi
 VvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607367; x=1726212167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfOliAxNACwqtzLN+YV71ddOYzl0F5barnLhJ5reo8A=;
 b=C2mp1ZRU38Kq0hhfxFmV0N/y0TtfhgnOAle40CKIhNToVOrkxEDwNZMnF+NCvkvGnD
 l7TrRjU1JQd5Qqnq4u/AG+MhqbWejbSFt1iX5ZwuRVz5f304sUz4aMx8RihlAwJk9AVc
 o41cCrrYK8M/crQkf95Bn7GpGLa0+7l549vvsny1Y6MtcEAwjvLhk7keBKoT4VYhJPYX
 W6FaxsBDMyRlR/ViD9sOerS8D7PMgbk4oF7f7l1e8xVpVPukSBTdyHhaGLKDaP9TfpxP
 PMkltIQyXn0tRAgKSy/mEzz/wplRkQ59C8JrCoa7/Q/LV6l3mtUtB9kdJQTlZCbOYbQp
 0Z5w==
X-Gm-Message-State: AOJu0YxDYmKQVbVAbELqdTeqt0B/4uTPBHfwsXIJfNsY6oc3pL3vqGT1
 6m2Tm3rFcZja3dUgKSiqUIFQ8js4txwMga+I41JkRMASNaIaH9HmV5gSr6idvgTEP2qphQyFrmG
 i
X-Google-Smtp-Source: AGHT+IFNsTjPFwtCqrOBrG0YvGMYIm9oV3CwIqAyjUVZ+JPLqmWZ+BjmPViSv3ozxEnrcE2Kb59tbQ==
X-Received: by 2002:a17:907:7f10:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a897f83ad82mr1802753566b.20.1725607366683; 
 Fri, 06 Sep 2024 00:22:46 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:46 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 12/28] acpi: Move function prototype
Date: Fri,  6 Sep 2024 09:22:14 +0200
Message-ID: <20240906072231.2531491-13-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
index f85ec9fa04..2b1a7ed277 100644
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
2.45.2

