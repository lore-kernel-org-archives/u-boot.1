Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14FBC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB90487BAC;
	Thu, 26 Oct 2023 20:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mc16Oyns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29E487641; Thu, 26 Oct 2023 20:31:59 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E85A875C6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-777745f1541so98543785a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345114; x=1698949914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/0n44yy2ftK4uX/Yr0zfrlRSSze7UY5xUsbdhotmXE=;
 b=mc16OynsC5rUXqfkE0LlMKi7QwYtFZ9j+MbnCJfRQoeIJRfBlEDnr7GALHODanxCxt
 bWHRyyHZ1VXIye0L+R6oHjerCElOshKHuav3z02TE5a+vCKDQZhcU8YGZVbL+I+8CAHo
 dmnSEKqqCO5g2GuY0d6ZQCDYrRDdEE1mGVK9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345114; x=1698949914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/0n44yy2ftK4uX/Yr0zfrlRSSze7UY5xUsbdhotmXE=;
 b=bhZsEWLRNgVBmHS415UUgYqPt7adIqRlJ+g+fcVXIW7csx8GEmp1bQaCDIxtcmfEO8
 i4N8sMNqRqOKCb9CYI1jeV7jUlDl/k1KM+R28XdH7Y9YNdiNcwZsTzjuOADe+SdsvszG
 1SfBSBtRGRnjDDtxGf20MxFKy0HaVVsqIMdclvM9GSHCqKA+BC3kkRuqY52En45iQ2oG
 i9ygR5bI5oG9x2ZsmIlqZKD479apIECqi5R/4svxow592IM8f0ztcxxNR5kdTmyZaC08
 qGzW4gzmuzAgZmZ4RUyT18RHbsLyy6sTDRMOVDV3Zr4PwDSWvhgNCRUCJtaioqOmaZVb
 wCRw==
X-Gm-Message-State: AOJu0YxJOVo+NtXZo1G++lccZeBddUyyyezC1UW87mjMR1pcdBAcnRww
 epgWNYpnFgrhlnYUNKxI5e7Sk9KsGnLU0fPviXGRKw==
X-Google-Smtp-Source: AGHT+IFB6LkEAxfyB71WDIielWEmLtWjS1z2n/T3iIg6R9KyQz3dBbifzfNHz/85ciSZ0mpWfysUqQ==
X-Received: by 2002:a05:620a:44d4:b0:775:7c53:c023 with SMTP id
 y20-20020a05620a44d400b007757c53c023mr141692qkp.18.1698345114687; 
 Thu, 26 Oct 2023 11:31:54 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v5 18/30] bootmeth_cros: Require bootm.o and bootm_os.o
Date: Thu, 26 Oct 2023 14:31:26 -0400
Message-Id: <20231026183138.636948-18-trini@konsulko.com>
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

In order to use bootmeth_cros, at least on non-X86, we need to be able
to start any type of kernel that the "bootm" code paths can handle.  Add
these objects to the required list for this option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Makefile b/boot/Makefile
index ad608598d298..3fd048bb41ab 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootstd-uclass.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootmeth_cros.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-- 
2.34.1

