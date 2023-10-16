Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C799CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B0C386E11;
	Tue, 17 Oct 2023 00:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AmG+//Jy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC2686E11; Tue, 17 Oct 2023 00:32:14 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9486E37
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-777506ccc6cso234405385a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495519; x=1698100319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcUfBsrY5qpvOwpHFoiq+dgCocPub4fQAua/5fgTArs=;
 b=AmG+//Jy7MlB67+gkGXbzyyGw30e99izbV0uP0eGw1gp5bD1E5VNxZxU3cNQbif4gp
 sOlkYzAHm6S20C/LNQRHE9JNg353zOXLlmPuf84klJ7F0+5kyo4yD5QPBwLUUCzsNoWD
 XXqjjpkorrRO8Ge0iT6OMcUFvG0wM5jW7DLW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495519; x=1698100319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcUfBsrY5qpvOwpHFoiq+dgCocPub4fQAua/5fgTArs=;
 b=qyfEUL+1c1p/5TRgDwrZJRy+wqxQamv90nSZxQsQoS8IW5RIrC0UjVB4h/pUgZjIyC
 yFK/OTGBQ3FFPLfkkpPZtVLRnMXsCg+PnEfyulMGj0vs4BKUCJa/gUsoC1sOg/h1FnKj
 8XgdrW14skkabPWRLOkNYdUf0t9FNkPj2OPFSfmIiBOeHi9/+L+2CBoH7mKKcY0psVKT
 TnRyOaGUxi7iEoTg816IT1ZzBeXDAEc2xQ5rXQAJjWLSDUXj9m9JrlYguij1SvovfgPn
 PCHEkig9BfUujEWqX6VW68NP6C8HfFCJzdepbBuuSeiwZtiD2L69GVn0YnAK5pOGfxcw
 Jqrw==
X-Gm-Message-State: AOJu0YzvfQimZ+seYLBnlJpyDHPzvec4ILlAIFGQJdUzUSckGJCdWPkJ
 SNuLpQslWUQ3eNq18eeFU+Gge7gtkL19Oq1V7cOXSA==
X-Google-Smtp-Source: AGHT+IFeo7XvZWcLqLi9gi4fj188PiKTxXn1CMaXeSMbLEkP9jlEWZ6gkcIjtB4lAmxUloJBtspaHA==
X-Received: by 2002:a05:620a:4045:b0:775:6a78:5f9a with SMTP id
 i5-20020a05620a404500b007756a785f9amr568641qko.6.1697495518786; 
 Mon, 16 Oct 2023 15:31:58 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Date: Mon, 16 Oct 2023 16:28:13 -0600
Message-ID: <20231016222835.596572-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
available, add it as an explicit dependency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to update EFI_LOADER to depend on DM_ETH

 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13cad6342c36..fca4b3eef270 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -11,6 +11,7 @@ config EFI_LOADER
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on BLK
+	depends on DM_ETH
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
 	select CHARSET
-- 
2.42.0.655.g421f12c284-goog

