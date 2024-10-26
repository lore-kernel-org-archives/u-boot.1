Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628C9D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B425F88D13;
	Sat, 26 Oct 2024 09:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wHFRZh6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCBF888D5; Sat, 26 Oct 2024 09:33:31 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F03188D13
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso425038066b.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729927996; x=1730532796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DeP0PjZ8E1mioEIeQLEMPLAozrpxOCy/8GtQhVj14LM=;
 b=wHFRZh6jrtnvM+Ag3QB1VvMHpHTYUtYROPvobUapCrEnmpOZu8Ly51AYiG50zjrOgk
 nmSMbFJtCcwbrTLzxMPYrwEzL2UBsOMZjfZiaUN0xCgSZdngoJALuzv1pbw3ymTN6cxV
 F8fu2nnoU4eMdMyEiTdVhAGkDER39Hr4e/8b8gDYOYmWV0E5R0qlNCG0SfNGY9XcBuob
 II81wAro4H4tbW/FdKzIwcnjgh4pnBtdW2aYSqP5b9sqLmC07iKqAB8vkGbpbZei4c6E
 +36twZ+e2YQmG0k+c4E151OHEaJA48u32dmUYNp7exVINGfzXaSV8gZBXcIv6DYtMXob
 zCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729927996; x=1730532796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeP0PjZ8E1mioEIeQLEMPLAozrpxOCy/8GtQhVj14LM=;
 b=TK5rIlLjkJI31n5osCRdx3KTQtMCaLfYwaiHBPNZPn3UfaP1YpWYDth9685uRWrZjZ
 ZdHRj/uL550CGElqJKtfcTX82dMsUgDLh0d41Om5Rdp7VzE4YTcRKEh0KHQGXsPkVKPD
 Cb/8ZLKffT7ilVgtsZ+tqRqK025OT++sX4TleO2Di8Np+L+lSpMdRRq3C4fHjFlpeiOA
 p0aQR0eDZkRMM3a74NmoRxh0DDy/DzRRy1c2tCx+HbaFb4dnXFouGNJ07P1bRr9mA3I0
 PLwPjwM3dG0LhlZhbbuF19EFMltm8+r3HWnj+6jA6LNjrGJgn7gzNKY1nn6wc+X8Gx5/
 4JSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAzAu58f0zTzByLIpDdgSNe939S0hH6qMFSgOrYFj+2dBbVkxCVum2YLy6mBS/kjkp1I5HzB4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7FaoOrW4jFJqmJ6U+Da8+KK5Lf3JSoYtsczfRzbZSQ0r80eg9
 ep8SAo8Uz1Pwcan5NnuBwWY1d79ToEozVlZKwK9cs/lL/qLV2xPVCZJbtzzyqNYVPi1Nen/6mJF
 k
X-Google-Smtp-Source: AGHT+IG4Ni0A3W+CxzzeS+6oO7Lrf97Rt0h3Z40ta3/+yj/y50cPML45YqKTI/2pr8IjSCiTTevjBQ==
X-Received: by 2002:a17:907:7216:b0:a99:ef65:58d0 with SMTP id
 a640c23a62f3a-a9de6440cbbmr114917666b.65.1729927996337; 
 Sat, 26 Oct 2024 00:33:16 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f067c50sm148525866b.90.2024.10.26.00.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:33:14 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH] cmd: fat: Make do_fat_size static
Date: Sat, 26 Oct 2024 10:33:09 +0300
Message-ID: <20241026073310.101619-1-ilias.apalodimas@linaro.org>
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

This is only used locally,so make it static

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/fat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/fat.c b/cmd/fat.c
index 1655e80e9450..5b7484dc1af7 100644
--- a/cmd/fat.c
+++ b/cmd/fat.c
@@ -14,7 +14,7 @@
 #include <part.h>
 #include <asm/cache.h>
 
-int do_fat_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int do_fat_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	return do_size(cmdtp, flag, argc, argv, FS_TYPE_FAT);
 }
-- 
2.43.0

