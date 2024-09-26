Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B4CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF2A88FB0;
	Fri, 27 Sep 2024 00:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KANSyyp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CE088F91; Fri, 27 Sep 2024 00:41:03 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18B288F75
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-45815723c87so12643101cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390460; x=1727995260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/MIu6+DvIvySMhIANpPgq+/quE+x8Fh9Pu+pcdl9mE=;
 b=KANSyyp1Int2CkKlbh8kVbXQS40LTfiM980UKjb7Y1+VzZ7Ljxa+wX9I89roVcnmzE
 k1jhacCaVLpuBcrlTDtbyCUEO4Z9DdNUeUDp8LQ2WKWn+FM7dhXRZokIuxiJGhFWc2G0
 7j0KP5tZrSC9ryENLK7gNWG/YfL2UbffJTAtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390460; x=1727995260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/MIu6+DvIvySMhIANpPgq+/quE+x8Fh9Pu+pcdl9mE=;
 b=B/JHyjcgPpxSTRfUqKZV3QJfwWjb29wT+lE3fHG1wSrpMdF0AxqaqNBDZWpWuav4Q/
 rgDvdPRDYCILkWt1FFWrFHG+Guh+pnV6YQgY4ZiJfafCMM48fGTIcoFvlcK3E7KJ61zT
 ArLLB18Jg6NEtdzsXCRgHJ9eIatCywU9X4L9qNYq/G8y6zrTAK0eq/eA12rI4hOfbagV
 y+iN76IWPol9m1mYb9a/norSav3W1fo1kAjmXBpu5wIjIX4GdT9FAtEBpmU51J8RWDVP
 iwxGqmF5N3ggUiOPa0moToUk9F02m30IuVHiWy8TJz7g/+Y6hsGfS9eGfuDVIPiBmzHb
 silA==
X-Gm-Message-State: AOJu0Yy2TxT96/VZsEjNxucJt/3OjfxpxRiGiZSCbUUctGCKa73cWp2x
 9IR4POJTOPTxfcAkPu0jufVmp5kpgy/cBk+/UADE+MterGQ8qQbu55NZ+rSxuNb5Po326OCG0yK
 LKpf1MR4=
X-Google-Smtp-Source: AGHT+IGqMR6kyq6gQ+JVeJW/88x3o+AgpJmS/0Ozi36993ezoQ7xhzCclBndIqGwnqQ5RFLdJ50RPg==
X-Received: by 2002:ac8:7d0b:0:b0:458:27cb:a5e4 with SMTP id
 d75a77b69052e-45c9ec764b9mr28319551cf.1.1727390459716; 
 Thu, 26 Sep 2024 15:40:59 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:40:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 08/42] x86: Update a comment to mention XPL
Date: Fri, 27 Sep 2024 00:35:33 +0200
Message-ID: <20240926223814.1276764-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

This uses XPL now, so update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index fbd23af6ce9..ea11b09eacc 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -247,7 +247,7 @@ static int last_stage_init(void)
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
-#endif  /* !SYS_COREBOOT && !EFI_STUB && !SPL_BUILD */
+#endif  /* !SYS_COREBOOT && !EFI_STUB && !XPL_BUILD */
 
 static int x86_init_cpus(void)
 {
-- 
2.43.0

