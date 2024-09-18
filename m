Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5326DCDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EA988F68;
	Wed, 18 Sep 2024 17:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JNZDVDXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36FDA88F4D; Wed, 18 Sep 2024 17:22:29 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C0388D4D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so756230066b.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672947; x=1727277747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r08313roRAmkuW+3ysCcdiZB+Ogq9tcIZk2Ds5uPYak=;
 b=JNZDVDXsi4AYxPHAHQHwdpSmthRlEOm59AVC+W4bS2dcD5mZdOwkxcgK5D/CqPb+t2
 kW8sSSScK05NOR9MEDlxxjLqHjNGh5kmKkz9MCeKmXNrcfdtC+sVFJQdt1EJwNvS+5SV
 8ZZb95c89WhLmfyrTQ0s8qFBOj9Mm1WEYfCb4tFKvphlWpxHAXlJAwei+XB7YKJV4Ciw
 rWWtnIWw0pbRU1JfJIRBkN/erj6WzGCqfO5c+bT+tnMb/z4BX7nBO9NHCMf2smvo5wKF
 WnzRgFjqLfKgK2divFCnQF4Fw4izPMwZ/vmObROVWE2c6z3fX6M5Yba7yyS9fvRtWqgj
 Vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672947; x=1727277747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r08313roRAmkuW+3ysCcdiZB+Ogq9tcIZk2Ds5uPYak=;
 b=rS9wkAvxSHMys9/66bueO10a9Hhjjgtw5ovXR+tlPveBEfOl9musj+9H4hMxqSi/9n
 8vVAqN11bW4BEr0bULn0mqyZ4F+YY5CocMH1dToSgLhvrk2BOZ6PBoYTqaBDY75UqaBq
 VE6x+1ou7e8Uik36yLBCetfm7lYwYTqxpenDBN6f9nseHcDHu9enfIBvRq67KmPVKOj1
 9QnLtlLhkwpsGLL69cwqTSga4Iav8UbBFfDYxNmGzdNImmsne3HLK/EhFJ1MNpum1YzM
 I6cPRtV0fkpEsWOLW3IjGNeCrFaXT8GfxRwBGGWctlR2xLQHy8rlsyuq79JXC+Tl1Q+r
 9S2Q==
X-Gm-Message-State: AOJu0YwMXsQ361RD0BszI1hJSl6CVb8LqOl9exQsCxG1bHGvdUg2Wfqb
 25dgZbAZyOKr4r+2jvO5VZ824xqZRvez8TOip919/NV/YrbmkAGUmyE4wDjhXfa5cZGYo83vrd6
 8
X-Google-Smtp-Source: AGHT+IFgHbIKHNrh+8mpR8vtis36m0sy5eLUx1mlNL64heyX+4beTKXL2qAZKCVlTPUMAOb9MzihKw==
X-Received: by 2002:a17:907:6d14:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a9047b50504mr1874286866b.7.1726672946664; 
 Wed, 18 Sep 2024 08:22:26 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:26 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 15/35] acpi: Add processor device
Date: Wed, 18 Sep 2024 17:20:19 +0200
Message-ID: <20240918152136.3395170-16-patrick.rudolph@9elements.com>
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
index b95cabb914..427ebc2104 100644
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
2.46.0

