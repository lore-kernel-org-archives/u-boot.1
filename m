Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F824C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A09D82E52;
	Wed, 25 Jun 2025 15:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wPEqR+8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F4B82EA5; Wed, 25 Jun 2025 15:21:40 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B569682E35
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso1026038f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857696; x=1751462496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkjgIbxAHU8Zj90b6X0L5ImxJYsM1pvo4wIHkeMkn8g=;
 b=wPEqR+8eKgjXZ4t+irN2AB15uQeaMILPhnOOXH57xvi8kQoVlS2YPR7I38xjomM8s/
 OAxWmLwMRfWlfLQLr4fy6bK9BPKjFtkCuTqTlIue3oEoPIOZ1uGgIgs/6nAU1DmxWQ3Z
 lJWMiH6ev1tcWCASF/5cKOL1SbkCRb++i/9Rtaf8EhEodsTf9g9PmUAwd9vxlQITUXIp
 4xWpYEO8sSGG7ZnKBw4OV6w/Fb1DpuTBiLq+0EZ61pZ7o9jPtO4nhEX+MmERToy+5aGe
 cLnkrxc4u7TYcshab6a9rLfcsva7Szqv9oJlEt5cGT7X7ENs2Fxg99yp+22owgVurmap
 qhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857696; x=1751462496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkjgIbxAHU8Zj90b6X0L5ImxJYsM1pvo4wIHkeMkn8g=;
 b=wojxv64/6yAAJxqKkK/iS2RR5TIpcixfoCxJUfd0iR0CYmqnTIR4OnL4zhXgY1WVp7
 YVOeG8zBd+HytpOzehV0t8v8/3t+Z6Z4XijCgEw5aKJqj2vYr5trqahsujnIt83drmxj
 O4Gqf6NNn+2SeU/NLJiwD+ZF2vHAHIroca2T/Temr9mpC5brSK/2bKfgtFlc9BBMulUj
 aTP/DWgKo/ZuekKJmeRgGvic/AbvilOxzgIvxFVxoz093Tc3d5MX5kXYh8OdbiAIu5VG
 jjmGB1u3gIyvnoqKGcjTAK2UrNqogRHhCqZgOL8xaNg2Th5VPq1T+y0ynWyoO3xJj+mV
 0wQw==
X-Gm-Message-State: AOJu0YzHcX9/eHOIaNuxVXjn8xtadAoAJE+lCdqs7EqKqVyrn5vnJJHm
 B2veE3Pf+1i58LA9nHWMa6MYjSyXp3j6148qinHi7R6GQ8NiDhQsi8zcjVR40LSpVXc6balzhRp
 8Fl+szlE=
X-Gm-Gg: ASbGncsMh/sq3O64YDoOWfpZwhPQAja4fro/AhznKaOLTmyi5YkgimJYvZtatJzyea9
 +AjCXP446B6OUtOaylIKMpkBHx5cHUnQ4QbOcBGjqK3yRJt5ONWNLUcCiShyXDeFKDc6sE9a88W
 a8tHYyYL4247tJNsuFaa5riH0xhm63vR9JRqkr4kGaTfkjBC/ZJf1enEHb4Psos+WL47j5fPk7o
 FPFZsdJdxLklLJ65piEQWMLVuVOEq0p+iytY313sIEbZOJ5G8n/pdLtqQ3jfUzDHIVXon2ivnvI
 y8WsbDTGMXAoWHSQZ15vqkXRDnSWNBncubnFCUtd1u+I0V/hOPPIQwcE0wXGilyccq3T3z8=
X-Google-Smtp-Source: AGHT+IET3rCUD4K9dqPQx++qfnQF/Fz4Nk/DTwjGuVg0qDLE2Ix7GC7Fml/wOU+FIGpne+q1aZ2b+w==
X-Received: by 2002:a05:6000:41da:b0:3a5:2653:7308 with SMTP id
 ffacd0b85a97d-3a6ed6750a3mr1941338f8f.57.1750857695787; 
 Wed, 25 Jun 2025 06:21:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/13] lwip: ping: accept host name when CONFIG_CMD_DNS=y
Date: Wed, 25 Jun 2025 15:19:17 +0200
Message-ID: <20250625132108.3292932-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Update the ping command so that a host name is accepted in addition to
an IP address, provided DNS support is enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 21a30228642..51e37111ca9 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -14,7 +14,7 @@
 #include <time.h>
 
 U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
-	   "pingAddress");
+	   "pingAddressOrHostName");
 
 #define PING_DELAY_MS 1000
 #define PING_COUNT 5
@@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	if (!ipaddr_aton(argv[1], &addr))
+	if (net_lwip_dns_resolve(argv[1], &addr))
 		return CMD_RET_USAGE;
 
 restart:
-- 
2.43.0

