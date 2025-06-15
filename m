Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C26C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 09:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6048129F;
	Sun, 15 Jun 2025 11:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLKO5yRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170418144A; Sun, 15 Jun 2025 11:33:50 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C3E807B1
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 11:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1978016f8f.0
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749980027; x=1750584827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QWiLPikU/cTm9hwDQx3jYg0y4ryHc/gDP2XefYYdMgU=;
 b=NLKO5yRbb4SQK79SPzVwykoYgi2PSEm6Iu0QEDjchlqEhXWQc3XeKu0rnSpIdqugoD
 r2ZtBdN/yzbrfDbux4w8gWobiSgULvAz5lb51nvAt2s1t+SslF5zhODi5wuvufhIL2h0
 Zk6s5L5Z8lmQIcZTAvtZCjAu45TGreU+jCKZiLasgPP8918L2B1kYOt1k+9TF8Nmw6Ak
 kM2RGFe2ztQMCfr0ZVyJXn6487EjO/EPLMVhl2k0LEjeQPHxCD02v5lsxHCFsrfXyd7P
 WXI90qWe1mzUQHr4IXHgJ6+xdEBrKbO/st7BN82funNfItPsc7hF0NrZ4EdgjjqBHz5E
 3A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749980027; x=1750584827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWiLPikU/cTm9hwDQx3jYg0y4ryHc/gDP2XefYYdMgU=;
 b=OFuORXhT5QaqlujpDItkuIlvpFdej8w2WxPzAj/sV8jWmQiQxrpVNEgnNYmcBQk6V6
 izDB6NgRQC6k1/a3nNfUJgUgCaTmwvl6WVZbmkEC2d7/x+1ceyb5V8ZijxhXADGvl4GF
 pkTSRpaUzheQMiLKMRqznhl/0UDJY7cWcqUpc79mHMxy2gyel/VQmJMTRYE+tgjP7riT
 ibVwamXGcSP1DlmteZaH9hA9zRbLBkt4lx8z26vOlUG6pu0s2GDv8raXfAAeJMTIqVwg
 G4Hky65m8U6bb2LGXdzTg/l9lnaQronjF6h8VE/j90JKlUDn5VQelyizr4SgDc5UhWvg
 AoFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEH58tXFdws+2dusk1d20AmibPVyEIs5ftTHMQpx8hnY9HLyJyG/2k9Hw2QIwjwTHdP+wFg2E=@lists.denx.de
X-Gm-Message-State: AOJu0YxoT1fhWintgR1OAIHumZtH/iXCSVay88rfJFtml4pYlj5JjEvl
 JZWVYxH2UgoX/x+vjnwpADAxAsHb7krMqBhK4Z9x3aE9A8PPIAGHcj+P
X-Gm-Gg: ASbGncsD7ehhu0YMMWManGoB5T5pw//IqlLpjtThQiPQ89E8VhBrV3x8nIgiTqbGCaE
 G2bs3JYfJHgY7/tfVOBO8PVQIRsHJOMVNGBgtbzvZ6lZac6IMGp3f51m/Jtmbq2iidN1uuOOMLX
 yzi+Ni2rRfvrU98GfXFP+Lax7JNx5CQOVgycnxA0y8kBJDOEumsX4809bTmpHkGYB38tIsgcSrO
 t3fN9dfHw4E/Frwtmm9sm4MgcRDWuIniVIbW+OySDuGqNQEgH70ySKVvAtiYbgX66YmxcF4JUnC
 1cZQLKHkysMtdUfi9jheLEklO1QDUUDSefd75oJNMzmyj4h87X4nme1PrZb5EKXyPYLExHx81iY
 B32Cjij1uobeRMllNFbu5SXf+LLSg+5z1g0FIzA09yTzZNez3T7ikPpIxOgss4/EbpFuCGDfjum
 NckZ+uB2p6JXdZdyKk5Q4+
X-Google-Smtp-Source: AGHT+IEQJN3Bb3XtRUL1ZAlf/Bf15hY0pkrm3h2BQKZ/ZIEroya/DVw/a2KCnXQu14o36NvGTzUUgA==
X-Received: by 2002:a05:6000:40c9:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3a572e67394mr5133432f8f.14.1749980027310; 
 Sun, 15 Jun 2025 02:33:47 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a577e928f7sm3580993f8f.64.2025.06.15.02.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 02:33:46 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] disable VBE by default
Date: Sun, 15 Jun 2025 10:33:42 +0100
Message-ID: <20250615093344.159920-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.49.0
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

The VBE protocol needs explicit device support and as
such isn't particularly useful by itself without that,
it also adds size and the potential of an attack vector
so devices that wish to use this protocol should
explicitly opt in to it like all other large features
in U-Boot.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 boot/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 30eb5b328d7..e8c3fbcb11d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -635,7 +635,6 @@ config BOOTMETH_QFW
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
-	default y
 	select BOOTMETH_GLOBAL
 	select EVENT
 	help
-- 
2.49.0

