Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C7CCFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 04:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4517283DBD;
	Tue,  2 Dec 2025 05:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJls6uJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822ED83DCA; Tue,  2 Dec 2025 05:10:48 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5AF83D9F
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 05:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-297e239baecso42551525ad.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 20:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764648644; x=1765253444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nMpxWU7wWzdYij9nUluKGYlv6hbwjNLDdsZoG9q9LLw=;
 b=WJls6uJyBkCB61F2E+HPJ4Ap4Y2Alr8xqOjJhk1FnW+WiOYBc+MS4fqHz69Dv2l19O
 Cw3VZT3JXFJ8UQ/cxa5Zo6pM0iB8qClnGeOsjNDhzi6dvMk+Q6udBQG5f6UFs85TCam7
 vPUxqdAaLJSSlDW2HdrErozvAAaIXYY1DwF2tU+4polIx8R9cFTgVpJCE4CsisRMqNhN
 tfRBUuwltZ+zUlc2sQhDgr8RXnJ489AkmdXY5HbMIOv5kiiJSvmXexjNWS4NU7OlkQXd
 HHI3VpQHnPZILSZXj+1BumNBrE9WXEnBCDdaYdAxarwK0b/40wy9tT+yPZJmBoOdT2FE
 4PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764648644; x=1765253444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nMpxWU7wWzdYij9nUluKGYlv6hbwjNLDdsZoG9q9LLw=;
 b=kH5LylLkchA9JgllCgW15rpeDO09Xvpoy6xZlw4FX29zbbgDJ3l0S1CMzBWBaD/Rrm
 9drqsamQmCH2aqDeT4IGbrtKTV3XCNyhkNBwYFY6snxa+31Dca9TtmuhBYf1hz1ebDN6
 Ht6zEFS80MdJqAY9iVrKhAfJXH6qDIcprBRUxZdklBGJfTF0ZL/yMLbeN6RwmQhBI+G9
 V+1+HkLOFhqBB9usjspn0nR7wt6G4Xcd4BGgiRZ8o+nSwMbiXKffN5fGlzrOisuLFFjJ
 TrMyNpYTG7bWtMLMizcvFz9zDPkmeD8/F3HDy32mX4nAibpnlq1CXHDQ/6BwDMGzqJEz
 fgfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0jF5pi5Cb0naKy97bl9/tvZOyT5GuExh2DXONFpr6/JRMo0KoYJ1w5cPtzKzGL+sXJoAqsXg=@lists.denx.de
X-Gm-Message-State: AOJu0YykAocUNP5KtMUOc2N0JYp7Hni4tEr/tSKtEkJXrblyqA0Gs/fE
 kcomfpagx50/hxyM9pmGGi8YMK6BzlHGLM7fkf6Xqe0+NCnJno71suBF
X-Gm-Gg: ASbGncvFSj6qj3zXu0ekz2ci8/kETXsh7ESqRDm1JBHQ1XD1kWKyQ+sC9NOou3Q9qSB
 nL60HxKnDwJnIdctTbJH0vkiY1pL1ztDj5pjkdm2VlAFr2Au0NR499gRBYXQvSv//2ZchpRYkSx
 eYm4F60eaTLoKjWe2U9o2jGYOrI8gOdjcUU2NGfwu6gbrOSSjllkOmiAfP/DlAhXkyjq75ewPdE
 kNQDOW8DUkqV/FwtbJW8I1uI4kxEnWJbsxIC2M1pUj/sWulaRWuA9cnMi8XL2PXup4j68NjNu9R
 C2XPUvvs2Y37+6VRxiqosxskzifhiAXZtylOp//2/DWRfAb9eVpLUpMBIgFgUPa+SbeQTzjHLwp
 v8jJsfp59a5a+Fj9cWvi9zOI3sCo1jvEFC0NfY9lQCP0OOIoBZQCm2mQHrE/1iV8X3JfP54MHl+
 1JUjv5G7npO3ivk36/qMjo70Ga8LU5SKZMLIH3VQ==
X-Google-Smtp-Source: AGHT+IEW3yO5UW5Rm4pv+kXWiFVMqpsc3lM2zIK2gqpVK95WtwLuAGX6Mcy1GSKQ+tuCZwhVjLRkeQ==
X-Received: by 2002:a17:903:2cf:b0:297:c079:4c32 with SMTP id
 d9443c01a7336-29d5a4d8e3cmr16152965ad.11.1764648644561; 
 Mon, 01 Dec 2025 20:10:44 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.248])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb275a3sm138355695ad.66.2025.12.01.20.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 20:10:44 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1] update GCC version check after Kbuild bump
Date: Tue,  2 Dec 2025 12:10:29 +0800
Message-ID: <20251202041029.186-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

ARM GCC tool check is not up to date,
while issues are reported such as file truncated linker errors.
Using ARM official cross tools shows that 10.0.1 is a safe
version to support latest kbuild bump properly.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/config.mk | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 73fddd50bd7..a7eff84a267 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -58,7 +58,7 @@ endif
 
 # Only test once
 ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
-archprepare: checkthumb checkgcc6
+archprepare: checkthumb checkgcc10
 
 checkthumb:
 	@if test "$(call cc-name)" = "gcc" -a \
@@ -69,13 +69,13 @@ checkthumb:
 		false; \
 	fi
 else
-archprepare: checkgcc6
+archprepare: checkgcc10
 endif
 
-checkgcc6:
+checkgcc10:
 	@if test "$(call cc-name)" = "gcc" -a \
-			"$(call cc-version)" -lt "0600"; then \
-		echo '*** Your GCC is older than 6.0 and is not supported'; \
+			"$(call cc-version)" -lt "1000"; then \
+		echo '*** Your GCC is older than 10.0 and is not supported'; \
 		false; \
 	fi
 
-- 
2.34.1

