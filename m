Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07017C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AFE82C57;
	Tue, 20 May 2025 07:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kjLtIp1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F4C82C57; Tue, 20 May 2025 07:22:19 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD4582BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso51257605e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718536; x=1748323336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pAAAWvH1t7DR8YTJo31VitnrEhEjBt9UETIfCADjWA=;
 b=kjLtIp1cbZ8lQciHbLKXC26C1Bzj605xG2fb/fGaauOIdQ0Zvcfvja5s9Hza7w0eVg
 9pniqtsqrHGxGKh2Rq0GRm+c+iL/Z2wwlFhRWREz0PzHfz/K+hD+9t6FtV6JpM4jrksA
 ryGlQ7sWSSKwnR+EBqtB8b63fMkalxIJIpwpNTequqgmaXhIEfZGnhpqIo/gtjbSmCVw
 Kgap76gWjNGHypM1XkHuvlc355XxlVnZrlGHUHPXHakXi35ZOKeoO/QGTEktcJgiIwEC
 wkpISSF+FxC6XDRnzoEsyqdh5BAuUUlLMOBtwpnfkawq91yZfiM+r/1g1ejinfZpO9x9
 IjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718536; x=1748323336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pAAAWvH1t7DR8YTJo31VitnrEhEjBt9UETIfCADjWA=;
 b=Lq2ajTREh0A2P6EkaO91CFIpDBALTnqejD0xB54Pb6dgpbRpARgXN0CATMx98WiQgY
 UzGHRfD7it+0PvHb5OM7JK9KHYp7cBtidOZ3U7ZRvBo1V6f25/9NkfFCfS1BFX7NcQd1
 ekAGXgYUzCZNaf5MH2XMW/6lKHh98vI9MKz4yuAQjZZ6u0T34kaGTt0DC7pe4V0UtrXa
 2QOXIsYLgKPo0qiBy5OJ4j6J2RTBntFaw7PFBTquf1EIAFHbOnRuoOMWpWYPMBwlSncS
 Z3SxYT3VIfd5+0D3pXNR42w1Ib5Jva+UYr7IYu/47QiHqDa4wLx8u76JcM++wEGUKHoL
 xXkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgBLR+LqYiVjknocSBRST9xOZ82RIpzXUPgcBWsjdmHujp5y7Frhl6cdNDWyzdJOAkPXV3j9o=@lists.denx.de
X-Gm-Message-State: AOJu0YyyYX0kJkyuvU7uT0ypcnPksYoV5QiRML3irPuTs9apca6pyc6z
 hoY6DrePYSkeV0Z/0dawKNJVPIgtqP0an2c3El4la4mzYhnTjUkvvZUYPQstfQBFXm6c4x6HBjF
 inUX9
X-Gm-Gg: ASbGncvp8LZRJXNdm0xWXW0CboBkaECwc5p/8LRm0Rp/uxiLBNByYWs7Xdt2hqQlxiM
 J0T+JlDScPw5Ned5D3QudOT4xBB1ygTCmPOMfN2m0uiFN7gvZiUC838OWiai7FSPuH15hb+I+L1
 2Jn5J8ZtMQHokmqsc40HD5pGEZrLZnb44hT6iY/jmDewMslYPaDKFNK2tTaELsUTdh8lWGblmfT
 lA/QHyBYNlI+b1GZOq0Qh0wQr4B/ux6Z9u2Wh0WdWxHhRluMkATUIUka7kzIH7mciFbOyjzszEP
 Kz4xDfg5mrHTFx19U8WWTBnLnf3W/zd6lzwoXYmugeTZ15Tl0u9S5mrSFm6Ks9twQ5SWvXQn1xg
 =
X-Google-Smtp-Source: AGHT+IEz1rszKOgjkxqU1XNOplwWbkFs7Ge/Ma4w97w1MWpObZLhII14A3hxibCGUa90ur7b1o3Nxg==
X-Received: by 2002:a05:6000:2285:b0:3a3:68c7:e473 with SMTP id
 ffacd0b85a97d-3a368c7e5ffmr8169195f8f.25.1747718536576; 
 Mon, 19 May 2025 22:22:16 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:16 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH 07/24] kbuild: simplify rules of data compression with size
 appending
Date: Tue, 20 May 2025 08:21:18 +0300
Message-ID: <20250520052153.307194-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport kernel changes
commit ecbd10d90e94 ("kbuild: simplify rules of data compression with size appending")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f1a78886e84f..6d0cb8e6513f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -546,7 +546,7 @@ $(obj)/dsdt_generated.c:    $(src)/dsdt.asl
 # append the size as a 32-bit littleendian number as gzip does.
 size_append = printf $(shell						\
 dec_size=0;								\
-for F in $1; do								\
+for F in $(filter-out FORCE,$^); do
 	fsize=$$(stat -c "%s" $$F);					\
 	dec_size=$$(expr $$dec_size + $$fsize);				\
 done;									\
@@ -560,23 +560,20 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
-	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (cat $(filter-out FORCE,$^) | \
-	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
 
 quiet_cmd_lzo = LZO     $@
-cmd_lzo = (cat $(filter-out FORCE,$^) | \
-	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
 
 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
+cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
+	$(size_append)) > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -621,8 +618,7 @@ quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
 cmd_xzkern = (cat $(filter-out FORCE,$^) | \
-	sh $(srctree)/scripts/xz_wrap.sh && \
-	$(call size_append, $(filter-out FORCE,$^))) > $@
+	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
 cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-- 
2.49.0

