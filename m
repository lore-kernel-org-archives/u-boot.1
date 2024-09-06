Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E5CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88FD88D13;
	Fri,  6 Sep 2024 09:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gZvPMz1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0A288D82; Fri,  6 Sep 2024 09:22:55 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE0888D3A
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso2110905a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607369; x=1726212169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcnffxIAkZ1BJZYb6zAIcTKhWWRq8S0LiIS9LyCWgfk=;
 b=gZvPMz1A4kDMenf+mZYqFcv6xzjJBPtwPELCmWqlnEtKTpoOUgDEw4u6UyvZjiIZzg
 PyPulxHH67TBymVb0F+dsJO71Ky0IcEZ6LgwQQjLlZ3DR8nbro75vFqFvaQCugEQ7IGM
 NVTzU+y/ciMrXDo29eJCABgNqSbcWyCu+Vqp4r20cjTjrv1UYdNSmEYtulsvYQXl/WTT
 mwaiu6Q6lDTLqcbGiDgpfDzAUURckIzVQfcZr2pkOtlz0Pg9rPDY+8Dq2ACJ3wKP5a5Y
 BM/x1H/iva5TVK5NntuH4c11oEyA0BdSltTOdVdycdmzyuSr/gTFRjd6h7EePCrycMyy
 miFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607369; x=1726212169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcnffxIAkZ1BJZYb6zAIcTKhWWRq8S0LiIS9LyCWgfk=;
 b=nhM2BibWEfXToCGDp0HdfQ6q0fm835JEzLz1uw4jKimJ8U1kS7Le2mXztgQrhXt6+N
 tHlqKHh5o4B4CE44YD4k0wzirKhbrxcZq+PYq6+oDS6Lrz91xY99ioZAFD3A4tVXx9YK
 01SEOD0+O6Q8E9EYZwAddb5hy4kO2t9LMZ1yMcyMhnEO2rhkHrrlVfeYz8YVKcyU8OQk
 00iShnBII45giFnHexSUx4Wn7YpQ/HfPTjWipeVjOIqYvWzAeVLnPqs7Qj9fPAgzttPL
 uhelxHT+MLP2i9EH7O+2pqaB/YWPwuCJ42Pqe09u5KnUY5UKt4Dhz3nEG+MWZz/lYyck
 WzlQ==
X-Gm-Message-State: AOJu0YzZ+1yd56rl0D3eCJq/4BjXUFPYsTK7zWDaT/ecAsfhF/M4gnXR
 pBjWSfl7+wXC4MWO3v5xYxQoXmxkHjSlDqtCIUpk15vUpBfox7ThpjA9hUELIqCNt4AT7BiL9dg
 O
X-Google-Smtp-Source: AGHT+IG0FCaOqZ0ECRoHpGgcxqsEJkuKlqvrLmji/wmUuhHvM1h8kewvRa/XSRJPq+dTmxSpemZYbw==
X-Received: by 2002:a17:907:7b8b:b0:a7a:a46e:dc3c with SMTP id
 a640c23a62f3a-a8a885f3f78mr123463866b.15.1725607369333; 
 Fri, 06 Sep 2024 00:22:49 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:49 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 15/28] acpi: Add processor device
Date: Fri,  6 Sep 2024 09:22:17 +0200
Message-ID: <20240906072231.2531491-16-patrick.rudolph@9elements.com>
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
2.45.2

