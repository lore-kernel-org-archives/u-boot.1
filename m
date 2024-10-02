Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA0CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF6B89043;
	Wed,  2 Oct 2024 11:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bTyXI3XZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1CA89057; Wed,  2 Oct 2024 11:52:07 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1CF288F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37ccd81de57so422652f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862725; x=1728467525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOl/zHDv+NoSeT3rWTl+kdkv0/0hEtgLzkQfuKxb4/I=;
 b=bTyXI3XZihjjl9LqWKOw6PvWuhYH4yyJQeetZHMEY3ISqG2wl/xC3sAwZr9AV8XgXx
 U3i8cgpz8oTV2JhSqqqll0Kcf9q+IriShxVbBcqB6e8uNoLxbFKV8LWm586TeutWPgEx
 vZIHbo0oG48+E2ST5o1swACgWm/wEtNGAKJfEsr6NyAItpYjkUHO1gvOG6Z24v0DHgnx
 WuUGJF/2KAEClyUctzX9LYwbJDt7AO1iB/91MfMbHc7vSVk/YtB7FG1ZGPEnxZ1iRp/Q
 7k+Gd1S1gq2O3ISLbzLwdW9jXMNm4JcgaUO0IcYsr7BfotEB5sJpB70DnHMmzPnbR6XC
 KCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862725; x=1728467525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOl/zHDv+NoSeT3rWTl+kdkv0/0hEtgLzkQfuKxb4/I=;
 b=vQXpftzSRnglgSJKx5cvLcJgz6AMZZzp2IUWJoVkve6xtzon3L35hnhZjUVBKnKjgg
 +BNJQmtcBW8ahWVPgmCF8HT3YVMfv3Vm0aq0A3nBYCb2Ex+B3eDHa8COcUwY7pwOWJkN
 Yoz0SgbwkvmDUa7DQauyUx5HGtt0Z3Klg+/8MeRXdm398j/tDN3TAUVuUHi7m9/UMjfo
 jHuo+ruza7R4AEXScaKQLwP0z7tqsOsoPXzm1UkDvsDC3cT0adHU9z0IEsvh0fW20+tY
 oOD0kEgQcb3DypS36Vcv3Msi5vcudMZWLe3zwRBXPXc9iaLmc7rydsDWOojZDJjq1tU4
 /ZWA==
X-Gm-Message-State: AOJu0YwarYwPtqyaJSulsmP4lCEgU4XCDYW0Gy0rNUqRW96XUpm0drtU
 JLTcAdYCOB6M6o6G6Cejd1OIU1KFyebIXPfleELkw6/Qar9mjDyXahY9BEfRGhBg2ia8rcRwOCX
 u
X-Google-Smtp-Source: AGHT+IGo2BWlW6xta1Vhb33UcA3inoJ2JhkOmLtUfMuO5FuSSgXl7+c2hhVB4nifdaX05j5IzfGyxQ==
X-Received: by 2002:adf:fe05:0:b0:374:c33d:377d with SMTP id
 ffacd0b85a97d-37cf28d67b7mr3235426f8f.28.1727862725227; 
 Wed, 02 Oct 2024 02:52:05 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 15/37] acpi: Add processor device
Date: Wed,  2 Oct 2024 11:47:06 +0200
Message-ID: <20241002094832.24933-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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
2.46.2

