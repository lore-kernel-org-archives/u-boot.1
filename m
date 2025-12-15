Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A95D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 08:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33C680050;
	Mon, 15 Dec 2025 09:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="gjaBUBBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC7780077; Mon, 15 Dec 2025 09:16:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69D68003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 09:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso31095845e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 00:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1765786603; x=1766391403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1sRWLxA4Fpf4BfMeU77n0cuKEiUw9Vx2UebJiHKpdbQ=;
 b=gjaBUBBqoBgecQRJ95e82MqjOjy/1ngfvccV8AHw8scbc6aM2BPkCsSvGlGW2B1ZKD
 cLMmFoMXAkWyvYcKy9lXiGuB+ZAp9FPwHlqvoFil/YVf+XsAWeUZbNruNCM8yqH9V6QG
 VibhtZuUV1TbPNLa7mlSbPhSCUkiTPMhFZSiR8P3/RGM+/pJOrHnGiyCP5DO/y9uUh4c
 44TetF5K2/ykQWYvexufINhNSWGfWekzhxEGflfNhf6Ylh/bacZk92mz1jqARkIBRzM5
 WqQ9I7XzVwgh4kKhPbgCErjMvr3ek9BdK5t1pGykQ8lYLcWwudpJ64vZxFdZDdKqDPoP
 JCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765786603; x=1766391403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sRWLxA4Fpf4BfMeU77n0cuKEiUw9Vx2UebJiHKpdbQ=;
 b=ZdL6hUh76PU3D2jS2Gfr13BNb/vLKiGZYRXoQq8NPZadYd+hak9mi1PGe2Tu4fN9W/
 YVOW8fM1moNDMaIguSbPojwguTCGJnWh85FaI3Wo/lKtP6z6zysZ9uYf3r7AuN8ijeHg
 8P/4TBGXzZl+R51kDb+JkKrKJ1YWc14+nax8Kwqn15eyjb96vJnGBTHho/StnEyNx3qZ
 sc557A6xphj6QISjXAKtRuCBBoToqWTXhp1neXBQ2lG+hY816XAU8itI3pMLh+ZITC/z
 +6GZ6L8adA9lW+Mtstwd+EWImNIWjACRFhEeb9Y2b0rIm9RVQqIQb6a5iDRwmlKKX8+J
 NFUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqOG8lkd2PmEavzEttaDkzqDThXQpu6o83OMqp2PplabymYABHcRlwEJstSUe6ousqEUmYqWE=@lists.denx.de
X-Gm-Message-State: AOJu0YxjYF8MxbwXWkI2hvuBT/oy+c8qRaq3jwLB2bU0N9S81XFqvnyF
 MH5VFAzCc6vGQ67pDSbgcGqyghiOkDfU5ZyqE4nvjjA9pd1BEkl6Uw9l0HvHfBQV7uE=
X-Gm-Gg: AY/fxX59w7pHfORr0zERjba3Wtttuww6QO0R4hLgYNf1sh0OoUEQ8yFqEdOQRfZAPhl
 PrVi8iUV1jwy2sR+x/7lB321CFFreKVd1oCszKAIScxn+NzHwz5sm7izZBAqnN1yd5p4PPMoahe
 2hd28NAj6gI2PA9uULtHuNSoLSV4bF+4gclXqN+M8bsQ2k2tgDVnWPEub6Ny0RWoFxbSaVVTbGr
 KAXJCd1N2wczf9GARFYAQS81i6/h9jCPGS4x4tHdSlQKO8F7P0MRtxKvea2PlmKIYzm8gLyVrtW
 eBaftt+RAhsQFLc8l351qEER8pd7PllV/9xwurZ+SRCIkrN0H5bwnv3c1eQW9NThMXkbf1rmPV5
 6LG8uxsPiYKoUszba3gspPmhuhoAaz/i3ewR/Qsl1fs3kZbEu7+cBNySfjuRv4Tp/wjOLYzw8YW
 8WKQxuQ+MszkwR39YD8RqBU+3BEBhOjMg2Yvnc28bFqiETGieF6j7w/V6lsDxl0oDtrrzvtdqXo
 YvLRLSbuRaPGBGy
X-Google-Smtp-Source: AGHT+IFZx9vVqSvGC2GLP7BXDbSAu8vxyRiolYk022aXyNKcDJPKuu/ANuLavQP+sliEPfNB7Jl/Lg==
X-Received: by 2002:a05:600c:46cb:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47a8f2cacf3mr111423725e9.17.1765786603119; 
 Mon, 15 Dec 2025 00:16:43 -0800 (PST)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f7475895sm9157705f8f.33.2025.12.15.00.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 00:16:42 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] x86: cpu: Fix crash on FTRACE enabled builds
Date: Mon, 15 Dec 2025 09:16:39 +0100
Message-ID: <20251215081640.1827840-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.52.0
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

When compiled with FTRACE=1 U-boot will crash as %rdi is clobbered
in board_init_f_alloc_reserve() and board_init_f_init_reserve() will
memset the .text segment instead of the global_data struct.

According to the System V AMD64 ABI %rdi is not preserved and the
existing code only worked as board_init_f_alloc_reserve() was small
enough to not use %rdi.

Fix that by always passing the correct argument to
board_init_f_init_reserve().

TEST=Can boot on qemu-q35 with FTRACE=1 enabled during build.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
Changes in v2:
- Point %rd to bottom of global_data struct instead of top

---
 arch/x86/cpu/start64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/cpu/start64.S b/arch/x86/cpu/start64.S
index 78e894d2a21..968a2929d0b 100644
--- a/arch/x86/cpu/start64.S
+++ b/arch/x86/cpu/start64.S
@@ -16,7 +16,9 @@ _start:
 	/* Set up memory using the existing stack */
 	mov	%rsp, %rdi
 	call	board_init_f_alloc_reserve
+
 	mov	%rax, %rsp
+	mov	%rsp, %rdi
 
 	call	board_init_f_init_reserve
 
-- 
2.52.0

