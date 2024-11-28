Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B37D690F0
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 10:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2E1893E8;
	Thu, 28 Nov 2024 11:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YuNHJlOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9874C891C4; Thu, 28 Nov 2024 11:14:58 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC35891C4
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso1740315e9.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 02:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732788895; x=1733393695;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tkWOBqq+Lp0suiTX32F0hJskD7rR7vljOoUjJ9arKEw=;
 b=YuNHJlOg6KOu+pSzFm6shTjTg0a2dyFVNOOfj5Ia9LueAUHeyTtomieXwi6ZEei/Om
 BNVg13zI5hU8UdHK8d085Ns0ZfqTuWL3m5V1EyF34ZlwusyaieectJyLg+jZnw/2Va9W
 q/DAMEcAGI/43TQj6AJTGDFEfxoJDBM2F22lKC0r9AplqMg/0fXNfewx26DnB578D16r
 1IVu1bdMfhh9zGljiLY5jydl1y8z0Y2PMduAA/tvqU0fCQ0+3D9cYXEeJWAmQykQbIFu
 7cIPEg3klp9qa2KWMZuT1sQZrof3yY9MawvP9yaXu2bgcSjpN/1lcRm/oDM4ZqTjq7Nq
 6kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732788895; x=1733393695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkWOBqq+Lp0suiTX32F0hJskD7rR7vljOoUjJ9arKEw=;
 b=DaYflG9jU9YA362VviyCS2cTSqDb0Zbuux5I7B7GtwWVDfGTdcVlrMOKX6lYRaSz+T
 1+hN5tavoi4gZ5+s44RA9JqmHAAYEqeP6aGPMnnfT+yk+B9yMS45MBWmbrk/7sDh8ioi
 RQobs4bbzr1nzLzWP54Kjj1X+q7LK5iMJcebs7pEONIk7lRkd0IvNusOTNiaHlEKfq5O
 NtKZuOjuq/DURyP0Q9Fb+dqbuImTBasIt9EmLonqKgUZWDEeqzDscEUNJf93BX0f25R5
 0LrAmduMWFYbyxJiNsL8k0pgmhCO1a8tOegG0QjDhDD3IxXpZtoL4S/nFOig+2M16J/d
 ItDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW6JsJP61IN5CUelfGMVKaqe5Dfn0oTbAu0OLQBrf2dmdh925SbgK4wbsOWdYpNbHkmSQJtnU=@lists.denx.de
X-Gm-Message-State: AOJu0YzPR48ikrsLy5NQzXvJwg4C8xxKyl3GJOv8dgn1xz7NHeU2HkOG
 nK0L/loiIL7LNDFp8eoegrKqwfny7nOalkVY+wTvx4tRxBbVQ0wWznoCIiQPj90xx/4Lias642P
 F7Fg=
X-Gm-Gg: ASbGncvE4aNp1sGt6CIHEzuP7zdQaGGzrHfxpO3lvQkrDsNBoAAhyOS6A72vhWzPJq9
 LNxKcf9XPCmmSizhtZPHz6okzOmB7z9wnZqQ8SaiZjQVuwGgl7ELESiB4R278IuNEx1YTsVoNCG
 pZh+/lMCPaWEF/J0rZT4aSFjAZEKzzA8BjcYfFA7spfte18upFZKfUA3zOveZj6Fls0XjQ6rY0S
 o5aNjRsg0GLRFAFBvXYY71W1on8MvvqK892Ae4HFxa4OFu0EYMriQ==
X-Google-Smtp-Source: AGHT+IFkxK7do7PhrFL+wMnO50CZ7ZKYgJkJAQI0A4Cj5KRHUD51DF+dAFWVzb8wtWe6JGgePMYtrw==
X-Received: by 2002:a05:600c:4f8f:b0:434:9fb5:fe04 with SMTP id
 5b1f17b1804b1-434a9df0803mr47751045e9.28.1732788895457; 
 Thu, 28 Nov 2024 02:14:55 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:91a7:bd7d:8e99:8990])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74efbesm48554535e9.7.2024.11.28.02.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:14:54 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 28 Nov 2024 11:14:47 +0100
Subject: [PATCH 1/2] boot: android: import addBootConfigParameters() from AOSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-bootconfig-v1-1-0e63a5dae82c@baylibre.com>
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
In-Reply-To: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

To properly implement Android boot image v4, U-Boot must be able to
add additional entries to the bootconfig.

Add `add_bootconfig_parameters()` to do so.

This has been imported from Google's U-Boot source[1]
The variables/function names have been reworked to be
compliant with U-Boot's coding style.

[1] https://android.googlesource.com/platform/external/u-boot/+/7af0a0506d4de6f5ea147d10fb0664a8af07d326
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/image-android.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 93b54bf8d793..05245a0ba918 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -57,6 +57,36 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+/*
+ * Add a string of boot config parameters to memory appended by the trailer.
+ */
+u32 add_bootconfig_parameters(char *params, ulong params_size,
+			      ulong bootconfig_start_addr, u32 bootconfig_size)
+{
+	if (!params || !bootconfig_start_addr)
+		return -1;
+
+	if (params_size == 0)
+		return 0;
+
+	u32 applied_bytes = 0;
+	u32 new_size = 0;
+	ulong end = bootconfig_start_addr + bootconfig_size;
+
+	if (is_trailer_present(end)) {
+		end -= BOOTCONFIG_TRAILER_SIZE;
+		applied_bytes -= BOOTCONFIG_TRAILER_SIZE;
+		memcpy(&new_size, (void *)end, BOOTCONFIG_SIZE_SIZE);
+	} else {
+		new_size = bootconfig_size;
+	}
+	memcpy((void *)end, params, params_size);
+	applied_bytes += params_size;
+	applied_bytes += add_trailer(bootconfig_start_addr,
+				     bootconfig_size + applied_bytes);
+	return applied_bytes;
+}
+
 __weak ulong get_avendor_bootimg_addr(void)
 {
 	return -1;

-- 
2.34.1

