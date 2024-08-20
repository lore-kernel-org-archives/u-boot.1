Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7B0C531DF
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 09:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72C888A27;
	Tue, 20 Aug 2024 11:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="njgPf3Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B003988D74; Tue, 20 Aug 2024 11:38:45 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E6988D84
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 11:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3dd25b2c3f2so2113662b6e.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724146721; x=1724751521; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRLz/Oc52uMf3BeRaXvVBkO671x5MoOqImmzsZV6I0M=;
 b=njgPf3Q9otmHAAYTxnz0yi0s8sSyZ7jZ6HeIKZiOvQJSVxKV+zr/7c6msl7emOKLY/
 DPL0t/XJtEdvUlIj2YEAr3VKcU9sqIDW4XoiRya5FmSiLwkzXNsb+9i0UvHqRChb23ov
 gzRfzARqKvQRxUYcshYr2SApSZPRKLhy+iTDBsFe+E2IWdQPMZMP2jf2MxtdFKX4hoiu
 FWWaJQbzVfywujCsyjAjOSsm/LWWl6HOv42q6hNnpbrjMbkIvuyeKDayk9m3vjOEl102
 mvrPupWIXo0J497ovx3sB6fx8hjBXHzmTOEMNYNk6qQ3+ZaDlbvIsoxzfWg0JkjjOSSh
 dxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724146721; x=1724751521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRLz/Oc52uMf3BeRaXvVBkO671x5MoOqImmzsZV6I0M=;
 b=DK0v1yZvzV0qPESJPauyNgg7K05heQM7j3aTV5uZqw8uzjRC9pQHCzQ6UNl7F1/WM1
 jVo23NWVdj8fF7lAHpoSrwSGmMMZ1eTzECCwIGkHMmFtjn2fAuxD5NL9zjJvW63zMov2
 WySLXtAB1xojq89NUc0yH0tDoqSE3KKfs6dRskxyDo10BEDN4GKb2Hg+uEMJVQrxq7oj
 2Il3OrQ8Yp12dl6axSoUWIowUHPVrRW1qxnWVP51zbHm5BXFC4tVrMF1KR96gT8JXluD
 AI6kRSSRC94DtecF7FUM2twlquH1CIEF+aUyHz2lG1wwTHNEO4KyXUn4hrhyHWODXCnq
 Em2g==
X-Gm-Message-State: AOJu0Ywk7M0Gq/U45vp55wVM4i2l/9oAjVVuifTQwqYjn9Ylq+vBh6Mp
 itUNjSjb9sNcZ/G52/vCG+cQt/NuH2E2FqIQUyBEKFQNXWL4l0+NINwKA6gEB9Ty8XQ262hegYQ
 /
X-Google-Smtp-Source: AGHT+IHkIAc+HbMJJ9rI5rc9ClaUEiutFSjGj5lCjTuH4DjOhkz0u7S6sW5VmHG4sD15l7F42kHd0g==
X-Received: by 2002:a05:6808:1597:b0:3da:b336:7151 with SMTP id
 5614622812f47-3dd3af64f83mr15569263b6e.40.1724146721494; 
 Tue, 20 Aug 2024 02:38:41 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-3dd33d3fe91sm2795674b6e.9.2024.08.20.02.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 02:38:41 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v1 3/3] board: qemu-riscv: Override enable_caches
Date: Tue, 20 Aug 2024 09:37:52 +0000
Message-Id: <20240820093800.5436-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820093800.5436-1-mchitale@ventanamicro.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
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

Define enable_caches function for the qemu-riscv board which probes for
the cbom-block-size dt property when RISCV_ISA_ZICBOM is enabled. Also
add flush_dcache_range and invalidate_dcache_range functions which use
the corresponding CBO ops.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 board/emulation/qemu-riscv/qemu-riscv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index e5193e31e3..1795d2f831 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -14,6 +14,7 @@
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <asm/cache.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -70,3 +71,18 @@ void *board_fdt_blob_setup(int *err)
 	/* Stored the DTB address there during our init */
 	return (void *)(ulong)gd->arch.firmware_fdt_addr;
 }
+
+void enable_caches(void)
+{
+	riscv_zicbom_init();
+}
+
+void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	cbo_flush(start, end);
+}
+
+void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	cbo_inval(start, end);
+}
-- 
2.34.1

