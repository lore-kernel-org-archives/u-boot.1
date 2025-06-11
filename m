Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E89C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8C682B0F;
	Wed, 11 Jun 2025 22:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yBEo6d5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4DC82CBB; Wed, 11 Jun 2025 22:25:12 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DA7828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so222312f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673510; x=1750278310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iRnpuDsRl+JlIXPKvd8K3Ryaye9eFr4JW/Zljv0tmw=;
 b=yBEo6d5a2CzlNWj2ojENNckUq7ZYhCjVQAmuvqDio2hVFsSP6Cl1lkP/F11llLsWMC
 zwG89mQ4WqtQuJjSUBSxfzczLu2z2ejbEEGg8sNJew4bNiUqbAWvH3sQPwD0wr6DyvXp
 ZNaUyrKJWBCX7w2srPTXozkats3IX+pVU/l9sE86V7KJWcqMMPOfgiY1hZIQGhdcvlK2
 NOkndJUBSdf2qbspqiRW285meOiSq2fU2j7ngpc8CWztVreBC0QzX57XMe+GHKbpM9dP
 ba2Q8cRt1UVKmZIMnTzVh1d6zvMm+R24PPp6bAt2HLJePwJExBrN4Og1KF0Cl/lK2+gc
 Qqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673510; x=1750278310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iRnpuDsRl+JlIXPKvd8K3Ryaye9eFr4JW/Zljv0tmw=;
 b=wtlgD/DjWsRdLwU13Mk/Ki+M5/ZxHiirbpKrNsebSgg6Wbyl7VzR7tzsM22hOFBk89
 1aga2lln37TqMNHlPJLtA4pDZoueJUGPRp3pONYdxvaGq0aJCeOOkdZKsouq0h5QfR6z
 S5qZmRv97exWHmsMQC3wQDil1EtmsBsTwZYJkCyqbQL22gs9hQmtSYU1BjeWvS5A9Gec
 948wIYGtdnUMGtEy+41/dsxw0DbmJjVHGYMq+t9lKfvJBaeCZbLbhym71qxbgfNYsFlJ
 2b75NsWIymmkoIv/JfHtFGIR31i/7k4upbEuURHMFng2dxjEX6z4AqZbPzh4fJ4Peiax
 OdVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS4NOTrC/vhx0GYW2+RPzuWM8A3TVqKjq4OeNDVLoTatfvNuFt3cYYVl5c0W5u4FS6rm/UxAs=@lists.denx.de
X-Gm-Message-State: AOJu0YzZoBWyP888fftuMzyI02For82QfQOinczONHslF/P8vrk0fgyf
 /s9kGPnyNnN+6Svcrft+eHfdbbS2Hr3UCpKolMLy7aEVSy5DIdg0phv0aJEhTulmiCQ=
X-Gm-Gg: ASbGncuJNh51W6WW6euXUhCJfnGT45p+44saYtFZ5Sx36+UYzjuLh9PB5zqcWgCQ4CD
 UpIRZ6gBandEvzhhCMiPSdi5vqqaAnRBN73JM2esC/JJ+lW6OTTu/IOSf3oWlxczp4XopeJL8ed
 uZzsGqMQXy958TGPD8C4DiAPxrmRKszyotzpjDtm7xUVlnIeAudjwPqOlfdQCL3yAvhbjBTq9C0
 KDa8BMkXjWH/h/3Z5m3i7HjxDVzoBDMnJ+0fXn3Dj5JiG5/lP3SDuhgU6yELGLDm+g7o1H4R8Wj
 tx8FoTzAraj+8yIczTONB53X03uWturnZpiMTsfQ0pTq8+3IZGLUj/U8KM8MzMjwqkCs9eDdJKZ
 XUjLWCOsHi1IEk4gH7Y0A7aaZn7BuHX2VDaY7w/IH
X-Google-Smtp-Source: AGHT+IH1eVzmasPFV6WN3OFSln3Xo6eOgbzz6FaEvHL6wzLoiDYfDrM/5GH/dXDyj982TjkIBNGbzA==
X-Received: by 2002:a05:6000:4023:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a56077b0e3mr516059f8f.47.1749673510469; 
 Wed, 11 Jun 2025 13:25:10 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:09 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 07/13] kbuild: remove meaningless prepare2 target
Date: Wed, 11 Jun 2025 23:24:34 +0300
Message-ID: <20250611202449.2317279-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 4f1c1008e786 ("kbuild: remove meaningless prepare2 target")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 2b9516bf4ff7..bd0866dc4579 100644
--- a/Makefile
+++ b/Makefile
@@ -1949,7 +1949,7 @@ include/config/uboot.release: include/config/auto.conf FORCE
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1964,10 +1964,7 @@ ifneq ($(KBUILD_SRC),)
 	fi;
 endif
 
-# prepare2 creates a makefile if using a separate output directory
-prepare2: prepare3 outputmakefile cfg
-
-prepare1: prepare2 $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
+prepare1: prepare3 outputmakefile cfg $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
                    include/config/auto.conf
 ifeq ($(wildcard $(LDSCRIPT)),)
 	@echo >&2 "  Could not find linker script."
-- 
2.49.0

