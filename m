Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A2C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB3680FFD;
	Sun, 26 Jan 2025 19:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FcC5/dC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0391680F85; Sun, 26 Jan 2025 19:44:14 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A9480FD8
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so10976025ab.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917049; x=1738521849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sz/ZOT7ytDV4v/a4UL7/PrWJUf3vE5YjIJm4k7cpkzI=;
 b=FcC5/dC/Vj888ri0iOR+hFcBF2FINyvBvyysn1t+VpqCUSZSNbMKl4lq/IhLwwUE35
 /YZBifXYfBcduu/twkxLBHa1/mI620BXqiAuxJ1PHgr5g9fxhMphSLBshIJytqBm4+km
 I2W03zLkhE1ooV22rtVb4Uy44jlD+p7njeYUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917049; x=1738521849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sz/ZOT7ytDV4v/a4UL7/PrWJUf3vE5YjIJm4k7cpkzI=;
 b=nwZoHRrAObvNr6FwPTWufDCXxAsTtGlz/zXa79v5PpizLAJhfYr1RO1JO2LQ6WSxLG
 kwpK0k2edGJCOXCyo3dK/VlCvqUSbXHkieShzNZQlh+A023Ntdrf9rm7upL57cjJ/1u+
 GW3jik2/I2M8zsCuuF7qEC1ki2sHraf/9NoIGPpH5GO8TPkm7R0eh3RdXM9Pwml2ZinI
 FOl/5/q9YmumSPLnmHRc39KhA1zEn8/8brtViNY/6VO8ZBOIs1Kas6mM3PWwvSI9lOgp
 8QHczFBKAA48TCZJe4n2RBe2ZsYVWimN5tvNo12kZ5RG9FCr3parTQPbXyk9OYedJfjo
 dAAQ==
X-Gm-Message-State: AOJu0YxrxOm29J0OUqwd2+LjDTe2syfDjmYQcoxCXyIhdqgLLwNAsfjo
 7OGq3KwunR5m+QzZJ4obLrQsgY92BuWw5jTk+O8cIyJ2v6MxyYjR1KBKa6xBoT+56Wr3+TQrMdc
 =
X-Gm-Gg: ASbGncs6gLmjGZcZR+CGAVQjjKtyxNlfv2FpmU9kxkyianti9Pnjd6CvIBGL5dRKOCD
 LYd6GVyn0Znibra1MDY1PacU3HWklOjuNijcdNHt3pg+2RoXjXzkRdSsdktZKekdPZqlZs8Dx31
 GUmtMliwBLrPtiBHIXp4J90P8w97y3c0mrllRMgp085zko+NaB/PY2fXOPasC+VWEh3/5BAFoVr
 n6ePZJZbNnpTW86lHH4KAxua0O48W9Jo8Wr0Jtr+WxJ48jbWmvxK9VMNAEfgmTMnu23nhVv8V6j
 gguqW2sdL0feuSn3BFeNbtzpdA8yHqZl0YkAAMP3Pw==
X-Google-Smtp-Source: AGHT+IEYie/9oLCI6jCqLTrXjju24rQft6zwjrRMMdEZ41OuiaDZBCHcmoSJ6ixx99c2o0UPh5iDyg==
X-Received: by 2002:a05:6e02:138c:b0:3cf:cd3c:bdfd with SMTP id
 e9e14a558f8ab-3cfcd3cbeabmr85711615ab.12.1737917048833; 
 Sun, 26 Jan 2025 10:44:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/19] lib: Mark crc8 as relocation code
Date: Sun, 26 Jan 2025 11:43:21 -0700
Message-ID: <20250126184333.4058848-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Mark the crc8 code as needed by relocation. This is used as a simple
check against corruption of the code when copying.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/crc8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/crc8.c b/lib/crc8.c
index 811e19917b4..bbb229c3892 100644
--- a/lib/crc8.c
+++ b/lib/crc8.c
@@ -6,11 +6,12 @@
 #ifdef USE_HOSTCC
 #include <arpa/inet.h>
 #endif
+#include <asm/sections.h>
 #include <u-boot/crc.h>
 
 #define POLY	(0x1070U << 3)
 
-static unsigned char _crc8(unsigned short data)
+__rcode static unsigned char _crc8(unsigned short data)
 {
 	int i;
 
@@ -23,7 +24,7 @@ static unsigned char _crc8(unsigned short data)
 	return (unsigned char)(data >> 8);
 }
 
-unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
+__rcode unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
 {
 	int i;
 
-- 
2.43.0

