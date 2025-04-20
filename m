Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C05C369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 13:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868DE80FDA;
	Sun, 20 Apr 2025 15:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="krkQHgFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66826810F4; Sun, 20 Apr 2025 10:12:24 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310C1809D4
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 10:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-afc857702d1so2644503a12.3
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745136740; x=1745741540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GX2ODz+R99M3xwmI+t5eXOA92X+GstClqJzbcjbxQlc=;
 b=krkQHgFOUudemW/8QXOE3QM/SJMUp9pmP1F2320udZ87hse7Nw76eaKarBLBzoWU9J
 n9T3UVsCTp8z1wJyN+FSPjS19+NsJZh4O5oLHKhpcv8329spCkokaVInsI7r1HmFGhZj
 /sMELy57pL4q5WkhrnooGsjb3dOfz9t0H7AYqNRWKkYjZsLG+1vTuh0/r9bPczSmMVkq
 31tBBnJZcNMfMs7QEUdudRDf7fPn8JtzFv9deDwZOPD6GvWaond/EEONevP5g91IT25S
 lCPaRBNgXHjtU/7U5JP6VRDnnfnnm2wZKHrhvsbNYuBp47J2+e+Y7jAfGqax1OGfht2c
 ocBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745136740; x=1745741540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GX2ODz+R99M3xwmI+t5eXOA92X+GstClqJzbcjbxQlc=;
 b=nymK83zZXNHlVtVduF24Q0x2QNQqGPFIVEWj+sX98WkiCRLKhl4/IYXOSvxknrB1qc
 y6ZbaKX00DChp9i+OOLzfBhBhWCQ5MnFHrfIwn6Y2IXfiU9k1IXVbcVmnwWlZ2FUA6XV
 GALXCH9F7/W64fBsxQ10ZpcgjqoWKbEahTj+xb0oLWI7siTxFHDQ0zqWs5RYToTSYyJj
 8kcNAm7XF8FL6mJEjNug0pFC6AfqQ/3DZSvW0cjH2hWVsD1oO7riR5iN7VZ0EK5Yv3WJ
 JyEfiY5gY+pMW9wFMA2702t1YYo/1CzNjUjVS5ZBh3VISKPyQ13XhDlIAbbDNJSE4HUC
 5FKQ==
X-Gm-Message-State: AOJu0YxmHXAwc3FP9cP0NdflrdBFXesUCxAk+I2LEcGGMcb6+2kJ9iYP
 zuSpSn/Dm9B0QkMLFyREtdP6E0ygLFLHS0WEZwS5Yd0VwgYV1TvFFLg3BLDJ
X-Gm-Gg: ASbGnctRj+zapkpxlVfMBTjNCFP8s4nBnXnEUkYzzXCxVrdKBx7rCGIpmmHKYt/kjFd
 eok4NkarAELOO+uQopLsNgJP9/dG2WUmScO6rdun2qHuUtYFq56eX5zUEpmpvhLX3znBuRCT8Qv
 DKHFxtz+fI5ufNOViBeZZaF6bF0kJXA+kCo9hIKtJZWrOZoQwNnNcd5uV6ILtMhnqlkAbVL3G2C
 3Uhl/CT2ZALHNjTNCVvKnpso4DVhcM9iF/z97QVuUWsbOyd802exk+4LsyOTNrjF8+QrDghPCv8
 r2KKQRkYpza3/SiZTtfrvXXcK1FKKRAT/2XKX2kGCv9s4ZYL88wtaJ01lDmNpvnMgb9En0Rj0p+
 uu1jAdztmdKp5FCqz
X-Google-Smtp-Source: AGHT+IE//dEDPYSsXkw1vlILAFd0+3rZNbfJq+eu6MYY3OcwW4xKxOC1WFOXEq5LLsJyH1WxZm0a9Q==
X-Received: by 2002:a17:90b:6c6:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-3087bddcc7fmr9725653a91.32.1745136740324; 
 Sun, 20 Apr 2025 01:12:20 -0700 (PDT)
Received: from aristo-b7flip.. (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df07c1csm4296964a91.20.2025.04.20.01.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Apr 2025 01:12:20 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, michal.simek@amd.com, ibai.erkiaga-elorza@amd.com
Subject: [PATCH] cmd: Kconfig: Fix typos
Date: Sun, 20 Apr 2025 16:12:10 +0800
Message-Id: <20250420081210.292644-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Apr 2025 15:52:14 +0200
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

fix the following typos
- from "categorys" to "categories"
- from "indivdually" to "individually"

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c2ce519d1e3..6e722279205 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -5,7 +5,7 @@ menuconfig CMDLINE
 	  Enable U-Boot's command-line functions. This provides a means
 	  to enter commands into U-Boot for a wide variety of purposes. It
 	  also allows scripts (containing commands) to be executed.
-	  Various commands and command categorys can be indivdually enabled.
+	  Various commands and command categories can be individually enabled.
 	  Depending on the number of commands enabled, this can add
 	  substantially to the size of U-Boot.
 
-- 
2.34.1

