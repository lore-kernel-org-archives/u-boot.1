Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DAC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3746280FD2;
	Sun, 26 Jan 2025 19:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U3tPAkTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCE280FD1; Sun, 26 Jan 2025 19:44:18 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F8480F10
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so8464185ab.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917055; x=1738521855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0C16iS5xDE2H9LAuVkc6UXmnboDp4SyNJWv5u0YDso=;
 b=U3tPAkTpHTUnDryNTNgMa67gQdsYQyNSF+3wfTRXJi/ExHslVazlRuXfWp0j+OBvJC
 IlSZ+1RyAL8zMpnSvZ1oQEkBhRjKPal7CX5o1O5l77ajm/emBNTblMNLdcV8XGvB9HL3
 AQ3xeqgbb5qi5bRFJlDFloA3kjOcGGXD2nXAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917055; x=1738521855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0C16iS5xDE2H9LAuVkc6UXmnboDp4SyNJWv5u0YDso=;
 b=MXmbzYIbLwmZ2DFzkUkyAherIGXFmP54zTunF3Xjxvf2jNpnY6ci9jv33JmjiHHu9Z
 sbMS1METU2zTxfVlGyt+pTgdbLaW2WiwCvnVMMjvJ/I3ErvbA1iJqUZpRTaNHBlSpMBx
 Pv6SpmWyBlRi3J9Xo9rymYF5oGx8M51+RF+1cvF54PNz+HMKeASY4B9w8sdk+6Whmif6
 rrx9w0RNk0oLDXGkj2t/5ECQI/SgtZ8m/uYq7fG5AWdv8ANB9+evE2rGSX/bEHIB0DOI
 Hty5zOZi+eDM2Q7CnpSnsEgp5BSgVuN+7LCW6T6hfV3msvBLkOMcG7WgBxK5tV5D39Ur
 PWCw==
X-Gm-Message-State: AOJu0Yxsc0mgTgFgz7s2HSoidjlU6Wj8RrlqRN4RTPKmjywN41iR0xqX
 zCDCLw5fx6Fkl1GnTszbCdic/zWLMhMFoNfO7xjcN8K7KNJHffZHLgONuwECH6X36XMff++6syg
 =
X-Gm-Gg: ASbGncuIyS82T/K8w2l43Lvasf2HFkqo4s7wKmJUmF1lJNCWUf2bmnb1vK/DsoXaRlh
 tXeQVjNXbSIT7bL6260UJbmBcF/SOIXm1MN+8IxXLFjAY6nymQUCsTdDE6p74xVHhP425OT+5Gj
 KwpwRmnTUBuW3GDBc6le76BlnvjHW47sw43vhxrHOU63ZA7VzuKR2sn+n4HZ8Nhv6sUxqpkOmSs
 x9SDr56zxVHEtmUtlBpVjvDaQv923IcXVE2EwCJku9a1BwxKM6QJy9YWacPSFfBBu6/6+TzInwU
 CDsG9kphwQ+xEZE12gb2uPsgHVNDEoVDQWdcN0DU7Q==
X-Google-Smtp-Source: AGHT+IGnhvJKY/NCitw9K2rgZ2KfcWw7ui/SQ3oaBhBMFGK14SLJfjrhV9rmzfUi1chbVIz6FYMZ1g==
X-Received: by 2002:a05:6e02:1fc4:b0:3ce:5af3:783e with SMTP id
 e9e14a558f8ab-3cf743fdf68mr321800085ab.7.1737917054928; 
 Sun, 26 Jan 2025 10:44:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/19] lib: Mark memcpy() and memmove() as relocation code
Date: Sun, 26 Jan 2025 11:43:23 -0700
Message-ID: <20250126184333.4058848-14-sjg@chromium.org>
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

Mark these functions as needed by relocation. These functions are used
to copy data while relocating the next-phase image.

Drop the 'safe' versions from SPL as they are not needed. Change the
static array to a local one, to avoid link errors when trying to access
the data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/string.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index feae9519f2f..0e0900de8bf 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <malloc.h>
+#include <asm/sections.h>
 
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -559,7 +560,7 @@ __used void * memset(void * s,int c,size_t count)
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-__used void * memcpy(void *dest, const void *src, size_t count)
+__rcode __used void *memcpy(void *dest, const void *src, size_t count)
 {
 	unsigned long *dl = (unsigned long *)dest, *sl = (unsigned long *)src;
 	char *d8, *s8;
@@ -593,7 +594,7 @@ __used void * memcpy(void *dest, const void *src, size_t count)
  *
  * Unlike memcpy(), memmove() copes with overlapping areas.
  */
-__used void * memmove(void * dest,const void *src,size_t count)
+__rcode __used void *memmove(void *dest, const void *src, size_t count)
 {
 	char *tmp, *s;
 
-- 
2.43.0

