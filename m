Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4B3D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E695189170;
	Mon, 28 Oct 2024 13:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FHhcZ307";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B701288C53; Mon, 28 Oct 2024 13:48:37 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA2A890BB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso543344566b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119715; x=1730724515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTuwSRe6mWhjmwH0wCm2erWu8Jpn5WMrfJTDNVz13d0=;
 b=FHhcZ307wwFl0ZYTdA77hoBU7gEXNiBtBEZXU9XTMQ6aB2fWCsFaxbMxXDh21D+yIc
 9ErG6sDYniP/BQtRGahjMUkENMHTlg3zdmUgIT8PK6PxDbpz5F/JHHo/Ip7v5xVqT9Pw
 /E66bmzxZ4lCauzC637xy2ox8IcxooExUPNXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119715; x=1730724515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTuwSRe6mWhjmwH0wCm2erWu8Jpn5WMrfJTDNVz13d0=;
 b=EHA8fpMRtej9BbFJv7LmeygjO34DN/UiNjLi0705DeH0yWhmjerjm8+0E400thlVsR
 PGZj34KYq3/1jS0/fgxKqd9Z0zzuvsbV4YmdcYlHRRwPsIG/jdLi6ARs54OPD0ugX2t3
 GSbJm4VaeUre23C6W6G9W3yUJQ7WKCIvV8uR8z8mep4X+JSuSPqbdUEwVV5lXPvvSuMf
 R8bEDLlkza7Vk9JOMtL2Ci1RmmUJ1WwV3+EMaV1swNSbejAFSvvey+ZH7onnEsPKU5zy
 MIdo9XGJabCUYJV56cth+nGYUNUIsgEd77eJsouAYlfpm2vCJBe2Ji166KiZvMFAFc8d
 RT4Q==
X-Gm-Message-State: AOJu0YwQa0ZtWKGW/VeIyHkGW+RdB5fCQszGN9OvB44M219pbcHCedR2
 Dau+jWmW/BUSivxLT6t/7EUk8VEli0Qf7DBLnn4so9YFmyeM+4RRsys+zTKUFzCgQLVXKr/zTrl
 03w==
X-Google-Smtp-Source: AGHT+IEd6Flm6k7jMLVUSrcf49nE0JISvFEqjeY/xLqgMux1CRgp9zg3T/R6ZP0kFHpaPbzvm2wDGA==
X-Received: by 2002:a17:907:9449:b0:a99:f92a:7a66 with SMTP id
 a640c23a62f3a-a9de5d783e5mr771653766b.30.1730119714678; 
 Mon, 28 Oct 2024 05:48:34 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Igor Prusov <ivprusov@salutedevices.com>
Subject: [PATCH 07/15] sandbox: Fix comment for nomap_sysmem() function
Date: Mon, 28 Oct 2024 13:47:58 +0100
Message-ID: <20241028124815.47262-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

This should say 'cast' rather than 'case', so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index a23bd64994a..3d09170063f 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -235,7 +235,7 @@ static inline void unmap_sysmem(const void *vaddr)
  * nomap_sysmem() - pass through an address unchanged
  *
  * This is used to indicate an address which should NOT be mapped, e.g. in
- * SMBIOS tables. Using this function instead of a case shows that the sandbox
+ * SMBIOS tables. Using this function instead of a cast shows that the sandbox
  * conversion has been done
  */
 static inline void *nomap_sysmem(phys_addr_t paddr, unsigned long len)
-- 
2.43.0

