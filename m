Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2B8C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15044885BC;
	Fri, 21 Jun 2024 01:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I2oXj4WQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE4CA885A8; Fri, 21 Jun 2024 01:06:51 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA728855E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so56531539f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924808; x=1719529608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=I2oXj4WQ3tZwnoYg9jnsrObsO31Z/EE4YS33SX7DcrVWVrZfebOElNHyTzBVKnpSFA
 QkxBTudmBwIbyttUg+nEuRFBPO2clE6qyLmrE1FSzEGUIT6qCqeGTC9brBkr4plQSR66
 MVHpr2Ps1XLj6hiICYQR8Sn4Y3tYj8UddoT3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924808; x=1719529608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=GikEO2SskyktbTqgcU5TbR0zX+PptQEEknk6gi5DlVub4dzGkR+HeQDGG+KlIrx/G+
 FvWDcshn+a73g0bojrp4YCL+CgGbhnFS78QNGI0AwZhfJ9QWU9hi+7Y/7hKO6xxeMjun
 YAl2OzEVDyj/YlwalQkUL/CCr/EaxyA+AOCalhRrBPi1VDpzUEw+3cfPYblKzrmyVNlb
 qoL2/CxbN9utBRSMXd7VEo+Bpv9VO827fqzUTtPmgU70muDicTdWIAm4ArL+tz+ZL2/t
 5TNqqwgsZ2vlXWOvpMRD83bkSdKIUZxqwVRNMBtTXsPu9/TsStSFw1JnmFxEWxvSYmMm
 G8rA==
X-Gm-Message-State: AOJu0YxTt4RyTLs+EMKw6pSgzDBEsqiF93E32wsDZR+IiZgeVn2S4fzc
 oR71bvjpZCxXBf/xmMrNf8V/sumFZpRCzc2jc8JoXK9HljcbcJRjYfSzHvm9y9L2Zqaqib0JbZU
 k9Q==
X-Google-Smtp-Source: AGHT+IEgRhCTfLirSQl8kT5LwzPNNCVPgu1rGZkm+P8aGilIPNczbWGB7YYINX69ujsbdwT1bWP5MA==
X-Received: by 2002:a05:6602:6d15:b0:7eb:71b9:fc8 with SMTP id
 ca18e2360f4ac-7f13ee6983cmr742120939f.16.1718924808612; 
 Thu, 20 Jun 2024 16:06:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 14/18] spl: Allow ATF to work when dcache is disabled
Date: Thu, 20 Jun 2024 17:06:21 -0600
Message-Id: <20240620230625.1797397-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

The dcache may not be enabled in SPL. Add a check to avoid trying to
use an undefined function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_atf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 3bdd013a35f..9afe6456bc4 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -204,7 +204,8 @@ static void __noreturn bl31_entry(uintptr_t bl31_entry, uintptr_t bl32_entry,
 						       fdt_addr);
 
 	raw_write_daif(SPSR_EXCEPTION_MASK);
-	dcache_disable();
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
 
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
-- 
2.34.1

