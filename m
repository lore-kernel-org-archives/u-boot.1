Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E60BCEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9CB83E57;
	Tue, 18 Nov 2025 19:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VkRk6ouC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0A083E69; Tue, 18 Nov 2025 19:03:59 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 300DC83E81
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e41b6469f5so2486380fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489036; x=1764093836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UsJO4knUSX8fBd9DlhWxUU+b/FmPo2HQTYSeYzR41Wg=;
 b=VkRk6ouC3dDLMaonW5xyycTVY9U+bR7OqijcfYoAPIKmIIqDE8hw1XTWsZyBoSctWL
 3Iat4W5sQ3N53Ew5a0gqDtwNp5L2IVu/tXnH0aBkgy9li0jSWnoPijRPVBhdwNfSxk9N
 O/+DCCGuNpWLQllA0KP8PKDsvlJZu07xHVN/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489036; x=1764093836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsJO4knUSX8fBd9DlhWxUU+b/FmPo2HQTYSeYzR41Wg=;
 b=GEbrjv8ecNdqVYbX6qib+SN0ayqSgNxCoDpFHZTC1WLgzNxMeX0jZQQaQGdvW9cgqn
 wHcMR3sW5rbrozzmIfw375k5xGQ55cS16hvKrXhs8Th+36LIF6s1c4KPg2GOqnf3QEPw
 PYxL7u2vwSyaIMz1RPdZ63G+i2HLl2Sl3mXio2t03kNGdoXzH5YRvnnmEoGRykw8xf3h
 4+RVW14gRlZN6d4hszGTaLgzWYlVyViNEuR0Zvr5qddbZold0HwI1Y9hjeWPPMYXmjzi
 2tYO62a8QYH6yGHekogjX+WAk3WdWjCMJu1p2vaClF3B3UH6+rE9bqhjxMtI6T0fuF2y
 TlOw==
X-Gm-Message-State: AOJu0Yzgu+BQO6GePbBZmNUtZQBKV6tECY7gDhPcFcyO8clJkS0Nx1sG
 Pu+OeV1wEN7eIyjpEMQJf3NeWrLoTyRUjuLrcPCcc2CKuuYFucXI6bXP+Y0k4dkRMg7Uaqi8kQH
 xe1WIj55R1A==
X-Gm-Gg: ASbGncsrXGWVNiuX33FghMqwJgp5GedvkVVYj5D8Xw15PUzaOUinz3YsFeXP8Pyii6C
 j0p2mNfmeS24wyTvUF1K+k4zBS0H8V6iPD8ne5OyhE7lI4PAljx6mOmikeTok9NwtXmsxJc9vh3
 Qx7Cm6QrWFonq3DCES1wQ5YIc4SMSxInOJ2DXQdl4Utpwj1OpKw/Fz9TjYNnKV3Yjx2oKx9JRYm
 i5NQGcw8A8iBZBRxL6D+xtkzse216RMf/IgLMZ0HA+Z0w43tkMbBZbibZnuwbMo7I66nNNWxIxZ
 zv7et7Amc80oRKvUS0ukDagoXjXA5AmQlPbqEFHE1gZT41oorqiUcaDx6SG8luvjuLrKXkaHJR2
 i1mL4BUyTlTDZrAu2A6bzV69Jc4c1elt4Lh0XIu2zTPHPrk5GGUv+86RaeTn6eyUci97ikAArly
 fSt9dedZn8m+o0sj0qa6yDowH+36ofh4zOiWAluBHQBVaxGjENLurc4a7QjKzSPsb7rxxHV3cUH
 A==
X-Google-Smtp-Source: AGHT+IHy+jim+Mdge7j+tHIkJImSdzcwiU9Xt8Mxw5gkco7bKMv5+0dr1Ltj05hwFPICsFDjcO4sFA==
X-Received: by 2002:a05:6870:b018:b0:3ec:3c21:9301 with SMTP id
 586e51a60fabf-3ec3c21adebmr4273980fac.9.1763489035883; 
 Tue, 18 Nov 2025 10:03:55 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851d64d3dsm7310805fac.0.2025.11.18.10.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Parthiban Nallathambi <parthitce@gmail.com>
Subject: [PATCH] dart_6ul: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:54 -0600
Message-ID: <20251118180354.591001-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Parthiban Nallathambi <parthitce@gmail.com>
---
 include/configs/dart_6ul.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/dart_6ul.h b/include/configs/dart_6ul.h
index 2b329b4065c3..7c4c869f771b 100644
--- a/include/configs/dart_6ul.h
+++ b/include/configs/dart_6ul.h
@@ -65,7 +65,6 @@
 
 /* Default environment */
 #define CFG_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffff\0" \
 	"console=ttymxc0,115200n8\0" \
 	"addcon=setenv bootargs ${bootargs} console=${console},${baudrate}\0" \
 	"fit_addr=0x82000000\0" \
-- 
2.43.0

