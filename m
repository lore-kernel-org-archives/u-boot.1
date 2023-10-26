Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E82C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6205687BCF;
	Thu, 26 Oct 2023 20:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="taOngW3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE9287B9F; Thu, 26 Oct 2023 20:32:05 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D64C87B77
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7789a4c01easo93194785a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345121; x=1698949921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/+Dw5slmCFCkhM/oxo99isZPNubO1SEp5ez3sWcVDY=;
 b=taOngW3d1KD2BAc2hZZeZbBuTOhE6MzAs9IMdMYyWxGjKSOr9B6EY7XcUoZjpNs+Us
 /nnRvfxP5YHGboXqPj5ZWIYE7lfh/eU4/Ej+cEysQh07o+OycxULU9MTLv0nADyOVIWt
 XyhxIQm6g1wVgtvcm81tghQfT+TqgF7Q1cz6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345121; x=1698949921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/+Dw5slmCFCkhM/oxo99isZPNubO1SEp5ez3sWcVDY=;
 b=nZlVW8n3cFSVx0o70eDA7SMAnPWsOO1iMZXo9Kl5lcVypIsfDovijE/OpPwCi1d17x
 Joz6aBIUOyerRINab6u9OdmMasncNLzwVbFguGQea6Nx9Zcoai+iSwLkkp+UUvLukqcA
 1aD3sZ2UnBfjbiIUyLoqlF+9mj6uQICBYwxg/u1cDxAkH1PidfHDTgXYmj64jdcMcY/M
 kUoBfDzJ0LTXr8+lF6SLeKzAyhIRDIrPqAyUUCjZcN/Vd2R5VWqMpas+cqA41PpfGP4X
 IQfqOSR3fF06RwjXbDHDePn4w7QaIFPWEVIWH3PDPYSs6YiA83i5Rav/kCopTV9Xd1mo
 T9pA==
X-Gm-Message-State: AOJu0YyJWwE0RerP6laMVLLco1QCA3qrLUHL0E/zc54yIxsq+MFrG/eQ
 4KNI+3ZzqAejaMYfpp59Uk9LPjumHmpHJASCm0+bSg==
X-Google-Smtp-Source: AGHT+IE1f5aoSeJBglUkwJ3XBnIPYq0Zv2QC1KLbpRcFOxSyYSiWr09hjdlCN1OgWs0Rvpuj9ikdIA==
X-Received: by 2002:a05:620a:3916:b0:779:e75d:e80e with SMTP id
 qr22-20020a05620a391600b00779e75de80emr158143qkn.15.1698345121541; 
 Thu, 26 Oct 2023 11:32:01 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:32:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 26/30] sandbox: Avoid requiring CMDLINE
Date: Thu, 26 Oct 2023 14:31:34 -0400
Message-Id: <20231026183138.636948-26-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Add some dependencies on features that we had been selecting so that we
can still disable CMDLINE.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v4:
- Reword the commit slightly (Tom)
- Rework overall to select if CMDLINE

Changes in v3:
- Reorder the Kconfig options a little
---
 arch/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6fa17b21b8fa..1cdcd1fdb8b0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -134,7 +134,7 @@ config SANDBOX
 	select ARCH_SUPPORTS_LTO
 	select BOARD_LATE_INIT
 	select BZIP2
-	select CMD_POWEROFF
+	select CMD_POWEROFF if CMDLINE
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
@@ -152,10 +152,10 @@ config SANDBOX
 	select PCI_ENDPOINT
 	select SPI
 	select SUPPORT_OF_CONTROL
-	select SYSRESET_CMD_POWEROFF
+	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_EXTENSION_SCAN
+	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
-- 
2.34.1

