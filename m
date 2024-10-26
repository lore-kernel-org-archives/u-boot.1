Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CA7D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C63388D13;
	Sat, 26 Oct 2024 09:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q7wb1/Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F2B88DF8; Sat, 26 Oct 2024 09:37:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB542888D5
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so376597766b.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729928260; x=1730533060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sFH7uCDq+8NalRSHdbNyKfzZn9c469IsS/bAsEo/Kr8=;
 b=q7wb1/QiqBxIWsqe7Tt4Ibo/2vBEJFENOizufpjxpl4fLuHDrkyClbE7fAHiqmZQFy
 CHnCtbOkp9G8TOeh6q4xBwF9rrkvVawsaQh96vDPtlWf7a4PU3S5t2vEdOLjRNtyF55r
 bZyu2ZWf3E80bs5zcMiW9HHRIHhg2HJAr2oRe/ial+Qm72L33H5Qz5KaIZmewpVm+dIS
 6ixUYu8v995U3ogrbE4hldqxH9jIk2aAOBFBBw7DacSyqpR8PR2ejqz5bM+nKhau26R6
 ltY1ilHTF1R7Z6MeUA5/neat65mjtNQv7aKgSGHuUmBtZnIRGQovPBn0wifXbpW8B+kv
 6RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729928260; x=1730533060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFH7uCDq+8NalRSHdbNyKfzZn9c469IsS/bAsEo/Kr8=;
 b=kR7UyGtSGFKJfg+d0Ysmmuo7QH+WauB6TxKADI5OM04x7Bc1OcLz4aM+8jL+UJlCOh
 PDlLs9p47RPfcK3XMIjpsuw9PULbMglcImltlc9IPmCNjYJxDWm4KRDZOTXWQe/s5eR9
 /eGtmhb5dZxYWDz5Vi4w7ntfetQIhajhfPeGKx/uy+WX/eUSw6YZZQ88vQTDT6+pF+nE
 sODD1uotwNtMhfMPGuz4YByGXXln7X3qvtz2VpvzzXxWoiDLQM8GBhjXBSz9+hbSRPE8
 BV2zjgIkY5ObD4Lne1A3IPow0XAOPvdXx1RZeF5E/k2zKwPcan7wut0v4OJGSmQ8udWX
 afZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/5ARaJ9XjR4gyCJQ77zE6pu8wZejb0LQ74doDi24OjJ/fqg01AKeDXPNn/9gZOpMBFWZrvXE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7bjiBLKot8PvOlvlnbk9CZU4zrjpxspH3+Fmx09kxUCPdXB6c
 6BH3bt6hlbV4zOcXWZWVI/OCQa5jZXQL5Zmsdm0WNGlgQKcwYzaVo/NlSf372vA=
X-Google-Smtp-Source: AGHT+IE9WB7LWp1s6UtIFIT+ZbMEtbnDMVwbiVDW7PIJJrZBwW/jwr4ZjavRmu8AJ+EMlZ0AO0Lscg==
X-Received: by 2002:a17:907:60c8:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-a9de61f5a6emr119664966b.59.1729928260151; 
 Sat, 26 Oct 2024 00:37:40 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a08478bsm147413166b.199.2024.10.26.00.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:37:38 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Mark efi_bootmgr_release_uridp as static
Date: Sat, 26 Oct 2024 10:37:32 +0300
Message-ID: <20241026073734.102723-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This is only used locally so make it static

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a3aa2b8d1b92..f9b5988a06ea 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -385,7 +385,7 @@ err:
  * @ctx:	event context
  * Return:	status code
  */
-efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
+static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 {
 	efi_status_t ret = EFI_SUCCESS;
 	efi_status_t ret2 = EFI_SUCCESS;
-- 
2.43.0

