Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74007C83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 16:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D757833C0;
	Tue,  8 Jul 2025 18:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u7Ev7PjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD0F833C0; Tue,  8 Jul 2025 18:51:20 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D505C8331D
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 18:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so53001025e9.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751993478; x=1752598278; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BY6plIVMXMeJKRvWsKbGUeUH/c2ZqBoNnc8fe5RqvKo=;
 b=u7Ev7PjJdPrNluMt+xQJtX4Zs6ng/0MKHQ3/JxrlBkUGIbjBFEuW0AXYSD3GSEVO2j
 /O+ojQhi7NcFEU91r5dtrbDZaRtrKNl/0lcsn9WAdfU2NTZpQfZgn42+5YTwxKqiJiKJ
 Gm4GNbhi/tUuriLx/OD2lB+Z//e8HhCzkLLjCUHdi6tixU9azl5a6k0xM2esMCa+JrnB
 KQ+eR798yEbler4V4ydI5AcALp+yVnBMJaa1Fq0XCGBhDSrnpfNzf/ZP65JsmWpikZ3u
 /CM0WAluDRbbHycw1BUMVaCyczydHxM7v6cNFPKXJKt35VxdRAi6T13aiSWYY5B1Y0YT
 L0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751993478; x=1752598278;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BY6plIVMXMeJKRvWsKbGUeUH/c2ZqBoNnc8fe5RqvKo=;
 b=qlqlhQDx0mZ6YCvjPxI8OY70j7h9PLJ2CJHipYZOoUNpmj1BuJQfgSD40vny8yljIH
 W3BSb6Zmd2vaT53iInaVq5St7AYBwlmMoRXqv3MbAFdPyahiAtiqUQ0LxITqBJkpS1Cu
 3FhpdZLO6gFjnnF9r+AOJiHdrESQZHchw258q+BlcKRXY0fZcIOUJo1+/ZzncC/9Nyor
 UB32a41YFSo1CHpO31PZzhYXQGR0uPlhdgas75b1Vl8X9/hHhY39eCnCR0tYMbKO7LMD
 L1PhR7phGydN+0pYe4LvEJYRL783obKRqiCygCJCKbnMj6oiNy87ND/uGI3cb4Vyc/Hx
 THRQ==
X-Gm-Message-State: AOJu0YwWbAfc3zMmFMhWwR/tECj7+ogIbeMqXD3V77LG/NumijLHP+/3
 Viw+4M83qYayiYk1c7X11c+J8hzetk1EXaNk1+fJCYoMpyCMf5UCAmLsvTdGWJSRGYZAI6mxkOa
 k+KoD
X-Gm-Gg: ASbGncuipxsUw7xMAuyA5/s4QQH/+DSP2pib0fzjBZLEnGcYGM0UuJlcdv9Q5blFCMd
 jUJNrsoGpzblhcTIcyRauCc+m3rf2LQZtbzmtPn+ypQmmyQkJuwVxhZhXxynncgMi1bwlFWLWmj
 8+P24mC2TL054LTHoiuI9B+AS1y+eNrT9wZj1Q2Ox7J8j9Jfua+Lj61GBDUtqn/GFkjtSEmRA6S
 epCdCfqDC97zjVZBBkMcPhAe62eQGFAEc7pSoqYgj8sbhyoRMkAKIRk8tlNZKcND6u5A+01U2u8
 v4eIX6chHJrUUNiU5Aef1wFupYkYCwCF0SZOEXpCRtXo/xr4X9UyXqU9FmngJ5ri5cMg5Hk0a64
 EnuiXhI7U9O4XeFyxCMNbnvY=
X-Google-Smtp-Source: AGHT+IG1jB5W3Lm6zGlkhFK0n7O+WYiB8KzxVWJvluyj7b3wCC1hIZElVuEgKHsm1Sr+418L5WbC8g==
X-Received: by 2002:a05:600c:1396:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-454ca33d1edmr64974375e9.24.1751993478104; 
 Tue, 08 Jul 2025 09:51:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba29sm13232481f8f.2.2025.07.08.09.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 09:51:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 17:51:16 +0100
Subject: [PATCH 1/3] net: Add parens to macro PSEUDO_HDR_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-net_fix-v1-1-292b9aa20f31@linaro.org>
References: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
In-Reply-To: <20250708-net_fix-v1-0-292b9aa20f31@linaro.org>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reports a warning about possibly needing parens around the macro
PSEUDO_HDR_SIZE. This will not affect the one place the macro is used
but add the parens anyway as it is good practice to have them and if the
macro is used again in the future it could possibly matter then.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/net/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5022fa9dc1b..6f4d58a1234 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -235,7 +235,7 @@ struct pseudo_hdr {
 	u16     len;
 } __packed;
 
-#define PSEUDO_HDR_SIZE	(sizeof(struct pseudo_hdr)) - PSEUDO_PAD_SIZE
+#define PSEUDO_HDR_SIZE	((sizeof(struct pseudo_hdr)) - PSEUDO_PAD_SIZE)
 
 /**
  * union tcp_build_pkt - union for building TCP/IP packet.

-- 
2.39.5

