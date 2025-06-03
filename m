Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA24C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E65882A76;
	Tue,  3 Jun 2025 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MVgmV0I6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C5882A8D; Tue,  3 Jun 2025 17:14:21 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407F2828BC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6f8a87f0c0fso58506136d6.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748963657; x=1749568457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mjGZZI9EoJdg05mtRltCAHd5FJcNhRmPLkrev2xPwA=;
 b=MVgmV0I6Tb0ANCSPH3WjwMXJsh5aiw0p11LNl/uTaCxBu8wxtGgi4BAuYRQ6jCZrSX
 8A5htqidsgtQCVD7GzCGUdE0/VeQaKma558HCMJo1XnxhiJcLKRHY3Mhg/JYiZUaUXbf
 TYEoTniA6Z//KvAblJLMiRQWZ2JT34CjataopmlfLUpLcRBZ541b3K7VvkaTX/hLD9C/
 RACfvDoqqXwTWXeBZzUaBPO9+SavRaiSVzeCoBmojjenhMssAopQeZbGigKwj08/YyH8
 QELqplErBsbWEB8MloMj2+ffDBOymwsF0JA08H3N378InpuuVBP/5GVrDxaemesN4Lhm
 s6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748963657; x=1749568457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mjGZZI9EoJdg05mtRltCAHd5FJcNhRmPLkrev2xPwA=;
 b=NtwY0xS4tbQkrzQwTbpt2paLhF4bP9U2bKswXbNTSMUJj5dEBUOJJNb1IsHia3cCyB
 mmJ8U8bDmD9+xFecy+hq8zsFf99xSMXkaKgtB/A6/dg6QcGLLvO5jmBXVJsJcrL7E0f3
 x0kRQpKY1Rc+DqXtKm71hLMV6I6sSut4tpqDS9AQjaYtC36zstaepZWPmXpA54JNHrRi
 gcqckiv7SXgyttQPbwPZOz89fbfa6nLQhtXZ90gS12kSn3HcOl30Eds0iN8ulNCuo0b3
 H/5SIxLJYBuglY43cVo5COmbuZ5OXSHIcrVVBqR/Tz6ByYLqzIZWPlYiigA7oGUvFJXS
 tp3A==
X-Gm-Message-State: AOJu0YwhlIliXajbuLv/SvYY7teXUcOQ47kawi49Ydf6C4+BMk2Xe9sk
 MPPCtm/JjZcLliDQwCuvyP1N8Im92XWZIyCqMUhlToO12IpiQfxUCNJdIHNRtJ2zCyb/OZafgvC
 sQDGA
X-Gm-Gg: ASbGncve6tAI0bGU83pdcLTeuSOsIjjOLYiBRX8w5Q+Zy3fru8jQ+XRr4YHlzE04jUA
 6SO0Q+9jYBVUuN4OquUQE7P7nYg5hh1WJoAhsBp0EUiP6onO++qWoIqzuKMAw342Tel5xVCn/ov
 9Hd/9NG07Vsg76TmwB/3Zg/vrR6bip5uekaYhn0xmwXBbnoNfzWE7HPDcxKLzATXzeR+urZyfg7
 8bsWS+YnjeLq11soLznOzDzWJTKaWoDDDV/xz79Vt/fKJk/n5++q6xbyhZ71et0hmYcg4v9zoV0
 93gto7zS3EuhNWRmZBaK7MHOmbbwUui0ftYU+pWIz2NXna4gjmBKJMvBWt5ue8h6L3rn8Ez6/M8
 sUzlXzC9HK3pJ1SuxqVBHTOtBb19Tg9TnNHSc
X-Google-Smtp-Source: AGHT+IFCWsZJneayPm7zSMr9u1iAUSg9v8MurnppJRxdw+nuEIaOGXjZ65Gdg5PqZGq4lAq4PO1FWQ==
X-Received: by 2002:a05:620a:600b:b0:7c5:4194:bbcc with SMTP id
 af79cd13be357-7d0a1fb84a1mr2323686885a.29.1748963657563; 
 Tue, 03 Jun 2025 08:14:17 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a0e4063sm865388085a.5.2025.06.03.08.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:14:16 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
Date: Tue,  3 Jun 2025 08:13:58 -0700
Message-Id: <20250603151401.1709532-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch is to solve the sandbox building error:
$ make O=build-sandbox -s sandbox_defconfig
$ make O=build-sandbox -s -j2
/usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
/usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
[...]

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/sandbox/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index dd9b7473fa9..9a61e803a57 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -3,7 +3,7 @@
 
 PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
 PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
-PLATFORM_LIBS += -lrt
+PLATFORM_LIBS += -lrt -lpthread
 SDL_CONFIG ?= sdl2-config
 
 # Define this to avoid linking with SDL, which requires SDL libraries
-- 
2.25.1

