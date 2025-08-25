Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8279CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260CB830C0;
	Tue, 26 Aug 2025 00:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/z5ApWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545A480819; Tue, 26 Aug 2025 00:34:19 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1F7830C0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c51f0158d8so3629001f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161257; x=1756766057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJlfq9tbjNWWWp2VqrAgcJmXwvcCT71Qd9cbjCPMZVM=;
 b=A/z5ApWIHzbMtJxpnKDivlUO7MOpK2oz04zVHeR8akolsPw+kqRbE+rO/sTNMC319i
 90FyJGm1TByurbTEfcTO05ZMPP6KDItzllwQbfOvq9NoOTL0NuqVJRPRWoKlRXXzLj4f
 NnTAwYb+HESRg3cuNl09LDrWWHxorTWk1fGdI7tAh8wbMZ9CU8I8YYkN74MGNV8ObuPr
 /c3LmaoFmk9KEl4Wd4gifJzvgmgOSMmyUEJiKp9tRmclW5X2YMGSMSrWgXrOPtN2umgE
 enApeFzwHLU95fjRsNYah4e1FjkwmLYkiEga6vaqigE80Fv/xsK3qLnKdFxaYjbcMx6T
 4ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161257; x=1756766057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJlfq9tbjNWWWp2VqrAgcJmXwvcCT71Qd9cbjCPMZVM=;
 b=R7I1XWHfFETzKPJLaBCjozh4p5N6qDn/xqPxR3YbpQbOwGyw8kDfRlWvMVLj9bJh9R
 cds6nWkgOrgVFPljmhsP96gU0JGVie7UTPOrhgbk97456jsFgJY3nl/18SZMdxwXtIsE
 uP+Em2zGo343bcaomtRympBYXImuaJEG6hM/3dXaDdYAyAekhag17FHa/hNfwzIY0AUz
 MKDAtxXFozCT0eslPNrQ1WbXpwM5yM7rm2HPld5XZyb+mb+IDpMmo1zJCkhfdjdKGe0w
 17hEN8y6s28xHZbA4s9U/aMPfBBuMpjSs1p/rnZyTLMHV7w95GYS4PJ1hdDEnqXWGSkM
 S/IA==
X-Gm-Message-State: AOJu0YzOsUNo2UiMwMVdpG8NRdpFxSZD6TFYP7x6mxj8FX+0vayCAZ3X
 00LxHon6v8+Eq+y0DpzqXuvLSn7CAswB8LArW7ZQ/ozwUtVuqHOIYIjbgkfJVWYbRKQ=
X-Gm-Gg: ASbGncvdI/BQIhD/4aGktgoQLmvl3rmWDODHJ9pwcvlyckblRqxzLHYyBPTV242oCGQ
 4OFl5WchAgqVSS2RUvZGl52z0RRsr/z3H5Qx1NaWXpFCXS8ZGUZAKXaNcjxZa7QKe8iu39VBzrz
 3pvOM0u4h9lJmJfWV0ntB8dbQLV5a1cxoNMWj/kBJ/Bf6fef9AOvE7Y6tZo1tW7eBpAiMxMhfoX
 0UgVIeBq8uKR4rIjbbvRJd2PYmkkzKLOmg2ifrZLRd9n6H+M72Y7V7qaJYpEorewivooWZLpzTK
 UOKn0vPPoCwMujPqlcKYqXqnWndFP1C9Nd4d9kZgD26O1GHBRbiXfxOlWVdYqgu6sas6RRYV3VI
 u4Z8Oi8JqPxPxNZOov3T/NYTdZLSW
X-Google-Smtp-Source: AGHT+IHsNX+QGJXmqvByNiZ8dFu9Ia90cWjw5JnN5Jh91tRDWVAq4HAy+sTtU+LwdYOpc9pk6RN2aA==
X-Received: by 2002:a05:6000:2404:b0:3c0:5db6:aed with SMTP id
 ffacd0b85a97d-3c5dcefd13fmr11958955f8f.54.1756161256483; 
 Mon, 25 Aug 2025 15:34:16 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:16 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 03/10] doc: Use "supports" instead of "has"
Date: Mon, 25 Aug 2025 23:32:30 +0100
Message-ID: <20250825223251.674591-4-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

Strictly speaking, "has" doesn't make sense.
"supports" seems like a better word and it probably was what the original author meant.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 3b51b9ed2b3..49ac5caeb14 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -476,7 +476,7 @@ Setting up
 
    Buildman should now be set up to use your new toolchain.
 
-   At the time of writing, U-Boot has these architectures:
+   At the time of writing, U-Boot supports these architectures:
 
       arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x86, xtensa
 
-- 
2.48.1

