Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F395ECFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D078789340;
	Fri, 11 Oct 2024 12:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="CHGnbfOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B98892E3; Fri, 11 Oct 2024 12:34:54 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1D9892E3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fabb837ddbso27973351fa.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642892; x=1729247692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=CHGnbfOllou9Fhrxz7xSg+mVyvm7ARQY0q4yyNodeJsZv8BxXpoLJiZlYvWWIwDyo3
 i9i5VTj+T1JcW4kbgmn5iKix+DjbitYwtfzOtsr3j4KlWT32NQ7THZD3OXHC2m/UQ80N
 RHWy1Gfto0UcSF/UM8IcEN/jXD9sbQokhERyUEoFYERcJqB6H1rxvtLdBVP1fk8OqWXX
 LyeVxV+ccjSAqnStC6NGR4xiPtS2wO931zfdsl8B7mlffRHm0NZb6nsYT43wdYee/eiT
 wq10d93DaVk5uznW7/Fsgmx8eOuqK30+0sU6o0yge2Dz3wxFHZyGEBQumTBHNk5PAnrR
 qohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642892; x=1729247692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=gbWv8t1A+V8A6AMlwYrmbm9tbK6KeScDiGAxdeL8HOpWoOAzxs0z+3aEuu7nemNk/I
 k/7e+eeQT00u/TB/8Isri7CvaRU9lmg/WRIB8uJsB4Q6BYsUDoalDu3wz2SRi2CK8HJJ
 GJTwWWtpZw15YMNlQRCwYr9uE9HXWkgLsii/G3aJ4RiyDAinsfaQbi9tE844HNFCkaqX
 qxa5k/W/oYi8ug556ZVdnbuiOcZenqZeCEjRV2Y3kgJ2Uxr0TmvkxLQ8TaxiUMAlXEAs
 Yt44zJOQF5J4JhlfK//PUJFlXi1h4P31enKlniOCFxu5ZhQSBGa4PJC21UGUOKLrRAc5
 thow==
X-Gm-Message-State: AOJu0Yx5dBE+ml+rKdHHfM6T2lhYUeShVTKa/VBRTo78drXYoIZvF2vD
 /SxZPWYGetrW4UYmm3d1C1Q2iLkfcxAG0n+db6UcrfpRwOrkuBqI3wGjpXbv8Z7YWGenkiqgv/d
 M6Ws=
X-Google-Smtp-Source: AGHT+IH4y4ylU18NQAIc28EH6L38OZBoUapnaIhOtyha0y0119PJDLMVKWiaj2w+ImRUXOm/YDGCMw==
X-Received: by 2002:a05:6512:2824:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-539da592f6amr1626123e87.52.1728642891835; 
 Fri, 11 Oct 2024 03:34:51 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:51 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 15/37] acpi: Add processor device
Date: Fri, 11 Oct 2024 12:22:56 +0200
Message-ID: <20241011102419.12523-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

