Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADEEE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E86D891A0;
	Wed, 11 Sep 2024 08:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LCF7W+qD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321A089195; Wed, 11 Sep 2024 08:25:47 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42968891A0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so848812a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035945; x=1726640745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FInmVWYwaLnkTSaY5jCg8oW4s09tanH0Gfb3VeAiIi4=;
 b=LCF7W+qDKGo9pji7wNCUaG3xmRBu/d5uQ2v9D+JxDg0vgxpfs9tTJdGuM4vy1v/+64
 kAJaaimzoSmcBw2+QlykMNyd3TyESWsSrXo1JbcRX9VC/zvG/AnMZ5BGIlgpFkKY5Byf
 +2GEZsLBnY8vAbD0KX8yKj9TQZ/5RduoYpdmit7irtla9cbbZpBuelZoQ5O+IfPXnrkH
 pnAy2fdRtWWAHuBMHfzb69+Woc9ANVOGETgW8MTWX5dIs2kFd2iVkcKlLcu9eUy1XKaV
 Beyo7u6G5PUqT0f4O9/amQ8W7kDe/+N4xKP4f5b9Ym2ZSStI6BtIezs9GZBndKyGJxwm
 QOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035945; x=1726640745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FInmVWYwaLnkTSaY5jCg8oW4s09tanH0Gfb3VeAiIi4=;
 b=f650B9wppbbZFf9pLJFYvH15OmIQ14xocMpoHXpF2e94iBeTC/soRmjH/DAHAeO9mG
 MRklS76Sb7uOJJ2FnrM2ICC7YWfOq4OB8SVJREq/nsqRnVCyQtDDycCeKYi8A4uB8SfN
 Yssv+LDPu3qPB/B2sUSItdw5USPt9+DhIxMFWV7imE+meuJduBm8K+9eV6daNDK4Jcvg
 JuIJ5s+OUa+D1DyHxAVJs7Bxz93dzau1eKxffIWPqMURNNonzGm7PFIOlU+MMU0oYBkV
 a+r/dOg39djozUgG8Znir2qvovP8fr/rosY9BAL5CroztRfjwaFqLw46zbA4Qt0RgEd5
 quCg==
X-Gm-Message-State: AOJu0YwqJzGM6cMGBocKOvp4dvNhNs6FjWgSVV7LEine6Kcei2eOAEq8
 Xpw+aVSZ7uB2jPoHrDKE3R12fz+TkfNYeGf32R1fTiWe1bOnCcULKGRkSDScAWsQieH6bhFiKXs
 v
X-Google-Smtp-Source: AGHT+IH9BNF/3Kt+6IsJzctqt9Pl7WukYMRLRPif9SABSrDRd+SBWROcFXkzsEhGAnmdvOhm0Ggyqw==
X-Received: by 2002:a17:907:2ce1:b0:a8d:41d8:14ad with SMTP id
 a640c23a62f3a-a8ffae3fd9fmr376078866b.29.1726035944511; 
 Tue, 10 Sep 2024 23:25:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:44 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/30] acpi: Add processor device
Date: Wed, 11 Sep 2024 08:24:05 +0200
Message-ID: <20240911062511.494855-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

