Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D7FC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D29884A27;
	Mon, 29 Jun 2026 19:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KpPxXvu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E535084A3E; Mon, 29 Jun 2026 19:06:54 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC27849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso2692595e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782752810; x=1783357610; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ee5nJ5nONdV3aR2Z+CsFlwSFMws+xN/olgD/euh3cc=;
 b=KpPxXvu+zEj7B7STUy+bo9j4FYVbZ+Dw5lSoqdhxP1FxpE8psaPS8ePBjT0R9ZGkaT
 YDGFhM29ntM3cUxcoVZlDuDkkg5FPVu635XiuzwWL5yYfkPIYkunQO99f5lJKCKYZ0nU
 g39fdj5M5MdqXb1oUmy2RKRI4Q4S3rzznXinymLk3plt6B6hODegYaMDhyae/WEGB5zD
 dN3fRWZrSqc03L+JZazU4AbhwDGZd9SZzeFwfzDLmE1ISyBbbPwTkBFcLBZfpbwjLe76
 HAaobb2eLIXB6c8p/FX2Whs4B3etPpziJKFPVeDKqZaG3F1X2S+W/a0zek94FNWlr3AB
 JiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752810; x=1783357610;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ee5nJ5nONdV3aR2Z+CsFlwSFMws+xN/olgD/euh3cc=;
 b=Ee/NjGHj7OMrWXBQgddkI2m5JtWzdu2WgtXOTMCHtKLxwgwsrEsWjug57/Jz3cGv+N
 MDTsYcdcJakCTj7AULKNSTY59BPBwdsRJO7itbG8Us4NSWrPzH5mYFACU5VN79mouHVJ
 3doHBvDDgTNmMYw1MgXuByeRb2cDJmPilMnXAMLQJBCTcJbNOEgWqeYEth8Agiu/NrO2
 GExvQxq+vBCJf0b9lKnkfaLq5kg1Mof/BjSnH1dLKiuobr7iwuwk5JrlS1mL34R10e/Z
 ZG5yAWxbRMHh9hLOmqTuzM8kY7tyOmp/6jsFoKYkXKnGN2nODoZ2Kw87XHOSUnphYL2E
 8zAw==
X-Gm-Message-State: AOJu0YyTkVSVzcxZxvdKX985XIK83VHcbh34d0b40ZEHscdUogLVkTq0
 xGEzzNMt5EfzwDKBiV/i6Cyk+r7/FDKB7Nn9yuBeLpJ3CGcDtfYrbRdLqX9zSrcynORbRxHh2ld
 krLhGtFU=
X-Gm-Gg: AfdE7cn+VKpqBf5F7KCbH55gv4PoM/3c6+LL1LgwdPMBS+AbFZgWLQGV/f8aTt8ywqo
 ZHycYXPNK46rQx0ubYAHUgr0de+URoNGfQfVdw/QQZ0LX3JKF78GluKEMXAw2sVjUfB7S0jlth6
 knw4spsnt67qRDPWUM6q29r1X7l9ZeMZ+hfmGhBJB2k8IB1Xd4q6NLdL5PxBAjLz1RYYT29Kdxr
 paWCLKn8p336l6Fy7QWNd80PxvisFVlxoqucGx8lfo0RtmPm6aw9OAC6k3ygdxBIkFNI21uHT39
 TvcSAgN2UDculZV/gifvN9+xCBpWrDpLKfUh/k/JTtCLSZ5ypoUQfBh2U9ztCUHNPtPKe0z5u5p
 MJrbMGmCJb886mNopxPQOnEmcoMArYswSOIO8VKsmaoK8t4l3rlf2HaU5bzSf1CsVm401uODan4
 Huc3137UqAKj52C3+T0+Nrlt3Km32tjkjKAYZN+0bDAYWEYTNF0Cs=
X-Received: by 2002:a05:600c:c162:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-493b827fc33mr9188815e9.1.1782752810118; 
 Mon, 29 Jun 2026 10:06:50 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:1b48:ce01:1924:f68e:c81f:44b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f9db29a94sm30565775f8f.22.2026.06.29.10.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:06:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 29 Jun 2026 18:06:49 +0100
Subject: [PATCH] Kconfig: Fix grammatical error in help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-typo1-v1-1-317f272c4441@linaro.org>
X-B4-Tracking: v=1; b=H4sIACimQmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3ZLKgnxDXfMUUwNTQ4M0czPDRCWg2oKi1LTMCrA50bG1tQBG+l3
 dVwAAAA==
X-Change-ID: 20260629-typo1-7d50510f761a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Fix the incorrect use of 'your' instead of 'you are' and reflow the text
around it.

Fixes: af9e6ad4ab29 ("board_f: Add new function to allow runtime DTB selection")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 dts/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 6b501c2239edb67f169a691647eff66256f26669..3fa1d756fc76c2f693cefb2b0e09b81e8e4efba8 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -314,10 +314,10 @@ config DTB_RESELECT
 	depends on !COMPILE_TEST
 	depends on MULTI_DTB_FIT
 	help
-	  It is possible during initial boot you may need to use a generic
-	  dtb until you can fully determine the board your running on. This
-	  config allows boards to implement a function at a later point
-	  during boot to switch to the "correct" dtb.
+	  It is possible during initial boot you may need to use a generic dtb
+	  until you can fully determine the board you are running on. This
+	  config allows boards to implement a function at a later point during
+	  boot to switch to the "correct" dtb.
 
 config MULTI_DTB_FIT
 	bool "Support embedding several DTBs in a FIT image for u-boot"

---
base-commit: 6dc7cd6e2f1eba531b71da403e5b2e7764d39b1d
change-id: 20260629-typo1-7d50510f761a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

