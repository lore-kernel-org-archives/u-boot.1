Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11993CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D32F838C7;
	Fri, 17 Oct 2025 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dfL2zOFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB3083804; Fri, 17 Oct 2025 15:19:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD1083837
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso9902075e9.2
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760707163; x=1761311963;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ervyBjo16SgZZlg93nb7EegynnAsjPw1EoB+QmsArpk=;
 b=dfL2zOFO1bora4AIVqrXUF9soPTPmqBnzPCS7pNItPl/cgG/yOLl0N6Z+1fxcdx3rJ
 Hg9qti9RFVUmk+wCg5wIzrq1CTIuBTNoi4THeCDj228lamdgV1+oMrE/z3HdJa0SiqxH
 xPbnkRhi64ndZmTbCe9j2dLyOTn//1ZbHBgTTSf0MlqSjIrotLdjnBlf0HMUYQl8C2Ip
 LxShlPlq7yeu58g5PE7ye+D/99wnAsLei608y/6dhCTXM3+DDOfSHvQrjHek4VKN14eQ
 Y4E2c40cRasazdyubHgA90swtqkFQOLCph7I3vP3lm0yfO8v/4Vwu0bw43ZvJFKJayrn
 LUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707163; x=1761311963;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ervyBjo16SgZZlg93nb7EegynnAsjPw1EoB+QmsArpk=;
 b=X+TLux4O/hq4nRiqTtofdzj3nuqzEuPUHm6khc0zR9wIU9Asg69IZy9xcjyFjy/bYw
 JxsZWmbD7/qBMOlGvXk2eIA20dcriPPTNwrTtp3wu4WAlV4IkCvbztyXJ86eiosJUkDj
 D8kboucL8MRHBezm1K5bXL85SC4wuFchGci6v9JDGlQSN6815aNblNeFboCTgXIDkBgh
 jMUS9CTvtlyfFThLD8oEHP9QGyxrXDTQ+Pwl1IqYDnuo+I3LSjiJPWAqsJgegy+lz2fw
 RJhyWFglMFvWGNNV4aB4mPDnxPMvBwXGUb0oI/QxQA4LGNhmJ26mjADIC7zsRvNDfEIj
 VIxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXLMq6Dk35N8e///cZfgxwSUvkX5BlGLfPuUfbYdxjlXo8zwxXFu1/Cs5Xn70UV9Bhtja4xMc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh4q4UCuIF3hNVl0zni1jSqx17As143tgc7Sv1TLl6hPSyi7L5
 qO5qSiO0F1N1tJAZvjycH6s1WV/sL+iU6OXI+qeBp/PWyJbgtjmMjePgYdT7w0M9UoAHHtdeE4w
 yILS9
X-Gm-Gg: ASbGnctJFC2iYinUq4WaFKW/pyUJ1lE5mu5Iy77F0x7qhsQLhxQyoWmQWEgo8MoYHkZ
 riKMZO3SXXHySSmRuKlV38X+AbFk7ox8YXj9rK5TmUclQfggYGYAzem6aseeU9HeKFu48QwUBNV
 hH3rUe5b9ADsdFBk9PgsA7uCZDf0Xd0jjbvVltml6AwpYdP6+bX/DQb7reE1FjVEF1uOjCAmmPJ
 Ch7QD2lGSY1xYDI4rhGMdcwGMQ9K1vdstdb5Re+1YTdJbuXDycB6tthm11IGzLAuiGFbvHfp04P
 gkCl9UxC/mFz7EDOMgMrqcttrhzkmihblD1I2rbQgF0N54pDcb6SOASGyGk0qxAEiIlBHY7yxLq
 VsCZrYHsk1UIir2USHe1yPEDoB71NuzPp7Ri9OfqWVFPXuYmrZQ4Kq4R/YO3xoeqFRtPrkwTshu
 dMFzwjIgIeScM2gH1faXgqLj1Y
X-Google-Smtp-Source: AGHT+IGma1cyivmhpgb53uq8YSsTgHmfDYBBKWRz3+w8RqWsE41+G+PGk6CymOglITl6x5o1ZUEYUw==
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id
 5b1f17b1804b1-47117872663mr31347345e9.8.1760707162841; 
 Fri, 17 Oct 2025 06:19:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4f9d:9005:7d78:d1f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44395465e9.10.2025.10.17.06.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:19:22 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 17 Oct 2025 15:19:17 +0200
Subject: [PATCH v2 1/5] boot: android: import addBootConfigParameters()
 from AOSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-bootconfig-v2-1-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
In-Reply-To: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
X-Mailer: b4 0.14.3
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

From: "Mattijs Korpershoek (TI.com)" <mkorpershoek@kernel.org>

To properly implement Android boot image v4, U-Boot must be able to
add additional entries to the bootconfig.

Add `add_bootconfig_parameters()` to do so.

This has been imported from Google's U-Boot source[1]
The variables/function names have been reworked to be
compliant with U-Boot's coding style.

[1] https://android.googlesource.com/platform/external/u-boot/+/7af0a0506d4de6f5ea147d10fb0664a8af07d326
Signed-off-by: Mattijs Korpershoek (TI.com) <mkorpershoek@kernel.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index e46dee0d9b3..3a0a934acc7 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -57,6 +57,44 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+/*
+ * Add a string of boot config parameters to memory appended by the trailer.
+ * NOTE: This function expects bootconfig_start_addr to be already mapped.
+ *       It works directly with the mapped pointer, not a physical address.
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
+		/*
+		 * When no trailer is present, the bootconfig_size includes the actual content.
+		 * We should write new parameters right after the existing content.
+		 */
+		end = bootconfig_start_addr + bootconfig_size;
+		new_size = bootconfig_size;
+	}
+
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

