Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2436E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F7C89462;
	Sat,  7 Dec 2024 18:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XDAoI7PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509688919F; Sat,  7 Dec 2024 18:26:30 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2187F88DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-84194e90c0fso206975639f.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592386; x=1734197186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VavxHntR3p2/fvzxP7Xztcud0CIpgaP4QnTEVGJ1nR0=;
 b=XDAoI7PIfEhdGxWvddK+Si4+ohNfyNT/VgMmvCQcdIJZ7ui74n/XpvHjGsB8ED95dA
 kund9joT4lxypchqYe4hJ68rD2uMhHfdnUOzkdOYWjk2orTSBqD0XbDSycflhiIMxzcL
 MkqPn8tp7lAJSzvvNRzG9InTTVK+wJQUp2tRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592386; x=1734197186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VavxHntR3p2/fvzxP7Xztcud0CIpgaP4QnTEVGJ1nR0=;
 b=ILHttaRu1iYM4o3SogRH0mElqGu5uV9RICyf+LhdoC9ml5BhfIU0aG7I6/T56wpEOW
 rxMp5ObvnbXtDUS6psFkF5rNKEIWGwcFNNi8xCWb0KnIAX3cs7KsZbV9xJLLHEv8fF77
 8xb5wTGDIFhW/0A1k0qWrote0/Pwr+EELl6O5W9mWA+qkGtCBiQPwoCjpWO7MaFxucO1
 i+KWMDSW5+nMcSJSHm/kWbZl/QdDKStoFbEWvyn1Lg7Pfet/ZidnKUCKvXf8bzk6rE6j
 wX2c91NBDj+255/UId2axJ7059D3NupzRl1sDlukdoszk/V/DbxcsyMruGJt7yNkHlM+
 x4/Q==
X-Gm-Message-State: AOJu0YyGrlJBByXn9h5tsYCX7ZwDbwAtc8a+F0/iGex7Yij+vJ6CIeWL
 g1t2QnhcNRFCHURUVMsRi61rpzEvCPMK1CaWzyioSS9pFyFbvGzlelJZbNVXDvM6T2fdPPJUwpA
 =
X-Gm-Gg: ASbGncuDr5uhFilYq5+6jL+rDAZfNZcH81gMXlZ+Es7utf/pv9kbqhkzPyuUXtLlPCg
 qWQJMPx0J4JLwpC8ajgjZVkv4wtARBL5/zgyBjQXtSymMpilafwmj0P7iWMWCWllbO0Lmuohnt/
 XrARO8R9iBUUFTBMDqfvTMk2HsJ+Bz+u/t/R8kxez0BYs5u8it4o2iypQEV9PMfQctE/hPktIB5
 0kuc/73FE7TGX/oxg9nc7FJwV8Mu2vRied/sF1SPsheAdc0qEBgzKTlxiH9Dgr2+ifjezQJ8tuo
 aoxC11QLiTc=
X-Google-Smtp-Source: AGHT+IGbK2vGQt1NgMjyaJKXX2ChOrqbMuhKNj2x84D8gM4HBbPC6QkDlyYCFC1nfpi8hh3ReB3M1A==
X-Received: by 2002:a05:6602:2b8e:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-8447e20126dmr891819439f.2.1733592386401; 
 Sat, 07 Dec 2024 09:26:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/19] spl: Allow serial to be disabled in any XPL phase
Date: Sat,  7 Dec 2024 10:24:03 -0700
Message-Id: <20241207172412.1124558-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7c57eb8539b..91ee07f7079 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -837,7 +837,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
  */
 void preloader_console_init(void)
 {
-#ifdef CONFIG_SPL_SERIAL
+#if CONFIG_IS_ENABLED(SERIAL)
 	gd->baudrate = CONFIG_BAUDRATE;
 
 	serial_init();		/* serial communications setup */
-- 
2.34.1

