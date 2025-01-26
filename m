Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62073C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836AC80F98;
	Sun, 26 Jan 2025 19:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K85OFuK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D12C80FB0; Sun, 26 Jan 2025 19:44:03 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EEF80F85
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so293908439f.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917039; x=1738521839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ9xYK6uC/QFQFdVNA3qhJ9mPn3/xbuAJ9WKyG/qmt8=;
 b=K85OFuK4xxsrC0HkQ14kJ/wcrolsWhVjGUSyGCjG6RUk0O3TDVlxAKe7CMUlLdPiBd
 cu9WPKZ3LQxHu0pK1KSBvXJhEdUDgBhVGdM6DJLl0UnQuV9Tg/yQFQ/sWgO9Urxy2/V9
 O7OYQc2WCi6W3RxJJ3vBqo2R6f4jWRW9RZ/Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917039; x=1738521839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ9xYK6uC/QFQFdVNA3qhJ9mPn3/xbuAJ9WKyG/qmt8=;
 b=kgXnjMHvW27nJ883TBjSIGiTnkaQrw8kRKHAycWuHb6daM+bWTUVdLn5AzPM58+tnY
 gAX3P2KUTiUZq2QBCDeyPa0LoMQ3ahN2v7ZFwQO+eYuYF81VHPK9/3eVPtPrh2qL+Ed5
 36XZiJwuq/0IGlfubrfVtqpzmZsnrXv5S1PA1lXanN0hGBnC4bpMQtHvom4iVq38NWfK
 7y+jJtNKZsrcRO9Vtj5N3KaHy7uNhkLDYwC4FtZ7woka9wIMG2Ivxcg+Ubvm1/IC7smj
 kdhRELUYiZDvPb2p5DIiPJvPFxkr4L7h7oiuqliQ4yO0E8QlCAwJfRkJH4IQ3+Kp7LRp
 9tmw==
X-Gm-Message-State: AOJu0YyuZnuqdeALmzR1u9srCaHBjkqx3KFPClm8llCZvAD+sbSN5s9E
 74lU/wXhoCr3M4x+Uj6D3EDs5ZDktxBnVeWwQNhfN5VoSpZjFohVnf+wEpMDiRXOGxj9Q+FeC0c
 =
X-Gm-Gg: ASbGncvUWJDXFuUNADUK/Xcj20Tma/5IFhbJ7/THxMs6LYsAQHUEGQN0LxvjnrUhKaS
 c2aJTtE38slTH/5Z8oE7LKR+1o/IYoP34X+HheZBf1ybv06jTx/C+OYxtNUsu81ZVF3zx7/st2K
 MWvkbaom6TW5lTKEFyEfTF5AZ2BmpQLykMREc/RlXqOI+zZ/0R/zfoiNVNL9Stj4Ru8q/N6y1eF
 qidTnbiFBZRpMEyVxJJUH1jZYhvvNaiRfhfQmDqPcEuLe0VR9MCNP3VxDam+21ZZN3vBQqhZXns
 NG+j0iZnAik4H+xYpXXA7mvW1KyTfKq8nZIoaa+YKQ==
X-Google-Smtp-Source: AGHT+IHjPwQY96QixwhbCWqJ+bIduSpnBJRPKCeTo28iKo0frDhIx6KigcsGBWcr9iqFpqSZ9caI3w==
X-Received: by 2002:a05:6602:488d:b0:849:a2bb:ffdd with SMTP id
 ca18e2360f4ac-851b618abd4mr4096284139f.4.1737917039037; 
 Sun, 26 Jan 2025 10:43:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/19] spl: Avoid including hash algorithms which are not
 wanted
Date: Sun, 26 Jan 2025 11:43:16 -0700
Message-ID: <20250126184333.4058848-7-sjg@chromium.org>
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

Update the build rule so that hash algorithms are only included in an
SPL build if they are requested. This helps to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 3f0936b0a27..ccc6df6fc2d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -74,10 +74,10 @@ obj-$(CONFIG_$(XPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
 
-obj-$(CONFIG_$(XPL_)MD5_LEGACY) += md5.o
-obj-$(CONFIG_$(XPL_)SHA1_LEGACY) += sha1.o
-obj-$(CONFIG_$(XPL_)SHA256_LEGACY) += sha256.o
-obj-$(CONFIG_$(XPL_)SHA512_LEGACY) += sha512.o
+obj-$(CONFIG_$(PHASE_)MD5_LEGACY) += md5.o
+obj-$(CONFIG_$(PHASE_)SHA1_LEGACY) += sha1.o
+obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256.o
+obj-$(CONFIG_$(PHASE_)SHA512_LEGACY) += sha512.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(XPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
-- 
2.43.0

