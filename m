Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D615CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC4E83622;
	Wed,  1 Oct 2025 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qR6tZbzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A82A83653; Wed,  1 Oct 2025 22:30:46 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A98183622
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-394587df7c4so224985fac.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350643; x=1759955443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LH1WKr5Rhdk2WipJwNcI3QIP17PrdHzmW64uaIFgGHg=;
 b=qR6tZbzugpDUJGwOztQMq1cNOEswFfyyAntkS1K84kfgDGYGNQijj9ZWa1xh3zqp6g
 Bd9e0s7B+AR2XG24/Zfqzepq9FJtErySG6WFB2sDHiLLsXP23CvpYAev6D9drL0MF8gU
 atpgdXSl8qIxnKO6kQNOK6FgLgqZhtC8Ige3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350643; x=1759955443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LH1WKr5Rhdk2WipJwNcI3QIP17PrdHzmW64uaIFgGHg=;
 b=GH0SB3LOX0TgMbtaDFWQtwRr/3EcQYYAABjTUDPNuZeRpiC7nD453z7sE3WYUY27qR
 kjNjdLWja3wWRJmVrGchLJWQql+4Px3B0MctCdnPonsAuTWiHO4KSIm5W6HLYHNLwvOb
 /fI8aCt+1SkR/0yEAgiM2hbHHiRLimXxNUG37ztELSgx3vDC9dXtO3NTt3mtPcYnD+LU
 r/2iSb5tQGN7t8iIEkp9sJ/KX3viXyFm2/fggiPTXjqdIXHpWb1ps2KCQrqiKwJlEmZr
 Qr01lg0qt+Pk7UOrP1kR/J518dk803wxFMtLrG6Bdrq/2c1UhMnpNJEUOEx+sV4c90a8
 mDwg==
X-Gm-Message-State: AOJu0YxVB/IzmWaRuV+lYiNgzYTI45ZvczVR95iz120pyio3vZtJiVjH
 REsJ/IptnEs0ut4S6QdgGd29DMv/CjVYC2V3Q4F5XbMtIkgF2mv+7tbMI3TK56vmjWGoLSXiUlz
 FjvXLumg=
X-Gm-Gg: ASbGncvTJqxEqKTby/m4j1i4LJSyhppUEs7P/cGFiLtESVB/WZSCCjzP/HzQTx/nJQs
 VR19ym5JGME9BOANF7oHbTUiCn/yqf3ygIdqZZTR61ABno5gJlL/RCZ8qZitz7tSFzb9vZY8Duz
 b6PIirOqE17M5IB0lf7hJXl5w05xj1eAh9YENjTZU8He/3VYh3aux+u0STS9CdiriMwQNQjjhT2
 AN7AHWSppZOVg/uNRsRUpe6mB3U6jLyDPbomEDHjCX/nxvH3qq9FML0imkZpPJ+SDvDUmPUIYPe
 3Zy+0Ld0sn8sZHmk2ZAKCoClax9FhYowMr0BP+4deabH1fkyWu4C1w7szbr9y15IxrkN9h09ypl
 qrk1pTJ87+pRCsqY4nuHLAut0vYRX3i0zrk8nYKmeo7py31c0VstBoJWYZT+vJUpRBWgwRqekov
 Ik4U4NJzU=
X-Google-Smtp-Source: AGHT+IG+L6Lz8NZgb8qIZRkqGPvEZa3gnZjkRR+M59y0V0nKB4qzKt1gpasNz2waIKu/PsTafattsw==
X-Received: by 2002:a05:6870:82ab:b0:35b:67e2:79b0 with SMTP id
 586e51a60fabf-39bb5ed83f2mr2876458fac.32.1759350642845; 
 Wed, 01 Oct 2025 13:30:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab94d984e4sm214045fac.26.2025.10.01.13.30.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mmc: Fix a potential warning in xPL
Date: Wed,  1 Oct 2025 14:30:41 -0600
Message-ID: <20251001203041.2828356-1-trini@konsulko.com>
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

When xPL_MMC_WRITE is set but also xPL_MMC_TINY is set, the function
sd_read_ssr may be unused. Guard it appropriately.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index b1cfa3cd7c22..ec61ed92e865 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1546,7 +1546,7 @@ static int sd_select_bus_width(struct mmc *mmc, int w)
 }
 #endif
 
-#if CONFIG_IS_ENABLED(MMC_WRITE)
+#if CONFIG_IS_ENABLED(MMC_WRITE) && !CONFIG_IS_ENABLED(MMC_TINY)
 static int sd_read_ssr(struct mmc *mmc)
 {
 	static const unsigned int sd_au_size[] = {
-- 
2.43.0

