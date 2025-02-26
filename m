Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C2C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 20:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9B4810F1;
	Wed, 26 Feb 2025 21:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G+ZxKlBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79075810EA; Wed, 26 Feb 2025 21:31:33 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F39810FE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 21:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e6c082eac0so3076006d6.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740601889; x=1741206689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ngmN0t0731G9MrAreQM/4M3FTfPD/qgJW5lzroqnOlg=;
 b=G+ZxKlBw7612ePl5OcPWQePG6Jwc+Pbvgajeq+7MZo4Iclbqf1uZe6ofHyIThybOpp
 RtDR+5JZYhCrp7AKnhiVsroet0rK4hO0Zhkl5I+lGyzrpj8c0sWghg57gFue4bO5HtvB
 A56MOis5GQSi7BNw7xlJq93YNYv9Ve3lLsv0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740601889; x=1741206689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngmN0t0731G9MrAreQM/4M3FTfPD/qgJW5lzroqnOlg=;
 b=ijYKJ2r/Bb8X8cGi1TvNmfU28T7H+bpoZiPQmKQcHPZUFovmZaR24/aTQK5jEbC1lS
 5BqVatWjx0BKKdcw+yIrVL8Pz8ddT9vs0YGxILo7nsLkQ+ibomNW1RVcoKnBumDBexHf
 7W3ZWxEuv8fgK+jGuu42sVyFwNELcH708BN2QDscimBDNt4+vx1cGf7oINcd2SV5SkHv
 VJEaXZlxbnw23x1pMvmNIDNcVtgtIh7S93bi1RWFkm+RmDMhtDeKci8ouNFQYC5j40pC
 gbjFphhQzjRRpW07cXFZLoV9R4SoQeQ48F6fTcNigPtMdW7lAmOsp3h3HuZL1d69dcm9
 j3cQ==
X-Gm-Message-State: AOJu0Yyn+EKE85yAaXuXDmYBXhxKCkI1bNui9Rc6bT8HYsSUcf3mQ91p
 ZyoJBZCYY6g3JgBEYKJHlPe5qMOMhPzOf34ej4rTrdHnXcVqxES/ILCBdWPMt87RW446gSrtwiw
 J
X-Gm-Gg: ASbGncsJQf827chOZioAJMJO05SyCVaCIeAQXkmI9S0HWfg3mIjSlJuWajpOx+INc3o
 NQtL+KQdlugc+l3g3c684SZVIjy1UDTJQdotkzLx544REQGvmNLhayyxiwYmh0JrmY/+Ql29fPq
 Oaql5AenQmka0pCfNyfoAn3qUotmQktDnWWXhZ+nJEueVZJd5kDHqGFMSH3H9veP9KU7Wa/9gx6
 mDyZ55tKy5fpDVqPE7zLIPLZXBoIY277aKQlhwArWV01NVMjupnp2aMIZw5sytPSkrFpPlkYPDi
 JowNbRX9aMhcIlsDhW0X/lIXwAQ=
X-Google-Smtp-Source: AGHT+IFD7S/iCEpMLvJ7pDGDBxXjCFFArFgaSX5aSGh4Izu60tSojj03Cn3xTBK3z6vT0X8Rfu05YA==
X-Received: by 2002:a05:6214:492:b0:6e6:6c7c:984a with SMTP id
 6a1803df08f44-6e8868fd5c9mr61770496d6.29.1740601889346; 
 Wed, 26 Feb 2025 12:31:29 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897653667sm396486d6.32.2025.02.26.12.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 12:31:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] x86: Correct usage of IS_ENABLED() macro in arch/x86/lib/spl.c
Date: Wed, 26 Feb 2025 14:31:26 -0600
Message-ID: <20250226203126.3831979-1-trini@konsulko.com>
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

This file was using IS_ENABLED() to test for CONFIG flags but omitted
the CONFIG_ prefix and so did not work as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 7a0335051012..61432f043004 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -82,7 +82,7 @@ static int x86_spl_init(void)
 	int ret;
 
 	log_debug("x86 spl starting\n");
-	if (IS_ENABLED(TPL))
+	if (IS_ENABLED(CONFIG_TPL))
 		ret = x86_cpu_reinit_f();
 	else
 		ret = x86_cpu_init_f();
-- 
2.43.0

