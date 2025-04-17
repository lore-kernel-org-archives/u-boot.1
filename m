Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0FFC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6351E8307F;
	Thu, 17 Apr 2025 14:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="UOj++BSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D8383019; Thu, 17 Apr 2025 11:10:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7983583037
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so9542915e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881009; x=1745485809;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l8Y/hMBnU99mPGeizQo+Re6ufV8p6NWpHRv0PDlzBr8=;
 b=UOj++BSZYRXeZZR5ymW3I7bdlnN+2AA+lxHCb5qWwzRawzhXQ/xN1XAFgIJG1nD4uw
 EpsXgek8LbgdaP4mjXYEKz4mugF5RVai8yS7vFHukktMyK3+GgVZfEwFtM8oF+PYO33k
 59RX7omQT5aUnkulcyuLtmvETy0SbFLOtz4Ku5z6aMCnzBJFmAD+U2X2cNwX1mxtuAQ0
 gbhLH+ziI2hgXWQLxcdN+h21ywmil2LGMN+dv704iT/8/Zt/dubnv4OR4GgYgsyOJpS1
 abdK4DMb+7Up7qZRf+mn4kWmumnTzEQbhaoPisdmKSRW2ZgjqfXESlUeslEWl91iyd+E
 jAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881009; x=1745485809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8Y/hMBnU99mPGeizQo+Re6ufV8p6NWpHRv0PDlzBr8=;
 b=TJSErAZSOWWpg8X/bFJ/fw8yITr8REZhSPD9rQl5yQediFsuS7zwnXLkra7ZP5HU0J
 C7n23YTZ9LHB/vWS1eE96tbd0MqeDGiMbCqcw4PgWbugpmhX0xSTZqzbyvj9VCRE3KZC
 kDc2OOIPkuQYkXFTkfmqwtSGYJa0ZZJu4yMlx2ow30IlleiskqYT212rsv+wR3sEatih
 HtLyxi6kf1HTMZjT54TyW27SygOt4RKFJK8CHbXKTnEZ6nDIVBKSYeVlCcxlJTdM2YNN
 mrRsQhCkTGsMwSDnME/zsHoVpoBHHFam5Tdsl9jOC+8BYnStLPyZRghOMp8SCZtQU3mJ
 Loig==
X-Gm-Message-State: AOJu0YwEm/CpazbW9Z/17KqaxHeOK0n8mh90DnsMkVoE9VkDVXtnGDAI
 V2hdr0GAu98tNSYp9dj0ImD2dE+YX8N5+Ewzfj8wSIsYgS5YSjzQd1XF0bw9H5LHSvZqymzHXox
 C
X-Gm-Gg: ASbGncuSmNzhpG8ikcR7+UDYqotbjUY09kV4BiRZcndlEGy+uz2r2xC/uPTjs/WQbsA
 ndPamAmj241ldFPwCp//IRzyj2/A+SSJXXLMySJD/l8KwDzj1p/kZ+LnmHxFiIQGZ3HT6lbs6jP
 RDkoiif8c57414P0sG8MDGPFwIBLthicmHXIeTA4gIj+mWyrTGbyJW9YMbHXe1A7ZYR2u8MsvtV
 rJWrthroa949dmjFXFcdBfW5rGylNV6qTj6LmTB3qshLGnTHDEpqUuXZHsyC7PMK1lRBUSDvARr
 YZH5ZQGhAZ6RzZFg6KgxmMdnCPWIfcBsLCsN3Oo=
X-Google-Smtp-Source: AGHT+IH2Fki1aGnbdShNyRxzNrTX9mDvF5qMmShwbQycuxhDDrnD0Es2oYlHKfLZcC+fo9ko9LLUuA==
X-Received: by 2002:a05:600c:8711:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-440634ad300mr17792335e9.4.1744881009397; 
 Thu, 17 Apr 2025 02:10:09 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:09 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:52 +0200
Subject: [PATCH v2 5/8] arm: at91: wdt: Add SAM9X60 register definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-5-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

SAM9X60 has different watchdog register definition.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index a5accbae52186e99de0b113d6982a4cc54e36095..9ba5283123bcf637bb1c3c66f7b98104e232ae05 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -33,14 +33,22 @@ struct at91_wdt_priv {
 
 /* Watchdog Mode Register*/
 #define AT91_WDT_MR			0X04
-#define AT91_WDT_MR_WDV(x)		(x & 0xfff)
+#define AT91_WDT_MR_WDV(x)		((x) & 0xfff)
+#define AT91_SAM9X60_MR_PERIODRST	0x00000010
 #define AT91_WDT_MR_WDFIEN		0x00001000
+#define AT91_SAM9X60_MR_WDDIS		0x00001000
 #define AT91_WDT_MR_WDRSTEN		0x00002000
 #define AT91_WDT_MR_WDRPROC		0x00004000
 #define AT91_WDT_MR_WDDIS		0x00008000
-#define AT91_WDT_MR_WDD(x)		((x & 0xfff) << 16)
+#define AT91_WDT_MR_WDD(x)		(((x) & 0xfff) << 16)
 #define AT91_WDT_MR_WDDBGHLT		0x10000000
+#define AT91_SAM9X60_MR_WDIDLEHLT	0x10000000
 #define AT91_WDT_MR_WDIDLEHLT		0x20000000
+#define AT91_SAM9X60_MR_WDDBGHLT	0x20000000
+
+/* Watchdog Window Level Register */
+#define AT91_SAM9X60_WLR		0x0c
+#define AT91_SAM9X60_WLR_COUNTER(x)	((x) & 0xfff)
 
 /* Hardware timeout in seconds */
 #define WDT_MAX_TIMEOUT		16

-- 
2.49.0

