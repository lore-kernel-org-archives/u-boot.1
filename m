Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB41CF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC6E8933D;
	Wed, 23 Oct 2024 15:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Hxan6UWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212CA89308; Wed, 23 Oct 2024 15:29:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15EC892F4
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314b316495so66210505e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690136; x=1730294936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=Hxan6UWcf23Q9kuwJyEX1808osVn/778m4XM2nwgyFQieiI6Oxj8khaZ/X4CKn9Lxg
 VQN0or6PS6oXIl4PN9q4QLAsSYadZp5t8RaM4Tid/79QSHCYdDrsUbN21dQOrJo60etq
 UkwWHGPE7YiITZzzL8vf2uZhfRAQnT5Jyh3iXOtXOmX5xGPd/In1SgEwYP/QGDFNFm1/
 5tREnZCw14lI2lhsQsr5cedyrsN55MtXleJHuLcl+GcBw32WSDYFoT3nsGwcq0CoS1DK
 AqdHNxj+5eL7G32D3pIq9x2WTpjhuWzZuAO9Sd7SjCgqzPnzvMCpswUPISl6xkLU311k
 YPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690136; x=1730294936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUSwEThMcuBbj+N1L6I/K35sdbHKZ32fPMo+DGkXuf8=;
 b=YHbPAAlDzzmOeFYwfwmx3OTRPwxnbUxWrqml0EycnzKNlqiB9Gp/cnin+NbgKyktxW
 VbIB1D6zrpvGGthNqgQ5uWzFY8amcoZvfV6VZ9WItdJ1Sk1/7iy+sVViq2V74QCjLnbD
 DY+KWxYMc9fLZUaGecOyae6WdGdT6nV8ukVZcjMjU1A/DvA2qGTrbunznKEymOAlliVv
 yt614/Stynn7pZP3O12El/Ly/OvFm5jhH5uf6NS0HWxB2Zuqoz7cJXWDwT+lvdstafrw
 HsO8z4wqxounM7fqtONGEaqIhZbcyOK5DdYboSuoV3juVLmuU4c5AdRr/ryFhdFgTf8R
 Ebuw==
X-Gm-Message-State: AOJu0YwL645oR07Ps2eGMEDahcBG2AbMgkgk/N/vJZ3GIAA7JK2GgDgG
 JRVVIdwIab3kDD/X6n3etvLD/NwEME/09PocxL9hv/K3iqfZ5iBfkmi2bGndnDB5L9nO9zaNEvg
 M
X-Google-Smtp-Source: AGHT+IGE4hEHHqiaBs6KN0pJ5PmsUIFEwIJnvrdxcwBhNnGyifLR+uAUyHB7y0lQ7XmNnkYvfz2B0Q==
X-Received: by 2002:a05:600c:1908:b0:431:1d0a:38e2 with SMTP id
 5b1f17b1804b1-4318415eb6fmr22252275e9.21.1729690136199; 
 Wed, 23 Oct 2024 06:28:56 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:55 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 15/37] acpi: Add processor device
Date: Wed, 23 Oct 2024 15:19:58 +0200
Message-ID: <20241023132116.970117-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

