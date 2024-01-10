Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29922C47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AB287AE7;
	Wed, 10 Jan 2024 19:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7TtPN6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFBA8792C; Wed, 10 Jan 2024 19:46:17 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C4A8792C
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680c7cf2ab3so30178856d6.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704912373; x=1705517173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m44TS+rxo+bpTbWzo/Amc33hoZJYPHTnGis2ix0LFQ0=;
 b=t7TtPN6emlirgqOC49S6FIgzlX8TiZGhUnvappvYGN14Aq6LpcjuwJnq5mwoKcpjeD
 PEiK31QWgaJfZaj69S/Zr6/DiI2M98sx22Ovlza3idTCg8msDa4gvYyBIbTGiS/9UuTI
 fuunoyJdLRGUfOp6h9QdAKQN+SWDr8cIcTlvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912373; x=1705517173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m44TS+rxo+bpTbWzo/Amc33hoZJYPHTnGis2ix0LFQ0=;
 b=apfCTL6ZXhqXrW9hvzJBinR93aEr1TgjhAwfavfCE//uatWd1JoJ0R5Q4A8nc5buAs
 NeElzl3m9tNEPqenXCWJT0+NF9igdpGW3Ab2B5/YGyuLpJvyp1zZcdWwNrp5MtPOwxYg
 Vq5cIbhId8hxk/dbPd+b0arMlRGsZZWnsrvGkFNejmU5N//AUyBXUx6uyBrjzscWQvTD
 9RUwRSjNk8p7iZEQ8iEBFd2kwieYSEXos5nJ45W1QmSaQseFih5WFyKXEy9GhXbm1hmb
 Ure8YYRebLfEt3tGqMmJHH8ZGDcKyEIgHEIlkY54rbqm/G4pFQc+Y3/Mcb4XS826Zbxu
 Relw==
X-Gm-Message-State: AOJu0Yxo5TGcpt6FsACeplLTmAEHQGbbOyG/LEnuQtnZtYAcf+CbvCK3
 G2m8R4H7BhggeDJNkTJ7Kfh2LvJE0/qfYAvmmBi5B2/k7Uc=
X-Google-Smtp-Source: AGHT+IFhjdSE9eUEj1qv4BJJBcbAeuq3Arsh2K4OXQsbwlZK9/49q6YuSQPELcSq2vCbcQ8qQMfIlQ==
X-Received: by 2002:ad4:5ce3:0:b0:681:1888:9670 with SMTP id
 iv3-20020ad45ce3000000b0068118889670mr2141451qvb.18.1704912373086; 
 Wed, 10 Jan 2024 10:46:13 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cc60c000000b0067aab230ed9sm1887979qvi.21.2024.01.10.10.46.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 10:46:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] env: Make ENV_IS_IN_SPI_FLASH depend on SPI flash being
 present
Date: Wed, 10 Jan 2024 13:46:08 -0500
Message-Id: <20240110184610.3909763-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110184610.3909763-1-trini@konsulko.com>
References: <20240110184610.3909763-1-trini@konsulko.com>
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

In order for our environment to be present on SPI flash we need to
depend not on the symbol for a SPI controller but rather that SPI flash
of some sort is present. Update the dependencies.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index f5f09692332d..7885c8bf8311 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -342,7 +342,7 @@ config ENV_IS_IN_REMOTE
 
 config ENV_IS_IN_SPI_FLASH
 	bool "Environment is in SPI flash"
-	depends on !CHAIN_OF_TRUST && SPI
+	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
 	default y if ARMADA_XP
 	default y if INTEL_BAYTRAIL
 	default y if INTEL_BRASWELL
-- 
2.34.1

