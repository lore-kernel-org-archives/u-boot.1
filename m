Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195DACCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 09:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CFD802C1;
	Wed,  1 Oct 2025 11:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kIUMjqda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF0081D6A; Wed,  1 Oct 2025 11:29:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A154F800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 11:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so66671325e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759310938; x=1759915738; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8eVlCxxEQKRTyp119aPoeleD6F2f+SYg9qfhEI7G3w8=;
 b=kIUMjqdayNZHmcPLvzqJaC2WgR+CpvQZk2xHM6xP5DaND2a7FLOVS+BrKUMLPUyjjr
 55bbSnCDIYD+lR2hM4o4GMbrgRjucCsuMVJr/DVj4uxQrfYu3hczyvy2GEFbQtL5IrDE
 Tx5oQejVH3T5bVfm7oL/5KSwBKQ4DKbQvgB0R5MBYRd1T7u4VoEjXe74ZXgujxasuzBI
 F5ZgtkFED8iEFTmkqW4hmzlZpTSNGNd3saeqFjgZTyVL0ny8s74IkhKdNIyag6bAx6MF
 qYKo/tPYMDEk/xl31ZPcaH14pLHFktLDjeT/Zo5fjPnpc2v9Jy/csIhuEsJzQLIwKbmV
 DLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759310938; x=1759915738;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8eVlCxxEQKRTyp119aPoeleD6F2f+SYg9qfhEI7G3w8=;
 b=ARxsY1I5uAuUpEG33r/Z7UVhkXj31DJieidslVs/mobSWsNdTOK5ywfikzJJCOaaOc
 jDGQuSTIuG2syX2XbZPf+AT6KN4pBEdzbSfTg07elXZTs+XFaZGUb8CZHQ5KF34HqVVH
 ByzCtlbxcxZ9owWsQpMnHs514Hx9PpzntbJuKQ9LPkrD+0kZMdwdsqIqFAwOG1a97lCI
 uanCR0fu8ppvGt0/8QIByiCnmPxYwNtf8K+15QeTR1ajLiGHs3QvDhvu+V81M/TZC6nn
 KS9skMdl/gsm/QkYBaSmigcp2cVSbxS2nKC7bfpJU/lRYuqFRSrjg3oP9T4NxP0bdQvt
 XtnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsctYMwVKFquP8hIsOkUkGMKes4UIv6QvKM5tYcduhZXTm0Mk7XQPxEvvT2Fq+8YoG9oQnQY0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzssodr82NDQo5W1cjNzeq6rzch20El9D1B+5d6cIUofoKa/gHO
 qIJ+7eUQfb1AOiHRvfaD889kJ3ts3ydBnMyZ/TfWiHL/bNuKkt0bIvOZfwJJCsLw5xV1oYgBSPh
 +HS5M
X-Gm-Gg: ASbGncv3fZ8q5ukMgi07ICORI5BlvwWRnR7RVkg2ZeyLAT7yBwTBmHkpXYA1TCGCAG2
 eMESg5YIRio9UeL6p8g/is3w+cxVVy26jZ7VZHjiW3EEC6F9tTLObJ/bqvIYASDhqpIGwwWFDR9
 541i3Z1u2uHKGC7LkF0g2tUWM/i3K+VggekVhd5XOmoYCtnYKaA9wat2QOx9jm+UqHggfYhY0Ps
 l0w7cfkkgb7RQdUvj7wt5+RESrW3cowJD3JHVgQRbrzncS0n7jhqM2GzLVeRXnikiUbo7m7BDoE
 OyTnpe06ixXRiAJ5/QFSVvZ6l/A+AsvPPd/BMYwD+evJyLhUDYPPJJrmCASbztJVN/1Lm1iDzwI
 VwVaSjkLvZqhEHFHLpOMIjq2Ie5IhCPSetHqJKw8Ar0WSUwpeWKpxXpEd2GZCCdwjYc7BfmQMVu
 M=
X-Google-Smtp-Source: AGHT+IErVYUP/mK7xRZZ49rgiuvx7ULlbycV8EsHoUvbHvrg33LTPGiAxqQ1qZ6gMICw3tMvynYdPg==
X-Received: by 2002:a5d:588b:0:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-425577edcdbmr2264668f8f.10.1759310938060; 
 Wed, 01 Oct 2025 02:28:58 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb2eesm26983944f8f.12.2025.10.01.02.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 02:28:57 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 10:28:37 +0100
Subject: [PATCH] b4-config: Improve b4 config for correct operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
X-B4-Tracking: v=1; b=H4sIAET03GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3bTMivgkE13jFNMUozSjRAPTxDQloOKColSgDNig6NjaWgAZBgi
 ZWAAAAA==
X-Change-ID: 20251001-fix_b4-3d5d2f2a05af
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
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

The recent change to .b4-config resulted in some expected recipients not
being added to the address lists. Rework the commands so that all
expected recipients are added while maintaining the ordering from the
first change.

Fixes: 26efc940c86 ("b4-config: configure `b4` for U-Boot")

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 .b4-config | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/.b4-config b/.b4-config
index 6ba10cf9b50e6acb8a789544d35a13641e6c0411..1f9ada793e652c99854e4d15241734c9b3bfc117 100644
--- a/.b4-config
+++ b/.b4-config
@@ -2,6 +2,5 @@
 # See https://b4.docs.kernel.org/en/latest/config.html
 
 [b4]
-    send-series-to = u-boot@lists.denx.de
-    send-auto-to-cmd = echo ""
-    send-auto-cc-cmd = scripts/get_maintainer.pl
+    send-auto-to-cmd = scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins --norolestats --nom
+    send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback --nogit-chief-penguins --norolestats --nol

---
base-commit: aff68c8514858ddd8d2e508d47bede566511521b
change-id: 20251001-fix_b4-3d5d2f2a05af

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

