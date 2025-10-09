Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A37CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 22:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40C5841B1;
	Fri, 10 Oct 2025 00:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lw26j1DD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71F5841B8; Fri, 10 Oct 2025 00:23:58 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A6683C62
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 00:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-63f03676bdcso411244eaf.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760048635; x=1760653435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5RoiXpDduPrRA2xFUoGTKsoM/hWLjwhymJCtXsAwdj4=;
 b=Lw26j1DD0Le+rZXgx7mLMpRPVki7/iiI0ubv8QWuPn5wJvYs0aVTu1QZkmCkxWbqTQ
 65lz310SGYrphpAovNTM7AsmWVRdwmb/MDKffAm9S3ZEcSkMKx7/35ABqc4MbnnCLmfU
 gP2dFji4FLl25BjCOz8AC2NEIop1nLhdq8RCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048635; x=1760653435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RoiXpDduPrRA2xFUoGTKsoM/hWLjwhymJCtXsAwdj4=;
 b=saQpBFvpoRdKI278jZldQhny2I7Lct5QiAVDZED0Z+j6AdLYApbYgzc1jwXN27flQp
 GkqF0VqM5qU6irz/E68yQmp4zW7wjWQiCsSclTHt+ahOrPl3MfxwY+wHYFAHNeNN+BTI
 dNhEmFgV7JbiiAVLPamIpHVaco5CMKjIeXFhWiywGHPWKu5tagxHarnViMJRrQDG4Bls
 qM78Nuw0845wIVqb/F3wKlp1H+L15RCx/IEzRsUAp7l8LpqI0Lpwbpfq0VaP108uHC9O
 VGQlduGzTJG/7hN087XFxvU13TdNptyz8RtHi6ETvz8kjAK5GBoIbBrBi4SN83GPy8/Q
 hOtw==
X-Gm-Message-State: AOJu0YyAPl309bU1JGJedVYXfzE9520O9wCtDkcxK5MeRzp7atT8N8O9
 qk1xJI3U45Ro6XxJBobMOJNom3bueo8Ar23EOLWmx5j8qQ6iOiv2nL3CbIhCq8Q/ou7xL7dlj+e
 T93HbNsg=
X-Gm-Gg: ASbGncuBa9lDqq5vJr/dw4E9eY8+c2GDX55XwDMqGehiYxZTgFF09tOpb2MHxQz6HMv
 kEvOrMaTaV8sGAh0PJU26ra1BIHwWVYD76kHghKVo+Im1ganoV2ZYsCcjeet4I+V1IEF6TS3qS2
 Niz2DN7Teywk0NF8RdtRUqz8FNzxRwB0uWYDkAlogwI8TwQCrK1S2qK2Ov/pKlYf8I7VIZLWa7o
 T3GXh+HjyfeA1S0lPZx1ej3CMfijGvfOdm9OcqFkhyvppxikeWqxbts+SZi1icurs9sRynFeLxd
 wIgYMfnhxreOdcsesDTbPspXrYfzFakQ9BCy15jMDgdEX03xMaVIhH9xC3ArX85sSqYfZuy7JV+
 SNAHY4RoAZzJh66rBUbQqAYAHNo22v0edeR1CCKyvYp0YW0N4rDa2c1d+q0liA1NE1weA5E1hr/
 nqZlySQ30mn8TF
X-Google-Smtp-Source: AGHT+IEnhT3jISW6WyOn3E8JwQu4sEUTrY39uEEzTlDBh+/IxyKCzks/tl7qku8HwisDUdc9pkbVCw==
X-Received: by 2002:a05:6870:17a1:b0:321:fcf1:e845 with SMTP id
 586e51a60fabf-3c0f63f0f60mr4033547fac.19.1760048635349; 
 Thu, 09 Oct 2025 15:23:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8bb1408sm302067fac.11.2025.10.09.15.23.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 15:23:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH] labgrid-trini: Fix logic in sd-mux flash
 wrapper
Date: Thu,  9 Oct 2025 16:23:53 -0600
Message-ID: <20251009222353.1010313-1-trini@konsulko.com>
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

We need to pass the normal first/second argument to the raw writer from
the labgrid wrapper that controls access to the sd-mux.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/flash.labgrid-trini.sd-mux | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/flash.labgrid-trini.sd-mux b/bin/flash.labgrid-trini.sd-mux
index a9648dc1dadc..dd3f55568f6e 100644
--- a/bin/flash.labgrid-trini.sd-mux
+++ b/bin/flash.labgrid-trini.sd-mux
@@ -25,7 +25,7 @@ echo "switching sd-mux to host"
 labgrid-client sd-mux host
 #let mmc have some time to initialize to be available for udisks
 sleep 1
-. writer.${flash_writer}
+. writer.${flash_writer} ${raw_device} ${U_BOOT_BUILD_DIR}
 
 echo "switching sd-mux to dut"
 labgrid-client sd-mux dut
-- 
2.43.0

