Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC52C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D5A82C49;
	Thu, 15 May 2025 17:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="gk5GRtSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B6E82C4D; Thu, 15 May 2025 17:58:14 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FA082C15
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5fbfa0a7d2cso1858591a12.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324692; x=1747929492;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5mJeXteBSfy5AijviFM+j9TQlBvYVtCwXBjsdyKF1Kw=;
 b=gk5GRtShozGHbG6ZXWejxskBfwFTLKobd0fa63F27+UgDpzEV2IBT9D3DGShCIpZrF
 Yev/P0Z2Ny49aWcYiUNm7SWBNPORef0w2hsOsFBExsQnSAW7WoxmP8JNI0ZYQLeUdqcj
 NsAgdX7sY/BWgIGqH+f7MtfFEOxUe6dXEirOzP2tW9/dxxSNoodE7KQ+8hMrtOFlSOwy
 /jCL3blzxEr5gQVqIZIKXPLKNEHhOQ2nxMw2kRHH0KcGbjbvm3jTyBhyuHlEeVFZiIsG
 bnKkD7eT1DoYHAXUHvCcdlQDTIm/eSoLF+A3a1NFg4/RzM3YTH4jfu+PnSyAWQ6fk0AK
 r2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324692; x=1747929492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mJeXteBSfy5AijviFM+j9TQlBvYVtCwXBjsdyKF1Kw=;
 b=H3wtaeHDjwAmod1LXrl6wLAQ24vXqiaVSX5UaT0Yz3VyOskwH8HDFnxG9ZsJxCEE2L
 wu0onf6oWH/gP2xS9MVEdlMO6NLQTNLx8ZOnskhVHkwIbw2UaeVmW1PSd2Dt/5EtZG+/
 XXhEQjtSNKU0nTVbRMM6eYdP+yul34D/Trc5HbaJwunFpzpIx1U6yr6YUUzdRDl+DvR4
 bm9vKD07+9fQDwcnQVjkyE0XgS0FI833dPMQEstj7BTNq5pkGAshzbH/6SKS9Pu/mcJq
 TPbi/EDXzr5LR7t4kuplS8CuU7Y1DcF7eMpRxupQqkGt8qv+J9yj+YZxXr92ZcpOBToa
 DWjg==
X-Gm-Message-State: AOJu0Yyfgdtb+hSYN7O8W3qFpgD44k/wuHpHuMq1618hmBxDS0Q+Hz4G
 /r16wu/LE6+0/p+TZUCZdtwosSzMw+nx+KLVAd5cPQIPDz0zFQRKjtOW3roND4eH5S8=
X-Gm-Gg: ASbGnctsbKIJFpITkFAa73PjWGCdUKTBY0PUqrFkS+p58xPXIezmyVyWm60eUSd0scr
 v7fwlppdjtiEy+iIgzUktmjgHqeWKkTtO4oRZ7RhjgnAzrQgx4mz8YqOSzesXwx8KxcPETv2nj3
 LK5v/d+hdgRCFgcCQvoNForwkJYGNibwt6yEGOt1rGO6pPppqOnXacj3dAqdq1uL482adpiphH2
 CLWtDVZMVHmgcpo4fYLq/1tTPXNebeKp9Um+4igc3SGRWTvo8ZAKFZ5IRuFHN3XGdQFoJ1Zwv1W
 2xs7lvbmyYDKKjjqjm2tCqZX6ckcCm2bJW3+3bUzP0M/bl+2uanwHQthzeyg1pFD
X-Google-Smtp-Source: AGHT+IGeMcr72Uq5QdMLgmO8502mxkb+BzJ7sKyMm3tCu+t+wSGobhB3Bz7l3C9OmZYJ3bkiu3BUCg==
X-Received: by 2002:a17:906:6a19:b0:ad2:1b0e:bfe5 with SMTP id
 a640c23a62f3a-ad52d443017mr24013566b.7.1747324692452; 
 Thu, 15 May 2025 08:58:12 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:11 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Thu, 15 May 2025 17:55:44 +0200
Subject: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
In-Reply-To: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Initialize the debug uart only in case CONFIG_DEBUG_UART is
enabled. The _debug_uart_putc is used internally by debug uart
functions, so it must be also included inside #ifdef block,
otherwise it will cause compilation warnings.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 lib/efi/efi_stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
index 40fc29d9adf7..5172cd78a7c0 100644
--- a/lib/efi/efi_stub.c
+++ b/lib/efi/efi_stub.c
@@ -83,12 +83,14 @@ void puts(const char *str)
 		putc(*str++);
 }
 
+#ifdef CONFIG_DEBUG_UART
 static void _debug_uart_putc(int ch)
 {
 	putc(ch);
 }
 
 DEBUG_UART_FUNCS
+#endif
 
 void *memcpy(void *dest, const void *src, size_t size)
 {

-- 
2.43.0

