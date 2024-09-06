Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C783CE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B3A88D36;
	Fri,  6 Sep 2024 09:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="RAi54Btn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D659C88D2D; Fri,  6 Sep 2024 09:22:43 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B9888ABE
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so219449766b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607360; x=1726212160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMT0UP4mKoqd1G/f+OIglON+yQSl70auLCGbIuvNf28=;
 b=RAi54BtnfpAqvOQqnxZ8/aRpX5cVOp8DDPNO8dcLxRRhbMzKyIUcHiE2S4jNbe7nYO
 3o7t10/I8vLPvAQaxxtcBEvyCbddsAXeefAiIzxndy3Gj15dnUSztpJf/Edhn5NcvwVE
 RemEKqTy8WAlj7OIUIansz7tfrmffwB6ZYo8wubBKS1HX0u7O/w7ir/9OkaIqKeFuqLX
 jDmb29EAVjhrnG/EdQY95scQ6XXBG6Hp8mwedSd47yRshsMKIvug5SX6dltZFP8HnyRp
 ZvNHMPokEZif4mXBIeKIxQi9MpczU0CFjl3P7fw+imGbOC1VIzdcUylOmwIp7fu7wZIi
 bnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607360; x=1726212160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMT0UP4mKoqd1G/f+OIglON+yQSl70auLCGbIuvNf28=;
 b=TACNNWaYAO8405r6RpKUwplAJ2/ZxbYgEO50HCxnAhAFSFC7znJz9yxe7F3i+ACT9I
 9xgcRYB1DNyIFz+Zyfi8SFi40UXpxiFH6RuRt3vOnqKnxYgMZ0DNkj5WmPfnVyHNsXsW
 YD8rdcvjHPBXRvpaQHUUumUqlTi+Qme0+MYdmEG/fAVMDyL1zSMi+8xjFG87AA1gdNYG
 y2OLEWY9KELnB98jKRYn2yQxrDcUF4CQdrMwxNfZwopLg5PayjzTQNpZX7j//uzhP9g/
 gCdLzyER6Htx33NWHsDldDdVqcu6/fbVreW64Y0Lsp1tf9Tq83Hg5WQD6A+nhm8VUgBp
 NAZg==
X-Gm-Message-State: AOJu0Yx9A6P4qRlYkExFzZ+PcOXm4i8p/ev0sQnw3Gwr9RrvCSHL6634
 yaYNrZiTTsDO7/Xm8zliyZjZ0mtjESQwUCtJCNrs6OEDC1X0at8idW9VT68w0sKvZyZ+WJOGP3Y
 i
X-Google-Smtp-Source: AGHT+IFPWSxSTQ70vXBMlmms46QB+xaJ7924XtTCW8cNiFWD5baI5AHQFiaEVh/4uPAfamNyeLkLXw==
X-Received: by 2002:a17:907:8f16:b0:a8a:8de6:a605 with SMTP id
 a640c23a62f3a-a8a8de6adedmr62930566b.17.1725607360053; 
 Fri, 06 Sep 2024 00:22:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:39 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 04/28] acpi: Fix typo
Date: Fri,  6 Sep 2024 09:22:06 +0200
Message-ID: <20240906072231.2531491-5-patrick.rudolph@9elements.com>
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

Rename ACPI tables MADR to MADT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 58630b3c4c..8a25c76cf3 100644
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
2.45.2

