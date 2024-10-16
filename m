Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F0D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D111688E43;
	Wed, 16 Oct 2024 08:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="GC/18ucS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F44C88E43; Wed, 16 Oct 2024 08:13:03 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8D288D9B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso3892879e87.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059181; x=1729663981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=GC/18ucSijBdvuig0IkA3ghEz9rUVO7WeZ0YSS2UtCNAXCXL8Ta/hevnxmtm6PVyOf
 pT0stSNmbj/O5/k7gTYBydZguuydoaPTSbPLv/wfVSeiOw2rGt14cAbzBuHJfBjLpp/r
 OK8GCpeggvhL0/H/ApNqZIevgRSEm1FfKMnExYYTUtxWjaiKjmBomaD38lEf3jiC7Jh5
 D4dfSLiRefnyoSMpO7bmLsLVBdJwFViGYdfSa+eo5M688U3ar6xxp1/OoQMW+/kwQu7R
 jyW4sWYQB3iGasPjZX4kclL+FdsDImA17kSKzebkj4HL8AdyMktvwW1NTpOsS8bETa1z
 th8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059181; x=1729663981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=gE1UWw8KU/ysPP1gP2OyrCHzHRCaLJ4KASKZRQbPdoqAHNuVb9UBzRVt2KMotV1Dmg
 fPZpV8OdoKwgLmvCebzEzOBniPGxUROJPvjN8IYvawQ6eo3eh30NnpbzRY6U/POwDWKc
 b7s4jwb7cpL0/dKADMVsfj8vz5vhjzW46W9hiGPbANxX83cS807xAg/Z0X86WHILndpp
 fO5rse9HxkehfkvNsjtC2CcHVxziXuKxmmJ7AXC5/6ijxEElv+9vNKAKoRjaDAbiZflG
 EsdmDFoVUSdI/+nuiiDXmVJcGvMb4Pe96MXQSBJBxANBYr2RaB1zYaucH3N+nw3gTttu
 PGiA==
X-Gm-Message-State: AOJu0YzZ6k4e6hnv9PmXhXUjelA1HWcIg8/dB8uVM+0Z0I4tHlp/Hpa+
 +k/JUQNDupaycT/GLC2pIbf3+gfmlbFJbUtw+m08MCTi2T0JM8q3nqAoM8Eu4Fyr7rNyhnAm/mO
 A
X-Google-Smtp-Source: AGHT+IHFc38fQIQwRfVuYHvVZEmgdqnurXD57k0frq5rZPGIYW+bOjw8879tf9Tyt7eTp87gMKYL0w==
X-Received: by 2002:a05:6512:1090:b0:539:e651:5d97 with SMTP id
 2adb3069b0e04-539e6515f25mr6935122e87.50.1729059180863; 
 Tue, 15 Oct 2024 23:13:00 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 15/37] acpi: Add processor device
Date: Wed, 16 Oct 2024 08:04:01 +0200
Message-ID: <20241016060523.888804-16-patrick.rudolph@9elements.com>
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

Add a new method to write the processor device identified by _HID
ACPI0007, that is preferred over the Processor OpCode since ACPI 6.0.

Fixes booting arm using ACPI only since the Processor OpCode isn't
found valid by the Linux kernel.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpigen.h | 12 ++++++++++++
 lib/acpi/acpigen.c     | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/acpi/acpigen.h b/include/acpi/acpigen.h
index 3aa94d70b9..16df85b9c1 100644
--- a/include/acpi/acpigen.h
+++ b/include/acpi/acpigen.h
@@ -833,6 +833,7 @@ void acpigen_write_dsm_end(struct acpi_ctx *ctx);
  *
  * This emits a Processor package header with the required information. The
  * caller must complete the information and call acpigen_pop_len() at the end
+ * Deprecated since ACPI 6.0.
  *
  * @ctx: ACPI context pointer
  * @cpuindex: CPU number
@@ -842,6 +843,17 @@ void acpigen_write_dsm_end(struct acpi_ctx *ctx);
 void acpigen_write_processor(struct acpi_ctx *ctx, uint cpuindex,
 			     u32 pblock_addr, uint pblock_len);
 
+/**
+ * acpigen_write_processor_device() - Write a Processor device
+ *
+ * Write a device with _HID ACPI0007 identifying a processor.
+ * Replacement for the Processor OpCode.
+ *
+ * @ctx: ACPI context pointer
+ * @cpuindex: CPU number
+ */
+void acpigen_write_processor_device(struct acpi_ctx *ctx, uint cpuindex);
+
 /**
  * acpigen_write_processor_package() - Write a package containing the processors
  *
diff --git a/lib/acpi/acpigen.c b/lib/acpi/acpigen.c
index ecff5a50d5..fa9dad32a3 100644
--- a/lib/acpi/acpigen.c
+++ b/lib/acpi/acpigen.c
@@ -361,6 +361,17 @@ void acpigen_write_processor(struct acpi_ctx *ctx, uint cpuindex,
 	acpigen_emit_byte(ctx, pblock_len);
 }
 
+void acpigen_write_processor_device(struct acpi_ctx *ctx, uint cpuindex)
+{
+	char pscope[16];
+
+	snprintf(pscope, sizeof(pscope), ACPI_CPU_STRING, cpuindex);
+	acpigen_write_device(ctx, pscope);
+	acpigen_write_name_string(ctx, "_HID", "ACPI0007");
+	acpigen_write_name_integer(ctx, "_UID", cpuindex);
+	acpigen_pop_len(ctx); /* Device */
+}
+
 void acpigen_write_processor_package(struct acpi_ctx *ctx,
 				     const char *const name,
 				     const uint first_core,
-- 
2.46.2

