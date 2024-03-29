Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC67DC6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 14:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B5B88204;
	Fri, 29 Mar 2024 15:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMWDq/MZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5AA388213; Fri, 29 Mar 2024 15:22:20 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB4087BE0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 15:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d52e65d4a8so27208521fa.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711722138; x=1712326938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dHN6PD4Q2dJRvHoJ1xiSbDNQRvnOlSyzNv616IPt9NQ=;
 b=dMWDq/MZTMiJ/gKgT8gklpvB1Qs8l/4ewlJThcGOj/cHrbX4GPLnRedfNitIfX1Afa
 qpMlI1Byw99i5+6wc3rxnLp/wMMxytHtS7uMNOlIPtlqfLX/Y9wIsg3f4HHrEitNHrlP
 jRwPN8GNX7UFIxqQ0MVr6tMgwN2Zz8FUv64biA67uR878+udw2WhgLTiy8k3Fk9fXEPW
 lDgiudA0Od9eMbKLoWf7BhOcViXnIN1IzifdGzwszdIhS18BFCkqhNon+k4dXhDgALQM
 jn6vF+M5UjwbkJyA0TIH84wUpN/+cfxBPLQvUSNuWIoLfVZTTsrOGUVJ5mrP4kkEotuI
 VA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711722138; x=1712326938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHN6PD4Q2dJRvHoJ1xiSbDNQRvnOlSyzNv616IPt9NQ=;
 b=vECi8OlH+dB1VxIWL209M082lF8uV5ejqmp8aPvqVo+DWKkPvim0Bu9r0KRUEGPT8i
 Pum7wQJBeheuKhkeq0Y/CixbaRuDRdVHNIoclFLlvSyZFYBciZqK/z52gfHBcV/FBa/K
 MuFDH9f3Dc6tAoz4QPeK6hwaQexZQsHj9nivqHKIUluCBpUGyuNlKmBxI9qrTQ+oBgXQ
 nKFOQ/tL0jH0X4AWaXTg9ln/Xo5xWYUpte4buwIaUFNflYIOHktN3hQklfiOuHdeG5MU
 2E9iVbCpRrFc3Rhe1zqF4A+qJdj6x+eO+G8cdCwqqGbJ3NHX+zdnlMIAY6CqXUCN1O8D
 gSWQ==
X-Gm-Message-State: AOJu0YwiPhPxKKXk66Hg1ATV6+UK3Nd3GSdD2f8r2Cu91XgzDKLT8bcB
 cSpSKEsKoyC05+rZWzJ2MI8PQ/xakOcfrKtMkSkaaUs04mEQ/rMSD9Gi4TzQ
X-Google-Smtp-Source: AGHT+IGxP7gWW4AGN2gj2Ib8WpE5nPSE9y9wYGCuXW5JMbqSkQJBWU3PLOMMYQL2VSiZN0tknCanjQ==
X-Received: by 2002:a2e:b604:0:b0:2d4:92d8:920f with SMTP id
 r4-20020a2eb604000000b002d492d8920fmr1459970ljn.33.1711722137770; 
 Fri, 29 Mar 2024 07:22:17 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:42cc:783c:8292:d36c:ba1b:6b9])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a2eba08000000b002d6c88b9addsm631823lja.50.2024.03.29.07.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 07:22:17 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] lib: fix newline in debug message
Date: Fri, 29 Mar 2024 17:22:14 +0300
Message-Id: <20240329142214.53895-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 lib/rsa/rsa-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 1007b6979a..e1093ce1a4 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -342,7 +342,7 @@ static int rsa_verify_key(struct image_sign_info *info,
 		return -EINVAL;
 	}
 
-	debug("Checksum algorithm: %s", checksum->name);
+	debug("Checksum algorithm: %s\n", checksum->name);
 
 	/* Sanity check for stack size */
 	if (sig_len > RSA_MAX_SIG_BITS / 8) {
-- 
2.39.2

