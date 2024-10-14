Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0EFD1625B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD74589143;
	Mon, 14 Oct 2024 15:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XhfPPR1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0068915A; Mon, 14 Oct 2024 15:12:40 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9112989138
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so2795719f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911551; x=1729516351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=XhfPPR1aRZJXXx033APxvncKZfyhRjU0S/N+EF+ccpY6hvvbRV1t7QEJWkH5Pi4oHc
 9AE7sdba739HGDIk9/+545KCh3EzhipQDOx237hXgXgvXoxZ3wdHikkW9B4uc3lgPNEU
 gQpvOQIrCHjslDpChBP4Fag3ygbID5t8fIhZarszPAxeh+/duJgQJqCmTZj37anR4Vir
 DF/BG3JrK4f4OJOxpJpwBrUYW96Oq3sFJViVUkwV0VGGxUVFT8SPPg3/4kM2EIlSEWd/
 PYVs4YeobqdgqTWUCCy6qc0tmgQEBIROHzbvGnNACdDdL064t+r/cRoDstvtemVVi7nq
 1Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911551; x=1729516351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=C4VHx7dSxIrCd24PavEaa5kSAEHC9kcqP532V9ZrmBbARNxg9X2CcUV7R7OZaKyclS
 n2+C/gqiGBXikkLAT4S0eZWFcs7MYHjjysNOpsKBRXqeYEpwiQHTrt6Dyirr67I5qRIN
 jOnkdPxO9thGXR7+6g5Jx14SzQIKQ7qo+2ZkHAvHPn738oTWW68NmnbWv7yQzipaDDOu
 ee+6Q1ZsuKhTcmw0rG1LK6kJL/BMncFM0n/W1md2pbTui+RRXn3Ed0YS8UOSYkOhS+QR
 L5QDNUrUfWJusyG2itXzZjWsx14uHVPjkbrdy6hAryhImniV7BzOW3AeodC6bX1EAEAx
 LkOw==
X-Gm-Message-State: AOJu0YwMM2HAHeJMEvJU2/kqnUYTbJVtzIIPdxXSppIgJTXUXAfwZhZq
 cBF2mr1SQMCZ/DgUnVbeaAbuFLfq9fZDB+qhDynRvQ2K14ti4h0MRhi3jlrO/RUMMAa2u1dxtSG
 4
X-Google-Smtp-Source: AGHT+IEx+S6l4dc6AKh3CiOA/ulz+QdsTSUdof1LjlIXnz1HFyEeP/+nWQwkWnEoydOkQlqUcLuosg==
X-Received: by 2002:a05:6000:128f:b0:37d:364c:b410 with SMTP id
 ffacd0b85a97d-37d55304616mr8892131f8f.33.1728911550966; 
 Mon, 14 Oct 2024 06:12:30 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:30 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 15/37] acpi: Add processor device
Date: Mon, 14 Oct 2024 15:10:31 +0200
Message-ID: <20241014131152.267405-16-patrick.rudolph@9elements.com>
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

