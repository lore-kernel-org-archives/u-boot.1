Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B43C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7391F88701;
	Sat, 27 Jul 2024 09:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QhevxzQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA5A886A6; Sat, 27 Jul 2024 09:20:14 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12CF88210
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso323036066b.3
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064812; x=1722669612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMNBdG7ovwjUfXUZgiOjHh9Pi3wt5nori9N+OrxwhdI=;
 b=QhevxzQbyNKeiGRHFCjsTxPosqstxqLW3vFiNheSRP9qglxz1HeYhDx407Uo7KnYL4
 9Zy5kighVO2MjxHtK5xzzIs0yt3K2AqX1OeabKCaNNe1c/vGseeQE7XkLar/30BNieXu
 /bvsQMV5a2ysqpJOAHC8zvF0ioNZENFEVjf70cHhx8peW/zjisK8dMZW/udLKrH7tfVD
 QV9Cge69MOcUjocwecpVh7o7tdBvi/i1mb/1q9To0Ct9MGD6BubzrHsenW1ua9a1NBJ5
 w3hxzohquYyhePESWIawMKuPUt7jw9api0xn9LtxmFem4cfpc+Y4NqBA+y8YmwoprFlW
 B2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064812; x=1722669612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMNBdG7ovwjUfXUZgiOjHh9Pi3wt5nori9N+OrxwhdI=;
 b=nYy3SgAZ2Ze8CiQKS4f4VzBsVOVnRN/rPAJenLjKcCHmEmHRolCRchEjXLfybtY/S9
 o5AUx3b/VUAHoBixCojTwS2GMFJb5dyyJxYzL4bwadsGl9s9YZt/5wH4EWlJXDdMLEXL
 pnAxs6t9nbvTCisuq1JnC8MY9JMP48ECYk0ltuipXJLE9IzMeUTwaPBlSDAaBPx6xRuT
 /lT4s8EbFaY6HMa47D8NlfqWrhQFrc33UxGV2+IubJamiT1mDDPY1U+qeBP1k/aLO5a0
 VOixELqela7qCaCPvvuYkgWE/AIQd3FfoeoOw8Fs+ZGf5cxSBynjaw9y3yiX8C4cZ+JK
 Zg0g==
X-Gm-Message-State: AOJu0YxlMfZnvds1ysJGpncS6imfPgr3KIKnCDf1ryIsD9WHOlLnOOgD
 Qfe+GiM0Lj+RO0JkWXeFBl95M0wh5daicewkBajWFFQ75HLzA2QVBhhlXIwMzu1+xtp6JGtIrtv
 bFjI=
X-Google-Smtp-Source: AGHT+IFqiuKeZA5HFZyYGVd3r/dDlXtaiOdHojD/XOlGS568Ucir4LJb4Cl83pBjzYSZDWLBAd4snA==
X-Received: by 2002:a17:907:3da2:b0:a72:6055:788d with SMTP id
 a640c23a62f3a-a7d40166145mr127681566b.42.1722064812123; 
 Sat, 27 Jul 2024 00:20:12 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:11 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 04/17] acpi: Fix typo
Date: Sat, 27 Jul 2024 09:17:05 +0200
Message-ID: <20240727071742.1735703-5-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 904c54e38e..0de3d3f439 100644
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

