Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723F8CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9055988DB1;
	Thu, 26 Sep 2024 10:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Ny1h6oxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CACF88D75; Thu, 26 Sep 2024 10:02:54 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11FD388D7E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca6603aso641248a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337767; x=1727942567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r08313roRAmkuW+3ysCcdiZB+Ogq9tcIZk2Ds5uPYak=;
 b=Ny1h6oxDIpARy7/f4EMMONm21gxYJZfV1cDE6xeAKh5o+dqUzbZeQBbUY/IeR5fNLx
 IknCLVVM65ReIsIbzXYCAIgAYoh4HsLKX8Rt1k07fhcZm5rsKVKFBW/YRu1PvuZqKrOh
 q2HSZl9NkVLjkXKOUfxTRQL9RpLGWBAn/fmmwPDUESM/xCVnrmQnJQr6iB/SeJpeaDQ2
 WdrPm6LZO5DzMOg7IG8/8q7ZpQxZsgfqcd+R8Zc4XCK5OIbSXvzDsO+dbrWvL+j/r/r7
 g+Z4fHoWe0UT4H111T+cG3NWDAPd0iYJUtYakM/ckkfqTGZKOBesRckeZ5UzB7E/KoHv
 kntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337767; x=1727942567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r08313roRAmkuW+3ysCcdiZB+Ogq9tcIZk2Ds5uPYak=;
 b=Ca13805V70942O/TnavUOABmCPTQz14lPzzvikZ9TNIITWsQmf8fmo1no4vAs/o7XI
 LgBuiD4JGqukes5m1HNp96/EMvELkJNBKqbqCm6kfMNOhVbuXurIXSVj+FLWr6uiZqjS
 W0S5DwzqND49VXJWJADU9jaOlwpe5YZWg8224FOEBKXYtdOgSE3Q16ns9b466fTfuMXG
 yQEX02q+rvUmSm6Rd+WPobeVjL3x08prmHVknBK27H8zlkG+6iPpO+dRxDGLHwjXdYXL
 6/aCly41OoaG9zbT/rQUPN1/lKAIkwi2dMWuMBMqF9a4ZJgEOuKf7bCoTAN3+x+Zl2IK
 zXzg==
X-Gm-Message-State: AOJu0YwY0r5eD//G7U0J91+NYrhvBgxC73oW/Eaht1ov5JVqvqUa+7Ih
 8p1F5UywZ3cYMddFoW88jolwJCO229tr+ZpPHlYgBdzqxXXfJHmb2eVZB0IJSB2QLNntLTxO8QM
 U
X-Google-Smtp-Source: AGHT+IFbtwKPjrQ5/nDXkpNK7gon4/mScH5fK3ewZ6cY+yS0pdvxCk+KgZMJGJmyDFgrJPIoRAgG4A==
X-Received: by 2002:a05:6402:354a:b0:5c5:c059:63c6 with SMTP id
 4fb4d7f45d1cf-5c72060a617mr4160108a12.2.1727337767315; 
 Thu, 26 Sep 2024 01:02:47 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:46 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 15/36] acpi: Add processor device
Date: Thu, 26 Sep 2024 09:59:03 +0200
Message-ID: <20240926080021.148031-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

