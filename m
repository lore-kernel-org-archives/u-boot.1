Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9666C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97531885D1;
	Mon, 10 Jun 2024 16:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AeJnPGyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1AB885E3; Mon, 10 Jun 2024 16:59:47 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B9C885AE
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3737b250ef9so17181205ab.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031584; x=1718636384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=AeJnPGyGkZz7F3ykIKwSz7/rB048uh1ke0ayBMhteniaAY+AwXhj2BR4jWn2cNc9ZH
 iR8xFhinvgR0DEaLMzu0kUvM/ecR6bJmkDFkz49H+21n+0Uf3toWL9IWFYNi6ZIGBLZm
 rNUQq0k54bOzVGiySpt3Z6Zr/HfzlsjJhn07w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031584; x=1718636384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPDTBpVZuVkaqULrtYe8FXz9i1e5MJHdje88Wa78OmY=;
 b=jff3RqPzq16p6DxPy9lVPZ81UbL/jKHeKlxTBhMQBu93o9WpxHT0QLcCZGTnnLDMFQ
 6IgCW9JERFWZsA2/fOEQweo1HAFl/mDOI3w5rbmVHE7jSUodqNoRAsijqEvYiYSaC9Kl
 x02oFRXU3GfxB/76cL222E7q9rxfwwCwtlXfMIYRuK4uIX2KI0aLPcVBEzrbkbdLq6tq
 qwTkJ91WSzuZ24/bmMJzTrvIjdNSYxVaCRqnmI+Kv83FD0U3hapmOVbxHsMsax4ZjcUJ
 ErLQQlCihfFQSZfw9vwTSMnMkyrEOGkfkqzeBTr02SBRKZJqD4kM4YV/O7ZnWB0hgZzh
 DCJw==
X-Gm-Message-State: AOJu0Yzp5UukjAlgevIRZIls3q0s16MmUZR+PK5VgrocGYCLf1GjdFg4
 +HktmyQKw4Ab+PnDtG4Uo2d8ILRK5Tdy1ypa5EdFYZT5col7/fEVlzQu+Emvuj4axJQOfLm8f9p
 QWg==
X-Google-Smtp-Source: AGHT+IGjfcIlCDIZU8m95EPywelmP3jziNKiBLCVP7k8xK7TIqy+v2rcYZyHcFrMbnr479YfSWzV0w==
X-Received: by 2002:a05:6e02:152f:b0:374:b123:1b8b with SMTP id
 e9e14a558f8ab-375802fd9c2mr118517655ab.12.1718031583343; 
 Mon, 10 Jun 2024 07:59:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 6/9] spl: Allow ATF to work when dcache is disabled
Date: Mon, 10 Jun 2024 08:59:17 -0600
Message-Id: <20240610145920.3302001-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

